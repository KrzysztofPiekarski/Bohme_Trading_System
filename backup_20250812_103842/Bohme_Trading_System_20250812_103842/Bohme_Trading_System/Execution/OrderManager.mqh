#ifndef ORDER_MANAGER_H
#define ORDER_MANAGER_H

// ========================================
// ORDER MANAGER - ZARZĄDZANIE ZLECENIAMI
// ========================================
// Zaawansowany system zarządzania zleceniami dla Systemu Böhmego
// Integruje zarządzanie pozycjami, zleceniami i ich cyklem życia

#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\OrderInfo.mqh>
#include <Trade\DealInfo.mqh>

// === ENUMERACJE ===

// Typy zleceń w systemie
enum ENUM_ORDER_TYPE_BOHME {
    ORDER_BOHME_MARKET,             // Zlecenie rynkowe
    ORDER_BOHME_LIMIT,              // Zlecenie limit
    ORDER_BOHME_STOP,               // Zlecenie stop
    ORDER_BOHME_STOP_LIMIT,         // Zlecenie stop limit
    ORDER_BOHME_TRAILING,           // Zlecenie trailing
    ORDER_BOHME_BREAKOUT,           // Zlecenie breakout
    ORDER_BOHME_MEAN_REVERSION,     // Zlecenie mean reversion
    ORDER_BOHME_SCALPING,           // Zlecenie skalpowania
    ORDER_BOHME_SWING,              // Zlecenie swing
    ORDER_BOHME_POSITION_SIZING,    // Zlecenie sizing pozycji
    ORDER_BOHME_RISK_MANAGEMENT,    // Zlecenie zarządzania ryzykiem
    ORDER_BOHME_SPIRIT_ALIGNED,     // Zlecenie zgodne z duchami
    ORDER_BOHME_SENTIMENT_DRIVEN,   // Zlecenie napędzane sentymentem
    ORDER_BOHME_EVENT_DRIVEN        // Zlecenie napędzane wydarzeniami
};

// Stany zleceń
enum ENUM_ORDER_STATE {
    ORDER_STATE_PENDING,            // Oczekujące
    ORDER_STATE_ACTIVE,             // Aktywne
    ORDER_STATE_PARTIAL,            // Częściowo wypełnione
    ORDER_STATE_FILLED,             // Wypełnione
    ORDER_STATE_CANCELLED,          // Anulowane
    ORDER_STATE_REJECTED,           // Odrzucone
    ORDER_STATE_MODIFIED,           // Zmodyfikowane
    ORDER_STATE_EXPIRED,            // Wygasłe
    ORDER_STATE_SUSPENDED           // Zawieszone
};

// Typy pozycji
enum ENUM_POSITION_TYPE {
    POSITION_TYPE_LONG,             // Pozycja długa
    POSITION_TYPE_SHORT,            // Pozycja krótka
    POSITION_TYPE_SCALP,            // Pozycja skalpowa
    POSITION_TYPE_SWING,            // Pozycja swingowa
    POSITION_TYPE_HEDGE,            // Pozycja hedgingowa
    POSITION_TYPE_ARBITRAGE,        // Pozycja arbitrażowa
    POSITION_TYPE_GRID,             // Pozycja grid
    POSITION_TYPE_MARTINGALE        // Pozycja martingale
};

// Priorytety zleceń
enum ENUM_ORDER_PRIORITY {
    PRIORITY_LOW,                   // Niski priorytet
    PRIORITY_NORMAL,                // Normalny priorytet
    PRIORITY_HIGH,                  // Wysoki priorytet
    PRIORITY_URGENT,                // Pilny priorytet
    PRIORITY_CRITICAL               // Krytyczny priorytet
};

// === STRUKTURY DANYCH ===

// Struktura zlecenia w systemie
struct SBohmeOrder {
    ulong ticket;                   // Ticket zlecenia
    string symbol;                  // Symbol
    ENUM_ORDER_TYPE_BOHME type;     // Typ zlecenia
    ENUM_ORDER_STATE state;         // Stan zlecenia
    ENUM_ORDER_PRIORITY priority;   // Priorytet
    double volume;                  // Wolumen
    double price;                   // Cena
    double stop_loss;               // Stop loss
    double take_profit;             // Take profit
    datetime open_time;             // Czas otwarcia
    datetime close_time;            // Czas zamknięcia
    string comment;                 // Komentarz
    double spirit_alignment;        // Zgodność z duchami
    double sentiment_score;         // Wynik sentymentu
    double confidence_level;        // Poziom pewności
    bool is_managed;                // Czy zarządzane
    bool is_hedged;                 // Czy hedgingowe
    string strategy_name;           // Nazwa strategii
    string spirit_signature;        // Podpis duchów
    double risk_reward_ratio;       // Stosunek ryzyko/nagroda
    double expected_profit;         // Oczekiwany zysk
    double max_risk;                // Maksymalne ryzyko
    string execution_algorithm;     // Algorytm wykonania
    string custom_data;             // Dane niestandardowe
};

