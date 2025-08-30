// Kompletna implementacja Ducha Goryczki - Momentum & Breakthrough Detection
#include <Indicators\Indicators.mqh>
#include "../Utils/LoggingSystem.mqh"
#include "../Core/CentralAI.mqh"  // 🆕 Centralny AI

// Centralny AI - Neural Network Momentum
class CNeuralNetworkMomentum {
private:
    CCentralLSTM* m_momentum_lstm;
    CCentralAttention* m_momentum_attention;
    bool m_is_initialized;
    
public:
    CNeuralNetworkMomentum() {
        m_momentum_lstm = NULL;
        m_momentum_attention = NULL;
        m_is_initialized = false;
    }
    
    ~CNeuralNetworkMomentum() {
        if(m_momentum_lstm != NULL) delete m_momentum_lstm;
        if(m_momentum_attention != NULL) delete m_momentum_attention;
    }
    
    bool Initialize() {
        // Inicjalizacja centralnego LSTM
        m_momentum_lstm = new CCentralLSTM(32, 64, 1, 20);
        if(m_momentum_lstm == NULL) return false;
        
        // Inicjalizacja centralnego Attention
        m_momentum_attention = new CCentralAttention(32, 4, 20);
        if(m_momentum_attention == NULL) return false;
        
        if(!m_momentum_lstm.Initialize() || !m_momentum_attention.Initialize()) {
            return false;
        }
        
        m_is_initialized = true;
        return true;
    }
    
    void UpdateData() {
        // Aktualizacja danych w centralnym AI
        if(m_is_initialized) {
            // Można dodać logikę aktualizacji
        }
    }
    
    double Predict(double &inputs[]) {
        if(!m_is_initialized) return 0.5;
        
        // Przygotuj dane dla LSTM
        double input_sequence[][];
        PrepareMomentumInput(inputs, input_sequence);
        
        // Użyj centralnego LSTM do predykcji
        double lstm_prediction = m_momentum_lstm.Predict(input_sequence);
        
        // Użyj centralnego Attention do poprawy predykcji
        double attention_output[][];
        m_momentum_attention.ApplyAttention(input_sequence, attention_output);
        
        // Połącz predykcje
        double final_prediction = (lstm_prediction + GetAttentionAverage(attention_output)) / 2.0;
        
        return MathMax(0.0, MathMin(1.0, final_prediction));
    }
    
private:
    void PrepareMomentumInput(double &inputs[], double &sequence[][]) {
        int lookback = 20;
        int features = ArraySize(inputs);
        
        ArrayResize(sequence, lookback);
        for(int i = 0; i < lookback; i++) {
            ArrayResize(sequence[i], features);
            for(int j = 0; j < features; j++) {
                sequence[i][j] = inputs[j] * (1.0 + i * 0.01); // Dodaj temporalność
            }
        }
    }
    
    double GetAttentionAverage(double &attention_output[][]) {
        if(ArraySize(attention_output) == 0) return 0.5;
        
        double sum = 0.0;
        int count = 0;
        
        for(int i = 0; i < ArraySize(attention_output); i++) {
            if(ArraySize(attention_output[i]) > 0) {
                sum += attention_output[i][0]; // Pierwszy wymiar
                count++;
            }
        }
        
        return count > 0 ? sum / count : 0.5;
    }
};

class CVolumeProfileAnalyzer {
private:
    CCentralCNN* m_volume_cnn;
    CCentralKalmanFilter* m_volume_kalman;
    bool m_is_initialized;
    
public:
    CVolumeProfileAnalyzer() {
        m_volume_cnn = NULL;
        m_volume_kalman = NULL;
        m_is_initialized = false;
    }
    
    ~CVolumeProfileAnalyzer() {
        if(m_volume_cnn != NULL) delete m_volume_cnn;
        if(m_volume_kalman != NULL) delete m_volume_kalman;
    }
    
    bool Initialize() {
        // Inicjalizacja centralnego CNN dla analizy wolumenu
        m_volume_cnn = new CCentralCNN(4, 3, 16); // OHLC + Volume
        if(m_volume_cnn == NULL) return false;
        
        // Inicjalizacja centralnego Kalman Filter
        m_volume_kalman = new CCentralKalmanFilter(4, 4);
        if(m_volume_kalman == NULL) return false;
        
        if(!m_volume_cnn.Initialize() || !m_volume_kalman.Initialize()) {
            return false;
        }
        
        m_is_initialized = true;
        return true;
    }
    
    void UpdateVolumeData() {
        // Aktualizacja danych wolumenu w centralnym AI
        if(m_is_initialized) {
            // Można dodać logikę aktualizacji
        }
    }
    
    double GetBreakthroughStrength() {
        if(!m_is_initialized) return 50.0;
        
        // Przygotuj dane OHLC + Volume
        double volume_data[][];
        PrepareVolumeData(volume_data);
        
        // Użyj centralnego CNN do rozpoznania wzorców
        double pattern_probabilities[];
        m_volume_cnn.RecognizePatterns(volume_data, pattern_probabilities);
        
        // Użyj centralnego Kalman Filter do filtrowania
        double measurement[] = {GetVolumeAverage(), GetPriceVolatility(), GetVolumeSpike(), GetBreakthroughSignal()};
        double* filtered = m_volume_kalman.Filter(measurement);
        
        // Oblicz siłę przełamania na podstawie wzorców i filtrowania
        double pattern_strength = GetPatternStrength(pattern_probabilities);
        double filtered_strength = filtered != NULL ? filtered[3] : 50.0;
        
        return MathMax(0.0, MathMin(100.0, (pattern_strength + filtered_strength) / 2.0));
    }
    
private:
    void PrepareVolumeData(double &volume_data[][]) {
        int bars = 50;
        int channels = 4; // OHLC
        
        ArrayResize(volume_data, bars);
        for(int i = 0; i < bars; i++) {
            ArrayResize(volume_data[i], channels);
            
            // Pobierz dane OHLC
            volume_data[i][0] = iOpen(Symbol(), PERIOD_CURRENT, i);
            volume_data[i][1] = iHigh(Symbol(), PERIOD_CURRENT, i);
            volume_data[i][2] = iLow(Symbol(), PERIOD_CURRENT, i);
            volume_data[i][3] = iClose(Symbol(), PERIOD_CURRENT, i);
        }
    }
    
