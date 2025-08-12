//+------------------------------------------------------------------+
//| AI Test Runner - Testy zaawansowanych implementacji AI
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "2.0.0"
#property description "Testy zaawansowanych algorytmów AI dla systemu Böhmego"

#include "AI\AdvancedAI.mqh"
#include "AI\NeuralNetworks.mqh"
#include "AI\MachineLearning.mqh"
#include "Utils\LoggingSystem.mqh"

// Parametry testów
input bool   TestLSTM = true;              // Test LSTM Network
input bool   TestCNN = true;               // Test Convolutional Network
input bool   TestTransformer = true;       // Test Transformer Network
input bool   TestFireSpiritAI = true;      // Test Fire Spirit AI
input bool   TestNeuralNetwork = true;     // Test podstawowej sieci neuronowej
input bool   GenerateReport = true;        // Generuj raport
input string ReportFileName = "AI_Test_Report.txt"; // Nazwa pliku raportu

// Globalne zmienne
bool g_tests_completed = false;
string g_test_results = "";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("=== BOHME AI TEST RUNNER ===");
    Print("Version: 2.0.0");
    Print("Date: ", TimeToString(TimeCurrent()));
    Print("Symbol: ", Symbol());
    Print("Period: ", EnumToString(Period()));
    
    // Sprawdź czy wszystkie pliki AI istnieją
    if(!CheckAIFiles()) {
        Print("❌ AI files missing. Tests cannot proceed.");
        return INIT_FAILED;
    }
    
    Print("✅ AI Test runner initialized successfully");
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("=== BOHME AI TEST RUNNER DEINITIALIZATION ===");
    Print("Test runner cleanup completed");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Uruchom testy tylko raz
    if(!g_tests_completed) {
        RunAITests();
        g_tests_completed = true;
    }
}

//+------------------------------------------------------------------+
//| Sprawdź czy pliki AI istnieją                                   |
//+------------------------------------------------------------------+
bool CheckAIFiles() {
    // Sprawdź główne pliki AI
    if(!FileIsExist("AI\\AdvancedAI.mqh")) {
        Print("❌ AdvancedAI.mqh not found");
        return false;
    }
    
    if(!FileIsExist("AI\\NeuralNetworks.mqh")) {
        Print("❌ NeuralNetworks.mqh not found");
        return false;
    }
    
    if(!FileIsExist("AI\\MachineLearning.mqh")) {
        Print("❌ MachineLearning.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Utils\\LoggingSystem.mqh")) {
        Print("❌ LoggingSystem.mqh not found");
        return false;
    }
    
    Print("✅ All AI files found");
    return true;
}

//+------------------------------------------------------------------+
//| Uruchomienie testów AI                                           |
//+------------------------------------------------------------------+
void RunAITests() {
    Print("=== STARTING BOHME AI TESTS ===");
    datetime start_time = TimeCurrent();
    
    g_test_results = "=== BOHME AI TEST REPORT ===\n";
    g_test_results += "Date: " + TimeToString(TimeCurrent()) + "\n";
    g_test_results += "Symbol: " + Symbol() + "\n";
    g_test_results += "Period: " + EnumToString(Period()) + "\n\n";
    
    int total_tests = 0;
    int passed_tests = 0;
    
    // Test LSTM Network
    if(TestLSTM) {
        total_tests++;
        if(TestLSTMNetwork()) {
            passed_tests++;
            Print("✅ LSTM Network test passed");
        } else {
            Print("❌ LSTM Network test failed");
        }
    }
    
    // Test Convolutional Network
    if(TestCNN) {
        total_tests++;
        if(TestConvolutionalNetwork()) {
            passed_tests++;
            Print("✅ Convolutional Network test passed");
        } else {
            Print("❌ Convolutional Network test failed");
        }
    }
    
    // Test Transformer Network
    if(TestTransformer) {
        total_tests++;
        if(TestTransformerNetwork()) {
            passed_tests++;
            Print("✅ Transformer Network test passed");
        } else {
            Print("❌ Transformer Network test failed");
        }
    }
    
    // Test Fire Spirit AI
    if(TestFireSpiritAI) {
        total_tests++;
        if(TestFireSpiritAI()) {
            passed_tests++;
            Print("✅ Fire Spirit AI test passed");
        } else {
            Print("❌ Fire Spirit AI test failed");
        }
    }
    
    // Test podstawowej sieci neuronowej
    if(TestNeuralNetwork) {
        total_tests++;
        if(TestBasicNeuralNetwork()) {
            passed_tests++;
            Print("✅ Basic Neural Network test passed");
        } else {
            Print("❌ Basic Neural Network test failed");
        }
    }
    
    // Wyświetl podsumowanie
    double success_rate = (total_tests > 0) ? (double)passed_tests / total_tests * 100.0 : 0.0;
    double total_time = (double)(TimeCurrent() - start_time);
    
    Print("=== AI TESTS COMPLETED ===");
    Print("Total tests: ", total_tests);
    Print("Passed tests: ", passed_tests);
    Print("Success rate: ", DoubleToString(success_rate, 2), "%");
    Print("Total time: ", DoubleToString(total_time, 2), " seconds");
    
    // Dodaj podsumowanie do raportu
    g_test_results += "=== SUMMARY ===\n";
    g_test_results += "Total tests: " + IntegerToString(total_tests) + "\n";
    g_test_results += "Passed tests: " + IntegerToString(passed_tests) + "\n";
    g_test_results += "Success rate: " + DoubleToString(success_rate, 2) + "%\n";
    g_test_results += "Total time: " + DoubleToString(total_time, 2) + " seconds\n";
    
    // Generuj raport
    if(GenerateReport) {
        GenerateAITestReport();
    }
}

