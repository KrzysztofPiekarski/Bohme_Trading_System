// Test Runner dla Bohme Trading System
// Uruchamia wszystkie testy integracyjne

#property copyright "Bohme Trading System"
#property link      "https://github.com/bohme-trading"
#property version   "1.00"
#property strict

#include "IntegrationTests.mqh"

// Parametry testów
input bool   RunAllTests = true;           // Uruchom wszystkie testy
input bool   TestIndividualSpirits = true; // Test indywidualnych duchów
input bool   TestIntegration = true;       // Test integracji
input bool   TestPerformance = true;       // Test wydajności
input bool   GenerateReport = true;        // Generuj raport
input string ReportFileName = "BohmeTestReport.txt"; // Nazwa pliku raportu

// Globalne zmienne
CBohmeIntegrationTester* g_tester = NULL;
bool g_tests_completed = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("=== BOHME TRADING SYSTEM TEST RUNNER ===");
    Print("Version: 1.00");
    Print("Date: ", TimeToString(TimeCurrent()));
    Print("Symbol: ", Symbol());
    Print("Period: ", EnumToString(Period()));
    
    // Sprawdź czy wszystkie pliki duchów istnieją
    if(!CheckRequiredFiles()) {
        Print("❌ Required files missing. Tests cannot proceed.");
        return INIT_FAILED;
    }
    
    // Inicjalizacja testera
    g_tester = new CBohmeIntegrationTester();
    if(g_tester == NULL) {
        Print("❌ Failed to create integration tester");
        return INIT_FAILED;
    }
    
    Print("✅ Test runner initialized successfully");
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("=== BOHME TEST RUNNER DEINITIALIZATION ===");
    
    if(g_tester != NULL) {
        delete g_tester;
        g_tester = NULL;
    }
    
    Print("Test runner cleanup completed");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Uruchom testy tylko raz
    if(!g_tests_completed) {
        RunTests();
        g_tests_completed = true;
    }
}

//+------------------------------------------------------------------+
//| Uruchomienie testów                                              |
//+------------------------------------------------------------------+
void RunTests() {
    Print("=== STARTING BOHME SYSTEM TESTS ===");
    datetime start_time = TimeCurrent();
    
    if(g_tester == NULL) {
        Print("❌ Tester not initialized");
        return;
    }
    
    // Uruchom wszystkie testy
    if(RunAllTests) {
        g_tester.RunAllTests();
    }
    
    // Generuj raport
    if(GenerateReport) {
        GenerateTestReport();
    }
    
    // Wyświetl podsumowanie
    DisplayFinalSummary();
    
    double total_time = (double)(TimeCurrent() - start_time);
    Print("=== TESTS COMPLETED IN ", DoubleToString(total_time, 2), " SECONDS ===");
}

//+------------------------------------------------------------------+
//| Sprawdzenie wymaganych plików                                    |
//+------------------------------------------------------------------+
bool CheckRequiredFiles() {
    Print("Checking required files...");
    
    string required_files[] = {
        "Core/MasterConsciousness.mqh",
        "Spirits/BitternessSpirit.mqh",
        "Spirits/BodySpirit.mqh",
        "Spirits/FireSpirit.mqh",
        "Spirits/HerbeSpirit.mqh",
        "Spirits/LightSpirit.mqh",
        "Spirits/SoundSpirit.mqh",
        "Spirits/SweetnessSpirit.mqh"
    };
    
    for(int i = 0; i < ArraySize(required_files); i++) {
        if(!FileIsExist(required_files[i])) {
            Print("❌ Missing file: ", required_files[i]);
            return false;
        }
        Print("✅ Found: ", required_files[i]);
    }
    
    Print("All required files found");
    return true;
}

