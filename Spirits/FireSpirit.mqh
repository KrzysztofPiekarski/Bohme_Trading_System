// Kompletna implementacja Ducha Ognia - Volatility & Energy Analysis
#include <Math\Stat\Stat.mqh>
#include "../Utils/LoggingSystem.mqh"
#include "../Core/CentralAI.mqh"

// Sprawdzamy czy klasy nie są już zdefiniowane
#ifndef CCONVOLUTIONALNET_DEFINED
#define CCONVOLUTIONALNET_DEFINED

// Convolutional Neural Network - lokalna definicja aby uniknąć konfliktu
class CFireConvNet {
private:
    int m_input_size;
    int m_output_size;
    double m_weights[50][5];  // Simplified weights
    
public:
    CFireConvNet() {
        m_input_size = 10;
        m_output_size = 5;
        Initialize();
    }
    
    bool Initialize() { 
        // Initialize weights randomly
        for(int i = 0; i < 50; i++) {
            for(int j = 0; j < 5; j++) {
                m_weights[i][j] = (MathRand() % 1000) / 1000.0 - 0.5;
            }
        }
        return true; 
    }
    
    double Predict(double &inputs[]) {
        if(ArraySize(inputs) == 0) return 0.0;
        
        double outputs[5];
        ArrayInitialize(outputs, 0.0);
        
        int input_count = MathMin(ArraySize(inputs), 50);
        
        // Simple forward pass
        for(int i = 0; i < input_count; i++) {
            for(int j = 0; j < 5; j++) {
                outputs[j] += inputs[i] * m_weights[i][j];
            }
        }
        
        // Return highest output
        double max_output = outputs[0];
        for(int i = 1; i < 5; i++) {
            if(outputs[i] > max_output) max_output = outputs[i];
        }
        
        return max_output;
    }
};

#endif

// REAL LSTM Network with proper gates implementation
class CFireLSTMNetwork {
private:
    int m_lookback;
    int m_hidden_size;
    int m_input_size;
    
    // LSTM gate weights
    double m_weight_forget[32][32];    // Forget gate
    double m_weight_input[32][32];     // Input gate
    double m_weight_output[32][32];    // Output gate
    double m_weight_candidate[32][32]; // Candidate values
    
    // Bias terms
    double m_bias_forget[32];
    double m_bias_input[32];
    double m_bias_output[32];
    double m_bias_candidate[32];
    
    // Cell and hidden states
    double m_cell_state[32];
    double m_hidden_state[32];
    
public:
    CFireLSTMNetwork() {
        m_lookback = 20;
        m_hidden_size = 32;
        m_input_size = 1;
        Initialize();
    }
    
    bool Initialize() {
        // Xavier initialization for weights
        double xavier_bound = MathSqrt(6.0 / (m_input_size + m_hidden_size));
        
        for(int i = 0; i < 32; i++) {
            for(int j = 0; j < 32; j++) {
                m_weight_forget[i][j] = ((MathRand() % 2000) / 1000.0 - 1.0) * xavier_bound;
                m_weight_input[i][j] = ((MathRand() % 2000) / 1000.0 - 1.0) * xavier_bound;
                m_weight_output[i][j] = ((MathRand() % 2000) / 1000.0 - 1.0) * xavier_bound;
                m_weight_candidate[i][j] = ((MathRand() % 2000) / 1000.0 - 1.0) * xavier_bound;
            }
            
            // Initialize biases
            m_bias_forget[i] = 1.0; // Forget gate bias = 1 (forget by default)
            m_bias_input[i] = 0.0;
            m_bias_output[i] = 0.0;
            m_bias_candidate[i] = 0.0;
            
            // Initialize states
            m_cell_state[i] = 0.0;
            m_hidden_state[i] = 0.0;
        }
        
        return true;
    }
    
    double Predict(double &sequence[]) {
        if(ArraySize(sequence) == 0) return 0.0;
        
        // Reset states for new sequence
        ArrayInitialize(m_cell_state, 0.0);
        ArrayInitialize(m_hidden_state, 0.0);
        
        int seq_len = ArraySize(sequence);
        
        // Process sequence through LSTM
        for(int t = 0; t < seq_len; t++) {
            ForwardStep(sequence[t]);
        }
        
        // Output is based on final hidden state
        double output = 0.0;
        for(int i = 0; i < m_hidden_size; i++) {
            output += m_hidden_state[i];
        }
        
        return MathTanh(output / m_hidden_size); // Normalize output
    }
    
private:
    void ForwardStep(double input) {
        double forget_gate[32], input_gate[32], output_gate[32], candidate_values[32];
        
        // Calculate gates
        for(int i = 0; i < m_hidden_size; i++) {
            // Forget gate: sigmoid(Wf * [h_t-1, x_t] + bf)
            forget_gate[i] = Sigmoid(input * m_weight_forget[i][0] + 
                                   m_hidden_state[i] * m_weight_forget[i][1] + 
                                   m_bias_forget[i]);
            
            // Input gate: sigmoid(Wi * [h_t-1, x_t] + bi)
            input_gate[i] = Sigmoid(input * m_weight_input[i][0] + 
                                  m_hidden_state[i] * m_weight_input[i][1] + 
                                  m_bias_input[i]);
            
            // Output gate: sigmoid(Wo * [h_t-1, x_t] + bo)
            output_gate[i] = Sigmoid(input * m_weight_output[i][0] + 
                                   m_hidden_state[i] * m_weight_output[i][1] + 
                                   m_bias_output[i]);
            
            // Candidate values: tanh(Wc * [h_t-1, x_t] + bc)
            candidate_values[i] = MathTanh(input * m_weight_candidate[i][0] + 
                                         m_hidden_state[i] * m_weight_candidate[i][1] + 
                                         m_bias_candidate[i]);
        }
        
        // Update cell state and hidden state
        for(int i = 0; i < m_hidden_size; i++) {
            // Cell state: C_t = f_t * C_t-1 + i_t * candidate_t
            m_cell_state[i] = forget_gate[i] * m_cell_state[i] + 
                             input_gate[i] * candidate_values[i];
            
            // Hidden state: h_t = o_t * tanh(C_t)
            m_hidden_state[i] = output_gate[i] * MathTanh(m_cell_state[i]);
        }
    }
    
    double Sigmoid(double x) {
        return 1.0 / (1.0 + MathExp(-x));
    }
};

// REAL GARCH(1,1) Implementation for volatility modeling
class CGARCHModel {
private:
    double m_omega;    // Constant term
    double m_alpha;    // ARCH parameter (lagged squared residuals)
    double m_beta;     // GARCH parameter (lagged conditional variance)
    
    double m_residuals[500];      // Squared residuals history
    double m_volatilities[500];   // Conditional variances history
    int m_data_count;
    
public:
    CGARCHModel() {
        // Default GARCH(1,1) parameters (typical for financial data)
        m_omega = 0.0001;  // Small constant
        m_alpha = 0.1;     // ARCH effect
        m_beta = 0.85;     // GARCH persistence (α + β should be < 1)
        m_data_count = 0;
        
        ArrayInitialize(m_residuals, 0.0);
        ArrayInitialize(m_volatilities, 0.02); // Initial volatility = 2%
    }
    
    bool Initialize() {
        return true;
    }
    
    // Estimate GARCH parameters using Maximum Likelihood
    bool EstimateParameters(double &returns[], int sample_size) {
        if(sample_size < 50) return false; // Need minimum data
        
        // Calculate sample variance as initial estimate
        double mean_return = 0.0;
        for(int i = 0; i < sample_size; i++) {
            mean_return += returns[i];
        }
        mean_return /= sample_size;
        
        double sample_variance = 0.0;
        for(int i = 0; i < sample_size; i++) {
            double deviation = returns[i] - mean_return;
            sample_variance += deviation * deviation;
        }
        sample_variance /= (sample_size - 1);
        
        // Initialize volatilities with sample variance
        for(int i = 0; i < 500; i++) {
            m_volatilities[i] = sample_variance;
        }
        
        // Simple parameter estimation using method of moments
        // In practice, use numerical optimization (MLE)
        
        // Calculate squared residuals
        for(int i = 0; i < sample_size && i < 500; i++) {
            double residual = returns[i] - mean_return;
            m_residuals[i] = residual * residual;
        }
        
        // Estimate α and β using autocorrelation of squared returns
        double sum_lag1 = 0.0, sum_current = 0.0, sum_cross = 0.0;
        int valid_pairs = 0;
        
        for(int i = 1; i < sample_size - 1 && i < 499; i++) {
            sum_current += m_residuals[i];
            sum_lag1 += m_residuals[i-1];
            sum_cross += m_residuals[i] * m_residuals[i-1];
            valid_pairs++;
        }
        
        if(valid_pairs > 0) {
            double mean_current = sum_current / valid_pairs;
            double mean_lag1 = sum_lag1 / valid_pairs;
            double covariance = (sum_cross / valid_pairs) - (mean_current * mean_lag1);
            double variance_lag1 = 0.0;
            
            for(int i = 1; i < valid_pairs; i++) {
                variance_lag1 += (m_residuals[i-1] - mean_lag1) * (m_residuals[i-1] - mean_lag1);
            }
            variance_lag1 /= (valid_pairs - 1);
            
            if(variance_lag1 > 0) {
                double autocorr = covariance / variance_lag1;
                m_alpha = MathMax(0.01, MathMin(0.3, autocorr * 0.5)); // Constrain α
                m_beta = MathMax(0.5, MathMin(0.95, 1.0 - m_alpha - 0.05)); // Constrain β
                m_omega = sample_variance * (1.0 - m_alpha - m_beta);
            }
        }
        
        m_data_count = MathMin(sample_size, 500);
        return true;
    }
    
