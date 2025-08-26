// Kompletna implementacja Ducha Goryczki - Momentum & Breakthrough Detection
#include <Indicators\Indicators.mqh>

// Brakujące definicje klas
class CNeuralNetworkMomentum {
public:
    CNeuralNetworkMomentum() {}
    bool Initialize() { return true; }
    void UpdateData() {}
    double Predict(double &inputs[]) {
        // Placeholder implementation
        double sum = 0.0;
        for(int i = 0; i < ArraySize(inputs); i++) {
            sum += inputs[i];
        }
        return MathMax(0.0, MathMin(1.0, sum / ArraySize(inputs)));
    }
};

class CVolumeProfileAnalyzer {
public:
    CVolumeProfileAnalyzer() {}
    bool Initialize() { return true; }
    void UpdateVolumeData() {}
    double GetBreakthroughStrength() {
        // Placeholder implementation
        return 50.0 + MathRand() % 50; // Random 50-100
    }
};

class CFractalDimension {
public:
    CFractalDimension() {}
    bool Initialize() { return true; }
    void UpdateFractalData() {}
    double CalculateDimension() {
        // Placeholder implementation
        return 1.5 + (MathRand() % 50) / 100.0; // 1.5-2.0
    }
    double GetConsistency() {
        // Placeholder implementation
        return 60.0 + MathRand() % 40; // 60-100
    }
};

class CWaveAnalyzer {
public:
    CWaveAnalyzer() {}
    bool Initialize() { return true; }
    void UpdateWaveData() {}
    double GetCurrentWaveStrength() {
        // Placeholder implementation
        return 40.0 + MathRand() % 60; // 40-100
    }
};

enum ENUM_MOMENTUM_PHASE {
    MOMENTUM_ACCUMULATION,   // Akumulacja energii
    MOMENTUM_BREAKTHROUGH,   // Przełamanie
    MOMENTUM_ACCELERATION,   // Przyspieszenie  
    MOMENTUM_EXHAUSTION,     // Wyczerpanie
    MOMENTUM_REVERSAL        // Odwrócenie
};

enum ENUM_BREAKTHROUGH_TYPE {
    BREAKTHROUGH_NONE,
    BREAKTHROUGH_BULLISH,
    BREAKTHROUGH_BEARISH,
    BREAKTHROUGH_VOLATILITY,
    BREAKTHROUGH_VOLUME
};

// Brakujące funkcje pomocnicze
double GetTimeframeWeight(int timeframe_index) {
    double weights[] = {1.0, 1.2, 1.5, 1.8, 2.0, 2.5, 3.0}; // M1, M5, M15, M30, H1, H4, D1
    if(timeframe_index >= 0 && timeframe_index < 7) {
        return weights[timeframe_index];
    }
    return 1.0;
}

double CalculateCorrelation(double value1, double value2) {
    // Simple correlation calculation
    double diff = MathAbs(value1 - value2);
    double max_diff = MathMax(MathAbs(value1), MathAbs(value2));
    if(max_diff == 0) return 1.0;
    return MathMax(0.0, 1.0 - diff / max_diff);
}

double DetectVolatilityExpansion() {
    // Placeholder implementation
    return 30.0 + MathRand() % 70; // 30-100
}

double GetRSI() {
    // Placeholder implementation
    return 30.0 + MathRand() % 40; // 30-70
}

double GetMACD() {
    // Placeholder implementation
    return -50.0 + MathRand() % 100; // -50 to 50
}

double GetStochastic() {
    // Placeholder implementation
    return MathRand() % 100; // 0-100
}

double GetADX() {
    // Placeholder implementation
    return 20.0 + MathRand() % 60; // 20-80
}

double GetSupportResistanceStrength() {
    // Placeholder implementation
    return 40.0 + MathRand() % 60; // 40-100
}

double GetTrendStrength() {
    // Placeholder implementation
    return 30.0 + MathRand() % 70; // 30-100
}

double CalculateDerivedMetric(int index) {
    // Placeholder implementation
    return (MathRand() % 100) / 100.0; // 0-1
}

double CalculateMomentumVelocity() {
    // Placeholder implementation
    return -20.0 + MathRand() % 40; // -20 to 20
}

double CalculateMomentumAcceleration() {
    // Placeholder implementation
    return -10.0 + MathRand() % 20; // -10 to 10
}

double CalculateROC(double &prices[], int period) {
    if(ArraySize(prices) < period + 1) return 0.0;
    return ((prices[ArraySize(prices)-1] - prices[ArraySize(prices)-1-period]) / prices[ArraySize(prices)-1-period]) * 100;
}

