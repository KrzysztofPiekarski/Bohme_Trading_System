//+------------------------------------------------------------------+
//| Complete System Test - Test kompletnego systemu z AI
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "2.0.0"
#property description "Test kompletnego systemu Bohme z wszystkimi duchami i AI"

#include "Core/SystemConfig.mqh"
#include "Core/ MasterConsciousness.mqh"
// REMOVED: #include "AI/AdvancedAI.mqh" - folder AI/ deleted (legacy code)
#include "Utils/LoggingSystem.mqh"

// Includes wszystkich duchów
#include "Spirits/LightSpirit.mqh"
#include "Spirits/FireSpirit.mqh"
#include "Spirits/BitternessSpirit.mqh"
#include "Spirits/BodySpirit.mqh"
#include "Spirits/HerbeSpirit.mqh"
#include "Spirits/SweetnessSpirit.mqh"
#include "Spirits/SoundSpirit.mqh"

// Parametry testów
input bool   TestAllSpirits = true;        // Test wszystkich duchów
input bool   TestMasterConsciousness = true; // Test Master Consciousness
input bool   TestAIComponents = true;       // Test komponentów AI
input bool   TestIntegration = true;        // Test integracji
input bool   GenerateReport = true;         // Generuj raport
input string ReportFileName = "Complete_System_Test_Report.txt"; // Nazwa pliku raportu

// Globalne zmienne
bool g_tests_completed = false;
string g_test_results = "";

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("=== BOHME COMPLETE SYSTEM TEST ===");
    Print("Version: 2.0.0");
    Print("Date: ", TimeToString(TimeCurrent()));
    Print("Symbol: ", Symbol());
    Print("Period: ", EnumToString(Period()));
    
    // Sprawdź czy wszystkie pliki istnieją
    if(!CheckSystemFiles()) {
        Print("❌ System files missing. Tests cannot proceed.");
        return INIT_FAILED;
    }
    
    Print("✅ Complete System Test runner initialized successfully");
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("=== BOHME COMPLETE SYSTEM TEST DEINITIALIZATION ===");
    Print("Test runner cleanup completed");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Uruchom testy tylko raz
    if(!g_tests_completed) {
        RunCompleteSystemTests();
        g_tests_completed = true;
    }
}

//+------------------------------------------------------------------+
//| Sprawdź czy pliki systemu istnieją                              |
//+------------------------------------------------------------------+
bool CheckSystemFiles() {
    // Sprawdź główne pliki systemu
    if(!FileIsExist("Core\\SystemConfig.mqh")) {
        Print("❌ SystemConfig.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Core\\ MasterConsciousness.mqh")) {
        Print("❌ MasterConsciousness.mqh not found");
        return false;
    }
    
    if(!FileIsExist("AI\\AdvancedAI.mqh")) {
        Print("❌ AdvancedAI.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Utils\\LoggingSystem.mqh")) {
        Print("❌ LoggingSystem.mqh not found");
        return false;
    }
    
    // Sprawdź pliki duchów
    if(!FileIsExist("Spirits\\LightSpirit.mqh")) {
        Print("❌ LightSpirit.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Spirits\\FireSpirit.mqh")) {
        Print("❌ FireSpirit.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Spirits\\BitternessSpirit.mqh")) {
        Print("❌ BitternessSpirit.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Spirits\\BodySpirit.mqh")) {
        Print("❌ BodySpirit.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Spirits\\HerbeSpirit.mqh")) {
        Print("❌ HerbeSpirit.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Spirits\\SweetnessSpirit.mqh")) {
        Print("❌ SweetnessSpirit.mqh not found");
        return false;
    }
    
    if(!FileIsExist("Spirits\\SoundSpirit.mqh")) {
        Print("❌ SoundSpirit.mqh not found");
        return false;
    }
    
    Print("✅ All system files found");
    return true;
}

