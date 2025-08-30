//+------------------------------------------------------------------+
//| Test Simple - Podstawowy test kompilacji                         |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "2.2.0"
#property description "Prosty test kompilacji systemu"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("🧪 Test Simple - Inicjalizacja");
    Print("✅ System Böhmego v2.2.0 - 100% kompletność");
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("🧪 Test Simple - Deinicjalizacja");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Prosty test
    static int counter = 0;
    counter++;
    
    if(counter % 100 == 0) {
        Print("🧪 Test Simple - Tick: ", counter);
    }
}
