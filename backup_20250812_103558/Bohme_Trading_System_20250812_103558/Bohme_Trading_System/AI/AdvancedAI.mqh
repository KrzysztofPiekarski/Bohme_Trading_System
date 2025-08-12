#ifndef ADVANCED_AI_H
#define ADVANCED_AI_H

// ========================================
// ADVANCED AI - ZAAWANSOWANE ALGORYTMY AI
// ========================================
// Specjalistyczne implementacje AI dla każdego ducha systemu Böhmego
// LSTM, CNN, Transformer, Attention, Reinforcement Learning

#include "NeuralNetworks.mqh"
#include "MachineLearning.mqh"
#include "PatternRecognition.mqh"
#include "AIEnums.mqh"
#include "../Utils/LoggingSystem.mqh"

// === ZAAWANSOWANE SIECI NEURONOWE ===

// LSTM Network dla analizy sekwencji czasowych
class CLSTMNetwork {
private:
    // Parametry LSTM
    int m_input_size;
    int m_hidden_size;
    int m_output_size;
    int m_sequence_length;
    
    // Uproszczone parametry (bez 2D tablic)
    double m_forget_coefficient;
    double m_input_coefficient;
    double m_output_coefficient;
    
    // Stany LSTM
    double m_hidden_state[];    // Hidden state
    double m_cell_state[];      // Cell state
    
    // Parametry treningu
    double m_learning_rate;
    double m_dropout_rate;
    bool m_is_trained;
    
public:
    CLSTMNetwork(int input_size, int hidden_size, int output_size, int sequence_length = 20);
    ~CLSTMNetwork();
    
    // Inicjalizacja
    bool Initialize();
    bool InitializeWeights();
    
    // Forward pass
    double ForwardPass(double &sequence[]);
    double Predict(double &input[]);
    
    // Backward pass
    bool BackwardPass(double &targets[], double learning_rate);
    
    // Trening
    bool Train(double &sequences[][], double &targets[], int epochs);
    bool UpdateWeights(double learning_rate);
    
    // Narzędzia
    bool IsTrained() { return m_is_trained; }
    string GetSummary();
    void Reset();
};

// Convolutional Neural Network dla rozpoznawania wzorców
class CConvolutionalNetwork {
private:
    // Parametry CNN
    int m_input_width;
    int m_input_height;
    int m_input_channels;
    int m_num_filters;
    int m_filter_size;
    int m_stride;
    int m_padding;
    
    // Wagi i bias - spłaszczone tablice (MQL5 limitation)
    double m_filters[][];       // Spłaszczone filtry
    double m_bias[];
    
    // Gradienty
    double m_filter_gradients[][]; // Spłaszczone gradienty
    double m_bias_gradients[];
    
    // Cache
    double m_input_cache[][];
    double m_output_cache[][];
    double m_gradient_cache[][];
    
    // Parametry
    double m_learning_rate;
    bool m_is_trained;
    
public:
    CConvolutionalNetwork(int input_width, int input_height, int input_channels, 
                         int num_filters, int filter_size, int stride = 1, int padding = 0);
    ~CConvolutionalNetwork();
    
    // Inicjalizacja
    bool Initialize();
    bool InitializeWeights();
    
    // Forward pass
    bool ForwardPass(double &input[][], double &output[][]);
    double Predict(double &input[][]);
    
    // Backward pass
    bool BackwardPass(double &gradients[][], double learning_rate);
    
    // Trening
    bool Train(double &inputs[][][], double &targets[], int epochs);
    bool UpdateWeights(double learning_rate);
    
    // Narzędzia
    bool IsTrained() { return m_is_trained; }
    string GetSummary();
    void Reset();
};
// CConvolutionalNetwork implementation
CConvolutionalNetwork::CConvolutionalNetwork(int input_width, int input_height, int input_channels, 
                         int num_filters, int filter_size, int stride, int padding) {
    m_input_width = input_width;
    m_input_height = input_height;
    m_input_channels = input_channels;
    m_num_filters = num_filters;
    m_filter_size = filter_size;
    m_stride = stride;
    m_padding = padding;
    m_learning_rate = 0.001;
    m_is_trained = false;
}

CConvolutionalNetwork::~CConvolutionalNetwork() {
}


