// Backtest Runner dla Bohme Trading System
// Uruchamia backtesting z różnymi parametrami

#property copyright "Bohme Trading System"
#property link      "https://github.com/bohme-trading"
#property version   "1.00"
#property strict

#include "BacktestFramework.mqh"

// Parametry backtestingu
input string   Symbol = "EURUSD";           // Symbol do testowania
input ENUM_TIMEFRAMES Timeframe = PERIOD_H1; // Timeframe
input datetime StartDate = 0;               // Data rozpoczęcia (0 = automatyczna)
input datetime EndDate = 0;                 // Data zakończenia (0 = automatyczna)
input double   InitialBalance = 10000.0;    // Początkowe saldo
input double   Commission = 0.1;            // Prowizja (%)
input double   Swap = 0.0;                  // Swap
input double   Slippage = 0.0;              // Slippage
input bool     GenerateReport = true;       // Generuj raport
input bool     ExportToCSV = true;          // Eksportuj do CSV
input string   ReportFileName = "BohmeBacktestReport.txt"; // Nazwa pliku raportu

// Parametry optymalizacji
input bool     RunOptimization = false;     // Uruchom optymalizację
input string   OptimizeParameter = "RiskPercent"; // Parametr do optymalizacji
input double   MinValue = 1.0;              // Minimalna wartość
input double   MaxValue = 5.0;              // Maksymalna wartość
input double   Step = 0.5;                  // Krok optymalizacji
input int      OptimizationCriterion = 0;   // Kryterium (0=Profit, 1=Sharpe, 2=Calmar)

// Globalne zmienne
CBohmeBacktester* g_backtester = NULL;
bool g_backtest_completed = false;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("=== BOHME BACKTEST RUNNER ===");
    Print("Version: 1.00");
    Print("Date: ", TimeToString(TimeCurrent()));
    Print("Symbol: ", Symbol);
    Print("Timeframe: ", EnumToString(Timeframe));
    
    // Sprawdź czy wszystkie pliki istnieją
    if(!CheckRequiredFiles()) {
        Print("❌ Required files missing. Backtest cannot proceed.");
        return INIT_FAILED;
    }
    
    // Inicjalizacja backtestera
    g_backtester = new CBohmeBacktester();
    if(g_backtester == NULL) {
        Print("❌ Failed to create backtester");
        return INIT_FAILED;
    }
    
    Print("✅ Backtest runner initialized successfully");
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("=== BOHME BACKTEST RUNNER DEINITIALIZATION ===");
    
    if(g_backtester != NULL) {
        delete g_backtester;
        g_backtester = NULL;
    }
    
    Print("Backtest runner cleanup completed");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Uruchom backtesting tylko raz
    if(!g_backtest_completed) {
        RunBacktest();
        g_backtest_completed = true;
    }
}