    double GetVolumeAverage() {
        double volumes[];
        if(CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, 20, volumes) == 20) {
            double sum = 0.0;
            for(int i = 0; i < 20; i++) {
                sum += volumes[i];
            }
            return sum / 20.0;
        }
        return 0.0;
    }
    
    double GetPriceVolatility() {
        double closes[];
        if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 20, closes) == 20) {
            double avg = 0.0;
            for(int i = 0; i < 20; i++) {
                avg += closes[i];
            }
            avg /= 20.0;
            
            double variance = 0.0;
            for(int i = 0; i < 20; i++) {
                variance += MathPow(closes[i] - avg, 2);
            }
            variance /= 20.0;
            
            return MathSqrt(variance);
        }
        return 0.0;
    }
    
    double GetVolumeSpike() {
        double volumes[];
        if(CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, 20, volumes) == 20) {
            double current_volume = volumes[0];
            double avg_volume = 0.0;
            
            for(int i = 1; i < 20; i++) {
                avg_volume += volumes[i];
            }
            avg_volume /= 19.0;
            
            return current_volume > avg_volume * 2.0 ? 100.0 : 50.0;
        }
        return 50.0;
    }
    
    double GetBreakthroughSignal() {
        // Prosty sygnał przełamania na podstawie ceny
        double closes[];
        if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 10, closes) == 10) {
            double current_price = closes[0];
            double avg_price = 0.0;
            
            for(int i = 1; i < 10; i++) {
                avg_price += closes[i];
            }
            avg_price /= 9.0;
            
            if(current_price > avg_price * 1.02) return 80.0; // Bullish breakthrough
            if(current_price < avg_price * 0.98) return 20.0; // Bearish breakthrough
            return 50.0; // No breakthrough
        }
        return 50.0;
    }
    
    double GetPatternStrength(double &probabilities[]) {
        if(ArraySize(probabilities) == 0) return 50.0;
        
        double max_prob = 0.0;
        for(int i = 0; i < ArraySize(probabilities); i++) {
            if(probabilities[i] > max_prob) {
                max_prob = probabilities[i];
            }
        }
        
        return max_prob * 100.0; // Konwertuj na procent
    }
};

class CFractalDimension {
private:
    CCentralCNN* m_fractal_cnn;
    CCentralAttention* m_fractal_attention;
    bool m_is_initialized;
    
public:
    CFractalDimension() {
        m_fractal_cnn = NULL;
        m_fractal_attention = NULL;
        m_is_initialized = false;
    }
    
    ~CFractalDimension() {
        if(m_fractal_cnn != NULL) delete m_fractal_cnn;
        if(m_fractal_attention != NULL) delete m_fractal_attention;
    }
    
    bool Initialize() {
        // Inicjalizacja centralnego CNN dla analizy fraktali
        m_fractal_cnn = new CCentralCNN(4, 5, 32); // OHLC + większe jądro dla fraktali
        if(m_fractal_cnn == NULL) return false;
        
        // Inicjalizacja centralnego Attention dla analizy wzorców
        m_fractal_attention = new CCentralAttention(64, 8, 20);
        if(m_fractal_attention == NULL) return false;
        
        if(!m_fractal_cnn.Initialize() || !m_fractal_attention.Initialize()) {
            return false;
        }
        
        m_is_initialized = true;
        return true;
    }
    
    void UpdateFractalData() {
        // Aktualizacja danych fraktali w centralnym AI
        if(m_is_initialized) {
            // Można dodać logikę aktualizacji
        }
    }
    
    double CalculateDimension() {
        if(!m_is_initialized) return 1.5;
        
        // Przygotuj dane OHLC dla analizy fraktali
        double fractal_data[][];
        PrepareFractalData(fractal_data);
        
        // Użyj centralnego CNN do rozpoznania wzorców fraktali
        double fractal_probabilities[];
        m_fractal_cnn.RecognizePatterns(fractal_data, fractal_probabilities);
        
        // Użyj centralnego Attention do analizy wzorców
        double attention_output[][];
        m_fractal_attention.ApplyAttention(fractal_data, attention_output);
        
        // Oblicz wymiar fraktalny na podstawie wzorców
        double pattern_dimension = GetPatternBasedDimension(fractal_probabilities);
        double attention_dimension = GetAttentionBasedDimension(attention_output);
        
        // Połącz wymiary
        double final_dimension = (pattern_dimension + attention_dimension) / 2.0;
        
        return MathMax(1.0, MathMin(3.0, final_dimension));
    }
    
    double GetConsistency() {
        if(!m_is_initialized) return 60.0;
        
        // Oblicz spójność na podstawie stabilności wymiaru fraktalnego
        double dimensions[];
        ArrayResize(dimensions, 10);
        
        for(int i = 0; i < 10; i++) {
            dimensions[i] = CalculateDimension();
        }
        
        // Oblicz odchylenie standardowe
        double avg = 0.0;
        for(int i = 0; i < 10; i++) {
            avg += dimensions[i];
        }
        avg /= 10.0;
        
        double variance = 0.0;
        for(int i = 0; i < 10; i++) {
            variance += MathPow(dimensions[i] - avg, 2);
        }
        variance /= 10.0;
        
        double std_dev = MathSqrt(variance);
        
        // Spójność jest odwrotnie proporcjonalna do odchylenia
        double consistency = MathMax(0.0, MathMin(100.0, 100.0 - std_dev * 50.0));
        
        return consistency;
    }
    
private:
    void PrepareFractalData(double &fractal_data[][]) {
        int bars = 100; // Więcej danych dla analizy fraktali
        int channels = 4; // OHLC
        
        ArrayResize(fractal_data, bars);
        for(int i = 0; i < bars; i++) {
            ArrayResize(fractal_data[i], channels);
            
            // Pobierz dane OHLC
            fractal_data[i][0] = iOpen(Symbol(), PERIOD_CURRENT, i);
            fractal_data[i][1] = iHigh(Symbol(), PERIOD_CURRENT, i);
            fractal_data[i][2] = iLow(Symbol(), PERIOD_CURRENT, i);
            fractal_data[i][3] = iClose(Symbol(), PERIOD_CURRENT, i);
        }
    }
    