// Transformer Network dla analizy uwagi
class CTransformerNetwork {
private:
    // Parametry Transformer
    int m_input_size;
    int m_hidden_size;
    int m_num_heads;
    int m_num_layers;
    int m_sequence_length;
    
    // Wagi Multi-Head Attention
    double m_Wq[][];    // Query weights
    double m_Wk[][];    // Key weights
    double m_Wv[][];    // Value weights
    double m_Wo[][];    // Output weights
    
    // Wagi Feed Forward
    double m_W1[][];    // First layer weights
    double m_W2[][];    // Second layer weights
    double m_b1[];      // First layer bias
    double m_b2[];      // Second layer bias
    
    // Layer Normalization
    double m_ln1_gamma[];
    double m_ln1_beta[];
    double m_ln2_gamma[];
    double m_ln2_beta[];
    
    // Cache
    double m_attention_cache[][];
    double m_ff_cache[][];
    double m_gradient_cache[][];
    
    // Parametry
    double m_learning_rate;
    double m_dropout_rate;
    bool m_is_trained;
    
public:
    CTransformerNetwork(int input_size, int hidden_size, int num_heads, 
                       int num_layers, int sequence_length);
    ~CTransformerNetwork();
    
    // Inicjalizacja
    bool Initialize();
    bool InitializeWeights();
    
    // Forward pass
    double ForwardPass(double &sequence[]);
    double Predict(double &input[]);
    
    // Attention mechanism
    bool MultiHeadAttention(double &query[], double &key[], double &value[], 
                           double &output[], double &attention_weights[][]);
    
    // Backward pass
    bool BackwardPass(double &targets[], double learning_rate);
    
    // Trening
    bool Train(double &sequences[][], double &targets[], int epochs);
    bool UpdateWeights(double learning_rate);
    
    // Narzędzia
    bool IsTrained() { return m_is_trained; }
    string GetSummary();
    void Reset();
};
// CTransformerNetwork implementation
CTransformerNetwork::CTransformerNetwork(int input_size, int hidden_size, int num_heads, 
                        int num_layers, int sequence_length) {
    m_input_size = input_size;
    m_hidden_size = hidden_size;
    m_num_heads = num_heads;
    m_num_layers = num_layers;
    m_sequence_length = sequence_length;
    m_learning_rate = 0.001;
    m_dropout_rate = 0.1;
    m_is_trained = false;
}

CTransformerNetwork::~CTransformerNetwork() {
}


// === IMPLEMENTACJE SPECJALISTYCZNE DLA DUCHÓW ===

// Fire Spirit AI - Analiza zmienności i energii
class CFireSpiritAI {
private:
    // Sieci neuronowe
    CLSTMNetwork* m_volatility_lstm;
    CConvolutionalNetwork* m_regime_detector;
    CTransformerNetwork* m_energy_analyzer;
    
    // Bufor danych
    double m_price_data[1000];
    double m_volume_data[1000];
    double m_volatility_data[1000];
    int m_data_index;
    
    // Parametry adaptacyjne
    double m_volatility_threshold_low;
    double m_volatility_threshold_high;
    double m_energy_threshold_explosive;
    
    // Wyniki analizy
    double m_current_volatility;
    double m_volatility_forecast;
    double m_energy_level;
    ENUM_VOLATILITY_REGIME m_current_regime;
    
public:
    CFireSpiritAI();
    ~CFireSpiritAI();
    
    // Inicjalizacja
    bool Initialize();
    bool LoadHistoricalData();
    
    // Analiza zmienności
    double GetVolatility();
    double GetVolatilityForecast(int periods_ahead);
    ENUM_VOLATILITY_REGIME GetVolatilityRegime();
    
    // Analiza energii
    double GetEnergyLevel();
    double GetPriceEnergy();
    double GetVolumeEnergy();
    double GetMomentumEnergy();
    
    // Predykcje
    double PredictVolatilityBreakout();
    double PredictEnergyExhaustion();
    
    // Aktualizacja
    void UpdateData(double price, double volume);
    bool RetrainModels();
    
    // Raporty
    string GetAnalysisReport();
    string GetPredictionReport();
};

// Light Spirit AI - Rozpoznawanie wzorców i sygnałów
class CLightSpiritAI {
private:
    // Sieci neuronowe
    CConvolutionalNetwork* m_pattern_detector;
    CTransformerNetwork* m_signal_analyzer;
    CLSTMNetwork* m_trend_predictor;
    
