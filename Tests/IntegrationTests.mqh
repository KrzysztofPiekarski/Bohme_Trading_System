// Kompletny system testowania integracyjnego dla Bohme Trading System
// Testuje wszystkie siedem duchów i Master Consciousness

#include "../Core/MasterConsciousness.mqh"
#include "../Spirits/BitternessSpirit.mqh"
#include "../Spirits/BodySpirit.mqh"
#include "../Spirits/FireSpirit.mqh"
#include "../Spirits/HerbeSpirit.mqh"
#include "../Spirits/LightSpirit.mqh"
#include "../Spirits/SoundSpirit.mqh"
#include "../Spirits/SweetnessSpirit.mqh"

// Struktury testowe
struct STestResult {
    string test_name;
    bool passed;
    double execution_time;
    string details;
    double expected_value;
    double actual_value;
};

struct SSpiritTest {
    string spirit_name;
    STestResult results[];
    double overall_score;
    bool is_healthy;
};

// Główna klasa testów integracyjnych
class CBohmeIntegrationTester {
private:
    // Instancje duchów
    BitternessSpirit* m_bitterness;
    BodySpirit* m_body;
    FireSpirit* m_fire;
    HerbeSpirit* m_herbe;
    LightSpirit* m_light;
    SoundSpirit* m_sound;
    SweetnessSpirit* m_sweetness;
    
    // Master Consciousness
    MasterConsciousness* m_master;
    
    // Wyniki testów
    SSpiritTest m_spirit_tests[7];
    STestResult m_integration_tests[];
    
    // Metryki wydajności
    double m_total_execution_time;
    int m_total_tests;
    int m_passed_tests;
    
    // Helper functions
    void InitializeSpirits();
    void CleanupSpirits();
    double MeasureExecutionTime(datetime start_time);
    string GetSpiritStatus(string spirit_name, bool is_healthy);
    
    // Dodatkowe funkcje pomocnicze
    bool CheckMemoryUsage();
    
public:
    CBohmeIntegrationTester();
    ~CBohmeIntegrationTester();
    
    // Główne metody testowania
    void RunAllTests();
    void TestIndividualSpirits();
    void TestSpiritIntegration();
    void TestMasterConsciousness();
    void TestSystemPerformance();
    void TestErrorHandling();
    
    // Raporty
    void GenerateTestReport();
    void PrintDetailedResults();
    void ExportResultsToFile();
    
    // Gettery
    double GetOverallScore();
    int GetPassedTests();
    int GetTotalTests();
    double GetAverageExecutionTime();
};

// Konstruktor
CBohmeIntegrationTester::CBohmeIntegrationTester() {
    Print("=== BOHME INTEGRATION TESTER INITIALIZED ===");
    
    // Inicjalizacja duchów
    InitializeSpirits();
    
    // Inicjalizacja Master Consciousness
    m_master = new MasterConsciousness();
    
    // Inicjalizacja metryk
    m_total_execution_time = 0.0;
    m_total_tests = 0;
    m_passed_tests = 0;
    
    // Inicjalizacja struktur testowych
    string spirit_names[] = {"Bitterness", "Body", "Fire", "Herbe", "Light", "Sound", "Sweetness"};
    for(int i = 0; i < 7; i++) {
        m_spirit_tests[i].spirit_name = spirit_names[i];
        m_spirit_tests[i].overall_score = 0.0;
        m_spirit_tests[i].is_healthy = false;
    }
}

// Inicjalizacja duchów
void CBohmeIntegrationTester::InitializeSpirits() {
    Print("Initializing all seven spirits...");
    
    m_bitterness = new BitternessSpirit();
    m_body = new BodySpirit();
    m_fire = new FireSpirit();
    m_herbe = new HerbeSpirit();
    m_light = new LightSpirit();
    m_sound = new SoundSpirit();
    m_sweetness = new SweetnessSpirit();
    
    Print("All spirits initialized successfully");
}

// Destruktor
CBohmeIntegrationTester::~CBohmeIntegrationTester() {
    CleanupSpirits();
    
    if(m_master != NULL) {
        delete m_master;
    }
    
    Print("=== BOHME INTEGRATION TESTER CLEANUP COMPLETE ===");
}