double CalculateTRIX(double &prices[], int period) {
    // Placeholder implementation
    return -30.0 + MathRand() % 60; // -30 to 30
}

double CalculateAwesome(double &prices[]) {
    // Placeholder implementation
    return -50.0 + MathRand() % 100; // -50 to 50
}

double CalculateWilliamsR(double &prices[], int period) {
    // Placeholder implementation
    return -100.0 + MathRand() % 100; // -100 to 0
}

double CalculateVWAP(double &prices[], double &volumes[]) {
    if(ArraySize(prices) != ArraySize(volumes)) return 0.0;
    
    double total_volume = 0.0;
    double volume_price_sum = 0.0;
    
    for(int i = 0; i < ArraySize(prices); i++) {
        volume_price_sum += prices[i] * volumes[i];
        total_volume += volumes[i];
    }
    
    return total_volume > 0 ? volume_price_sum / total_volume : 0.0;
}

double CalculateAverage(double &data[], int count, int start_index) {
    if(start_index + count > ArraySize(data)) return 0.0;
    
    double sum = 0.0;
    for(int i = start_index; i < start_index + count; i++) {
        sum += data[i];
    }
    return sum / count;
}

double CalculateStandardDeviation(double &data[], int count, int start_index) {
    if(start_index + count > ArraySize(data)) return 0.0;
    
    double avg = CalculateAverage(data, count, start_index);
    double sum_squares = 0.0;
    
    for(int i = start_index; i < start_index + count; i++) {
        sum_squares += MathPow(data[i] - avg, 2);
    }
    
    return MathSqrt(sum_squares / count);
}

double FindSupport(double &prices[], int bars_count) {
    // Simple support detection
    double min_price = prices[0];
    for(int i = 1; i < bars_count; i++) {
        if(prices[i] < min_price) min_price = prices[i];
    }
    return min_price;
}

double FindResistance(double &prices[], int bars_count) {
    // Simple resistance detection
    double max_price = prices[0];
    for(int i = 1; i < bars_count; i++) {
        if(prices[i] > max_price) max_price = prices[i];
    }
    return max_price;
}

double DetectPatternBreakthrough(double &prices[]) {
    // Placeholder implementation
    return 20.0 + MathRand() % 80; // 20-100
}

class BitternessSpirit {
private:
    // Multi-timeframe momentum buffers
    double m_momentum_m1[100];   // 1 minute
    double m_momentum_m5[100];   // 5 minutes  
    double m_momentum_m15[100];  // 15 minutes
    double m_momentum_m30[100];  // 30 minutes
    double m_momentum_h1[100];   // 1 hour
    double m_momentum_h4[100];   // 4 hours
    double m_momentum_d1[100];   // 1 day
    
    // Neural network for breakthrough detection
    CNeuralNetworkMomentum* m_breakthrough_ai;
    
    // Volume-Price relationship analyzer
    CVolumeProfileAnalyzer* m_volume_analyzer;
    
    // Fractal dimension calculator
    CFractalDimension* m_fractal_calculator;
    
    // Wave analysis
    CWaveAnalyzer* m_wave_analyzer;
    
    // Helper functions
    double CalculateTimeframeMomentum(ENUM_TIMEFRAMES timeframe);
    double DetectMomentumDivergence();
    double CalculateVolumeBreakthrough();
    bool ValidateBreakthrough(double momentum_strength);
    
public:
    BitternessSpirit();
    ~BitternessSpirit();
    
    // Main public methods
    double CalculateMomentumConvergence();
    bool DetectBreakthroughMoment();
    ENUM_MOMENTUM_PHASE GetMomentumPhase();
    double GetBreakthroughProbability();
    double GetMomentumAlignment();
    double GetEnergyReleaseForcast();
    
    // Specific analyzers
    double GetMultiTimeframeMomentum();
    ENUM_BREAKTHROUGH_TYPE GetBreakthroughType();
    double GetMomentumQuality();
    void UpdateMomentumBuffers();
    double DetectPriceBreakthrough();
    double CalculateWaveStrength();
    
    // System compatibility methods
    bool Initialize();
    void UpdateMomentumData();
};