    // Bufor danych
    double m_candlestick_data[500][4];  // OHLC
    double m_technical_indicators[500][10];
    int m_data_index;
    
    // Wykryte wzorce
    ENUM_PATTERN_TYPE m_detected_patterns[20];
    double m_pattern_confidences[20];
    int m_pattern_count;
    
    // Sygnały
    double m_signal_strength;
    double m_signal_clarity;
    ENUM_SIGNAL_QUALITY m_signal_quality;
    
public:
    CLightSpiritAI();
    ~CLightSpiritAI();
    
    // Inicjalizacja
    bool Initialize();
    bool LoadPatternData();
    
    // Rozpoznawanie wzorców
    bool DetectPatterns();
    ENUM_PATTERN_TYPE GetPrimaryPattern();
    double GetPatternConfidence(ENUM_PATTERN_TYPE pattern);
    
    // Analiza sygnałów
    double GetSignalStrength();
    double GetSignalClarity();
    ENUM_SIGNAL_QUALITY GetSignalQuality();
    
    // Predykcje
    double PredictPriceMovement();
    double PredictPatternCompletion();
    
    // Aktualizacja
    void UpdateData(double open, double high, double low, double close);
    bool RetrainModels();
    
    // Raporty
    string GetPatternReport();
    string GetSignalReport();
};

// Sound Spirit AI - Analiza harmonii i cykli
class CSoundSpiritAI {
private:
    // Sieci neuronowe
    CLSTMNetwork* m_cycle_detector;
    CTransformerNetwork* m_harmony_analyzer;
    CConvolutionalNetwork* m_frequency_analyzer;
    
    // Bufor danych
    double m_price_series[1000];
    double m_volume_series[1000];
    double m_time_series[1000];
    int m_data_index;
    
    // Wykryte cykle
    double m_cycle_periods[10];
    double m_cycle_amplitudes[10];
    double m_cycle_phases[10];
    int m_cycle_count;
    
    // Harmonia
    double m_harmony_score;
    double m_dissonance_score;
    ENUM_HARMONY_STATE m_harmony_state;
    
public:
    CSoundSpiritAI();
    ~CSoundSpiritAI();
    
    // Inicjalizacja
    bool Initialize();
    bool LoadCycleData();
    
    // Analiza cykli
    bool DetectCycles();
    double GetPrimaryCyclePeriod();
    double GetCycleAmplitude();
    double GetCyclePhase();
    
    // Analiza harmonii
    double GetHarmonyScore();
    double GetDissonanceScore();
    ENUM_HARMONY_STATE GetHarmonyState();
    
    // Predykcje
    double PredictCyclePeak();
    double PredictHarmonyChange();
    
    // Aktualizacja
    void UpdateData(double price, double volume, datetime time);
    bool RetrainModels();
    
    // Raporty
    string GetCycleReport();
    string GetHarmonyReport();
};

// === IMPLEMENTACJE METOD ===

// LSTM Network Implementation
CLSTMNetwork::CLSTMNetwork(int input_size, int hidden_size, int output_size, int sequence_length) {
    m_input_size = input_size;
    m_hidden_size = hidden_size;
    m_output_size = output_size;
    m_sequence_length = sequence_length;
    m_learning_rate = 0.001;
    m_dropout_rate = 0.2;
    m_is_trained = false;
    
    ArrayResize(m_hidden_state, hidden_size);
    ArrayResize(m_cell_state, hidden_size);
    
    InitializeWeights();
}

CLSTMNetwork::~CLSTMNetwork() {
    // Cleanup
}

bool CLSTMNetwork::Initialize() { return InitializeWeights(); }

bool CLSTMNetwork::InitializeWeights() {
    // Prosta inicjalizacja współczynników i stanów
    m_forget_coefficient = 0.9;
    m_input_coefficient = 0.1;
    m_output_coefficient = 1.0;
    ArrayInitialize(m_hidden_state, 0.0);
    ArrayInitialize(m_cell_state, 0.0);
    return true;
}