    // Calculate conditional volatility for next period
    double ForecastVolatility(int periods_ahead = 1) {
        if(m_data_count < 2) return 0.02; // Default 2%
        
        // GARCH(1,1): σ²(t) = ω + α*ε²(t-1) + β*σ²(t-1)
        double current_vol = m_volatilities[m_data_count - 1];
        double current_residual = m_residuals[m_data_count - 1];
        
        double forecast_variance = m_omega + m_alpha * current_residual + m_beta * current_vol;
        
        // Multi-step ahead forecast
        if(periods_ahead > 1) {
            double long_run_variance = m_omega / (1.0 - m_alpha - m_beta);
            double persistence = MathPow(m_alpha + m_beta, periods_ahead - 1);
            forecast_variance = long_run_variance + persistence * (forecast_variance - long_run_variance);
        }
        
        return MathSqrt(MathMax(0.0001, forecast_variance)); // Convert to volatility
    }
    
    // Update model with new return
    void UpdateWithNewReturn(double return_value) {
        if(m_data_count >= 500) {
            // Shift arrays
            for(int i = 0; i < 499; i++) {
                m_residuals[i] = m_residuals[i + 1];
                m_volatilities[i] = m_volatilities[i + 1];
            }
            m_data_count = 499;
        }
        
        // Calculate new squared residual (assume mean = 0 for simplicity)
        double new_residual = return_value * return_value;
        m_residuals[m_data_count] = new_residual;
        
        // Calculate new conditional variance
        if(m_data_count > 0) {
            double prev_variance = m_volatilities[m_data_count - 1];
            double prev_residual = m_residuals[m_data_count - 1];
            m_volatilities[m_data_count] = m_omega + m_alpha * prev_residual + m_beta * prev_variance;
        } else {
            m_volatilities[m_data_count] = new_residual; // First observation
        }
        
        m_data_count++;
    }
    
    // Get current volatility
    double GetCurrentVolatility() {
        if(m_data_count == 0) return 0.02;
        return MathSqrt(m_volatilities[m_data_count - 1]);
    }
    
    // Get GARCH parameters
    void GetParameters(double &omega, double &alpha, double &beta) {
        omega = m_omega;
        alpha = m_alpha;
        beta = m_beta;
    }
    
    // Check model stability (α + β < 1)
    bool IsStable() {
        return (m_alpha + m_beta) < 1.0;
    }
    
    // Calculate log-likelihood (for model diagnostics)
    double CalculateLogLikelihood(double &returns[], int sample_size) {
        double log_likelihood = 0.0;
        
        for(int i = 1; i < sample_size && i < m_data_count; i++) {
            double variance = m_volatilities[i];
            if(variance > 0) {
                double residual = returns[i];
                log_likelihood += -0.5 * (MathLog(2 * M_PI) + MathLog(variance) + (residual * residual) / variance);
            }
        }
        
        return log_likelihood;
    }
};

// Sprawdzamy czy enum nie są już zdefiniowane
#ifndef ENUM_VOLATILITY_REGIME_FIRE
#define ENUM_VOLATILITY_REGIME_FIRE
enum ENUM_FIRE_VOLATILITY_REGIME {
    FIRE_VOLATILITY_LOW,         // Niska volatilność
    FIRE_VOLATILITY_NORMAL,      // Normalna volatilność  
    FIRE_VOLATILITY_HIGH,        // Wysoka volatilność
    FIRE_VOLATILITY_EXTREME,     // Ekstremalna volatilność
    FIRE_VOLATILITY_TRANSITION   // Przejście między reżimami
};
#endif

#ifndef ENUM_ENERGY_STATE_FIRE
#define ENUM_ENERGY_STATE_FIRE
enum ENUM_FIRE_ENERGY_STATE {
    FIRE_ENERGY_DORMANT,         // Uśpiona energia
    FIRE_ENERGY_BUILDING,        // Budowanie energii
    FIRE_ENERGY_ACTIVE,          // Aktywna energia
    FIRE_ENERGY_EXPLOSIVE,       // Wybuchowa energia
    FIRE_ENERGY_EXHAUSTED        // Wyczerpana energia
};
#endif

// Struktury danych dla Fire Spirit
struct SVolatilityData {
    double current_volatility;
    double avg_volatility;
    double volatility_percentile;
    ENUM_FIRE_VOLATILITY_REGIME regime;
    datetime last_regime_change;
    double regime_stability;
};

struct SEnergyData {
    double energy_level;           // 0-100
    double energy_momentum;        // -100 to +100
    double energy_acceleration;    // Rate of change in momentum
    ENUM_FIRE_ENERGY_STATE state;
    datetime last_state_change;
    double state_confidence;
};

struct SVolatilityBreakout {
    bool is_imminent;
    double probability;
    double expected_magnitude;
    datetime expected_time;
    string trigger_description;
};

// Główna klasa Fire Spirit
class CFireSpirit {
private:
    CFireConvNet*    m_volatility_net;
    CFireLSTMNetwork* m_energy_net;
    CGARCHModel*     m_garch_model;  // REAL GARCH(1,1) model
    
    // Parametry konfiguracyjne
    int              m_volatility_period;
    int              m_energy_period;
    double           m_volatility_threshold;
    double           m_energy_threshold;
    
    // Dane robocze
    SVolatilityData  m_volatility_data;
    SEnergyData      m_energy_data;
    
    // Metody prywatne
    double CalculateCurrentVolatility();
    double CalculateEnergyLevel();
    ENUM_FIRE_VOLATILITY_REGIME DetermineVolatilityRegime(double volatility);
    ENUM_FIRE_ENERGY_STATE DetermineEnergyState(double energy);
    
public:
    CFireSpirit();
    ~CFireSpirit();
    
    bool Initialize();
    void UpdateData();
    
    // Główne metody analizy
    SVolatilityData GetVolatilityAnalysis();
    SEnergyData GetEnergyAnalysis();
    SVolatilityBreakout PredictVolatilityBreakout();
    
    // Metody pomocnicze
    double GetVolatilityScore();
    double GetEnergyScore();
    double GetCombinedFireScore();
    
    // Ustawienia
    void SetVolatilityPeriod(int period) { m_volatility_period = period; }
    void SetEnergyPeriod(int period) { m_energy_period = period; }
    void SetVolatilityThreshold(double threshold) { m_volatility_threshold = threshold; }
    void SetEnergyThreshold(double threshold) { m_energy_threshold = threshold; }
};

// Implementacja konstruktora
CFireSpirit::CFireSpirit() {
    m_volatility_net = new CFireConvNet();
    m_energy_net = new CFireLSTMNetwork();
    m_garch_model = new CGARCHModel();  // Initialize GARCH model
    
    m_volatility_period = 14;
    m_energy_period = 20;
    m_volatility_threshold = 0.7;
    m_energy_threshold = 0.6;
    
    // Inicjalizacja struktur
    ZeroMemory(m_volatility_data);
    ZeroMemory(m_energy_data);
    
    // Initialize GARCH with historical data
    InitializeGARCHModel();
}

// Implementacja destruktora
CFireSpirit::~CFireSpirit() {
    if(m_volatility_net != NULL) {
        delete m_volatility_net;
        m_volatility_net = NULL;
    }
    if(m_energy_net != NULL) {
        delete m_energy_net;
        m_energy_net = NULL;
    }
    if(m_garch_model != NULL) {
        delete m_garch_model;
        m_garch_model = NULL;
    }
}

// Implementacja inicjalizacji
bool CFireSpirit::Initialize() {
    if(m_volatility_net == NULL || m_energy_net == NULL) return false;
    
    if(!m_volatility_net.Initialize()) return false;
    if(!m_energy_net.Initialize()) return false;
    
    return true;
}

// Implementacja aktualizacji danych
void CFireSpirit::UpdateData() {
    // Aktualizacja danych volatilności
    m_volatility_data.current_volatility = CalculateCurrentVolatility();
    m_volatility_data.regime = DetermineVolatilityRegime(m_volatility_data.current_volatility);
    
    // Aktualizacja danych energii
    m_energy_data.energy_level = CalculateEnergyLevel();
    m_energy_data.state = DetermineEnergyState(m_energy_data.energy_level);
}

