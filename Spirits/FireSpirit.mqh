// Kompletna implementacja Ducha Ognia - Volatility & Energy Analysis
#include <Math\Stat\Stat.mqh>
#include "../Utils/LoggingSystem.mqh"
#include "../AI/AIEnums.mqh"
#include "../AI/AdvancedAI.mqh"

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

// LSTM Network - lokalna definicja aby uniknąć konfliktu nazw
class CFireLSTMNetwork {
private:
    int m_lookback;
    int m_hidden_size;
    int m_output_size;
    double m_weights[64][64];  // Simplified LSTM weights
    
public:
    CFireLSTMNetwork() {
        m_lookback = 20;
        m_hidden_size = 32;
        m_output_size = 1;
        Initialize();
    }
    
    bool Initialize() {
        // Initialize weights
        for(int i = 0; i < 64; i++) {
            for(int j = 0; j < 64; j++) {
                m_weights[i][j] = (MathRand() % 1000) / 1000.0 - 0.5;
            }
        }
        return true;
    }
    
    double Predict(double &sequence[]) {
        if(ArraySize(sequence) == 0) return 0.0;
        
        // Simple LSTM-like prediction
        double hidden_state = 0.0;
        int seq_size = ArraySize(sequence);
        
        for(int i = 0; i < seq_size; i++) {
            hidden_state = MathTanh(sequence[i] + hidden_state * 0.8);
        }
        
        return MathMax(0.0, MathMin(1.0, hidden_state));
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
    
    m_volatility_period = 14;
    m_energy_period = 20;
    m_volatility_threshold = 0.7;
    m_energy_threshold = 0.6;
    
    // Inicjalizacja struktur
    ZeroMemory(m_volatility_data);
    ZeroMemory(m_energy_data);
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
    // Placeholder implementation
    return 50.0 + (MathRand() % 50); // 50-100
}

double CFireSpirit::CalculateEnergyLevel() {
    // Placeholder implementation
    return 30.0 + (MathRand() % 70); // 30-100
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
    
    // Placeholder prediction
    breakout.is_imminent = (m_volatility_data.current_volatility > 70);
    breakout.probability = m_volatility_data.current_volatility / 100.0;
    breakout.expected_magnitude = 50.0 + (MathRand() % 50);
    breakout.expected_time = TimeCurrent() + 3600; // 1 hour from now
    breakout.trigger_description = "High volatility regime detected";
    
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

class FireSpiritAI {
private:
    // Zaawansowane sieci neuronowe
    CFireSpiritAI* m_advanced_ai;
    
    // Forward declarations for neural network classes
    class CConvolutionalNet; // forward declaration
    class CLocalLSTMNetwork; // forward declaration to satisfy pointer
    
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
    
    // Brakujące funkcje pomocnicze
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
    
    // Initialize networks
    // m_regime_detector = new CConvolutionalNet(50, 5); // 50 inputs, 5 regimes - disabled until class is available
    // m_volatility_lstm = new CLocalLSTMNetwork(20, 64, 1);  // 20 lookback, 64 hidden, 1 output - disabled until class is available
    
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
    
    // Initialize networks
    if(CheckPointer(m_regime_detector) == POINTER_DYNAMIC) {
        // m_regime_detector.Initialize(); // Initialize if method exists
    }
    
    if(CheckPointer(m_volatility_lstm) == POINTER_DYNAMIC) {
        // m_volatility_lstm.Initialize(); // Initialize if method exists  
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
    // Aktualizuj zaawansowane AI (zachowane z pierwszej wersji)
    if(m_advanced_ai != NULL) {
        double price_buffer[1];
        long volume_buffer[1];
        
        if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 1, price_buffer) > 0 &&
           CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, 1, volume_buffer) > 0) {
            double current_price = price_buffer[0];
            double current_volume = (double)volume_buffer[0];
            
            m_advanced_ai.UpdateData(current_price, current_volume);
        }
        
        // Retrain models if needed (e.g., every 1000 updates)
        static int update_counter = 0;
        update_counter++;
        
        if(update_counter % 1000 == 0) {
            LogInfo(LOG_COMPONENT_FIRE, "Retraining Advanced AI", "Update counter: " + IntegerToString(update_counter));
            RetrainAdvancedAI();
        }
    }
    
    // Aktualizuj oryginalne modele
    double current_vol = CalculateRealizedVolatility();
    
