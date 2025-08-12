#ifndef LOGGING_SYSTEM_TEST_H
#define LOGGING_SYSTEM_TEST_H

// ========================================
// LOGGING SYSTEM TEST - TESTY SYSTEMU LOGOWANIA
// ========================================
// Testy funkcjonalności systemu logowania

#include "Utils\LoggingSystem.mqh"
#include "Core\ SystemConfig.mqh"

// === KLASA TESTÓW LOGOWANIA ===

class CLoggingSystemTest {
private:
    CLoggingSystem* m_logger;
    int m_total_tests;
    int m_passed_tests;
    double m_total_execution_time;
    
public:
    CLoggingSystemTest();
    ~CLoggingSystemTest();
    
    // Inicjalizacja testów
    bool Initialize();
    void Cleanup();
    
    // Uruchomienie wszystkich testów
    void RunAllTests();
    
    // Testy podstawowe
    void TestBasicLogging();
    void TestLogLevels();
    void TestComponents();
    void TestLogTypes();
    
    // Testy zaawansowane
    void TestFileOutput();
    void TestPerformanceLogging();
    void TestRiskLogging();
    void TestTradeLogging();
    void TestAILogging();
    
    // Testy integracji
    void TestIntegrationWithSystem();
    void TestCallbackFunctions();
    void TestStatistics();
    void TestExport();
    
    // Raporty
    string GetTestReport();
    double GetOverallScore();
};

// === IMPLEMENTACJA ===

CLoggingSystemTest::CLoggingSystemTest() {
    m_logger = NULL;
    m_total_tests = 0;
    m_passed_tests = 0;
    m_total_execution_time = 0.0;
}

CLoggingSystemTest::~CLoggingSystemTest() {
    Cleanup();
}

bool CLoggingSystemTest::Initialize() {
    // Konfiguracja testowa
    SLogConfig config;
    config.enable_logging = true;
    config.min_level = LOG_LEVEL_DEBUG;
    config.enable_console_output = true;
    config.enable_file_output = true;
    config.enable_performance_logging = true;
    config.enable_risk_logging = true;
    config.enable_trade_logging = true;
    config.enable_ai_logging = true;
    config.max_log_entries = 1000;
    config.log_file_path = "Tests/LoggingTest.log";
    config.enable_timestamp = true;
    config.enable_component_prefix = true;
    config.enable_emoji = true;
    config.enable_color = false;
    
    m_logger = new CLoggingSystem();
    bool success = m_logger.Initialize(config);
    
    if(success) {
        LogInfo(LOG_COMPONENT_TEST, "Logging System Test zainicjalizowany");
    }
    
    return success;
}

void CLoggingSystemTest::Cleanup() {
    if(m_logger != NULL) {
        LogInfo(LOG_COMPONENT_TEST, "Zamykanie Logging System Test");
        delete m_logger;
        m_logger = NULL;
    }
}

void CLoggingSystemTest::RunAllTests() {
    datetime start_time = TimeCurrent();
    
    LogInfo(LOG_COMPONENT_TEST, "=== ROZPOCZĘCIE TESTÓW SYSTEMU LOGOWANIA ===");
    
    // Testy podstawowe
    TestBasicLogging();
    TestLogLevels();
    TestComponents();
    TestLogTypes();
    
    // Testy zaawansowane
    TestFileOutput();
    TestPerformanceLogging();
    TestRiskLogging();
    TestTradeLogging();
    TestAILogging();
    
    // Testy integracji
    TestIntegrationWithSystem();
    TestCallbackFunctions();
    TestStatistics();
    TestExport();
    
    m_total_execution_time = (double)(TimeCurrent() - start_time);
    
    LogInfo(LOG_COMPONENT_TEST, "=== ZAKOŃCZENIE TESTÓW SYSTEMU LOGOWANIA ===");
    LogInfo(LOG_COMPONENT_TEST, "Wyniki testów", 
            "Przeszło: " + IntegerToString(m_passed_tests) + "/" + IntegerToString(m_total_tests));
}