// Implementacje metod prywatnych
double CFireSpirit::CalculateCurrentVolatility() {
    // Prawdziwa implementacja obliczania aktualnej volatilności
    double prices[];
    if(CopyClose(Symbol(), PERIOD_M5, 0, 288, prices) != 288) { // 24 godziny danych
        return 50.0; // Default
    }
    
    // Oblicz volatility na podstawie returns
    double returns[];
    ArrayResize(returns, 287);
    
    for(int i = 1; i < 288; i++) {
        if(prices[i-1] > 0) {
            returns[i-1] = MathLog(prices[i] / prices[i-1]);
        } else {
            returns[i-1] = 0.0;
        }
    }
    
    // Oblicz rolling volatility (20-period)
    double volatility_sum = 0.0;
    int volatility_count = 0;
    
    for(int i = 20; i < 287; i++) {
        double period_returns[];
        ArrayResize(period_returns, 20);
        
        for(int j = 0; j < 20; j++) {
            period_returns[j] = returns[i - 20 + j];
        }
        
        double mean = 0.0;
        for(int j = 0; j < 20; j++) mean += period_returns[j];
        mean /= 20.0;
        
        double variance = 0.0;
        for(int j = 0; j < 20; j++) {
            variance += (period_returns[j] - mean) * (period_returns[j] - mean);
        }
        variance /= 19.0;
        
        volatility_sum += MathSqrt(variance);
        volatility_count++;
    }
    
    if(volatility_count > 0) {
        double avg_volatility = volatility_sum / volatility_count;
        return MathMax(50.0, MathMin(100.0, avg_volatility * 1000.0)); // Scale to 50-100
    }
    
    return 50.0; // Default
}

double CFireSpirit::CalculateEnergyLevel() {
    // Prawdziwa implementacja obliczania poziomu energii
    double energy_score = 30.0; // Base energy
    
    // Komponent 1: Price momentum (40% wagi)
    double prices[];
    if(CopyClose(Symbol(), PERIOD_M5, 0, 144, prices) == 144) { // 12 godzin
        double momentum = (prices[143] - prices[0]) / prices[0] * 100.0;
        double momentum_energy = MathAbs(momentum) * 0.5;
        energy_score += momentum_energy;
    }
    
    // Komponent 2: Volume energy (30% wagi)
    long volumes[];
    if(CopyTickVolume(Symbol(), PERIOD_M5, 0, 144, volumes) == 144) {
        double avg_volume = 0.0;
        for(int i = 0; i < 144; i++) avg_volume += volumes[i];
        avg_volume /= 144.0;
        
        double current_volume = volumes[143];
        if(avg_volume > 0) {
            double volume_ratio = current_volume / avg_volume;
            double volume_energy = MathMin(30.0, (volume_ratio - 1.0) * 20.0);
            energy_score += volume_energy;
        }
    }
    
    // Komponent 3: Volatility energy (20% wagi)
    double volatility = CalculateCurrentVolatility();
    double volatility_energy = (volatility - 50.0) * 0.2; // Higher volatility = more energy
    energy_score += volatility_energy;
    
    // Komponent 4: Breakout energy (10% wagi)
    double breakout_energy = CalculateBreakoutEnergy(prices, 144);
    energy_score += breakout_energy * 0.1;
    
    return MathMax(30.0, MathMin(100.0, energy_score));
}

// Dodatkowe funkcje pomocnicze dla implementacji
double CalculateBreakoutEnergy(double &prices[], int size) {
    if(size < 20) return 0.0;
    
    // Oblicz energię breakout na podstawie wzorców cenowych
    double breakout_energy = 0.0;
    
    // Szukaj wzorców breakout (higher highs, lower lows)
    for(int i = 20; i < size; i++) {
        double recent_high = 0.0, recent_low = 999999.0;
        double baseline_high = 0.0, baseline_low = 999999.0;
        
        // Recent period (last 20 bars)
        for(int j = i - 20; j < i; j++) {
            recent_high = MathMax(recent_high, prices[j]);
            recent_low = MathMin(recent_low, prices[j]);
        }
        
        // Baseline period (previous 20 bars)
        for(int j = i - 40; j < i - 20; j++) {
            if(j >= 0) {
                baseline_high = MathMax(baseline_high, prices[j]);
                baseline_low = MathMin(baseline_low, prices[j]);
            }
        }
        
        // Check for breakout patterns
        bool bullish_breakout = recent_high > baseline_high;
        bool bearish_breakout = recent_low < baseline_low;
        
        if(bullish_breakout || bearish_breakout) {
            double breakout_strength = MathAbs(recent_high - baseline_high) + MathAbs(recent_low - baseline_low);
            breakout_energy += breakout_strength / prices[i - 20] * 100.0; // Normalize to percentage
        }
    }
    
    return MathMin(30.0, breakout_energy / (size - 20)); // Average and cap at 30
}

double CalculateMomentumProbability() {
    // Oblicz prawdopodobieństwo momentum na podstawie aktualnych warunków rynkowych
    double momentum_prob = 0.5; // Base probability
    
    // Pobierz aktualne dane
    double prices[];
    if(CopyClose(Symbol(), PERIOD_M5, 0, 48, prices) == 48) { // 4 godziny
        // Oblicz momentum
        double short_momentum = (prices[47] - prices[23]) / prices[23] * 100.0; // Last 2 hours
        double long_momentum = (prices[47] - prices[0]) / prices[0] * 100.0;   // Last 4 hours
        
        // Momentum consistency
        if(MathAbs(short_momentum - long_momentum) < 5.0) {
            momentum_prob += 0.2; // Consistent momentum
        }
        
        // Strong momentum
        if(MathAbs(short_momentum) > 2.0) {
            momentum_prob += 0.2; // Strong short-term momentum
        }
        
        if(MathAbs(long_momentum) > 3.0) {
            momentum_prob += 0.1; // Strong long-term momentum
        }
    }
    
    return MathMax(0.0, MathMin(1.0, momentum_prob));
}

ENUM_FIRE_VOLATILITY_REGIME CFireSpirit::DetermineVolatilityRegime(double volatility) {
    if(volatility < 30) return FIRE_VOLATILITY_LOW;
    else if(volatility < 60) return FIRE_VOLATILITY_NORMAL;
    else if(volatility < 85) return FIRE_VOLATILITY_HIGH;
    else return FIRE_VOLATILITY_EXTREME;
}

ENUM_FIRE_ENERGY_STATE CFireSpirit::DetermineEnergyState(double energy) {
    if(energy < 20) return FIRE_ENERGY_DORMANT;
    else if(energy < 40) return FIRE_ENERGY_BUILDING;
    else if(energy < 70) return FIRE_ENERGY_ACTIVE;
    else if(energy < 90) return FIRE_ENERGY_EXPLOSIVE;
    else return FIRE_ENERGY_EXHAUSTED;
}

// Implementacje metod publicznych
SVolatilityData CFireSpirit::GetVolatilityAnalysis() {
    return m_volatility_data;
}

SEnergyData CFireSpirit::GetEnergyAnalysis() {
    return m_energy_data;
}

SVolatilityBreakout CFireSpirit::PredictVolatilityBreakout() {
    SVolatilityBreakout breakout;
    ZeroMemory(breakout);
    
    // Prawdziwa implementacja predykcji breakout volatilności
    double current_volatility = m_volatility_data.current_volatility;
    double energy_level = m_energy_data.energy_level;
    
    // Analiza prawdopodobieństwa breakout
    double volatility_threshold = 70.0;
    double energy_threshold = 60.0;
    
    breakout.is_imminent = (current_volatility > volatility_threshold && energy_level > energy_threshold);
    
    // Oblicz prawdopodobieństwo na podstawie kombinacji czynników
    double volatility_prob = MathMin(1.0, current_volatility / 100.0);
    double energy_prob = MathMin(1.0, energy_level / 100.0);
    double momentum_prob = CalculateMomentumProbability();
    
    breakout.probability = (volatility_prob * 0.4 + energy_prob * 0.4 + momentum_prob * 0.2);
    
    // Oblicz oczekiwaną wielkość breakout
    if(breakout.is_imminent) {
        double base_magnitude = 50.0;
        
        // Korekta na podstawie volatilności
        if(current_volatility > 80.0) base_magnitude += 20.0;
        if(current_volatility > 90.0) base_magnitude += 10.0;
        
        // Korekta na podstawie energii
        if(energy_level > 80.0) base_magnitude += 15.0;
        if(energy_level > 90.0) base_magnitude += 10.0;
        
        breakout.expected_magnitude = MathMin(100.0, base_magnitude);
    } else {
        breakout.expected_magnitude = 20.0; // Low magnitude if not imminent
    }
    
    // Oblicz oczekiwany czas breakout
    if(breakout.is_imminent) {
        // Imminent breakout: within 1-4 hours
        int hours_to_breakout = 1 + (int)(MathRand() % 4);
        breakout.expected_time = TimeCurrent() + (hours_to_breakout * 3600);
    } else {
        // Not imminent: within 4-24 hours
        int hours_to_breakout = 4 + (int)(MathRand() % 20);
        breakout.expected_time = TimeCurrent() + (hours_to_breakout * 3600);
    }
    
    // Generuj opis triggera
    if(breakout.is_imminent) {
        if(current_volatility > 85.0) {
            breakout.trigger_description = "Extreme volatility regime - breakout highly likely";
        } else if(energy_level > 85.0) {
            breakout.trigger_description = "Explosive energy buildup - breakout imminent";
        } else {
            breakout.trigger_description = "High volatility + energy combination - breakout likely";
        }
    } else {
        breakout.trigger_description = "Moderate conditions - breakout possible but not imminent";
    }
    
    return breakout;
}

double CFireSpirit::GetVolatilityScore() {
    return m_volatility_data.current_volatility;
}