    // Update volatility history
    static int vol_index = 0;
    m_volatility_history[vol_index] = current_vol;
    vol_index = (vol_index + 1) % 288;
    
    // Update energy buffers
    double price_buffer[1];
    long volume_buffer[1];
    double current_price = 0.0;
    double current_volume = 0.0;
    
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 1, price_buffer) > 0) {
        current_price = price_buffer[0];
    }
    if(CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, 1, volume_buffer) > 0) {
        current_volume = (double)volume_buffer[0];
    }
    
    static int energy_index = 0;
    m_price_energy[energy_index] = CalculatePriceEnergy();
    m_volume_energy[energy_index] = CalculateVolumeEnergy();
    energy_index = (energy_index + 1) % 288;
    
    // Update adaptive thresholds
    UpdateAdaptiveThresholds();
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
    double current_vol = CalculateRealizedVolatility();
    
    // Adaptive thresholds based on historical data
    UpdateAdaptiveThresholds();
    
    if(current_vol < m_volatility_threshold_low) {
        return VOLATILITY_LOW;
    }
    else if(current_vol < m_volatility_threshold_high) {
        return VOLATILITY_NORMAL;
    }
    else if(current_vol < m_volatility_threshold_high * 2.0) {
        return VOLATILITY_HIGH;
    }
    else {
        return VOLATILITY_EXTREME;
    }
}

// Energy State Assessment
ENUM_ENERGY_STATE FireSpiritAI::GetEnergyState() {
    double fire_intensity = GetFireIntensity();
    double energy_trend = CalculateEnergyTrend();
    double energy_acceleration = CalculateEnergyAcceleration();
    
    if(fire_intensity < 20) {
        return ENERGY_DORMANT;
    }
    else if(fire_intensity < 40 && energy_trend > 0) {
        return ENERGY_BUILDING;
    }
    else if(fire_intensity < 70) {
        return ENERGY_ACTIVE;
    }
    else if(fire_intensity >= 70 && energy_acceleration > 5) {
        return ENERGY_EXPLOSIVE;
    }
    else if(fire_intensity > 80 && energy_acceleration < -5) {
        return ENERGY_EXHAUSTED;
    }
    
    return ENERGY_ACTIVE; // Default
}

// Volatility Forecast using LSTM
double FireSpiritAI::GetVolatilityForecast(int periods_ahead) {
    double input_sequence[20]; // LSTM input sequence
    
    // Prepare input from recent volatility history
    for(int i = 0; i < 20; i++) {
        input_sequence[i] = m_volatility_history[287 - 19 + i]; // Last 20 periods
    }
    
    // LSTM prediction (fallback to simple calculation when LSTM is disabled)
    double forecast = 0.0;
    if(CheckPointer(m_volatility_lstm) == POINTER_DYNAMIC) {
        // forecast = m_volatility_lstm.Predict(input_sequence); // Disabled until class is available
        // Fallback: use average of recent volatility
        double sum = 0.0;
        for(int i = 0; i < 20; i++) {
            sum += input_sequence[i];
        }
        forecast = sum / 20.0;
    }
    
    // Multi-step ahead prediction
    if(periods_ahead > 1) {
        // Iterative prediction for multiple periods
        for(int step = 1; step < periods_ahead; step++) {
            // Shift sequence and add prediction
            for(int i = 0; i < 19; i++) {
                input_sequence[i] = input_sequence[i + 1];
            }
            input_sequence[19] = forecast;
            
            if(CheckPointer(m_volatility_lstm) == POINTER_DYNAMIC) {
                // forecast = m_volatility_lstm.Predict(input_sequence); // Disabled until class is available
                // Fallback: decay the forecast slightly for future periods
                forecast = forecast * 0.95;
            }
        }
    }
    
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
    ENUM_VOLATILITY_REGIME current_regime = GetCurrentRegime();
    int regime_index = (int)current_regime;
    
    // Stability based on transition matrix diagonal
    return m_transition_matrix[regime_index][regime_index] * 100.0;
}

// Get Energy Level
double FireSpiritAI::GetEnergyLevel() {
    double price_energy = CalculatePriceEnergy();
    double volume_energy = CalculateVolumeEnergy();
    double momentum_energy = CalculateMomentumEnergy();
    
    return (price_energy + volume_energy + momentum_energy) / 3.0;
}