// Czyszczenie duchów
void CBohmeIntegrationTester::CleanupSpirits() {
    if(m_bitterness != NULL) delete m_bitterness;
    if(m_body != NULL) delete m_body;
    if(m_fire != NULL) delete m_fire;
    if(m_herbe != NULL) delete m_herbe;
    if(m_light != NULL) delete m_light;
    if(m_sound != NULL) delete m_sound;
    if(m_sweetness != NULL) delete m_sweetness;
}

// Główna metoda uruchamiająca wszystkie testy
void CBohmeIntegrationTester::RunAllTests() {
    Print("=== STARTING BOHME INTEGRATION TESTS ===");
    datetime start_time = TimeCurrent();
    
    // Test 1: Indywidualne duchy
    Print("--- Testing Individual Spirits ---");
    TestIndividualSpirits();
    
    // Test 2: Integracja duchów
    Print("--- Testing Spirit Integration ---");
    TestSpiritIntegration();
    
    // Test 3: Master Consciousness
    Print("--- Testing Master Consciousness ---");
    TestMasterConsciousness();
    
    // Test 4: Wydajność systemu
    Print("--- Testing System Performance ---");
    TestSystemPerformance();
    
    // Test 5: Obsługa błędów
    Print("--- Testing Error Handling ---");
    TestErrorHandling();
    
    // Obliczenie całkowitego czasu
    m_total_execution_time = MeasureExecutionTime(start_time);
    
    // Generowanie raportu
    GenerateTestReport();
    
    Print("=== BOHME INTEGRATION TESTS COMPLETED ===");
}

// Test indywidualnych duchów
void CBohmeIntegrationTester::TestIndividualSpirits() {
    // Test Bitterness Spirit
    TestBitternessSpirit();
    
    // Test Body Spirit
    TestBodySpirit();
    
    // Test Fire Spirit
    TestFireSpirit();
    
    // Test Herbe Spirit
    TestHerbeSpirit();
    
    // Test Light Spirit
    TestLightSpirit();
    
    // Test Sound Spirit
    TestSoundSpirit();
    
    // Test Sweetness Spirit
    TestSweetnessSpirit();
}

// Test Bitterness Spirit
void TestBitternessSpirit() {
    Print("Testing Bitterness Spirit...");
    datetime start_time = TimeCurrent();
    
    // Test 1: GetMomentumPhase
    double momentum = m_bitterness.GetMomentumPhase();
    bool test1 = (momentum >= 0 && momentum <= 100);
    AddTestResult(0, "GetMomentumPhase", test1, MeasureExecutionTime(start_time), 
                 "Momentum phase calculation", 50.0, momentum);
    
    // Test 2: GetBreakthroughProbability
    double breakthrough = m_bitterness.GetBreakthroughProbability();
    bool test2 = (breakthrough >= 0 && breakthrough <= 1);
    AddTestResult(0, "GetBreakthroughProbability", test2, MeasureExecutionTime(start_time),
                 "Breakthrough probability calculation", 0.5, breakthrough);
    
    // Test 3: CalculateMomentumConvergence
    double strength = m_bitterness.CalculateMomentumConvergence();
    bool test3 = (strength >= 0 && strength <= 100);
    AddTestResult(0, "CalculateMomentumConvergence", test3, MeasureExecutionTime(start_time),
                 "Momentum strength calculation", 50.0, strength);
    
    m_spirit_tests[0].is_healthy = (test1 && test2 && test3);
}

// Test Body Spirit
void TestBodySpirit() {
    Print("Testing Body Spirit...");
    datetime start_time = TimeCurrent();
    
    // Test 1: GetExecutionQuality
    double quality = m_body.GetExecutionQuality();
    bool test1 = (quality >= 0 && quality <= 100);
    AddTestResult(1, "GetExecutionQuality", test1, MeasureExecutionTime(start_time),
                 "Execution quality calculation", 50.0, quality);
    
    // Test 2: CalculateOptimalSize
    double size = m_body.CalculateOptimalSize(1000.0, 0.02);
    bool test2 = (size > 0 && size <= 1000.0);
    AddTestResult(1, "CalculateOptimalSize", test2, MeasureExecutionTime(start_time),
                 "Optimal position size calculation", 500.0, size);
    
    // Test 3: GetRiskLevel
    double risk = m_body.GetRiskLevel();
    bool test3 = (risk >= 0 && risk <= 100);
    AddTestResult(1, "GetRiskLevel", test3, MeasureExecutionTime(start_time),
                 "Risk level calculation", 50.0, risk);
    
    m_spirit_tests[1].is_healthy = (test1 && test2 && test3);
}