// Struktura pozycji w systemie
struct SBohmePosition {
    ulong ticket;                   // Ticket pozycji
    string symbol;                  // Symbol
    ENUM_POSITION_TYPE type;        // Typ pozycji
    double volume;                  // Wolumen
    double open_price;              // Cena otwarcia
    double current_price;           // Aktualna cena
    double stop_loss;               // Stop loss
    double take_profit;             // Take profit
    datetime open_time;             // Czas otwarcia
    double unrealized_profit;       // Nierzeczywisty zysk
    double realized_profit;         // Rzeczywisty zysk
    double swap;                    // Swap
    double commission;              // Komisja
    double margin;                  // Margin
    double equity;                  // Equity
    double risk_reward_ratio;       // Stosunek ryzyko/nagroda
    double drawdown;                // Drawdown
    double max_drawdown;            // Maksymalny drawdown
    double profit_factor;           // Współczynnik zysku
    double sharpe_ratio;            // Współczynnik Sharpe
    string strategy_name;           // Nazwa strategii
    string spirit_signature;        // Podpis duchów
    double spirit_alignment;        // Zgodność z duchami
    double sentiment_score;         // Wynik sentymentu
    bool is_managed;                // Czy zarządzane
    bool is_hedged;                 // Czy hedgingowe
    string custom_data;             // Dane niestandardowe
};

// Struktura zarządzania ryzykiem
struct SRiskManagement {
    double max_position_size;       // Maksymalny rozmiar pozycji
    double max_daily_loss;          // Maksymalna dzienna strata
    double max_drawdown_limit;      // Limit drawdown
    double correlation_limit;       // Limit korelacji
    double exposure_limit;          // Limit ekspozycji
    double leverage_limit;          // Limit dźwigni
    double margin_requirement;      // Wymagany margin
    double risk_per_trade;          // Ryzyko na transakcję
    double total_risk;              // Całkowite ryzyko
    bool auto_hedge;                // Automatyczny hedging
    bool dynamic_sizing;            // Dynamiczny sizing
    bool position_scaling;          // Skalowanie pozycji
    string risk_strategy;           // Strategia ryzyka
    double risk_score;              // Wynik ryzyka
    string risk_warnings;           // Ostrzeżenia ryzyka
};

// Struktura statystyk
struct SOrderStatistics {
    int total_orders;               // Całkowita liczba zleceń
    int successful_orders;          // Pomyślne zlecenia
    int failed_orders;              // Nieudane zlecenia
    int cancelled_orders;           // Anulowane zlecenia
    double success_rate;            // Wskaźnik sukcesu
    double average_execution_time;  // Średni czas wykonania
    double average_slippage;        // Średni poślizg
    double total_commission;        // Całkowita komisja
    double total_profit;            // Całkowity zysk
    double total_loss;              // Całkowita strata
    double profit_factor;           // Współczynnik zysku
    double sharpe_ratio;            // Współczynnik Sharpe
    double max_drawdown;            // Maksymalny drawdown
    double win_rate;                // Wskaźnik wygranych
    double average_win;             // Średnia wygrana
    double average_loss;            // Średnia strata
    double largest_win;             // Największa wygrana
    double largest_loss;            // Największa strata
    int consecutive_wins;           // Kolejne wygrane
    int consecutive_losses;         // Kolejne straty
    datetime last_order_time;       // Czas ostatniego zlecenia
    string best_strategy;           // Najlepsza strategia
    string worst_strategy;          // Najgorsza strategia
};

// === KLASA ORDER MANAGER ===

class COrderManager {
private:
    // Handles do trading
    CTrade m_trade;
    CPositionInfo m_position;
    COrderInfo m_order;
    CDealInfo m_deal;
    
    // Parametry
    string m_symbol;
    ENUM_TIMEFRAMES m_timeframe;
    double m_point;
    int m_digits;
    double m_tick_size;
    double m_contract_size;
    
    // Zarządzanie zleceniami
    SBohmeOrder m_orders[];
    SBohmePosition m_positions[];
    SRiskManagement m_risk_management;
    SOrderStatistics m_statistics;
    
    // Cache
    datetime m_last_update;
    bool m_initialized;
    int m_max_orders;
    int m_max_positions;
    
    // Callback functions
    void (*m_on_order_created)(SBohmeOrder&);
    void (*m_on_order_filled)(SBohmeOrder&);
    void (*m_on_order_cancelled)(SBohmeOrder&);
    void (*m_on_position_opened)(SBohmePosition&);
    void (*m_on_position_closed)(SBohmePosition&);
    void (*m_on_risk_alert)(string);
    
public:
    // === KONSTRUKTOR I DESTRUKTOR ===
    COrderManager() {
        m_symbol = _Symbol;
        m_timeframe = PERIOD_CURRENT;
        m_initialized = false;
        m_last_update = 0;
        m_max_orders = 100;
        m_max_positions = 50;
        
        // Resetowanie callbacków
        m_on_order_created = NULL;
        m_on_order_filled = NULL;
        m_on_order_cancelled = NULL;
        m_on_position_opened = NULL;
        m_on_position_closed = NULL;
        m_on_risk_alert = NULL;
        
        // Inicjalizacja statystyk
        InitializeStatistics();
        
        // Inicjalizacja zarządzania ryzykiem
        InitializeRiskManagement();
    }
    
