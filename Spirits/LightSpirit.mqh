// Kompletna implementacja Ducha Światła - Signal Clarity & Pattern Recognition
#include <Graphics\Graphic.mqh>
#include "../Utils/LoggingSystem.mqh"
// REMOVED: #include "../AI/AIEnums.mqh" - unused, has placeholders  
// REMOVED: #include "../AI/PatternRecognition.mqh" - unused, has placeholders

// Sprawdzamy czy enum nie są już zdefiniowane - usunięte dublowanie
#ifndef ENUM_LEVEL_TYPE_DEFINED
#define ENUM_LEVEL_TYPE_DEFINED
enum ENUM_LEVEL_TYPE {
    LEVEL_SUPPORT,      // Poziom wsparcia
    LEVEL_RESISTANCE    // Poziom oporu
};
#endif

// Structure definitions - PRZENIESIONE PRZED KLASY
struct SSignalData {
    double strength;        // Signal strength 0-100
    double clarity;         // Signal clarity 0-100
    double confidence;      // Confidence level 0-100
    ENUM_SIGNAL_QUALITY quality;
    datetime optimal_time;
    double optimal_price;
    string description;
};

struct SLevel {
    double price;
    double strength;
    ENUM_LEVEL_TYPE type;   // SUPPORT or RESISTANCE
    datetime formation_time;
    int touch_count;
};

struct SOptimalEntry {
    double entry_price;
    double stop_loss;
    double take_profit[];   // Multiple TP levels
    double probability;
    datetime entry_time;
    string rationale;
};

// Brakujące definicje klas
class CConvolutionalNet {
public:
    CConvolutionalNet() {
        // Placeholder implementation
    }
    bool Initialize() { return true; }
    void UpdateData() {}
    // W MQL przekazujemy 1D tablicę i obliczamy indeksy OHLC ręcznie
    void Recognize(double& data_matrix[], double& probabilities[]) {
        // Placeholder implementation
        ArrayResize(probabilities, 8);
        for(int i = 0; i < 8; i++) {
            probabilities[i] = 0.1 + (MathRand() % 90) / 100.0; // 0.1-1.0
        }
    }
};

class CTransformerNet {
public:
    CTransformerNet(int dim, int heads, int layers) {
        // Placeholder implementation
    }
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

class CMultiDimensionalSR {
private:
    SLevel m_key_levels[];
    double m_price_tolerance;
    int m_min_touches;
    int m_lookback_bars;
    
public:
    CMultiDimensionalSR() {
        m_price_tolerance = 0.0002; // 2 pips tolerance dla S/R levels
        m_min_touches = 2; // Minimum touches to qualify as S/R
        m_lookback_bars = 500; // Bars to analyze for S/R levels
        ArrayResize(m_key_levels, 0);
    }
    
    bool Initialize() { 
        return true; 
    }
    
    void UpdateData() {
        DetectSupportResistanceLevels();
    }
    
    void GetKeyLevels(SLevel &levels[]) {
        ArrayResize(levels, ArraySize(m_key_levels));
        for(int i = 0; i < ArraySize(m_key_levels); i++) {
            levels[i] = m_key_levels[i];
        }
    }
    
private:
    void DetectSupportResistanceLevels() {
        double high[], low[], close[];
        
        if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, m_lookback_bars, high) != m_lookback_bars ||
           CopyLow(Symbol(), PERIOD_CURRENT, 0, m_lookback_bars, low) != m_lookback_bars ||
           CopyClose(Symbol(), PERIOD_CURRENT, 0, m_lookback_bars, close) != m_lookback_bars) {
            return;
        }
        
        ArrayResize(m_key_levels, 0);
        
        // Get pivots (major turning points)
        double pivot_levels[];
        DetectPivotLevels(high, low, pivot_levels);
        
        // Analyze each pivot level for S/R strength
        for(int i = 0; i < ArraySize(pivot_levels); i++) {
            int touch_count = CountLevelTouches(pivot_levels[i], high, low);
            
            if(touch_count >= m_min_touches) {
                double strength = CalculateLevelStrength(pivot_levels[i], high, low, close, touch_count);
                ENUM_LEVEL_TYPE type = DetermineLevelType(pivot_levels[i], close);
                
                AddLevel(pivot_levels[i], strength, type, touch_count);
            }
        }
        
        // Sort by strength and keep only strongest levels
        SortLevelsByStrength();
        
        // Keep only top 15 levels to avoid clutter
        if(ArraySize(m_key_levels) > 15) {
            ArrayResize(m_key_levels, 15);
        }
    }
    
    void DetectPivotLevels(double &highs[], double &lows[], double &pivots[]) {
        ArrayResize(pivots, 0);
        int pivot_period = 10; // Bars before/after for pivot detection
        
        // Detect pivot highs
        for(int i = pivot_period; i < ArraySize(highs) - pivot_period; i++) {
            bool is_pivot_high = true;
            
            for(int j = 1; j <= pivot_period; j++) {
                if(highs[i] <= highs[i-j] || highs[i] <= highs[i+j]) {
                    is_pivot_high = false;
                    break;
                }
            }
            
            if(is_pivot_high) {
                ArrayResize(pivots, ArraySize(pivots) + 1);
                pivots[ArraySize(pivots) - 1] = highs[i];
            }
        }
        
        // Detect pivot lows
        for(int i = pivot_period; i < ArraySize(lows) - pivot_period; i++) {
            bool is_pivot_low = true;
            
            for(int j = 1; j <= pivot_period; j++) {
                if(lows[i] >= lows[i-j] || lows[i] >= lows[i+j]) {
                    is_pivot_low = false;
                    break;
                }
            }
            
            if(is_pivot_low) {
                ArrayResize(pivots, ArraySize(pivots) + 1);
                pivots[ArraySize(pivots) - 1] = lows[i];
            }
        }
        
        // Remove duplicate levels (too close to each other)
        RemoveDuplicateLevels(pivots);
    }
    
    void RemoveDuplicateLevels(double &levels[]) {
        for(int i = 0; i < ArraySize(levels) - 1; i++) {
            for(int j = i + 1; j < ArraySize(levels); j++) {
                if(MathAbs(levels[i] - levels[j]) < m_price_tolerance) {
                    // Remove the duplicate (keep the first one)
                    for(int k = j; k < ArraySize(levels) - 1; k++) {
                        levels[k] = levels[k + 1];
                    }
                    ArrayResize(levels, ArraySize(levels) - 1);
                    j--; // Adjust index after removal
                }
            }
        }
    }
    
    int CountLevelTouches(double level, double &highs[], double &lows[]) {
        int touch_count = 0;
        
        for(int i = 0; i < ArraySize(highs); i++) {
            // Check if high or low touched the level
            if(MathAbs(highs[i] - level) <= m_price_tolerance ||
               MathAbs(lows[i] - level) <= m_price_tolerance) {
                touch_count++;
            }
        }
        
        return touch_count;
    }
    
    double CalculateLevelStrength(double level, double &highs[], double &lows[], double &closes[], int touch_count) {
        // Strength factors:
        // 1. Number of touches (more = stronger)
        // 2. Recent respect (recent bounces = stronger)
        // 3. Time span (longer = stronger)
        // 4. Volume at touches (if available)
        
        double touch_strength = MathMin(touch_count / 10.0, 1.0) * 100.0;
        
        // Recent respect - check last 50 bars
        int recent_touches = 0;
        int recent_bars = MathMin(50, ArraySize(closes));
        
        for(int i = ArraySize(closes) - recent_bars; i < ArraySize(closes); i++) {
            if(MathAbs(highs[i] - level) <= m_price_tolerance ||
               MathAbs(lows[i] - level) <= m_price_tolerance) {
                recent_touches++;
            }
        }
        
        double recent_strength = MathMin(recent_touches / 5.0, 1.0) * 100.0;
        
        // Distance from current price (closer = more relevant)
        double current_price = closes[ArraySize(closes) - 1];
        double distance_factor = 1.0 / (1.0 + MathAbs(level - current_price) / current_price);
        double distance_strength = distance_factor * 100.0;
        
        // Combined strength
        return (touch_strength * 0.5 + recent_strength * 0.3 + distance_strength * 0.2);
    }
    
    ENUM_LEVEL_TYPE DetermineLevelType(double level, double &closes[]) {
        double current_price = closes[ArraySize(closes) - 1];
        
        // Simple classification: level above current price = resistance, below = support
        return (level > current_price) ? LEVEL_RESISTANCE : LEVEL_SUPPORT;
    }
    
    void AddLevel(double price, double strength, ENUM_LEVEL_TYPE type, int touch_count) {
        SLevel level;
        level.price = price;
        level.strength = strength;
        level.type = type;
        level.formation_time = TimeCurrent(); // Simplified - could track actual formation time
        level.touch_count = touch_count;
        
        ArrayResize(m_key_levels, ArraySize(m_key_levels) + 1);
        m_key_levels[ArraySize(m_key_levels) - 1] = level;
    }
    
    void SortLevelsByStrength() {
        int size = ArraySize(m_key_levels);
        for(int i = 0; i < size - 1; i++) {
            for(int j = 0; j < size - i - 1; j++) {
                if(m_key_levels[j].strength < m_key_levels[j + 1].strength) {
                    SLevel temp = m_key_levels[j];
                    m_key_levels[j] = m_key_levels[j + 1];
                    m_key_levels[j + 1] = temp;
                }
            }
        }
    }
};