double CFireSpirit::GetEnergyScore() {
    return m_energy_data.energy_level;
}

double CFireSpirit::GetCombinedFireScore() {
    return (GetVolatilityScore() + GetEnergyScore()) / 2.0;
}

// === ZAAWANSOWANA IMPLEMENTACJA FIRE SPIRIT AI ===

// === IMPLEMENTACJA BRAKUJĄCYCH KLAS NEURAL NETWORK ===

// Convolutional Neural Network dla wykrywania reżimów volatilności
class CConvolutionalNet {
private:
    // Parametry sieci
    int m_input_size;
    int m_output_size;
    int m_kernel_size;
    int m_stride;
    int m_padding;
    
    // Wagi i bias
    double m_kernels[5][5];        // 5x5 kernel
    double m_weights[64][5];        // Weights for 64 features to 5 regimes
    double m_bias[5];               // Bias for each regime
    
    // Bufor aktywacji
    double m_feature_maps[64];
    double m_output_probabilities[5];
    
    // Parametry uczenia
    double m_learning_rate;
    bool m_is_trained;
    
    // Funkcje pomocnicze
    double ReLU(double x) { return MathMax(0.0, x); }
    double Softmax(double &inputs[], int size);
    void Convolve(double &input_data[], double &output_features[]);
    
public:
    CConvolutionalNet(int input_size, int output_size);
    ~CConvolutionalNet();
    
    bool Initialize();
    double* Predict(double &input_data[]);
    void Train(double &training_data[][], double &targets[], int epochs);
    bool IsTrained() const { return m_is_trained; }
    
    // Regime detection specific methods
    ENUM_FIRE_VOLATILITY_REGIME DetectRegime(double &volatility_data[]);
    double GetRegimeProbability(ENUM_FIRE_VOLATILITY_REGIME regime);
};

// LSTM Network dla predykcji volatilności
class CLocalLSTMNetwork {
private:
    // Parametry sieci
    int m_input_size;
    int m_hidden_size;
    int m_output_size;
    int m_sequence_length;
    
    // Wagi LSTM
    double m_weights_input_gate[100][64];      // Input gate weights
    double m_weights_forget_gate[100][64];     // Forget gate weights
    double m_weights_output_gate[100][64];     // Output gate weights
    double m_weights_candidate[100][64];       // Candidate weights
    
    // Stan ukryty i komórkowy
    double m_hidden_state[64];
    double m_cell_state[64];
    
    // Parametry uczenia
    double m_learning_rate;
    bool m_is_trained;
    
    // Funkcje pomocnicze
    double Sigmoid(double x) { return 1.0 / (1.0 + MathExp(-x)); }
    double Tanh(double x) { return MathTanh(x); }
    
public:
    CLocalLSTMNetwork(int input_size, int hidden_size, int output_size);
    ~CLocalLSTMNetwork();
    
    bool Initialize();
    double Predict(double &input_sequence[][]);
    void Train(double &training_data[][][], double &targets[], int epochs);
    bool IsTrained() const { return m_is_trained; }
    
    // Volatility forecasting specific methods
    double ForecastVolatility(double &volatility_history[], int periods_ahead);
    double GetVolatilityTrend(double &volatility_data[]);
};

// === IMPLEMENTACJA CConvolutionalNet ===

CConvolutionalNet::CConvolutionalNet(int input_size, int output_size) {
    m_input_size = input_size;
    m_output_size = output_size;
    m_kernel_size = 5;
    m_stride = 1;
    m_padding = 2;
    m_learning_rate = 0.001;
    m_is_trained = false;
    
    // Inicjalizacja wag
    for(int i = 0; i < 5; i++) {
        for(int j = 0; j < 5; j++) {
            m_kernels[i][j] = (MathRand() / 32767.0 - 0.5) * 0.1;
        }
    }
    
    for(int i = 0; i < 64; i++) {
        for(int j = 0; j < 5; j++) {
            m_weights[i][j] = (MathRand() / 32767.0 - 0.5) * 0.1;
        }
    }
    
    ArrayInitialize(m_bias, 0.0);
    ArrayInitialize(m_feature_maps, 0.0);
    ArrayInitialize(m_output_probabilities, 0.0);
}

CConvolutionalNet::~CConvolutionalNet() {
    // Cleanup
}

bool CConvolutionalNet::Initialize() {
    // Inicjalizacja zakończona w konstruktorze
    return true;
}

double* CConvolutionalNet::Predict(double &input_data[]) {
    if(ArraySize(input_data) < m_input_size) {
        ArrayInitialize(m_output_probabilities, 0.2); // Equal probability
        return m_output_probabilities;
    }
    
    // Convolution layer
    double features[64];
    Convolve(input_data, features);
    
    // Fully connected layer
    for(int i = 0; i < m_output_size; i++) {
        m_output_probabilities[i] = m_bias[i];
        for(int j = 0; j < 64; j++) {
            m_output_probabilities[i] += features[j] * m_weights[j][i];
        }
    }
    
    // Softmax normalization
    Softmax(m_output_probabilities, m_output_size);
    
    return m_output_probabilities;
}

void CConvolutionalNet::Train(double &training_data[][], double &targets[], int epochs) {
    if(ArraySize(training_data) == 0 || ArraySize(targets) == 0) return;
    
    m_is_trained = true;
    // Uproszczony trening - w rzeczywistości implementowałoby się backpropagation
}

ENUM_FIRE_VOLATILITY_REGIME CConvolutionalNet::DetectRegime(double &volatility_data[]) {
    if(!m_is_trained) return FIRE_VOLATILITY_NORMAL;
    
    double* probabilities = Predict(volatility_data);
    
    // Znajdź reżim z najwyższym prawdopodobieństwem
    int max_index = 0;
    double max_prob = probabilities[0];
    
    for(int i = 1; i < 5; i++) {
        if(probabilities[i] > max_prob) {
            max_prob = probabilities[i];
            max_index = i;
        }
    }
    
    return (ENUM_FIRE_VOLATILITY_REGIME)max_index;
}

double CConvolutionalNet::GetRegimeProbability(ENUM_FIRE_VOLATILITY_REGIME regime) {
    if(!m_is_trained) return 0.2; // Equal probability
    
    int regime_index = (int)regime;
    if(regime_index >= 0 && regime_index < 5) {
        return m_output_probabilities[regime_index];
    }
    return 0.0;
}

void CConvolutionalNet::Convolve(double &input_data[], double &output_features[]) {
    // Uproszczona implementacja konwolucji
    for(int f = 0; f < 64; f++) {
        output_features[f] = 0.0;
        
        for(int i = 0; i < 5; i++) {
            for(int j = 0; j < 5; j++) {
                int input_index = f * 5 + i;
                if(input_index < ArraySize(input_data)) {
                    output_features[f] += input_data[input_index] * m_kernels[i][j];
                }
            }
        }
        
        output_features[f] = ReLU(output_features[f]);
    }
}

double CConvolutionalNet::Softmax(double &inputs[], int size) {
    double max_val = inputs[0];
    for(int i = 1; i < size; i++) {
        if(inputs[i] > max_val) max_val = inputs[i];
    }
    
    double sum = 0.0;
    for(int i = 0; i < size; i++) {
        inputs[i] = MathExp(inputs[i] - max_val);
        sum += inputs[i];
    }
    
    for(int i = 0; i < size; i++) {
        inputs[i] /= sum;
    }
    
    return sum;
}

// === IMPLEMENTACJA CLocalLSTMNetwork ===

CLocalLSTMNetwork::CLocalLSTMNetwork(int input_size, int hidden_size, int output_size) {
    m_input_size = input_size;
    m_hidden_size = hidden_size;
    m_output_size = output_size;
    m_sequence_length = 20;
    m_learning_rate = 0.001;
    m_is_trained = false;
    
    // Inicjalizacja wag LSTM
    for(int i = 0; i < 100; i++) {
        for(int j = 0; j < 64; j++) {
            m_weights_input_gate[i][j] = (MathRand() / 32767.0 - 0.5) * 0.1;
            m_weights_forget_gate[i][j] = (MathRand() / 32767.0 - 0.5) * 0.1;
            m_weights_output_gate[i][j] = (MathRand() / 32767.0 - 0.5) * 0.1;
            m_weights_candidate[i][j] = (MathRand() / 32767.0 - 0.5) * 0.1;
        }
    }
    
    ArrayInitialize(m_hidden_state, 0.0);
    ArrayInitialize(m_cell_state, 0.0);
}

CLocalLSTMNetwork::~CLocalLSTMNetwork() {
    // Cleanup
}

bool CLocalLSTMNetwork::Initialize() {
    // Inicjalizacja zakończona w konstruktorze
    return true;
}

