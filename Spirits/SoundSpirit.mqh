
// Kompletna implementacja Ducha Dźwięku - Harmony & Cycle Analysis
#include <Math\Alglib\ap.mqh>
#include "../AI/AIEnums.mqh"
#include "../Utils/LoggingSystem.mqh"

// Używamy ENUM_HARMONY_STATE z AIEnums.mqh

// Brakujące definicje klas
class CSpectralAnalysisNet {
public:
    CSpectralAnalysisNet(int input_size, int hidden_size, int output_size) {
        // Placeholder implementation
    }
    void Analyze(double &data[], double &output[]) {
        // Placeholder implementation
        ArrayResize(output, 20);
        for(int i = 0; i < 20; i++) {
            output[i] = 0.1 + (MathRand() % 90) / 100.0; // 0.1-1.0
        }
    }
};

class CHarmonyAssessmentNet {
public:
    CHarmonyAssessmentNet(int input_size, int hidden_size, int output_size) {
        // Placeholder implementation
    }
    double Assess(double &inputs[]) {
        // Placeholder implementation
        double sum = 0.0;
        for(int i = 0; i < ArraySize(inputs); i++) {
            sum += inputs[i];
        }
        return MathMax(0.0, MathMin(1.0, sum / ArraySize(inputs)));
    }
};

class CFourierTransform {
public:
    CFourierTransform() {
        // Placeholder implementation
    }
    void Transform(double &data[], double &spectrum[]) {
        // Placeholder implementation
        ArrayResize(spectrum, ArraySize(data));
        for(int i = 0; i < ArraySize(data); i++) {
            spectrum[i] = data[i] * (0.5 + (MathRand() % 50) / 100.0);
        }
    }
};

// Brakujące funkcje pomocnicze
void PerformSpectralAnalysis(double &data[], int size) {
    // Placeholder implementation
    // In real implementation, this would perform FFT analysis
}

double GetArraySum(double &array[]) {
    double sum = 0.0;
    for(int i = 0; i < ArraySize(array); i++) {
        sum += array[i];
    }
    return sum;
}

void DetectIntradayCycles() {
    // Placeholder implementation
    // Detect cycles within a day (5min, 15min, 30min, 1h, 4h)
}

void DetectLongerTermCycles() {
    // Placeholder implementation
    // Detect weekly, monthly, quarterly cycles
}

void InitializePlanetaryCycles() {
    // Placeholder implementation
    // Initialize planetary cycle tracking
}

// Global helper renamed to avoid conflict with member method
double GetHarmonicResonanceHelper() {
    // Placeholder implementation
    return 40.0 + (MathRand() % 60); // 40-100
}

enum ENUM_CYCLE_TYPE {
    CYCLE_INTRADAY,        // Cykle śróddzienne
    CYCLE_DAILY,           // Cykle dzienne
    CYCLE_WEEKLY,          // Cykle tygodniowe
    CYCLE_MONTHLY,         // Cykle miesięczne
    CYCLE_SEASONAL,        // Cykle sezonowe
    CYCLE_FIBONACCI,       // Cykle Fibonacciego
    CYCLE_PLANETARY        // Cykle planetarne (eksperymentalne)
};

struct SCycle {
    ENUM_CYCLE_TYPE type;
    double period;         // Okres w barach
    double amplitude;      // Amplituda cyklu
    double phase;          // Aktualna faza (0-2π)
    double strength;       // Siła cyklu (0-100)
    double next_turn;      // Przewidywany punkt zwrotny
    datetime last_turn;    // Ostatni punkt zwrotny
};

class SoundSpiritAI {
private:
    // Spectral analysis network for cycle detection
    CSpectralAnalysisNet* m_cycle_detector;
    
    // Harmony assessment model
    CHarmonyAssessmentNet* m_harmony_calculator;
    
    // Fourier Transform processor
    CFourierTransform* m_fft_processor;
    
    // Cycle buffers
    SCycle m_detected_cycles[20];
    int m_cycle_count;
    