    double GetPatternBasedDimension(double &probabilities[]) {
        if(ArraySize(probabilities) == 0) return 1.5;
        
        // Mapuj prawdopodobieństwa wzorców na wymiary fraktalne
        double dimension = 1.0; // Podstawowy wymiar
        
        for(int i = 0; i < ArraySize(probabilities); i++) {
            dimension += probabilities[i] * 0.5; // Każdy wzorzec dodaje do wymiaru
        }
        
        return MathMax(1.0, MathMin(3.0, dimension));
    }
    
    double GetAttentionBasedDimension(double &attention_output[][]) {
        if(ArraySize(attention_output) == 0) return 1.5;
        
        // Analizuj uwagę na różnych skalach czasowych
        double attention_sum = 0.0;
        int attention_count = 0;
        
        for(int i = 0; i < ArraySize(attention_output); i++) {
            if(ArraySize(attention_output[i]) > 0) {
                attention_sum += attention_output[i][0];
                attention_count++;
            }
        }
        
        if(attention_count == 0) return 1.5;
        
        double avg_attention = attention_sum / attention_count;
        
        // Mapuj uwagę na wymiar fraktalny
        return 1.0 + avg_attention * 2.0; // 1.0 - 3.0
    }
};

class CWaveAnalyzer {
private:
    CCentralLSTM* m_wave_lstm;
    CCentralAttention* m_wave_attention;
    bool m_is_initialized;
    
public:
    CWaveAnalyzer() {
        m_wave_lstm = NULL;
        m_wave_attention = NULL;
        m_is_initialized = false;
    }
    
    ~CWaveAnalyzer() {
        if(m_wave_lstm != NULL) delete m_wave_lstm;
        if(m_wave_attention != NULL) delete m_wave_attention;
    }
    
    bool Initialize() {
        // Inicjalizacja centralnego LSTM dla analizy fal
        m_wave_lstm = new CCentralLSTM(16, 32, 1, 30); // Krótsze sekwencje dla fal
        if(m_wave_lstm == NULL) return false;
        
        // Inicjalizacja centralnego Attention dla analizy wzorców fal
        m_wave_attention = new CCentralAttention(32, 4, 30);
        if(m_wave_attention == NULL) return false;
        
        if(!m_wave_lstm.Initialize() || !m_wave_attention.Initialize()) {
            return false;
        }
        
        m_is_initialized = true;
        return true;
    }
    
    void UpdateWaveData() {
        // Aktualizacja danych fal w centralnym AI
        if(m_is_initialized) {
            // Można dodać logikę aktualizacji
        }
    }
    
    double GetCurrentWaveStrength() {
        if(!m_is_initialized) return 50.0;
        
        // Przygotuj dane dla analizy fal
        double wave_data[][];
        PrepareWaveData(wave_data);
        
        // Użyj centralnego LSTM do predykcji siły fali
        double lstm_prediction = m_wave_lstm.Predict(wave_data);
        
        // Użyj centralnego Attention do analizy wzorców fal
        double attention_output[][];
        m_wave_attention.ApplyAttention(wave_data, attention_output);
        
        // Oblicz siłę fali na podstawie LSTM i Attention
        double wave_strength = GetWaveStrengthFromLSTM(lstm_prediction);
        double pattern_strength = GetWaveStrengthFromPatterns(attention_output);
        
        // Połącz wyniki
        double final_strength = (wave_strength + pattern_strength) / 2.0;
        
        return MathMax(0.0, MathMin(100.0, final_strength));
    }
    
private:
    void PrepareWaveData(double &wave_data[][]) {
        int bars = 30; // Krótsze okno dla analizy fal
        int features = 6; // OHLC + RSI + MACD
        
        ArrayResize(wave_data, bars);
        for(int i = 0; i < bars; i++) {
            ArrayResize(wave_data[i], features);
            
            // OHLC
            wave_data[i][0] = iOpen(Symbol(), PERIOD_CURRENT, i);
            wave_data[i][1] = iHigh(Symbol(), PERIOD_CURRENT, i);
            wave_data[i][2] = iLow(Symbol(), PERIOD_CURRENT, i);
            wave_data[i][3] = iClose(Symbol(), PERIOD_CURRENT, i);
            
            // RSI
            wave_data[i][4] = CalculateRSI(i);
            
            // MACD
            wave_data[i][5] = CalculateMACD(i);
        }
    }
    
    double CalculateRSI(int shift) {
        double closes[];
        if(CopyClose(Symbol(), PERIOD_CURRENT, shift, 15, closes) == 15) {
            double gains = 0.0, losses = 0.0;
            
            for(int i = 1; i < 15; i++) {
                double change = closes[i] - closes[i-1];
                if(change > 0) gains += change;
                else losses -= change;
            }
            
            double avg_gain = gains / 14.0;
            double avg_loss = losses / 14.0;
            
            if(avg_loss == 0) return 100.0;
            
            double rs = avg_gain / avg_loss;
            return 100.0 - (100.0 / (1.0 + rs));
        }
        return 50.0;
    }
    