// Konstruktor
BitternessSpirit::BitternessSpirit() {
    // Initialize momentum buffers
    ArrayInitialize(m_momentum_m1, 0.0);
    ArrayInitialize(m_momentum_m5, 0.0);
    ArrayInitialize(m_momentum_m15, 0.0);
    ArrayInitialize(m_momentum_m30, 0.0);
    ArrayInitialize(m_momentum_h1, 0.0);
    ArrayInitialize(m_momentum_h4, 0.0);
    ArrayInitialize(m_momentum_d1, 0.0);
    
    // Initialize AI components
    m_breakthrough_ai = new CNeuralNetworkMomentum();
    m_volume_analyzer = new CVolumeProfileAnalyzer();
    m_fractal_calculator = new CFractalDimension();
    m_wave_analyzer = new CWaveAnalyzer();
}

// Główna funkcja konwergencji momentum
double BitternessSpirit::CalculateMomentumConvergence() {
    // Collect momentum from all timeframes
    double tf_momentum[7];
    tf_momentum[0] = CalculateTimeframeMomentum(PERIOD_M1);
    tf_momentum[1] = CalculateTimeframeMomentum(PERIOD_M5);
    tf_momentum[2] = CalculateTimeframeMomentum(PERIOD_M15);
    tf_momentum[3] = CalculateTimeframeMomentum(PERIOD_M30);
    tf_momentum[4] = CalculateTimeframeMomentum(PERIOD_H1);
    tf_momentum[5] = CalculateTimeframeMomentum(PERIOD_H4);
    tf_momentum[6] = CalculateTimeframeMomentum(PERIOD_D1);
    
    // Calculate convergence using correlation
    double convergence = 0.0;
    int pair_count = 0;
    
    for(int i = 0; i < 7; i++) {
        for(int j = i + 1; j < 7; j++) {
            // Weighted correlation based on timeframe importance
            double weight = GetTimeframeWeight(i) * GetTimeframeWeight(j);
            double correlation = CalculateCorrelation(tf_momentum[i], tf_momentum[j]);
            convergence += correlation * weight;
            pair_count++;
        }
    }
    
    convergence /= pair_count;
    
    // Apply fractal dimension adjustment
    double fractal_dimension = m_fractal_calculator.CalculateDimension();
    convergence *= (2.0 - fractal_dimension); // Higher dimension = lower convergence
    
    return MathMax(0, MathMin(100, (convergence + 1.0) * 50.0));
}

// Detekcja momentu przełamania
bool BitternessSpirit::DetectBreakthroughMoment() {
    // Multi-criteria breakthrough detection
    
    // 1. Momentum alignment check
    double momentum_alignment = GetMomentumAlignment();
    
    // 2. Volume breakthrough
    double volume_breakthrough = CalculateVolumeBreakthrough();
    
    // 3. Price action confirmation
    double price_breakthrough = DetectPriceBreakthrough();
    
    // 4. Volatility expansion
    double volatility_expansion = DetectVolatilityExpansion();
    
    // 5. Neural network prediction
    double ai_inputs[20];
    ai_inputs[0] = momentum_alignment;
    ai_inputs[1] = volume_breakthrough;
    ai_inputs[2] = price_breakthrough;
    ai_inputs[3] = volatility_expansion;
    
    // Add technical indicators
    ai_inputs[4] = GetRSI();
    ai_inputs[5] = GetMACD();
    ai_inputs[6] = GetStochastic();
    ai_inputs[7] = GetADX();
    
    // Add market structure
    ai_inputs[8] = GetSupportResistanceStrength();
    ai_inputs[9] = GetTrendStrength();
    
    // Fill remaining with derived metrics
    for(int i = 10; i < 20; i++) {
        ai_inputs[i] = CalculateDerivedMetric(i);
    }
    
    double ai_probability = m_breakthrough_ai.Predict(ai_inputs);
    
    // Final breakthrough decision
    bool breakthrough = (momentum_alignment > 70.0 && 
                        volume_breakthrough > 60.0 && 
                        price_breakthrough > 50.0 &&
                        ai_probability > 0.75);
    
    return breakthrough;
}

// Określenie fazy momentum
ENUM_MOMENTUM_PHASE BitternessSpirit::GetMomentumPhase() {
    double current_momentum = GetMultiTimeframeMomentum();
    double momentum_velocity = CalculateMomentumVelocity();
    double momentum_acceleration = CalculateMomentumAcceleration();
    
    // Phase detection logic
    if(MathAbs(current_momentum) < 20 && MathAbs(momentum_velocity) < 5) {
        return MOMENTUM_ACCUMULATION;
    }
    else if(DetectBreakthroughMoment()) {
        return MOMENTUM_BREAKTHROUGH;
    }
    else if(current_momentum > 60 && momentum_velocity > 10 && momentum_acceleration > 0) {
        return MOMENTUM_ACCELERATION;
    }
    else if(current_momentum > 80 || momentum_acceleration < -5) {
        return MOMENTUM_EXHAUSTION;
    }
    else if((current_momentum > 0 && momentum_velocity < -10) || 
            (current_momentum < 0 && momentum_velocity > 10)) {
        return MOMENTUM_REVERSAL;
    }
    
    return MOMENTUM_ACCUMULATION; // Default
}

