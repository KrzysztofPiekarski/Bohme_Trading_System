// Wspólne typy handlowe używane przez różne moduły systemu

enum ENUM_TRADE_ACTION {
    ACTION_NONE,        // Brak akcji
    ACTION_BUY,         // Kupno
    ACTION_SELL,        // Sprzedaż
    ACTION_HOLD,        // Trzymanie
    ACTION_CLOSE        // Zamknięcie
};

struct STradeExecution {
    ENUM_TRADE_ACTION action;
    double price;
    double volume;
    datetime execution_time;
    string comment;
};