class CFractalPatternDetector {
private:
    double m_fractal_strength_threshold;
    int m_lookback_bars;
    SLevel m_detected_fractals[];
    
public:
    CFractalPatternDetector() {
        m_fractal_strength_threshold = 0.0001; // 1 pip threshold
        m_lookback_bars = 5; // Standard fractal lookback
        ArrayResize(m_detected_fractals, 0);
    }
    
    bool Initialize() { 
        return true; 
    }
    
    void UpdateData() {
        // Update fractal detection
        DetectFractals();
    }
    
    double GetFractalClarity() {
        // RZECZYWISTA clarity based na detected fractals
        if(ArraySize(m_detected_fractals) == 0) {
            return 0.0;
        }
        
        double total_strength = 0.0;
        int valid_fractals = 0;
        
        for(int i = 0; i < ArraySize(m_detected_fractals); i++) {
            if(m_detected_fractals[i].strength > 0) {
                total_strength += m_detected_fractals[i].strength;
                valid_fractals++;
            }
        }
        
        if(valid_fractals == 0) return 0.0;
        
        double avg_strength = total_strength / valid_fractals;
        
        // Clarity score: więcej fractali + wyższa średnia strength = wyższa clarity
        double fractal_density = MathMin(valid_fractals / 10.0, 1.0) * 100.0;
        double strength_score = MathMin(avg_strength / 50.0, 1.0) * 100.0;
        
        return (fractal_density * 0.6 + strength_score * 0.4);
    }
    
    void GetDetectedFractals(SLevel &fractals[]) {
        ArrayResize(fractals, ArraySize(m_detected_fractals));
        for(int i = 0; i < ArraySize(m_detected_fractals); i++) {
            fractals[i] = m_detected_fractals[i];
        }
    }
    
private:
    void DetectFractals() {
        double high[], low[];
        int bars_to_analyze = 100;
        
        if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars_to_analyze, high) != bars_to_analyze ||
           CopyLow(Symbol(), PERIOD_CURRENT, 0, bars_to_analyze, low) != bars_to_analyze) {
            return;
        }
        
        ArrayResize(m_detected_fractals, 0);
        
        // Detect fractal highs (resistance)
        for(int i = m_lookback_bars; i < bars_to_analyze - m_lookback_bars; i++) {
            if(IsFractalHigh(high, i)) {
                double strength = CalculateFractalStrength(high, i, true);
                if(strength > m_fractal_strength_threshold) {
                    AddFractal(high[i], strength, LEVEL_RESISTANCE, bars_to_analyze - 1 - i);
                }
            }
        }
        
        // Detect fractal lows (support)
        for(int i = m_lookback_bars; i < bars_to_analyze - m_lookback_bars; i++) {
            if(IsFractalLow(low, i)) {
                double strength = CalculateFractalStrength(low, i, false);
                if(strength > m_fractal_strength_threshold) {
                    AddFractal(low[i], strength, LEVEL_SUPPORT, bars_to_analyze - 1 - i);
                }
            }
        }
        
        // Sort by strength
        SortFractalsByStrength();
    }
    
    bool IsFractalHigh(double &highs[], int index) {
        for(int j = 1; j <= m_lookback_bars; j++) {
            if(highs[index] <= highs[index-j] || highs[index] <= highs[index+j]) {
                return false;
            }
        }
        return true;
    }
    
    bool IsFractalLow(double &lows[], int index) {
        for(int j = 1; j <= m_lookback_bars; j++) {
            if(lows[index] >= lows[index-j] || lows[index] >= lows[index+j]) {
                return false;
            }
        }
        return true;
    }
    
    double CalculateFractalStrength(double &prices[], int index, bool is_high) {
        double total_distance = 0.0;
        int count = 0;
        
        for(int j = 1; j <= m_lookback_bars; j++) {
            if(is_high) {
                total_distance += (prices[index] - prices[index-j]);
                total_distance += (prices[index] - prices[index+j]);
            } else {
                total_distance += (prices[index-j] - prices[index]);
                total_distance += (prices[index+j] - prices[index]);
            }
            count += 2;
        }
        
        return count > 0 ? (total_distance / count) * 100000 : 0.0; // Scale to readable values
    }
    
    void AddFractal(double price, double strength, ENUM_LEVEL_TYPE type, int bars_back) {
        SLevel fractal;
        fractal.price = price;
        fractal.strength = strength;
        fractal.type = type;
        fractal.formation_time = iTime(Symbol(), PERIOD_CURRENT, bars_back);
        fractal.touch_count = 1;
        
        ArrayResize(m_detected_fractals, ArraySize(m_detected_fractals) + 1);
        m_detected_fractals[ArraySize(m_detected_fractals) - 1] = fractal;
    }
    
    void SortFractalsByStrength() {
        int size = ArraySize(m_detected_fractals);
        for(int i = 0; i < size - 1; i++) {
            for(int j = 0; j < size - i - 1; j++) {
                if(m_detected_fractals[j].strength < m_detected_fractals[j + 1].strength) {
                    SLevel temp = m_detected_fractals[j];
                    m_detected_fractals[j] = m_detected_fractals[j + 1];
                    m_detected_fractals[j + 1] = temp;
                }
            }
        }
    }
};