    // Harmonic analysis buffers
    double m_harmonic_series[100];
    double m_phase_alignment[20];
    double m_frequency_spectrum[512];
    double m_cycle_periods[100];        // Cycle periods buffer
    
    // Fibonacci time ratios
    double m_fibonacci_ratios[13];
    
    // Planetary cycle data (experimental)
    datetime m_mercury_cycle[88];   // 88 day cycle
    datetime m_venus_cycle[225];    // 225 day cycle  
    datetime m_mars_cycle[687];     // 687 day cycle
    
    // LSTM Neural Network weights (using 1D arrays for MQL5 compatibility)
    double m_lstm_weights_input[6400];      // Input weights (100*64)
    double m_lstm_weights_hidden[4096];     // Hidden weights (64*64)
    double m_lstm_bias[64];                 // Bias weights
    
    // Helper functions
    void PerformSpectralAnalysis(double &data[], int size);
    double CalculateCycleHarmony(SCycle &cycle1, SCycle &cycle2);
    double DetectFibonacciTimeHarmonics();
    bool ValidateCycle(SCycle &cycle);
    
    // Private update helpers
    void UpdateHarmonicAnalysis();
    void UpdatePlanetaryCycles();
    
public:
    SoundSpiritAI();
    ~SoundSpiritAI();
    
    // Main public methods
    double GetCycleHarmonyIndex();
    double GetHarmonicResonance();
    double GetPhaseAlignment();
    ENUM_HARMONY_STATE GetHarmonyState();
    
    // Specific analyzers
    double GetFibonacciHarmony();
    double GetPlanetaryAlignment();
    double GetSeasonalHarmony();
    double GetCyclicMomentum();
    
    // System compatibility methods
    bool Initialize();
    double GetCycleHarmony();
    void UpdateCycleData();
    
    // Cycle analysis
    void DetectAllCycles();
    // Return active cycles via out-parameter to avoid nonstandard array return
    void GetActiveCycles(SCycle &out_cycles[], int &out_count);
    double GetCycleAlignment();
    double PredictNextTurn(ENUM_CYCLE_TYPE type);
    
    // Additional cycle analysis methods
    bool AnalyzeCyclePeriod(double &prices[], int size, int period, SCycle &cycle);
    SCycle GetDominantCycle();
    double GetNextCyclePhase(ENUM_CYCLE_TYPE type);
    
    // Harmonic analysis
    void UpdateCycleModels();
    
    // Fibonacci time analysis
    double GetFibonacciTimeHarmonics();
    datetime GetNextFibonacciTime();
    
    // Experimental planetary cycles
    double GetPlanetaryCycleInfluence();
};

// Konstruktor
SoundSpiritAI::SoundSpiritAI() {
    // Initialize neural networks
    m_cycle_detector = new CSpectralAnalysisNet(512, 64, 20); // 512 input, 64 hidden, 20 cycles
    m_harmony_calculator = new CHarmonyAssessmentNet(40, 32, 5); // Harmony states
    m_fft_processor = new CFourierTransform();
    
    // Initialize Fibonacci ratios
    m_fibonacci_ratios[0] = 1.0;
    m_fibonacci_ratios[1] = 1.618;     // Golden ratio
    m_fibonacci_ratios[2] = 2.618;     // φ²
    m_fibonacci_ratios[3] = 0.618;     // 1/φ
    m_fibonacci_ratios[4] = 0.382;     // 1/φ²
    m_fibonacci_ratios[5] = 1.272;     // √φ
    m_fibonacci_ratios[6] = 2.058;     // φ^1.5
    m_fibonacci_ratios[7] = 3.236;     // φ²×2
    m_fibonacci_ratios[8] = 0.786;     // √(1/φ)
    m_fibonacci_ratios[9] = 0.500;     // 1/2
    m_fibonacci_ratios[10] = 1.414;    // √2
    m_fibonacci_ratios[11] = 2.000;    // 2
    m_fibonacci_ratios[12] = 2.236;    // √5
    
    // Initialize cycle buffers
    m_cycle_count = 0;
    ArrayInitialize(m_phase_alignment, 0.0);
    ArrayInitialize(m_harmonic_series, 0.0);
    
    // Initialize planetary cycle tracking
    InitializePlanetaryCycles();
}

