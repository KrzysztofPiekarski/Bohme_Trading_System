#ifndef NEURAL_NETWORKS_H
#define NEURAL_NETWORKS_H

// ========================================
// NEURAL NETWORKS - ZAAWANSOWANE SIECI NEURONOWE
// ========================================
// Sieci neuronowe dla Systemu Böhmego
// CNN, LSTM, Transformer, Autoencoder, GAN

#include "../Utils/LoggingSystem.mqh"

// Pomocnicze funkcje konwersji
bool StringToBool(string value) {
    return (value == "true" || value == "1");
}

// === PODSTAWOWE ENUMERACJE ===

// Typy warstw neuronowych
enum ENUM_LAYER_TYPE {
    LAYER_DENSE,                    // Warstwa gęsta
    LAYER_CONVOLUTIONAL,            // Warstwa konwolucyjna
    LAYER_POOLING,                  // Warstwa pooling
    LAYER_RECURRENT,                // Warstwa rekurencyjna
    LAYER_LSTM,                     // Warstwa LSTM
    LAYER_GRU,                      // Warstwa GRU
    LAYER_ATTENTION,                // Warstwa uwagi
    LAYER_NORMALIZATION,            // Warstwa normalizacji
    LAYER_DROPOUT,                  // Warstwa dropout
    LAYER_FLATTEN,                  // Warstwa spłaszczająca
    LAYER_RESHAPE,                  // Warstwa Reshape
    LAYER_EMBEDDING,                // Warstwa Embedding
    LAYER_OUTPUT                    // Warstwa wyjściowa
};

// Funkcje aktywacji - używamy wbudowanego ENUM_ACTIVATION_FUNCTION z MQL5
// Jeśli stałe nie są zdefiniowane w środowisku, zdefiniuj je lokalnie
#ifndef ACTIVATION_LINEAR
#define ACTIVATION_LINEAR 0
#endif
#ifndef ACTIVATION_RELU
#define ACTIVATION_RELU 1
#endif
#ifndef ACTIVATION_SIGMOID
#define ACTIVATION_SIGMOID 2
#endif
#ifndef ACTIVATION_TANH
#define ACTIVATION_TANH 3
#endif
#ifndef ACTIVATION_SOFTMAX
#define ACTIVATION_SOFTMAX 4
#endif
#ifndef ACTIVATION_LEAKY_RELU
#define ACTIVATION_LEAKY_RELU 5
#endif
#ifndef ACTIVATION_ELU
#define ACTIVATION_ELU 6
#endif
#ifndef ACTIVATION_SELU
#define ACTIVATION_SELU 7
#endif
#ifndef ACTIVATION_SWISH
#define ACTIVATION_SWISH 8
#endif
#ifndef ACTIVATION_GELU
#define ACTIVATION_GELU 9
#endif
#ifndef ACTIVATION_MISH
#define ACTIVATION_MISH 10
#endif
#ifndef ACTIVATION_NONE
#define ACTIVATION_NONE 11
#endif

// Typy optymalizatorów
enum ENUM_OPTIMIZER {
    OPTIMIZER_SGD,                  // Stochastic Gradient Descent
    OPTIMIZER_ADAM,                 // Adam
    OPTIMIZER_RMS_PROP,             // RMSprop
    OPTIMIZER_ADAGRAD,              // Adagrad
    OPTIMIZER_ADADELTA,             // Adadelta
    OPTIMIZER_NADAM,                // Nadam
    OPTIMIZER_AMSGRAD,              // AMSGrad
    OPTIMIZER_ADAMW                 // AdamW
};

// Typy funkcji straty - używamy wbudowanego ENUM_LOSS_FUNCTION z MQL5
#ifndef LOSS_MEAN_SQUARED_ERROR
#define LOSS_MEAN_SQUARED_ERROR 0
#define LOSS_MEAN_ABSOLUTE_ERROR 1
#define LOSS_BINARY_CROSSENTROPY 2
#define LOSS_HUBER 3
#endif

// Typy inicjalizacji wag
enum ENUM_WEIGHT_INITIALIZATION {
    WEIGHT_INIT_ZEROS,              // Zera
    WEIGHT_INIT_ONES,               // Jedynki
    WEIGHT_INIT_RANDOM,             // Losowe
    WEIGHT_INIT_XAVIER,             // Xavier/Glorot
    WEIGHT_INIT_HE,                 // He
    WEIGHT_INIT_LECUN,              // LeCun
    WEIGHT_INIT_ORTHOGONAL,         // Ortogonalne
    WEIGHT_INIT_UNIFORM             // Jednostajne
};

// === STRUKTURY DANYCH ===

// Struktura parametrów warstwy
struct SNeuralLayerParams {
    ENUM_LAYER_TYPE layer_type;     // Typ warstwy
    int input_size;                 // Rozmiar wejścia
    int output_size;                // Rozmiar wyjścia
    ENUM_ACTIVATION_FUNCTION activation; // Funkcja aktywacji
    double dropout_rate;            // Współczynnik dropout
    bool use_bias;                  // Czy używać bias
    ENUM_WEIGHT_INITIALIZATION weight_init; // Inicjalizacja wag
    double learning_rate;           // Szybkość uczenia
    double momentum;                // Momentum
    double epsilon;                 // Epsilon dla optymalizatorów
    double beta1;                   // Beta1 dla Adam
    double beta2;                   // Beta2 dla Adam
    double decay;                   // Decay dla RMSprop
    double clip_norm;               // Gradient clipping
    bool trainable;                 // Czy warstwa jest trenowalna
    string name;                    // Nazwa warstwy
};

// Struktura warstwy neuronowej - tylko podstawowe parametry
struct SNeuralLayer {
    SNeuralLayerParams params;      // Parametry warstwy
    bool is_initialized;            // Czy warstwa jest zainicjalizowana
    int layer_index;                // Indeks warstwy
    datetime last_update;           // Ostatnia aktualizacja

    // Dane warstwy
    double weights[];               // Wagi (flattened length: input_size*output_size)
    double bias[];                  // Bias [output_size]

    // Bufory obliczeniowe
    double activations[];           // Aktywacje [output_size]
    double deltas[];                // Delta błędu [output_size]
    double gradients[];             // Gradienty wag (flattened)
    double bias_gradients[];        // Gradienty bias [output_size]

    // Bufory optymalizatorów
    double momentum_weights[];      // Momentum wag (flattened)
    double momentum_bias[];         // Momentum bias [output_size]
    double velocity_weights[];      // RMS/Adam v dla wag (flattened)
    double velocity_bias[];         // RMS/Adam v dla bias [output_size]
    double cache_weights[];         // Dodatkowy cache wag (flattened)
    double cache_bias[];            // Dodatkowy cache bias [output_size]
};

// Struktura parametrów sieci
struct SNeuralNetworkParams {
    int input_size;                 // Rozmiar wejścia
    int output_size;                // Rozmiar wyjścia
    int hidden_layers[10];          // Rozmiary warstw ukrytych (max 10 warstw)
    int hidden_layers_count;        // Liczba warstw ukrytych
    ENUM_ACTIVATION_FUNCTION hidden_activation; // Aktywacja warstw ukrytych
    ENUM_ACTIVATION_FUNCTION output_activation; // Aktywacja warstwy wyjściowej
    ENUM_OPTIMIZER optimizer;       // Optymalizator
    ENUM_LOSS_FUNCTION loss_function; // Funkcja straty
    double learning_rate;           // Szybkość uczenia
    int batch_size;                 // Rozmiar batch
    int epochs;                     // Liczba epok
    double validation_split;        // Proporcja walidacji
    bool shuffle_data;              // Czy mieszać dane
    bool early_stopping;            // Czy używać early stopping
    int patience;                   // Cierpliwość early stopping
    double min_delta;               // Minimalna zmiana dla early stopping
    bool verbose;                   // Czy wyświetlać postęp
    int random_seed;                // Ziarno losowości
    double weight_decay;            // Decay wag
    double gradient_clip;           // Gradient clipping
    bool use_batch_norm;            // Czy używać batch normalization
    double batch_norm_momentum;     // Momentum dla batch norm
    bool use_dropout;               // Czy używać dropout
    double dropout_rate;            // Współczynnik dropout
    string model_name;              // Nazwa modelu
    datetime creation_time;         // Czas utworzenia
};

// Struktura wyników treningu
struct SNeuralTrainingResult {
    bool success;                   // Czy trening się powiódł
    double training_loss;           // Strata treningowa
    double validation_loss;         // Strata walidacyjna
    double training_accuracy;       // Dokładność treningowa
    double validation_accuracy;     // Dokładność walidacyjna
    int epochs_completed;           // Liczba ukończonych epok
    double final_loss;              // Końcowa strata
    double final_accuracy;          // Końcowa dokładność
    double best_loss;               // Najlepsza strata
    double best_accuracy;           // Najlepsza dokładność
    bool early_stopped;             // Czy early stopping został aktywowany
    double convergence_time;        // Czas zbieżności
    string error_message;           // Komunikat błędu
    double model_size;              // Rozmiar modelu (MB)
    bool overfitting_detected;      // Czy wykryto overfitting
    double overfitting_score;       // Skala overfitting
    SNeuralNetworkParams params;    // Parametry sieci
    datetime training_time;         // Czas treningu
};

// Struktura predykcji sieci - bez dynamicznych tablic (MQL5 limitation)
struct SNeuralPrediction {
    double confidence;              // Pewność predykcji
    int predicted_class;            // Predykcja klasy (dla klasyfikacji)
    double prediction_time;         // Czas predykcji
    bool is_anomaly;                // Czy to anomalia
    double anomaly_score;           // Skala anomalii
    string explanation;             // Wyjaśnienie predykcji
    double output[];                // Wyjście modelu (np. 1D)
};

// === KLASA GŁÓWNA NEURAL NETWORK ===

class CNeuralNetwork {
private:
    // Parametry sieci
    SNeuralNetworkParams m_params;      // Parametry sieci
    SNeuralTrainingResult m_training_result; // Wyniki treningu
    
    // Warstwy sieci
    SNeuralLayer m_layers[];            // Tablica warstw
    int m_layers_count;                 // Liczba warstw
    
    // Dane treningowe (spłaszczone 2D -> 1D)
    double m_training_data[];           // Dane treningowe (flattened)
    double m_training_labels[];         // Etykiety treningowe
    double m_validation_data[];         // Dane walidacyjne (flattened)
    double m_validation_labels[];       // Etykiety walidacyjne
    int m_data_size;                    // Rozmiar danych
    int m_features_count;               // Liczba cech
    
    // Statystyki
    bool m_model_trained;               // Czy model jest wytrenowany
    bool m_data_loaded;                 // Czy dane są załadowane
    int m_total_predictions;            // Łączna liczba predykcji
    double m_avg_prediction_time;       // Średni czas predykcji
    double m_total_training_time;       // Łączny czas treningu
    datetime m_last_training;           // Ostatni trening
    bool m_early_stopped;               // Czy early stopping został aktywowany
    double m_best_loss;                 // Najlepsza strata
    double m_best_accuracy;             // Najlepsza dokładność
    int m_epochs_without_improvement;   // Epoki bez poprawy
    
    // Cache i optymalizacje
    double m_input_cache[];             // Cache wejścia
    double m_output_cache[];            // Cache wyjścia
    double m_gradient_cache[];          // Cache gradientów - spłaszczony do 1D
    bool m_cache_valid;                 // Czy cache jest aktualny
    
    // Tablice dla warstw - używamy tablic 1D (MQL5 limitation)
    // Wszystkie dane przechowywane w tablicach 1D z indeksowaniem ręcznym
    double m_weights[];                 // Wagi warstw - spłaszczone do 1D
    double m_bias[];                    // Bias warstw - spłaszczone do 1D
    double m_gradients[];               // Gradienty - spłaszczone do 1D
    double m_bias_gradients[];          // Gradienty bias - spłaszczone do 1D
    double m_activations[];             // Aktywacje - spłaszczone do 1D
    double m_deltas[];                  // Deltas - spłaszczone do 1D
    double m_momentum_weights[];        // Momentum wag - spłaszczone do 1D
    double m_momentum_bias[];           // Momentum bias - spłaszczone do 1D
    double m_velocity_weights[];        // Velocity wag - spłaszczone do 1D
    double m_velocity_bias[];           // Velocity bias - spłaszczone do 1D
    double m_cache_weights[];           // Cache wag - spłaszczone do 1D
    double m_cache_bias[];              // Cache bias - spłaszczone do 1D
    