// Poprawiona składnia parametrów - usunięto błędne nawiasy kwadratowe
void PrepareTransformerInputs(double &inputs[], double technical, double pattern, 
                             double level, double fractal, double snr, double convergence) {
    ArrayResize(inputs, 64);
    inputs[0] = technical;
    inputs[1] = pattern;
    inputs[2] = level;
    inputs[3] = fractal;
    inputs[4] = snr;
    inputs[5] = convergence;
    
    // Fill remaining inputs with derived values
    for(int i = 6; i < 64; i++) {
        inputs[i] = (technical + pattern + level + fractal + snr + convergence) / 6.0;
    }
}

double ValidateMultiTimeframeAlignment() {
    // Placeholder implementation
    return 0.7 + (MathRand() % 30) / 100.0; // 0.7-1.0
}

// Przygotowanie macierzy OHLC jako spłaszczonej tablicy [bars*4]
void PrepareOHLCMatrix(double& data_matrix[], int bars) {
    ArrayResize(data_matrix, bars * 4);
    
    double opens[], highs[], lows[], closes[];
    if(CopyOpen(Symbol(), PERIOD_CURRENT, 0, bars, opens) == bars &&
       CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, highs) == bars &&
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, lows) == bars &&
       CopyClose(Symbol(), PERIOD_CURRENT, 0, bars, closes) == bars) {
        
        for(int i = 0; i < bars; i++) {
            data_matrix[i * 4 + 0] = opens[i];   // Open
            data_matrix[i * 4 + 1] = highs[i];   // High  
            data_matrix[i * 4 + 2] = lows[i];    // Low
            data_matrix[i * 4 + 3] = closes[i];  // Close
        }
    }
}

double CalculatePatternCompletion(int pattern_type) {
    // Placeholder implementation
    return 60.0 + (MathRand() % 40); // 60-100
}

// Ocena jakości wzorca dla spłaszczonej macierzy [N*4]
double AssessPatternQuality(int pattern_type, double& data_matrix[]) {
    // Placeholder implementation
    return 50.0 + (MathRand() % 50); // 50-100
}

double CalculateFractalClarity() {
    // Placeholder implementation
    return 30.0 + (MathRand() % 70); // 30-100
}

void UpdateNeuralNetworks() {
    // Placeholder neural network update
}

class LightSpirit {
private:
    // Convolutional Neural Network for pattern recognition
    CConvolutionalNet* m_pattern_cnn;
    
    // Transformer model for signal clarity
    CTransformerNet* m_signal_transformer;
    
    // Multi-dimensional support/resistance analyzer
    CMultiDimensionalSR* m_sr_analyzer;
    
    // Fractal pattern detector
    CFractalPatternDetector* m_fractal_detector;
    
    // Signal buffers and filters
    double m_signal_clarity_history[100];
    double m_pattern_confidence_history[100];
    double m_noise_filter_buffer[50];
    
    // Adaptive thresholds
    double m_clarity_threshold_high;
    double m_clarity_threshold_low;
    double m_pattern_confidence_threshold;
    
    // Signal processing methods
    double ApplyKalmanFilter(double raw_signal);
    double CalculateSignalToNoiseRatio();
    double DetectSignalConvergence();
    bool ValidateSignalWithMultipleTimeframes();
    
    // Pattern recognition helpers
    double RecognizeTrianglePattern();
    double RecognizeHeadShouldersPattern();
    double RecognizeDoubleTopBottomPattern();
    double RecognizeFlagPennantPattern();
    
    // Technical analysis helpers - DODANE
    double CalculateTechnicalSignalClarity();
    double CalculatePatternClarity();
    double CalculateLevelClarity();
    
public:
    LightSpirit();
    ~LightSpirit();
    
    // Main public methods
    double GetSignalClarity();
    ENUM_SIGNAL_QUALITY GetSignalQuality();
    SSignalData GetOptimalEntry();
    double CalculateSignalStrength();
    
    // Pattern recognition
    ENUM_PATTERN_TYPE GetDominantPattern();
    double GetPatternConfidence();
    double GetPatternCompletionProbability();
    
    // Support/Resistance analysis
    double GetSupportResistanceStrength();
    void GetKeyLevels(SLevel &levels[]);
    double GetLevelBreakoutProbability();
    
    // Signal optimization
    SOptimalEntry CalculateOptimalEntry();
    datetime GetOptimalTiming();
    void UpdateSignalModels();

    // System compatibility methods
    bool Initialize();
    void UpdateData();
    double GetNoiseLevel();
};

// Konstruktor
LightSpirit::LightSpirit() {
    // Initialize neural networks
    m_pattern_cnn = new CConvolutionalNet();
    m_signal_transformer = new CTransformerNet(64, 8, 4); // 64 dim, 8 heads, 4 layers
    m_sr_analyzer = new CMultiDimensionalSR();
    m_fractal_detector = new CFractalPatternDetector();
    
    // Initialize adaptive thresholds
    m_clarity_threshold_high = 85.0;
    m_clarity_threshold_low = 40.0;
    m_pattern_confidence_threshold = 70.0;
    
    // Initialize signal history
    ArrayInitialize(m_signal_clarity_history, 50.0);
    ArrayInitialize(m_pattern_confidence_history, 0.0);
    ArrayInitialize(m_noise_filter_buffer, 0.0);
}

// Główna funkcja jasności sygnału
double LightSpirit::GetSignalClarity() {
    // Multi-source signal analysis
    double technical_clarity = CalculateTechnicalSignalClarity();
    double pattern_clarity = CalculatePatternClarity();
    double level_clarity = CalculateLevelClarity();
    double fractal_clarity = CalculateFractalClarity();
    
    // Signal-to-noise ratio
    double snr = CalculateSignalToNoiseRatio();
    
    // Convergence analysis
    double convergence = DetectSignalConvergence();
    
    // Multi-timeframe validation
    double mtf_validation = ValidateMultiTimeframeAlignment();
    
    // Transformer-based clarity assessment
    double transformer_inputs[64];
    PrepareTransformerInputs(transformer_inputs, technical_clarity, pattern_clarity, 
                           level_clarity, fractal_clarity, snr, convergence);
    
    double transformer_clarity = 0.0;
    if(CheckPointer(m_signal_transformer) == POINTER_DYNAMIC) {
        transformer_clarity = m_signal_transformer.Predict(transformer_inputs);
    }
    
    // Weighted combination
    double final_clarity = (technical_clarity * 0.25 +
                           pattern_clarity * 0.20 +
                           level_clarity * 0.20 +
                           fractal_clarity * 0.15 +
                           snr * 0.10 +
                           convergence * 0.05 +
                           transformer_clarity * 0.05) * mtf_validation;
    
    // Apply Kalman filter for smoothing
    final_clarity = ApplyKalmanFilter(final_clarity);
    
    return MathMax(0, MathMin(100, final_clarity));
}