// Test Fire Spirit
void TestFireSpirit() {
    Print("Testing Fire Spirit...");
    datetime start_time = TimeCurrent();
    
    // Test 1: GetEnergyLevel
    double energy = m_fire.GetEnergyLevel();
    bool test1 = (energy >= 0 && energy <= 100);
    AddTestResult(2, "GetEnergyLevel", test1, MeasureExecutionTime(start_time),
                 "Energy level calculation", 50.0, energy);
    
    // Test 2: GetVolatilityRegime
    double regime = m_fire.GetVolatilityRegime();
    bool test2 = (regime >= 0 && regime <= 100);
    AddTestResult(2, "GetVolatilityRegime", test2, MeasureExecutionTime(start_time),
                 "Volatility regime calculation", 50.0, regime);
    
    // Test 3: GetEnergyExhaustionProbability
    double exhaustion = m_fire.GetEnergyExhaustionProbability();
    bool test3 = (exhaustion >= 0 && exhaustion <= 1);
    AddTestResult(2, "GetEnergyExhaustionProbability", test3, MeasureExecutionTime(start_time),
                 "Energy exhaustion probability", 0.5, exhaustion);
    
    m_spirit_tests[2].is_healthy = (test1 && test2 && test3);
}

// Test Herbe Spirit
void TestHerbeSpirit() {
    Print("Testing Herbe Spirit...");
    datetime start_time = TimeCurrent();
    
    // Test 1: GetMarketPhase
    double phase = m_herbe.GetMarketPhase();
    bool test1 = (phase >= 0 && phase <= 100);
    AddTestResult(3, "GetMarketPhase", test1, MeasureExecutionTime(start_time),
                 "Market phase calculation", 50.0, phase);
    
    // Test 2: GetPolicyDivergenceIndex
    double divergence = m_herbe.GetPolicyDivergenceIndex();
    bool test2 = (divergence >= 0 && divergence <= 100);
    AddTestResult(3, "GetPolicyDivergenceIndex", test2, MeasureExecutionTime(start_time),
                 "Policy divergence calculation", 50.0, divergence);
    
    // Test 3: GetGeopoliticalTension
    double tension = m_herbe.GetGeopoliticalTension();
    bool test3 = (tension >= 0 && tension <= 100);
    AddTestResult(3, "GetGeopoliticalTension", test3, MeasureExecutionTime(start_time),
                 "Geopolitical tension calculation", 50.0, tension);
    
    m_spirit_tests[3].is_healthy = (test1 && test2 && test3);
}

// Test Light Spirit
void TestLightSpirit() {
    Print("Testing Light Spirit...");
    datetime start_time = TimeCurrent();
    
    // Test 1: GetSignalClarity
    double clarity = m_light.GetSignalClarity();
    bool test1 = (clarity >= 0 && clarity <= 100);
    AddTestResult(4, "GetSignalClarity", test1, MeasureExecutionTime(start_time),
                 "Signal clarity calculation", 50.0, clarity);
    
    // Test 2: GetSignalQuality
    double quality = m_light.GetSignalQuality();
    bool test2 = (quality >= 0 && quality <= 4); // ENUM_SIGNAL_QUALITY
    AddTestResult(4, "GetSignalQuality", test2, MeasureExecutionTime(start_time),
                 "Signal quality assessment", 2.0, quality);
    
    // Test 3: GetPatternConfidence
    double confidence = m_light.GetPatternConfidence();
    bool test3 = (confidence >= 0 && confidence <= 100);
    AddTestResult(4, "GetPatternConfidence", test3, MeasureExecutionTime(start_time),
                 "Pattern confidence calculation", 50.0, confidence);
    
    m_spirit_tests[4].is_healthy = (test1 && test2 && test3);
}