    // Pomocnicze: indeks w spłaszczonych tablicach danych
    int TrainingOffset(const int sample_index, const int feature_index);
    int ValidationOffset(const int sample_index, const int feature_index);
    
public:
    // Konstruktor i destruktor
    CNeuralNetwork();
    ~CNeuralNetwork();
    
    // Inicjalizacja i konfiguracja
    bool Initialize(SNeuralNetworkParams &params);
    bool SetParameters(SNeuralNetworkParams &params);
    bool AddLayer(SNeuralLayerParams &layer_params);
    bool AddDenseLayer(int units, ENUM_ACTIVATION_FUNCTION activation);
    bool BuildModel();
    bool CompileModel();
    
    // Zarządzanie danymi
    bool LoadData(double &data[][], double &labels[]);
    bool LoadDataFromFile(string filename);
    bool PreprocessData();
    bool SplitData(double validation_ratio);
    bool NormalizeData();
    bool AugmentData();
    
    // Trening
    bool TrainModel();
    bool TrainEpoch();
    bool TrainBatch(double &batch_data[][], double &batch_labels[]);
    bool Backpropagate(double &targets[]);
    bool UpdateWeights();
    bool ValidateModel();
    
    // Predykcje
    SNeuralPrediction Predict(double &input_data[]);
    SNeuralPrediction PredictBatch(double &inputs[][]);
    double ForwardPass(double &input_data[]);
    double BackwardPass(double &targets[]);
    
    // Funkcje aktywacji
    double Activate(double x, ENUM_ACTIVATION_FUNCTION activation);
    double ActivateDerivative(double x, ENUM_ACTIVATION_FUNCTION activation);
    bool ActivateArray(double &array[], ENUM_ACTIVATION_FUNCTION activation);
    bool ActivateDerivativeArray(double &array[], ENUM_ACTIVATION_FUNCTION activation);
    
    // Funkcje straty
    double CalculateLoss(double &predictions[], double &targets[]);
    double CalculateLossDerivative(double prediction, double target);
    double CalculateAccuracy(double &predictions[], double &targets[]);
    
    // Optymalizatory
    bool ApplySGD(int layer_index);
    bool ApplyAdam(int layer_index);
    bool ApplyRMSprop(int layer_index);
    bool ApplyAdagrad(int layer_index);
    bool ApplyAdadelta(int layer_index);
    bool ApplyNadam(int layer_index);
    bool ApplyAMSGrad(int layer_index);
    bool ApplyAdamW(int layer_index);
    
    // Inicjalizacja wag
    bool InitializeWeights(int layer_index);
    bool InitializeXavier(int layer_index);
    bool InitializeHe(int layer_index);
    bool InitializeLeCun(int layer_index);
    bool InitializeOrthogonal(int layer_index);
    bool InitializeUniform(int layer_index);
    
    // Zapisywanie i wczytywanie
    bool SaveModel(string filename);
    bool LoadModel(string filename);
    bool ExportModel(string filename);
    bool ImportModel(string filename);
    
    // Analiza modelu
    double GetLayerOutput(int layer_index, int neuron_index);
    double GetWeight(int layer_index, int from_neuron, int to_neuron);
    double GetBias(int layer_index, int neuron_index);
    double GetGradient(int layer_index, int from_neuron, int to_neuron);
    string GetModelSummary();
    string GetTrainingReport();
    string GetLayerReport(int layer_index);
    
    // Narzędzia pomocnicze
    bool IsModelTrained();
    bool IsDataLoaded();
    int GetLayersCount();
    int GetTotalParameters();
    double GetTrainingTime();
    double GetAveragePredictionTime();
    int GetTotalPredictions();
    
    // Czyszczenie i reset
    void ClearModel();
    void ClearCache();
    void ResetStatistics();
    void Cleanup();
    
private:
    // Funkcje pomocnicze
    bool ValidateInput(double &input_data[]);
    bool ValidateTargets(double &targets[]);
    void UpdateStatistics(double prediction_time);
    string FormatTime(double seconds);
    double GenerateRandomDouble(double min, double max);
    int GenerateRandomInteger(int min, int max);
    void ShuffleData();
    double CalculateDistance(double &point1[], double &point2[]);
    bool IsAnomaly(double &input_data[], double threshold);
    string GenerateExplanation(double &input_data[], SNeuralPrediction &prediction);
};

// === IMPLEMENTACJA PODSTAWOWYCH FUNKCJI ===

// Konstruktor
CNeuralNetwork::CNeuralNetwork() {
    m_layers_count = 0;
    m_model_trained = false;
    m_data_loaded = false;
    m_total_predictions = 0;
    m_avg_prediction_time = 0.0;
    m_total_training_time = 0.0;
    
    // Inicjalizacja parametrów domyślnych
    m_params.input_size = 10;
    m_params.output_size = 1;
    m_params.hidden_activation = ACTIVATION_RELU;
    m_params.output_activation = ACTIVATION_LINEAR;
    m_params.optimizer = OPTIMIZER_ADAM;
    m_params.loss_function = LOSS_MEAN_SQUARED_ERROR;
    m_params.learning_rate = 0.001;
    m_params.batch_size = 32;
    m_params.epochs = 100;
    m_params.validation_split = 0.2;
    m_params.shuffle_data = true;
    m_params.early_stopping = true;
    m_params.patience = 10;
    m_params.min_delta = 1e-6;
    m_params.verbose = true;
    m_params.random_seed = 42;
    m_params.weight_decay = 0.0;
    m_params.gradient_clip = 1.0;
    m_params.use_batch_norm = false;
    m_params.batch_norm_momentum = 0.9;
    m_params.use_dropout = false;
    m_params.dropout_rate = 0.5;
    m_params.model_name = "NeuralNetwork";
    m_params.creation_time = TimeCurrent();
    
    // Inicjalizacja statystyk
    m_early_stopped = false;
    m_best_loss = 1e10;
    m_best_accuracy = 0.0;
    m_epochs_without_improvement = 0;
    m_cache_valid = false;
    
    // Inicjalizacja ziarna losowości
    if(m_params.random_seed > 0) {
        MathSrand(m_params.random_seed);
    }
}

// Destruktor
CNeuralNetwork::~CNeuralNetwork() {
    Cleanup();
}

// Inicjalizacja
bool CNeuralNetwork::Initialize(SNeuralNetworkParams &params) {
    m_params = params;
    m_model_trained = false;
    m_data_loaded = false;
    m_layers_count = 0;
    
    // Inicjalizacja ziarna losowości
    if(m_params.random_seed > 0) {
        MathSrand(m_params.random_seed);
    }
    
    return true;
}

// Wczytanie danych
bool CNeuralNetwork::LoadData(double &data[][], double &labels[]) {
    if(ArraySize(data) <= 0 || ArraySize(labels) <= 0) {
        return false;
    }
    
    int total_samples = ArraySize(data);
    int features_count = 0;
    if(total_samples > 0) {
        features_count = ArraySize(data[0]);
    }
    
    if(total_samples != ArraySize(labels)) {
        return false;
    }
    
    // Podział na trening i walidację
    int training_samples = (int)(total_samples * (1.0 - m_params.validation_split));
    int validation_samples = total_samples - training_samples;
    
    // Alokacja pamięci (spłaszczone)
    ArrayResize(m_training_data, training_samples * features_count);
    ArrayResize(m_training_labels, training_samples);
    ArrayResize(m_validation_data, validation_samples * features_count);
    ArrayResize(m_validation_labels, validation_samples);
    
    // Kopiowanie danych treningowych (flattened)
    for(int i = 0; i < training_samples; i++) {
        for(int j = 0; j < features_count; j++) {
            if(i < ArraySize(data) && j < ArraySize(data[i])) {
                int off = TrainingOffset(i, j);
                if(off >= 0 && off < ArraySize(m_training_data)) {
                    m_training_data[off] = data[i][j];
                }
            }
        }
        if(i < ArraySize(m_training_labels)) {
            m_training_labels[i] = labels[i];
        }
    }
    
    // Kopiowanie danych walidacyjnych (flattened)
    for(int i = 0; i < validation_samples; i++) {
        for(int j = 0; j < features_count; j++) {
            if(training_samples + i < ArraySize(data) && j < ArraySize(data[training_samples + i])) {
                int off = ValidationOffset(i, j);
                if(off >= 0 && off < ArraySize(m_validation_data)) {
                    m_validation_data[off] = data[training_samples + i][j];
                }
            }
        }
        if(i < ArraySize(m_validation_labels) && training_samples + i < ArraySize(labels)) {
            m_validation_labels[i] = labels[training_samples + i];
        }
    }
    
    m_data_size = training_samples;
    m_features_count = features_count;
    m_data_loaded = true;
    
    return true;
}

// Dodanie warstwy gęstej
bool CNeuralNetwork::AddDenseLayer(int units, ENUM_ACTIVATION_FUNCTION activation) {
    SNeuralLayerParams layer_params;
    layer_params.layer_type = LAYER_DENSE;
    layer_params.output_size = units;
    layer_params.activation = activation;
    layer_params.dropout_rate = m_params.dropout_rate;
    layer_params.use_bias = true;
    layer_params.weight_init = WEIGHT_INIT_XAVIER;
    layer_params.learning_rate = m_params.learning_rate;
    layer_params.momentum = 0.9;
    layer_params.epsilon = 1e-8;
    layer_params.beta1 = 0.9;
    layer_params.beta2 = 0.999;
    layer_params.decay = 0.9;
    layer_params.clip_norm = m_params.gradient_clip;
    layer_params.trainable = true;
    layer_params.name = "Dense_" + IntegerToString(m_layers_count);
    
    return AddLayer(layer_params);
}

// Dodanie warstwy
bool CNeuralNetwork::AddLayer(SNeuralLayerParams &layer_params) {
    if(m_layers_count >= 100) { // Maksymalna liczba warstw
        return false;
    }
    
    // Ustaw rozmiar wejścia dla pierwszej warstwy
    if(m_layers_count == 0) {
        layer_params.input_size = m_params.input_size;
    } else {
        layer_params.input_size = m_layers[m_layers_count - 1].params.output_size;
    }
    
    // Dodaj warstwę
    ArrayResize(m_layers, m_layers_count + 1);
    m_layers[m_layers_count] = SNeuralLayer();
    m_layers[m_layers_count].params = layer_params;
    m_layers[m_layers_count].layer_index = m_layers_count;
    m_layers[m_layers_count].is_initialized = false;
    m_layers[m_layers_count].last_update = TimeCurrent();
    
    m_layers_count++;
    
    return true;
}

// Budowanie architektury
bool CNeuralNetwork::BuildModel() {
    if(m_layers_count == 0) {
        // Dodaj domyślne warstwy jeśli nie ma żadnych
        if(!AddDenseLayer(64, ACTIVATION_RELU)) return false;
        if(!AddDenseLayer(32, ACTIVATION_RELU)) return false;
        if(!AddDenseLayer(m_params.output_size, m_params.output_activation)) return false;
    }
    
    // Inicjalizacja wszystkich warstw
    for(int i = 0; i < m_layers_count; i++) {
        if(!InitializeWeights(i)) return false;
    }
    
    return true;
}