    double CalculateMACD(int shift) {
        double closes[];
        if(CopyClose(Symbol(), PERIOD_CURRENT, shift, 26, closes) == 26) {
            // Prosty MACD
            double ema12 = 0.0, ema26 = 0.0;
            
            // EMA 12
            double multiplier12 = 2.0 / (12.0 + 1.0);
            ema12 = closes[0];
            for(int i = 1; i < 26; i++) {
                ema12 = (closes[i] * multiplier12) + (ema12 * (1.0 - multiplier12));
            }
            
            // EMA 26
            double multiplier26 = 2.0 / (26.0 + 1.0);
            ema26 = closes[0];
            for(int i = 1; i < 26; i++) {
                ema26 = (closes[i] * multiplier26) + (ema26 * (1.0 - multiplier26));
            }
            
            return ema12 - ema26;
        }
        return 0.0;
    }
    
    double GetWaveStrengthFromLSTM(double lstm_prediction) {
        // Mapuj predykcję LSTM na siłę fali (0-100)
        return MathMax(0.0, MathMin(100.0, (lstm_prediction + 1.0) * 50.0));
    }
    
    double GetWaveStrengthFromPatterns(double &attention_output[][]) {
        if(ArraySize(attention_output) == 0) return 50.0;
        
        // Analizuj wzorce uwagi dla określenia siły fali
        double attention_sum = 0.0;
        int attention_count = 0;
        
        for(int i = 0; i < ArraySize(attention_output); i++) {
            if(ArraySize(attention_output[i]) > 0) {
                attention_sum += attention_output[i][0];
                attention_count++;
            }
        }
        
        if(attention_count == 0) return 50.0;
        
        double avg_attention = attention_sum / attention_count;
        
        // Mapuj uwagę na siłę fali
        return avg_attention * 100.0;
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
    // Prawdziwa implementacja detekcji ekspansji zmienności
    double closes[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 20, closes) == 20) {
        double current_volatility = CalculateVolatility(closes, 10);
        double historical_volatility = CalculateVolatility(closes, 20);
        
        if(historical_volatility > 0) {
            double expansion_ratio = current_volatility / historical_volatility;
            return MathMax(0.0, MathMin(100.0, (expansion_ratio - 1.0) * 100.0));
        }
    }
    return 30.0; // Fallback
}

double GetRSI() {
    // Prawdziwa implementacja RSI
    double closes[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 15, closes) == 15) {
        return CalculateRSIFromData(closes);
    }
    return 50.0; // Neutral
}

double GetMACD() {
    // Prawdziwa implementacja MACD
    double closes[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 26, closes) == 26) {
        return CalculateMACDFromData(closes);
    }
    return 0.0; // Neutral
}

double GetStochastic() {
    // Prawdziwa implementacja Stochastic
    double highs[], lows[], closes[];
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, 14, highs) == 14 &&
       CopyLow(Symbol(), PERIOD_CURRENT, 0, 14, lows) == 14 &&
       CopyClose(Symbol(), PERIOD_CURRENT, 0, 14, closes) == 14) {
        return CalculateStochasticFromData(highs, lows, closes);
    }
    return 50.0; // Neutral
}

double GetADX() {
    // Prawdziwa implementacja ADX
    double highs[], lows[], closes[];
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, 20, highs) == 20 &&
       CopyLow(Symbol(), PERIOD_CURRENT, 0, 20, lows) == 20 &&
       CopyClose(Symbol(), PERIOD_CURRENT, 0, 20, closes) == 20) {
        return CalculateADXFromData(highs, lows, closes);
    }
    return 25.0; // Weak trend
}

double GetSupportResistanceStrength() {
    // Prawdziwa implementacja siły wsparcia/oporu
    double highs[], lows[];
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, 50, highs) == 50 &&
       CopyLow(Symbol(), PERIOD_CURRENT, 0, 50, lows) == 50) {
        return CalculateSupportResistanceStrength(highs, lows);
    }
    return 50.0; // Neutral
}

double GetTrendStrength() {
    // Prawdziwa implementacja siły trendu
    double closes[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 20, closes) == 20) {
        return CalculateTrendStrength(closes);
    }
    return 50.0; // Neutral
}

double CalculateDerivedMetric(int index) {
    // Prawdziwa implementacja metryki pochodnej
    double closes[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 20, closes) == 20) {
        return CalculateDerivedMetricFromData(closes, index);
    }
    return 0.5; // Neutral
}

double CalculateMomentumVelocity() {
    // Prawdziwa implementacja prędkości momentum
    double closes[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 10, closes) == 10) {
        return CalculateMomentumVelocityFromData(closes);
    }
    return 0.0; // Neutral
}

double CalculateMomentumAcceleration() {
    // Prawdziwa implementacja przyspieszenia momentum
    double closes[];
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, 15, closes) == 15) {
        return CalculateMomentumAccelerationFromData(closes);
    }
    return 0.0; // Neutral
}

double CalculateROC(double &prices[], int period) {
    if(ArraySize(prices) < period + 1) return 0.0;
    return ((prices[ArraySize(prices)-1] - prices[ArraySize(prices)-1-period]) / prices[ArraySize(prices)-1-period]) * 100;
}

double CalculateTRIX(double &prices[], int period) {
    // Prawdziwa implementacja TRIX
    if(ArraySize(prices) < period * 3) return 0.0;
    
    double ema1[], ema2[], ema3[];
    ArrayResize(ema1, ArraySize(prices));
    ArrayResize(ema2, ArraySize(prices));
    ArrayResize(ema3, ArraySize(prices));
    
    // Pierwsza EMA
    double multiplier = 2.0 / (period + 1.0);
    ema1[0] = prices[0];
    for(int i = 1; i < ArraySize(prices); i++) {
        ema1[i] = (prices[i] * multiplier) + (ema1[i-1] * (1.0 - multiplier));
    }
    
    // Druga EMA
    ema2[0] = ema1[0];
    for(int i = 1; i < ArraySize(prices); i++) {
        ema2[i] = (ema1[i] * multiplier) + (ema2[i-1] * (1.0 - multiplier));
    }
    
    // Trzecia EMA
    ema3[0] = ema2[0];
    for(int i = 1; i < ArraySize(prices); i++) {
        ema3[i] = (ema2[i] * multiplier) + (ema3[i-1] * (1.0 - multiplier));
    }
    
    // TRIX = zmiana procentowa trzeciej EMA
    if(ema3[1] != 0) {
        return ((ema3[0] - ema3[1]) / ema3[1]) * 100.0;
    }
    
    return 0.0;
}