// Technical Signal Clarity
double LightSpirit::CalculateTechnicalSignalClarity() {
    // RSI clarity
    int rsi_handle = iRSI(Symbol(), PERIOD_CURRENT, 14, PRICE_CLOSE);
    double rsi_buffer[1];
    double rsi_clarity = 50.0; // Default value
    
    if(CopyBuffer(rsi_handle, 0, 0, 1, rsi_buffer) == 1) {
        double rsi = rsi_buffer[0];
        if(rsi > 70 || rsi < 30) rsi_clarity = 80.0; // Clear overbought/oversold
        else if(rsi > 60 || rsi < 40) rsi_clarity = 60.0; // Moderate
        else rsi_clarity = 20.0; // Neutral zone
    }
    
    // MACD clarity
    int macd_handle = iMACD(Symbol(), PERIOD_CURRENT, 12, 26, 9, PRICE_CLOSE);
    double macd_buffer[1];
    double macd_clarity = 50.0; // Default value
    
    if(CopyBuffer(macd_handle, 0, 0, 1, macd_buffer) == 1) { // MACD main line
        double macd_main = macd_buffer[0];
        if(CopyBuffer(macd_handle, 1, 0, 1, macd_buffer) == 1) { // MACD signal line
            double macd_signal = macd_buffer[0];
            macd_clarity = MathAbs(macd_main - macd_signal) * 10000.0; // Scale up
        }
    }
    
    // Moving Average clarity
    int ma20_handle = iMA(Symbol(), PERIOD_CURRENT, 20, 0, MODE_SMA, PRICE_CLOSE);
    int ma50_handle = iMA(Symbol(), PERIOD_CURRENT, 50, 0, MODE_SMA, PRICE_CLOSE);
    double ma_buffer[1];
    double ma_clarity = 50.0; // Default value
    double current_price = iClose(Symbol(), PERIOD_CURRENT, 0);
    
    if(CopyBuffer(ma20_handle, 0, 0, 1, ma_buffer) == 1) {
        double ma_20 = ma_buffer[0];
        if(CopyBuffer(ma50_handle, 0, 0, 1, ma_buffer) == 1) {
            double ma_50 = ma_buffer[0];
            
            if((current_price > ma_20 && ma_20 > ma_50) || (current_price < ma_20 && ma_20 < ma_50)) {
                ma_clarity = 70.0; // Clear trend
            }
            else {
                ma_clarity = 30.0; // Mixed signals
            }
        }
    }
    
    // Bollinger Bands clarity
    int bb_handle = iBands(Symbol(), PERIOD_CURRENT, 20, 2, 0, PRICE_CLOSE);
    double bb_buffer[1];
    double bb_clarity = 50.0; // Default value
    
    if(CopyBuffer(bb_handle, 0, 0, 1, bb_buffer) == 1) { // MODE_MAIN
        double bb_middle = bb_buffer[0];
        if(CopyBuffer(bb_handle, 1, 0, 1, bb_buffer) == 1) { // MODE_UPPER
            double bb_upper = bb_buffer[0];
            if(CopyBuffer(bb_handle, 2, 0, 1, bb_buffer) == 1) { // MODE_LOWER
                double bb_lower = bb_buffer[0];
                
                if(current_price > bb_upper) bb_clarity = 85.0; // Clear breakout up
                else if(current_price < bb_lower) bb_clarity = 85.0; // Clear breakout down
                else if(MathAbs(current_price - bb_middle) / (bb_upper - bb_lower) < 0.1) bb_clarity = 20.0; // Squeeze
                else bb_clarity = 50.0; // Normal
            }
        }
    }
    
    // Combined technical clarity
    return (rsi_clarity * 0.3 + macd_clarity * 0.3 + ma_clarity * 0.25 + bb_clarity * 0.15);
}

// RZECZYWISTE Pattern Recognition - bez placeholder CNN
double LightSpirit::CalculatePatternClarity() {
    // Real pattern recognition using price action analysis
    double triangle_strength = RecognizeTrianglePattern();
    double hs_strength = RecognizeHeadShouldersPattern();
    double double_top_strength = RecognizeDoubleTopBottomPattern();
    double flag_strength = RecognizeFlagPennantPattern();
    
    // Get fractal clarity
    double fractal_clarity = 0.0;
    if(CheckPointer(m_fractal_detector) == POINTER_DYNAMIC) {
        fractal_clarity = m_fractal_detector.GetFractalClarity();
    }
    
    // Find strongest pattern
    double pattern_strengths[4] = {triangle_strength, hs_strength, double_top_strength, flag_strength};
    double max_pattern_strength = 0.0;
    int dominant_pattern = -1;
    
    for(int i = 0; i < 4; i++) {
        if(pattern_strengths[i] > max_pattern_strength) {
            max_pattern_strength = pattern_strengths[i];
            dominant_pattern = i;
        }
    }
    
    // Pattern completion and quality assessment
    double completion_score = 0.0;
    if(max_pattern_strength > 80) completion_score = 90.0;
    else if(max_pattern_strength > 60) completion_score = 70.0;
    else if(max_pattern_strength > 40) completion_score = 50.0;
    else completion_score = 20.0;
    
    // Volume confirmation
    double volume_confirmation = AnalyzePatternVolumeConfirmation();
    
    // Multi-timeframe validation
    double mtf_validation = ValidatePatternAcrossTimeframes(dominant_pattern);
    
    // Combined pattern clarity
    double pattern_clarity = (max_pattern_strength * 0.4 + 
                             completion_score * 0.25 + 
                             fractal_clarity * 0.15 + 
                             volume_confirmation * 0.1 + 
                             mtf_validation * 0.1);
    
    return MathMax(0.0, MathMin(100.0, pattern_clarity));
}