// Inicjalizacja wag
bool CNeuralNetwork::InitializeWeights(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) {
        return false;
    }
    
    SNeuralLayer &layer = m_layers[layer_index];
    int input_size = layer.params.input_size;
    int output_size = layer.params.output_size;
    
    // Inicjalizacja macierzy wag
    ArrayResize(layer.weights, input_size);
    ArrayResize(layer.gradients, input_size);
    ArrayResize(layer.momentum_weights, input_size);
    ArrayResize(layer.velocity_weights, input_size);
    ArrayResize(layer.cache_weights, input_size);
    
    for(int i = 0; i < input_size; i++) {
        ArrayResize(layer.weights[i], output_size);
        ArrayResize(layer.gradients[i], output_size);
        ArrayResize(layer.momentum_weights[i], output_size);
        ArrayResize(layer.velocity_weights[i], output_size);
        ArrayResize(layer.cache_weights[i], output_size);
    }
    
    // Inicjalizacja bias
    ArrayResize(layer.bias, output_size);
    ArrayResize(layer.bias_gradients, output_size);
    ArrayResize(layer.momentum_bias, output_size);
    ArrayResize(layer.velocity_bias, output_size);
    ArrayResize(layer.cache_bias, output_size);
    
    // Inicjalizacja aktywacji i deltas
    ArrayResize(layer.activations, output_size);
    ArrayResize(layer.deltas, output_size);
    
    // Inicjalizacja wag według wybranej metody
    switch(layer.params.weight_init) {
        case WEIGHT_INIT_XAVIER:
            return InitializeXavier(layer_index);
        case WEIGHT_INIT_HE:
            return InitializeHe(layer_index);
        case WEIGHT_INIT_LECUN:
            return InitializeLeCun(layer_index);
        case WEIGHT_INIT_ORTHOGONAL:
            return InitializeOrthogonal(layer_index);
        case WEIGHT_INIT_UNIFORM:
            return InitializeUniform(layer_index);
        default:
            return InitializeXavier(layer_index);
    }
}

// Inicjalizacja Xavier/Glorot
bool CNeuralNetwork::InitializeXavier(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    int input_size = layer.params.input_size;
    int output_size = layer.params.output_size;
    
    double scale = MathSqrt(2.0 / (input_size + output_size));
    
    // Inicjalizacja wag
    for(int i = 0; i < input_size; i++) {
        for(int j = 0; j < output_size; j++) {
            layer.weights[i][j] = GenerateRandomDouble(-scale, scale);
            layer.gradients[i][j] = 0.0;
            layer.momentum_weights[i][j] = 0.0;
            layer.velocity_weights[i][j] = 0.0;
            layer.cache_weights[i][j] = 0.0;
        }
    }
    
    // Inicjalizacja bias
    for(int j = 0; j < output_size; j++) {
        layer.bias[j] = 0.0;
        layer.bias_gradients[j] = 0.0;
        layer.momentum_bias[j] = 0.0;
        layer.velocity_bias[j] = 0.0;
        layer.cache_bias[j] = 0.0;
    }
    
    layer.is_initialized = true;
    return true;
}

// Inicjalizacja He
bool CNeuralNetwork::InitializeHe(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    int input_size = layer.params.input_size;
    int output_size = layer.params.output_size;
    
    double scale = MathSqrt(2.0 / input_size);
    
    // Inicjalizacja wag
    for(int i = 0; i < input_size; i++) {
        for(int j = 0; j < output_size; j++) {
            layer.weights[i][j] = GenerateRandomDouble(-scale, scale);
            layer.gradients[i][j] = 0.0;
            layer.momentum_weights[i][j] = 0.0;
            layer.velocity_weights[i][j] = 0.0;
            layer.cache_weights[i][j] = 0.0;
        }
    }
    
    // Inicjalizacja bias
    for(int j = 0; j < output_size; j++) {
        layer.bias[j] = 0.0;
        layer.bias_gradients[j] = 0.0;
        layer.momentum_bias[j] = 0.0;
        layer.velocity_bias[j] = 0.0;
        layer.cache_bias[j] = 0.0;
    }
    
    layer.is_initialized = true;
    return true;
}

// Inicjalizacja LeCun
bool CNeuralNetwork::InitializeLeCun(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    int input_size = layer.params.input_size;
    int output_size = layer.params.output_size;
    
    double scale = MathSqrt(1.0 / input_size);
    
    // Inicjalizacja wag
    for(int i = 0; i < input_size; i++) {
        for(int j = 0; j < output_size; j++) {
            layer.weights[i][j] = GenerateRandomDouble(-scale, scale);
            layer.gradients[i][j] = 0.0;
            layer.momentum_weights[i][j] = 0.0;
            layer.velocity_weights[i][j] = 0.0;
            layer.cache_weights[i][j] = 0.0;
        }
    }
    
    // Inicjalizacja bias
    for(int j = 0; j < output_size; j++) {
        layer.bias[j] = 0.0;
        layer.bias_gradients[j] = 0.0;
        layer.momentum_bias[j] = 0.0;
        layer.velocity_bias[j] = 0.0;
        layer.cache_bias[j] = 0.0;
    }
    
    layer.is_initialized = true;
    return true;
}

// Inicjalizacja ortogonalna
bool CNeuralNetwork::InitializeOrthogonal(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    int input_size = layer.params.input_size;
    int output_size = layer.params.output_size;
    
    // Uproszczona inicjalizacja ortogonalna
    double scale = MathSqrt(2.0 / (input_size + output_size));
    
    for(int i = 0; i < input_size; i++) {
        for(int j = 0; j < output_size; j++) {
            layer.weights[i][j] = GenerateRandomDouble(-scale, scale);
            layer.gradients[i][j] = 0.0;
            layer.momentum_weights[i][j] = 0.0;
            layer.velocity_weights[i][j] = 0.0;
            layer.cache_weights[i][j] = 0.0;
        }
    }
    
    // Inicjalizacja bias
    for(int j = 0; j < output_size; j++) {
        layer.bias[j] = 0.0;
        layer.bias_gradients[j] = 0.0;
        layer.momentum_bias[j] = 0.0;
        layer.velocity_bias[j] = 0.0;
        layer.cache_bias[j] = 0.0;
    }
    
    layer.is_initialized = true;
    return true;
}

// Inicjalizacja jednostajna
bool CNeuralNetwork::InitializeUniform(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    int input_size = layer.params.input_size;
    int output_size = layer.params.output_size;
    
    double scale = MathSqrt(6.0 / (input_size + output_size));
    
    // Inicjalizacja wag
    for(int i = 0; i < input_size; i++) {
        for(int j = 0; j < output_size; j++) {
            layer.weights[i][j] = GenerateRandomDouble(-scale, scale);
            layer.gradients[i][j] = 0.0;
            layer.momentum_weights[i][j] = 0.0;
            layer.velocity_weights[i][j] = 0.0;
            layer.cache_weights[i][j] = 0.0;
        }
    }
    
    // Inicjalizacja bias
    for(int j = 0; j < output_size; j++) {
        layer.bias[j] = 0.0;
        layer.bias_gradients[j] = 0.0;
        layer.momentum_bias[j] = 0.0;
        layer.velocity_bias[j] = 0.0;
        layer.cache_bias[j] = 0.0;
    }
    
    layer.is_initialized = true;
    return true;
}

// Funkcje aktywacji
double CNeuralNetwork::Activate(double x, ENUM_ACTIVATION_FUNCTION activation) {
    switch(activation) {
        case ACTIVATION_RELU:
            return MathMax(0, x);
        case ACTIVATION_SIGMOID:
            return 1.0 / (1.0 + MathExp(-x));
        case ACTIVATION_TANH:
            return MathTanh(x);
        case ACTIVATION_SOFTMAX:
            return MathExp(x); // Uproszczone - pełna implementacja wymaga normalizacji
        case ACTIVATION_LEAKY_RELU:
            return x > 0 ? x : 0.01 * x;
        case ACTIVATION_ELU:
            return x > 0 ? x : 0.01 * (MathExp(x) - 1);
        case ACTIVATION_SELU:
            return x > 0 ? 1.0507 * x : 1.0507 * 1.67326 * (MathExp(x) - 1);
        case ACTIVATION_SWISH:
            return x / (1.0 + MathExp(-x));
        case ACTIVATION_GELU:
            return 0.5 * x * (1.0 + MathTanh(MathSqrt(2.0 / 3.14159) * (x + 0.044715 * MathPow(x, 3))));
        case ACTIVATION_MISH:
            return x * MathTanh(MathLog(1.0 + MathExp(x)));
        case ACTIVATION_LINEAR:
        case ACTIVATION_NONE:
        default:
            return x;
    }
}

// Pochodne funkcji aktywacji
double CNeuralNetwork::ActivateDerivative(double x, ENUM_ACTIVATION_FUNCTION activation) {
    switch(activation) {
        case ACTIVATION_RELU:
            return x > 0 ? 1.0 : 0.0;
        case ACTIVATION_SIGMOID: {
            double sigmoid = 1.0 / (1.0 + MathExp(-x));
            return sigmoid * (1.0 - sigmoid);
        }
        case ACTIVATION_TANH: {
            double tanh_val = MathTanh(x);
            return 1.0 - tanh_val * tanh_val;
        }
        case ACTIVATION_LEAKY_RELU:
            return x > 0 ? 1.0 : 0.01;
        case ACTIVATION_ELU:
            return x > 0 ? 1.0 : 0.01 * MathExp(x);
        case ACTIVATION_SELU:
            return x > 0 ? 1.0507 : 1.0507 * 1.67326 * MathExp(x);
        case ACTIVATION_SWISH: {
            double swish = x / (1.0 + MathExp(-x));
            return swish + (1.0 - swish) * (1.0 / (1.0 + MathExp(-x)));
        }
        case ACTIVATION_GELU: {
            double cdf = 0.5 * (1.0 + MathTanh(MathSqrt(2.0 / 3.14159) * (x + 0.044715 * MathPow(x, 3))));
            double pdf = MathExp(-0.5 * x * x) / MathSqrt(2.0 * 3.14159);
            return cdf + x * pdf * 0.5 * MathSqrt(2.0 / 3.14159) * (1.0 + 0.134145 * x * x);
        }
        case ACTIVATION_MISH: {
            double omega = MathExp(3 * x) + 4 * MathExp(2 * x) + MathExp(x) * (4 * x + 6) + 4 * (x + 1);
            double delta = 2 * MathExp(x) + MathExp(2 * x) + 2;
            return MathExp(x) * omega / (delta * delta);
        }
        case ACTIVATION_LINEAR:
        case ACTIVATION_NONE:
        default:
            return 1.0;
    }
}

// Aktywacja tablicy
bool CNeuralNetwork::ActivateArray(double &array[], ENUM_ACTIVATION_FUNCTION activation) {
    int size = ArraySize(array);
    for(int i = 0; i < size; i++) {
        array[i] = Activate(array[i], activation);
    }
    return true;
}

// Pochodna aktywacji tablicy
bool CNeuralNetwork::ActivateDerivativeArray(double &array[], ENUM_ACTIVATION_FUNCTION activation) {
    int size = ArraySize(array);
    for(int i = 0; i < size; i++) {
        array[i] = ActivateDerivative(array[i], activation);
    }
    return true;
}

// Forward pass
double CNeuralNetwork::ForwardPass(double &input_data[]) {
    if(!IsDataLoaded() || !ValidateInput(input_data)) return 0.0;
    
    double current_input[];
    ArrayCopy(current_input, input_data);
    
    // Przejście przez wszystkie warstwy
    for(int layer = 0; layer < m_layers_count; layer++) {
        SNeuralLayer &current_layer = m_layers[layer];
        
        // Upewnij się, że bufory są zainicjalizowane
        if(!current_layer.is_initialized) {
            ArrayResize(current_layer.bias, current_layer.params.output_size);
            ArrayResize(current_layer.activations, current_layer.params.output_size);
            ArrayResize(current_layer.deltas, current_layer.params.output_size);
            ArrayResize(current_layer.bias_gradients, current_layer.params.output_size);
            ArrayResize(current_layer.momentum_bias, current_layer.params.output_size);
            ArrayResize(current_layer.velocity_bias, current_layer.params.output_size);
            ArrayResize(current_layer.cache_bias, current_layer.params.output_size);

            int weight_len = current_layer.params.input_size * current_layer.params.output_size;
            ArrayResize(current_layer.weights, weight_len);
            ArrayResize(current_layer.gradients, weight_len);
            ArrayResize(current_layer.momentum_weights, weight_len);
            ArrayResize(current_layer.velocity_weights, weight_len);
            ArrayResize(current_layer.cache_weights, weight_len);

            // Inicjalizacja domyślna
            for(int i = 0; i < current_layer.params.input_size; i++) {
                for(int j = 0; j < current_layer.params.output_size; j++) {
                    int off = i * current_layer.params.output_size + j;
                    current_layer.weights[off] = 0.0;
                    current_layer.gradients[off] = 0.0;
                    current_layer.momentum_weights[off] = 0.0;
                    current_layer.velocity_weights[off] = 0.0;
                    current_layer.cache_weights[off] = 0.0;
                }
            }
            for(int j = 0; j < current_layer.params.output_size; j++) {
                current_layer.bias[j] = 0.0;
                current_layer.activations[j] = 0.0;
                current_layer.deltas[j] = 0.0;
                current_layer.bias_gradients[j] = 0.0;
                current_layer.momentum_bias[j] = 0.0;
                current_layer.velocity_bias[j] = 0.0;
                current_layer.cache_bias[j] = 0.0;
            }
            current_layer.is_initialized = true;
        }

        // Obliczenie wyjścia warstwy
        for(int j = 0; j < current_layer.params.output_size; j++) {
            double sum = current_layer.bias[j];
            
            for(int i = 0; i < current_layer.params.input_size; i++) {
                if(i < ArraySize(current_input)) {
                    int off = i * current_layer.params.output_size + j;
                    sum += current_layer.weights[off] * current_input[i];
                }
            }
            
            current_layer.activations[j] = sum;
        }
        
        // Zastosowanie funkcji aktywacji
        ActivateArray(current_layer.activations, current_layer.params.activation);
        
        // Przygotowanie wejścia dla następnej warstwy
            ArrayResize(current_input, current_layer.params.output_size);
            for(int k = 0; k < current_layer.params.output_size; k++) {
                current_input[k] = current_layer.activations[k];
            }
    }
    
    // Zwróć wyjście ostatniej warstwy
    if(m_layers_count > 0) {
        SNeuralLayer &last_layer = m_layers[m_layers_count - 1];
        return last_layer.activations[0]; // Uproszczone - zwraca pierwszy neuron
    }
    
    return 0.0;
}