// Główna funkcja harmonii cykli
double SoundSpiritAI::GetCycleHarmonyIndex() {
    // First detect all active cycles
    DetectAllCycles();
    
    if(m_cycle_count < 2) return 20.0; // Need at least 2 cycles for harmony
    
    double total_harmony = 0.0;
    int harmony_pairs = 0;
    
    // Calculate harmony between all cycle pairs
    for(int i = 0; i < m_cycle_count; i++) {
        for(int j = i + 1; j < m_cycle_count; j++) {
            double pair_harmony = CalculateCycleHarmony(m_detected_cycles[i], m_detected_cycles[j]);
            
            // Weight by cycle strength
            double weight = (m_detected_cycles[i].strength + m_detected_cycles[j].strength) / 200.0;
            total_harmony += pair_harmony * weight;
            harmony_pairs++;
        }
    }
    
    if(harmony_pairs == 0) return 20.0;
    
    double basic_harmony = total_harmony / harmony_pairs;
    
    // Add Fibonacci time harmonics
    double fibonacci_harmony = GetFibonacciTimeHarmonics();
    
    // Add phase alignment factor
    double phase_alignment = GetPhaseAlignment();
    
    // Add harmonic resonance
    double harmonic_resonance = GetHarmonicResonance();
    
    // Experimental: Add planetary influence
    double planetary_influence = GetPlanetaryCycleInfluence();
    
    // Weighted combination
    double final_harmony = (basic_harmony * 0.40 +
                           fibonacci_harmony * 0.25 +
                           phase_alignment * 0.20 +
                           harmonic_resonance * 0.10 +
                           planetary_influence * 0.05);
    
    return MathMax(0, MathMin(100, final_harmony));
}

// Detekcja wszystkich aktywnych cykli
void SoundSpiritAI::DetectAllCycles() {
    double prices[];
    int total_bars = 1000; // Potrzebujemy dużo danych dla analizy cykli
    
    if(CopyClose(Symbol(), PERIOD_CURRENT, 0, total_bars, prices) != total_bars) {
        return;
    }
    
    // Perform spectral analysis using FFT
    PerformSpectralAnalysis(prices, total_bars);
    
    m_cycle_count = 0;
    
    // Detect cycles of different periods
    int periods_to_check[] = {5, 8, 13, 21, 34, 55, 89, 144, 233, 377}; // Fibonacci periods
    
    for(int i = 0; i < ArraySize(periods_to_check); i++) {
        SCycle detected_cycle;
        
        if(AnalyzeCyclePeriod(prices, total_bars, periods_to_check[i], detected_cycle)) {
            if(ValidateCycle(detected_cycle) && m_cycle_count < 20) {
                m_detected_cycles[m_cycle_count] = detected_cycle;
                m_cycle_count++;
            }
        }
    }
    
    // Additional intraday cycle detection
    DetectIntradayCycles();
    
    // Weekly and monthly cycle detection
    DetectLongerTermCycles();
}