//+------------------------------------------------------------------+
//| Generowanie raportu testów                                       |
//+------------------------------------------------------------------+
void GenerateTestReport() {
    if(g_tester == NULL) return;
    
    Print("Generating test report...");
    
    string report = "";
    report += "=== BOHME TRADING SYSTEM TEST REPORT ===\n";
    report += "Date: " + TimeToString(TimeCurrent()) + "\n";
    report += "Symbol: " + Symbol() + "\n";
    report += "Period: " + EnumToString(Period()) + "\n\n";
    
    // Podsumowanie
    report += "SUMMARY:\n";
    report += "Total Tests: " + IntegerToString(g_tester.GetTotalTests()) + "\n";
    report += "Passed Tests: " + IntegerToString(g_tester.GetPassedTests()) + "\n";
    report += "Failed Tests: " + IntegerToString(g_tester.GetTotalTests() - g_tester.GetPassedTests()) + "\n";
    report += "Success Rate: " + DoubleToString(g_tester.GetOverallScore(), 2) + "%\n";
    report += "Average Execution Time: " + DoubleToString(g_tester.GetAverageExecutionTime(), 3) + " seconds\n\n";
    
    // Status systemu
    double score = g_tester.GetOverallScore();
    string system_status = "";
    if(score >= 90) system_status = "EXCELLENT";
    else if(score >= 80) system_status = "GOOD";
    else if(score >= 70) system_status = "ACCEPTABLE";
    else system_status = "NEEDS IMPROVEMENT";
    
    report += "SYSTEM STATUS: " + system_status + "\n\n";
    
    // Zapisz raport do pliku
    int file_handle = FileOpen(ReportFileName, FILE_WRITE | FILE_TXT);
    if(file_handle != INVALID_HANDLE) {
        FileWriteString(file_handle, report);
        FileClose(file_handle);
        Print("✅ Test report saved to: ", ReportFileName);
    }
    else {
        Print("❌ Failed to save test report");
    }
}

//+------------------------------------------------------------------+
//| Wyświetlenie podsumowania końcowego                              |
//+------------------------------------------------------------------+
void DisplayFinalSummary() {
    if(g_tester == NULL) return;
    
    Print("\n" + StringRepeat("=", 50));
    Print("🎯 FINAL TEST SUMMARY");
    Print(StringRepeat("=", 50));
    
    double score = g_tester.GetOverallScore();
    Print("Overall Score: ", DoubleToString(score, 2), "%");
    
    // Status systemu
    if(score >= 90) {
        Print("🏆 System Status: EXCELLENT");
        Print("✅ All components working perfectly");
        Print("🚀 Ready for live trading");
    }
    else if(score >= 80) {
        Print("✅ System Status: GOOD");
        Print("⚠️  Minor issues detected");
        Print("🔧 Ready for demo trading");
    }
    else if(score >= 70) {
        Print("⚠️  System Status: ACCEPTABLE");
        Print("🔧 Some issues need attention");
        Print("🧪 Requires further testing");
    }
    else {
        Print("❌ System Status: NEEDS IMPROVEMENT");
        Print("🚨 Critical issues detected");
        Print("🔧 System requires fixes before use");
    }
    
    Print("\nTest Details:");
    Print("- Total Tests: ", g_tester.GetTotalTests());
    Print("- Passed: ", g_tester.GetPassedTests());
    Print("- Failed: ", g_tester.GetTotalTests() - g_tester.GetPassedTests());
    Print("- Average Time: ", DoubleToString(g_tester.GetAverageExecutionTime(), 3), "s");
    
    Print(StringRepeat("=", 50));
}

//+------------------------------------------------------------------+
//| Helper function - powtórzenie stringa                            |
//+------------------------------------------------------------------+
string StringRepeat(string str, int count) {
    string result = "";
    for(int i = 0; i < count; i++) {
        result += str;
    }
    return result;
}

//+------------------------------------------------------------------+
//| Funkcja do ręcznego uruchomienia testów                          |
//+------------------------------------------------------------------+
void RunBohmeTests() {
    Print("=== MANUAL TEST EXECUTION ===");
    
    if(g_tester != NULL) {
        g_tester.RunAllTests();
        DisplayFinalSummary();
    }
    else {
        Print("❌ Tester not available");
    }
} 