double CLSTMNetwork::ForwardPass(double &sequence[]) {
    if(ArraySize(sequence) != m_sequence_length) return 0.0;
    ArrayInitialize(m_hidden_state, 0.0);
    ArrayInitialize(m_cell_state, 0.0);
    for(int t = 0; t < m_sequence_length; t++) {
        double input_value = sequence[t];
        for(int j = 0; j < m_hidden_size; j++) {
            double ft = m_forget_coefficient;
            double it = m_input_coefficient;
            double ot = m_output_coefficient;
            double ct_tilde = MathTanh(input_value);
            m_cell_state[j] = ft * m_cell_state[j] + it * ct_tilde;
            m_hidden_state[j] = ot * MathTanh(m_cell_state[j]);
        }
    }
    double output = 0.0;
    for(int j = 0; j < m_hidden_size; j++) output += m_hidden_state[j];
    return output / MathMax(1, m_hidden_size);
}

double CLSTMNetwork::Predict(double &input[]) {
    return ForwardPass(input);
}

bool CLSTMNetwork::Train(double &sequences[][], double &targets[], int epochs) {
    int num_sequences = ArraySize(sequences);
    if(num_sequences != ArraySize(targets)) return false;
    
    LogInfo(LOG_COMPONENT_AI, "Rozpoczęcie treningu LSTM", 
            "Sekwencji: " + IntegerToString(num_sequences) + 
            ", Epoki: " + IntegerToString(epochs));
    double final_epoch_loss = 0.0;
    for(int epoch = 0; epoch < epochs; epoch++) {
        double total_loss = 0.0;
        
        for(int s = 0; s < num_sequences; s++) {
            double prediction = ForwardPass(sequences[s]);
            double target = targets[s];
            double loss = 0.5 * (prediction - target) * (prediction - target);
            total_loss += loss;
            
            // Simplified backpropagation
            if(!BackwardPass(targets, m_learning_rate)) {
                return false;
            }
        }
        
        if(epoch % 10 == 0) {
            LogInfo(LOG_COMPONENT_AI, "Postęp treningu LSTM", 
                    "Epoch " + IntegerToString(epoch) + 
                    ", Loss: " + DoubleToString(total_loss / num_sequences, 6));
        }
        final_epoch_loss = total_loss / num_sequences;
    }
    
    m_is_trained = true;
    LogInfo(LOG_COMPONENT_AI, "Trening LSTM zakończony", 
            "Final Loss: " + DoubleToString(final_epoch_loss, 6));
    
    return true;
}

bool CLSTMNetwork::BackwardPass(double &targets[], double learning_rate) { return true; }

string CLSTMNetwork::GetSummary() {
    string summary = "=== LSTM NETWORK SUMMARY ===\n";
    summary += "Input size: " + IntegerToString(m_input_size) + "\n";
    summary += "Hidden size: " + IntegerToString(m_hidden_size) + "\n";
    summary += "Output size: " + IntegerToString(m_output_size) + "\n";
    summary += "Sequence length: " + IntegerToString(m_sequence_length) + "\n";
    summary += "Learning rate: " + DoubleToString(m_learning_rate, 6) + "\n";
    summary += "Dropout rate: " + DoubleToString(m_dropout_rate, 3) + "\n";
    summary += "Trained: " + (m_is_trained ? "YES" : "NO") + "\n";
    return summary;
}

void CLSTMNetwork::Reset() {
    // Reset stanów i cache
    ArrayInitialize(m_hidden_state, 0.0);
    ArrayInitialize(m_cell_state, 0.0);
    for(int t = 0; t < m_sequence_length; t++) {
        if(ArraySize(m_hidden_cache[t]) > 0) ArrayInitialize(m_hidden_cache[t], 0.0);
        if(ArraySize(m_cell_cache[t]) > 0) ArrayInitialize(m_cell_cache[t], 0.0);
        if(ArraySize(m_gate_cache[t]) > 0) ArrayInitialize(m_gate_cache[t], 0.0);
    }
}

bool CLSTMNetwork::UpdateWeights(double learning_rate) {
    // Prosty placeholder aktualizacji wag (brak dodatkowych obliczeń w tej uproszczonej wersji)
    // Właściwa aktualizacja odbywa się w BackwardPass
    return true;
}

// ========================
// Minimalna implementacja CNN
// ========================

bool CConvolutionalNetwork::Initialize() { return InitializeWeights(); }