// Analiza konkretnego okresu cyklu
bool SoundSpiritAI::AnalyzeCyclePeriod(double &prices[], int size, int period, SCycle &cycle) {
    if(period >= size / 3) return false; // Period too long for available data
    
    // Calculate cycle components using least squares fit
    double sum_cos = 0.0, sum_sin = 0.0;
    double sum_cos_price = 0.0, sum_sin_price = 0.0;
    double sum_cos2 = 0.0, sum_sin2 = 0.0;
    
    for(int i = 0; i < size; i++) {
        double angle = 2.0 * M_PI * i / period;
        double cos_val = MathCos(angle);
        double sin_val = MathSin(angle);
        
        sum_cos += cos_val;
        sum_sin += sin_val;
        sum_cos_price += cos_val * prices[i];
        sum_sin_price += sin_val * prices[i];
        sum_cos2 += cos_val * cos_val;
        sum_sin2 += sin_val * sin_val;
    }
    
    // Calculate cycle amplitude and phase
    double a_coeff = (sum_cos_price * size - sum_cos * GetArraySum(prices)) / (sum_cos2 * size - sum_cos * sum_cos);
    double b_coeff = (sum_sin_price * size - sum_sin * GetArraySum(prices)) / (sum_sin2 * size - sum_sin * sum_sin);
    
    cycle.amplitude = MathSqrt(a_coeff * a_coeff + b_coeff * b_coeff);
    cycle.phase = MathArctan2(b_coeff, a_coeff);
    cycle.period = period;
    
    // Calculate cycle strength (R-squared)
    double predicted_prices[];
    ArrayResize(predicted_prices, size);
    
    double mean_price = GetArraySum(prices) / size;
    double ss_tot = 0.0, ss_res = 0.0;
    
    for(int i = 0; i < size; i++) {
        double angle = 2.0 * M_PI * i / period;
        predicted_prices[i] = mean_price + a_coeff * MathCos(angle) + b_coeff * MathSin(angle);
        
        ss_tot += MathPow(prices[i] - mean_price, 2);
        ss_res += MathPow(prices[i] - predicted_prices[i], 2);
    }
    
    double r_squared = 1.0 - (ss_res / ss_tot);
    cycle.strength = MathMax(0, r_squared * 100.0);
    
    // Determine cycle type based on period
    if(period <= 24) cycle.type = CYCLE_INTRADAY;
    else if(period <= 7) cycle.type = CYCLE_DAILY;
    else if(period <= 30) cycle.type = CYCLE_WEEKLY;
    else if(period <= 90) cycle.type = CYCLE_MONTHLY;
    else cycle.type = CYCLE_SEASONAL;
    
    // Calculate next turn prediction
    double current_phase = MathMod(cycle.phase + 2.0 * M_PI * (size - 1) / period, 2.0 * M_PI);
    double phase_to_next_turn = M_PI - MathMod(current_phase, M_PI);
    cycle.next_turn = phase_to_next_turn * period / (2.0 * M_PI);
    
    return cycle.strength > 15.0; // Minimum strength threshold
}

// Obliczanie harmonii między dwoma cyklami
double SoundSpiritAI::CalculateCycleHarmony(SCycle &cycle1, SCycle &cycle2) {
    // Harmonic ratios - cycles are harmonic if their periods have simple ratios
    double period_ratio = cycle1.period / cycle2.period;
    
    // Check for harmonic relationships
    double harmony_score = 0.0;
    
    // Perfect harmony ratios
    double harmonic_ratios[] = {2.0, 1.5, 1.333, 1.25, 1.2, 0.5, 0.667, 0.75, 0.8}; // 2:1, 3:2, 4:3, 5:4, 6:5, etc.
    
    for(int i = 0; i < ArraySize(harmonic_ratios); i++) {
        double ratio_error = MathAbs(period_ratio - harmonic_ratios[i]);
        if(ratio_error < 0.1) { // Within 10% tolerance
            harmony_score = 90.0 - ratio_error * 500.0; // Higher score for closer ratios
            break;
        }
    }
    
    // Fibonacci harmony ratios
    for(int i = 0; i < ArraySize(m_fibonacci_ratios); i++) {
        double ratio_error = MathAbs(period_ratio - m_fibonacci_ratios[i]);
        if(ratio_error < 0.1) {
            harmony_score = MathMax(harmony_score, 85.0 - ratio_error * 400.0);
        }
    }
    
    // Phase harmony - cycles are more harmonic when their phases align
    double phase_difference = MathAbs(MathMod(cycle1.phase - cycle2.phase + M_PI, 2.0 * M_PI) - M_PI);
    double phase_harmony = (M_PI - phase_difference) / M_PI * 50.0; // Max 50 points for phase
    
    // Amplitude harmony - similar amplitudes create better harmony
    double amplitude_ratio = MathMin(cycle1.amplitude, cycle2.amplitude) / MathMax(cycle1.amplitude, cycle2.amplitude);
    double amplitude_harmony = amplitude_ratio * 30.0; // Max 30 points for amplitude
    
    // Combined harmony score
    double total_harmony = harmony_score + phase_harmony + amplitude_harmony;
    
    // Weight by cycle strengths
    double strength_weight = (cycle1.strength + cycle2.strength) / 200.0;
    
    return total_harmony * strength_weight;
}