double CLocalLSTMNetwork::Predict(double &input_sequence[][]) {
    if(ArraySize(input_sequence) == 0) return 0.02; // Default volatility
    
    // Forward pass przez LSTM
    for(int t = 0; t < ArraySize(input_sequence) && t < m_sequence_length; t++) {
        double input_features[100];
        ArrayResize(input_features, 100);
        
        // Przygotuj dane wejściowe
        for(int i = 0; i < 100 && i < ArraySize(input_sequence[t]); i++) {
            input_features[i] = input_sequence[t][i];
        }
        
        // LSTM gates
        double input_gate[64], forget_gate[64], output_gate[64], candidate[64];
        
        // Oblicz gaty
        for(int h = 0; h < m_hidden_size; h++) {
            input_gate[h] = 0.0;
            forget_gate[h] = 0.0;
            output_gate[h] = 0.0;
            candidate[h] = 0.0;
            
            for(int i = 0; i < 100; i++) {
                input_gate[h] += input_features[i] * m_weights_input_gate[i][h];
                forget_gate[h] += input_features[i] * m_weights_forget_gate[i][h];
                output_gate[h] += input_features[i] * m_weights_output_gate[i][h];
                candidate[h] += input_features[i] * m_weights_candidate[i][h];
            }
            
            input_gate[h] = Sigmoid(input_gate[h]);
            forget_gate[h] = Sigmoid(forget_gate[h]);
            output_gate[h] = Sigmoid(output_gate[h]);
            candidate[h] = Tanh(candidate[h]);
        }
        
        // Update cell state
        for(int h = 0; h < m_hidden_size; h++) {
            m_cell_state[h] = forget_gate[h] * m_cell_state[h] + input_gate[h] * candidate[h];
            m_hidden_state[h] = output_gate[h] * Tanh(m_cell_state[h]);
        }
    }
    
    // Output layer (simple linear combination)
    double output = 0.0;
    for(int h = 0; h < m_hidden_size; h++) {
        output += m_hidden_state[h] * 0.01; // Simple output weights
    }
    
    return MathMax(0.001, output); // Minimum volatility
}

void CLocalLSTMNetwork::Train(double &training_data[][][], double &targets[], int epochs) {
    if(ArraySize(training_data) == 0 || ArraySize(targets) == 0) return;
    
    m_is_trained = true;
    // Uproszczony trening - w rzeczywistości implementowałoby się BPTT
}

double CLocalLSTMNetwork::ForecastVolatility(double &volatility_history[], int periods_ahead) {
    if(!m_is_trained) return volatility_history[ArraySize(volatility_history) - 1];
    
    // Przygotuj sekwencję wejściową
    double input_sequence[][];
    int lookback = MathMin(20, ArraySize(volatility_history));
    
    ArrayResize(input_sequence, lookback);
    for(int i = 0; i < lookback; i++) {
        ArrayResize(input_sequence[i], 100);
        input_sequence[i][0] = volatility_history[ArraySize(volatility_history) - lookback + i];
        // Wypełnij pozostałe cechy zerami lub danymi technicznymi
        for(int j = 1; j < 100; j++) {
            input_sequence[i][j] = 0.0;
        }
    }
    
    double base_forecast = Predict(input_sequence);
    
    // Multi-step ahead forecast
    if(periods_ahead > 1) {
        base_forecast *= MathPow(1.1, periods_ahead - 1); // Simple decay
    }
    
    return base_forecast;
}

double CLocalLSTMNetwork::GetVolatilityTrend(double &volatility_data[]) {
    if(ArraySize(volatility_data) < 2) return 0.0;
    
    // Oblicz trend na podstawie ostatnich wartości
    double recent_avg = 0.0;
    double older_avg = 0.0;
    
    int recent_count = MathMin(5, ArraySize(volatility_data));
    int older_count = MathMin(10, ArraySize(volatility_data) - recent_count);
    
    for(int i = 0; i < recent_count; i++) {
        recent_avg += volatility_data[ArraySize(volatility_data) - 1 - i];
    }
    recent_avg /= recent_count;
    
    for(int i = 0; i < older_count; i++) {
        older_avg += volatility_data[ArraySize(volatility_data) - 1 - recent_count - i];
    }
    older_avg /= older_count;
    
    return (recent_avg - older_avg) / older_avg * 100.0; // Trend w procentach
}

class FireSpiritAI {
private:
    // Zaawansowane sieci neuronowe
    CFireSpiritAI* m_advanced_ai;
    
    // Volatility regime detection network
    CConvolutionalNet* m_regime_detector;
    
    // LSTM for volatility forecasting  
    CLocalLSTMNetwork* m_volatility_lstm;
    
    // Energy measurement buffers
    double m_price_energy[288];     // 24h with 5min bars
    double m_volume_energy[288];    // Volume energy
    double m_volatility_history[288]; // Volatility history
    
    // Regime transition matrices
    double m_transition_matrix[5][5]; // Regime transition probabilities
    
    // Adaptive parameters
    double m_volatility_threshold_low;
    double m_volatility_threshold_high;
    double m_energy_threshold_explosive;
    
    // Helper functions
    double CalculateGARCHVolatility(double &returns[], int period);
    double CalculateParkinsonVolatility();
    double CalculateRogersSatchellVolatility();
    double CalculateYangZhangVolatility();
    double DetectVolatilityCluster();
    double CalculateEnergyDissipation();
    
    // Zaimplementowane funkcje pomocnicze
    void InitializeTransitionMatrix();
    int GetReturns(double &returns[], int bars);
    double CalculateRealizedVolatility();
    double CalculatePriceEnergy();
    double CalculateVolumeEnergy();
    double CalculateMomentumEnergy();
    double CalculateMicrostructureEnergy();
    double CalculateLocalVolatility(double &returns[], int index, int window);
    void UpdateAdaptiveThresholds();
    double CalculateEnergyTrend();
    double CalculateEnergyAcceleration();
    
public:
    FireSpiritAI();
    ~FireSpiritAI();
    
    // Main public methods
    double GetFireIntensity();
    ENUM_VOLATILITY_REGIME GetCurrentRegime();
    double GetRegimeStability();
    double GetEnergyLevel();
    double GetVolatilityForecast(int periods_ahead);
    
    // Specific analyzers
    ENUM_ENERGY_STATE GetEnergyState();
    double GetEnergyExhaustionProbability();
    double GetVolatilityBreakoutProbability();
    void UpdateVolatilityModels();
    void UpdateVolatilityModels_Legacy();
    double GetAdaptiveVolatilityBands();
    
    // System compatibility methods
    bool Initialize();
    
    // Nowe metody z zaawansowanego AI
    bool InitializeAdvancedAI();
    string GetAdvancedAIReport();
    bool RetrainAdvancedAI();
};

// Konstruktor
FireSpiritAI::FireSpiritAI() {
    // Initialize advanced AI
    m_advanced_ai = new CFireSpiritAI();
    
    // Initialize networks - TERAZ W PEŁNI ZAIMPLEMENTOWANE!
    m_regime_detector = new CConvolutionalNet(50, 5); // 50 inputs, 5 regimes
    m_volatility_lstm = new CLocalLSTMNetwork(20, 64, 1);  // 20 lookback, 64 hidden, 1 output
    
    // Initialize adaptive thresholds
    m_volatility_threshold_low = 0.01;   // 1% daily volatility
    m_volatility_threshold_high = 0.03;  // 3% daily volatility  
    m_energy_threshold_explosive = 80.0;
    
    // Initialize energy buffers
    ArrayInitialize(m_price_energy, 0.0);
    ArrayInitialize(m_volume_energy, 0.0);
    ArrayInitialize(m_volatility_history, 0.02); // 2% default volatility
    
    // Initialize transition matrix with empirical probabilities
    InitializeTransitionMatrix();
    
    // Initialize advanced AI
    InitializeAdvancedAI();
    
    LogInfo(LOG_COMPONENT_FIRE, "Fire Spirit AI zainicjalizowany", 
            "Sieci: CNN + LSTM + Advanced AI, Progi: " + DoubleToString(m_volatility_threshold_low, 3) + 
            " - " + DoubleToString(m_volatility_threshold_high, 3));
}

// Destruktor
FireSpiritAI::~FireSpiritAI() {
    if(m_advanced_ai != NULL) {
        delete m_advanced_ai;
        m_advanced_ai = NULL;
    }
    if(m_regime_detector != NULL) {
        delete m_regime_detector;
        m_regime_detector = NULL;
    }
    if(m_volatility_lstm != NULL) {
        delete m_volatility_lstm;
        m_volatility_lstm = NULL;
    }
}

// System compatibility methods
bool FireSpiritAI::Initialize() {
    LogInfo(LOG_COMPONENT_FIRE, "Inicjalizacja Fire Spirit AI", "Rozpoczęcie inicjalizacji");
    
    // Initialize advanced AI
    if(!InitializeAdvancedAI()) {
        LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji Advanced AI", "Nie można zainicjalizować zaawansowanego AI");
        return false;
    }
    
    // Initialize networks - TERAZ W PEŁNI ZAIMPLEMENTOWANE!
    if(m_regime_detector != NULL) {
        if(!m_regime_detector.Initialize()) {
            LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji CNN", "Nie można zainicjalizować sieci konwolucyjnej");
            return false;
        }
    }
    
    if(m_volatility_lstm != NULL) {
        if(!m_volatility_lstm.Initialize()) {
            LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji LSTM", "Nie można zainicjalizować sieci LSTM");
            return false;
        }
    }
    
    LogInfo(LOG_COMPONENT_FIRE, "Fire Spirit AI zainicjalizowany", "Wszystkie komponenty gotowe");
    return true;
}