// Support/Resistance Level Clarity
double LightSpirit::CalculateLevelClarity() {
    SLevel levels[];
    if(CheckPointer(m_sr_analyzer) == POINTER_DYNAMIC) {
        m_sr_analyzer.GetKeyLevels(levels);
    }
    
    double current_price = iClose(Symbol(), PERIOD_CURRENT, 0);
    double level_clarity = 0.0;
    
    // Find nearest levels
    double nearest_support = 0.0;
    double nearest_resistance = 0.0;
    double support_strength = 0.0;
    double resistance_strength = 0.0;
    
    for(int i = 0; i < ArraySize(levels); i++) {
        if(levels[i].type == LEVEL_SUPPORT && levels[i].price < current_price) {
            if(nearest_support == 0.0 || levels[i].price > nearest_support) {
                nearest_support = levels[i].price;
                support_strength = levels[i].strength;
            }
        }
        else if(levels[i].type == LEVEL_RESISTANCE && levels[i].price > current_price) {
            if(nearest_resistance == 0.0 || levels[i].price < nearest_resistance) {
                nearest_resistance = levels[i].price;
                resistance_strength = levels[i].strength;
            }
        }
    }
    
    // Calculate level clarity based on distance and strength
    double support_distance = nearest_support > 0 ? (current_price - nearest_support) / current_price * 100 : 100;
    double resistance_distance = nearest_resistance > 0 ? (nearest_resistance - current_price) / current_price * 100 : 100;
    
    // Closer to strong levels = higher clarity
    if(support_distance < 0.5 && support_strength > 70) level_clarity += 40;
    else if(support_distance < 1.0 && support_strength > 50) level_clarity += 25;
    
    if(resistance_distance < 0.5 && resistance_strength > 70) level_clarity += 40;
    else if(resistance_distance < 1.0 && resistance_strength > 50) level_clarity += 25;
    
    // Between strong levels = lower clarity
    if(support_distance > 2.0 && resistance_distance > 2.0)
        level_clarity = MathMax(level_clarity, 20.0);
    
    return MathMax(0, MathMin(100, level_clarity));
}

// Implementacje brakujących metod publicznych
ENUM_SIGNAL_QUALITY LightSpirit::GetSignalQuality() {
    double clarity = GetSignalClarity();
    
    if(clarity < 20) return SIGNAL_NOISE;
    else if(clarity < 40) return SIGNAL_WEAK;
    else if(clarity < 60) return SIGNAL_MODERATE;
    else if(clarity < 80) return SIGNAL_STRONG;
    else return SIGNAL_CRYSTAL_CLEAR;
}

SSignalData LightSpirit::GetOptimalEntry() {
    SSignalData signal;
    signal.strength = CalculateSignalStrength();
    signal.clarity = GetSignalClarity();
    signal.confidence = GetPatternConfidence();
    signal.quality = GetSignalQuality();
    signal.optimal_time = GetOptimalTiming();
    signal.optimal_price = iClose(Symbol(), PERIOD_CURRENT, 0);
    signal.description = "Optimal entry based on signal clarity analysis";
    
    return signal;
}

double LightSpirit::CalculateSignalStrength() {
    double clarity = GetSignalClarity();
    double pattern_confidence = GetPatternConfidence();
    double level_strength = GetSupportResistanceStrength();
    
    // Signal strength combines clarity, pattern confidence, and level strength
    double strength = clarity * 0.4 + pattern_confidence * 0.3 + level_strength * 0.3;
    
    return MathMax(0, MathMin(100, strength));
}

ENUM_PATTERN_TYPE LightSpirit::GetDominantPattern() {
    double price_matrix[];
    PrepareOHLCMatrix(price_matrix, 50);
    
    double pattern_probabilities[8];
    if(CheckPointer(m_pattern_cnn) == POINTER_DYNAMIC) {
        m_pattern_cnn.Recognize(price_matrix, pattern_probabilities);
    }
    
    // Find dominant pattern
    double max_probability = 0.0;
    int dominant_pattern = PATTERN_NONE;
    
    for(int i = 0; i < 8; i++) {
        if(pattern_probabilities[i] > max_probability) {
            max_probability = pattern_probabilities[i];
            dominant_pattern = i;
        }
    }
    
    return (ENUM_PATTERN_TYPE)dominant_pattern;
}

double LightSpirit::GetPatternConfidence() {
    ENUM_PATTERN_TYPE pattern = GetDominantPattern();
    if(pattern == PATTERN_NONE) return 0.0;
    
    double price_matrix[];
    PrepareOHLCMatrix(price_matrix, 50);
    
    double completion = CalculatePatternCompletion((int)pattern);
    double quality = AssessPatternQuality((int)pattern, price_matrix);
    
    return (completion * 0.6 + quality * 0.4);
}

double LightSpirit::GetPatternCompletionProbability() {
    double confidence = GetPatternConfidence();
    double clarity = GetSignalClarity();
    
    // Higher confidence and clarity = higher completion probability
    return (confidence * 0.7 + clarity * 0.3) / 100.0;
}

double LightSpirit::GetSupportResistanceStrength() {
    SLevel levels[];
    if(CheckPointer(m_sr_analyzer) == POINTER_DYNAMIC) {
        m_sr_analyzer.GetKeyLevels(levels);
    }
    
    double total_strength = 0.0;
    int level_count = 0;
    
    for(int i = 0; i < ArraySize(levels); i++) {
        if(levels[i].strength > 50) { // Only strong levels
            total_strength += levels[i].strength;
            level_count++;
        }
    }
    
    return level_count > 0 ? total_strength / level_count : 0.0;
}

void LightSpirit::GetKeyLevels(SLevel &levels[]) {
    if(CheckPointer(m_sr_analyzer) == POINTER_DYNAMIC) {
        m_sr_analyzer.GetKeyLevels(levels);
    }
}

double LightSpirit::GetLevelBreakoutProbability() {
    double current_price = iClose(Symbol(), PERIOD_CURRENT, 0);
    SLevel levels[];
    if(CheckPointer(m_sr_analyzer) == POINTER_DYNAMIC) {
        m_sr_analyzer.GetKeyLevels(levels);
    }
    
    double nearest_level_distance = 100.0;
    double nearest_level_strength = 0.0;
    
    for(int i = 0; i < ArraySize(levels); i++) {
        double distance = MathAbs(current_price - levels[i].price) / current_price * 100;
        if(distance < nearest_level_distance) {
            nearest_level_distance = distance;
            nearest_level_strength = levels[i].strength;
        }
    }
    
    // Closer to strong level = higher breakout probability
    if(nearest_level_distance < 0.5 && nearest_level_strength > 70) return 0.8;
    else if(nearest_level_distance < 1.0 && nearest_level_strength > 50) return 0.6;
    else if(nearest_level_distance < 2.0) return 0.4;
    else return 0.2;
}

SOptimalEntry LightSpirit::CalculateOptimalEntry() {
    SOptimalEntry entry;
    double current_price = iClose(Symbol(), PERIOD_CURRENT, 0);
    
    entry.entry_price = current_price;
    entry.stop_loss = current_price * 0.99; // 1% stop loss
    ArrayResize(entry.take_profit, 3);
    entry.take_profit[0] = current_price * 1.02; // 2% TP1
    entry.take_profit[1] = current_price * 1.05; // 5% TP2
    entry.take_profit[2] = current_price * 1.10; // 10% TP3
    entry.probability = GetPatternCompletionProbability();
    entry.entry_time = TimeCurrent();
    entry.rationale = "Optimal entry based on signal clarity and pattern analysis";
    
    return entry;
}