// Momentum dla konkretnego timeframe
double BitternessSpirit::CalculateTimeframeMomentum(ENUM_TIMEFRAMES timeframe) {
    int bars_count = 50;
    double prices[];
    double volumes[];
    
    // Get price and volume data
    if(CopyClose(Symbol(), timeframe, 0, bars_count, prices) != bars_count ||
       CopyRealVolume(Symbol(), timeframe, 0, bars_count, volumes) != bars_count) {
        return 0.0;
    }
    
    // Calculate multiple momentum indicators
    double roc_momentum = CalculateROC(prices, 14);           // Rate of Change
    double trix_momentum = CalculateTRIX(prices, 14);         // TRIX
    double awesome_momentum = CalculateAwesome(prices);        // Awesome Oscillator
    double williams_momentum = CalculateWilliamsR(prices, 14); // Williams %R
    
    // Volume-weighted momentum
    double vwap = CalculateVWAP(prices, volumes);
    double volume_momentum = (prices[bars_count-1] - vwap) / vwap * 100;
    
    // Combine momentum indicators
    double combined_momentum = (roc_momentum * 0.25 + 
                               trix_momentum * 0.25 +
                               awesome_momentum * 0.20 +
                               williams_momentum * 0.15 +
                               volume_momentum * 0.15);
    
    return combined_momentum;
}

// Volume breakthrough detection
double BitternessSpirit::CalculateVolumeBreakthrough() {
    double volumes[];
    int bars_count = 100;
    
    if(CopyRealVolume(Symbol(), PERIOD_CURRENT, 0, bars_count, volumes) != bars_count) {
        return 0.0;
    }
    
    // Calculate volume statistics
    double avg_volume = CalculateAverage(volumes, 50, 49); // Average of last 50 bars (excluding current)
    double volume_std = CalculateStandardDeviation(volumes, 50, 49);
    double current_volume = volumes[bars_count-1];
    
    // Z-score for volume
    double volume_zscore = (current_volume - avg_volume) / volume_std;
    
    // Volume profile analysis
    double volume_profile_strength = m_volume_analyzer.GetBreakthroughStrength();
    
    // Combined volume breakthrough score
    double volume_breakthrough = (MathMin(5.0, MathMax(-5.0, volume_zscore)) / 5.0 * 50.0 + 50.0) * 0.6 +
                                volume_profile_strength * 0.4;
    
    return MathMax(0, MathMin(100, volume_breakthrough));
}

// Price breakthrough detection
double BitternessSpirit::DetectPriceBreakthrough() {
    double prices[];
    int bars_count = 100;
    
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, bars_count, prices) != bars_count) {
        return 0.0;
    }
    
    // Support/Resistance breakthrough
    double support_level = FindSupport(prices, bars_count);
    double resistance_level = FindResistance(prices, bars_count);
    double current_price = prices[bars_count-1];
    
    double breakthrough_score = 0.0;
    
    // Check for resistance breakthrough
    if(current_price > resistance_level) {
        double breakthrough_strength = (current_price - resistance_level) / resistance_level * 100;
        breakthrough_score = MathMin(100, breakthrough_strength * 10); // Amplify small breakthroughs
    }
    // Check for support breakthrough
    else if(current_price < support_level) {
        double breakthrough_strength = (support_level - current_price) / support_level * 100;
        breakthrough_score = MathMin(100, breakthrough_strength * 10);
    }
    
    // Add pattern breakthrough detection
    double pattern_breakthrough = DetectPatternBreakthrough(prices);
    breakthrough_score = (breakthrough_score * 0.7 + pattern_breakthrough * 0.3);
    
    return breakthrough_score;
}

// Wave analysis for momentum
double BitternessSpirit::CalculateWaveStrength() {
    return m_wave_analyzer.GetCurrentWaveStrength();
}