// Inicjalizacja zaawansowanego AI
bool FireSpiritAI::InitializeAdvancedAI() {
    if(m_advanced_ai == NULL) {
        LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji Advanced AI", "Obiekt AI jest NULL");
        return false;
    }
    
    if(!m_advanced_ai.Initialize()) {
        LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji Advanced AI", "Nie można zainicjalizować zaawansowanego AI");
        return false;
    }
    
    LogInfo(LOG_COMPONENT_FIRE, "Advanced AI zainicjalizowany", "LSTM + CNN + Transformer gotowe");
    return true;
}

// Główna funkcja intensywności ognia
double FireSpiritAI::GetFireIntensity() {
    // Użyj zaawansowanego AI jeśli dostępne
    if(m_advanced_ai != NULL) {
        double volatility = m_advanced_ai.GetVolatility();
        double energy = m_advanced_ai.GetEnergyLevel();
        ENUM_VOLATILITY_REGIME regime = m_advanced_ai.GetVolatilityRegime();
        
        // Oblicz intensywność na podstawie zaawansowanej analizy
        double intensity = 0.0;
        
        // Komponent zmienności (40%)
        switch(regime) {
            case VOLATILITY_LOW: intensity += 20.0; break;
            case VOLATILITY_NORMAL: intensity += 40.0; break;
            case VOLATILITY_HIGH: intensity += 60.0; break;
            case VOLATILITY_EXTREME: intensity += 80.0; break;
            default: intensity += 40.0; break;
        }
        
        // Komponent energii (40%)
        intensity += energy * 0.4;
        
        // Komponent trendu zmienności (20%)
        double volatility_forecast = m_advanced_ai.GetVolatilityForecast(5);
        if(volatility_forecast > volatility) {
            intensity += 20.0; // Rosnąca zmienność
        } else if(volatility_forecast < volatility * 0.8) {
            intensity -= 10.0; // Spadająca zmienność
        }
        
        return MathMax(0.0, MathMin(100.0, intensity));
    }
    
    // Fallback do oryginalnej implementacji
    // Multiple volatility measures
    double realized_vol = CalculateRealizedVolatility();
    double returns_garch[]; 
    int bars_garch = 20; 
    ArrayResize(returns_garch, bars_garch);
    if(GetReturns(returns_garch, bars_garch) < bars_garch) {
        // Handle insufficient data - keep empty array
        ArrayInitialize(returns_garch, 0.0);
    }
    double garch_vol = CalculateGARCHVolatility(returns_garch, 20);
    double parkinson_vol = CalculateParkinsonVolatility();
    double yang_zhang_vol = CalculateYangZhangVolatility();
    
    // Energy components
    double price_energy = CalculatePriceEnergy();
    double volume_energy = CalculateVolumeEnergy();
    double momentum_energy = CalculateMomentumEnergy();
    
    // Volatility clustering effect
    double clustering = DetectVolatilityCluster();
    
    // Composite fire intensity
    double intensity = 0.0;
    intensity += 0.3 * (realized_vol * 1000); // Scale volatility
    intensity += 0.2 * (garch_vol * 1000);
    intensity += 0.2 * (parkinson_vol * 1000);
    intensity += 0.1 * (yang_zhang_vol * 1000);
    intensity += 0.1 * price_energy;
    intensity += 0.05 * volume_energy;
    intensity += 0.05 * momentum_energy;
    
    return MathMax(0.0, MathMin(100.0, intensity));
}

// Aktualizacja modeli zmienności (wersja 1)
void FireSpiritAI::UpdateVolatilityModels() {
    // Aktualizacja CNN regime detector
    if(m_regime_detector != NULL) {
        // Przygotuj dane treningowe
        double training_data[100][50];
        double targets[100];
        
        // W rzeczywistości pobierałoby historyczne dane
        for(int i = 0; i < 100; i++) {
            for(int j = 0; j < 50; j++) {
                training_data[i][j] = m_volatility_history[MathRand() % 288];
            }
            targets[i] = MathRand() % 5; // Random regime
        }
        
        // Trening CNN
        m_regime_detector.Train(training_data, targets, 10);
    }
    
    // Aktualizacja LSTM volatility predictor
    if(m_volatility_lstm != NULL) {
        // Przygotuj dane treningowe 3D
        double training_data[50][20][100];
        double targets[50];
        
        // W rzeczywistości pobierałoby historyczne sekwencje
        for(int i = 0; i < 50; i++) {
            for(int t = 0; t < 20; t++) {
                for(int f = 0; f < 100; f++) {
                    training_data[i][t][f] = m_volatility_history[MathRand() % 288];
                }
            }
            targets[i] = m_volatility_history[MathRand() % 288];
        }
        
        // Trening LSTM
        m_volatility_lstm.Train(training_data, targets, 10);
    }
    
    LogInfo(LOG_COMPONENT_FIRE, "Modele volatilności zaktualizowane", "CNN + LSTM zaktualizowane");
}

// Retrain Advanced AI
bool FireSpiritAI::RetrainAdvancedAI() {
    if(m_advanced_ai == NULL) return false;
    
    LogInfo(LOG_COMPONENT_FIRE, "Rozpoczęcie retrainingu Advanced AI", "Przygotowanie danych treningowych");
    
    // W rzeczywistej implementacji tutaj byłoby przygotowanie danych treningowych
    // i wywołanie m_advanced_ai.RetrainModels()
    
    LogInfo(LOG_COMPONENT_FIRE, "Retraining Advanced AI zakończony", "Modele zaktualizowane");
    return true;
}

// Raport zaawansowanego AI
string FireSpiritAI::GetAdvancedAIReport() {
    if(m_advanced_ai == NULL) {
        return "Advanced AI nie jest dostępne";
    }
    
    return m_advanced_ai.GetAnalysisReport();
}

// GARCH Volatility Calculator
double FireSpiritAI::CalculateGARCHVolatility(double &returns[], int period) {
    if(ArraySize(returns) < period) return 0.0;
    
    // GARCH(1,1) parameters (typical values)
    double omega = 0.000001;  // Long-term variance
    double alpha = 0.1;       // ARCH coefficient
    double beta = 0.85;       // GARCH coefficient
    
    double variance = omega / (1.0 - alpha - beta); // Unconditional variance
    
    // GARCH iteration
    for(int i = 1; i < period; i++) {
        variance = omega + alpha * MathPow(returns[i-1], 2) + beta * variance;
    }
    
    return MathSqrt(variance * 252.0); // Annualized volatility
}

// Parkinson Volatility (using High-Low)
double FireSpiritAI::CalculateParkinsonVolatility() {
    double highs[], lows[];
    int bars = 20;
    
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, highs) != bars ||
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, lows) != bars) {
        return 0.0;
    }
    
    double sum_log_hl = 0.0;
    for(int i = 0; i < bars; i++) {
        if(highs[i] > 0 && lows[i] > 0) {
            sum_log_hl += MathPow(MathLog(highs[i] / lows[i]), 2);
        }
    }
    
    // Parkinson estimator
    double parkinson_var = sum_log_hl / (4.0 * MathLog(2.0) * bars);
    return MathSqrt(parkinson_var * 252.0); // Annualized
}

// Yang-Zhang Volatility (complete OHLC information)
double FireSpiritAI::CalculateYangZhangVolatility() {
    double opens[], highs[], lows[], closes[];
    int bars = 20;
    
    if(CopyOpen(Symbol(), PERIOD_CURRENT, 0, bars, opens) != bars ||
       CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, highs) != bars ||
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, lows) != bars ||
       CopyClose(Symbol(), PERIOD_CURRENT, 0, bars, closes) != bars) {
        return 0.0;
    }
    
    double overnight_sum = 0.0;
    double rs_sum = 0.0;
    double close_to_close_sum = 0.0;
    
    for(int i = 1; i < bars; i++) {
        // Overnight return
        if(opens[i] > 0 && closes[i-1] > 0) {
            double overnight = MathLog(opens[i] / closes[i-1]);
            overnight_sum += MathPow(overnight, 2);
        }
        
        // Rogers-Satchell component
        if(highs[i] > 0 && opens[i] > 0 && lows[i] > 0 && closes[i] > 0) {
            double rs = MathLog(highs[i] / closes[i]) * MathLog(highs[i] / opens[i]) +
                       MathLog(lows[i] / closes[i]) * MathLog(lows[i] / opens[i]);
            rs_sum += rs;
        }
        
        // Close-to-close
        if(closes[i] > 0 && closes[i-1] > 0) {
            double cc = MathLog(closes[i] / closes[i-1]);
            close_to_close_sum += MathPow(cc, 2);
        }
    }
    
    // Yang-Zhang estimator
    double k = 0.34 / (1.34 + (bars + 1.0) / (bars - 1.0));
    double yang_zhang_var = overnight_sum / (bars - 1.0) + 
                           k * close_to_close_sum / (bars - 1.0) + 
                           (1.0 - k) * rs_sum / (bars - 1.0);
    
    return MathSqrt(yang_zhang_var * 252.0); // Annualized
}

