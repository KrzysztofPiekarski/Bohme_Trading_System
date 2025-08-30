//+------------------------------------------------------------------+
//| Test Logging - Test funkcji logowania                            |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "2.2.0"
#property description "Test funkcji logowania systemu"

// Enumeracja komponentów logowania
enum ENUM_LOG_COMPONENT {
    LOG_COMPONENT_SYSTEM,      // System
    LOG_COMPONENT_HERBE,       // Herbe Spirit
    LOG_COMPONENT_SWEETNESS,   // Sweetness Spirit
    LOG_COMPONENT_BITTERNESS,  // Bitterness Spirit
    LOG_COMPONENT_FIRE,        // Fire Spirit
    LOG_COMPONENT_LIGHT,       // Light Spirit
    LOG_COMPONENT_SOUND,       // Sound Spirit
    LOG_COMPONENT_BODY,        // Body Spirit
    LOG_COMPONENT_MASTER,      // Master Consciousness
    LOG_COMPONENT_RISK,        // Risk Management
    LOG_COMPONENT_TRADE,       // Trading
    LOG_COMPONENT_AI,          // AI
    LOG_COMPONENT_DATA,        // Data
    LOG_COMPONENT_NEWS,        // News
    LOG_COMPONENT_SENTIMENT,   // Sentiment
    LOG_COMPONENT_ECONOMIC,    // Economic
    LOG_COMPONENT_EXECUTION,   // Execution
    LOG_COMPONENT_POSITION,    // Position
    LOG_COMPONENT_ORDER,       // Order
    LOG_COMPONENT_TEST         // Test
};

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("🧪 Test Logging - Inicjalizacja");
    
    // Test funkcji logowania
    TestLoggingFunctions();
    
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    Print("🧪 Test Logging - Deinicjalizacja");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    // Prosty test
    static int counter = 0;
    counter++;
    
    if(counter % 100 == 0) {
        Print("🧪 Test Logging - Tick: ", counter);
    }
}

//+------------------------------------------------------------------+
//| Test funkcji logowania                                           |
//+------------------------------------------------------------------+
void TestLoggingFunctions() {
    Print("🔍 Test funkcji logowania...");
    
    // Test 1: LogError
    LogError(LOG_COMPONENT_SYSTEM, "Test błędu", "To jest test błędu systemu");
    LogError(LOG_COMPONENT_AI, "Test błędu AI", "To jest test błędu AI");
    LogError(LOG_COMPONENT_TRADE, "Test błędu trading", "To jest test błędu trading");
    
    // Test 2: LogInfo
    LogInfo(LOG_COMPONENT_SYSTEM, "Test informacji", "To jest test informacji systemu");
    LogInfo(LOG_COMPONENT_AI, "Test informacji AI", "To jest test informacji AI");
    LogInfo(LOG_COMPONENT_TRADE, "Test informacji trading", "To jest test informacji trading");
    
    // Test 3: LogWarning
    LogWarning(LOG_COMPONENT_SYSTEM, "Test ostrzeżenia", "To jest test ostrzeżenia systemu");
    LogWarning(LOG_COMPONENT_AI, "Test ostrzeżenia AI", "To jest test ostrzeżenia AI");
    LogWarning(LOG_COMPONENT_TRADE, "Test ostrzeżenia trading", "To jest test ostrzeżenia trading");
    
    // Test 4: EnumToString
    string system_str = EnumToString(LOG_COMPONENT_SYSTEM);
    string ai_str = EnumToString(LOG_COMPONENT_AI);
    string trade_str = EnumToString(LOG_COMPONENT_TRADE);
    
    Print("✅ LOG_COMPONENT_SYSTEM = ", system_str);
    Print("✅ LOG_COMPONENT_AI = ", ai_str);
    Print("✅ LOG_COMPONENT_TRADE = ", trade_str);
    
    Print("🎉 Wszystkie testy logowania przeszły pomyślnie!");
}

//+------------------------------------------------------------------+
//| Funkcje logowania                                                |
//+------------------------------------------------------------------+
void LogError(ENUM_LOG_COMPONENT component, string message, string details) {
    Print("❌ [", EnumToString(component), "] ", message, ": ", details);
}

void LogInfo(ENUM_LOG_COMPONENT component, string message, string details) {
    Print("ℹ️ [", EnumToString(component), "] ", message, ": ", details);
}

void LogWarning(ENUM_LOG_COMPONENT component, string message, string details) {
    Print("⚠️ [", EnumToString(component), "] ", message, ": ", details);
}

//+------------------------------------------------------------------+
//| Helper function to convert log component enum to string         |
//+------------------------------------------------------------------+
string EnumToString(ENUM_LOG_COMPONENT component) {
    switch(component) {
        case LOG_COMPONENT_SYSTEM: return "SYSTEM";
        case LOG_COMPONENT_HERBE: return "HERBE";
        case LOG_COMPONENT_SWEETNESS: return "SWEETNESS";
        case LOG_COMPONENT_BITTERNESS: return "BITTERNESS";
        case LOG_COMPONENT_FIRE: return "FIRE";
        case LOG_COMPONENT_LIGHT: return "LIGHT";
        case LOG_COMPONENT_SOUND: return "SOUND";
        case LOG_COMPONENT_BODY: return "BODY";
        case LOG_COMPONENT_MASTER: return "MASTER";
        case LOG_COMPONENT_RISK: return "RISK";
        case LOG_COMPONENT_TRADE: return "TRADE";
        case LOG_COMPONENT_AI: return "AI";
        case LOG_COMPONENT_DATA: return "DATA";
        case LOG_COMPONENT_NEWS: return "NEWS";
        case LOG_COMPONENT_SENTIMENT: return "SENTIMENT";
        case LOG_COMPONENT_ECONOMIC: return "ECONOMIC";
        case LOG_COMPONENT_EXECUTION: return "EXECUTION";
        case LOG_COMPONENT_POSITION: return "POSITION";
        case LOG_COMPONENT_ORDER: return "ORDER";
        case LOG_COMPONENT_TEST: return "TEST";
        default: return "UNKNOWN";
    }
}