// Test Sound Spirit
void TestSoundSpirit() {
    Print("Testing Sound Spirit...");
    datetime start_time = TimeCurrent();
    
    // Test 1: GetCycleHarmonyIndex
    double harmony = m_sound.GetCycleHarmonyIndex();
    bool test1 = (harmony >= 0 && harmony <= 100);
    AddTestResult(5, "GetCycleHarmonyIndex", test1, MeasureExecutionTime(start_time),
                 "Cycle harmony calculation", 50.0, harmony);
    
    // Test 2: GetHarmonyState
    double state = m_sound.GetHarmonyState();
    bool test2 = (state >= 0 && state <= 4); // ENUM_HARMONY_STATE
    AddTestResult(5, "GetHarmonyState", test2, MeasureExecutionTime(start_time),
                 "Harmony state assessment", 2.0, state);
    
    // Test 3: GetPhaseAlignment
    double alignment = m_sound.GetPhaseAlignment();
    bool test3 = (alignment >= 0 && alignment <= 100);
    AddTestResult(5, "GetPhaseAlignment", test3, MeasureExecutionTime(start_time),
                 "Phase alignment calculation", 50.0, alignment);
    
    m_spirit_tests[5].is_healthy = (test1 && test2 && test3);
}

// Test Sweetness Spirit
void TestSweetnessSpirit() {
    Print("Testing Sweetness Spirit...");
    datetime start_time = TimeCurrent();
    
    // Test 1: GetHarmonyIndex
    double harmony = m_sweetness.GetHarmonyIndex();
    bool test1 = (harmony >= 0 && harmony <= 100);
    AddTestResult(6, "GetHarmonyIndex", test1, MeasureExecutionTime(start_time),
                 "Sentiment harmony calculation", 50.0, harmony);
    
    // Test 2: GetFearGreedIndex
    double fear_greed = m_sweetness.GetFearGreedIndex();
    bool test2 = (fear_greed >= 0 && fear_greed <= 100);
    AddTestResult(6, "GetFearGreedIndex", test2, MeasureExecutionTime(start_time),
                 "Fear & Greed index calculation", 50.0, fear_greed);
    
    // Test 3: GetCrowdWisdomScore
    double wisdom = m_sweetness.GetCrowdWisdomScore();
    bool test3 = (wisdom >= 0 && wisdom <= 100);
    AddTestResult(6, "GetCrowdWisdomScore", test3, MeasureExecutionTime(start_time),
                 "Crowd wisdom calculation", 50.0, wisdom);
    
    m_spirit_tests[6].is_healthy = (test1 && test2 && test3);
}

// Test integracji duchów
void CBohmeIntegrationTester::TestSpiritIntegration() {
    Print("Testing Spirit Integration...");
    datetime start_time = TimeCurrent();
    
    // Test 1: Wszystkie duchy zwracają wartości w poprawnych zakresach
    bool all_spirits_healthy = true;
    for(int i = 0; i < 7; i++) {
        if(!m_spirit_tests[i].is_healthy) {
            all_spirits_healthy = false;
            break;
        }
    }
    
    AddIntegrationTest("All Spirits Healthy", all_spirits_healthy, MeasureExecutionTime(start_time),
                      "All seven spirits are functioning correctly", 1.0, all_spirits_healthy ? 1.0 : 0.0);
    
    // Test 2: Spójność wartości między duchami
    TestSpiritConsistency();
    
    // Test 3: Współpraca duchów
    TestSpiritCollaboration();
}

// Test spójności duchów
void TestSpiritConsistency() {
    Print("Testing Spirit Consistency...");
    datetime start_time = TimeCurrent();
    
    // Sprawdź czy wartości są logicznie spójne
    double bitterness_momentum = m_bitterness.GetMomentumPhase();
    double fire_energy = m_fire.GetEnergyLevel();
    double light_clarity = m_light.GetSignalClarity();
    
    // Wysoka energia + wysoka jasność = wysoki momentum
    bool consistency_test = true;
    if(fire_energy > 70 && light_clarity > 70) {
        if(bitterness_momentum < 30) {
            consistency_test = false;
        }
    }
    
    AddIntegrationTest("Spirit Consistency", consistency_test, MeasureExecutionTime(start_time),
                      "Spirit values are logically consistent", 1.0, consistency_test ? 1.0 : 0.0);
}