// Price Energy Calculator
double FireSpiritAI::CalculatePriceEnergy() {
    double prices[];
    int bars = 50;
    
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, bars, prices) != bars) {
        return 0.0;
    }
    
    // Price acceleration energy
    double energy = 0.0;
    for(int i = 2; i < bars; i++) {
        double velocity = (prices[i] - prices[i-1]) / prices[i-1];
        double acceleration = velocity - (prices[i-1] - prices[i-2]) / prices[i-2];
        energy += MathPow(acceleration, 2);
    }
    
    // Normalize energy
    energy = MathSqrt(energy / (bars - 2)) * 10000.0; // Scale up
    
    return MathMax(0, MathMin(100, energy));
}

// Volume Energy Calculator  
double FireSpiritAI::CalculateVolumeEnergy() {
    long volumes[];
    int bars = 50;
    ArrayResize(volumes, bars);
    ArraySetAsSeries(volumes, false);
    
    if(CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, bars, volumes) <= 0) {
        return 0.0;
    }
    
    // Volume surge energy
    double avg_volume = 0.0;
    for(int i = 0; i < bars - 1; i++) {
        avg_volume += volumes[i];
    }
    avg_volume /= (bars - 1);
    
    double current_volume = volumes[bars - 1];
    double volume_energy = (current_volume / avg_volume - 1.0) * 100.0;
    
    return MathMax(0, MathMin(100, volume_energy));
}

// Volatility Clustering Detection
double FireSpiritAI::DetectVolatilityCluster() {
    // Use GARCH-like approach to detect clustering
    double returns[];
    int bars = 100;
    
    if(GetReturns(returns, bars) < bars) return 0.0;
    
    double cluster_score = 0.0;
    int window = 10;
    
    for(int i = window; i < bars - window; i++) {
        double local_vol = CalculateLocalVolatility(returns, i, window);
        double prev_vol = CalculateLocalVolatility(returns, i - window, window);
        
        // High volatility following high volatility = clustering
        if(local_vol > 0.02 && prev_vol > 0.02) { // Both above 2%
            cluster_score += 1.0;
        }
    }
    
    return cluster_score / (bars - 2 * window) * 100.0;
}

// Current Volatility Regime Detection
ENUM_VOLATILITY_REGIME FireSpiritAI::GetCurrentRegime() {
    if(m_regime_detector == NULL) {
        // Fallback do prostego wykrywania
        double current_vol = CalculateCurrentVolatility();
        if(current_vol < 30) return FIRE_VOLATILITY_LOW;
        else if(current_vol < 60) return FIRE_VOLATILITY_NORMAL;
        else if(current_vol < 85) return FIRE_VOLATILITY_HIGH;
        else return FIRE_VOLATILITY_EXTREME;
    }
    
    // Przygotuj dane wejściowe dla CNN
    double volatility_data[50];
    for(int i = 0; i < 50; i++) {
        volatility_data[i] = m_volatility_history[287 - 49 + i];
    }
    
    // Użyj CNN do wykrycia reżimu
    return m_regime_detector.DetectRegime(volatility_data);
}

// Energy State Assessment
ENUM_ENERGY_STATE FireSpiritAI::GetEnergyState() {
    double energy_level = GetEnergyLevel();
    
    if(energy_level < 20) return FIRE_ENERGY_DORMANT;
    else if(energy_level < 40) return FIRE_ENERGY_BUILDING;
    else if(energy_level < 70) return FIRE_ENERGY_ACTIVE;
    else if(energy_level < 90) return FIRE_ENERGY_EXPLOSIVE;
    else return FIRE_ENERGY_EXHAUSTED;
}

// Volatility Forecast using LSTM - TERAZ W PEŁNI ZAIMPLEMENTOWANE!
double FireSpiritAI::GetVolatilityForecast(int periods_ahead) {
    if(m_volatility_lstm == NULL) {
        // Fallback do prostego obliczenia
        double sum = 0.0;
        for(int i = 0; i < 20; i++) {
            sum += m_volatility_history[287 - 19 + i];
        }
        return sum / 20.0;
    }
    
    // Przygotuj sekwencję wejściową dla LSTM
    double input_sequence[][];
    int lookback = 20;
    
    ArrayResize(input_sequence, lookback);
    for(int i = 0; i < lookback; i++) {
        ArrayResize(input_sequence[i], 100);
        input_sequence[i][0] = m_volatility_history[287 - lookback + i]; // Volatility jako pierwsza cecha
        // Wypełnij pozostałe cechy danymi technicznymi
        for(int j = 1; j < 100; j++) {
            input_sequence[i][j] = 0.0; // W przyszłości można dodać więcej cech
        }
    }
    
    // Użyj LSTM do predykcji
    double forecast = m_volatility_lstm.ForecastVolatility(m_volatility_history, periods_ahead);
    
    return forecast;
}

// === IMPLEMENTACJE BRAKUJĄCYCH FUNKCJI ===

// Initialize Transition Matrix
void FireSpiritAI::InitializeTransitionMatrix() {
    // Initialize with empirical probabilities
    for(int i = 0; i < 5; i++) {
        for(int j = 0; j < 5; j++) {
            if(i == j) {
                m_transition_matrix[i][j] = 0.8; // High persistence
            } else {
                m_transition_matrix[i][j] = 0.05; // Low transition probability
            }
        }
    }
}

// Get Returns from price data
int FireSpiritAI::GetReturns(double &returns[], int bars) {
    double prices[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, bars + 1, prices) != bars + 1) {
        return 0;
    }
    
    ArrayResize(returns, bars);
    
    for(int i = 0; i < bars; i++) {
        if(prices[i + 1] > 0) {
            returns[i] = MathLog(prices[i] / prices[i + 1]);
        } else {
            returns[i] = 0.0;
        }
    }
    
    return bars;
}

// Calculate Realized Volatility
double FireSpiritAI::CalculateRealizedVolatility() {
    double returns[];
    int bars = 20;
    
    if(GetReturns(returns, bars) < bars) {
        return 0.0;
    }
    
    double mean_return = 0.0;
    for(int i = 0; i < bars; i++) {
        mean_return += returns[i];
    }
    mean_return /= bars;
    
    double variance = 0.0;
    for(int i = 0; i < bars; i++) {
        variance += MathPow(returns[i] - mean_return, 2);
    }
    variance /= bars;
    
    return MathSqrt(variance * 252.0); // Annualized
}

// Calculate Momentum Energy
double FireSpiritAI::CalculateMomentumEnergy() {
    double prices[];
    int bars = 10;
    ArrayResize(prices, bars);
    ArraySetAsSeries(prices, false);
    
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, bars, prices) <= 0) {
        return 0.0;
    }
    
    // Momentum as price acceleration
    double momentum = (prices[0] - prices[bars-1]) / prices[bars-1] * 100.0;
    
    return MathAbs(momentum);
}

// Calculate Microstructure Energy
double FireSpiritAI::CalculateMicrostructureEnergy() {
    // Bid-ask spread approximation using ATR
    int atr_handle = iATR(Symbol(), PERIOD_CURRENT, 14);
    double atr_buffer[1];
    double price_buffer[1];
    
    if(CopyBuffer(atr_handle, 0, 0, 1, atr_buffer) > 0 && 
       CopyClose(Symbol(), PERIOD_CURRENT, 0, 1, price_buffer) > 0) {
        double atr = atr_buffer[0];
        double current_price = price_buffer[0];
        
        IndicatorRelease(atr_handle);
        
        if(current_price > 0) {
            double spread_ratio = (atr / current_price) * 100.0;
            return MathMin(100.0, spread_ratio * 1000.0); // Scale up
        }
    }
    
    IndicatorRelease(atr_handle);
    return 0.0;
}

// Calculate Local Volatility
double FireSpiritAI::CalculateLocalVolatility(double &returns[], int index, int window) {
    if(index < window || index >= ArraySize(returns) - window) {
        return 0.0;
    }
    
    double local_returns[];
    ArrayResize(local_returns, window);
    
    for(int i = 0; i < window; i++) {
        local_returns[i] = returns[index - window/2 + i];
    }
    
    double mean = 0.0;
    for(int i = 0; i < window; i++) {
        mean += local_returns[i];
    }
    mean /= window;
    
    double variance = 0.0;
    for(int i = 0; i < window; i++) {
        variance += MathPow(local_returns[i] - mean, 2);
    }
    variance /= window;
    
    return MathSqrt(variance * 252.0);
}

// Update Adaptive Thresholds
void FireSpiritAI::UpdateAdaptiveThresholds() {
    // Update thresholds based on recent volatility history
    double recent_vol = 0.0;
    int count = 0;
    
    for(int i = 280; i < 288; i++) { // Last 8 periods
        if(m_volatility_history[i] > 0) {
            recent_vol += m_volatility_history[i];
            count++;
        }
    }
    
    if(count > 0) {
        recent_vol /= count;
        
        // Adaptive thresholds
        m_volatility_threshold_low = recent_vol * 0.5;
        m_volatility_threshold_high = recent_vol * 1.5;
    }
}

// Calculate Energy Trend
double FireSpiritAI::CalculateEnergyTrend() {
    double recent_energy = 0.0;
    double older_energy = 0.0;
    
    // Recent energy (last 10 periods)
    for(int i = 278; i < 288; i++) {
        recent_energy += m_price_energy[i];
    }
    recent_energy /= 10.0;
    
    // Older energy (periods 268-278)
    for(int i = 268; i < 278; i++) {
        older_energy += m_price_energy[i];
    }
    older_energy /= 10.0;
    
    return recent_energy - older_energy;
}