//+------------------------------------------------------------------+
//| Uruchomienie backtestingu                                        |
//+------------------------------------------------------------------+
void RunBacktest() {
    Print("=== STARTING BOHME BACKTEST ===");
    datetime start_time = TimeCurrent();
    
    if(g_backtester == NULL) {
        Print("❌ Backtester not initialized");
        return;
    }
    
    // Ustaw daty jeśli nie podano
    datetime start_date = StartDate;
    datetime end_date = EndDate;
    
    if(start_date == 0) {
        start_date = StringToTime("2023.01.01");
        Print("Using default start date: ", TimeToString(start_date));
    }
    
    if(end_date == 0) {
        end_date = StringToTime("2023.12.31");
        Print("Using default end date: ", TimeToString(end_date));
    }
    
    // Ustaw parametry backtestingu
    g_backtester.SetParameters(Symbol, Timeframe, start_date, end_date,
                              InitialBalance, Commission, Swap, Slippage);
    
    SBacktestResult result;
    
    if(RunOptimization) {
        Print("Running optimization for parameter: ", OptimizeParameter);
        result = g_backtester.RunOptimization(OptimizeParameter, MinValue, MaxValue, 
                                             Step, OptimizationCriterion);
    } else {
        Print("Running standard backtest");
        result = g_backtester.RunBacktest();
    }
    
    // Wyświetl wyniki
    g_backtester.PrintBacktestSummary(result);
    
    // Generuj raport
    if(GenerateReport) {
        string report_filename = ReportFileName;
        if(RunOptimization) {
            report_filename = "Optimization_" + OptimizeParameter + "_" + report_filename;
        }
        g_backtester.GenerateBacktestReport(result, report_filename);
    }
    
    // Eksportuj do CSV
    if(ExportToCSV) {
        string csv_filename = "BohmeBacktest_" + Symbol + "_" + TimeToString(TimeCurrent()) + ".csv";
        g_backtester.ExportResultsToCSV(result, csv_filename);
    }
    
    // Wyświetl podsumowanie końcowe
    DisplayFinalSummary(result);
    
    double total_time = (double)(TimeCurrent() - start_time);
    Print("=== BACKTEST COMPLETED IN ", DoubleToString(total_time, 2), " SECONDS ===");
}

