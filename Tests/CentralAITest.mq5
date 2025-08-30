//+------------------------------------------------------------------+
//| CentralAITest.mq5 - Test Centralnego Modułu AI                    |
//| Testuje wszystkie funkcjonalności centralnego AI                  |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property link      "https://github.com/bohme-trading"
#property version   "2.0.0"
#property strict

#include "../Core/CentralAI.mqh"

//+------------------------------------------------------------------+
//| Test Input Parameters                                              |
//+------------------------------------------------------------------+
input int TestBars = 100;           // Liczba świec do testu
input int LSTMInputSize = 64;       // Rozmiar wejścia LSTM
input int LSTMHiddenSize = 128;     // Rozmiar ukrytej warstwy LSTM
input int CNNKernelSize = 3;        // Rozmiar jądra CNN
input int CNNOutputFeatures = 32;   // Liczba map cech CNN

//+------------------------------------------------------------------+
//| Expert initialization function                                     |
//+------------------------------------------------------------------+
int OnInit() {
    Print("🧠 Rozpoczęcie testu Centralnego Modułu AI...");
    
    // Test 1: Inicjalizacja modeli AI
    if(!TestAIModelsInitialization()) {
        Print("❌ Test inicjalizacji modeli AI nieudany");
        return INIT_FAILED;
    }
    
    // Test 2: Test LSTM
    if(!TestLSTM()) {
        Print("❌ Test LSTM nieudany");
        return INIT_FAILED;
    }
    
    // Test 3: Test CNN
    if(!TestCNN()) {
        Print("❌ Test CNN nieudany");
        return INIT_FAILED;
    }
    
    // Test 4: Test Attention
    if(!TestAttention()) {
        Print("❌ Test Attention nieudany");
        return INIT_FAILED;
    }
    
    // Test 5: Test Kalman Filter
    if(!TestKalmanFilter()) {
        Print("❌ Test Kalman Filter nieudany");
        return INIT_FAILED;
    }
    
    // Test 6: Test Ensemble
    if(!TestEnsemble()) {
        Print("❌ Test Ensemble nieudany");
        return INIT_FAILED;
    }
    
    // Test 7: Test Central AI Manager
    if(!TestCentralAIManager()) {
        Print("❌ Test Central AI Manager nieudany");
        return INIT_FAILED;
    }
    
    // Test 8: Test funkcji pomocniczych
    if(!TestHelperFunctions()) {
        Print("❌ Test funkcji pomocniczych nieudany");
        return INIT_FAILED;
    }
    
    Print("✅ Wszystkie testy Centralnego AI zakończone pomyślnie!");
    Print("🚀 Centralny Moduł AI jest gotowy do użycia!");
    
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                   |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("🧠 Zakończenie testu Centralnego Modułu AI");
}

//+------------------------------------------------------------------+
//| Expert tick function                                               |
//+------------------------------------------------------------------+
void OnTick() {
    // Test wykonuje się tylko raz w OnInit
}