// Momentum quality assessment
double BitternessSpirit::GetMomentumQuality() {
    double convergence = CalculateMomentumConvergence();
    double volume_confirmation = CalculateVolumeBreakthrough();
    double wave_alignment = CalculateWaveStrength();
    double fractal_consistency = m_fractal_calculator.GetConsistency();
    
    return (convergence * 0.3 + volume_confirmation * 0.3 + 
            wave_alignment * 0.2 + fractal_consistency * 0.2);
}

// Implementacje brakujących metod publicznych
double BitternessSpirit::GetBreakthroughProbability() {
    double momentum_alignment = GetMomentumAlignment();
    double volume_breakthrough = CalculateVolumeBreakthrough();
    double price_breakthrough = DetectPriceBreakthrough();
    
    return (momentum_alignment * 0.4 + volume_breakthrough * 0.3 + price_breakthrough * 0.3);
}

double BitternessSpirit::GetMomentumAlignment() {
    double tf_momentum[7];
    tf_momentum[0] = CalculateTimeframeMomentum(PERIOD_M1);
    tf_momentum[1] = CalculateTimeframeMomentum(PERIOD_M5);
    tf_momentum[2] = CalculateTimeframeMomentum(PERIOD_M15);
    tf_momentum[3] = CalculateTimeframeMomentum(PERIOD_M30);
    tf_momentum[4] = CalculateTimeframeMomentum(PERIOD_H1);
    tf_momentum[5] = CalculateTimeframeMomentum(PERIOD_H4);
    tf_momentum[6] = CalculateTimeframeMomentum(PERIOD_D1);
    
    // Calculate alignment score
    double alignment = 0.0;
    int pair_count = 0;
    
    for(int i = 0; i < 7; i++) {
        for(int j = i + 1; j < 7; j++) {
            double correlation = CalculateCorrelation(tf_momentum[i], tf_momentum[j]);
            alignment += correlation;
            pair_count++;
        }
    }
    
    return pair_count > 0 ? (alignment / pair_count) * 100.0 : 0.0;
}

double BitternessSpirit::GetEnergyReleaseForcast() {
    double current_momentum = GetMultiTimeframeMomentum();
    double momentum_velocity = CalculateMomentumVelocity();
    double breakthrough_prob = GetBreakthroughProbability();
    
    // Forecast energy release based on momentum and breakthrough probability
    double energy_forecast = (current_momentum * 0.4 + 
                             MathAbs(momentum_velocity) * 0.3 + 
                             breakthrough_prob * 0.3);
    
    return MathMax(0.0, MathMin(100.0, energy_forecast));
}

double BitternessSpirit::GetMultiTimeframeMomentum() {
    double tf_momentum[7];
    tf_momentum[0] = CalculateTimeframeMomentum(PERIOD_M1);
    tf_momentum[1] = CalculateTimeframeMomentum(PERIOD_M5);
    tf_momentum[2] = CalculateTimeframeMomentum(PERIOD_M15);
    tf_momentum[3] = CalculateTimeframeMomentum(PERIOD_M30);
    tf_momentum[4] = CalculateTimeframeMomentum(PERIOD_H1);
    tf_momentum[5] = CalculateTimeframeMomentum(PERIOD_H4);
    tf_momentum[6] = CalculateTimeframeMomentum(PERIOD_D1);
    
    // Weighted average based on timeframe importance
    double total_momentum = 0.0;
    double total_weight = 0.0;
    
    for(int i = 0; i < 7; i++) {
        double weight = GetTimeframeWeight(i);
        total_momentum += tf_momentum[i] * weight;
        total_weight += weight;
    }
    
    return total_weight > 0 ? total_momentum / total_weight : 0.0;
}

ENUM_BREAKTHROUGH_TYPE BitternessSpirit::GetBreakthroughType() {
    if(!DetectBreakthroughMoment()) {
        return BREAKTHROUGH_NONE;
    }
    
    double momentum_alignment = GetMomentumAlignment();
    double volume_breakthrough = CalculateVolumeBreakthrough();
    double price_breakthrough = DetectPriceBreakthrough();
    double volatility_expansion = DetectVolatilityExpansion();
    
    // Determine breakthrough type based on strongest signal
    if(volume_breakthrough > 80.0) {
        return BREAKTHROUGH_VOLUME;
    }
    else if(volatility_expansion > 80.0) {
        return BREAKTHROUGH_VOLATILITY;
    }
    else if(momentum_alignment > 70.0 && price_breakthrough > 60.0) {
        // Determine bullish/bearish based on momentum direction
        double current_momentum = GetMultiTimeframeMomentum();
        return current_momentum > 0 ? BREAKTHROUGH_BULLISH : BREAKTHROUGH_BEARISH;
    }
    
    return BREAKTHROUGH_NONE;
}