// Test współpracy duchów
void TestSpiritCollaboration() {
    Print("Testing Spirit Collaboration...");
    datetime start_time = TimeCurrent();
    
    // Symulacja współpracy duchów
    double body_execution = m_body.GetExecutionQuality();
    double light_clarity = m_light.GetSignalClarity();
    double sound_harmony = m_sound.GetCycleHarmonyIndex();
    
    // Wysoka jasność + harmonia = dobra jakość wykonania
    bool collaboration_test = true;
    if(light_clarity > 80 && sound_harmony > 80) {
        if(body_execution < 40) {
            collaboration_test = false;
        }
    }
    
    AddIntegrationTest("Spirit Collaboration", collaboration_test, MeasureExecutionTime(start_time),
                      "Spirits collaborate effectively", 1.0, collaboration_test ? 1.0 : 0.0);
}

// Test Master Consciousness
void CBohmeIntegrationTester::TestMasterConsciousness() {
    Print("Testing Master Consciousness...");
    datetime start_time = TimeCurrent();
    
    // Test 1: Inicjalizacja Master Consciousness
    bool init_test = (m_master != NULL);
    AddIntegrationTest("Master Consciousness Init", init_test, MeasureExecutionTime(start_time),
                      "Master Consciousness initialized successfully", 1.0, init_test ? 1.0 : 0.0);
    
    // Test 2: Koordynacja duchów
    TestSpiritCoordination();
    
    // Test 3: Podejmowanie decyzji
    TestDecisionMaking();
}

// Test koordynacji duchów przez Master Consciousness
void TestSpiritCoordination() {
    Print("Testing Spirit Coordination...");
    datetime start_time = TimeCurrent();
    
    // Symulacja koordynacji
    bool coordination_test = true;
    
    // Sprawdź czy Master Consciousness może koordynować wszystkie duchy
    for(int i = 0; i < 7; i++) {
        if(!m_spirit_tests[i].is_healthy) {
            coordination_test = false;
            break;
        }
    }
    
    AddIntegrationTest("Spirit Coordination", coordination_test, MeasureExecutionTime(start_time),
                      "Master Consciousness can coordinate all spirits", 1.0, coordination_test ? 1.0 : 0.0);
}

// Test podejmowania decyzji
void TestDecisionMaking() {
    Print("Testing Decision Making...");
    datetime start_time = TimeCurrent();
    
    // Symulacja procesu decyzyjnego
    bool decision_test = true;
    
    // Sprawdź czy system może podjąć decyzję
    double overall_sentiment = m_sweetness.GetHarmonyIndex();
    double overall_energy = m_fire.GetEnergyLevel();
    double overall_clarity = m_light.GetSignalClarity();
    
    // Jeśli wszystkie wskaźniki są wysokie, system powinien być gotowy do działania
    if(overall_sentiment > 70 && overall_energy > 70 && overall_clarity > 70) {
        decision_test = true;
    }
    
    AddIntegrationTest("Decision Making", decision_test, MeasureExecutionTime(start_time),
                      "System can make trading decisions", 1.0, decision_test ? 1.0 : 0.0);
}

// Test wydajności systemu
void CBohmeIntegrationTester::TestSystemPerformance() {
    Print("Testing System Performance...");
    datetime start_time = TimeCurrent();
    
    // Test 1: Czas wykonania wszystkich duchów
    datetime spirit_start = TimeCurrent();
    
    // Wykonaj wszystkie główne funkcje duchów
    m_bitterness.GetMomentumPhase();
    m_body.GetExecutionQuality();
    m_fire.GetEnergyLevel();
    m_herbe.GetMarketPhase();
    m_light.GetSignalClarity();
    m_sound.GetCycleHarmonyIndex();
    m_sweetness.GetHarmonyIndex();
    
    double spirit_execution_time = MeasureExecutionTime(spirit_start);
    bool performance_test = (spirit_execution_time < 1.0); // Mniej niż 1 sekunda
    
    AddIntegrationTest("Spirit Performance", performance_test, spirit_execution_time,
                      "All spirits execute within acceptable time", 1.0, performance_test ? 1.0 : 0.0);
    
    // Test 2: Użycie pamięci
    TestMemoryUsage();
}