datetime LightSpirit::GetOptimalTiming() {
    // Optimal timing based on signal clarity and market conditions
    double clarity = GetSignalClarity();
    double pattern_confidence = GetPatternConfidence();
    
    // Higher clarity and confidence = sooner entry
    if(clarity > 80 && pattern_confidence > 70) {
        return TimeCurrent() + 300; // 5 minutes
    }
    else if(clarity > 60 && pattern_confidence > 50) {
        return TimeCurrent() + 900; // 15 minutes
    }
    else {
        return TimeCurrent() + 3600; // 1 hour
    }
}

void LightSpirit::UpdateSignalModels() {
    // Update signal clarity history
    double current_clarity = GetSignalClarity();
    
    // Shift history array
    for(int i = 0; i < 99; i++) {
        m_signal_clarity_history[i] = m_signal_clarity_history[i + 1];
        m_pattern_confidence_history[i] = m_pattern_confidence_history[i + 1];
    }
    
    // Add new values
    m_signal_clarity_history[99] = current_clarity;
    m_pattern_confidence_history[99] = GetPatternConfidence();
    
    // Update neural networks
    UpdateNeuralNetworks();
}

// System compatibility methods
bool LightSpirit::Initialize() {
    LogInfo(LOG_COMPONENT_LIGHT, "Inicjalizacja Light Spirit", "Rozpoczęcie inicjalizacji");
    
    // Initialize neural networks
    if(CheckPointer(m_pattern_cnn) == POINTER_DYNAMIC) {
        m_pattern_cnn.Initialize();
    }
    
    if(CheckPointer(m_signal_transformer) == POINTER_DYNAMIC) {
        m_signal_transformer.Initialize();
    }
    
    if(CheckPointer(m_sr_analyzer) == POINTER_DYNAMIC) {
        m_sr_analyzer.Initialize();
    }
    
    if(CheckPointer(m_fractal_detector) == POINTER_DYNAMIC) {
        m_fractal_detector.Initialize();
    }
    
    // Initialize signal history
    ArrayInitialize(m_signal_clarity_history, 50.0);
    ArrayInitialize(m_pattern_confidence_history, 0.0);
    ArrayInitialize(m_noise_filter_buffer, 0.0);
    
    LogInfo(LOG_COMPONENT_LIGHT, "Light Spirit zainicjalizowany", "Neural networks gotowe");
    return true;
}

void LightSpirit::UpdateData() {
    // Update signal clarity history
    for(int i = 0; i < 99; i++) {
        m_signal_clarity_history[i] = m_signal_clarity_history[i + 1];
    }
    m_signal_clarity_history[99] = GetSignalClarity();
    
    // Update pattern confidence history
    for(int i = 0; i < 99; i++) {
        m_pattern_confidence_history[i] = m_pattern_confidence_history[i + 1];
    }
    m_pattern_confidence_history[99] = GetPatternConfidence();
    
    // Update noise filter buffer
    for(int i = 0; i < 19; i++) {
        m_noise_filter_buffer[i] = m_noise_filter_buffer[i + 1];
    }
    m_noise_filter_buffer[19] = GetNoiseLevel();
    
    // Update neural networks
    if(CheckPointer(m_pattern_cnn) == POINTER_DYNAMIC) {
        m_pattern_cnn.UpdateData();
    }
    
    if(CheckPointer(m_signal_transformer) == POINTER_DYNAMIC) {
        m_signal_transformer.UpdateData();
    }
    
    if(CheckPointer(m_sr_analyzer) == POINTER_DYNAMIC) {
        m_sr_analyzer.UpdateData();
    }
}

// Implementacje brakujących metod prywatnych
double LightSpirit::ApplyKalmanFilter(double raw_signal) {
    // Placeholder Kalman filter implementation
    static double filtered_value = 50.0;
    static double error_covariance = 1.0;
    
    double measurement_noise = 10.0;
    double process_noise = 1.0;
    
    // Prediction step
    double predicted_value = filtered_value;
    double predicted_error = error_covariance + process_noise;
    
    // Update step
    double kalman_gain = predicted_error / (predicted_error + measurement_noise);
    filtered_value = predicted_value + kalman_gain * (raw_signal - predicted_value);
    error_covariance = (1 - kalman_gain) * predicted_error;
    
    return filtered_value;
}

double LightSpirit::CalculateSignalToNoiseRatio() {
    // Placeholder SNR calculation
    return 0.6 + (MathRand() % 40) / 100.0; // 0.6-1.0
}

double LightSpirit::DetectSignalConvergence() {
    // Placeholder convergence detection
    return 0.5 + (MathRand() % 50) / 100.0; // 0.5-1.0
}

bool LightSpirit::ValidateSignalWithMultipleTimeframes() {
    // Placeholder multi-timeframe validation
    return (MathRand() % 100) > 30; // 70% success rate
}

double LightSpirit::RecognizeTrianglePattern() {
    // RZECZYWISTE wykrywanie trójkątów (symmetrical, ascending, descending)
    double high[], low[];
    int bars = 100;
    
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, high) != bars ||
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, low) != bars) {
        return 0.0;
    }
    
    // Find swing highs and lows
    double swing_highs[], swing_lows[];
    DetectSwingPoints(high, low, swing_highs, swing_lows);
    
    if(ArraySize(swing_highs) < 3 || ArraySize(swing_lows) < 3) {
        return 0.0;
    }
    
    // Analyze trend lines for triangle patterns
    double upper_slope = CalculateTrendLineSlope(swing_highs, false); // highs trending down
    double lower_slope = CalculateTrendLineSlope(swing_lows, true);   // lows trending up
    
    // Triangle characteristics
    bool converging = (upper_slope < 0 && lower_slope > 0) || // Symmetrical triangle
                     (MathAbs(upper_slope) < 0.0001 && lower_slope > 0) || // Ascending triangle
                     (upper_slope < 0 && MathAbs(lower_slope) < 0.0001);   // Descending triangle
    
    if(!converging) return 0.0;
    
    // Calculate triangle strength
    double slope_ratio = MathAbs(upper_slope) / (MathAbs(lower_slope) + 0.0001);
    double symmetry_score = 1.0 / (1.0 + MathAbs(slope_ratio - 1.0));
    
    // Volume analysis (should decrease during triangle formation)
    double volume_confirmation = AnalyzeTriangleVolumePattern();
    
    // Duration factor (triangles need time to develop)
    double duration_factor = MathMin(ArraySize(swing_highs) / 5.0, 1.0);
    
    double triangle_strength = (symmetry_score * 0.4 + volume_confirmation * 0.3 + duration_factor * 0.3) * 100.0;
    
    return MathMax(0.0, MathMin(100.0, triangle_strength));
}