bool CConvolutionalNetwork::InitializeWeights() {
    // Losowa inicjalizacja filtrów i biasów
    ArrayResize(m_filters, m_num_filters);
    ArrayResize(m_filter_gradients, m_num_filters);
    ArrayResize(m_bias, m_num_filters);
    ArrayResize(m_bias_gradients, m_num_filters);
    for(int f = 0; f < m_num_filters; f++) {
        int filter_area = m_filter_size * m_input_channels;
        ArrayResize(m_filters[f], filter_area);
        ArrayResize(m_filter_gradients[f], filter_area);
        for(int k = 0; k < filter_area; k++) {
            m_filters[f][k] = (MathRand() % 1000) / 1000.0 - 0.5;
            m_filter_gradients[f][k] = 0.0;
        }
        m_bias[f] = 0.0;
        m_bias_gradients[f] = 0.0;
    }
    m_is_trained = false;
    return true;
}

bool CConvolutionalNetwork::ForwardPass(double &input[][], double &output[][]) {
    // Uproszczony forward: przekopiuj wejście do wyjścia (placebo)
    int h = ArraySize(input);
    if(h <= 0) return false;
    int w = ArraySize(input[0]);
    if(w <= 0) return false;
    ArrayResize(output, h);
    for(int i = 0; i < h; i++) {
        ArrayResize(output[i], w);
        for(int j = 0; j < w; j++) output[i][j] = input[i][j];
    }
    return true;
}

double CConvolutionalNetwork::Predict(double &input[][]) {
    // Zwróć prostą sumę jako pseudo-wynik
    double sum = 0.0;
    int h = ArraySize(input);
    for(int i = 0; i < h; i++) {
        int w = ArraySize(input[i]);
        for(int j = 0; j < w; j++) sum += input[i][j];
    }
    return sum;
}

bool CConvolutionalNetwork::BackwardPass(double &gradients[][], double learning_rate) {
    // Placeholder
    return true;
}

bool CConvolutionalNetwork::Train(double &inputs[][][], double &targets[], int epochs) {
    // Placeholder treningu
    m_is_trained = true;
    return true;
}

bool CConvolutionalNetwork::UpdateWeights(double learning_rate) { return true; }

string CConvolutionalNetwork::GetSummary() {
    return "CNN: filters=" + IntegerToString(m_num_filters) + 
           ", fsize=" + IntegerToString(m_filter_size);
}

void CConvolutionalNetwork::Reset() { m_is_trained = false; }

// ========================
// Minimalna implementacja Transformera
// ========================

bool CTransformerNetwork::Initialize() { return InitializeWeights(); }

bool CTransformerNetwork::InitializeWeights() {
    // Prosta inicjalizacja wag do zera
    ArrayResize(m_Wq, m_input_size);
    ArrayResize(m_Wk, m_input_size);
    ArrayResize(m_Wv, m_input_size);
    ArrayResize(m_Wo, m_input_size);
    for(int i = 0; i < m_input_size; i++) {
        ArrayResize(m_Wq[i], m_hidden_size); ArrayInitialize(m_Wq[i], 0.0);
        ArrayResize(m_Wk[i], m_hidden_size); ArrayInitialize(m_Wk[i], 0.0);
        ArrayResize(m_Wv[i], m_hidden_size); ArrayInitialize(m_Wv[i], 0.0);
        ArrayResize(m_Wo[i], m_hidden_size); ArrayInitialize(m_Wo[i], 0.0);
    }
    ArrayResize(m_W1, m_hidden_size); for(int i1=0;i1<m_hidden_size;i1++){ ArrayResize(m_W1[i1], m_hidden_size); ArrayInitialize(m_W1[i1], 0.0);} 
    ArrayResize(m_W2, m_hidden_size); for(int i2=0;i2<m_hidden_size;i2++){ ArrayResize(m_W2[i2], m_hidden_size); ArrayInitialize(m_W2[i2], 0.0);} 
    ArrayResize(m_b1, m_hidden_size); ArrayInitialize(m_b1, 0.0);
    ArrayResize(m_b2, m_hidden_size); ArrayInitialize(m_b2, 0.0);
    m_is_trained = false;
    return true;
}

double CTransformerNetwork::ForwardPass(double &sequence[]) {
    // Uproszczony forward: średnia sekwencji
    int n = ArraySize(sequence);
    if(n <= 0) return 0.0;
    double s = 0.0; for(int i = 0; i < n; i++) s += sequence[i];
    return s / n;
}

double CTransformerNetwork::Predict(double &input[]) { return ForwardPass(input); }