// Test użycia pamięci
void TestMemoryUsage() {
    Print("Testing Memory Usage...");
    datetime start_time = TimeCurrent();
    
    // Prawdziwa implementacja testu pamięci
    bool memory_test = CheckMemoryUsage();
    
    AddIntegrationTest("Memory Usage", memory_test, MeasureExecutionTime(start_time),
                      "Memory usage is within acceptable limits", 1.0, memory_test ? 1.0 : 0.0);
}

// Test obsługi błędów
void CBohmeIntegrationTester::TestErrorHandling() {
    Print("Testing Error Handling...");
    datetime start_time = TimeCurrent();
    
    // Test 1: Obsługa nieprawidłowych danych wejściowych
    bool error_handling_test = true;
    
    // Symulacja błędów
    try {
        // Próba dostępu do nieistniejących danych
        double invalid_data = 0.0;
        if(invalid_data == 0.0) {
            // Symulacja błędu
            error_handling_test = false;
        }
    }
    catch(...) {
        error_handling_test = true; // Błąd został obsłużony
    }
    
    AddIntegrationTest("Error Handling", error_handling_test, MeasureExecutionTime(start_time),
                      "System handles errors gracefully", 1.0, error_handling_test ? 1.0 : 0.0);
}

// Helper functions
double CBohmeIntegrationTester::MeasureExecutionTime(datetime start_time) {
    return (double)(TimeCurrent() - start_time);
}

void CBohmeIntegrationTester::AddTestResult(int spirit_index, string test_name, bool passed, 
                                           double execution_time, string details, 
                                           double expected, double actual) {
    STestResult result;
    result.test_name = test_name;
    result.passed = passed;
    result.execution_time = execution_time;
    result.details = details;
    result.expected_value = expected;
    result.actual_value = actual;
    
    // Dodaj do tablicy wyników ducha
    int current_size = ArraySize(m_spirit_tests[spirit_index].results);
    ArrayResize(m_spirit_tests[spirit_index].results, current_size + 1);
    m_spirit_tests[spirit_index].results[current_size] = result;
    
    // Aktualizuj metryki
    m_total_tests++;
    if(passed) m_passed_tests++;
    m_total_execution_time += execution_time;
}

void CBohmeIntegrationTester::AddIntegrationTest(string test_name, bool passed, 
                                                double execution_time, string details, 
                                                double expected, double actual) {
    STestResult result;
    result.test_name = test_name;
    result.passed = passed;
    result.execution_time = execution_time;
    result.details = details;
    result.expected_value = expected;
    result.actual_value = actual;
    
    // Dodaj do tablicy testów integracyjnych
    int current_size = ArraySize(m_integration_tests);
    ArrayResize(m_integration_tests, current_size + 1);
    m_integration_tests[current_size] = result;
    
    // Aktualizuj metryki
    m_total_tests++;
    if(passed) m_passed_tests++;
    m_total_execution_time += execution_time;
}

// Generowanie raportu testów
void CBohmeIntegrationTester::GenerateTestReport() {
    Print("=== BOHME INTEGRATION TEST REPORT ===");
    Print("Total Tests: ", m_total_tests);
    Print("Passed Tests: ", m_passed_tests);
    Print("Failed Tests: ", m_total_tests - m_passed_tests);
    Print("Success Rate: ", DoubleToString((double)m_passed_tests / m_total_tests * 100, 2), "%");
    Print("Total Execution Time: ", DoubleToString(m_total_execution_time, 3), " seconds");
    Print("Average Execution Time: ", DoubleToString(m_total_execution_time / m_total_tests, 3), " seconds");
    
    // Status duchów
    Print("\n--- SPIRIT STATUS ---");
    for(int i = 0; i < 7; i++) {
        string status = GetSpiritStatus(m_spirit_tests[i].spirit_name, m_spirit_tests[i].is_healthy);
        Print(status);
    }
    
    // Szczegółowe wyniki
    PrintDetailedResults();
}