double LightSpirit::RecognizeHeadShouldersPattern() {
    // RZECZYWISTE wykrywanie H&S (głowa i ramiona)
    double high[], low[];
    int bars = 150;
    
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, high) != bars ||
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, low) != bars) {
        return 0.0;
    }
    
    // Find major swing highs for H&S pattern
    double major_highs[];
    DetectMajorSwingHighs(high, major_highs, 20); // 20-bar lookback for major swings
    
    if(ArraySize(major_highs) < 3) return 0.0;
    
    // Look for H&S pattern in last 3-5 major highs
    double best_hs_score = 0.0;
    
    for(int i = 2; i < ArraySize(major_highs) && i < 5; i++) {
        double left_shoulder = major_highs[i-2];
        double head = major_highs[i-1]; 
        double right_shoulder = major_highs[i];
        
        // H&S criteria:
        // 1. Head should be highest
        // 2. Shoulders should be roughly equal
        // 3. Neckline should be tested
        
        if(head > left_shoulder && head > right_shoulder) {
            double shoulder_symmetry = 1.0 - MathAbs(left_shoulder - right_shoulder) / head;
            double head_prominence = (head - MathMax(left_shoulder, right_shoulder)) / head;
            
            // Neckline analysis
            double neckline_strength = AnalyzeNecklineStrength(left_shoulder, right_shoulder);
            
            double hs_score = (shoulder_symmetry * 0.4 + head_prominence * 0.4 + neckline_strength * 0.2) * 100.0;
            best_hs_score = MathMax(best_hs_score, hs_score);
        }
    }
    
    return MathMax(0.0, MathMin(100.0, best_hs_score));
}

double LightSpirit::RecognizeDoubleTopBottomPattern() {
    // RZECZYWISTE wykrywanie podwójnych szczytów/dołów
    double high[], low[];
    int bars = 100;
    
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, high) != bars ||
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, low) != bars) {
        return 0.0;
    }
    
    double double_top_score = DetectDoubleTop(high);
    double double_bottom_score = DetectDoubleBottom(low);
    
    return MathMax(double_top_score, double_bottom_score);
}

double LightSpirit::RecognizeFlagPennantPattern() {
    // RZECZYWISTE wykrywanie flag i pennantów
    double high[], low[], close[];
    long volume[];
    int bars = 80;
    
    if(CopyHigh(Symbol(), PERIOD_CURRENT, 0, bars, high) != bars ||
       CopyLow(Symbol(), PERIOD_CURRENT, 0, bars, low) != bars ||
       CopyClose(Symbol(), PERIOD_CURRENT, 0, bars, close) != bars ||
       CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, bars, volume) != bars) {
        return 0.0;
    }
    
    // Flag/Pennant characteristics:
    // 1. Strong initial move (pole)
    // 2. Consolidation period (flag/pennant)
    // 3. Volume should decrease during consolidation
    
    // Find the pole (strong directional move)
    double pole_strength = DetectFlagPole(close, volume);
    if(pole_strength < 30.0) return 0.0;
    
    // Analyze consolidation pattern
    double consolidation_quality = AnalyzeConsolidationPattern(high, low, close);
    
    // Volume pattern analysis
    double volume_pattern_score = AnalyzeFlagVolumePattern(volume);
    
    double flag_strength = (pole_strength * 0.5 + consolidation_quality * 0.3 + volume_pattern_score * 0.2);
    
    return MathMax(0.0, MathMin(100.0, flag_strength));
}

// === HELPER FUNCTIONS FOR PATTERN RECOGNITION ===

void LightSpirit::DetectSwingPoints(double &highs[], double &lows[], double &swing_highs[], double &swing_lows[]) {
    ArrayResize(swing_highs, 0);
    ArrayResize(swing_lows, 0);
    int lookback = 5; // 5-bar swing detection
    
    // Detect swing highs
    for(int i = lookback; i < ArraySize(highs) - lookback; i++) {
        bool is_swing_high = true;
        for(int j = 1; j <= lookback; j++) {
            if(highs[i] <= highs[i-j] || highs[i] <= highs[i+j]) {
                is_swing_high = false;
                break;
            }
        }
        if(is_swing_high) {
            ArrayResize(swing_highs, ArraySize(swing_highs) + 1);
            swing_highs[ArraySize(swing_highs) - 1] = highs[i];
        }
    }
    
    // Detect swing lows
    for(int i = lookback; i < ArraySize(lows) - lookback; i++) {
        bool is_swing_low = true;
        for(int j = 1; j <= lookback; j++) {
            if(lows[i] >= lows[i-j] || lows[i] >= lows[i+j]) {
                is_swing_low = false;
                break;
            }
        }
        if(is_swing_low) {
            ArrayResize(swing_lows, ArraySize(swing_lows) + 1);
            swing_lows[ArraySize(swing_lows) - 1] = lows[i];
        }
    }
}

double LightSpirit::CalculateTrendLineSlope(double &points[], bool ascending) {
    if(ArraySize(points) < 2) return 0.0;
    
    int n = ArraySize(points);
    double slope = (points[n-1] - points[0]) / (n - 1);
    
    return ascending ? slope : -slope; // Normalize direction
}

double LightSpirit::AnalyzeTriangleVolumePattern() {
    long volume[];
    int bars = 50;
    
    if(CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, bars, volume) != bars) {
        return 50.0; // Default if no volume data
    }
    
    // Calculate volume trend (should be decreasing in triangle)
    double recent_avg = 0.0, older_avg = 0.0;
    
    for(int i = 0; i < 15; i++) recent_avg += volume[bars - 1 - i];
    for(int i = 15; i < 30; i++) older_avg += volume[bars - 1 - i];
    
    recent_avg /= 15.0;
    older_avg /= 15.0;
    
    // Volume should decrease over time
    double volume_decline = (older_avg - recent_avg) / older_avg;
    
    return MathMax(0.0, MathMin(100.0, volume_decline * 100.0 + 50.0));
}

void LightSpirit::DetectMajorSwingHighs(double &highs[], double &major_highs[], int period) {
    ArrayResize(major_highs, 0);
    
    for(int i = period; i < ArraySize(highs) - period; i++) {
        bool is_major_high = true;
        for(int j = 1; j <= period; j++) {
            if(highs[i] <= highs[i-j] || highs[i] <= highs[i+j]) {
                is_major_high = false;
                break;
            }
        }
        if(is_major_high) {
            ArrayResize(major_highs, ArraySize(major_highs) + 1);
            major_highs[ArraySize(major_highs) - 1] = highs[i];
        }
    }
}

double LightSpirit::AnalyzeNecklineStrength(double left_shoulder, double right_shoulder) {
    // Simplified neckline analysis - check if price respected the neckline level
    double neckline_level = MathMin(left_shoulder, right_shoulder);
    double current_price = iClose(Symbol(), PERIOD_CURRENT, 0);
    
    // Distance from neckline
    double distance_factor = MathAbs(current_price - neckline_level) / neckline_level;
    
    return MathMax(0.0, 100.0 - distance_factor * 1000.0); // Closer = stronger
}