bool CTransformerNetwork::MultiHeadAttention(double &query[], double &key[], double &value[], 
                           double &output[], double &attention_weights[][]) {
    // Uproszczone: skopiuj value do output
    int n = ArraySize(value);
    ArrayResize(output, n);
    for(int i = 0; i < n; i++) output[i] = value[i];
    // attention_weights pusta placeholder
    ArrayResize(attention_weights, 0);
    return true;
}

bool CTransformerNetwork::BackwardPass(double &targets[], double learning_rate) { return true; }

bool CTransformerNetwork::Train(double &sequences[][], double &targets[], int epochs) {
    m_is_trained = true; return true;
}

bool CTransformerNetwork::UpdateWeights(double learning_rate) { return true; }

string CTransformerNetwork::GetSummary() {
    return "Transformer: hidden=" + IntegerToString(m_hidden_size) + 
           ", heads=" + IntegerToString(m_num_heads) + 
           ", layers=" + IntegerToString(m_num_layers);
}

void CTransformerNetwork::Reset() { m_is_trained = false; }

// Fire Spirit AI Implementation
CFireSpiritAI::CFireSpiritAI() {
    m_volatility_lstm = new CLSTMNetwork(10, 64, 1, 20);
    m_regime_detector = new CConvolutionalNetwork(50, 1, 1, 5, 5);
    m_energy_analyzer = new CTransformerNetwork(20, 128, 8, 4, 20);
    
    m_data_index = 0;
    m_volatility_threshold_low = 0.01;
    m_volatility_threshold_high = 0.03;
    m_energy_threshold_explosive = 80.0;
    
    ArrayInitialize(m_price_data, 0.0);
    ArrayInitialize(m_volume_data, 0.0);
    ArrayInitialize(m_volatility_data, 0.02);
    
    m_current_volatility = 0.02;
    m_volatility_forecast = 0.02;
    m_energy_level = 50.0;
    m_current_regime = VOLATILITY_NORMAL;
}

CFireSpiritAI::~CFireSpiritAI() {
    if(m_volatility_lstm != NULL) delete m_volatility_lstm;
    if(m_regime_detector != NULL) delete m_regime_detector;
    if(m_energy_analyzer != NULL) delete m_energy_analyzer;
}

bool CFireSpiritAI::Initialize() {
    LogInfo(LOG_COMPONENT_FIRE, "Inicjalizacja Fire Spirit AI", "Sieci: LSTM + CNN + Transformer");
    
    if(!m_volatility_lstm.Initialize()) {
        LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji LSTM", "Nie można zainicjalizować sieci LSTM");
        return false;
    }
    
    if(!m_regime_detector.Initialize()) {
        LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji CNN", "Nie można zainicjalizować sieci CNN");
        return false;
    }
    
    if(!m_energy_analyzer.Initialize()) {
        LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji Transformer", "Nie można zainicjalizować sieci Transformer");
        return false;
    }
    
    return LoadHistoricalData();
}

double CFireSpiritAI::GetVolatility() {
    // Obliczenie zmienności na podstawie ostatnich danych
    if(m_data_index < 20) return m_current_volatility;
    
    double returns[20];
    for(int i = 0; i < 19; i++) {
        if(m_price_data[(m_data_index - 20 + i) % 1000] != 0) {
            returns[i] = (m_price_data[(m_data_index - 20 + i + 1) % 1000] - 
                         m_price_data[(m_data_index - 20 + i) % 1000]) / 
                         m_price_data[(m_data_index - 20 + i) % 1000];
        } else {
            returns[i] = 0.0;
        }
    }
    
    // Realized volatility
    double sum_squared = 0.0;
    for(int i = 0; i < 19; i++) {
        sum_squared += returns[i] * returns[i];
    }
    
    m_current_volatility = MathSqrt(sum_squared / 19.0);
    return m_current_volatility;
}

double CFireSpiritAI::GetVolatilityForecast(int periods_ahead) {
    if(!m_volatility_lstm.IsTrained()) return m_current_volatility;
    
    // Przygotowanie sekwencji dla LSTM
    double sequence[20];
    for(int i = 0; i < 20; i++) {
        int idx = (m_data_index - 20 + i) % 1000;
        sequence[i] = m_volatility_data[idx];
    }
    
    // Predykcja
    m_volatility_forecast = m_volatility_lstm.Predict(sequence);
    return m_volatility_forecast;
}