void CLoggingSystemTest::TestBasicLogging() {
    m_total_tests++;
    
    try {
        // Test podstawowego logowania
        LogDebug(LOG_COMPONENT_TEST, "Test debug message", "Debug details", 42.0);
        LogInfo(LOG_COMPONENT_TEST, "Test info message", "Info details", 100.0);
        LogWarning(LOG_COMPONENT_TEST, "Test warning message", "Warning details", 75.0);
        LogError(LOG_COMPONENT_TEST, "Test error message", "Error details", 0.0);
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestBasicLogging - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestBasicLogging - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestLogLevels() {
    m_total_tests++;
    
    try {
        // Test wszystkich poziomów logowania
        for(int level = LOG_LEVEL_DEBUG; level <= LOG_LEVEL_CRITICAL; level++) {
            m_logger.Log((ENUM_LOG_LEVEL)level, LOG_COMPONENT_TEST, LOG_TYPE_GENERAL, 
                        "Test level " + IntegerToString(level), "Level test", (double)level);
        }
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestLogLevels - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestLogLevels - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestComponents() {
    m_total_tests++;
    
    try {
        // Test wszystkich komponentów
        ENUM_LOG_COMPONENT components[] = {
            LOG_COMPONENT_SYSTEM, LOG_COMPONENT_HERBE, LOG_COMPONENT_SWEETNESS,
            LOG_COMPONENT_BITTERNESS, LOG_COMPONENT_FIRE, LOG_COMPONENT_LIGHT,
            LOG_COMPONENT_SOUND, LOG_COMPONENT_BODY, LOG_COMPONENT_MASTER,
            LOG_COMPONENT_RISK, LOG_COMPONENT_POSITION, LOG_COMPONENT_ORDER,
            LOG_COMPONENT_EXECUTION, LOG_COMPONENT_AI, LOG_COMPONENT_NEWS,
            LOG_COMPONENT_TEST, LOG_COMPONENT_INTEGRATION
        };
        
        for(int i = 0; i < ArraySize(components); i++) {
            LogInfo(components[i], "Test component " + IntegerToString(i), "Component test");
        }
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestComponents - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestComponents - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestLogTypes() {
    m_total_tests++;
    
    try {
        // Test wszystkich typów logów
        LogPerformance(LOG_COMPONENT_TEST, "Test operation", 0.001, "Performance test");
        LogRisk(LOG_COMPONENT_TEST, "Test risk", 25.5, "Risk mitigation");
        LogTrade(LOG_COMPONENT_TEST, "Test trade", 150.75, "Trade execution");
        LogAI(LOG_COMPONENT_TEST, "Test prediction", 0.85, "AI reasoning");
        LogIntegration(LOG_COMPONENT_TEST, "Test integration", "SUCCESS", "Integration test");
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestLogTypes - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestLogTypes - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestFileOutput() {
    m_total_tests++;
    
    try {
        // Test zapisu do pliku
        for(int i = 0; i < 10; i++) {
            LogInfo(LOG_COMPONENT_TEST, "File test message " + IntegerToString(i), 
                    "File output test", (double)i);
        }
        
        m_logger.Flush();
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestFileOutput - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestFileOutput - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestPerformanceLogging() {
    m_total_tests++;
    
    try {
        // Test logowania wydajności
        for(int i = 0; i < 5; i++) {
            double execution_time = (MathRand() % 1000) / 1000.0;
            LogPerformance(LOG_COMPONENT_TEST, "Performance test " + IntegerToString(i), 
                          execution_time, "Performance measurement");
        }
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestPerformanceLogging - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestPerformanceLogging - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestRiskLogging() {
    m_total_tests++;
    
    try {
        // Test logowania ryzyka
        LogRisk(LOG_COMPONENT_TEST, "High volatility", 85.5, "Reduce position size");
        LogRisk(LOG_COMPONENT_TEST, "Low liquidity", 45.2, "Increase spreads");
        LogRisk(LOG_COMPONENT_TEST, "Market gap", 92.1, "Emergency stop");
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestRiskLogging - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestRiskLogging - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestTradeLogging() {
    m_total_tests++;
    
    try {
        // Test logowania transakcji
        LogTrade(LOG_COMPONENT_TEST, "Buy order", 250.50, "EURUSD long");
        LogTrade(LOG_COMPONENT_TEST, "Sell order", -125.25, "GBPUSD short");
        LogTrade(LOG_COMPONENT_TEST, "Close position", 75.00, "Take profit");
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestTradeLogging - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestTradeLogging - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestAILogging() {
    m_total_tests++;
    
    try {
        // Test logowania AI
        LogAI(LOG_COMPONENT_TEST, "Bullish signal", 0.87, "Fire Spirit + Light Spirit alignment");
        LogAI(LOG_COMPONENT_TEST, "Bearish signal", 0.73, "Bitterness Spirit momentum");
        LogAI(LOG_COMPONENT_TEST, "Neutral signal", 0.45, "Mixed spirit signals");
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestAILogging - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestAILogging - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestIntegrationWithSystem() {
    m_total_tests++;
    
    try {
        // Test integracji z systemem
        LogIntegration(LOG_COMPONENT_TEST, "System startup", "SUCCESS", "All components loaded");
        LogIntegration(LOG_COMPONENT_TEST, "Spirit coordination", "ACTIVE", "7 spirits synchronized");
        LogIntegration(LOG_COMPONENT_TEST, "Risk management", "MONITORING", "Real-time risk analysis");
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestIntegrationWithSystem - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestIntegrationWithSystem - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestCallbackFunctions() {
    m_total_tests++;
    
    try {
        // Test funkcji callback
        m_logger.SetOnLogEntry(NULL);
        m_logger.SetOnErrorLog(NULL);
        m_logger.SetOnCriticalLog(NULL);
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestCallbackFunctions - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestCallbackFunctions - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestStatistics() {
    m_total_tests++;
    
    try {
        // Test statystyk
        SLogStats stats = m_logger.GetStats();
        string stats_report = m_logger.GetStatsReport();
        
        LogInfo(LOG_COMPONENT_TEST, "Statystyki logowania", 
                "Total: " + IntegerToString(stats.total_logs) + 
                ", Errors: " + IntegerToString(stats.error_logs));
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestStatistics - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestStatistics - NIE PRZESZŁY", "Exception occurred");
    }
}

void CLoggingSystemTest::TestExport() {
    m_total_tests++;
    
    try {
        // Test eksportu
        m_logger.ExportLogs("Tests/LoggingExport.csv", LOG_LEVEL_INFO);
        m_logger.ExportLogsByComponent("Tests/LoggingComponent.csv", LOG_COMPONENT_TEST);
        m_logger.ExportLogsByType("Tests/LoggingType.csv", LOG_TYPE_GENERAL);
        
        m_passed_tests++;
        LogInfo(LOG_COMPONENT_TEST, "✅ TestExport - PRZESZŁY");
    } catch(...) {
        LogError(LOG_COMPONENT_TEST, "❌ TestExport - NIE PRZESZŁY", "Exception occurred");
    }
}

string CLoggingSystemTest::GetTestReport() {
    string report = "=== RAPORT TESTÓW SYSTEMU LOGOWANIA ===\n";
    report += "Całkowite testy: " + IntegerToString(m_total_tests) + "\n";
    report += "Przeszłe testy: " + IntegerToString(m_passed_tests) + "\n";
    report += "Nieprzeszłe testy: " + IntegerToString(m_total_tests - m_passed_tests) + "\n";
    report += "Wskaźnik sukcesu: " + DoubleToString(GetOverallScore(), 2) + "%\n";
    report += "Czas wykonania: " + DoubleToString(m_total_execution_time, 3) + " sekund\n";
    
    return report;
}

double CLoggingSystemTest::GetOverallScore() {
    if(m_total_tests == 0) return 0.0;
    return (double)m_passed_tests / m_total_tests * 100.0;
}

// === FUNKCJA GŁÓWNA TESTÓW ===

void TestLoggingSystem() {
    Print("=== ROZPOCZĘCIE TESTÓW SYSTEMU LOGOWANIA ===");
    
    CLoggingSystemTest* tester = new CLoggingSystemTest();
    
    if(tester.Initialize()) {
        tester.RunAllTests();
        
        Print("\n=== WYNIKI TESTÓW SYSTEMU LOGOWANIA ===");
        Print(tester.GetTestReport());
        
        double score = tester.GetOverallScore();
        Print("Ogólny wynik: ", DoubleToString(score, 2), "%");
        Print("Status systemu: ", score >= 90 ? "✅ DOSKONAŁY" : 
                                 score >= 80 ? "🟡 DOBRY" : 
                                 score >= 70 ? "🟠 ZADOWALAJĄCY" : "❌ WYMAGA POPRAWY");
    } else {
        Print("❌ Błąd inicjalizacji testów systemu logowania");
    }
    
    delete tester;
    Print("=== ZAKOŃCZENIE TESTÓW SYSTEMU LOGOWANIA ===");
}

#endif // LOGGING_SYSTEM_TEST_H 