    ~COrderManager() {
        // Zwalnianie zasobów
        ArrayFree(m_orders);
        ArrayFree(m_positions);
    }
    
    // === INICJALIZACJA ===
    bool Initialize(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
        if(symbol != "") m_symbol = symbol;
        if(timeframe != PERIOD_CURRENT) m_timeframe = timeframe;
        
        Print("📋 Inicjalizacja Order Manager dla ", m_symbol);
        
        // Pobranie informacji o symbolu
        if(!GetSymbolInfo()) {
            Print("❌ Błąd pobierania informacji o symbolu");
            return false;
        }
        
        // Inicjalizacja handlu
        if(!InitializeTrading()) {
            Print("❌ Błąd inicjalizacji handlu");
            return false;
        }
        
        // Wczytanie istniejących zleceń i pozycji
        if(!LoadExistingOrders()) {
            Print("❌ Błąd wczytywania istniejących zleceń");
            return false;
        }
        
        if(!LoadExistingPositions()) {
            Print("❌ Błąd wczytywania istniejących pozycji");
            return false;
        }
        
        m_initialized = true;
        m_last_update = TimeCurrent();
        
        Print("✅ Order Manager zainicjalizowany");
        Print("📊 Zlecenia: ", ArraySize(m_orders), ", Pozycje: ", ArraySize(m_positions));
        
        return true;
    }
    
    // === INICJALIZACJA HANDLU ===
    bool InitializeTrading() {
        m_trade.SetExpertMagicNumber(123456);
        m_trade.SetDeviationInPoints(10);
        m_trade.SetTypeFilling(ORDER_FILLING_FOK);
        m_trade.SetMarginMode();
        m_trade.LogLevel(LOG_LEVEL_ALL);
        
        return true;
    }
    
    // === POBRANIE INFORMACJI O SYMBOLU ===
    bool GetSymbolInfo() {
        m_point = SymbolInfoDouble(m_symbol, SYMBOL_POINT);
        m_digits = (int)SymbolInfoInteger(m_symbol, SYMBOL_DIGITS);
        m_tick_size = SymbolInfoDouble(m_symbol, SYMBOL_TRADE_TICK_SIZE);
        m_contract_size = SymbolInfoDouble(m_symbol, SYMBOL_TRADE_CONTRACT_SIZE);
        
        if(m_point <= 0 || m_digits <= 0 || m_tick_size <= 0) {
            return false;
        }
        
        return true;
    }
    
    // === WCZYTANIE ISTNIEJĄCYCH ZLECEŃ ===
    bool LoadExistingOrders() {
        ArrayResize(m_orders, 0);
        
        for(int i = 0; i < OrdersTotal(); i++) {
            if(OrderSelect(OrderGetTicket(i))) {
                if(OrderGetString(ORDER_SYMBOL) == m_symbol) {
                    SBohmeOrder order;
                    if(ConvertToBohmeOrder(order)) {
                        ArrayResize(m_orders, ArraySize(m_orders) + 1);
                        m_orders[ArraySize(m_orders) - 1] = order;
                    }
                }
            }
        }
        
        return true;
    }
    
    // === WCZYTANIE ISTNIEJĄCYCH POZYCJI ===
    bool LoadExistingPositions() {
        ArrayResize(m_positions, 0);
        
        for(int i = 0; i < PositionsTotal(); i++) {
            if(PositionSelectByTicket(PositionGetTicket(i))) {
                if(PositionGetString(POSITION_SYMBOL) == m_symbol) {
                    SBohmePosition position;
                    if(ConvertToBohmePosition(position)) {
                        ArrayResize(m_positions, ArraySize(m_positions) + 1);
                        m_positions[ArraySize(m_positions) - 1] = position;
                    }
                }
            }
        }
        
        return true;
    }
    