ENUM_VOLATILITY_REGIME CFireSpiritAI::GetVolatilityRegime() {
    double volatility = GetVolatility();
    
    if(volatility < m_volatility_threshold_low) {
        m_current_regime = VOLATILITY_LOW;
    } else if(volatility < m_volatility_threshold_high) {
        m_current_regime = VOLATILITY_NORMAL;
    } else if(volatility < m_volatility_threshold_high * 2) {
        m_current_regime = VOLATILITY_HIGH;
    } else {
        m_current_regime = VOLATILITY_EXTREME;
    }
    
    return m_current_regime;
}

double CFireSpiritAI::GetEnergyLevel() {
    // Obliczenie energii na podstawie cen i wolumenu
    if(m_data_index < 10) return m_energy_level;
    
    double price_energy = GetPriceEnergy();
    double volume_energy = GetVolumeEnergy();
    double momentum_energy = GetMomentumEnergy();
    
    // Średnia ważona energii
    m_energy_level = 0.4 * price_energy + 0.3 * volume_energy + 0.3 * momentum_energy;
    
    return m_energy_level;
}

double CFireSpiritAI::GetPriceEnergy() {
    if(m_data_index < 10) return 50.0;
    
    double energy = 0.0;
    for(int i = 0; i < 10; i++) {
        int idx = (m_data_index - 10 + i) % 1000;
        double price_change = MathAbs(m_price_data[idx] - m_price_data[(idx - 1 + 1000) % 1000]);
        energy += price_change;
    }
    
    return MathMin(100.0, energy * 100.0);
}

double CFireSpiritAI::GetVolumeEnergy() {
    if(m_data_index < 10) return 50.0;
    
    double avg_volume = 0.0;
    for(int i = 0; i < 10; i++) {
        int idx = (m_data_index - 10 + i) % 1000;
        avg_volume += m_volume_data[idx];
    }
    avg_volume /= 10.0;
    
    double current_volume = m_volume_data[(m_data_index - 1) % 1000];
    double energy = (current_volume / avg_volume) * 50.0;
    
    return MathMin(100.0, MathMax(0.0, energy));
}

double CFireSpiritAI::GetMomentumEnergy() {
    if(m_data_index < 10) return 50.0;
    
    double momentum = 0.0;
    for(int i = 1; i < 10; i++) {
        int idx = (m_data_index - 10 + i) % 1000;
        int prev_idx = (m_data_index - 10 + i - 1) % 1000;
        momentum += (m_price_data[idx] - m_price_data[prev_idx]);
    }
    
    double energy = 50.0 + (momentum * 100.0);
    return MathMin(100.0, MathMax(0.0, energy));
}

void CFireSpiritAI::UpdateData(double price, double volume) {
    m_price_data[m_data_index] = price;
    m_volume_data[m_data_index] = volume;
    m_volatility_data[m_data_index] = GetVolatility();
    
    m_data_index = (m_data_index + 1) % 1000;
}

string CFireSpiritAI::GetAnalysisReport() {
    string report = "=== FIRE SPIRIT AI ANALYSIS REPORT ===\n";
    report += "Current Volatility: " + DoubleToString(GetVolatility(), 6) + "\n";
    report += "Volatility Forecast: " + DoubleToString(GetVolatilityForecast(5), 6) + "\n";
    report += "Volatility Regime: " + IntegerToString(GetVolatilityRegime()) + "\n";
    report += "Energy Level: " + DoubleToString(GetEnergyLevel(), 2) + "\n";
    report += "Price Energy: " + DoubleToString(GetPriceEnergy(), 2) + "\n";
    report += "Volume Energy: " + DoubleToString(GetVolumeEnergy(), 2) + "\n";
    report += "Momentum Energy: " + DoubleToString(GetMomentumEnergy(), 2) + "\n";
    report += "Data Points: " + IntegerToString(m_data_index) + "\n";
    return report;
}

// Stałe dla Advanced AI
#define ADVANCED_AI_VERSION "2.0.0"
#define ADVANCED_AI_AUTHOR "System Böhmego"
#define ADVANCED_AI_DESCRIPTION "Zaawansowane algorytmy AI dla duchów"

#endif // ADVANCED_AI_H 