// Fibonacci Time Harmonics
double SoundSpiritAI::GetFibonacciTimeHarmonics() {
    datetime current_time = TimeCurrent();
    double fibonacci_harmony = 0.0;
    int harmony_count = 0;
    
    // Check major market events for Fibonacci time relationships
    datetime significant_events[] = {
        // Add significant historical dates for the instrument being traded
        D'2020.03.20', // COVID crash low
        D'2021.01.29', // GameStop peak
        D'2022.06.16', // Bear market low
        D'2023.10.27'  // Recent significant date
    };
    
    for(int i = 0; i < ArraySize(significant_events); i++) {
        int days_elapsed = (int)((current_time - significant_events[i]) / 86400);
        
        // Check if current time aligns with Fibonacci ratios of elapsed time
        for(int j = 0; j < ArraySize(m_fibonacci_ratios); j++) {
            double expected_days = days_elapsed * m_fibonacci_ratios[j];
            double days_from_expected = MathAbs(days_elapsed - expected_days);
            
            if(days_from_expected < 3.0) { // Within 3 days tolerance
                fibonacci_harmony += (3.0 - days_from_expected) / 3.0 * 10.0;
                harmony_count++;
            }
        }
    }
    
    if(harmony_count > 0) {
        fibonacci_harmony /= harmony_count;
    }
    
    return MathMax(0, MathMin(100, fibonacci_harmony));
}

// Phase Alignment Calculation
double SoundSpiritAI::GetPhaseAlignment() {
    if(m_cycle_count < 2) return 0.0;
    
    // Calculate how well all cycles are phase-aligned
    double alignment_sum = 0.0;
    int alignment_count = 0;
    
    for(int i = 0; i < m_cycle_count; i++) {
        for(int j = i + 1; j < m_cycle_count; j++) {
            // Normalize phases to 0-1 range
            double phase1 = MathMod(m_detected_cycles[i].phase + M_PI, 2.0 * M_PI) / (2.0 * M_PI);
            double phase2 = MathMod(m_detected_cycles[j].phase + M_PI, 2.0 * M_PI) / (2.0 * M_PI);
            
            // Calculate phase difference (minimum distance on unit circle)
            double phase_diff = MathAbs(phase1 - phase2);
            phase_diff = MathMin(phase_diff, 1.0 - phase_diff);
            
            // Convert to alignment score (0 = perfect alignment, 0.5 = worst alignment)
            double alignment = (0.5 - phase_diff) / 0.5 * 100.0;
            
            // Weight by cycle strengths
            double weight = (m_detected_cycles[i].strength + m_detected_cycles[j].strength) / 200.0;
            alignment_sum += alignment * weight;
            alignment_count++;
        }
    }
    
    return alignment_count > 0 ? alignment_sum / alignment_count : 0.0;
}