// Funkcje straty
double CNeuralNetwork::CalculateLoss(double &predictions[], double &targets[]) {
    int size = MathMin(ArraySize(predictions), ArraySize(targets));
    if(size == 0) return 0.0;
    
    double total_loss = 0.0;
    
    switch(m_params.loss_function) {
        case LOSS_MEAN_SQUARED_ERROR: {
            for(int i = 0; i < size; i++) {
                double error = predictions[i] - targets[i];
                total_loss += error * error;
            }
            return total_loss / size;
        }
        case LOSS_MEAN_ABSOLUTE_ERROR: {
            for(int i = 0; i < size; i++) {
                total_loss += MathAbs(predictions[i] - targets[i]);
            }
            return total_loss / size;
        }
        case LOSS_BINARY_CROSSENTROPY: {
            for(int i = 0; i < size; i++) {
                double p = MathMax(1e-15, MathMin(1.0 - 1e-15, predictions[i]));
                total_loss += -targets[i] * MathLog(p) - (1.0 - targets[i]) * MathLog(1.0 - p);
            }
            return total_loss / size;
        }
        case LOSS_HUBER: {
            double delta = 1.0;
            for(int i = 0; i < size; i++) {
                double error = MathAbs(predictions[i] - targets[i]);
                if(error <= delta) {
                    total_loss += 0.5 * error * error;
                } else {
                    total_loss += delta * error - 0.5 * delta * delta;
                }
            }
            return total_loss / size;
        }
            
        default:
            return 0.0;
    }
}

// Pochodna funkcji straty
double CNeuralNetwork::CalculateLossDerivative(double prediction, double target) {
    switch(m_params.loss_function) {
        case LOSS_MEAN_SQUARED_ERROR:
            return 2.0 * (prediction - target);
            
        case LOSS_MEAN_ABSOLUTE_ERROR:
            return prediction > target ? 1.0 : -1.0;
            
        case LOSS_BINARY_CROSSENTROPY: {
            double p = MathMax(1e-15, MathMin(1.0 - 1e-15, prediction));
            return (p - target) / (p * (1.0 - p));
        }
            
        case LOSS_HUBER: {
            double delta = 1.0;
            double error = prediction - target;
            if(MathAbs(error) <= delta) {
                return error;
            } else {
                return error > 0 ? delta : -delta;
            }
        }
            
        default:
            return 0.0;
    }
}

// Obliczenie dokładności
double CNeuralNetwork::CalculateAccuracy(double &predictions[], double &targets[]) {
    int size = MathMin(ArraySize(predictions), ArraySize(targets));
    if(size == 0) return 0.0;
    
    int correct = 0;
    
    for(int i = 0; i < size; i++) {
        int pred_class = predictions[i] > 0.5 ? 1 : 0;
        int true_class = targets[i] > 0.5 ? 1 : 0;
        
        if(pred_class == true_class) {
            correct++;
        }
    }
    
    return (double)correct / size;
}

// Funkcje pomocnicze
bool CNeuralNetwork::IsModelTrained() {
    return m_model_trained;
}

bool CNeuralNetwork::IsDataLoaded() {
    return m_data_loaded;
}

int CNeuralNetwork::GetLayersCount() {
    return m_layers_count;
}

int CNeuralNetwork::GetTotalParameters() {
    int total = 0;
    for(int i = 0; i < m_layers_count; i++) {
        total += m_layers[i].params.input_size * m_layers[i].params.output_size;
        if(m_layers[i].params.use_bias) {
            total += m_layers[i].params.output_size;
        }
    }
    return total;
}

double CNeuralNetwork::GetTrainingTime() {
    return m_total_training_time;
}

double CNeuralNetwork::GetAveragePredictionTime() {
    return m_avg_prediction_time;
}

int CNeuralNetwork::GetTotalPredictions() {
    return m_total_predictions;
}

bool CNeuralNetwork::ValidateInput(double &input_data[]) {
    return ArraySize(input_data) >= m_params.input_size;
}

bool CNeuralNetwork::ValidateTargets(double &targets[]) {
    return ArraySize(targets) > 0;
}

void CNeuralNetwork::UpdateStatistics(double prediction_time) {
    m_total_predictions++;
    m_avg_prediction_time = (m_avg_prediction_time * (m_total_predictions - 1) + prediction_time) / m_total_predictions;
}

string CNeuralNetwork::FormatTime(double seconds) {
    if(seconds < 60) {
        return DoubleToString(seconds, 2) + "s";
    } else if(seconds < 3600) {
        return DoubleToString(seconds / 60, 2) + "m";
    } else {
        return DoubleToString(seconds / 3600, 2) + "h";
    }
}

double CNeuralNetwork::GenerateRandomDouble(double min, double max) {
    return min + (max - min) * ((double)MathRand() / 32767.0);
}

int CNeuralNetwork::GenerateRandomInteger(int min, int max) {
    return min + (int)((max - min + 1) * ((double)MathRand() / 32768.0));
}

void CNeuralNetwork::ShuffleData() {
    if(!m_data_loaded) return;
    
    // Fisher-Yates shuffle
    for(int i = m_data_size - 1; i > 0; i--) {
        int j = GenerateRandomInteger(0, i);
        
        // Zamień dane (flattened)
        for(int feat = 0; feat < m_features_count; feat++) {
            int off_i = TrainingOffset(i, feat);
            int off_j = TrainingOffset(j, feat);
            double temp = m_training_data[off_i];
            m_training_data[off_i] = m_training_data[off_j];
            m_training_data[off_j] = temp;
        }
        
        // Zamień etykiety
        double temp_label = m_training_labels[i];
        m_training_labels[i] = m_training_labels[j];
        m_training_labels[j] = temp_label;
    }
}

int CNeuralNetwork::TrainingOffset(const int sample_index, const int feature_index) {
    return sample_index * m_features_count + feature_index;
}

int CNeuralNetwork::ValidationOffset(const int sample_index, const int feature_index) {
    return sample_index * m_features_count + feature_index;
}

double CNeuralNetwork::CalculateDistance(double &point1[], double &point2[]) {
    double distance = 0.0;
    int size = MathMin(ArraySize(point1), ArraySize(point2));
    
    for(int i = 0; i < size; i++) {
        double diff = point1[i] - point2[i];
        distance += diff * diff;
    }
    
    return MathSqrt(distance);
}

bool CNeuralNetwork::IsAnomaly(double &input_data[], double threshold) {
    // Uproszczone wykrywanie anomalii
    double prediction = ForwardPass(input_data);
    double error = MathAbs(prediction - input_data[0]); // Porównanie z pierwszym elementem
    return error > threshold;
}

string CNeuralNetwork::GenerateExplanation(double &input_data[], SNeuralPrediction &prediction) {
    string explanation = "Predykcja: " + DoubleToString(prediction.confidence, 4);
    explanation += ", Pewność: " + DoubleToString(prediction.confidence, 2);
    explanation += ", Czas: " + FormatTime(prediction.prediction_time);
    
    if(prediction.is_anomaly) {
        explanation += ", ANOMALIA: " + DoubleToString(prediction.anomaly_score, 4);
    }
    
    return explanation;
}

// Predykcja
SNeuralPrediction CNeuralNetwork::Predict(double &input_data[]) {
    SNeuralPrediction prediction;
    prediction.prediction_time = 0.0;
    prediction.confidence = 0.0;
    prediction.is_anomaly = false;
    prediction.anomaly_score = 0.0;
    
    if(!IsModelTrained() || !ValidateInput(input_data)) {
        return prediction;
    }
    
    datetime start_time = TimeCurrent();
    
    // Forward pass
    double output = ForwardPass(input_data);
    
    // Przygotuj wynik
    ArrayResize(prediction.output, 1);
    prediction.output[0] = output;
    prediction.confidence = 0.8; // Domyślna pewność
    
    // Sprawdź czy to anomalia
    prediction.is_anomaly = IsAnomaly(input_data, 2.0);
    if(prediction.is_anomaly) {
        prediction.anomaly_score = MathAbs(output - input_data[0]);
    }
    
    prediction.prediction_time = (double)(TimeCurrent() - start_time);
    UpdateStatistics(prediction.prediction_time);
    
    return prediction;
}

// Trening modelu
bool CNeuralNetwork::TrainModel() {
    if(!IsDataLoaded()) {
        LogError(LOG_COMPONENT_AI, "Brak danych treningowych", "Dane muszą być załadowane przed treningiem");
        return false;
    }
    
    if(m_layers_count == 0) {
        if(!BuildModel()) {
            LogError(LOG_COMPONENT_AI, "Błąd budowania architektury", "Nie można zbudować architektury sieci");
            return false;
        }
    }
    
    datetime start_time = TimeCurrent();
    LogInfo(LOG_COMPONENT_AI, "Rozpoczęcie treningu", 
            "Epoki: " + IntegerToString(m_params.epochs) + 
            ", Batch size: " + IntegerToString(m_params.batch_size) + 
            ", Learning rate: " + DoubleToString(m_params.learning_rate, 6));
    
    // Inicjalizacja wyników treningu
    m_training_result.epochs_completed = 0;
    m_training_result.final_loss = 0.0;
    m_training_result.final_accuracy = 0.0;
    m_training_result.best_loss = 1e10;
    m_training_result.best_accuracy = 0.0;
    m_training_result.early_stopped = false;
    
    // Trening przez epoki
    for(int epoch = 0; epoch < m_params.epochs; epoch++) {
        if(!TrainEpoch()) {
            LogError(LOG_COMPONENT_AI, "Błąd w epoce " + IntegerToString(epoch), "Trening przerwany");
            return false;
        }
        
        // Early stopping check
        if(m_params.early_stopping && epoch > m_params.patience) {
            if(m_training_result.final_loss > m_training_result.best_loss + m_params.min_delta) {
                m_training_result.early_stopped = true;
                LogInfo(LOG_COMPONENT_AI, "Early stopping", "Epoch " + IntegerToString(epoch) + " - brak poprawy");
                break;
            }
        }
        
        // Aktualizacja najlepszych wyników
        if(m_training_result.final_loss < m_training_result.best_loss) {
            m_training_result.best_loss = m_training_result.final_loss;
        }
        if(m_training_result.final_accuracy > m_training_result.best_accuracy) {
            m_training_result.best_accuracy = m_training_result.final_accuracy;
        }
        
        // Logowanie postępu
        if(m_params.verbose && epoch % 10 == 0) {
            LogInfo(LOG_COMPONENT_AI, "Postęp treningu", 
                    "Epoch " + IntegerToString(epoch) + "/" + IntegerToString(m_params.epochs) + 
                    ", Loss: " + DoubleToString(m_training_result.final_loss, 6) + 
                    ", Accuracy: " + DoubleToString(m_training_result.final_accuracy, 4));
        }
    }
    
    m_total_training_time = (double)(TimeCurrent() - start_time);
    m_model_trained = true;
    
    LogInfo(LOG_COMPONENT_AI, "Trening zakończony", 
            "Czas: " + FormatTime(m_total_training_time) + 
            ", Final Loss: " + DoubleToString(m_training_result.final_loss, 6) + 
            ", Final Accuracy: " + DoubleToString(m_training_result.final_accuracy, 4));
    
    return true;
}