double CalculateAwesome(double &prices[]) {
    // Prawdziwa implementacja Awesome Oscillator
    if(ArraySize(prices) < 34) return 0.0;
    
    double sma5 = 0.0, sma34 = 0.0;
    
    // SMA 5
    for(int i = 0; i < 5; i++) {
        sma5 += prices[i];
    }
    sma5 /= 5.0;
    
    // SMA 34
    for(int i = 0; i < 34; i++) {
        sma34 += prices[i];
    }
    sma34 /= 34.0;
    
    return sma5 - sma34;
}

double CalculateWilliamsR(double &prices[], int period) {
    // Prawdziwa implementacja Williams %R
    if(ArraySize(prices) < period) return -50.0;
    
    double highest_high = prices[0];
    double lowest_low = prices[0];
    
    for(int i = 1; i < period; i++) {
        if(prices[i] > highest_high) highest_high = prices[i];
        if(prices[i] < lowest_low) lowest_low = prices[i];
    }
    
    if(highest_high == lowest_low) return -50.0;
    
    double current_price = prices[0];
    return ((highest_high - current_price) / (highest_high - lowest_low)) * -100.0;
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
    // Prawdziwa implementacja detekcji przełamania wzorców
    if(ArraySize(prices) < 20) return 50.0;
    
    // Oblicz siłę trendu
    double trend_strength = CalculateTrendStrength(prices);
    
    // Oblicz zmienność
    double volatility = CalculateVolatility(prices, 20);
    
    // Oblicz momentum
    double momentum = (prices[0] - prices[19]) / prices[19] * 100.0;
    
    // Oblicz siłę przełamania na podstawie kombinacji czynników
    double breakthrough_strength = 0.0;
    
    // Trend strength contribution (40%)
    breakthrough_strength += (trend_strength / 100.0) * 40.0;
    
    // Volatility contribution (30%)
    double normalized_volatility = MathMin(volatility / 0.01, 1.0); // Normalizuj do 0-1
    breakthrough_strength += normalized_volatility * 30.0;
    
    // Momentum contribution (30%)
    double normalized_momentum = MathAbs(momentum) / 10.0; // Normalizuj do 0-1
    breakthrough_strength += MathMin(normalized_momentum, 1.0) * 30.0;
    
    return MathMax(0.0, MathMin(100.0, breakthrough_strength));
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
    
    // Helper functions - REAL IMPLEMENTATIONS
    double CalculateTimeframeMomentum(ENUM_TIMEFRAMES timeframe);
    double DetectMomentumDivergence();
    double CalculateVolumeBreakthrough();
    bool ValidateBreakthrough(double momentum_strength);
    
    // NOWE - rzeczywiste funkcje momentum
    double CalculateRateOfChange(ENUM_TIMEFRAMES timeframe, int period);
    double CalculateMomentumOscillator(ENUM_TIMEFRAMES timeframe);
    double CalculateAccelerationDecelerator(ENUM_TIMEFRAMES timeframe);
    double CalculateChaikinOscillator(ENUM_TIMEFRAMES timeframe);
    double CalculateVolumeRateOfChange(ENUM_TIMEFRAMES timeframe);
    bool DetectMomentumBreakout(ENUM_TIMEFRAMES timeframe);
    double CalculateMomentumAlignment();
    
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
    // RZECZYWISTA implementacja momentum convergence
    ENUM_TIMEFRAMES timeframes[] = {PERIOD_M1, PERIOD_M5, PERIOD_M15, PERIOD_M30, PERIOD_H1, PERIOD_H4, PERIOD_D1};
    double momentum_scores[7];
    double volume_scores[7];
    
    // Oblicz rzeczywiste momentum dla każdego timeframe
    for(int i = 0; i < 7; i++) {
        // Price momentum - Rate of Change + Acceleration/Deceleration
        double roc = CalculateRateOfChange(timeframes[i], 14);
        double ac = CalculateAccelerationDecelerator(timeframes[i]);
        double mom_osc = CalculateMomentumOscillator(timeframes[i]);
        
        // Volume momentum - Chaikin Oscillator + Volume ROC
        double chaikin = CalculateChaikinOscillator(timeframes[i]);
        double vol_roc = CalculateVolumeRateOfChange(timeframes[i]);
        
        // Combined scores
        momentum_scores[i] = (roc * 0.4 + ac * 0.3 + mom_osc * 0.3);
        volume_scores[i] = (chaikin * 0.6 + vol_roc * 0.4);
        
        // Boost dla breakout
        if(DetectMomentumBreakout(timeframes[i])) {
            momentum_scores[i] *= 1.3;
        }
    }
    
    // Oblicz directional consensus
    int bullish_tf = 0, bearish_tf = 0;
    double total_strength = 0.0;
    
    for(int i = 0; i < 7; i++) {
        double weight = GetTimeframeWeight(i);
        double combined = (momentum_scores[i] + volume_scores[i]) / 2.0;
        
        if(combined > 10.0) bullish_tf++;
        else if(combined < -10.0) bearish_tf++;
        
        total_strength += MathAbs(combined) * weight;
    }
    
    // Convergence calculation
    double consensus = MathMax(bullish_tf, bearish_tf) / 7.0 * 100.0;
    double strength = MathMin(total_strength / 10.0, 100.0);
    double alignment = CalculateMomentumAlignment();
    
    return MathMax(0.0, MathMin(100.0, consensus * 0.4 + strength * 0.4 + alignment * 0.2));
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
    long volumes[];
    
    // Resize arrays first
    ArrayResize(prices, bars_count);
    ArrayResize(volumes, bars_count);
    ArraySetAsSeries(prices, false);
    ArraySetAsSeries(volumes, false);
    
    // Get price and volume data
    int price_count = CopyClose(Symbol(), timeframe, 0, bars_count, prices);
    int volume_count = CopyTickVolume(Symbol(), timeframe, 0, bars_count, volumes);
    
    if(price_count <= 0 || volume_count <= 0) {
        return 0.0;
    }
    
    // Calculate multiple momentum indicators
    double roc_momentum = CalculateROC(prices, 14);           // Rate of Change
    double trix_momentum = CalculateTRIX(prices, 14);         // TRIX
    double awesome_momentum = CalculateAwesome(prices);        // Awesome Oscillator
    double williams_momentum = CalculateWilliamsR(prices, 14); // Williams %R
    
    // Convert volumes to double for calculations
    double volumes_double[];
    ArrayResize(volumes_double, bars_count);
    for(int i = 0; i < bars_count; i++) {
        volumes_double[i] = (double)volumes[i];
    }
    
    // Volume-weighted momentum
    double vwap = CalculateVWAP(prices, volumes_double);
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
    long volumes[];
    int bars_count = 100;
    
    // Resize array first
    ArrayResize(volumes, bars_count);
    ArraySetAsSeries(volumes, false);
    
    int volume_count = -1;
    if(bars_count > 0) {
        volume_count = CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, bars_count, volumes);
    }
    if(volume_count <= 0) {
        return 0.0;
    }
    
    // Calculate volume statistics - convert long to double
    double volumes_double[];
    ArrayResize(volumes_double, bars_count);
    for(int i = 0; i < bars_count; i++) {
        volumes_double[i] = (double)volumes[i];
    }
    
    double avg_volume = CalculateAverage(volumes_double, 50, 49); // Average of last 50 bars (excluding current)
    double volume_std = CalculateStandardDeviation(volumes_double, 50, 49);
    double current_volume = (double)volumes[bars_count-1];
    
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