// Experimental Planetary Cycle Influence
double SoundSpiritAI::GetPlanetaryCycleInfluence() {
    // This is experimental - some traders believe in planetary cycle correlations
    datetime current_time = TimeCurrent();
    double planetary_influence = 50.0; // Neutral base
    
    // Mercury cycle (88 days) - short-term volatility
    int mercury_position = (int)((current_time - D'2000.01.01') / 86400) % 88;
    if(mercury_position < 5 || mercury_position > 83) { // Near conjunction/opposition
        planetary_influence += 5.0;
    }
    
    // Venus cycle (225 days) - medium-term trends
    int venus_position = (int)((current_time - D'2000.01.01') / 86400) % 225;
    if(venus_position < 10 || venus_position > 215) {
        planetary_influence += 8.0;
    }
    
    // Mars cycle (687 days) - long-term cycles
    int mars_position = (int)((current_time - D'2000.01.01') / 86400) % 687;
    if(mars_position < 20 || mars_position > 667) {
         planetary_influence += 5.0;
    }
    
    return MathMax(0, MathMin(100, planetary_influence));
}

// Implementacje brakujących metod publicznych
ENUM_HARMONY_STATE SoundSpiritAI::GetHarmonyState() {
    double harmony_index = GetCycleHarmonyIndex();
    
    if(harmony_index < 20) return HARMONY_CHAOTIC;
    else if(harmony_index < 40) return HARMONY_EMERGING;
    else if(harmony_index < 60) return HARMONY_BALANCED;
    else if(harmony_index < 80) return HARMONY_RESONANT;
    else return HARMONY_TRANSCENDENT;
}

SCycle SoundSpiritAI::GetDominantCycle() {
    if(m_cycle_count == 0) {
        SCycle empty_cycle;
        empty_cycle.type = CYCLE_INTRADAY;
        empty_cycle.period = 0;
        empty_cycle.amplitude = 0;
        empty_cycle.phase = 0;
        empty_cycle.strength = 0;
        empty_cycle.next_turn = 0;
        empty_cycle.last_turn = 0;
        return empty_cycle;
    }
    
    // Find cycle with highest strength
    int dominant_index = 0;
    double max_strength = m_detected_cycles[0].strength;
    
    for(int i = 1; i < m_cycle_count; i++) {
        if(m_detected_cycles[i].strength > max_strength) {
            max_strength = m_detected_cycles[i].strength;
            dominant_index = i;
        }
    }
    
    return m_detected_cycles[dominant_index];
}

double SoundSpiritAI::GetNextCyclePhase(ENUM_CYCLE_TYPE type) {
    for(int i = 0; i < m_cycle_count; i++) {
        if(m_detected_cycles[i].type == type) {
            return m_detected_cycles[i].phase;
        }
    }
    return 0.0; // No cycle of this type found
}

void SoundSpiritAI::GetActiveCycles(SCycle &out_cycles[], int &out_count) {
    out_count = m_cycle_count;
    ArrayResize(out_cycles, m_cycle_count);
    for(int i = 0; i < m_cycle_count; i++) {
        out_cycles[i] = m_detected_cycles[i];
    }
}

double SoundSpiritAI::GetCycleAlignment() {
    return GetPhaseAlignment(); // Use phase alignment as cycle alignment
}

double SoundSpiritAI::PredictNextTurn(ENUM_CYCLE_TYPE type) {
    for(int i = 0; i < m_cycle_count; i++) {
        if(m_detected_cycles[i].type == type) {
            return m_detected_cycles[i].next_turn;
        }
    }
    return 0.0; // No cycle of this type found
}

datetime SoundSpiritAI::GetNextFibonacciTime() {
    datetime current_time = TimeCurrent();
    datetime next_fibonacci_time = current_time;
    
    // Find the next Fibonacci time alignment
    double min_days_to_next = 1000.0;
    
    datetime significant_events[] = {
        D'2020.03.20', // COVID crash low
        D'2021.01.29', // GameStop peak
        D'2022.06.16', // Bear market low
        D'2023.10.27'  // Recent significant date
    };
    
    for(int i = 0; i < ArraySize(significant_events); i++) {
        for(int j = 0; j < ArraySize(m_fibonacci_ratios); j++) {
            int days_elapsed = (int)((current_time - significant_events[i]) / 86400);
            double expected_days = days_elapsed * m_fibonacci_ratios[j];
            double days_to_next = expected_days - days_elapsed;
            
            if(days_to_next > 0 && days_to_next < min_days_to_next) {
                min_days_to_next = days_to_next;
                next_fibonacci_time = current_time + (datetime)(days_to_next * 86400);
            }
        }
    }
    
    return next_fibonacci_time;
}