    // === KONWERSJA ZLECENIA ===
    bool ConvertToBohmeOrder(SBohmeOrder &order) {
        order.ticket = OrderGetTicket(0);
        order.symbol = OrderGetString(ORDER_SYMBOL);
        order.type = (ENUM_ORDER_TYPE_BOHME)OrderGetInteger(ORDER_TYPE);
        order.state = (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE);
        order.priority = PRIORITY_NORMAL;
        order.volume = OrderGetDouble(ORDER_VOLUME_INITIAL);
        order.price = OrderGetDouble(ORDER_PRICE_OPEN);
        order.stop_loss = OrderGetDouble(ORDER_SL);
        order.take_profit = OrderGetDouble(ORDER_TP);
        order.open_time = (datetime)OrderGetInteger(ORDER_TIME_SETUP);
        order.close_time = 0;
        order.comment = OrderGetString(ORDER_COMMENT);
        order.spirit_alignment = 0;
        order.sentiment_score = 0;
        order.confidence_level = 0;
        order.is_managed = false;
        order.is_hedged = false;
        order.strategy_name = "";
        order.spirit_signature = "";
        order.risk_reward_ratio = 0;
        order.expected_profit = 0;
        order.max_risk = 0;
        order.execution_algorithm = "";
        order.custom_data = "";
        
        return true;
    }
    