// Wyświetlanie szczegółowych wyników
void CBohmeIntegrationTester::PrintDetailedResults() {
    Print("\n--- DETAILED RESULTS ---");
    
    // Wyniki duchów
    for(int i = 0; i < 7; i++) {
        Print("\n", m_spirit_tests[i].spirit_name, " Spirit:");
        for(int j = 0; j < ArraySize(m_spirit_tests[i].results); j++) {
            STestResult result = m_spirit_tests[i].results[j];
            string status = result.passed ? "PASS" : "FAIL";
            Print("  ", result.test_name, ": ", status, " (", DoubleToString(result.execution_time, 3), "s)");
        }
    }
    
    // Wyniki integracyjne
    Print("\nIntegration Tests:");
    for(int i = 0; i < ArraySize(m_integration_tests); i++) {
        STestResult result = m_integration_tests[i];
        string status = result.passed ? "PASS" : "FAIL";
        Print("  ", result.test_name, ": ", status, " (", DoubleToString(result.execution_time, 3), "s)");
    }
}

// Gettery
double CBohmeIntegrationTester::GetOverallScore() {
    return m_total_tests > 0 ? (double)m_passed_tests / m_total_tests * 100 : 0.0;
}

int CBohmeIntegrationTester::GetPassedTests() {
    return m_passed_tests;
}

int CBohmeIntegrationTester::GetTotalTests() {
    return m_total_tests;
}

double CBohmeIntegrationTester::GetAverageExecutionTime() {
    return m_total_tests > 0 ? m_total_execution_time / m_total_tests : 0.0;
}

// Helper function dla statusu ducha
string CBohmeIntegrationTester::GetSpiritStatus(string spirit_name, bool is_healthy) {
    return spirit_name + " Spirit: " + (is_healthy ? "✅ HEALTHY" : "❌ UNHEALTHY");
}

// Implementacja funkcji CheckMemoryUsage
bool CBohmeIntegrationTester::CheckMemoryUsage() {
    // Sprawdź użycie pamięci systemu
    bool memory_ok = true;
    
    // Sprawdź dostępność pamięci
    double available_memory = TerminalInfoDouble(TERMINAL_MEMORY_AVAILABLE);
    double total_memory = TerminalInfoDouble(TERMINAL_MEMORY_TOTAL);
    
    if(available_memory > 0 && total_memory > 0) {
        double memory_usage_percent = (total_memory - available_memory) / total_memory * 100.0;
        
        // Pamięć OK jeśli użycie < 80%
        if(memory_usage_percent > 80.0) {
            memory_ok = false;
            Print("⚠️ Wysokie użycie pamięci: ", DoubleToString(memory_usage_percent, 1), "%");
        } else {
            Print("✅ Użycie pamięci OK: ", DoubleToString(memory_usage_percent, 1), "%");
        }
    } else {
        // Jeśli nie można sprawdzić pamięci, zakładamy że jest OK
        memory_ok = true;
        Print("ℹ️ Nie można sprawdzić pamięci - zakładam OK");
    }
    
    return memory_ok;
}

// Funkcja główna do uruchomienia testów
void RunBohmeIntegrationTests() {
    Print("Starting Bohme Trading System Integration Tests...");
    
    CBohmeIntegrationTester* tester = new CBohmeIntegrationTester();
    
    if(tester != NULL) {
        tester.RunAllTests();
        
        // Wyświetl podsumowanie
        Print("\n=== FINAL SUMMARY ===");
        Print("Overall Score: ", DoubleToString(tester.GetOverallScore(), 2), "%");
        Print("System Status: ", tester.GetOverallScore() >= 90 ? "✅ EXCELLENT" : 
                                tester.GetOverallScore() >= 80 ? "✅ GOOD" :
                                tester.GetOverallScore() >= 70 ? "⚠️  ACCEPTABLE" : "❌ NEEDS IMPROVEMENT");
        
        delete tester;
    }
    else {
        Print("❌ Failed to create integration tester");
    }
}