//+------------------------------------------------------------------+
//| Test 1: Inicjalizacja modeli AI                                   |
//+------------------------------------------------------------------+
bool TestAIModelsInitialization() {
    Print("📋 Test 1: Inicjalizacja modeli AI...");
    
    try {
        // Test LSTM
        CCentralLSTM* lstm = new CCentralLSTM(LSTMInputSize, LSTMHiddenSize, 1, 20);
        if(lstm == NULL) {
            Print("❌ Nie udało się utworzyć LSTM");
            return false;
        }
        
        if(!lstm.Initialize()) {
            Print("❌ Nie udało się zainicjalizować LSTM");
            delete lstm;
            return false;
        }
        
        // Test CNN
        CCentralCNN* cnn = new CCentralCNN(4, CNNKernelSize, CNNOutputFeatures);
        if(cnn == NULL) {
            Print("❌ Nie udało się utworzyć CNN");
            delete lstm;
            return false;
        }
        
        if(!cnn.Initialize()) {
            Print("❌ Nie udało się zainicjalizować CNN");
            delete lstm;
            delete cnn;
            return false;
        }
        
        // Test Attention
        CCentralAttention* attention = new CCentralAttention(64, 8, 20);
        if(attention == NULL) {
            Print("❌ Nie udało się utworzyć Attention");
            delete lstm;
            delete cnn;
            return false;
        }
        
        if(!attention.Initialize()) {
            Print("❌ Nie udało się zainicjalizować Attention");
            delete lstm;
            delete cnn;
            delete attention;
            return false;
        }
        
        // Test Kalman Filter
        CCentralKalmanFilter* kalman = new CCentralKalmanFilter(4, 4);
        if(kalman == NULL) {
            Print("❌ Nie udało się utworzyć Kalman Filter");
            delete lstm;
            delete cnn;
            delete attention;
            return false;
        }
        
        if(!kalman.Initialize()) {
            Print("❌ Nie udało się zainicjalizować Kalman Filter");
            delete lstm;
            delete cnn;
            delete attention;
            delete kalman;
            return false;
        }
        
        // Cleanup
        delete lstm;
        delete cnn;
        delete attention;
        delete kalman;
        
        Print("✅ Test inicjalizacji modeli AI zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu inicjalizacji modeli AI");
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 2: Test LSTM                                                 |
//+------------------------------------------------------------------+
bool TestLSTM() {
    Print("🧠 Test 2: Test LSTM...");
    
    try {
        CCentralLSTM* lstm = new CCentralLSTM(LSTMInputSize, LSTMHiddenSize, 1, 20);
        if(!lstm.Initialize()) {
            delete lstm;
            return false;
        }
        
        // Przygotuj dane treningowe
        double training_data[][];
        double targets[];
        
        if(!PrepareLSTMTestData(training_data, targets)) {
            delete lstm;
            return false;
        }
        
        // Test treningu
        Print("📊 Rozpoczęcie treningu LSTM...");
        if(!lstm.Train(training_data, targets, 10)) { // 10 epok dla testu
            Print("❌ Trening LSTM nieudany");
            delete lstm;
            return false;
        }
        
        // Test predykcji
        double prediction = lstm.Predict(training_data);
        Print("🔮 Predykcja LSTM: ", DoubleToString(prediction, 6));
        
        // Test stanu modelu
        SAIModelState state = lstm.GetModelState();
        Print("📊 Status modelu LSTM: ", IntegerToString(state.training_state));
        Print("📊 Dokładność: ", DoubleToString(state.accuracy, 1), "%");
        
        delete lstm;
        
        Print("✅ Test LSTM zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu LSTM");
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 3: Test CNN                                                  |
//+------------------------------------------------------------------+
bool TestCNN() {
    Print("🔍 Test 3: Test CNN...");
    
    try {
        CCentralCNN* cnn = new CCentralCNN(4, CNNKernelSize, CNNOutputFeatures);
        if(!cnn.Initialize()) {
            delete cnn;
            return false;
        }
        
        // Przygotuj dane testowe
        double test_data[][];
        if(!PrepareCNNTestData(test_data)) {
            delete cnn;
            return false;
        }
        
        // Test rozpoznawania wzorców
        double probabilities[];
        cnn.RecognizePatterns(test_data, probabilities);
        
        Print("🔍 Rozpoznane wzorce CNN:");
        for(int i = 0; i < MathMin(ArraySize(probabilities), 8); i++) {
            Print("  Wzorzec ", i + 1, ": ", DoubleToString(probabilities[i], 3));
        }
        
        // Test stanu modelu
        SAIModelState state = cnn.GetModelState();
        Print("📊 Status modelu CNN: ", IntegerToString(state.training_state));
        
        delete cnn;
        
        Print("✅ Test CNN zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu CNN");
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 4: Test Attention                                            |
//+------------------------------------------------------------------+
bool TestAttention() {
    Print("👁️ Test 4: Test Attention...");
    
    try {
        CCentralAttention* attention = new CCentralAttention(64, 8, 20);
        if(!attention.Initialize()) {
            delete attention;
            return false;
        }
        
        // Przygotuj dane testowe
        double input_data[][];
        double output_data[][];
        
        if(!PrepareAttentionTestData(input_data, output_data)) {
            delete attention;
            return false;
        }
        
        // Test mechanizmu uwagi
        attention.ApplyAttention(input_data, output_data);
        
        Print("👁️ Mechanizm uwagi zastosowany");
        Print("📊 Rozmiar danych wejściowych: ", ArraySize(input_data), "x", ArraySize(input_data[0]));
        Print("📊 Rozmiar danych wyjściowych: ", ArraySize(output_data), "x", ArraySize(output_data[0]));
        
        // Test stanu modelu
        SAIModelState state = attention.GetModelState();
        Print("📊 Status modelu Attention: ", IntegerToString(state.training_state));
        
        delete attention;
        
        Print("✅ Test Attention zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu Attention");
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 5: Test Kalman Filter                                        |
//+------------------------------------------------------------------+
bool TestKalmanFilter() {
    Print("📊 Test 5: Test Kalman Filter...");
    
    try {
        CCentralKalmanFilter* kalman = new CCentralKalmanFilter(4, 4);
        if(!kalman.Initialize()) {
            delete kalman;
            return false;
        }
        
        // Przygotuj dane testowe
        double measurement[];
        if(!PrepareKalmanTestData(measurement)) {
            delete kalman;
            return false;
        }
        
        // Test filtrowania
        double* filtered_result = kalman.Filter(measurement);
        
        if(filtered_result != NULL) {
            Print("📊 Wynik filtrowania Kalman:");
            for(int i = 0; i < 4; i++) {
                Print("  Wymiar ", i + 1, ": ", DoubleToString(filtered_result[i], 6));
            }
        }
        
        // Test stanu modelu
        double state_estimate[];
        kalman.GetStateEstimate(state_estimate);
        Print("📊 Estymata stanu Kalman: ", ArraySize(state_estimate), " wymiarów");
        
        delete kalman;
        
        Print("✅ Test Kalman Filter zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu Kalman Filter");
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 6: Test Ensemble                                             |
//+------------------------------------------------------------------+
bool TestEnsemble() {
    Print("🎯 Test 6: Test Ensemble...");
    
    try {
        CCentralEnsemble* ensemble = new CCentralEnsemble();
        if(!ensemble.Initialize()) {
            delete ensemble;
            return false;
        }
        
        // Przygotuj dane testowe
        double test_data[][];
        if(!PrepareEnsembleTestData(test_data)) {
            delete ensemble;
            return false;
        }
        
        // Test predykcji ensemble
        double prediction = ensemble.Predict(test_data);
        Print("🔮 Predykcja Ensemble: ", DoubleToString(prediction, 6));
        
        // Test raportu
        string report = ensemble.GetEnsembleReport();
        Print("📊 Raport Ensemble: ", report);
        
        delete ensemble;
        
        Print("✅ Test Ensemble zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu Ensemble");
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 7: Test Central AI Manager                                   |
//+------------------------------------------------------------------+
bool TestCentralAIManager() {
    Print("🚀 Test 7: Test Central AI Manager...");
    
    try {
        CCentralAIManager* manager = new CCentralAIManager();
        if(!manager.Initialize()) {
            delete manager;
            return false;
        }
        
        // Test konfiguracji
        manager.EnableEnsemble(true);
        manager.EnableAutoRetrain(true);
        manager.SetRetrainThreshold(0.7);
        
        // Test raportu
        string report = manager.GetAIManagerReport();
        Print("📊 Raport AI Manager: ", report);
        
        // Test stanu modeli
        SAIModelState lstm_state = manager.GetModelState(AI_MODEL_LSTM);
        SAIModelState cnn_state = manager.GetModelState(AI_MODEL_CNN);
        
        Print("📊 Status LSTM: ", IntegerToString(lstm_state.training_state));
        Print("📊 Status CNN: ", IntegerToString(cnn_state.training_state));
        
        delete manager;
        
        Print("✅ Test Central AI Manager zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu Central AI Manager");
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 8: Test funkcji pomocniczych                                 |
//+------------------------------------------------------------------+
bool TestHelperFunctions() {
    Print("🛠️ Test 8: Test funkcji pomocniczych...");
    
    try {
        // Test normalizacji danych
        double test_data[] = {1.0, 5.0, 10.0, 15.0, 20.0};
        Print("📊 Dane przed normalizacją: ", ArrayToString(test_data));
        
        NormalizeData(test_data, 0.0, 1.0);
        Print("📊 Dane po normalizacji: ", ArrayToString(test_data));
        
        // Test przygotowania danych OHLC
        double opens[] = {1.1000, 1.1010, 1.1020};
        double highs[] = {1.1015, 1.1025, 1.1035};
        double lows[] = {1.0995, 1.1005, 1.1015};
        double closes[] = {1.1010, 1.1020, 1.1030};
        
        double normalized_ohlc[][];
        PrepareOHLCData(opens, highs, lows, closes, normalized_ohlc, 3);
        
        Print("📊 Znormalizowane dane OHLC:");
        for(int i = 0; i < 3; i++) {
            Print("  Bar ", i + 1, ": O=", DoubleToString(normalized_ohlc[i][0], 4),
                  " H=", DoubleToString(normalized_ohlc[i][1], 4),
                  " L=", DoubleToString(normalized_ohlc[i][2], 4),
                  " C=", DoubleToString(normalized_ohlc[i][3], 4));
        }
        
        // Test obliczania RSI
        double prices[] = {1.1000, 1.1010, 1.1020, 1.1015, 1.1025, 1.1030, 1.1025, 1.1035, 1.1040, 1.1035, 1.1045, 1.1050, 1.1045, 1.1055, 1.1060};
        double rsi = CalculateRSI(prices, 14);
        Print("📊 RSI (14): ", DoubleToString(rsi, 2));
        
        // Test obliczania MACD
        double macd_line[], signal_line[], histogram[];
        CalculateMACD(prices, 12, 26, 9, macd_line, signal_line, histogram);
        
        Print("📊 MACD ostatni: ", DoubleToString(macd_line[ArraySize(macd_line)-1], 6));
        Print("📊 Signal ostatni: ", DoubleToString(signal_line[ArraySize(signal_line)-1], 6));
        Print("📊 Histogram ostatni: ", DoubleToString(histogram[ArraySize(histogram)-1], 6));
        
        Print("✅ Test funkcji pomocniczych zakończony pomyślnie");
        return true;
        
    } catch(...) {
        Print("❌ Błąd podczas testu funkcji pomocniczych");
        return false;
    }
}

//+------------------------------------------------------------------+
//| FUNKCJE POMOCNICZE DO TESTÓW                                      |
//+------------------------------------------------------------------+

// Przygotowanie danych testowych dla LSTM
bool PrepareLSTMTestData(double &training_data[][], double &targets[]) {
    int sequence_length = 20;
    int input_size = LSTMInputSize;
    
    // Resize tablic
    ArrayResize(training_data, sequence_length);
    for(int i = 0; i < sequence_length; i++) {
        ArrayResize(training_data[i], input_size);
    }
    ArrayResize(targets, sequence_length);
    
    // Generuj losowe dane treningowe
    for(int t = 0; t < sequence_length; t++) {
        for(int j = 0; j < input_size; j++) {
            training_data[t][j] = (MathRand() / 32767.0 - 0.5) * 2.0; // -1 do 1
        }
        targets[t] = (MathRand() / 32767.0 - 0.5) * 2.0; // -1 do 1
    }
    
    return true;
}

// Przygotowanie danych testowych dla CNN
bool PrepareCNNTestData(double &test_data[][]) {
    int bars = 50;
    int channels = 4; // OHLC
    
    ArrayResize(test_data, bars);
    for(int i = 0; i < bars; i++) {
        ArrayResize(test_data[i], channels);
        
        // Generuj losowe dane OHLC
        test_data[i][0] = 1.1000 + (MathRand() / 32767.0 - 0.5) * 0.0100; // Open
        test_data[i][1] = test_data[i][0] + (MathRand() / 32767.0) * 0.0050; // High
        test_data[i][2] = test_data[i][0] - (MathRand() / 32767.0) * 0.0050; // Low
        test_data[i][3] = test_data[i][2] + (MathRand() / 32767.0) * (test_data[i][1] - test_data[i][2]); // Close
    }
    
    return true;
}

// Przygotowanie danych testowych dla Attention
bool PrepareAttentionTestData(double &input_data[][], double &output_data[][]) {
    int sequence_length = 20;
    int embedding_dim = 64;
    
    ArrayResize(input_data, sequence_length);
    for(int i = 0; i < sequence_length; i++) {
        ArrayResize(input_data[i], embedding_dim);
        for(int j = 0; j < embedding_dim; j++) {
            input_data[i][j] = (MathRand() / 32767.0 - 0.5) * 2.0;
        }
    }
    
    ArrayResize(output_data, sequence_length);
    for(int i = 0; i < sequence_length; i++) {
        ArrayResize(output_data[i], embedding_dim);
    }
    
    return true;
}

// Przygotowanie danych testowych dla Kalman
bool PrepareKalmanTestData(double &measurement[]) {
    ArrayResize(measurement, 4);
    
    // Generuj losowe pomiary (OHLC)
    measurement[0] = 1.1000 + (MathRand() / 32767.0 - 0.5) * 0.0100; // Open
    measurement[1] = measurement[0] + (MathRand() / 32767.0) * 0.0050; // High
    measurement[2] = measurement[0] - (MathRand() / 32767.0) * 0.0050; // Low
    measurement[3] = measurement[2] + (MathRand() / 32767.0) * (measurement[1] - measurement[2]); // Close
    
    return true;
}

// Przygotowanie danych testowych dla Ensemble
bool PrepareEnsembleTestData(double &test_data[][]) {
    int bars = 30;
    int features = 8;
    
    ArrayResize(test_data, bars);
    for(int i = 0; i < bars; i++) {
        ArrayResize(test_data[i], features);
        for(int j = 0; j < features; j++) {
            test_data[i][j] = (MathRand() / 32767.0 - 0.5) * 2.0;
        }
    }
    
    return true;
}

// Funkcja pomocnicza do konwersji tablicy na string
string ArrayToString(double &array[]) {
    string result = "[";
    for(int i = 0; i < ArraySize(array); i++) {
        if(i > 0) result += ", ";
        result += DoubleToString(array[i], 4);
    }
    result += "]";
    return result;
}
