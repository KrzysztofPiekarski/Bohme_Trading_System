//+------------------------------------------------------------------+
//| Test Basic System - Podstawowe funkcje systemu                   |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "2.2.0"
#property description "Test podstawowych funkcji systemu"

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("🧪 Test Basic System - Inicjalizacja");
    
    // Test podstawowych funkcji
    TestBasicFunctions();
    
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("🧪 Test Basic System - Deinicjalizacja");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Prosty test
    static int counter = 0;
    counter++;
    
    if(counter % 100 == 0) {
        Print("🧪 Test Basic System - Tick: ", counter);
    }
}

//+------------------------------------------------------------------+
//| Test podstawowych funkcji                                        |
//+------------------------------------------------------------------+
void TestBasicFunctions() {
    Print("🔍 Test podstawowych funkcji...");
    
    // Test 1: Podstawowe operacje matematyczne
    double result1 = MathPow(2, 8);
    double result2 = MathSqrt(144);
    double result3 = MathMax(10, 20);
    
    Print("✅ MathPow(2,8) = ", result1);
    Print("✅ MathSqrt(144) = ", result2);
    Print("✅ MathMax(10,20) = ", result3);
    
    // Test 2: Operacje na stringach
    string symbol = _Symbol;
    string timeframe = EnumToString(_Period);
    
    Print("✅ Symbol: ", symbol);
    Print("✅ Timeframe: ", timeframe);
    
    // Test 3: Operacje czasowe
    datetime current_time = TimeCurrent();
    int hour = TimeHour(current_time);
    int minute = TimeMinute(current_time);
    
    Print("✅ Czas: ", TimeToString(current_time));
    Print("✅ Godzina: ", hour, ":", minute);
    
    // Test 4: Operacje na tablicach
    double prices[];
    ArrayResize(prices, 10);
    
    for(int i = 0; i < 10; i++) {
        prices[i] = MathRand() / 32767.0 * 100;
    }
    
    Print("✅ Tablica cen utworzona, rozmiar: ", ArraySize(prices));
    
    // Test 5: Podstawowe operacje tradingowe
    double bid = SymbolInfoDouble(_Symbol, SYMBOL_BID);
    double ask = SymbolInfoDouble(_Symbol, SYMBOL_ASK);
    double spread = ask - bid;
    
    Print("✅ Bid: ", bid);
    Print("✅ Ask: ", ask);
    Print("✅ Spread: ", spread);
    
    Print("🎉 Wszystkie podstawowe testy przeszły pomyślnie!");
}