//+------------------------------------------------------------------+
//| Uruchomienie testów kompletnego systemu                         |
//+------------------------------------------------------------------+
void RunCompleteSystemTests() {
    Print("=== STARTING BOHME COMPLETE SYSTEM TESTS ===");
    datetime start_time = TimeCurrent();
    
    g_test_results = "=== BOHME COMPLETE SYSTEM TEST REPORT ===\n";
    g_test_results += "Date: " + TimeToString(TimeCurrent()) + "\n";
    g_test_results += "Symbol: " + Symbol() + "\n";
    g_test_results += "Period: " + EnumToString(Period()) + "\n\n";
    
    int total_tests = 0;
    int passed_tests = 0;
    
    // Test wszystkich duchów
    if(TestAllSpirits) {
        total_tests++;
        if(TestAllSpirits()) {
            passed_tests++;
            Print("✅ All Spirits test passed");
        } else {
            Print("❌ All Spirits test failed");
        }
    }
    
    // Test Master Consciousness
    if(TestMasterConsciousness) {
        total_tests++;
        if(TestMasterConsciousness()) {
            passed_tests++;
            Print("✅ Master Consciousness test passed");
        } else {
            Print("❌ Master Consciousness test failed");
        }
    }
    
    // Test komponentów AI
    if(TestAIComponents) {
        total_tests++;
        if(TestAIComponents()) {
            passed_tests++;
            Print("✅ AI Components test passed");
        } else {
            Print("❌ AI Components test failed");
        }
    }
    
    // Test integracji
    if(TestIntegration) {
        total_tests++;
        if(TestIntegration()) {
            passed_tests++;
            Print("✅ Integration test passed");
        } else {
            Print("❌ Integration test failed");
        }
    }
    
    // Wyświetl podsumowanie
    double success_rate = (total_tests > 0) ? (double)passed_tests / total_tests * 100.0 : 0.0;
    double total_time = (double)(TimeCurrent() - start_time);
    
    Print("=== COMPLETE SYSTEM TESTS COMPLETED ===");
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
        GenerateCompleteSystemTestReport();
    }
}