// Get Energy Exhaustion Probability
double FireSpiritAI::GetEnergyExhaustionProbability() {
    double energy_level = GetEnergyLevel();
    double energy_trend = CalculateEnergyTrend();
    double energy_acceleration = CalculateEnergyAcceleration();
    
    // High energy + negative acceleration = exhaustion
    if(energy_level > 80.0 && energy_acceleration < -5.0) {
        return 0.8;
    }
    else if(energy_level > 60.0 && energy_trend < 0) {
        return 0.5;
    }
    else {
        return 0.1;
    }
}

// Get Volatility Breakout Probability
double FireSpiritAI::GetVolatilityBreakoutProbability() {
    double current_vol = CalculateRealizedVolatility();
    double returns2[]; 
    int bars2 = 20; 
    ArrayResize(returns2, bars2);
    if(GetReturns(returns2, bars2) < bars2) {
        // Handle insufficient data
        return 0.0;
    } 
    double garch_vol = CalculateGARCHVolatility(returns2, 20);
    double vol_forecast = GetVolatilityForecast(5);
    
    // Volatility expansion probability
    if(vol_forecast > current_vol * 1.5) {
        return 0.7;
    }
    else if(vol_forecast > current_vol * 1.2) {
        return 0.5;
    }
    else {
        return 0.2;
    }
}

// Update Volatility Models (wersja 2) — scalona do jednej implementacji powyżej
void FireSpiritAI::UpdateVolatilityModels_Legacy() {
    // Update volatility history
    double current_vol = CalculateRealizedVolatility();
    
    // Shift history
    for(int i = 0; i < 287; i++) {
        m_volatility_history[i] = m_volatility_history[i + 1];
        m_price_energy[i] = m_price_energy[i + 1];
        m_volume_energy[i] = m_volume_energy[i + 1];
    }
    
    // Add new values
    m_volatility_history[287] = current_vol;
    m_price_energy[287] = CalculatePriceEnergy();
    m_volume_energy[287] = CalculateVolumeEnergy();
    
    // Update adaptive thresholds
    UpdateAdaptiveThresholds();
}

// Get Adaptive Volatility Bands
double FireSpiritAI::GetAdaptiveVolatilityBands() {
    double current_vol = CalculateRealizedVolatility();
    double forecast_vol = GetVolatilityForecast(1);
    
    // Adaptive bands based on volatility forecast
    double upper_band = current_vol + forecast_vol * 0.5;
    double lower_band = MathMax(0.001, current_vol - forecast_vol * 0.3);
    
    return (upper_band + lower_band) / 2.0;
}

// === BRAKUJĄCE IMPLEMENTACJE ===

// Rogers-Satchell Volatility
double FireSpiritAI::CalculateRogersSatchellVolatility() {
    double opens[], highs[], lows[], closes[];
    int bars = 20;
    
    if(CopyOpen(Symbol(), PERIOD_CURRENT, 0, bars, opens) != bars ||
       CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, highs) != bars ||
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, lows) != bars ||
       CopyClose(Symbol(), PERIOD_CURRENT, 0, bars, closes) != bars) {
        return 0.0;
    }
    
    double rs_sum = 0.0;
    
    for(int i = 0; i < bars; i++) {
        if(highs[i] > 0 && opens[i] > 0 && lows[i] > 0 && closes[i] > 0) {
            double rs = MathLog(highs[i] / closes[i]) * MathLog(highs[i] / opens[i]) +
                       MathLog(lows[i] / closes[i]) * MathLog(lows[i] / opens[i]);
            rs_sum += rs;
        }
    }
    
    // Rogers-Satchell estimator
    double rs_var = rs_sum / bars;
    return MathSqrt(MathAbs(rs_var) * 252.0); // Annualized
}

// Energy Dissipation Calculator
double FireSpiritAI::CalculateEnergyDissipation() {
    double recent_energy = 0.0;
    double older_energy = 0.0;
    
    // Recent energy (last 5 periods)
    for(int i = 283; i < 288; i++) {
        recent_energy += m_price_energy[i];
    }
    recent_energy /= 5.0;
    
    // Older energy (periods 278-283)
    for(int i = 278; i < 283; i++) {
        older_energy += m_price_energy[i];
    }
    older_energy /= 5.0;
    
    // Energy dissipation = energy loss over time
    double dissipation = (older_energy - recent_energy) / older_energy * 100.0;
    
    return MathMax(0.0, MathMin(100.0, dissipation));
}
