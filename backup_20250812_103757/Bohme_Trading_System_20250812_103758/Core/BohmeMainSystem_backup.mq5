//+------------------------------------------------------------------+
//| BohmeSystemV1.mq5 - Podstawowa Implementacja                    |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "1.00"
#property description "System Siedmiu Duchów Rynku - Wersja Startowa"

// Includes
#include "Core/SystemConfig.mqh"
#include "Spirits/LightSpirit.mqh"
// #include "Spirits/BitternessSpirit.mqh"  // Dodaj w fazie 2
// #include "Spirits/FireSpirit.mqh"        // Dodaj w fazie 2

// Global variables
LightSpirit* g_light_spirit = NULL;
datetime g_last_analysis = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("🌟 Inicjalizacja Systemu Böhmego v1.0");
    
    // Initialize spirits
    g_light_spirit = new LightSpirit();
    if(!g_light_spirit.Initialize()) {
        Print("❌ Błąd inicjalizacji Light Spirit");
        return INIT_FAILED;
    }
    
    Print("✅ System Böhmego zainicjalizowany");
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    if(g_light_spirit != NULL) {
        delete g_light_spirit;
        g_light_spirit = NULL;
    }
    Print("🌙 System Böhmego zakończył pracę");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    datetime current_time = TimeCurrent();
    
    // Analyze every minute
    if(current_time - g_last_analysis >= 60) {
        g_last_analysis = current_time;
        AnalyzeMarket();
    }
}

//+------------------------------------------------------------------+
//| Market Analysis Function                                         |
//+------------------------------------------------------------------+
void AnalyzeMarket() {
    // Get signal from Light Spirit
    SSignalData signal = g_light_spirit.GetOptimalEntry();
    
    if(signal.quality >= SIGNAL_STRONG && signal.confidence > g_config.confidence_threshold) {
        Print("💡 Light Spirit sygnał: ", signal.description);
        Print("🎯 Confidence: ", signal.confidence, "%");
        
        // Execute trade (simplified for v1.0)
        if(signal.strength > 50) {
            ExecuteSimpleTrade(signal);
        }
    }
}

//+------------------------------------------------------------------+
//| Simple Trade Execution                                           |
//+------------------------------------------------------------------+
void ExecuteSimpleTrade(SSignalData& signal) {
    // Simplified execution for starter version
    double lot_size = 0.1; // Fixed for testing
    
    if(signal.strength > 75) { // Buy signal
        Print("📈 Executing BUY order");
        // Add your order execution code here
    }
    else if(signal.strength < 25) { // Sell signal  
        Print("📉 Executing SELL order");
        // Add your order execution code here
    }
}