//+------------------------------------------------------------------+
//| Test LSTM Network                                                |
//+------------------------------------------------------------------+
bool TestLSTMNetwork() {
    g_test_results += "--- LSTM Network Test ---\n";
    
    try {
        // Utwórz LSTM network
        CLSTMNetwork* lstm = new CLSTMNetwork(10, 64, 1, 20);
        
        if(lstm == NULL) {
            g_test_results += "❌ Failed to create LSTM network\n";
            return false;
        }
        
        // Test inicjalizacji
        if(!lstm.InitializeWeights()) {
            g_test_results += "❌ Failed to initialize LSTM weights\n";
            delete lstm;
            return false;
        }
        
        // Przygotuj dane testowe
        double test_sequence[20];
        for(int i = 0; i < 20; i++) {
            test_sequence[i] = MathSin(i * 0.1) + (MathRand() % 100) / 1000.0; // Sinusoida z szumem
        }
        
        // Test forward pass
        double prediction = lstm.ForwardPass(test_sequence);
        
        if(prediction == 0.0 && lstm.IsTrained()) {
            g_test_results += "❌ LSTM forward pass returned 0\n";
            delete lstm;
            return false;
        }
        
        // Test treningu (uproszczony)
        double training_sequences[][20];
        double training_targets[];
        
        ArrayResize(training_sequences, 10);
        ArrayResize(training_targets, 10);
        
        for(int i = 0; i < 10; i++) {
            ArrayResize(training_sequences[i], 20);
            for(int j = 0; j < 20; j++) {
                training_sequences[i][j] = MathSin((i + j) * 0.1) + (MathRand() % 100) / 1000.0;
            }
            training_targets[i] = MathSin((i + 20) * 0.1); // Następna wartość
        }
        
        // Trening (tylko kilka epok dla testu)
        if(!lstm.Train(training_sequences, training_targets, 5)) {
            g_test_results += "❌ LSTM training failed\n";
            delete lstm;
            return false;
        }
        
        // Test predykcji po treningu
        double trained_prediction = lstm.Predict(test_sequence);
        
        // Sprawdź czy model jest oznaczony jako wytrenowany
        if(!lstm.IsTrained()) {
            g_test_results += "❌ LSTM not marked as trained after training\n";
            delete lstm;
            return false;
        }
        
        // Test GetSummary
        string summary = lstm.GetSummary();
        if(StringLen(summary) < 50) {
            g_test_results += "❌ LSTM summary too short\n";
            delete lstm;
            return false;
        }
        
        g_test_results += "✅ LSTM Network test completed successfully\n";
        g_test_results += "Initial prediction: " + DoubleToString(prediction, 6) + "\n";
        g_test_results += "Trained prediction: " + DoubleToString(trained_prediction, 6) + "\n";
        g_test_results += "Summary length: " + IntegerToString(StringLen(summary)) + " characters\n\n";
        
        delete lstm;
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in LSTM test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test Convolutional Network                                       |
//+------------------------------------------------------------------+
bool TestConvolutionalNetwork() {
    g_test_results += "--- Convolutional Network Test ---\n";
    
    try {
        // Utwórz CNN (uproszczony test)
        CConvolutionalNet* cnn = new CConvolutionalNet(50, 5);
        
        if(cnn == NULL) {
            g_test_results += "❌ Failed to create CNN\n";
            return false;
        }
        
        // Przygotuj dane testowe
        double test_input[50];
        for(int i = 0; i < 50; i++) {
            test_input[i] = (MathRand() % 1000) / 1000.0; // Losowe dane
        }
        
        // Test predykcji
        double prediction = cnn.Predict(test_input);
        
        if(prediction == 0.0) {
            g_test_results += "❌ CNN prediction returned 0\n";
            delete cnn;
            return false;
        }
        
        g_test_results += "✅ Convolutional Network test completed successfully\n";
        g_test_results += "Prediction: " + DoubleToString(prediction, 6) + "\n\n";
        
        delete cnn;
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in CNN test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test Transformer Network                                         |
//+------------------------------------------------------------------+
bool TestTransformerNetwork() {
    g_test_results += "--- Transformer Network Test ---\n";
    
    try {
        // Utwórz Transformer (uproszczony test)
        CTransformerNetwork* transformer = new CTransformerNetwork(20, 128, 8, 4, 20);
        
        if(transformer == NULL) {
            g_test_results += "❌ Failed to create Transformer\n";
            return false;
        }
        
        // Test inicjalizacji
        if(!transformer.Initialize()) {
            g_test_results += "❌ Failed to initialize Transformer\n";
            delete transformer;
            return false;
        }
        
        // Przygotuj dane testowe
        double test_sequence[20];
        for(int i = 0; i < 20; i++) {
            test_sequence[i] = MathCos(i * 0.2) + (MathRand() % 100) / 1000.0;
        }
        
        // Test forward pass
        double prediction = transformer.ForwardPass(test_sequence);
        
        if(prediction == 0.0 && transformer.IsTrained()) {
            g_test_results += "❌ Transformer forward pass returned 0\n";
            delete transformer;
            return false;
        }
        
        g_test_results += "✅ Transformer Network test completed successfully\n";
        g_test_results += "Prediction: " + DoubleToString(prediction, 6) + "\n\n";
        
        delete transformer;
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in Transformer test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test Fire Spirit AI                                              |
//+------------------------------------------------------------------+
bool TestFireSpiritAI() {
    g_test_results += "--- Fire Spirit AI Test ---\n";
    
    try {
        // Utwórz Fire Spirit AI
        CFireSpiritAI* fire_ai = new CFireSpiritAI();
        
        if(fire_ai == NULL) {
            g_test_results += "❌ Failed to create Fire Spirit AI\n";
            return false;
        }
        
        // Test inicjalizacji
        if(!fire_ai.Initialize()) {
            g_test_results += "❌ Failed to initialize Fire Spirit AI\n";
            delete fire_ai;
            return false;
        }
        
        // Dodaj dane testowe
        for(int i = 0; i < 100; i++) {
            double price = 1.0 + MathSin(i * 0.1) * 0.1 + (MathRand() % 100) / 10000.0;
            double volume = 1000 + MathSin(i * 0.05) * 500 + (MathRand() % 1000);
            fire_ai.UpdateData(price, volume);
        }
        
        // Test analizy zmienności
        double volatility = fire_ai.GetVolatility();
        if(volatility < 0.0) {
            g_test_results += "❌ Invalid volatility value\n";
            delete fire_ai;
            return false;
        }
        
        // Test analizy energii
        double energy = fire_ai.GetEnergyLevel();
        if(energy < 0.0 || energy > 100.0) {
            g_test_results += "❌ Invalid energy level\n";
            delete fire_ai;
            return false;
        }
        
        // Test reżimu zmienności
        ENUM_VOLATILITY_REGIME regime = fire_ai.GetVolatilityRegime();
        if(regime < VOLATILITY_LOW || regime > VOLATILITY_TRANSITION) {
            g_test_results += "❌ Invalid volatility regime\n";
            delete fire_ai;
            return false;
        }
        
        // Test predykcji zmienności
        double forecast = fire_ai.GetVolatilityForecast(5);
        if(forecast < 0.0) {
            g_test_results += "❌ Invalid volatility forecast\n";
            delete fire_ai;
            return false;
        }
        
        // Test raportu
        string report = fire_ai.GetAnalysisReport();
        if(StringLen(report) < 100) {
            g_test_results += "❌ Analysis report too short\n";
            delete fire_ai;
            return false;
        }
        
        g_test_results += "✅ Fire Spirit AI test completed successfully\n";
        g_test_results += "Volatility: " + DoubleToString(volatility, 6) + "\n";
        g_test_results += "Energy Level: " + DoubleToString(energy, 2) + "\n";
        g_test_results += "Regime: " + IntegerToString(regime) + "\n";
        g_test_results += "Forecast: " + DoubleToString(forecast, 6) + "\n";
        g_test_results += "Report length: " + IntegerToString(StringLen(report)) + " characters\n\n";
        
        delete fire_ai;
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in Fire Spirit AI test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test podstawowej sieci neuronowej                                |
//+------------------------------------------------------------------+
bool TestBasicNeuralNetwork() {
    g_test_results += "--- Basic Neural Network Test ---\n";
    
    try {
        // Utwórz sieć neuronową
        CNeuralNetwork* nn = new CNeuralNetwork();
        
        if(nn == NULL) {
            g_test_results += "❌ Failed to create Neural Network\n";
            return false;
        }
        
        // Konfiguracja parametrów
        SNeuralNetworkParams params;
        params.input_size = 10;
        params.output_size = 1;
        params.hidden_activation = ACTIVATION_RELU;
        params.output_activation = ACTIVATION_LINEAR;
        params.optimizer = OPTIMIZER_ADAM;
        params.loss_function = LOSS_MEAN_SQUARED_ERROR;
        params.learning_rate = 0.001;
        params.batch_size = 32;
        params.epochs = 10;
        params.validation_split = 0.2;
        params.shuffle_data = true;
        params.early_stopping = false;
        params.verbose = false;
        params.random_seed = 42;
        
        // Inicjalizacja
        if(!nn.Initialize(params)) {
            g_test_results += "❌ Failed to initialize Neural Network\n";
            delete nn;
            return false;
        }
        
        // Przygotuj dane treningowe
        double training_data[][10];
        double training_labels[];
        
        ArrayResize(training_data, 100);
        ArrayResize(training_labels, 100);
        
        for(int i = 0; i < 100; i++) {
            ArrayResize(training_data[i], 10);
            for(int j = 0; j < 10; j++) {
                training_data[i][j] = (MathRand() % 1000) / 1000.0;
            }
            // Prosta funkcja: suma wejść
            training_labels[i] = 0.0;
            for(int j = 0; j < 10; j++) {
                training_labels[i] += training_data[i][j];
            }
            training_labels[i] /= 10.0; // Normalizacja
        }
        
        // Wczytaj dane
        if(!nn.LoadData(training_data, training_labels, 0.2)) {
            g_test_results += "❌ Failed to load training data\n";
            delete nn;
            return false;
        }
        
        // Dodaj warstwy
        if(!nn.AddDenseLayer(64, ACTIVATION_RELU)) {
            g_test_results += "❌ Failed to add dense layer\n";
            delete nn;
            return false;
        }
        
        if(!nn.AddDenseLayer(32, ACTIVATION_RELU)) {
            g_test_results += "❌ Failed to add dense layer\n";
            delete nn;
            return false;
        }
        
        if(!nn.AddDenseLayer(1, ACTIVATION_LINEAR)) {
            g_test_results += "❌ Failed to add output layer\n";
            delete nn;
            return false;
        }
        
        // Zbuduj architekturę
        if(!nn.BuildArchitecture()) {
            g_test_results += "❌ Failed to build architecture\n";
            delete nn;
            return false;
        }
        
        // Test predykcji przed treningiem
        double test_input[10];
        for(int i = 0; i < 10; i++) {
            test_input[i] = 0.5; // Stała wartość
        }
        
        SNeuralPrediction prediction_before = nn.Predict(test_input);
        
        // Trening
        if(!nn.TrainModel()) {
            g_test_results += "❌ Training failed\n";
            delete nn;
            return false;
        }
        
        // Test predykcji po treningu
        SNeuralPrediction prediction_after = nn.Predict(test_input);
        
        // Sprawdź czy model jest oznaczony jako wytrenowany
        if(!nn.IsModelTrained()) {
            g_test_results += "❌ Model not marked as trained after training\n";
            delete nn;
            return false;
        }
        
        // Test GetModelSummary
        string summary = nn.GetModelSummary();
        if(StringLen(summary) < 100) {
            g_test_results += "❌ Model summary too short\n";
            delete nn;
            return false;
        }
        
        g_test_results += "✅ Basic Neural Network test completed successfully\n";
        g_test_results += "Prediction before training: " + DoubleToString(prediction_before.output[0], 6) + "\n";
        g_test_results += "Prediction after training: " + DoubleToString(prediction_after.output[0], 6) + "\n";
        g_test_results += "Training time: " + DoubleToString(nn.GetTrainingTime(), 2) + " seconds\n";
        g_test_results += "Total parameters: " + IntegerToString(nn.GetTotalParameters()) + "\n";
        g_test_results += "Summary length: " + IntegerToString(StringLen(summary)) + " characters\n\n";
        
        delete nn;
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in Basic Neural Network test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Generuj raport testów AI                                         |
//+------------------------------------------------------------------+
void GenerateAITestReport() {
    string filename = "Files\\" + ReportFileName;
    
    int file_handle = FileOpen(filename, FILE_WRITE | FILE_TXT);
    if(file_handle != INVALID_HANDLE) {
        FileWriteString(file_handle, g_test_results);
        FileClose(file_handle);
        Print("✅ AI test report saved to: ", filename);
    } else {
        Print("❌ Failed to save AI test report");
    }
} 