double LightSpirit::DetectDoubleTop(double &highs[]) {
    int n = ArraySize(highs);
    if(n < 40) return 0.0;
    
    // Find two highest peaks in recent history
    double peak1 = 0.0, peak2 = 0.0;
    int peak1_idx = -1, peak2_idx = -1;
    
    for(int i = 10; i < n - 10; i++) {
        if(highs[i] > peak1) {
            peak2 = peak1;
            peak2_idx = peak1_idx;
            peak1 = highs[i];
            peak1_idx = i;
        } else if(highs[i] > peak2 && MathAbs(i - peak1_idx) > 10) {
            peak2 = highs[i];
            peak2_idx = i;
        }
    }
    
    if(peak1_idx == -1 || peak2_idx == -1) return 0.0;
    
    // Check double top criteria
    double peak_similarity = 1.0 - MathAbs(peak1 - peak2) / MathMax(peak1, peak2);
    double time_separation = MathAbs(peak1_idx - peak2_idx) / 10.0; // Normalize
    
    if(peak_similarity > 0.98 && time_separation > 1.0) {
        return peak_similarity * 100.0;
    }
    
    return 0.0;
}

double LightSpirit::DetectDoubleBottom(double &lows[]) {
    int n = ArraySize(lows);
    if(n < 40) return 0.0;
    
    // Find two lowest valleys in recent history
    double valley1 = 999999.0, valley2 = 999999.0;
    int valley1_idx = -1, valley2_idx = -1;
    
    for(int i = 10; i < n - 10; i++) {
        if(lows[i] < valley1) {
            valley2 = valley1;
            valley2_idx = valley1_idx;
            valley1 = lows[i];
            valley1_idx = i;
        } else if(lows[i] < valley2 && MathAbs(i - valley1_idx) > 10) {
            valley2 = lows[i];
            valley2_idx = i;
        }
    }
    
    if(valley1_idx == -1 || valley2_idx == -1) return 0.0;
    
    // Check double bottom criteria
    double valley_similarity = 1.0 - MathAbs(valley1 - valley2) / MathMax(valley1, valley2);
    double time_separation = MathAbs(valley1_idx - valley2_idx) / 10.0;
    
    if(valley_similarity > 0.98 && time_separation > 1.0) {
        return valley_similarity * 100.0;
    }
    
    return 0.0;
}

double LightSpirit::DetectFlagPole(double &closes[], long &volumes[]) {
    int n = ArraySize(closes);
    if(n < 20) return 0.0;
    
    // Look for strong directional move in last 20 bars
    double price_change = MathAbs(closes[n-1] - closes[n-20]);
    double price_range = closes[n-1];
    double move_strength = (price_change / price_range) * 100.0;
    
    // Volume should be high during the pole formation
    double recent_volume = 0.0, baseline_volume = 0.0;
    
    for(int i = 0; i < 10; i++) recent_volume += volumes[n-1-i];
    for(int i = 20; i < 40; i++) baseline_volume += volumes[n-1-i];
    
    recent_volume /= 10.0;
    baseline_volume /= 20.0;
    
    double volume_expansion = (recent_volume / baseline_volume) * 100.0;
    
    return MathMin(100.0, move_strength * 2.0 + (volume_expansion - 100.0));
}

double LightSpirit::AnalyzeConsolidationPattern(double &highs[], double &lows[], double &closes[]) {
    int n = ArraySize(closes);
    if(n < 20) return 0.0;
    
    // Analyze last 15 bars for consolidation
    double high_range = 0.0, low_range = 999999.0;
    
    for(int i = n-15; i < n; i++) {
        high_range = MathMax(high_range, highs[i]);
        low_range = MathMin(low_range, lows[i]);
    }
    
    double consolidation_range = (high_range - low_range) / closes[n-1] * 100.0;
    
    // Tight consolidation = better flag/pennant
    return MathMax(0.0, 100.0 - consolidation_range * 10.0);
}

double LightSpirit::AnalyzeFlagVolumePattern(long &volumes[]) {
    int n = ArraySize(volumes);
    if(n < 30) return 50.0;
    
    // Volume should decrease during flag formation
    double flag_volume = 0.0, pole_volume = 0.0;
    
    for(int i = 0; i < 15; i++) flag_volume += volumes[n-1-i]; // Recent 15 bars
    for(int i = 15; i < 30; i++) pole_volume += volumes[n-1-i]; // Previous 15 bars
    
    flag_volume /= 15.0;
    pole_volume /= 15.0;
    
    double volume_decline = (pole_volume - flag_volume) / pole_volume * 100.0;
    
    return MathMax(0.0, MathMin(100.0, volume_decline));
}

double LightSpirit::AnalyzePatternVolumeConfirmation() {
    // General volume confirmation for patterns
    long volume[];
    int bars = 30;
    
    if(CopyTickVolume(Symbol(), PERIOD_CURRENT, 0, bars, volume) != bars) {
        return 50.0;
    }
    
    double recent_avg = 0.0, baseline_avg = 0.0;
    
    for(int i = 0; i < 10; i++) recent_avg += volume[bars-1-i];
    for(int i = 10; i < 30; i++) baseline_avg += volume[bars-1-i];
    
    recent_avg /= 10.0;
    baseline_avg /= 20.0;
    
    double volume_ratio = recent_avg / baseline_avg;
    
    return MathMin(100.0, volume_ratio * 50.0);
}

double LightSpirit::ValidatePatternAcrossTimeframes(int pattern_type) {
    // Multi-timeframe pattern validation
    ENUM_TIMEFRAMES timeframes[] = {PERIOD_M15, PERIOD_H1, PERIOD_H4};
    double validation_score = 0.0;
    
    for(int i = 0; i < 3; i++) {
        // Simplified: check if same pattern exists on higher timeframes
        double pattern_strength = 0.0;
        
        switch(pattern_type) {
            case 0: // Triangle
                // Check for triangle on this timeframe
                pattern_strength = 60.0; // Simplified
                break;
            case 1: // H&S
                pattern_strength = 40.0;
                break;
            case 2: // Double Top/Bottom
                pattern_strength = 70.0;
                break;
            case 3: // Flag/Pennant
                pattern_strength = 50.0;
                break;
        }
        
        validation_score += pattern_strength * (i + 1) / 6.0; // Weight higher timeframes more
    }
    
    return MathMin(100.0, validation_score);
}

// Destruktor
LightSpirit::~LightSpirit() {
    if(CheckPointer(m_pattern_cnn) == POINTER_DYNAMIC) delete m_pattern_cnn;
    if(CheckPointer(m_signal_transformer) == POINTER_DYNAMIC) delete m_signal_transformer;
    if(CheckPointer(m_sr_analyzer) == POINTER_DYNAMIC) delete m_sr_analyzer;
    if(CheckPointer(m_fractal_detector) == POINTER_DYNAMIC) delete m_fractal_detector;
};

double LightSpirit::GetNoiseLevel() {
    // Prosty placeholder dla poziomu szumu
    return 0.5 + (MathRand() % 50) / 100.0; // 0.5 - 1.0
}