// Trening jednej epoki
bool CNeuralNetwork::TrainEpoch() {
    if(!IsDataLoaded()) return false;
    
    // Mieszanie danych
    if(m_params.shuffle_data) {
        ShuffleData();
    }
    
    double epoch_loss = 0.0;
    double epoch_accuracy = 0.0;
    int batches_processed = 0;
    
    // Przetwarzanie batch po batch
    for(int batch_start = 0; batch_start < m_data_size; batch_start += m_params.batch_size) {
        int batch_end = MathMin(batch_start + m_params.batch_size, m_data_size);
        int batch_size = batch_end - batch_start;
        
        // Przygotowanie batch
        double batch_data[][];
        double batch_labels[];
        ArrayResize(batch_data, batch_size);
        ArrayResize(batch_labels, batch_size);
        
        for(int i = 0; i < batch_size; i++) {
            ArrayResize(batch_data[i], m_features_count);
            for(int j = 0; j < m_features_count; j++) {
                int off = TrainingOffset(batch_start + i, j);
                batch_data[i][j] = m_training_data[off];
            }
            batch_labels[i] = m_training_labels[batch_start + i];
        }
        
        // Trening batch
        if(!TrainBatch(batch_data, batch_labels)) {
            return false;
        }
        
        // Obliczenie loss i accuracy dla batch
        double batch_predictions[];
        ArrayResize(batch_predictions, batch_size);
        
        for(int i = 0; i < batch_size; i++) {
            batch_predictions[i] = ForwardPass(batch_data[i]);
        }
        
        double batch_loss = CalculateLoss(batch_predictions, batch_labels);
        double batch_accuracy = CalculateAccuracy(batch_predictions, batch_labels);
        
        epoch_loss += batch_loss * batch_size;
        epoch_accuracy += batch_accuracy * batch_size;
        batches_processed++;
    }
    
    // Aktualizacja wyników epoki
    if(batches_processed > 0) {
        m_training_result.final_loss = epoch_loss / m_data_size;
        m_training_result.final_accuracy = epoch_accuracy / m_data_size;
        m_training_result.epochs_completed++;
    }
    
    return true;
}

// Trening batch
bool CNeuralNetwork::TrainBatch(double &batch_data[][], double &batch_labels[]) {
    int batch_size = ArraySize(batch_data);
    if(batch_size == 0) return false;
    
    // Forward pass dla całego batch
    double batch_predictions[];
    ArrayResize(batch_predictions, batch_size);
    
    for(int i = 0; i < batch_size; i++) {
        batch_predictions[i] = ForwardPass(batch_data[i]);
    }
    
    // Backpropagation
    if(!Backpropagate(batch_labels)) {
        return false;
    }
    
    // Aktualizacja wag
    if(!UpdateWeights()) {
        return false;
    }
    
    return true;
}

// Backpropagation
bool CNeuralNetwork::Backpropagate(double &targets[]) {
    if(m_layers_count == 0) return false;
    
    int batch_size = ArraySize(targets);
    if(batch_size == 0) return false;
    
    // Obliczenie deltas dla ostatniej warstwy
    SNeuralLayer &last_layer = m_layers[m_layers_count - 1];
    
    for(int i = 0; i < last_layer.params.output_size; i++) {
        double output = last_layer.activations[i];
        double target = (i < batch_size) ? targets[i] : 0.0;
        
        // Pochodna funkcji straty
        double loss_derivative = CalculateLossDerivative(output, target);
        
        // Pochodna funkcji aktywacji
        double activation_derivative = ActivateDerivative(output, last_layer.params.activation);
        
        // Delta dla ostatniej warstwy
        last_layer.deltas[i] = loss_derivative * activation_derivative;
    }
    
    // Backpropagation przez ukryte warstwy
    for(int layer = m_layers_count - 2; layer >= 0; layer--) {
        SNeuralLayer &current_layer = m_layers[layer];
        SNeuralLayer &next_layer = m_layers[layer + 1];
        
        for(int i = 0; i < current_layer.params.output_size; i++) {
            double delta = 0.0;
            
            // Suma deltas z następnej warstwy
            for(int j = 0; j < next_layer.params.output_size; j++) {
                int off = i * next_layer.params.output_size + j;
                delta += next_layer.deltas[j] * next_layer.weights[off];
            }
            
            // Pochodna funkcji aktywacji
            double activation_derivative = ActivateDerivative(current_layer.activations[i], current_layer.params.activation);
            
            // Delta dla bieżącej warstwy
            current_layer.deltas[i] = delta * activation_derivative;
        }
    }
    
    // Obliczenie gradientów
    for(int layer = 0; layer < m_layers_count; layer++) {
        SNeuralLayer &current_layer = m_layers[layer];
        
        // Gradienty wag
        for(int i = 0; i < current_layer.params.input_size; i++) {
            for(int j = 0; j < current_layer.params.output_size; j++) {
                double input_value = (layer == 0) ? 0.0 : m_layers[layer - 1].activations[i];
                int off = i * current_layer.params.output_size + j;
                current_layer.gradients[off] = current_layer.deltas[j] * input_value;
            }
        }
        
        // Gradienty bias
        for(int j = 0; j < current_layer.params.output_size; j++) {
            current_layer.bias_gradients[j] = current_layer.deltas[j];
        }
    }
    
    return true;
}

// Aktualizacja wag
bool CNeuralNetwork::UpdateWeights() {
    for(int layer = 0; layer < m_layers_count; layer++) {
        switch(m_params.optimizer) {
            case OPTIMIZER_SGD:
                if(!ApplySGD(layer)) return false;
                break;
            case OPTIMIZER_ADAM:
                if(!ApplyAdam(layer)) return false;
                break;
            case OPTIMIZER_RMS_PROP:
                if(!ApplyRMSprop(layer)) return false;
                break;
            case OPTIMIZER_ADAGRAD:
                if(!ApplyAdagrad(layer)) return false;
                break;
            case OPTIMIZER_ADADELTA:
                if(!ApplyAdadelta(layer)) return false;
                break;
            case OPTIMIZER_NADAM:
                if(!ApplyNadam(layer)) return false;
                break;
            case OPTIMIZER_AMSGRAD:
                if(!ApplyAMSGrad(layer)) return false;
                break;
            case OPTIMIZER_ADAMW:
                if(!ApplyAdamW(layer)) return false;
                break;
            default:
                if(!ApplySGD(layer)) return false;
                break;
        }
    }
    
    return true;
}

// Implementacja optymalizatorów
bool CNeuralNetwork::ApplySGD(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double learning_rate = layer.params.learning_rate;
    double momentum = layer.params.momentum;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            int off = i * layer.params.output_size + j;
            double gradient = layer.gradients[off];
            double momentum_update = momentum * layer.momentum_weights[off];
            double weight_update = -learning_rate * gradient + momentum_update;
            
            layer.weights[off] += weight_update;
            layer.momentum_weights[off] = weight_update;
        }
    }
    
    // Aktualizacja bias
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        double momentum_update = momentum * layer.momentum_bias[j];
        double bias_update = -learning_rate * gradient + momentum_update;
        
        layer.bias[j] += bias_update;
        layer.momentum_bias[j] = bias_update;
    }
    
    return true;
}

bool CNeuralNetwork::ApplyAdam(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double learning_rate = layer.params.learning_rate;
    double beta1 = layer.params.beta1;
    double beta2 = layer.params.beta2;
    double epsilon = layer.params.epsilon;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            int off = i * layer.params.output_size + j;
            double gradient = layer.gradients[off];
            
            // Aktualizacja momentum (bias-corrected first moment)
            layer.momentum_weights[off] = beta1 * layer.momentum_weights[off] + (1.0 - beta1) * gradient;
            
            // Aktualizacja velocity (bias-corrected second moment)
            layer.velocity_weights[off] = beta2 * layer.velocity_weights[off] + (1.0 - beta2) * gradient * gradient;
            
            // Bias correction
            double m_hat = layer.momentum_weights[off] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
            double v_hat = layer.velocity_weights[off] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
            
            // Aktualizacja wagi
            layer.weights[off] -= learning_rate * m_hat / (MathSqrt(v_hat) + epsilon);
        }
    }
    
    // Aktualizacja bias
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        
        // Aktualizacja momentum
        layer.momentum_bias[j] = beta1 * layer.momentum_bias[j] + (1.0 - beta1) * gradient;
        
        // Aktualizacja velocity
        layer.velocity_bias[j] = beta2 * layer.velocity_bias[j] + (1.0 - beta2) * gradient * gradient;
        
        // Bias correction
        double m_hat = layer.momentum_bias[j] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
        double v_hat = layer.velocity_bias[j] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
        
        // Aktualizacja bias
        layer.bias[j] -= learning_rate * m_hat / (MathSqrt(v_hat) + epsilon);
    }
    
    return true;
}

bool CNeuralNetwork::ApplyRMSprop(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double learning_rate = layer.params.learning_rate;
    double decay = layer.params.decay;
    double epsilon = layer.params.epsilon;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            double gradient = layer.gradients[i][j];
            
            // Aktualizacja cache
            layer.cache_weights[i][j] = decay * layer.cache_weights[i][j] + (1.0 - decay) * gradient * gradient;
            
            // Aktualizacja wagi
            layer.weights[i][j] -= learning_rate * gradient / (MathSqrt(layer.cache_weights[i][j]) + epsilon);
        }
    }
    
    // Aktualizacja bias
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        
        // Aktualizacja cache
        layer.cache_bias[j] = decay * layer.cache_bias[j] + (1.0 - decay) * gradient * gradient;
        
        // Aktualizacja bias
        layer.bias[j] -= learning_rate * gradient / (MathSqrt(layer.cache_bias[j]) + epsilon);
    }
    
    return true;
}

bool CNeuralNetwork::ApplyAdagrad(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double learning_rate = layer.params.learning_rate;
    double epsilon = layer.params.epsilon;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            double gradient = layer.gradients[i][j];
            
            // Aktualizacja cache (suma kwadratów gradientów)
            layer.cache_weights[i][j] += gradient * gradient;
            
            // Aktualizacja wagi
            layer.weights[i][j] -= learning_rate * gradient / (MathSqrt(layer.cache_weights[i][j]) + epsilon);
        }
    }
    
    // Aktualizacja bias
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        
        // Aktualizacja cache
        layer.cache_bias[j] += gradient * gradient;
        
        // Aktualizacja bias
        layer.bias[j] -= learning_rate * gradient / (MathSqrt(layer.cache_bias[j]) + epsilon);
    }
    
    return true;
}