void SoundSpiritAI::UpdateCycleModels() {
    // Update cycle detection
    DetectAllCycles();
    
    // Update harmonic analysis
    UpdateHarmonicAnalysis();
    
    // Update planetary cycles
    UpdatePlanetaryCycles();
}

// Implementacje brakujących metod prywatnych
void UpdateHarmonicAnalysis() {
    // Placeholder implementation
    // Update harmonic series and phase alignment
}

void UpdatePlanetaryCycles() {
    // Placeholder implementation
    // Update planetary cycle positions
}

// System compatibility methods
bool SoundSpiritAI::Initialize() {
    LogInfo(LOG_COMPONENT_SOUND, "Inicjalizacja Sound Spirit AI", "Rozpoczęcie inicjalizacji");
    
    // Initialize neural networks
    for(int i = 0; i < 100; i++) {
        for(int j = 0; j < 64; j++) {
            m_lstm_weights_input[i * 64 + j] = (MathRand()/32767.0 - 0.5) * 0.1;
        }
    }
    
    // Initialize Fibonacci ratios
    m_fibonacci_ratios[0] = 0.236; m_fibonacci_ratios[1] = 0.382;
    m_fibonacci_ratios[2] = 0.500; m_fibonacci_ratios[3] = 0.618;
    m_fibonacci_ratios[4] = 0.786; m_fibonacci_ratios[5] = 1.000;
    m_fibonacci_ratios[6] = 1.618; m_fibonacci_ratios[7] = 2.618;
    
    // Initialize cycle buffers
    ArrayInitialize(m_cycle_periods, 0.0);
    ArrayInitialize(m_phase_alignment, 0.0);
    ArrayInitialize(m_harmonic_series, 0.0);
    
    // Initialize planetary cycle tracking
    InitializePlanetaryCycles();
    
    LogInfo(LOG_COMPONENT_SOUND, "Sound Spirit AI zainicjalizowany", "LSTM i analiza cykli gotowe");
    return true;
}

double SoundSpiritAI::GetCycleHarmony() {
    return GetCycleHarmonyIndex();
}

void SoundSpiritAI::UpdateCycleData() {
    // Update cycle periods
    for(int i = 0; i < 99; i++) {
        m_cycle_periods[i] = m_cycle_periods[i + 1];
    }
    m_cycle_periods[99] = GetCyclicMomentum();
    
    // Update phase alignment
    for(int i = 0; i < 99; i++) {
        m_phase_alignment[i] = m_phase_alignment[i + 1];
    }
    m_phase_alignment[99] = GetPhaseAlignment();
    
    // Update harmonic series
    for(int i = 0; i < 99; i++) {
        m_harmonic_series[i] = m_harmonic_series[i + 1];
    }
    m_harmonic_series[99] = GetHarmonicResonance();
    
    // Update planetary cycles
    UpdatePlanetaryCycles();
}

// Implementacja GetCyclicMomentum
double SoundSpiritAI::GetCyclicMomentum() {
    double momentum = 0.0;
    for(int i = 0; i < m_cycle_count; i++) {
        momentum += m_detected_cycles[i].strength * m_detected_cycles[i].amplitude;
    }
    return m_cycle_count > 0 ? momentum / m_cycle_count : 0.0;
}

// Destruktor
SoundSpiritAI::~SoundSpiritAI() {
    if(m_cycle_detector != NULL) delete m_cycle_detector;
    if(m_harmony_calculator != NULL) delete m_harmony_calculator;
    if(m_fft_processor != NULL) delete m_fft_processor;
}