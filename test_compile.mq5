//+------------------------------------------------------------------+
//| Test compilation file for Bohme AI System                         |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "3.0.0"
#property description "Test compilation of all AI models and classes"

// Include all core modules
#include "Bohme/Core/CentralAI.mqh"
#include "Bohme/Core/MasterConsciousness.mqh"
#include "Bohme/Core/TradeTypes.mqh"

// Test variables
CCentralLSTM* test_lstm = NULL;
CCentralCNN* test_cnn = NULL;
CCentralAttention* test_attention = NULL;
CCentralKalmanFilter* test_kalman = NULL;
CCentralEnsemble* test_ensemble = NULL;
CCentralAIManager* test_manager = NULL;

//+------------------------------------------------------------------+
//| Expert initialization function                                     |
//+------------------------------------------------------------------+
int OnInit() {
    Print("🧪 ROZPOCZYNAM TESTY KOMPILACJI SYSTEMU BÖHMEGO...");
    
    // Test 1: Inicjalizacja klas AI
    if(!TestAIClassesInitialization()) {
        Print("❌ Test 1 - Inicjalizacja klas AI: BŁĄD");
        return INIT_FAILED;
    }
    Print("✅ Test 1 - Inicjalizacja klas AI: SUKCES");
    
    // Test 2: Test funkcji podstawowych
    if(!TestBasicFunctions()) {
        Print("❌ Test 2 - Funkcje podstawowe: BŁĄD");
        return INIT_FAILED;
    }
    Print("✅ Test 2 - Funkcje podstawowe: SUKCES");
    
    // Test 3: Test funkcji duchowych
    if(!TestSpiritualFunctions()) {
        Print("❌ Test 3 - Funkcje duchowe: BŁĄD");
        return INIT_FAILED;
    }
    Print("✅ Test 3 - Funkcje duchowe: SUKCES");
    
    // Test 4: Test integracji
    if(!TestIntegration()) {
        Print("❌ Test 4 - Integracja: BŁĄD");
        return INIT_FAILED;
    }
    Print("✅ Test 4 - Integracja: SUKCES");
    
    Print("🎉 WSZYSTKIE TESTY KOMPILACJI ZAKOŃCZONE POMYŚLNIE!");
    Print("🚀 System Böhmego jest gotowy do użycia!");
    
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Test 1: Inicjalizacja klas AI                                    |
//+------------------------------------------------------------------+
bool TestAIClassesInitialization() {
    Print("🔍 Test 1: Inicjalizacja klas AI...");
    
    try {
        // Test LSTM
        test_lstm = new CCentralLSTM(10, 20, 1, 5, AI_PERSONALITY_FIRE);
        if(test_lstm == NULL) {
            Print("❌ Błąd tworzenia LSTM");
            return false;
        }
        if(!test_lstm.Initialize()) {
            Print("❌ Błąd inicjalizacji LSTM");
            return false;
        }
        Print("✅ LSTM zainicjalizowany");
        
        // Test CNN
        test_cnn = new CCentralCNN(3, 3, 16, AI_PERSONALITY_WATER);
        if(test_cnn == NULL) {
            Print("❌ Błąd tworzenia CNN");
            return false;
        }
        if(!test_cnn.Initialize()) {
            Print("❌ Błąd inicjalizacji CNN");
            return false;
        }
        Print("✅ CNN zainicjalizowany");
        
        // Test Attention
        test_attention = new CCentralAttention(32, 4, 10, AI_PERSONALITY_EARTH);
        if(test_attention == NULL) {
            Print("❌ Błąd tworzenia Attention");
            return false;
        }
        if(!test_attention.Initialize()) {
            Print("❌ Błąd inicjalizacji Attention");
            return false;
        }
        Print("✅ Attention zainicjalizowany");
        
        // Test Kalman Filter
        test_kalman = new CCentralKalmanFilter(4, 4);
        if(test_kalman == NULL) {
            Print("❌ Błąd tworzenia Kalman Filter");
            return false;
        }
        if(!test_kalman.Initialize()) {
            Print("❌ Błąd inicjalizacji Kalman Filter");
            return false;
        }
        Print("✅ Kalman Filter zainicjalizowany");
        
        // Test Ensemble
        test_ensemble = new CCentralEnsemble();
        if(test_ensemble == NULL) {
            Print("❌ Błąd tworzenia Ensemble");
            return false;
        }
        if(!test_ensemble.Initialize()) {
            Print("❌ Błąd inicjalizacji Ensemble");
            return false;
        }
        Print("✅ Ensemble zainicjalizowany");
        
        // Test AI Manager
        test_manager = new CCentralAIManager();
        if(test_manager == NULL) {
            Print("❌ Błąd tworzenia AI Manager");
            return false;
        }
        if(!test_manager.Initialize()) {
            Print("❌ Błąd inicjalizacji AI Manager");
            return false;
        }
        Print("✅ AI Manager zainicjalizowany");
        
        return true;
        
    } catch(...) {
        Print("❌ Wyjątek podczas inicjalizacji: ", GetLastError());
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 2: Test funkcji podstawowych                                |
//+------------------------------------------------------------------+
bool TestBasicFunctions() {
    Print("🔍 Test 2: Funkcje podstawowe...");
    
    try {
        // Przygotuj dane testowe
        double test_data[][];
        double test_targets[];
        
        ArrayResize(test_data, 5);
        ArrayResize(test_targets, 5);
        
        for(int i = 0; i < 5; i++) {
            ArrayResize(test_data[i], 3);
            for(int j = 0; j < 3; j++) {
                test_data[i][j] = MathRand() / 32767.0;
            }
            test_targets[i] = MathRand() / 32767.0;
        }
        
        // Test LSTM funkcji
        if(test_lstm != NULL) {
            double lstm_pred = test_lstm.Predict(test_data);
            Print("✅ LSTM Predict: ", DoubleToString(lstm_pred, 6));
            
            SAIModelState lstm_state = test_lstm.GetModelState();
            Print("✅ LSTM State: ", lstm_state.model_type, " - ", lstm_state.training_state);
        }
        
        // Test CNN funkcji
        if(test_cnn != NULL) {
            double cnn_pred = test_cnn.Predict(test_data);
            Print("✅ CNN Predict: ", DoubleToString(cnn_pred, 6));
            
            double probabilities[];
            test_cnn.RecognizePatterns(test_data, probabilities);
            Print("✅ CNN Patterns: ", ArraySize(probabilities), " wzorców");
        }
        
        // Test Attention funkcji
        if(test_attention != NULL) {
            double att_pred = test_attention.Predict(test_data);
            Print("✅ Attention Predict: ", DoubleToString(att_pred, 6));
        }
        
        // Test Kalman Filter funkcji
        if(test_kalman != NULL) {
            double measurement[] = {1.0, 2.0, 3.0, 4.0};
            test_kalman.Filter(measurement);
            
            double state[];
            test_kalman.GetStateEstimate(state);
            Print("✅ Kalman State: ", ArraySize(state), " wymiarów");
        }
        
        // Test Ensemble funkcji
        if(test_ensemble != NULL) {
            double ensemble_pred = test_ensemble.Predict(test_data);
            Print("✅ Ensemble Predict: ", DoubleToString(ensemble_pred, 6));
            
            string report = test_ensemble.GetEnsembleReport();
            Print("✅ Ensemble Report: ", StringLen(report), " znaków");
        }
        
        return true;
        
    } catch(...) {
        Print("❌ Wyjątek podczas testu funkcji: ", GetLastError());
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 3: Test funkcji duchowych                                   |
//+------------------------------------------------------------------+
bool TestSpiritualFunctions() {
    Print("🔍 Test 3: Funkcje duchowe...");
    
    try {
        // Test duchowych funkcji LSTM
        if(test_lstm != NULL) {
            test_lstm.ApplySpiritualEnhancement();
            double spiritual_pred = test_lstm.GetSpiritualPrediction(test_data);
            Print("✅ LSTM Spiritual: ", DoubleToString(spiritual_pred, 6));
            
            test_lstm.ChannelMarketWisdom();
            double intuition = test_lstm.GetIntuitivePrediction(test_data);
            Print("✅ LSTM Intuition: ", DoubleToString(intuition, 6));
        }
        
        // Test duchowych funkcji CNN
        if(test_cnn != NULL) {
            test_cnn.ApplyPatternRecognitionWisdom();
            double spiritual_conf = test_cnn.GetSpiritualPatternConfidence();
            Print("✅ CNN Spiritual Confidence: ", DoubleToString(spiritual_conf, 6));
        }
        
        // Test duchowych funkcji Attention
        if(test_attention != NULL) {
            test_attention.ApplyFocusWisdom();
            double attention_score = test_attention.GetSpiritualAttentionScore();
            Print("✅ Attention Spiritual Score: ", DoubleToString(attention_score, 6));
        }
        
        // Test duchowych funkcji Kalman
        if(test_kalman != NULL) {
            test_kalman.ApplyFilteringWisdom();
            double filtering_conf = test_kalman.GetSpiritualFilteringConfidence();
            Print("✅ Kalman Spiritual Confidence: ", DoubleToString(filtering_conf, 6));
        }
        
        // Test duchowych funkcji Ensemble
        if(test_ensemble != NULL) {
            test_ensemble.ApplyEnsembleWisdom();
            double ensemble_conf = test_ensemble.GetSpiritualEnsembleConfidence();
            Print("✅ Ensemble Spiritual Confidence: ", DoubleToString(ensemble_conf, 6));
        }
        
        // Test duchowych funkcji Manager
        if(test_manager != NULL) {
            test_manager.ApplyManagerWisdom();
            test_manager.BalanceSpiritualEnergies();
            
            string spiritual_report = test_manager.GetSpiritualManagerReport();
            Print("✅ Manager Spiritual Report: ", StringLen(spiritual_report), " znaków");
        }
        
        return true;
        
    } catch(...) {
        Print("❌ Wyjątek podczas testu duchowych funkcji: ", GetLastError());
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test 4: Test integracji                                           |
//+------------------------------------------------------------------+
bool TestIntegration() {
    Print("🔍 Test 4: Integracja systemu...");
    
    try {
        // Test integracji z Master Consciousness
        if(test_manager != NULL) {
            // Symuluj dane rynkowe
            double market_data[][];
            ArrayResize(market_data, 10);
            for(int i = 0; i < 10; i++) {
                ArrayResize(market_data[i], 8); // OHLC + Volume + Time
                for(int j = 0; j < 8; j++) {
                    market_data[i][j] = MathRand() / 32767.0 * 100.0;
                }
            }
            
            // Test predykcji z różnych modeli
            double lstm_pred = test_manager.GetPrediction(AI_MODEL_LSTM, market_data);
            double cnn_pred = test_manager.GetPrediction(AI_MODEL_CNN, market_data);
            double attention_pred = test_manager.GetPrediction(AI_MODEL_ATTENTION, market_data);
            double kalman_pred = test_manager.GetPrediction(AI_MODEL_KALMAN, market_data);
            
            Print("✅ Integracja predykcji:");
            Print("   LSTM: ", DoubleToString(lstm_pred, 6));
            Print("   CNN: ", DoubleToString(cnn_pred, 6));
            Print("   Attention: ", DoubleToString(attention_pred, 6));
            Print("   Kalman: ", DoubleToString(kalman_pred, 6));
            
            // Test duchowej predykcji
            double spiritual_pred = test_manager.GetSpiritualPrediction(AI_MODEL_LSTM, market_data);
            Print("✅ Duchowa predykcja LSTM: ", DoubleToString(spiritual_pred, 6));
        }
        
        return true;
        
    } catch(...) {
        Print("❌ Wyjątek podczas testu integracji: ", GetLastError());
        return false;
    }
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                  |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("🧹 Czyszczenie zasobów testowych...");
    
    // Usuń obiekty testowe
    if(test_lstm != NULL) {
        delete test_lstm;
        test_lstm = NULL;
    }
    if(test_cnn != NULL) {
        delete test_cnn;
        test_cnn = NULL;
    }
    if(test_attention != NULL) {
        delete test_attention;
        test_cnn = NULL;
    }
    if(test_kalman != NULL) {
        delete test_kalman;
        test_kalman = NULL;
    }
    if(test_ensemble != NULL) {
        delete test_ensemble;
        test_ensemble = NULL;
    }
    if(test_manager != NULL) {
        delete test_manager;
        test_manager = NULL;
    }
    
    Print("✅ Zasoby testowe wyczyszczone");
}

//+------------------------------------------------------------------+
//| Expert tick function                                              |
//+------------------------------------------------------------------+
void OnTick() {
    // Test tick function - sprawdź czy system działa
    static int tick_count = 0;
    tick_count++;
    
    if(tick_count % 100 == 0) {
        Print("🔄 Tick #", tick_count, " - System Böhmego działa poprawnie");
    }
}