bool CNeuralNetwork::ApplyAdadelta(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double rho = 0.95; // Decay rate
    double epsilon = layer.params.epsilon;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            double gradient = layer.gradients[i][j];
            
            // Aktualizacja cache gradientów
            layer.cache_weights[i][j] = rho * layer.cache_weights[i][j] + (1.0 - rho) * gradient * gradient;
            
            // Obliczenie RMS
            double rms_grad = MathSqrt(layer.cache_weights[i][j] + epsilon);
            
            // Aktualizacja cache deltas (jeśli nie istnieje, użyj domyślnej wartości)
            if(layer.velocity_weights[i][j] == 0.0) {
                layer.velocity_weights[i][j] = 1e-8;
            }
            layer.velocity_weights[i][j] = rho * layer.velocity_weights[i][j] + (1.0 - rho) * layer.velocity_weights[i][j] * layer.velocity_weights[i][j];
            
            double rms_delta = MathSqrt(layer.velocity_weights[i][j] + epsilon);
            
            // Aktualizacja wagi
            double delta = -rms_delta / rms_grad * gradient;
            layer.weights[i][j] += delta;
            layer.velocity_weights[i][j] = delta * delta;
        }
    }
    
    // Aktualizacja bias
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        
        // Aktualizacja cache gradientów
        layer.cache_bias[j] = rho * layer.cache_bias[j] + (1.0 - rho) * gradient * gradient;
        
        // Obliczenie RMS
        double rms_grad = MathSqrt(layer.cache_bias[j] + epsilon);
        
        // Aktualizacja cache deltas
        if(layer.velocity_bias[j] == 0.0) {
            layer.velocity_bias[j] = 1e-8;
        }
        layer.velocity_bias[j] = rho * layer.velocity_bias[j] + (1.0 - rho) * layer.velocity_bias[j] * layer.velocity_bias[j];
        
        double rms_delta = MathSqrt(layer.velocity_bias[j] + epsilon);
        
        // Aktualizacja bias
        double delta = -rms_delta / rms_grad * gradient;
        layer.bias[j] += delta;
        layer.velocity_bias[j] = delta * delta;
    }
    
    return true;
}

bool CNeuralNetwork::ApplyNadam(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double learning_rate = layer.params.learning_rate;
    double beta1 = layer.params.beta1;
    double beta2 = layer.params.beta2;
    double epsilon = layer.params.epsilon;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            double gradient = layer.gradients[i][j];
            
            // Aktualizacja momentum
            layer.momentum_weights[i][j] = beta1 * layer.momentum_weights[i][j] + (1.0 - beta1) * gradient;
            
            // Aktualizacja velocity
            layer.velocity_weights[i][j] = beta2 * layer.velocity_weights[i][j] + (1.0 - beta2) * gradient * gradient;
            
            // Bias correction
            double m_hat = layer.momentum_weights[i][j] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
            double v_hat = layer.velocity_weights[i][j] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
            
            // Nadam correction
            double nadam_correction = beta1 * m_hat / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
            
            // Aktualizacja wagi
            layer.weights[i][j] -= learning_rate * (nadam_correction + (1.0 - beta1) * gradient / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1))) / (MathSqrt(v_hat) + epsilon);
        }
    }
    
    // Aktualizacja bias
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        
        // Aktualizacja momentum
        layer.momentum_bias[j] = beta1 * layer.momentum_bias[j] + (1.0 - beta1) * gradient;
        
        // Aktualizacja velocity
        layer.velocity_bias[j] = beta2 * layer.velocity_bias[j] + (1.0 - beta2) * gradient * gradient;
        
        // Bias correction
        double m_hat = layer.momentum_bias[j] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
        double v_hat = layer.velocity_bias[j] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
        
        // Nadam correction
        double nadam_correction = beta1 * m_hat / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
        
        // Aktualizacja bias
        layer.bias[j] -= learning_rate * (nadam_correction + (1.0 - beta1) * gradient / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1))) / (MathSqrt(v_hat) + epsilon);
    }
    
    return true;
}

bool CNeuralNetwork::ApplyAMSGrad(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double learning_rate = layer.params.learning_rate;
    double beta1 = layer.params.beta1;
    double beta2 = layer.params.beta2;
    double epsilon = layer.params.epsilon;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            double gradient = layer.gradients[i][j];
            
            // Aktualizacja momentum
            layer.momentum_weights[i][j] = beta1 * layer.momentum_weights[i][j] + (1.0 - beta1) * gradient;
            
            // Aktualizacja velocity
            layer.velocity_weights[i][j] = beta2 * layer.velocity_weights[i][j] + (1.0 - beta2) * gradient * gradient;
            
            // Bias correction
            double m_hat = layer.momentum_weights[i][j] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
            double v_hat = layer.velocity_weights[i][j] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
            
            // AMSGrad correction - użyj maksimum z poprzednich v_hat
            if(layer.cache_weights[i][j] < v_hat) {
                layer.cache_weights[i][j] = v_hat;
            }
            
            // Aktualizacja wagi
            layer.weights[i][j] -= learning_rate * m_hat / (MathSqrt(layer.cache_weights[i][j]) + epsilon);
        }
    }
    
    // Aktualizacja bias
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        
        // Aktualizacja momentum
        layer.momentum_bias[j] = beta1 * layer.momentum_bias[j] + (1.0 - beta1) * gradient;
        
        // Aktualizacja velocity
        layer.velocity_bias[j] = beta2 * layer.velocity_bias[j] + (1.0 - beta2) * gradient * gradient;
        
        // Bias correction
        double m_hat = layer.momentum_bias[j] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
        double v_hat = layer.velocity_bias[j] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
        
        // AMSGrad correction
        if(layer.cache_bias[j] < v_hat) {
            layer.cache_bias[j] = v_hat;
        }
        
        // Aktualizacja bias
        layer.bias[j] -= learning_rate * m_hat / (MathSqrt(layer.cache_bias[j]) + epsilon);
    }
    
    return true;
}

bool CNeuralNetwork::ApplyAdamW(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return false;
    
    SNeuralLayer &layer = m_layers[layer_index];
    double learning_rate = layer.params.learning_rate;
    double beta1 = layer.params.beta1;
    double beta2 = layer.params.beta2;
    double epsilon = layer.params.epsilon;
    double weight_decay = m_params.weight_decay;
    
    // Aktualizacja wag
    for(int i = 0; i < layer.params.input_size; i++) {
        for(int j = 0; j < layer.params.output_size; j++) {
            double gradient = layer.gradients[i][j];
            
            // Dodaj weight decay do gradientu
            gradient += weight_decay * layer.weights[i][j];
            
            // Aktualizacja momentum
            layer.momentum_weights[i][j] = beta1 * layer.momentum_weights[i][j] + (1.0 - beta1) * gradient;
            
            // Aktualizacja velocity
            layer.velocity_weights[i][j] = beta2 * layer.velocity_weights[i][j] + (1.0 - beta2) * gradient * gradient;
            
            // Bias correction
            double m_hat = layer.momentum_weights[i][j] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
            double v_hat = layer.velocity_weights[i][j] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
            
            // Aktualizacja wagi (z weight decay)
            layer.weights[i][j] -= learning_rate * (m_hat / (MathSqrt(v_hat) + epsilon) + weight_decay * layer.weights[i][j]);
        }
    }
    
    // Aktualizacja bias (bez weight decay)
    for(int j = 0; j < layer.params.output_size; j++) {
        double gradient = layer.bias_gradients[j];
        
        // Aktualizacja momentum
        layer.momentum_bias[j] = beta1 * layer.momentum_bias[j] + (1.0 - beta1) * gradient;
        
        // Aktualizacja velocity
        layer.velocity_bias[j] = beta2 * layer.velocity_bias[j] + (1.0 - beta2) * gradient * gradient;
        
        // Bias correction
        double m_hat = layer.momentum_bias[j] / (1.0 - MathPow(beta1, m_training_result.epochs_completed + 1));
        double v_hat = layer.velocity_bias[j] / (1.0 - MathPow(beta2, m_training_result.epochs_completed + 1));
        
        // Aktualizacja bias
        layer.bias[j] -= learning_rate * m_hat / (MathSqrt(v_hat) + epsilon);
    }
    
    return true;
}

// Zapisywanie i wczytywanie
bool CNeuralNetwork::SaveModel(string filename) {
    if(m_layers_count == 0) {
        LogError(LOG_COMPONENT_AI, "Nie można zapisać modelu - architektura sieci jest pusta", "Zbuduj architekturę sieci przed zapisem");
        return false;
    }
    
    // Tworzenie pliku
    int file_handle = FileOpen(filename, FILE_WRITE | FILE_ANSI);
    if(file_handle == INVALID_HANDLE) {
        LogError(LOG_COMPONENT_AI, "Błąd podczas tworzenia pliku do zapisu modelu", "Nie można otworzyć pliku: " + filename + " Error: " + IntegerToString(GetLastError()));
        return false;
    }
    
    // Zapisanie parametrów sieci
    string params_str = "NeuralNetworkParams\n";
    params_str += "input_size=" + IntegerToString(m_params.input_size) + "\n";
    params_str += "output_size=" + IntegerToString(m_params.output_size) + "\n";
    params_str += "hidden_layers_count=" + IntegerToString(m_params.hidden_layers_count) + "\n";
    for(int i = 0; i < m_params.hidden_layers_count; i++) {
        params_str += "hidden_layer_" + IntegerToString(i) + "=" + IntegerToString(m_params.hidden_layers[i]) + "\n";
    }
    params_str += "hidden_activation=" + IntegerToString(m_params.hidden_activation) + "\n";
    params_str += "output_activation=" + IntegerToString(m_params.output_activation) + "\n";
    params_str += "optimizer=" + IntegerToString(m_params.optimizer) + "\n";
    params_str += "loss_function=" + IntegerToString(m_params.loss_function) + "\n";
    params_str += "learning_rate=" + DoubleToString(m_params.learning_rate, 6) + "\n";
    params_str += "batch_size=" + IntegerToString(m_params.batch_size) + "\n";
    params_str += "epochs=" + IntegerToString(m_params.epochs) + "\n";
    params_str += "validation_split=" + DoubleToString(m_params.validation_split, 2) + "\n";
    params_str += "shuffle_data=" + (m_params.shuffle_data ? "true" : "false") + "\n";
    params_str += "early_stopping=" + (m_params.early_stopping ? "true" : "false") + "\n";
    params_str += "patience=" + IntegerToString(m_params.patience) + "\n";
    params_str += "min_delta=" + DoubleToString(m_params.min_delta, 6) + "\n";
    params_str += "verbose=" + (m_params.verbose ? "true" : "false") + "\n";
    params_str += "random_seed=" + IntegerToString(m_params.random_seed) + "\n";
    params_str += "weight_decay=" + DoubleToString(m_params.weight_decay, 6) + "\n";
    params_str += "gradient_clip=" + DoubleToString(m_params.gradient_clip, 6) + "\n";
    params_str += "use_batch_norm=" + (m_params.use_batch_norm ? "true" : "false") + "\n";
    params_str += "batch_norm_momentum=" + DoubleToString(m_params.batch_norm_momentum, 6) + "\n";
    params_str += "use_dropout=" + (m_params.use_dropout ? "true" : "false") + "\n";
    params_str += "dropout_rate=" + DoubleToString(m_params.dropout_rate, 2) + "\n";
    params_str += "model_name=" + m_params.model_name + "\n";
    params_str += "creation_time=" + TimeToString(m_params.creation_time) + "\n";
    
    FileWriteString(file_handle, params_str);
    
    // Zapisanie warstw
    for(int i = 0; i < m_layers_count; i++) {
        string layer_str = "Layer_" + IntegerToString(i) + "\n";
        layer_str += "layer_type=" + IntegerToString(m_layers[i].params.layer_type) + "\n";
        layer_str += "input_size=" + IntegerToString(m_layers[i].params.input_size) + "\n";
        layer_str += "output_size=" + IntegerToString(m_layers[i].params.output_size) + "\n";
        layer_str += "activation=" + IntegerToString(m_layers[i].params.activation) + "\n";
        layer_str += "dropout_rate=" + DoubleToString(m_layers[i].params.dropout_rate, 2) + "\n";
        layer_str += "use_bias=" + (m_layers[i].params.use_bias ? "true" : "false") + "\n";
        layer_str += "weight_init=" + IntegerToString(m_layers[i].params.weight_init) + "\n";
        layer_str += "learning_rate=" + DoubleToString(m_layers[i].params.learning_rate, 6) + "\n";
        layer_str += "momentum=" + DoubleToString(m_layers[i].params.momentum, 6) + "\n";
        layer_str += "epsilon=" + DoubleToString(m_layers[i].params.epsilon, 6) + "\n";
        layer_str += "beta1=" + DoubleToString(m_layers[i].params.beta1, 6) + "\n";
        layer_str += "beta2=" + DoubleToString(m_layers[i].params.beta2, 6) + "\n";
        layer_str += "decay=" + DoubleToString(m_layers[i].params.decay, 6) + "\n";
        layer_str += "clip_norm=" + DoubleToString(m_layers[i].params.clip_norm, 6) + "\n";
        layer_str += "trainable=" + (m_layers[i].params.trainable ? "true" : "false") + "\n";
        layer_str += "name=" + m_layers[i].params.name + "\n";
        
        FileWriteString(file_handle, layer_str);
        
        // Zapisanie wag
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].weights[k][j]);
            }
        }
        
        // Zapisanie bias
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].bias[j]);
        }
        
        // Zapisanie gradientów wag
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].gradients[k][j]);
            }
        }
        
        // Zapisanie gradientów bias
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].bias_gradients[j]);
        }
        
        // Zapisanie aktywacji
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].activations[j]);
        }
        
        // Zapisanie deltas
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].deltas[j]);
        }
        
        // Zapisanie momentum dla wag
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].momentum_weights[k][j]);
            }
        }
        
        // Zapisanie momentum dla bias
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].momentum_bias[j]);
        }
        
        // Zapisanie velocity dla wag
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].velocity_weights[k][j]);
            }
        }
        
        // Zapisanie velocity dla bias
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].velocity_bias[j]);
        }
        
        // Zapisanie cache dla RMSprop
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].cache_weights[k][j]);
            }
        }
        
        // Zapisanie cache dla bias
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].cache_bias[j]);
        }
    }
    
    FileClose(file_handle);
    return true;
}