//+------------------------------------------------------------------+
//| Sprawdzenie wymaganych plików                                    |
//+------------------------------------------------------------------+
bool CheckRequiredFiles() {
    Print("Checking required files...");
    
    string required_files[] = {
        "Core/MasterConsciousness.mqh",
        "Core/SystemConfig.mqh",
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
//| Wyświetlenie podsumowania końcowego                              |
//+------------------------------------------------------------------+
void DisplayFinalSummary(SBacktestResult& result) {
    Print("\n" + StringRepeat("=", 60));
    Print("🎯 FINAL BACKTEST SUMMARY");
    Print(StringRepeat("=", 60));
    
    Print("📊 Key Metrics:");
    Print("  Net Profit: ", DoubleToString(result.net_profit, 2));
    Print("  Win Rate: ", DoubleToString(result.win_rate, 2), "%");
    Print("  Profit Factor: ", DoubleToString(result.profit_factor, 2));
    Print("  Max Drawdown: ", DoubleToString(result.max_drawdown, 2), "%");
    Print("  Sharpe Ratio: ", DoubleToString(result.sharpe_ratio, 2));
    
    // Ocena systemu
    Print("\n🏆 System Assessment:");
    if(result.win_rate >= 60 && result.profit_factor >= 1.5 && result.max_drawdown < 20) {
        Print("  🏆 EXCELLENT - System ready for live trading");
        Print("  ✅ High win rate, good profit factor, low drawdown");
        Print("  🚀 Recommended for live account");
    }
    else if(result.win_rate >= 50 && result.profit_factor >= 1.2 && result.max_drawdown < 30) {
        Print("  ✅ GOOD - System ready for demo trading");
        Print("  ⚠️  Moderate performance, acceptable risk");
        Print("  🔧 Consider optimization before live trading");
    }
    else if(result.win_rate >= 40 && result.profit_factor >= 1.0 && result.max_drawdown < 40) {
        Print("  ⚠️  ACCEPTABLE - System needs optimization");
        Print("  🔧 Performance below optimal levels");
        Print("  📈 Requires parameter tuning and testing");
    }
    else {
        Print("  ❌ NEEDS IMPROVEMENT - System requires significant changes");
        Print("  🚨 Performance issues detected");
        Print("  🔧 Major optimization required before use");
    }
    
    // Rekomendacje
    Print("\n💡 Recommendations:");
    if(result.win_rate < 50) {
        Print("  📈 Improve win rate by adjusting entry/exit criteria");
    }
    if(result.profit_factor < 1.2) {
        Print("  💰 Optimize risk/reward ratio and position sizing");
    }
    if(result.max_drawdown > 30) {
        Print("  ⚠️  Reduce risk per trade and improve stop loss management");
    }
    if(result.sharpe_ratio < 1.0) {
        Print("  📊 Improve consistency and reduce volatility of returns");
    }
    
    Print(StringRepeat("=", 60));
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
//| Funkcja do ręcznego uruchomienia backtestingu                    |
//+------------------------------------------------------------------+
void RunBohmeBacktest() {
    Print("=== MANUAL BACKTEST EXECUTION ===");
    
    if(g_backtester != NULL) {
        // Ustaw parametry
        datetime start_date = StartDate == 0 ? StringToTime("2023.01.01") : StartDate;
        datetime end_date = EndDate == 0 ? StringToTime("2023.12.31") : EndDate;
        
        g_backtester.SetParameters(Symbol, Timeframe, start_date, end_date,
                                  InitialBalance, Commission, Swap, Slippage);
        
        // Uruchom backtesting
        SBacktestResult result = g_backtester.RunBacktest();
        
        // Wyświetl wyniki
        g_backtester.PrintBacktestSummary(result);
        
        // Generuj raport
        if(GenerateReport) {
            string report_filename = "ManualBacktest_" + Symbol + "_" + TimeToString(TimeCurrent()) + ".txt";
            g_backtester.GenerateBacktestReport(result, report_filename);
        }
    }
    else {
        Print("❌ Backtester not available");
    }
}

//+------------------------------------------------------------------+
//| Funkcja do uruchomienia optymalizacji                            |
//+------------------------------------------------------------------+
void RunBohmeOptimization() {
    Print("=== MANUAL OPTIMIZATION EXECUTION ===");
    
    if(g_backtester != NULL) {
        Print("Optimizing parameter: ", OptimizeParameter);
        Print("Range: ", DoubleToString(MinValue, 2), " to ", DoubleToString(MaxValue, 2));
        Print("Step: ", DoubleToString(Step, 2));
        
        SBacktestResult result = g_backtester.RunOptimization(OptimizeParameter, MinValue, MaxValue, 
                                                             Step, OptimizationCriterion);
        
        // Wyświetl wyniki optymalizacji
        g_backtester.PrintBacktestSummary(result);
        
        // Generuj raport optymalizacji
        if(GenerateReport) {
            string report_filename = "Optimization_" + OptimizeParameter + "_" + TimeToString(TimeCurrent()) + ".txt";
            g_backtester.GenerateBacktestReport(result, report_filename);
        }
    }
    else {
        Print("❌ Backtester not available");
    }
}

//+------------------------------------------------------------------+
//| Funkcja do porównania różnych parametrów                         |
//+------------------------------------------------------------------+
void CompareParameters() {
    Print("=== PARAMETER COMPARISON ===");
    
    if(g_backtester == NULL) {
        Print("❌ Backtester not available");
        return;
    }
    
    // Lista parametrów do porównania
    string parameters[] = {"RiskPercent", "MaxPositions", "BitternessWeight", "LightWeight"};
    double values[][2] = {{1.0, 3.0}, {3, 7}, {0.1, 0.2}, {0.15, 0.25}};
    
    for(int i = 0; i < ArraySize(parameters); i++) {
        Print("Testing parameter: ", parameters[i]);
        
        // Test z wartością niską
        SBacktestResult result_low = g_backtester.RunOptimization(parameters[i], values[i][0], values[i][0], 0.1, 0);
        
        // Test z wartością wysoką
        SBacktestResult result_high = g_backtester.RunOptimization(parameters[i], values[i][1], values[i][1], 0.1, 0);
        
        Print("  Low value (", DoubleToString(values[i][0], 2), "): Profit = ", DoubleToString(result_low.net_profit, 2));
        Print("  High value (", DoubleToString(values[i][1], 2), "): Profit = ", DoubleToString(result_high.net_profit, 2));
        
        if(result_low.net_profit > result_high.net_profit) {
            Print("  ✅ Lower value performs better");
        } else {
            Print("  ✅ Higher value performs better");
        }
        Print("");
    }
} 