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
    double stop_loss;
    double take_profit;
    datetime execution_time;
    string comment;
};

enum ENUM_POSITION_STATE {
    POSITION_OPTIMAL,      // Pozycja optymalna
    POSITION_ACCEPTABLE,   // Pozycja akceptowalna
    POSITION_RISKY,        // Pozycja ryzykowna
    POSITION_CRITICAL      // Pozycja krytyczna
};

enum ENUM_EXECUTION_QUALITY {
    EXECUTION_POOR,        // Słaba jakość wykonania
    EXECUTION_FAIR,        // Umiarkowana jakość
    EXECUTION_GOOD,        // Dobra jakość
    EXECUTION_EXCELLENT,   // Doskonała jakość
    EXECUTION_PERFECT      // Idealna jakość
};

struct SPositionManagement {
    double current_risk;       // Aktualne ryzyko
    double max_risk;           // Maksymalne ryzyko
    double position_size;      // Rozmiar pozycji
    double unrealized_pnl;     // Nieskonsolidowany P&L
    ENUM_POSITION_STATE state; // Stan pozycji
    bool needs_adjustment;     // Czy potrzebuje dostosowania
};

struct SExecutionOptimization {
    double optimal_price;      // Optymalna cena wejścia
    double optimal_size;       // Optymalny rozmiar pozycji
    double stop_loss;          // Stop loss
    double take_profit;        // Take profit
    ENUM_EXECUTION_QUALITY quality; // Jakość wykonania
    string reason;             // Uzasadnienie
};