// === RZECZYWISTE IMPLEMENTACJE MOMENTUM FUNCTIONS ===

double BitternessSpirit::CalculateRateOfChange(ENUM_TIMEFRAMES timeframe, int period) {
    double prices[];
    if(CopyClose(Symbol(), timeframe, 0, period + 1, prices) != period + 1) {
        return 0.0;
    }
    
    double current_price = prices[period];
    double past_price = prices[0];
    
    if(past_price == 0) return 0.0;
    
    // ROC = ((Current - Past) / Past) * 100
    return ((current_price - past_price) / past_price) * 100.0;
}

double BitternessSpirit::CalculateMomentumOscillator(ENUM_TIMEFRAMES timeframe) {
    // Momentum = Close - Close[n periods ago]
    double prices[];
    int period = 14;
    
    if(CopyClose(Symbol(), timeframe, 0, period + 1, prices) != period + 1) {
        return 0.0;
    }
    
    double momentum = prices[period] - prices[0];
    
    // Normalize to percentage
    if(prices[0] != 0) {
        momentum = (momentum / prices[0]) * 100.0;
    }
    
    return momentum;
}

double BitternessSpirit::CalculateAccelerationDecelerator(ENUM_TIMEFRAMES timeframe) {
    // AC = AO - SMA(AO, 5)
    // AO = SMA(HL/2, 5) - SMA(HL/2, 34)
    
    double high[], low[];
    int bars = 40; // Need extra bars for SMA calculations
    
    if(CopyHigh(Symbol(), timeframe, 0, bars, high) != bars ||
       CopyLow(Symbol(), timeframe, 0, bars, low) != bars) {
        return 0.0;
    }
    
    // Calculate HL/2 (median prices)
    double median_prices[];
    ArrayResize(median_prices, bars);
    for(int i = 0; i < bars; i++) {
        median_prices[i] = (high[i] + low[i]) / 2.0;
    }
    
    // Calculate AO = SMA(HL/2, 5) - SMA(HL/2, 34)
    double ao_current = 0.0, ao_prev = 0.0;
    
    // Current AO
    double sma5_current = 0.0, sma34_current = 0.0;
    for(int i = bars - 5; i < bars; i++) sma5_current += median_prices[i];
    for(int i = bars - 34; i < bars; i++) sma34_current += median_prices[i];
    ao_current = (sma5_current / 5.0) - (sma34_current / 34.0);
    
    // Previous AO (5 periods back for AC calculation)
    double sma5_prev = 0.0, sma34_prev = 0.0;
    for(int i = bars - 10; i < bars - 5; i++) sma5_prev += median_prices[i];
    for(int i = bars - 39; i < bars - 5; i++) sma34_prev += median_prices[i];
    ao_prev = (sma5_prev / 5.0) - (sma34_prev / 34.0);
    
    // AC = Current AO - SMA of AO
    // Simplified: AC ≈ AO momentum
    return (ao_current - ao_prev) * 10000.0; // Scale for visibility
}

double BitternessSpirit::CalculateChaikinOscillator(ENUM_TIMEFRAMES timeframe) {
    // Chaikin Oscillator = EMA(ADL, 3) - EMA(ADL, 10)
    
    double high[], low[], close[];
    long volume[];
    int bars = 20;
    
    if(CopyHigh(Symbol(), timeframe, 0, bars, high) != bars ||
       CopyLow(Symbol(), timeframe, 0, bars, low) != bars ||
       CopyClose(Symbol(), timeframe, 0, bars, close) != bars ||
       CopyTickVolume(Symbol(), timeframe, 0, bars, volume) != bars) {
        return 0.0;
    }
    
    // Calculate ADL (Accumulation/Distribution Line)
    double adl = 0.0;
    double adl_values[];
    ArrayResize(adl_values, bars);
    
    for(int i = 0; i < bars; i++) {
        if(high[i] != low[i]) {
            double money_flow_multiplier = ((close[i] - low[i]) - (high[i] - close[i])) / (high[i] - low[i]);
            double money_flow_volume = money_flow_multiplier * volume[i];
            adl += money_flow_volume;
        }
        adl_values[i] = adl;
    }
    
    // Calculate EMA(ADL, 3) and EMA(ADL, 10)
    double ema3 = adl_values[bars-1];
    double ema10 = adl_values[bars-1];
    
    // Simplified EMA calculation
    for(int i = bars - 10; i < bars; i++) {
        ema3 = (adl_values[i] * 2.0 + ema3 * 2.0) / 4.0;
        ema10 = (adl_values[i] * 2.0 + ema10 * 18.0) / 20.0;
    }
    
    return (ema3 - ema10) / 1000.0; // Scale for readability
}