    // === KONWERSJA POZYCJI ===
    bool ConvertToBohmePosition(SBohmePosition &position) {
        position.ticket = PositionGetTicket(0);
        position.symbol = PositionGetString(POSITION_SYMBOL);
        position.type = (ENUM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
        position.volume = PositionGetDouble(POSITION_VOLUME);
        position.open_price = PositionGetDouble(POSITION_PRICE_OPEN);
        position.current_price = PositionGetDouble(POSITION_PRICE_CURRENT);
        position.stop_loss = PositionGetDouble(POSITION_SL);
        position.take_profit = PositionGetDouble(POSITION_TP);
        position.open_time = (datetime)PositionGetInteger(POSITION_TIME);
        position.unrealized_profit = PositionGetDouble(POSITION_PROFIT);
        position.realized_profit = 0;
        position.swap = PositionGetDouble(POSITION_SWAP);
        position.commission = 0;
        position.margin = PositionGetDouble(POSITION_MARGIN);
        position.equity = 0;
        position.risk_reward_ratio = 0;
        position.drawdown = 0;
        position.max_drawdown = 0;
        position.profit_factor = 0;
        position.sharpe_ratio = 0;
        position.strategy_name = "";
        position.spirit_signature = "";
        position.spirit_alignment = 0;
        position.sentiment_score = 0;
        position.is_managed = false;
        position.is_hedged = false;
        position.custom_data = "";
        
        return true;
    }
    
    // === INICJALIZACJA STATYSTYK ===
    void InitializeStatistics() {
        m_statistics.total_orders = 0;
        m_statistics.successful_orders = 0;
        m_statistics.failed_orders = 0;
        m_statistics.cancelled_orders = 0;
        m_statistics.success_rate = 0;
        m_statistics.average_execution_time = 0;
        m_statistics.average_slippage = 0;
        m_statistics.total_commission = 0;
        m_statistics.total_profit = 0;
        m_statistics.total_loss = 0;
        m_statistics.profit_factor = 0;
        m_statistics.sharpe_ratio = 0;
        m_statistics.max_drawdown = 0;
        m_statistics.win_rate = 0;
        m_statistics.average_win = 0;
        m_statistics.average_loss = 0;
        m_statistics.largest_win = 0;
        m_statistics.largest_loss = 0;
        m_statistics.consecutive_wins = 0;
        m_statistics.consecutive_losses = 0;
        m_statistics.last_order_time = 0;
        m_statistics.best_strategy = "";
        m_statistics.worst_strategy = "";
    }
    
    // === INICJALIZACJA ZARZĄDZANIA RYZYKIEM ===
    void InitializeRiskManagement() {
        m_risk_management.max_position_size = 1.0;
        m_risk_management.max_daily_loss = 5.0;
        m_risk_management.max_drawdown_limit = 20.0;
        m_risk_management.correlation_limit = 0.7;
        m_risk_management.exposure_limit = 100.0;
        m_risk_management.leverage_limit = 100.0;
        m_risk_management.margin_requirement = 10.0;
        m_risk_management.risk_per_trade = 2.0;
        m_risk_management.total_risk = 0;
        m_risk_management.auto_hedge = false;
        m_risk_management.dynamic_sizing = true;
        m_risk_management.position_scaling = true;
        m_risk_management.risk_strategy = "CONSERVATIVE";
        m_risk_management.risk_score = 0;
        m_risk_management.risk_warnings = "";
    }
    
    // === TWORZENIE ZLECENIA ===
    ulong CreateOrder(ENUM_ORDER_TYPE_BOHME type, double volume, double price, 
                     double stop_loss = 0, double take_profit = 0, 
                     string comment = "", ENUM_ORDER_PRIORITY priority = PRIORITY_NORMAL) {
        
        if(!m_initialized) {
            Print("❌ Order Manager nie zainicjalizowany");
            return 0;
        }
        
        // Sprawdzenie ryzyka
        if(!CheckRiskLimits(volume, price)) {
            Print("❌ Przekroczono limity ryzyka");
            return 0;
        }
        
        // Tworzenie zlecenia
        SBohmeOrder order;
        order.ticket = 0;
        order.symbol = m_symbol;
        order.type = type;
        order.state = ORDER_STATE_PENDING;
        order.priority = priority;
        order.volume = volume;
        order.price = price;
        order.stop_loss = stop_loss;
        order.take_profit = take_profit;
        order.open_time = TimeCurrent();
        order.close_time = 0;
        order.comment = comment;
        order.spirit_alignment = 0;
        order.sentiment_score = 0;
        order.confidence_level = 0;
        order.is_managed = true;
        order.is_hedged = false;
        order.strategy_name = "";
        order.spirit_signature = "";
        order.risk_reward_ratio = CalculateRiskRewardRatio(price, stop_loss, take_profit);
        order.expected_profit = CalculateExpectedProfit(volume, price, stop_loss, take_profit);
        order.max_risk = CalculateMaxRisk(volume, price, stop_loss);
        order.execution_algorithm = "";
        order.custom_data = "";
        
        // Wykonanie zlecenia
        bool result = false;
        switch(type) {
            case ORDER_BOHME_MARKET:
                result = m_trade.Buy(volume, m_symbol, price);
                break;
            case ORDER_BOHME_LIMIT:
                result = m_trade.BuyLimit(volume, price, m_symbol);
                break;
            case ORDER_BOHME_STOP:
                result = m_trade.BuyStop(volume, price, m_symbol);
                break;
            default:
                result = m_trade.Buy(volume, m_symbol, price);
                break;
        }
        
        if(result) {
            order.ticket = m_trade.ResultOrder();
            
            // Dodanie do listy
            ArrayResize(m_orders, ArraySize(m_orders) + 1);
            m_orders[ArraySize(m_orders) - 1] = order;
            
            // Aktualizacja statystyk
            UpdateOrderStatistics(order, true);
            
            // Callback
            if(m_on_order_created != NULL) {
                m_on_order_created(order);
            }
            
            Print("✅ Zlecenie utworzone: ", order.ticket, " (", EnumToString(type), ")");
            return order.ticket;
        } else {
            Print("❌ Błąd tworzenia zlecenia: ", m_trade.ResultRetcodeDescription());
            return 0;
        }
    }
    
    // === SPRAWDZENIE LIMITÓW RYZYKA ===
    bool CheckRiskLimits(double volume, double price) {
        double account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
        double current_equity = AccountInfoDouble(ACCOUNT_EQUITY);
        double current_margin = AccountInfoDouble(ACCOUNT_MARGIN);
        
        // Sprawdzenie rozmiaru pozycji
        if(volume > m_risk_management.max_position_size) {
            Print("❌ Przekroczono maksymalny rozmiar pozycji");
            return false;
        }
        
        // Sprawdzenie dziennej straty
        double daily_loss = (account_balance - current_equity) / account_balance * 100;
        if(daily_loss > m_risk_management.max_daily_loss) {
            Print("❌ Przekroczono maksymalną dzienną stratę");
            return false;
        }
        
        // Sprawdzenie drawdown
        double drawdown = (account_balance - current_equity) / account_balance * 100;
        if(drawdown > m_risk_management.max_drawdown_limit) {
            Print("❌ Przekroczono limit drawdown");
            return false;
        }
        
        // Sprawdzenie marginesu
        double required_margin = volume * price / m_risk_management.leverage_limit;
        if(current_margin + required_margin > account_balance * m_risk_management.margin_requirement / 100) {
            Print("❌ Niewystarczający margines");
            return false;
        }
        
        return true;
    }
    
    // === OBLICZENIE STOSUNKU RYZYKO/NAGRODA ===
    double CalculateRiskRewardRatio(double price, double stop_loss, double take_profit) {
        if(stop_loss == 0 || take_profit == 0) return 0;
        
        double risk = MathAbs(price - stop_loss);
        double reward = MathAbs(take_profit - price);
        
        if(risk == 0) return 0;
        return reward / risk;
    }
    
    // === OBLICZENIE OCZEKIWANEGO ZYSKU ===
    double CalculateExpectedProfit(double volume, double price, double stop_loss, double take_profit) {
        if(stop_loss == 0 || take_profit == 0) return 0;
        
        double risk = MathAbs(price - stop_loss) * volume;
        double reward = MathAbs(take_profit - price) * volume;
        double risk_reward_ratio = CalculateRiskRewardRatio(price, stop_loss, take_profit);
        
        // Symulacja prawdopodobieństwa (50/50)
        return (reward * 0.5) - (risk * 0.5);
    }
    
    // === OBLICZENIE MAKSYMALNEGO RYZYKA ===
    double CalculateMaxRisk(double volume, double price, double stop_loss) {
        if(stop_loss == 0) return 0;
        return MathAbs(price - stop_loss) * volume;
    }
    
    // === AKTUALIZACJA STATYSTYK ZLECEŃ ===
    void UpdateOrderStatistics(SBohmeOrder &order, bool is_new) {
        if(is_new) {
            m_statistics.total_orders++;
            m_statistics.last_order_time = TimeCurrent();
        }
        
        // Aktualizacja wskaźnika sukcesu
        if(m_statistics.total_orders > 0) {
            m_statistics.success_rate = (double)m_statistics.successful_orders / m_statistics.total_orders * 100;
        }
    }
    
    // === ZAMKNIĘCIE ZLECENIA ===
    bool CloseOrder(ulong ticket, string reason = "") {
        if(!m_initialized) return false;
        
        // Znalezienie zlecenia
        int index = FindOrderByTicket(ticket);
        if(index == -1) {
            Print("❌ Zlecenie nie znalezione: ", ticket);
            return false;
        }
        
        SBohmeOrder &order = m_orders[index];
        
        // Anulowanie zlecenia
        if(m_trade.OrderDelete(ticket)) {
            order.state = ORDER_STATE_CANCELLED;
            order.close_time = TimeCurrent();
            order.comment += " | " + reason;
            
            // Aktualizacja statystyk
            m_statistics.cancelled_orders++;
            UpdateOrderStatistics(order, false);
            
            // Callback
            if(m_on_order_cancelled != NULL) {
                m_on_order_cancelled(order);
            }
            
            Print("✅ Zlecenie anulowane: ", ticket);
            return true;
        } else {
            Print("❌ Błąd anulowania zlecenia: ", m_trade.ResultRetcodeDescription());
            return false;
        }
    }
    
    // === ZNALEZIENIE ZLECENIA PO TICKET ===
    int FindOrderByTicket(ulong ticket) {
        for(int i = 0; i < ArraySize(m_orders); i++) {
            if(m_orders[i].ticket == ticket) {
                return i;
            }
        }
        return -1;
    }
    
    // === ZNALEZIENIE POZYCJI PO TICKET ===
    int FindPositionByTicket(ulong ticket) {
        for(int i = 0; i < ArraySize(m_positions); i++) {
            if(m_positions[i].ticket == ticket) {
                return i;
            }
        }
        return -1;
    }
    
    // === ZAMKNIĘCIE POZYCJI ===
    bool ClosePosition(ulong ticket, string reason = "") {
        if(!m_initialized) return false;
        
        // Znalezienie pozycji
        int index = FindPositionByTicket(ticket);
        if(index == -1) {
            Print("❌ Pozycja nie znaleziona: ", ticket);
            return false;
        }
        
        SBohmePosition &position = m_positions[index];
        
        // Zamknięcie pozycji
        if(m_trade.PositionClose(ticket)) {
            // Aktualizacja statystyk
            if(position.unrealized_profit > 0) {
                m_statistics.total_profit += position.unrealized_profit;
                m_statistics.largest_win = MathMax(m_statistics.largest_win, position.unrealized_profit);
                m_statistics.consecutive_wins++;
                m_statistics.consecutive_losses = 0;
            } else {
                m_statistics.total_loss += MathAbs(position.unrealized_profit);
                m_statistics.largest_loss = MathMax(m_statistics.largest_loss, MathAbs(position.unrealized_profit));
                m_statistics.consecutive_losses++;
                m_statistics.consecutive_wins = 0;
            }
            
            // Callback
            if(m_on_position_closed != NULL) {
                m_on_position_closed(position);
            }
            
            // Usunięcie z listy
            for(int i = index; i < ArraySize(m_positions) - 1; i++) {
                m_positions[i] = m_positions[i + 1];
            }
            ArrayResize(m_positions, ArraySize(m_positions) - 1);
            
            Print("✅ Pozycja zamknięta: ", ticket, " (", DoubleToString(position.unrealized_profit, 2), ")");
            return true;
        } else {
            Print("❌ Błąd zamykania pozycji: ", m_trade.ResultRetcodeDescription());
            return false;
        }
    }
    
    // === AKTUALIZACJA ===
    void Update() {
        if(!m_initialized) return;
        
        datetime current_time = TimeCurrent();
        
        // Aktualizacja co sekundę
        if(current_time - m_last_update >= 1) {
            m_last_update = current_time;
            
            // Aktualizacja zleceń
            UpdateOrders();
            
            // Aktualizacja pozycji
            UpdatePositions();
            
            // Sprawdzenie ryzyka
            CheckRiskAlerts();
            
            // Aktualizacja statystyk
            UpdateStatistics();
        }
    }
    
    // === AKTUALIZACJA ZLECEŃ ===
    void UpdateOrders() {
        for(int i = 0; i < ArraySize(m_orders); i++) {
            SBohmeOrder &order = m_orders[i];
            
            if(OrderSelect(order.ticket)) {
                ENUM_ORDER_STATE new_state = (ENUM_ORDER_STATE)OrderGetInteger(ORDER_STATE);
                
                if(new_state != order.state) {
                    order.state = new_state;
                    
                    if(new_state == ORDER_STATE_FILLED) {
                        // Zlecenie wypełnione
                        m_statistics.successful_orders++;
                        
                        if(m_on_order_filled != NULL) {
                            m_on_order_filled(order);
                        }
                    } else if(new_state == ORDER_STATE_REJECTED) {
                        // Zlecenie odrzucone
                        m_statistics.failed_orders++;
                    }
                    
                    UpdateOrderStatistics(order, false);
                }
            }
        }
    }
    
    // === AKTUALIZACJA POZYCJI ===
    void UpdatePositions() {
        for(int i = 0; i < ArraySize(m_positions); i++) {
            SBohmePosition &position = m_positions[i];
            
            if(PositionSelectByTicket(position.ticket)) {
                position.current_price = PositionGetDouble(POSITION_PRICE_CURRENT);
                position.unrealized_profit = PositionGetDouble(POSITION_PROFIT);
                position.swap = PositionGetDouble(POSITION_SWAP);
                position.margin = PositionGetDouble(POSITION_MARGIN);
                
                // Obliczenie drawdown
                if(position.unrealized_profit < 0) {
                    position.drawdown = MathAbs(position.unrealized_profit);
                    position.max_drawdown = MathMax(position.max_drawdown, position.drawdown);
                }
            }
        }
    }
    
    // === SPRAWDZENIE OSTRZEŻEŃ RYZYKA ===
    void CheckRiskAlerts() {
        double account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
        double current_equity = AccountInfoDouble(ACCOUNT_EQUITY);
        double drawdown = (account_balance - current_equity) / account_balance * 100;
        
        string warnings = "";
        
        if(drawdown > m_risk_management.max_drawdown_limit * 0.8) {
            warnings += "WYSOKI DRAWDOWN; ";
        }
        
        if(drawdown > m_risk_management.max_daily_loss * 0.8) {
            warnings += "WYSOKA DZIENNA STRATA; ";
        }
        
        if(ArraySize(m_positions) > 10) {
            warnings += "ZBYT WIELE POZYCJI; ";
        }
        
        if(warnings != "") {
            m_risk_management.risk_warnings = warnings;
            m_risk_management.risk_score = drawdown;
            
            if(m_on_risk_alert != NULL) {
                m_on_risk_alert(warnings);
            }
        }
    }
    
    // === AKTUALIZACJA STATYSTYK ===
    void UpdateStatistics() {
        if(m_statistics.total_orders > 0) {
            m_statistics.success_rate = (double)m_statistics.successful_orders / m_statistics.total_orders * 100;
        }
        
        if(m_statistics.total_loss > 0) {
            m_statistics.profit_factor = m_statistics.total_profit / m_statistics.total_loss;
        }
        
        // Obliczenie wskaźnika wygranych
        int total_closed = m_statistics.successful_orders + m_statistics.failed_orders;
        if(total_closed > 0) {
            m_statistics.win_rate = (double)m_statistics.successful_orders / total_closed * 100;
        }
    }
    
    // === FUNKCJE DOSTĘPU ===
    
    SBohmeOrder GetOrder(ulong ticket) {
        int index = FindOrderByTicket(ticket);
        if(index != -1) {
            return m_orders[index];
        }
        return SBohmeOrder{};
    }
    
    SBohmePosition GetPosition(ulong ticket) {
        int index = FindPositionByTicket(ticket);
        if(index != -1) {
            return m_positions[index];
        }
        return SBohmePosition{};
    }
    
    SBohmeOrder GetOrders()[] {
        return m_orders;
    }
    
    SBohmePosition GetPositions()[] {
        return m_positions;
    }
    
    SOrderStatistics GetStatistics() {
        return m_statistics;
    }
    
    SRiskManagement GetRiskManagement() {
        return m_risk_management;
    }
    
    void SetRiskManagement(SRiskManagement &risk) {
        m_risk_management = risk;
    }
    
    // === SETTERY CALLBACKÓW ===
    void SetOnOrderCreated(void (*callback)(SBohmeOrder&)) {
        m_on_order_created = callback;
    }
    
    void SetOnOrderFilled(void (*callback)(SBohmeOrder&)) {
        m_on_order_filled = callback;
    }
    
    void SetOnOrderCancelled(void (*callback)(SBohmeOrder&)) {
        m_on_order_cancelled = callback;
    }
    
    void SetOnPositionOpened(void (*callback)(SBohmePosition&)) {
        m_on_position_opened = callback;
    }
    
    void SetOnPositionClosed(void (*callback)(SBohmePosition&)) {
        m_on_position_closed = callback;
    }
    
    void SetOnRiskAlert(void (*callback)(string)) {
        m_on_risk_alert = callback;
    }
    
    // === FUNKCJE POMOCNICZE ===
    
    string GetOrderReport() {
        return GetStatusReport();
    }
    
    string GetStatusReport() {
        string report = "=== ORDER MANAGER STATUS ===\n";
        report += "Symbol: " + m_symbol + "\n";
        report += "Zlecenia aktywne: " + IntegerToString(ArraySize(m_orders)) + "\n";
        report += "Pozycje otwarte: " + IntegerToString(ArraySize(m_positions)) + "\n";
        report += "Całkowite zlecenia: " + IntegerToString(m_statistics.total_orders) + "\n";
        report += "Pomyślne zlecenia: " + IntegerToString(m_statistics.successful_orders) + "\n";
        report += "Wskaźnik sukcesu: " + DoubleToString(m_statistics.success_rate, 1) + "%\n";
        report += "Całkowity zysk: " + DoubleToString(m_statistics.total_profit, 2) + "\n";
        report += "Całkowita strata: " + DoubleToString(m_statistics.total_loss, 2) + "\n";
        report += "Współczynnik zysku: " + DoubleToString(m_statistics.profit_factor, 2) + "\n";
        report += "Wskaźnik wygranych: " + DoubleToString(m_statistics.win_rate, 1) + "%\n";
        report += "Maksymalny drawdown: " + DoubleToString(m_statistics.max_drawdown, 2) + "\n";
        report += "Wynik ryzyka: " + DoubleToString(m_risk_management.risk_score, 2) + "\n";
        report += "Ostrzeżenia: " + m_risk_management.risk_warnings + "\n";
        report += "Ostatnia aktualizacja: " + TimeToString(m_last_update) + "\n";
        report += "================================";
        
        return report;
    }
    
    string GetOrderTypeDescription(ENUM_ORDER_TYPE_BOHME type) {
        switch(type) {
            case ORDER_BOHME_MARKET: return "Zlecenie rynkowe";
            case ORDER_BOHME_LIMIT: return "Zlecenie limit";
            case ORDER_BOHME_STOP: return "Zlecenie stop";
            case ORDER_BOHME_STOP_LIMIT: return "Zlecenie stop limit";
            case ORDER_BOHME_TRAILING: return "Zlecenie trailing";
            case ORDER_BOHME_BREAKOUT: return "Zlecenie breakout";
            case ORDER_BOHME_MEAN_REVERSION: return "Zlecenie mean reversion";
            case ORDER_BOHME_SCALPING: return "Zlecenie skalpowania";
            case ORDER_BOHME_SWING: return "Zlecenie swing";
            case ORDER_BOHME_POSITION_SIZING: return "Zlecenie sizing pozycji";
            case ORDER_BOHME_RISK_MANAGEMENT: return "Zlecenie zarządzania ryzykiem";
            case ORDER_BOHME_SPIRIT_ALIGNED: return "Zlecenie zgodne z duchami";
            case ORDER_BOHME_SENTIMENT_DRIVEN: return "Zlecenie napędzane sentymentem";
            case ORDER_BOHME_EVENT_DRIVEN: return "Zlecenie napędzane wydarzeniami";
            default: return "Nieznany typ zlecenia";
        }
    }
};

// === GLOBALNA INSTANCJA ===
extern COrderManager* g_order_manager = NULL;

// === FUNKCJE GLOBALNE ===
bool InitializeGlobalOrderManager(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
    if(g_order_manager != NULL) delete g_order_manager;
    g_order_manager = new COrderManager();
    return g_order_manager.Initialize(symbol, timeframe);
}

void ReleaseGlobalOrderManager() {
    if(g_order_manager != NULL) {
        delete g_order_manager;
        g_order_manager = NULL;
    }
}

ulong CreateBohmeOrder(ENUM_ORDER_TYPE_BOHME type, double volume, double price, 
                      double stop_loss = 0, double take_profit = 0, 
                      string comment = "", ENUM_ORDER_PRIORITY priority = PRIORITY_NORMAL) {
    return g_order_manager != NULL ? g_order_manager.CreateOrder(type, volume, price, stop_loss, take_profit, comment, priority) : 0;
}

bool CloseBohmeOrder(ulong ticket, string reason = "") {
    return g_order_manager != NULL ? g_order_manager.CloseOrder(ticket, reason) : false;
}

bool CloseBohmePosition(ulong ticket, string reason = "") {
    return g_order_manager != NULL ? g_order_manager.ClosePosition(ticket, reason) : false;
}

SBohmeOrder GetBohmeOrder(ulong ticket) {
    return g_order_manager != NULL ? g_order_manager.GetOrder(ticket) : SBohmeOrder{};
}

SBohmePosition GetBohmePosition(ulong ticket) {
    return g_order_manager != NULL ? g_order_manager.GetPosition(ticket) : SBohmePosition{};
}

SOrderStatistics GetOrderManagerStatistics() {
    return g_order_manager != NULL ? g_order_manager.GetStatistics() : SOrderStatistics{};
}

string GetOrderManagerReport() {
    return g_order_manager != NULL ? g_order_manager.GetStatusReport() : "Order Manager nie zainicjalizowany";
}

#endif // ORDER_MANAGER_H