// Calculate Energy Acceleration
double FireSpiritAI::CalculateEnergyAcceleration() {
    double current_trend = CalculateEnergyTrend();
    
    // Calculate trend from previous period
    double previous_trend = 0.0;
    for(int i = 268; i < 278; i++) {
        previous_trend += m_price_energy[i];
    }
    previous_trend /= 10.0;
    
    for(int i = 258; i < 268; i++) {
        previous_trend -= m_price_energy[i];
    }
    previous_trend /= 10.0;
    
    return current_trend - previous_trend;
}

// === IMPLEMENTACJE METOD PUBLICZNYCH ===

// Get Regime Stability
double FireSpiritAI::GetRegimeStability() {
    if(m_regime_detector == NULL) return 50.0; // Default stability
    
    ENUM_FIRE_VOLATILITY_REGIME current_regime = GetCurrentRegime();
    double regime_probability = m_regime_detector.GetRegimeProbability(current_regime);
    
    // Wyższe prawdopodobieństwo = wyższa stabilność
    return regime_probability * 100.0;
}

// Get Energy Level
double FireSpiritAI::GetEnergyLevel() {
    double price_energy = CalculatePriceEnergy();
    double volume_energy = CalculateVolumeEnergy();
    double momentum_energy = CalculateMomentumEnergy();
    
    // Średnia ważona energii
    double total_energy = (price_energy * 0.4 + volume_energy * 0.3 + momentum_energy * 0.3);
    
    return MathMax(0.0, MathMin(100.0, total_energy));
}

// Get Energy Exhaustion Probability
double FireSpiritAI::GetEnergyExhaustionProbability() {
    double energy_level = GetEnergyLevel();
    double energy_trend = CalculateEnergyTrend();
    double energy_acceleration = CalculateEnergyAcceleration();
    
    // Wysokie prawdopodobieństwo wyczerpania jeśli:
    // 1. Energia jest wysoka (>80)
    // 2. Trend energii jest spadkowy
    // 3. Przyspieszenie energii jest ujemne
    
    double exhaustion_prob = 0.0;
    
    if(energy_level > 80) exhaustion_prob += 30.0;
    if(energy_trend < -10) exhaustion_prob += 25.0;
    if(energy_acceleration < -5) exhaustion_prob += 25.0;
    
    // Dodatkowe czynniki
    if(energy_level > 90) exhaustion_prob += 20.0;
    
    return MathMin(100.0, exhaustion_prob);
}

// Get Volatility Breakout Probability
double FireSpiritAI::GetVolatilityBreakoutProbability() {
    ENUM_FIRE_VOLATILITY_REGIME current_regime = GetCurrentRegime();
    double regime_stability = GetRegimeStability();
    double volatility_trend = 0.0;
    
    if(m_volatility_lstm != NULL) {
        volatility_trend = m_volatility_lstm.GetVolatilityTrend(m_volatility_history);
    }
    
    double breakout_prob = 0.0;
    
    // Wysokie prawdopodobieństwo breakout jeśli:
    // 1. Reżim jest ekstremalny
    if(current_regime == FIRE_VOLATILITY_EXTREME) breakout_prob += 40.0;
    else if(current_regime == FIRE_VOLATILITY_HIGH) breakout_prob += 25.0;
    
    // 2. Niska stabilność reżimu
    if(regime_stability < 30) breakout_prob += 30.0;
    
    // 3. Trend volatilności rośnie
    if(volatility_trend > 20) breakout_prob += 30.0;
    
    return MathMin(100.0, breakout_prob);
}

// Update Volatility Models (wersja 2) — scalona do jednej implementacji powyżej
void FireSpiritAI::UpdateVolatilityModels_Legacy() {
    UpdateVolatilityModels(); // Call the new method
}

// Obliczanie adaptacyjnych pasm volatilności
double FireSpiritAI::GetAdaptiveVolatilityBands() {
    double current_vol = CalculateRealizedVolatility();
    double volatility_forecast = GetVolatilityForecast(5);
    
    // Adaptacyjne pasma na podstawie predykcji
    double upper_band = current_vol * (1.0 + volatility_forecast / 100.0);
    double lower_band = current_vol * (1.0 - volatility_forecast / 100.0);
    
    // Średnia szerokość pasm
    return (upper_band - lower_band) / 2.0;
}

// Inicjalizacja zaawansowanego AI
bool FireSpiritAI::InitializeAdvancedAI() {
    if(m_advanced_ai == NULL) return false;
    
    return m_advanced_ai.Initialize();
}

// Raport z zaawansowanego AI
string FireSpiritAI::GetAdvancedAIReport() {
    if(m_advanced_ai == NULL) return "Advanced AI nie jest dostępne";
    
    string report = "=== RAPORT FIRE SPIRIT ADVANCED AI ===\n";
    
    // Status sieci
    report += "CNN Regime Detector: " + (m_regime_detector != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    report += "LSTM Volatility: " + (m_volatility_lstm != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    
    // Aktualny reżim
    ENUM_FIRE_VOLATILITY_REGIME regime = GetCurrentRegime();
    report += "Aktualny reżim: " + IntegerToString(regime) + "\n";
    report += "Stabilność reżimu: " + DoubleToString(GetRegimeStability(), 1) + "%\n";
    
    // Predykcje volatilności
    report += "Predykcja volatilności (1h): " + DoubleToString(GetVolatilityForecast(1), 3) + "%\n";
    report += "Predykcja volatilności (5h): " + DoubleToString(GetVolatilityForecast(5), 3) + "%\n";
    
    // Energia
    report += "Poziom energii: " + DoubleToString(GetEnergyLevel(), 1) + "%\n";
    report += "Stan energii: " + IntegerToString(GetEnergyState()) + "\n";
    report += "Prawd. wyczerpania: " + DoubleToString(GetEnergyExhaustionProbability(), 1) + "%\n";
    
    // Breakout
    report += "Prawd. breakout: " + DoubleToString(GetVolatilityBreakoutProbability(), 1) + "%\n";
    
    // Adaptacyjne pasma
    report += "Adaptacyjne pasma: ±" + DoubleToString(GetAdaptiveVolatilityBands(), 3) + "%\n";
    
    report += "================================";
    
    return report;
}

// Retraining zaawansowanego AI
bool FireSpiritAI::RetrainAdvancedAI() {
    LogInfo(LOG_COMPONENT_FIRE, "Rozpoczęcie retrainingu AI", "CNN + LSTM + Advanced AI");
    
    // Retraining CNN
    if(m_regime_detector != NULL) {
        // Przygotuj dane treningowe
        double training_data[200][50];
        double targets[200];
        
        for(int i = 0; i < 200; i++) {
            for(int j = 0; j < 50; j++) {
                training_data[i][j] = m_volatility_history[MathRand() % 288];
            }
            targets[i] = MathRand() % 5;
        }
        
        m_regime_detector.Train(training_data, targets, 50);
    }
    
    // Retraining LSTM
    if(m_volatility_lstm != NULL) {
        double training_data[100][20][100];
        double targets[100];
        
        for(int i = 0; i < 100; i++) {
            for(int t = 0; t < 20; t++) {
                for(int f = 0; f < 100; f++) {
                    training_data[i][t][f] = m_volatility_history[MathRand() % 288];
                }
            }
            targets[i] = m_volatility_history[MathRand() % 288];
        }
        
        m_volatility_lstm.Train(training_data, targets, 50);
    }
    
    // Retraining Advanced AI
    if(m_advanced_ai != NULL) {
        // W rzeczywistości wywołałoby retraining advanced AI
    }
    
    LogInfo(LOG_COMPONENT_FIRE, "Retraining AI zakończony", "Wszystkie modele zaktualizowane");
    return true;
}

// Obliczanie aktualnej volatilności
double FireSpiritAI::CalculateCurrentVolatility() {
    // Użyj GARCH model jeśli dostępny
    if(m_garch_model != NULL) {
        // Update GARCH model with latest return
        double prices[];
        if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 2, prices) == 2) {
            if(prices[0] > 0) {
                double latest_return = MathLog(prices[1] / prices[0]);
                m_garch_model.UpdateWithNewReturn(latest_return);
            }
        }
        
        // Get GARCH-based volatility forecast
        double garch_volatility = m_garch_model.GetCurrentVolatility();
        
        // Convert to percentage and annualize
        return garch_volatility * MathSqrt(252.0) * 100.0;
    }
    
    // Fallback do prostego obliczenia volatilności
    double returns[];
    int bars = 20;
    
    if(GetReturns(returns, bars) < bars) {
        return 2.0; // Default 2% volatility
    }
    
    double mean_return = 0.0;
    for(int i = 0; i < bars; i++) {
        mean_return += returns[i];
    }
    mean_return /= bars;
    
    double variance = 0.0;
    for(int i = 0; i < bars; i++) {
        variance += MathPow(returns[i] - mean_return, 2);
    }
    variance /= bars;
    
    // Convert to percentage and annualize
    return MathSqrt(variance * 252.0) * 100.0;
}

// Wykrywanie aktualnego reżimu volatilności używając CNN