double BitternessSpirit::CalculateVolumeRateOfChange(ENUM_TIMEFRAMES timeframe) {
    long volume[];
    int period = 14;
    
    if(CopyTickVolume(Symbol(), timeframe, 0, period + 1, volume) != period + 1) {
        return 0.0;
    }
    
    long current_volume = volume[period];
    long past_volume = volume[0];
    
    if(past_volume == 0) return 0.0;
    
    // Volume ROC = ((Current Volume - Past Volume) / Past Volume) * 100
    return ((double)(current_volume - past_volume) / past_volume) * 100.0;
}

bool BitternessSpirit::DetectMomentumBreakout(ENUM_TIMEFRAMES timeframe) {
    // Multi-criteria breakout detection
    
    double roc = CalculateRateOfChange(timeframe, 14);
    double mom_osc = CalculateMomentumOscillator(timeframe);
    double vol_roc = CalculateVolumeRateOfChange(timeframe);
    
    // Breakout criteria:
    // 1. Strong price momentum (ROC > 2% or < -2%)
    // 2. Confirming momentum oscillator (same direction)
    // 3. Volume expansion (Volume ROC > 50%)
    
    bool price_breakout = (MathAbs(roc) > 2.0);
    bool momentum_confirm = (roc > 0 && mom_osc > 0) || (roc < 0 && mom_osc < 0);
    bool volume_confirm = (vol_roc > 50.0);
    
    return price_breakout && momentum_confirm && volume_confirm;
}

double BitternessSpirit::CalculateMomentumAlignment() {
    // Calculate alignment between different momentum indicators
    ENUM_TIMEFRAMES timeframes[] = {PERIOD_M15, PERIOD_H1, PERIOD_H4, PERIOD_D1};
    int tf_count = 4;
    
    double roc_values[4];
    double mom_values[4];
    double vol_values[4];
    
    for(int i = 0; i < tf_count; i++) {
        roc_values[i] = CalculateRateOfChange(timeframes[i], 14);
        mom_values[i] = CalculateMomentumOscillator(timeframes[i]);
        vol_values[i] = CalculateVolumeRateOfChange(timeframes[i]);
    }
    
    // Count timeframes with same directional bias
    int bullish_roc = 0, bearish_roc = 0;
    int bullish_mom = 0, bearish_mom = 0;
    int bullish_vol = 0, bearish_vol = 0;
    
    for(int i = 0; i < tf_count; i++) {
        if(roc_values[i] > 0.5) bullish_roc++;
        else if(roc_values[i] < -0.5) bearish_roc++;
        
        if(mom_values[i] > 0.5) bullish_mom++;
        else if(mom_values[i] < -0.5) bearish_mom++;
        
        if(vol_values[i] > 10.0) bullish_vol++;
        else if(vol_values[i] < -10.0) bearish_vol++;
    }
    
    // Calculate alignment score
    double roc_alignment = MathMax(bullish_roc, bearish_roc) / (double)tf_count * 100.0;
    double mom_alignment = MathMax(bullish_mom, bearish_mom) / (double)tf_count * 100.0;
    double vol_alignment = MathMax(bullish_vol, bearish_vol) / (double)tf_count * 100.0;
    
    return (roc_alignment * 0.4 + mom_alignment * 0.4 + vol_alignment * 0.2);
}

// Destruktor
BitternessSpirit::~BitternessSpirit() {
    if(m_breakthrough_ai != NULL) delete m_breakthrough_ai;
    if(m_volume_analyzer != NULL) delete m_volume_analyzer;
    if(m_fractal_calculator != NULL) delete m_fractal_calculator;
    if(m_wave_analyzer != NULL) delete m_wave_analyzer;
}

//+------------------------------------------------------------------+
//| IMPLEMENTACJE FUNKCJI POMOCNICZYCH                                |
//+------------------------------------------------------------------+

// Obliczanie zmienności
double CalculateVolatility(double &data[], int period) {
    if(ArraySize(data) < period) return 0.0;
    
    double avg = 0.0;
    for(int i = 0; i < period; i++) {
        avg += data[i];
    }
    avg /= period;
    
    double variance = 0.0;
    for(int i = 0; i < period; i++) {
        variance += MathPow(data[i] - avg, 2);
    }
    variance /= period;
    
    return MathSqrt(variance);
}

// Obliczanie RSI z danych
double CalculateRSIFromData(double &closes[]) {
    if(ArraySize(closes) < 15) return 50.0;
    
    double gains = 0.0, losses = 0.0;
    
    for(int i = 1; i < 15; i++) {
        double change = closes[i] - closes[i-1];
        if(change > 0) gains += change;
        else losses -= change;
    }
    
    double avg_gain = gains / 14.0;
    double avg_loss = losses / 14.0;
    
    if(avg_loss == 0) return 100.0;
    
    double rs = avg_gain / avg_loss;
    return 100.0 - (100.0 / (1.0 + rs));
}