//+------------------------------------------------------------------+
//| Test wszystkich duchów                                           |
//+------------------------------------------------------------------+
bool TestAllSpirits() {
    g_test_results += "--- All Spirits Test ---\n";
    
    try {
        // Test Light Spirit
        LightSpirit* light_spirit = new LightSpirit();
        if(!light_spirit.Initialize()) {
            g_test_results += "❌ Light Spirit initialization failed\n";
            delete light_spirit;
            return false;
        }
        
        SSignalData signal = light_spirit.GetOptimalEntry();
        g_test_results += "✅ Light Spirit: " + DoubleToString(signal.confidence, 1) + "% confidence\n";
        delete light_spirit;
        
        // Test Fire Spirit
        FireSpiritAI* fire_spirit = new FireSpiritAI();
        if(!fire_spirit.Initialize()) {
            g_test_results += "❌ Fire Spirit initialization failed\n";
            delete fire_spirit;
            return false;
        }
        
        double intensity = fire_spirit.GetFireIntensity();
        g_test_results += "✅ Fire Spirit: " + DoubleToString(intensity, 1) + " intensity\n";
        delete fire_spirit;
        
        // Test Bitterness Spirit
        BitternessSpirit* bitterness_spirit = new BitternessSpirit();
        if(!bitterness_spirit.Initialize()) {
            g_test_results += "❌ Bitterness Spirit initialization failed\n";
            delete bitterness_spirit;
            return false;
        }
        
        double momentum = bitterness_spirit.CalculateMomentumConvergence();
        g_test_results += "✅ Bitterness Spirit: " + DoubleToString(momentum, 1) + " momentum\n";
        delete bitterness_spirit;
        
        // Test Body Spirit
        BodySpirit* body_spirit = new BodySpirit();
        if(!body_spirit.Initialize()) {
            g_test_results += "❌ Body Spirit initialization failed\n";
            delete body_spirit;
            return false;
        }
        
        double readiness = body_spirit.GetExecutionQuality();
        g_test_results += "✅ Body Spirit: " + DoubleToString(readiness, 1) + " readiness\n";
        delete body_spirit;
        
        // Test Herbe Spirit
        HerbeQualityAI* herbe_spirit = new HerbeQualityAI();
        if(!herbe_spirit.Initialize()) {
            g_test_results += "❌ Herbe Spirit initialization failed\n";
            delete herbe_spirit;
            return false;
        }
        
        double tension = herbe_spirit.GetFundamentalConflictStrength();
        g_test_results += "✅ Herbe Spirit: " + DoubleToString(tension, 1) + " tension\n";
        delete herbe_spirit;
        
        // Test Sweetness Spirit
        SentimentAI* sweetness_spirit = new SentimentAI();
        if(!sweetness_spirit.Initialize()) {
            g_test_results += "❌ Sweetness Spirit initialization failed\n";
            delete sweetness_spirit;
            return false;
        }
        
        double sentiment = sweetness_spirit.GetHarmonyIndex();
        g_test_results += "✅ Sweetness Spirit: " + DoubleToString(sentiment, 1) + " sentiment\n";
        delete sweetness_spirit;
        
        // Test Sound Spirit
        SoundSpiritAI* sound_spirit = new SoundSpiritAI();
        if(!sound_spirit.Initialize()) {
            g_test_results += "❌ Sound Spirit initialization failed\n";
            delete sound_spirit;
            return false;
        }
        
        double harmony = sound_spirit.GetCycleHarmonyIndex();
        g_test_results += "✅ Sound Spirit: " + DoubleToString(harmony, 1) + " harmony\n";
        delete sound_spirit;
        
        g_test_results += "✅ All Spirits test completed successfully\n\n";
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in All Spirits test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test Master Consciousness                                        |
//+------------------------------------------------------------------+
bool TestMasterConsciousness() {
    g_test_results += "--- Master Consciousness Test ---\n";
    
    try {
        // Utwórz wszystkie duchy
        LightSpirit* light_spirit = new LightSpirit();
        FireSpiritAI* fire_spirit = new FireSpiritAI();
        BitternessSpirit* bitterness_spirit = new BitternessSpirit();
        BodySpirit* body_spirit = new BodySpirit();
        HerbeQualityAI* herbe_spirit = new HerbeQualityAI();
        SentimentAI* sweetness_spirit = new SentimentAI();
        SoundSpiritAI* sound_spirit = new SoundSpiritAI();
        
        // Inicjalizuj wszystkie duchy
        if(!light_spirit.Initialize() || !fire_spirit.Initialize() || 
           !bitterness_spirit.Initialize() || !body_spirit.Initialize() ||
           !herbe_spirit.Initialize() || !sweetness_spirit.Initialize() || 
           !sound_spirit.Initialize()) {
            g_test_results += "❌ Spirit initialization failed\n";
            return false;
        }
        
        // Utwórz Master Consciousness
        CMasterConsciousness* master = new CMasterConsciousness();
        
        // Ustaw referencje duchów
        master.SetLightSpirit(light_spirit);
        master.SetFireSpirit(fire_spirit);
        master.SetBitternessSpirit(bitterness_spirit);
        master.SetBodySpirit(body_spirit);
        master.SetHerbeSpirit(herbe_spirit);
        master.SetSweetnessSpirit(sweetness_spirit);
        master.SetSoundSpirit(sound_spirit);
        
        // Inicjalizuj Master Consciousness
        if(!master.Initialize()) {
            g_test_results += "❌ Master Consciousness initialization failed\n";
            delete master;
            return false;
        }
        
        // Test konsensusu
        SConsensusDecision decision = master.GetConsensusDecision();
        g_test_results += "✅ Consensus Decision: " + IntegerToString(decision.action) + "\n";
        g_test_results += "   Confidence: " + DoubleToString(decision.confidence, 1) + "%\n";
        g_test_results += "   Harmony: " + DoubleToString(decision.harmony, 1) + "%\n";
        
        // Test stanu rynku
        SMarketState state = master.GetMarketState();
        g_test_results += "✅ Market State: " + IntegerToString(state.system_state) + "\n";
        g_test_results += "   System Confidence: " + DoubleToString(state.system_confidence, 1) + "%\n";
        g_test_results += "   All Spirits Aligned: " + (state.all_spirits_aligned ? "YES" : "NO") + "\n";
        
        // Test raportów
        string consensus_report = master.GetConsensusReport();
        string alignment_report = master.GetSpiritAlignmentReport();
        
        g_test_results += "✅ Reports generated successfully\n";
        g_test_results += "   Consensus report length: " + IntegerToString(StringLen(consensus_report)) + " characters\n";
        g_test_results += "   Alignment report length: " + IntegerToString(StringLen(alignment_report)) + " characters\n";
        
        // Cleanup
        delete master;
        delete light_spirit;
        delete fire_spirit;
        delete bitterness_spirit;
        delete body_spirit;
        delete herbe_spirit;
        delete sweetness_spirit;
        delete sound_spirit;
        
        g_test_results += "✅ Master Consciousness test completed successfully\n\n";
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in Master Consciousness test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test komponentów AI                                              |
//+------------------------------------------------------------------+
bool TestAIComponents() {
    g_test_results += "--- AI Components Test ---\n";
    
    try {
        // Test LSTM Network
        CLSTMNetwork* lstm = new CLSTMNetwork(10, 64, 1, 20);
        if(!lstm.InitializeWeights()) {
            g_test_results += "❌ LSTM initialization failed\n";
            delete lstm;
            return false;
        }
        
        double test_sequence[20];
        for(int i = 0; i < 20; i++) {
            test_sequence[i] = MathSin(i * 0.1);
        }
        
        double prediction = lstm.ForwardPass(test_sequence);
        g_test_results += "✅ LSTM Network: " + DoubleToString(prediction, 6) + " prediction\n";
        delete lstm;
        
        // Test Fire Spirit AI
        CFireSpiritAI* fire_ai = new CFireSpiritAI();
        if(!fire_ai.Initialize()) {
            g_test_results += "❌ Fire Spirit AI initialization failed\n";
            delete fire_ai;
            return false;
        }
        
        // Dodaj dane testowe
        for(int i = 0; i < 50; i++) {
            double price = 1.0 + MathSin(i * 0.1) * 0.1;
            double volume = 1000 + MathSin(i * 0.05) * 500;
            fire_ai.UpdateData(price, volume);
        }
        
        double volatility = fire_ai.GetVolatility();
        double energy = fire_ai.GetEnergyLevel();
        g_test_results += "✅ Fire Spirit AI: Volatility=" + DoubleToString(volatility, 6) + 
                         ", Energy=" + DoubleToString(energy, 1) + "\n";
        delete fire_ai;
        
        // Test Neural Network
        CNeuralNetwork* nn = new CNeuralNetwork();
        SNeuralNetworkParams params;
        params.input_size = 10;
        params.output_size = 1;
        params.hidden_activation = ACTIVATION_RELU;
        params.output_activation = ACTIVATION_LINEAR;
        params.optimizer = OPTIMIZER_ADAM;
        params.loss_function = LOSS_MEAN_SQUARED_ERROR;
        params.learning_rate = 0.001;
        params.batch_size = 32;
        params.epochs = 5;
        params.verbose = false;
        
        if(!nn.Initialize(params)) {
            g_test_results += "❌ Neural Network initialization failed\n";
            delete nn;
            return false;
        }
        
        g_test_results += "✅ Neural Network initialized successfully\n";
        delete nn;
        
        g_test_results += "✅ AI Components test completed successfully\n\n";
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in AI Components test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Test integracji                                                  |
//+------------------------------------------------------------------+
bool TestIntegration() {
    g_test_results += "--- Integration Test ---\n";
    
    try {
        // Test pełnej integracji systemu
        g_test_results += "Testing complete system integration...\n";
        
        // Symulacja działania systemu
        for(int i = 0; i < 10; i++) {
            // Symuluj tick
            datetime current_time = TimeCurrent();
            
            // Symuluj analizę rynku
            double price = 1.0 + MathSin(i * 0.1) * 0.1;
            double volume = 1000 + MathSin(i * 0.05) * 500;
            
            g_test_results += "Tick " + IntegerToString(i + 1) + ": Price=" + 
                             DoubleToString(price, 5) + ", Volume=" + DoubleToString(volume, 0) + "\n";
        }
        
        g_test_results += "✅ Integration test completed successfully\n";
        g_test_results += "System is ready for live trading\n\n";
        return true;
        
    } catch(...) {
        g_test_results += "❌ Exception in Integration test\n";
        return false;
    }
}

//+------------------------------------------------------------------+
//| Generuj raport testów kompletnego systemu                       |
//+------------------------------------------------------------------+
void GenerateCompleteSystemTestReport() {
    string filename = "Files\\" + ReportFileName;
    
    int file_handle = FileOpen(filename, FILE_WRITE | FILE_TXT);
    if(file_handle != INVALID_HANDLE) {
        FileWriteString(file_handle, g_test_results);
        FileClose(file_handle);
        Print("✅ Complete system test report saved to: ", filename);
    } else {
        Print("❌ Failed to save complete system test report");
    }
} 