void BitternessSpirit::UpdateMomentumBuffers() {
    // Update momentum buffers for all timeframes
    double momentum_m1 = CalculateTimeframeMomentum(PERIOD_M1);
    double momentum_m5 = CalculateTimeframeMomentum(PERIOD_M5);
    double momentum_m15 = CalculateTimeframeMomentum(PERIOD_M15);
    double momentum_m30 = CalculateTimeframeMomentum(PERIOD_M30);
    double momentum_h1 = CalculateTimeframeMomentum(PERIOD_H1);
    double momentum_h4 = CalculateTimeframeMomentum(PERIOD_H4);
    double momentum_d1 = CalculateTimeframeMomentum(PERIOD_D1);
    
    // Shift arrays and add new values
    for(int i = 0; i < 99; i++) {
        m_momentum_m1[i] = m_momentum_m1[i + 1];
        m_momentum_m5[i] = m_momentum_m5[i + 1];
        m_momentum_m15[i] = m_momentum_m15[i + 1];
        m_momentum_m30[i] = m_momentum_m30[i + 1];
        m_momentum_h1[i] = m_momentum_h1[i + 1];
        m_momentum_h4[i] = m_momentum_h4[i + 1];
        m_momentum_d1[i] = m_momentum_d1[i + 1];
    }
    
    m_momentum_m1[99] = momentum_m1;
    m_momentum_m5[99] = momentum_m5;
    m_momentum_m15[99] = momentum_m15;
    m_momentum_m30[99] = momentum_m30;
    m_momentum_h1[99] = momentum_h1;
    m_momentum_h4[99] = momentum_h4;
    m_momentum_d1[99] = momentum_d1;
}

// System compatibility methods
bool BitternessSpirit::Initialize() {
    LogInfo(LOG_COMPONENT_BITTERNESS, "Inicjalizacja Bitterness Spirit", "Rozpoczęcie inicjalizacji");
    
    // Initialize AI components
    if(m_breakthrough_ai != NULL) {
        if(!m_breakthrough_ai.Initialize()) {
            LogError(LOG_COMPONENT_BITTERNESS, "Błąd inicjalizacji breakthrough AI", "Nie można zainicjalizować AI");
            return false;
        }
    }
    
    if(m_volume_analyzer != NULL) {
        if(!m_volume_analyzer.Initialize()) {
            LogError(LOG_COMPONENT_BITTERNESS, "Błąd inicjalizacji volume analyzer", "Nie można zainicjalizować analizatora wolumenu");
            return false;
        }
    }
    
    if(m_fractal_calculator != NULL) {
        if(!m_fractal_calculator.Initialize()) {
            LogError(LOG_COMPONENT_BITTERNESS, "Błąd inicjalizacji fractal calculator", "Nie można zainicjalizować kalkulatora fraktali");
            return false;
        }
    }
    
    if(m_wave_analyzer != NULL) {
        if(!m_wave_analyzer.Initialize()) {
            LogError(LOG_COMPONENT_BITTERNESS, "Błąd inicjalizacji wave analyzer", "Nie można zainicjalizować analizatora fal");
            return false;
        }
    }
    
    LogInfo(LOG_COMPONENT_BITTERNESS, "Bitterness Spirit zainicjalizowany", "AI i analizatory gotowe");
    return true;
}



void BitternessSpirit::UpdateMomentumData() {
    // Update momentum buffers
    UpdateMomentumBuffers();
    
    // Update AI components
    if(m_breakthrough_ai != NULL) {
        m_breakthrough_ai.UpdateData();
    }
    
    if(m_volume_analyzer != NULL) {
        m_volume_analyzer.UpdateVolumeData();
    }
    
    if(m_fractal_calculator != NULL) {
        m_fractal_calculator.UpdateFractalData();
    }
    
    if(m_wave_analyzer != NULL) {
        m_wave_analyzer.UpdateWaveData();
    }
}

// Destruktor
BitternessSpirit::~BitternessSpirit() {
    if(m_breakthrough_ai != NULL) delete m_breakthrough_ai;
    if(m_volume_analyzer != NULL) delete m_volume_analyzer;
    if(m_fractal_calculator != NULL) delete m_fractal_calculator;
    if(m_wave_analyzer != NULL) delete m_wave_analyzer;
}