bool CNeuralNetwork::LoadModel(string filename) {
    if(m_layers_count > 0) {
        ClearModel(); // Usuń istniejące warstwy przed załadowaniem nowych
    }
    
    int file_handle = FileOpen(filename, FILE_READ | FILE_ANSI);
    if(file_handle == INVALID_HANDLE) {
        LogError(LOG_COMPONENT_AI, "Błąd podczas otwierania pliku do wczytania modelu", "Nie można otworzyć pliku: " + filename + " Error: " + IntegerToString(GetLastError()));
        return false;
    }
    
    string line;
    while(!FileIsEnding(file_handle)) {
        line = FileReadString(file_handle);
        if(line == "NeuralNetworkParams") {
            m_params.input_size = StringToInteger(FileReadString(file_handle));
            m_params.output_size = StringToInteger(FileReadString(file_handle));
            m_params.hidden_layers_count = StringToInteger(FileReadString(file_handle));
            for(int i = 0; i < m_params.hidden_layers_count; i++) {
                m_params.hidden_layers[i] = StringToInteger(FileReadString(file_handle));
            }
            m_params.hidden_activation = (ENUM_ACTIVATION_FUNCTION)StringToInteger(FileReadString(file_handle));
            m_params.output_activation = (ENUM_ACTIVATION_FUNCTION)StringToInteger(FileReadString(file_handle));
            m_params.optimizer = (ENUM_OPTIMIZER)StringToInteger(FileReadString(file_handle));
            m_params.loss_function = (ENUM_LOSS_FUNCTION)StringToInteger(FileReadString(file_handle));
            m_params.learning_rate = StringToDouble(FileReadString(file_handle));
            m_params.batch_size = StringToInteger(FileReadString(file_handle));
            m_params.epochs = StringToInteger(FileReadString(file_handle));
            m_params.validation_split = StringToDouble(FileReadString(file_handle));
            m_params.shuffle_data = StringToBool(FileReadString(file_handle));
            m_params.early_stopping = StringToBool(FileReadString(file_handle));
            m_params.patience = StringToInteger(FileReadString(file_handle));
            m_params.min_delta = StringToDouble(FileReadString(file_handle));
            m_params.verbose = StringToBool(FileReadString(file_handle));
            m_params.random_seed = StringToInteger(FileReadString(file_handle));
            m_params.weight_decay = StringToDouble(FileReadString(file_handle));
            m_params.gradient_clip = StringToDouble(FileReadString(file_handle));
            m_params.use_batch_norm = StringToBool(FileReadString(file_handle));
            m_params.batch_norm_momentum = StringToDouble(FileReadString(file_handle));
            m_params.use_dropout = StringToBool(FileReadString(file_handle));
            m_params.dropout_rate = StringToDouble(FileReadString(file_handle));
            m_params.model_name = FileReadString(file_handle);
            m_params.creation_time = StringToTime(FileReadString(file_handle));
        } else if(line == "Layer_") {
            SNeuralLayerParams layer_params;
            layer_params.layer_type = StringToENUM(FileReadString(file_handle));
            layer_params.input_size = StringToInteger(FileReadString(file_handle));
            layer_params.output_size = StringToInteger(FileReadString(file_handle));
            layer_params.activation = StringToENUM(FileReadString(file_handle));
            layer_params.dropout_rate = StringToDouble(FileReadString(file_handle));
            layer_params.use_bias = StringToBool(FileReadString(file_handle));
            layer_params.weight_init = StringToENUM(FileReadString(file_handle));
            layer_params.learning_rate = StringToDouble(FileReadString(file_handle));
            layer_params.momentum = StringToDouble(FileReadString(file_handle));
            layer_params.epsilon = StringToDouble(FileReadString(file_handle));
            layer_params.beta1 = StringToDouble(FileReadString(file_handle));
            layer_params.beta2 = StringToDouble(FileReadString(file_handle));
            layer_params.decay = StringToDouble(FileReadString(file_handle));
            layer_params.clip_norm = StringToDouble(FileReadString(file_handle));
            layer_params.trainable = StringToBool(FileReadString(file_handle));
            layer_params.name = FileReadString(file_handle);
            
            AddLayer(layer_params); // Dodaj warstwę do sieci
            
            // Wczytaj wagę
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            // Wczytaj bias
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].bias[j] = FileReadDouble(file_handle);
            }
            
            // Wczytaj gradienty wag
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].gradients[k][j] = FileReadDouble(file_handle);
                }
            }
            
            // Wczytaj gradienty bias
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].bias_gradients[j] = FileReadDouble(file_handle);
            }
            
            // Wczytaj aktywacje
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].activations[j] = FileReadDouble(file_handle);
            }
            
            // Wczytaj delty
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].deltas[j] = FileReadDouble(file_handle);
            }
            
            // Wczytaj momentum dla wag
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].momentum_weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            // Wczytaj momentum dla bias
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].momentum_bias[j] = FileReadDouble(file_handle);
            }
            
            // Wczytaj velocity dla wag
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].velocity_weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            // Wczytaj velocity dla bias
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].velocity_bias[j] = FileReadDouble(file_handle);
            }
            
            // Wczytaj cache dla RMSprop
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].cache_weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            // Wczytaj cache dla bias
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].cache_bias[j] = FileReadDouble(file_handle);
            }
        }
    }
    
    FileClose(file_handle);
    
    // Inicjalizacja wszystkich warstw po załadowaniu
    for(int i = 0; i < m_layers_count; i++) {
        if(!InitializeWeights(i)) return false;
    }
    
    return true;
}

bool CNeuralNetwork::ExportModel(string filename) {
    if(m_layers_count == 0) {
        LogError(LOG_COMPONENT_AI, "Nie można eksportować modelu - architektura sieci jest pusta", "Zbuduj architekturę sieci przed eksportem");
        return false;
    }
    
    int file_handle = FileOpen(filename, FILE_WRITE | FILE_ANSI);
    if(file_handle == INVALID_HANDLE) {
        LogError(LOG_COMPONENT_AI, "Błąd podczas tworzenia pliku do eksportu modelu", "Nie można otworzyć pliku: " + filename + " Error: " + IntegerToString(GetLastError()));
        return false;
    }
    
    string header = "NeuralNetworkModel\n";
    header += "Version=" + NEURAL_NETWORK_VERSION + "\n";
    header += "Author=" + NEURAL_NETWORK_AUTHOR + "\n";
    header += "Description=" + NEURAL_NETWORK_DESCRIPTION + "\n";
    header += "Layers=" + IntegerToString(m_layers_count) + "\n";
    
    FileWriteString(file_handle, header);
    
    for(int i = 0; i < m_layers_count; i++) {
        string layer_str = "Layer_" + IntegerToString(i) + "\n";
        layer_str += "Type=" + IntegerToString(m_layers[i].params.layer_type) + "\n";
        layer_str += "InputSize=" + IntegerToString(m_layers[i].params.input_size) + "\n";
        layer_str += "OutputSize=" + IntegerToString(m_layers[i].params.output_size) + "\n";
        layer_str += "Activation=" + IntegerToString(m_layers[i].params.activation) + "\n";
        layer_str += "DropoutRate=" + DoubleToString(m_layers[i].params.dropout_rate, 2) + "\n";
        layer_str += "UseBias=" + (m_layers[i].params.use_bias ? "true" : "false") + "\n";
        layer_str += "WeightInit=" + IntegerToString(m_layers[i].params.weight_init) + "\n";
        layer_str += "LearningRate=" + DoubleToString(m_layers[i].params.learning_rate, 6) + "\n";
        layer_str += "Momentum=" + DoubleToString(m_layers[i].params.momentum, 6) + "\n";
        layer_str += "Epsilon=" + DoubleToString(m_layers[i].params.epsilon, 6) + "\n";
        layer_str += "Beta1=" + DoubleToString(m_layers[i].params.beta1, 6) + "\n";
        layer_str += "Beta2=" + DoubleToString(m_layers[i].params.beta2, 6) + "\n";
        layer_str += "Decay=" + DoubleToString(m_layers[i].params.decay, 6) + "\n";
        layer_str += "ClipNorm=" + DoubleToString(m_layers[i].params.clip_norm, 6) + "\n";
        layer_str += "Trainable=" + (m_layers[i].params.trainable ? "true" : "false") + "\n";
        layer_str += "Name=" + m_layers[i].params.name + "\n";
        
        FileWriteString(file_handle, layer_str);
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].weights[k][j]);
            }
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].bias[j]);
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].gradients[k][j]);
            }
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].bias_gradients[j]);
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].activations[j]);
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].deltas[j]);
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].momentum_weights[k][j]);
            }
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].momentum_bias[j]);
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].velocity_weights[k][j]);
            }
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].velocity_bias[j]);
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            for(int k = 0; k < m_layers[i].params.input_size; k++) {
                FileWriteDouble(file_handle, m_layers[i].cache_weights[k][j]);
            }
        }
        
        for(int j = 0; j < m_layers[i].params.output_size; j++) {
            FileWriteDouble(file_handle, m_layers[i].cache_bias[j]);
        }
    }
    
    FileClose(file_handle);
    return true;
}