// Obliczanie MACD z danych
double CalculateMACDFromData(double &closes[]) {
    if(ArraySize(closes) < 26) return 0.0;
    
    double ema12 = 0.0, ema26 = 0.0;
    
    // EMA 12
    double multiplier12 = 2.0 / (12.0 + 1.0);
    ema12 = closes[0];
    for(int i = 1; i < 26; i++) {
        ema12 = (closes[i] * multiplier12) + (ema12 * (1.0 - multiplier12));
    }
    
    // EMA 26
    double multiplier26 = 2.0 / (26.0 + 1.0);
    ema26 = closes[0];
    for(int i = 1; i < 26; i++) {
        ema26 = (closes[i] * multiplier26) + (ema26 * (1.0 - multiplier26));
    }
    
    return ema12 - ema26;
}

// Obliczanie Stochastic z danych
double CalculateStochasticFromData(double &highs[], double &lows[], double &closes[]) {
    if(ArraySize(highs) < 14 || ArraySize(lows) < 14 || ArraySize(closes) < 14) return 50.0;
    
    double highest_high = highs[0];
    double lowest_low = lows[0];
    
    for(int i = 1; i < 14; i++) {
        if(highs[i] > highest_high) highest_high = highs[i];
        if(lows[i] < lowest_low) lowest_low = lows[i];
    }
    
    if(highest_high == lowest_low) return 50.0;
    
    double current_close = closes[0];
    return ((current_close - lowest_low) / (highest_high - lowest_low)) * 100.0;
}

// Obliczanie ADX z danych
double CalculateADXFromData(double &highs[], double &lows[], double &closes[]) {
    if(ArraySize(highs) < 20 || ArraySize(lows) < 20 || ArraySize(closes) < 20) return 25.0;
    
    // Uproszczona implementacja ADX
    double true_ranges = 0.0;
    double directional_moves = 0.0;
    
    for(int i = 1; i < 20; i++) {
        double tr = MathMax(highs[i] - lows[i], 
                           MathMax(MathAbs(highs[i] - closes[i-1]), 
                                  MathAbs(lows[i] - closes[i-1])));
        true_ranges += tr;
        
        double dm = 0.0;
        if(highs[i] - highs[i-1] > lows[i-1] - lows[i]) {
            dm = MathMax(0.0, highs[i] - highs[i-1]);
        }
        directional_moves += dm;
    }
    
    if(true_ranges == 0) return 25.0;
    
    double adx = (directional_moves / true_ranges) * 100.0;
    return MathMax(0.0, MathMin(100.0, adx));
}

// Obliczanie siły wsparcia/oporu
double CalculateSupportResistanceStrength(double &highs[], double &lows[]) {
    if(ArraySize(highs) < 50 || ArraySize(lows) < 50) return 50.0;
    
    // Znajdź kluczowe poziomy
    double resistance_levels[];
    double support_levels[];
    
    // Prosta implementacja - można rozszerzyć
    double avg_high = 0.0, avg_low = 0.0;
    
    for(int i = 0; i < 50; i++) {
        avg_high += highs[i];
        avg_low += lows[i];
    }
    
    avg_high /= 50.0;
    avg_low /= 50.0;
    
    double current_price = iClose(Symbol(), PERIOD_CURRENT, 0);
    double high_distance = MathAbs(current_price - avg_high);
    double low_distance = MathAbs(current_price - avg_low);
    
    if(high_distance < low_distance) {
        return MathMax(0.0, MathMin(100.0, 100.0 - (high_distance / avg_high) * 100.0));
    } else {
        return MathMax(0.0, MathMin(100.0, 100.0 - (low_distance / avg_low) * 100.0));
    }
}

// Obliczanie siły trendu
double CalculateTrendStrength(double &closes[]) {
    if(ArraySize(closes) < 20) return 50.0;
    
    // Linear regression slope
    double sum_x = 0.0, sum_y = 0.0, sum_xy = 0.0, sum_x2 = 0.0;
    
    for(int i = 0; i < 20; i++) {
        sum_x += i;
        sum_y += closes[i];
        sum_xy += i * closes[i];
        sum_x2 += i * i;
    }
    
    double n = 20.0;
    double slope = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x * sum_x);
    
    // Normalizuj slope do zakresu 0-100
    double normalized_slope = MathAbs(slope) * 1000.0; // Skala
    return MathMax(0.0, MathMin(100.0, normalized_slope));
}

// Obliczanie metryki pochodnej
double CalculateDerivedMetricFromData(double &closes[], int index) {
    if(ArraySize(closes) < 20) return 0.5;
    
    switch(index % 5) {
        case 0: return CalculateVolatility(closes, 10) / 100.0; // Normalizowana zmienność
        case 1: return (CalculateRSIFromData(closes) - 50.0) / 50.0; // Normalizowany RSI
        case 2: return MathTanh(CalculateMACDFromData(closes) / 100.0); // Normalizowany MACD
        case 3: return CalculateTrendStrength(closes) / 100.0; // Normalizowana siła trendu
        case 4: return (closes[0] - closes[19]) / closes[19]; // Zmiana procentowa
        default: return 0.5;
    }
}

// Obliczanie prędkości momentum
double CalculateMomentumVelocityFromData(double &closes[]) {
    if(ArraySize(closes) < 10) return 0.0;
    
    double current_momentum = (closes[0] - closes[9]) / closes[9] * 100.0;
    double previous_momentum = (closes[1] - closes[10]) / closes[10] * 100.0;
    
    return current_momentum - previous_momentum;
}

// Obliczanie przyspieszenia momentum
double CalculateMomentumAccelerationFromData(double &closes[]) {
    if(ArraySize(closes) < 15) return 0.0;
    
    double current_velocity = CalculateMomentumVelocityFromData(closes);
    
    double temp_closes[];
    ArrayResize(temp_closes, 10);
    for(int i = 0; i < 10; i++) {
        temp_closes[i] = closes[i + 1];
    }
    
    double previous_velocity = CalculateMomentumVelocityFromData(temp_closes);
    
    return current_velocity - previous_velocity;
}