bool CNeuralNetwork::ImportModel(string filename) {
    if(m_layers_count > 0) {
        ClearModel(); // Usuń istniejące warstwy przed załadowaniem nowych
    }
    
    int file_handle = FileOpen(filename, FILE_READ | FILE_ANSI);
    if(file_handle == INVALID_HANDLE) {
        LogError(LOG_COMPONENT_AI, "Błąd podczas otwierania pliku do importu modelu", "Nie można otworzyć pliku: " + filename + " Error: " + IntegerToString(GetLastError()));
        return false;
    }
    
    string header = FileReadString(file_handle);
    if(header != "NeuralNetworkModel") {
        LogError(LOG_COMPONENT_AI, "Nieprawidłowy nagłówek pliku modelu", "Oczekiwano: NeuralNetworkModel, otrzymano: " + header);
        FileClose(file_handle);
        return false;
    }
    
    string version = FileReadString(file_handle);
    if(version != NEURAL_NETWORK_VERSION) {
        LogWarning(LOG_COMPONENT_AI, "Różna wersja modelu", "Oczekiwano: " + NEURAL_NETWORK_VERSION + ", otrzymano: " + version);
    }
    
    string author = FileReadString(file_handle);
    if(author != NEURAL_NETWORK_AUTHOR) {
        LogWarning(LOG_COMPONENT_AI, "Różny autor modelu", "Oczekiwano: " + NEURAL_NETWORK_AUTHOR + ", otrzymano: " + author);
    }
    
    string description = FileReadString(file_handle);
    if(description != NEURAL_NETWORK_DESCRIPTION) {
        LogWarning(LOG_COMPONENT_AI, "Różne opisy modelu", "Oczekiwano: " + NEURAL_NETWORK_DESCRIPTION + ", otrzymano: " + description);
    }
    
    int layers_count = StringToInteger(FileReadString(file_handle));
    if(layers_count != m_layers_count) {
        LogWarning(LOG_COMPONENT_AI, "Różna liczba warstw w modelu", "Oczekiwano: " + IntegerToString(m_layers_count) + ", otrzymano: " + IntegerToString(layers_count));
    }
    
    for(int i = 0; i < layers_count; i++) {
        string layer_str = FileReadString(file_handle);
        if(layer_str == "Layer_") {
            SNeuralLayerParams layer_params;
            layer_params.layer_type = StringToENUM(FileReadString(file_handle));
            layer_params.input_size = StringToInteger(FileReadString(file_handle));
            layer_params.output_size = StringToInteger(FileReadString(file_handle));
            layer_params.activation = StringToENUM(FileReadString(file_handle));
            layer_params.dropout_rate = StringToDouble(FileReadString(file_handle));
            layer_params.use_bias = StringToBool(FileReadString(file_handle));
            layer_params.weight_init = StringToENUM(FileReadString(file_handle));
            layer_params.learning_rate = StringToDouble(FileReadString(file_handle));
            layer_params.momentum = StringToDouble(FileReadString(file_handle));
            layer_params.epsilon = StringToDouble(FileReadString(file_handle));
            layer_params.beta1 = StringToDouble(FileReadString(file_handle));
            layer_params.beta2 = StringToDouble(FileReadString(file_handle));
            layer_params.decay = StringToDouble(FileReadString(file_handle));
            layer_params.clip_norm = StringToDouble(FileReadString(file_handle));
            layer_params.trainable = StringToBool(FileReadString(file_handle));
            layer_params.name = FileReadString(file_handle);
            
            AddLayer(layer_params); // Dodaj warstwę do sieci
            
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].bias[j] = FileReadDouble(file_handle);
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].gradients[k][j] = FileReadDouble(file_handle);
                }
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].bias_gradients[j] = FileReadDouble(file_handle);
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].activations[j] = FileReadDouble(file_handle);
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].deltas[j] = FileReadDouble(file_handle);
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].momentum_weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].momentum_bias[j] = FileReadDouble(file_handle);
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].velocity_weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].velocity_bias[j] = FileReadDouble(file_handle);
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                for(int k = 0; k < layer_params.input_size; k++) {
                    m_layers[m_layers_count - 1].cache_weights[k][j] = FileReadDouble(file_handle);
                }
            }
            
            for(int j = 0; j < layer_params.output_size; j++) {
                m_layers[m_layers_count - 1].cache_bias[j] = FileReadDouble(file_handle);
            }
        }
    }
    
    FileClose(file_handle);
    
    // Inicjalizacja wszystkich warstw po załadowaniu
    for(int i = 0; i < m_layers_count; i++) {
        if(!InitializeWeights(i)) return false;
    }
    
    return true;
}

// Analiza modelu
double CNeuralNetwork::GetLayerOutput(int layer_index, int neuron_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return 0.0;
    if(neuron_index < 0 || neuron_index >= m_layers[layer_index].params.output_size) return 0.0;
    
    return m_layers[layer_index].activations[neuron_index];
}

double CNeuralNetwork::GetWeight(int layer_index, int from_neuron, int to_neuron) {
    if(layer_index < 0 || layer_index >= m_layers_count) return 0.0;
    if(from_neuron < 0 || from_neuron >= m_layers[layer_index].params.input_size) return 0.0;
    if(to_neuron < 0 || to_neuron >= m_layers[layer_index].params.output_size) return 0.0;
    
    return m_layers[layer_index].weights[from_neuron][to_neuron];
}

double CNeuralNetwork::GetBias(int layer_index, int neuron_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) return 0.0;
    if(neuron_index < 0 || neuron_index >= m_layers[layer_index].params.output_size) return 0.0;
    
    return m_layers[layer_index].bias[neuron_index];
}

double CNeuralNetwork::GetGradient(int layer_index, int from_neuron, int to_neuron) {
    if(layer_index < 0 || layer_index >= m_layers_count) return 0.0;
    if(from_neuron < 0 || from_neuron >= m_layers[layer_index].params.input_size) return 0.0;
    if(to_neuron < 0 || to_neuron >= m_layers[layer_index].params.output_size) return 0.0;
    
    return m_layers[layer_index].gradients[from_neuron][to_neuron];
}

string CNeuralNetwork::GetModelSummary() {
    string summary = "=== PODSUMOWANIE SIECI NEURONOWEJ ===\n";
    summary += "Nazwa: " + m_params.model_name + "\n";
    summary += "Liczba warstw: " + IntegerToString(m_layers_count) + "\n";
    summary += "Parametry: " + IntegerToString(GetTotalParameters()) + "\n";
    summary += "Rozmiar wejścia: " + IntegerToString(m_params.input_size) + "\n";
    summary += "Rozmiar wyjścia: " + IntegerToString(m_params.output_size) + "\n";
    summary += "Optymalizator: " + IntegerToString(m_params.optimizer) + "\n";
    summary += "Funkcja straty: " + IntegerToString(m_params.loss_function) + "\n";
    summary += "Szybkość uczenia: " + DoubleToString(m_params.learning_rate, 6) + "\n";
    summary += "Czy wytrenowany: " + (IsModelTrained() ? "TAK" : "NIE") + "\n";
    summary += "Czy dane załadowane: " + (IsDataLoaded() ? "TAK" : "NIE") + "\n";
    summary += "Łączne predykcje: " + IntegerToString(GetTotalPredictions()) + "\n";
    summary += "Średni czas predykcji: " + FormatTime(GetAveragePredictionTime()) + "\n";
    summary += "Czas treningu: " + FormatTime(GetTrainingTime()) + "\n";
    
    return summary;
}

string CNeuralNetwork::GetTrainingReport() {
    string report = "=== RAPORT TRENINGU SIECI NEURONOWEJ ===\n";
    report += "Nazwa modelu: " + m_params.model_name + "\n";
    report += "Czas utworzenia: " + TimeToString(m_params.creation_time) + "\n";
    report += "Liczba epok: " + IntegerToString(m_params.epochs) + "\n";
    report += "Rozmiar batch: " + IntegerToString(m_params.batch_size) + "\n";
    report += "Split walidacji: " + DoubleToString(m_params.validation_split, 2) + "\n";
    report += "Czy mieszać dane: " + (m_params.shuffle_data ? "TAK" : "NIE") + "\n";
    report += "Czy używać early stopping: " + (m_params.early_stopping ? "TAK" : "NIE") + "\n";
    report += "Cierpliwość early stopping: " + IntegerToString(m_params.patience) + "\n";
    report += "Minimalna zmiana dla early stopping: " + DoubleToString(m_params.min_delta, 6) + "\n";
    report += "Czy wyświetlać postęp: " + (m_params.verbose ? "TAK" : "NIE") + "\n";
    report += "Ziarno losowości: " + IntegerToString(m_params.random_seed) + "\n";
    report += "Decay wag: " + DoubleToString(m_params.weight_decay, 6) + "\n";
    report += "Gradient clipping: " + DoubleToString(m_params.gradient_clip, 6) + "\n";
    report += "Czy używać batch normalization: " + (m_params.use_batch_norm ? "TAK" : "NIE") + "\n";
    report += "Momentum dla batch norm: " + DoubleToString(m_params.batch_norm_momentum, 6) + "\n";
    report += "Czy używać dropout: " + (m_params.use_dropout ? "TAK" : "NIE") + "\n";
    report += "Współczynnik dropout: " + DoubleToString(m_params.dropout_rate, 2) + "\n";
    
    report += "Najlepsza strata: " + DoubleToString(m_training_result.best_loss, 6) + "\n";
    report += "Najlepsza dokładność: " + DoubleToString(m_training_result.best_accuracy, 4) + "\n";
    report += "Czas treningu: " + FormatTime(m_total_training_time) + "\n";
    report += "Czas zbieżności: " + FormatTime(m_training_result.convergence_time) + "\n";
    
    if(m_training_result.early_stopped) {
        report += "Trening przerwany z powodu early stopping.\n";
    }
    
    report += "=== WYNIKI TRENINGU ===\n";
    report += "Epoki ukończone: " + IntegerToString(m_training_result.epochs_completed) + "\n";
    report += "Końcowa strata: " + DoubleToString(m_training_result.final_loss, 6) + "\n";
    report += "Końcowa dokładność: " + DoubleToString(m_training_result.final_accuracy, 4) + "\n";
    
    if(m_training_result.overfitting_detected) {
        report += "Wykryto overfitting (skala: " + DoubleToString(m_training_result.overfitting_score, 4) + ")\n";
    }
    
    report += "=== KRZYWE TRENINGU ===\n";
    report += "Strata treningowa: " + DoubleToString(m_training_result.training_loss, 6) + "\n";
    report += "Strata walidacyjna: " + DoubleToString(m_training_result.validation_loss, 6) + "\n";
    report += "Dokładność treningowa: " + DoubleToString(m_training_result.training_accuracy, 4) + "\n";
    report += "Dokładność walidacyjna: " + DoubleToString(m_training_result.validation_accuracy, 4) + "\n";
    
    return report;
}

string CNeuralNetwork::GetLayerReport(int layer_index) {
    if(layer_index < 0 || layer_index >= m_layers_count) {
        return "BŁĄD: Nieprawidłowy indeks warstwy";
    }
    
    string report = "=== RAPORT WARSTWY " + IntegerToString(layer_index) + " ===\n";
    report += "Typ warstwy: " + IntegerToString(m_layers[layer_index].params.layer_type) + "\n";
    report += "Rozmiar wejścia: " + IntegerToString(m_layers[layer_index].params.input_size) + "\n";
    report += "Rozmiar wyjścia: " + IntegerToString(m_layers[layer_index].params.output_size) + "\n";
    report += "Funkcja aktywacji: " + IntegerToString(m_layers[layer_index].params.activation_function) + "\n";
    report += "Liczba neuronów: " + IntegerToString(m_layers[layer_index].params.output_size) + "\n";
    report += "Liczba wag: " + IntegerToString(m_layers[layer_index].params.input_size * m_layers[layer_index].params.output_size) + "\n";
    report += "Liczba biasów: " + IntegerToString(m_layers[layer_index].params.output_size) + "\n";
    
    // Statystyki wag
    double min_weight = 0.0, max_weight = 0.0, avg_weight = 0.0;
    double min_bias = 0.0, max_bias = 0.0, avg_bias = 0.0;
    
    if(m_layers[layer_index].params.input_size > 0 && m_layers[layer_index].params.output_size > 0) {
        min_weight = max_weight = m_layers[layer_index].weights[0][0];
        min_bias = max_bias = m_layers[layer_index].bias[0];
        
        for(int i = 0; i < m_layers[layer_index].params.input_size; i++) {
            for(int j = 0; j < m_layers[layer_index].params.output_size; j++) {
                double weight = m_layers[layer_index].weights[i][j];
                if(weight < min_weight) min_weight = weight;
                if(weight > max_weight) max_weight = weight;
                avg_weight += weight;
            }
        }
        
        for(int j = 0; j < m_layers[layer_index].params.output_size; j++) {
            double bias = m_layers[layer_index].bias[j];
            if(bias < min_bias) min_bias = bias;
            if(bias > max_bias) max_bias = bias;
            avg_bias += bias;
        }
        
        int total_weights = m_layers[layer_index].params.input_size * m_layers[layer_index].params.output_size;
        avg_weight /= total_weights;
        avg_bias /= m_layers[layer_index].params.output_size;
    }
    
    report += "=== STATYSTYKI WAG ===\n";
    report += "Min waga: " + DoubleToString(min_weight, 6) + "\n";
    report += "Max waga: " + DoubleToString(max_weight, 6) + "\n";
    report += "Średnia waga: " + DoubleToString(avg_weight, 6) + "\n";
    report += "Min bias: " + DoubleToString(min_bias, 6) + "\n";
    report += "Max bias: " + DoubleToString(max_bias, 6) + "\n";
    report += "Średni bias: " + DoubleToString(avg_bias, 6) + "\n";
    
    return report;
}

// Stałe dla Neural Networks
#define NEURAL_NETWORK_VERSION "1.0.0"
#define NEURAL_NETWORK_AUTHOR "System Böhmego"
#define NEURAL_NETWORK_DESCRIPTION "Zaawansowane sieci neuronowe"

#endif // NEURAL_NETWORKS_H
