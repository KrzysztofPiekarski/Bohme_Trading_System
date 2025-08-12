#ifndef EXECUTION_ALGORITHMS_H
#define EXECUTION_ALGORITHMS_H

// ========================================
// EXECUTION ALGORITHMS - ALGORYTMY WYKONANIA
// ========================================
// Zaawansowane algorytmy wykonania transakcji dla Systemu Böhmego
// Integruje decyzje duchów z optymalnym wykonaniem na rynku

#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\OrderInfo.mqh>

// === ENUMERACJE ===

// Typy algorytmów wykonania
enum ENUM_EXECUTION_ALGORITHM {
    ALGO_MARKET_ORDER,             // Zlecenie rynkowe
    ALGO_LIMIT_ORDER,              // Zlecenie limit
    ALGO_STOP_ORDER,               // Zlecenie stop
    ALGO_TWAP,                     // Time Weighted Average Price
    ALGO_VWAP,                     // Volume Weighted Average Price
    ALGO_ICEBERG,                  // Zlecenie góra lodowa
    ALGO_SMART_ROUTING,            // Inteligentne kierowanie
    ALGO_ADAPTIVE,                 // Algorytm adaptacyjny
    ALGO_SPIRIT_DRIVEN,            // Napędzany duchami
    ALGO_SENTIMENT_AWARE,          // Świadomy sentymentu
    ALGO_EVENT_DRIVEN,             // Napędzany wydarzeniami
    ALGO_MOMENTUM_BASED,           // Oparty na momentum
    ALGO_MEAN_REVERSION,           // Powrót do średniej
    ALGO_BREAKOUT,                 // Breakout
    ALGO_SCALPING,                 // Skalpowanie
    ALGO_SWING_TRADING,            // Swing trading
    ALGO_POSITION_SIZING,          // Sizing pozycji
    ALGO_RISK_MANAGEMENT           // Zarządzanie ryzykiem
};

// Stany wykonania
enum ENUM_EXECUTION_STATE {
    EXECUTION_PENDING,             // Oczekujące
    EXECUTION_ACTIVE,              // Aktywne
    EXECUTION_PARTIAL,             // Częściowe
    EXECUTION_COMPLETED,           // Zakończone
    EXECUTION_CANCELLED,           // Anulowane
    EXECUTION_REJECTED,            // Odrzucone
    EXECUTION_MODIFIED,            // Zmodyfikowane
    EXECUTION_SUSPENDED            // Zawieszone
};

// Typy optymalizacji
enum ENUM_OPTIMIZATION_TYPE {
    OPTIMIZE_SPEED,                // Optymalizacja szybkości
    OPTIMIZE_COST,                 // Optymalizacja kosztów
    OPTIMIZE_IMPACT,               // Optymalizacja wpływu
    OPTIMIZE_FILL_RATE,            // Optymalizacja wypełnienia
    OPTIMIZE_RISK,                 // Optymalizacja ryzyka
    OPTIMIZE_SPIRIT_ALIGNMENT,     // Optymalizacja zgodności duchów
    OPTIMIZE_SENTIMENT,            // Optymalizacja sentymentu
    OPTIMIZE_MARKET_CONDITIONS     // Optymalizacja warunków rynkowych
};

// === STRUKTURY DANYCH ===

// Struktura parametrów wykonania
struct ExecutionParameters {
    ENUM_EXECUTION_ALGORITHM algorithm;    // Algorytm wykonania
    ENUM_OPTIMIZATION_TYPE optimization;   // Typ optymalizacji
    double order_size;                     // Rozmiar zlecenia
    double max_order_size;                 // Maksymalny rozmiar
    double min_order_size;                 // Minimalny rozmiar
    double price_limit;                    // Limit ceny
    double time_limit;                     // Limit czasowy (sekundy)
    double urgency_level;                  // Poziom pilności (0-1)
    double cost_sensitivity;               // Wrażliwość na koszty (0-1)
    double impact_sensitivity;             // Wrażliwość na wpływ (0-1)
    bool allow_partial_fills;              // Pozwól na częściowe wypełnienia
    bool use_smart_routing;                // Użyj inteligentnego kierowania
    bool adapt_to_volatility;              // Dostosuj do zmienności
    bool respect_spirit_alignment;         // Szanuj zgodność duchów
    bool consider_sentiment;               // Uwzględnij sentyment
    bool check_events;                     // Sprawdź wydarzenia
    int max_retries;                       // Maksymalna liczba prób
    double retry_delay;                    // Opóźnienie między próbami
    string custom_parameters;              // Parametry niestandardowe
};

// Struktura wyniku wykonania
struct ExecutionResult {
    bool success;                          // Czy sukces
    ulong order_ticket;                    // Ticket zlecenia
    double executed_volume;                // Wykonany wolumen
    double average_price;                  // Średnia cena
    double total_cost;                     // Całkowity koszt
    double market_impact;                  // Wpływ na rynek
    double slippage;                       // Poślizg
    int fill_count;                        // Liczba wypełnień
    datetime start_time;                   // Czas rozpoczęcia
    datetime end_time;                     // Czas zakończenia
    ENUM_EXECUTION_STATE state;            // Stan wykonania
    string error_message;                  // Komunikat błędu
    double spirit_alignment_score;         // Wynik zgodności duchów
    double sentiment_score;                // Wynik sentymentu
    double execution_quality;              // Jakość wykonania (0-1)
    string execution_log;                  // Log wykonania
};

// Struktura analizy rynku
struct MarketAnalysis {
    double current_volatility;             // Aktualna zmienność
    double average_volume;                 // Średni wolumen
    double bid_ask_spread;                 // Spread bid-ask
    double market_depth;                   // Głębokość rynku
    double order_flow;                     // Przepływ zleceń
    double price_momentum;                 // Momentum ceny
    double volume_profile;                 // Profil wolumenu
    bool is_liquid;                        // Czy płynny
    bool is_volatile;                      // Czy zmienny
    bool is_trending;                      // Czy trendujący
    string market_condition;               // Stan rynku
    datetime analysis_time;                // Czas analizy
};

// Struktura optymalizacji
struct OptimizationResult {
    double optimal_order_size;             // Optymalny rozmiar zlecenia
    double optimal_price;                  // Optymalna cena
    double optimal_timing;                 // Optymalny czas
    double expected_cost;                  // Oczekiwany koszt
    double expected_impact;                // Oczekiwany wpływ
    double success_probability;            // Prawdopodobieństwo sukcesu
    string optimization_reason;            // Powód optymalizacji
    double confidence_level;               // Poziom pewności
    datetime calculation_time;             // Czas obliczenia
};

// === KLASA EXECUTION ALGORITHMS ===

class CExecutionAlgorithms {
private:
    // Handles do trading
    CTrade m_trade;
    CPositionInfo m_position;
    COrderInfo m_order;
    
    // Parametry
    string m_symbol;
    ENUM_TIMEFRAMES m_timeframe;
    double m_point;
    int m_digits;
    double m_tick_size;
    double m_contract_size;
    
    // Statystyki
    int m_total_executions;
    int m_successful_executions;
    double m_average_execution_time;
    double m_average_slippage;
    double m_total_cost;
    
    // Cache
    MarketAnalysis m_market_analysis;
    ExecutionParameters m_default_params;
    datetime m_last_analysis;
    
public:
    // === KONSTRUKTOR I DESTRUKTOR ===
    CExecutionAlgorithms() {
        m_symbol = _Symbol;
        m_timeframe = PERIOD_CURRENT;
        
        m_total_executions = 0;
        m_successful_executions = 0;
        m_average_execution_time = 0;
        m_average_slippage = 0;
        m_total_cost = 0;
        
        m_last_analysis = 0;
        
        // Inicjalizacja parametrów domyślnych
        InitializeDefaultParameters();
    }
    
    ~CExecutionAlgorithms() {
        // Zwalnianie zasobów
    }
    
    // === INICJALIZACJA ===
    bool Initialize(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
        if(symbol != "") m_symbol = symbol;
        if(timeframe != PERIOD_CURRENT) m_timeframe = timeframe;
        
        Print("⚡ Inicjalizacja Execution Algorithms dla ", m_symbol);
        
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
        
        // Analiza rynku
        if(!AnalyzeMarket()) {
            Print("❌ Błąd analizy rynku");
            return false;
        }
        
        Print("✅ Execution Algorithms zainicjalizowany");
        return true;
    }
    
    // === INICJALIZACJA PARAMETRÓW DOMYŚLNYCH ===
    void InitializeDefaultParameters() {
        m_default_params.algorithm = ALGO_SMART_ROUTING;
        m_default_params.optimization = OPTIMIZE_COST;
        m_default_params.order_size = 0.1;
        m_default_params.max_order_size = 1.0;
        m_default_params.min_order_size = 0.01;
        m_default_params.price_limit = 0;
        m_default_params.time_limit = 60;
        m_default_params.urgency_level = 0.5;
        m_default_params.cost_sensitivity = 0.7;
        m_default_params.impact_sensitivity = 0.5;
        m_default_params.allow_partial_fills = true;
        m_default_params.use_smart_routing = true;
        m_default_params.adapt_to_volatility = true;
        m_default_params.respect_spirit_alignment = true;
        m_default_params.consider_sentiment = true;
        m_default_params.check_events = true;
        m_default_params.max_retries = 3;
        m_default_params.retry_delay = 1.0;
        m_default_params.custom_parameters = "";
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
    
    // === INICJALIZACJA HANDLU ===
    bool InitializeTrading() {
        m_trade.SetExpertMagicNumber(123456);
        m_trade.SetDeviationInPoints(10);
        m_trade.SetTypeFilling(ORDER_FILLING_FOK);
        m_trade.SetMarginMode();
        m_trade.LogLevel(LOG_LEVEL_ALL);
        
        return true;
    }
    
    // === ANALIZA RYNKU ===
    bool AnalyzeMarket() {
        MqlTick tick;
        if(!SymbolInfoTick(m_symbol, tick)) return false;
        
        m_market_analysis.bid_ask_spread = tick.ask - tick.bid;
        m_market_analysis.current_volatility = CalculateVolatility();
        m_market_analysis.average_volume = CalculateAverageVolume();
        m_market_analysis.market_depth = EstimateMarketDepth();
        m_market_analysis.order_flow = AnalyzeOrderFlow();
        m_market_analysis.price_momentum = CalculatePriceMomentum();
        m_market_analysis.volume_profile = AnalyzeVolumeProfile();
        
        // Określenie stanu rynku
        m_market_analysis.is_liquid = m_market_analysis.average_volume > 1000000;
        m_market_analysis.is_volatile = m_market_analysis.current_volatility > 0.5;
        m_market_analysis.is_trending = MathAbs(m_market_analysis.price_momentum) > 0.3;
        
        if(m_market_analysis.is_liquid && !m_market_analysis.is_volatile) {
            m_market_analysis.market_condition = "STABLE";
        } else if(m_market_analysis.is_volatile && m_market_analysis.is_trending) {
            m_market_analysis.market_condition = "TRENDING";
        } else if(m_market_analysis.is_volatile && !m_market_analysis.is_trending) {
            m_market_analysis.market_condition = "VOLATILE";
        } else {
            m_market_analysis.market_condition = "UNSTABLE";
        }
        
        m_market_analysis.analysis_time = TimeCurrent();
        return true;
    }
    
    // === FUNKCJE ANALIZY RYNKU ===
    
    double CalculateVolatility() {
        double close[];
        ArraySetAsSeries(close, true);
        
        if(CopyClose(m_symbol, m_timeframe, 0, 20, close) != 20) return 0;
        
        double sum = 0;
        for(int i = 1; i < 20; i++) {
            sum += MathAbs(close[i-1] - close[i]);
        }
        
        return sum / 19 / m_point;
    }
    
    double CalculateAverageVolume() {
        long volume[];
        ArraySetAsSeries(volume, true);
        
        if(CopyTickVolume(m_symbol, m_timeframe, 0, 20, volume) != 20) return 0;
        
        double sum = 0;
        for(int i = 0; i < 20; i++) {
            sum += volume[i];
        }
        
        return sum / 20;
    }
    
    double EstimateMarketDepth() {
        // Symulacja głębokości rynku
        return 1000000 + (MathRand() % 5000000);
    }
    
    double AnalyzeOrderFlow() {
        // Symulacja przepływu zleceń
        return (MathRand() % 200 - 100) / 100.0;
    }
    
    double CalculatePriceMomentum() {
        double close[];
        ArraySetAsSeries(close, true);
        
        if(CopyClose(m_symbol, m_timeframe, 0, 10, close) != 10) return 0;
        
        return (close[0] - close[9]) / close[9] * 100;
    }
    
    double AnalyzeVolumeProfile() {
        // Symulacja profilu wolumenu
        return 0.5 + (MathRand() % 50) / 100.0;
    }
    
    // === OPTYMALIZACJA WYKONANIA ===
    OptimizationResult OptimizeExecution(ExecutionParameters &params, double target_price, ENUM_ORDER_TYPE order_type) {
        OptimizationResult result;
        
        // Resetowanie wyników
        result.optimal_order_size = params.order_size;
        result.optimal_price = target_price;
        result.optimal_timing = 0;
        result.expected_cost = 0;
        result.expected_impact = 0;
        result.success_probability = 0.8;
        result.confidence_level = 0.7;
        result.calculation_time = TimeCurrent();
        
        // Optymalizacja na podstawie typu algorytmu
        switch(params.algorithm) {
            case ALGO_TWAP:
                OptimizeTWAP(params, result);
                break;
            case ALGO_VWAP:
                OptimizeVWAP(params, result);
                break;
            case ALGO_ICEBERG:
                OptimizeIceberg(params, result);
                break;
            case ALGO_SMART_ROUTING:
                OptimizeSmartRouting(params, result);
                break;
            case ALGO_ADAPTIVE:
                OptimizeAdaptive(params, result);
                break;
            case ALGO_SPIRIT_DRIVEN:
                OptimizeSpiritDriven(params, result);
                break;
            case ALGO_SENTIMENT_AWARE:
                OptimizeSentimentAware(params, result);
                break;
            case ALGO_EVENT_DRIVEN:
                OptimizeEventDriven(params, result);
                break;
            default:
                OptimizeDefault(params, result);
                break;
        }
        
        // Dostosowanie do warunków rynkowych
        AdaptToMarketConditions(params, result);
        
        // Sprawdzenie limitów
        ValidateLimits(params, result);
        
        return result;
    }
    
    // === ALGORYTMY OPTYMALIZACJI ===
    
    void OptimizeTWAP(ExecutionParameters &params, OptimizationResult &result) {
        // Time Weighted Average Price
        double time_slices = MathMax(1, (int)(params.time_limit / 10));
        result.optimal_order_size = params.order_size / time_slices;
        result.optimal_timing = params.time_limit / time_slices;
        result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.5;
        result.optimization_reason = "TWAP - równomierne rozłożenie w czasie";
    }
    
    void OptimizeVWAP(ExecutionParameters &params, OptimizationResult &result) {
        // Volume Weighted Average Price
        double volume_ratio = m_market_analysis.average_volume / 1000000;
        result.optimal_order_size = params.order_size * MathMin(1.0, volume_ratio);
        result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.3;
        result.optimization_reason = "VWAP - dostosowanie do wolumenu";
    }
    
    void OptimizeIceberg(ExecutionParameters &params, OptimizationResult &result) {
        // Zlecenie góra lodowa
        double visible_size = params.order_size * 0.2;
        result.optimal_order_size = MathMax(params.min_order_size, visible_size);
        result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.2;
        result.optimization_reason = "ICEBERG - ukrycie rzeczywistego rozmiaru";
    }
    
    void OptimizeSmartRouting(ExecutionParameters &params, OptimizationResult &result) {
        // Inteligentne kierowanie
        if(m_market_analysis.is_liquid) {
            result.optimal_order_size = params.order_size;
            result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.4;
        } else {
            result.optimal_order_size = params.order_size * 0.5;
            result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.8;
        }
        result.optimization_reason = "SMART ROUTING - dostosowanie do płynności";
    }
    
    void OptimizeAdaptive(ExecutionParameters &params, OptimizationResult &result) {
        // Algorytm adaptacyjny
        double volatility_factor = 1.0 + m_market_analysis.current_volatility;
        result.optimal_order_size = params.order_size / volatility_factor;
        result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * (0.3 + m_market_analysis.current_volatility * 0.4);
        result.optimization_reason = "ADAPTIVE - dostosowanie do zmienności";
    }
    
    void OptimizeSpiritDriven(ExecutionParameters &params, OptimizationResult &result) {
        // Napędzany duchami
        // Tutaj byłaby integracja z systemem duchów
        double spirit_alignment = 0.8; // Symulacja
        result.optimal_order_size = params.order_size * spirit_alignment;
        result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.5;
        result.optimization_reason = "SPIRIT DRIVEN - zgodność z duchami";
    }
    
    void OptimizeSentimentAware(ExecutionParameters &params, OptimizationResult &result) {
        // Świadomy sentymentu
        // Tutaj byłaby integracja z SentimentAnalyzer
        double sentiment_score = 0.6; // Symulacja
        result.optimal_order_size = params.order_size * (0.5 + sentiment_score * 0.5);
        result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.6;
        result.optimization_reason = "SENTIMENT AWARE - uwzględnienie sentymentu";
    }
    
    void OptimizeEventDriven(ExecutionParameters &params, OptimizationResult &result) {
        // Napędzany wydarzeniami
        // Tutaj byłaby integracja z EconomicCalendar
        bool has_event = false; // Symulacja
        if(has_event) {
            result.optimal_order_size = params.order_size * 0.3;
            result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 1.2;
            result.optimization_reason = "EVENT DRIVEN - dostosowanie do wydarzeń";
        } else {
            result.optimal_order_size = params.order_size;
            result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.5;
            result.optimization_reason = "EVENT DRIVEN - brak wydarzeń";
        }
    }
    
    void OptimizeDefault(ExecutionParameters &params, OptimizationResult &result) {
        // Domyślna optymalizacja
        result.optimal_order_size = params.order_size;
        result.expected_cost = params.order_size * m_market_analysis.bid_ask_spread * 0.5;
        result.optimization_reason = "DEFAULT - standardowa optymalizacja";
    }
    
    // === DOSTOSOWANIE DO WARUNKÓW RYNKOWYCH ===
    void AdaptToMarketConditions(ExecutionParameters &params, OptimizationResult &result) {
        if(m_market_analysis.is_volatile) {
            result.optimal_order_size *= 0.7;
            result.expected_cost *= 1.3;
            result.success_probability *= 0.9;
        }
        
        if(!m_market_analysis.is_liquid) {
            result.optimal_order_size *= 0.5;
            result.expected_cost *= 1.5;
            result.success_probability *= 0.8;
        }
        
        if(m_market_analysis.is_trending) {
            result.optimal_timing = 0; // Natychmiastowe wykonanie
            result.success_probability *= 1.1;
        }
    }
    
    // === WALIDACJA LIMITÓW ===
    void ValidateLimits(ExecutionParameters &params, OptimizationResult &result) {
        // Sprawdzenie rozmiaru zlecenia
        if(result.optimal_order_size > params.max_order_size) {
            result.optimal_order_size = params.max_order_size;
        }
        if(result.optimal_order_size < params.min_order_size) {
            result.optimal_order_size = params.min_order_size;
        }
        
        // Sprawdzenie limitu ceny
        if(params.price_limit > 0) {
            if(result.optimal_price > params.price_limit) {
                result.optimal_price = params.price_limit;
            }
        }
    }
    
    // === WYKONANIE ZLECENIA ===
    ExecutionResult ExecuteOrder(ExecutionParameters &params, ENUM_ORDER_TYPE order_type, double volume, double price = 0) {
        ExecutionResult result;
        
        // Resetowanie wyników
        result.success = false;
        result.order_ticket = 0;
        result.executed_volume = 0;
        result.average_price = 0;
        result.total_cost = 0;
        result.market_impact = 0;
        result.slippage = 0;
        result.fill_count = 0;
        result.start_time = TimeCurrent();
        result.end_time = 0;
        result.state = EXECUTION_PENDING;
        result.error_message = "";
        result.spirit_alignment_score = 0;
        result.sentiment_score = 0;
        result.execution_quality = 0;
        result.execution_log = "";
        
        // Optymalizacja wykonania
        OptimizationResult optimization = OptimizeExecution(params, price, order_type);
        
        // Logowanie
        result.execution_log += "Optymalizacja: " + optimization.optimization_reason + "\n";
        result.execution_log += "Rozmiar: " + DoubleToString(optimization.optimal_order_size, 2) + "\n";
        result.execution_log += "Oczekiwany koszt: " + DoubleToString(optimization.expected_cost, 5) + "\n";
        
        // Wykonanie zlecenia
        bool order_result = false;
        
        switch(order_type) {
            case ORDER_TYPE_BUY:
                order_result = m_trade.Buy(optimization.optimal_order_size, m_symbol, optimization.optimal_price);
                break;
            case ORDER_TYPE_SELL:
                order_result = m_trade.Sell(optimization.optimal_order_size, m_symbol, optimization.optimal_price);
                break;
            case ORDER_TYPE_BUY_LIMIT:
                order_result = m_trade.BuyLimit(optimization.optimal_order_size, optimization.optimal_price, m_symbol);
                break;
            case ORDER_TYPE_SELL_LIMIT:
                order_result = m_trade.SellLimit(optimization.optimal_order_size, optimization.optimal_price, m_symbol);
                break;
            case ORDER_TYPE_BUY_STOP:
                order_result = m_trade.BuyStop(optimization.optimal_order_size, optimization.optimal_price, m_symbol);
                break;
            case ORDER_TYPE_SELL_STOP:
                order_result = m_trade.SellStop(optimization.optimal_order_size, optimization.optimal_price, m_symbol);
                break;
        }
        
        if(order_result) {
            result.success = true;
            result.order_ticket = m_trade.ResultOrder();
            result.executed_volume = m_trade.ResultVolume();
            result.average_price = m_trade.ResultPrice();
            result.state = EXECUTION_COMPLETED;
            
            // Obliczenie metryk
            CalculateExecutionMetrics(result, optimization);
            
            // Aktualizacja statystyk
            UpdateStatistics(result);
            
            result.execution_log += "Zlecenie wykonane pomyślnie\n";
            result.execution_log += "Ticket: " + IntegerToString(result.order_ticket) + "\n";
            result.execution_log += "Wolumen: " + DoubleToString(result.executed_volume, 2) + "\n";
            result.execution_log += "Cena: " + DoubleToString(result.average_price, m_digits) + "\n";
        } else {
            result.success = false;
            result.error_message = m_trade.ResultRetcodeDescription();
            result.state = EXECUTION_REJECTED;
            
            result.execution_log += "Błąd wykonania: " + result.error_message + "\n";
        }
        
        result.end_time = TimeCurrent();
        
        return result;
    }
    
    // === OBLICZENIE METRYK WYKONANIA ===
    void CalculateExecutionMetrics(ExecutionResult &result, OptimizationResult &optimization) {
        // Obliczenie poślizgu
        MqlTick tick;
        if(SymbolInfoTick(m_symbol, tick)) {
            if(result.average_price > tick.ask) {
                result.slippage = result.average_price - tick.ask;
            } else if(result.average_price < tick.bid) {
                result.slippage = tick.bid - result.average_price;
            }
        }
        
        // Obliczenie wpływu na rynek
        result.market_impact = result.executed_volume / m_market_analysis.average_volume;
        
        // Obliczenie kosztów
        result.total_cost = result.executed_volume * m_market_analysis.bid_ask_spread * 0.5;
        
        // Jakość wykonania
        double time_factor = 1.0 - (result.end_time - result.start_time) / 60.0; // Maksymalnie 1 minuta
        double slippage_factor = 1.0 - MathMin(1.0, result.slippage / m_point / 10);
        double impact_factor = 1.0 - MathMin(1.0, result.market_impact);
        
        result.execution_quality = (time_factor + slippage_factor + impact_factor) / 3;
        
        // Symulacja wyników duchów i sentymentu
        result.spirit_alignment_score = 0.8 + (MathRand() % 20) / 100.0;
        result.sentiment_score = 0.6 + (MathRand() % 40) / 100.0;
    }
    
    // === AKTUALIZACJA STATYSTYK ===
    void UpdateStatistics(ExecutionResult &result) {
        m_total_executions++;
        
        if(result.success) {
            m_successful_executions++;
        }
        
        // Średni czas wykonania
        double execution_time = (double)(result.end_time - result.start_time);
        m_average_execution_time = (m_average_execution_time + execution_time) / 2;
        
        // Średni poślizg
        m_average_slippage = (m_average_slippage + result.slippage) / 2;
        
        // Całkowity koszt
        m_total_cost += result.total_cost;
    }
    
    // === FUNKCJE DOSTĘPU ===
    
    MarketAnalysis GetMarketAnalysis() {
        if(TimeCurrent() - m_last_analysis > 60) {
            AnalyzeMarket();
        }
        return m_market_analysis;
    }
    
    ExecutionParameters GetDefaultParameters() {
        return m_default_params;
    }
    
    void SetDefaultParameters(ExecutionParameters &params) {
        m_default_params = params;
    }
    
    // === FUNKCJE POMOCNICZE ===
    
    ExecutionStatistics GetStatistics() {
        ExecutionStatistics stats;
        stats.total_orders = m_total_executions;
        stats.successful_orders = m_successful_executions;
        stats.failed_orders = m_total_executions - m_successful_executions;
        stats.success_rate = m_total_executions > 0 ? (double)m_successful_executions / m_total_executions * 100 : 0;
        stats.average_execution_time = m_average_execution_time;
        stats.total_volume = 0; // TODO: Implement volume tracking
        stats.last_order_time = 0; // TODO: Implement last order time tracking
        stats.last_order_symbol = m_symbol;
        stats.total_profit = 0; // TODO: Implement profit tracking
        stats.total_loss = 0; // TODO: Implement loss tracking
        stats.net_pnl = 0; // TODO: Implement PnL tracking
        return stats;
    }
    
    string GetExecutionReport() {
        return GetStatusReport();
    }
    
    string GetStatusReport() {
        string report = "=== EXECUTION ALGORITHMS STATUS ===\n";
        report += "Symbol: " + m_symbol + "\n";
        report += "Całkowite wykonania: " + IntegerToString(m_total_executions) + "\n";
        report += "Pomyślne wykonania: " + IntegerToString(m_successful_executions) + "\n";
        report += "Wskaźnik sukcesu: " + DoubleToString((double)m_successful_executions / MathMax(1, m_total_executions) * 100, 1) + "%\n";
        report += "Średni czas wykonania: " + DoubleToString(m_average_execution_time, 1) + "s\n";
        report += "Średni poślizg: " + DoubleToString(m_average_slippage, m_digits) + "\n";
        report += "Całkowity koszt: " + DoubleToString(m_total_cost, 2) + "\n";
        report += "Stan rynku: " + m_market_analysis.market_condition + "\n";
        report += "Zmienność: " + DoubleToString(m_market_analysis.current_volatility, 2) + "\n";
        report += "Spread: " + DoubleToString(m_market_analysis.bid_ask_spread, m_digits) + "\n";
        report += "Ostatnia analiza: " + TimeToString(m_last_analysis) + "\n";
        report += "================================";
        
        return report;
    }
    
    string GetAlgorithmDescription(ENUM_EXECUTION_ALGORITHM algorithm) {
        switch(algorithm) {
            case ALGO_MARKET_ORDER: return "Zlecenie rynkowe - natychmiastowe wykonanie";
            case ALGO_LIMIT_ORDER: return "Zlecenie limit - po określonej cenie";
            case ALGO_STOP_ORDER: return "Zlecenie stop - po przekroczeniu ceny";
            case ALGO_TWAP: return "TWAP - równomierne rozłożenie w czasie";
            case ALGO_VWAP: return "VWAP - dostosowanie do wolumenu";
            case ALGO_ICEBERG: return "ICEBERG - ukrycie rzeczywistego rozmiaru";
            case ALGO_SMART_ROUTING: return "SMART ROUTING - inteligentne kierowanie";
            case ALGO_ADAPTIVE: return "ADAPTIVE - dostosowanie do warunków";
            case ALGO_SPIRIT_DRIVEN: return "SPIRIT DRIVEN - napędzany duchami";
            case ALGO_SENTIMENT_AWARE: return "SENTIMENT AWARE - świadomy sentymentu";
            case ALGO_EVENT_DRIVEN: return "EVENT DRIVEN - napędzany wydarzeniami";
            default: return "Nieznany algorytm";
        }
    }
};

// === GLOBALNA INSTANCJA ===
extern CExecutionAlgorithms* g_execution_algorithms = NULL;

// === FUNKCJE GLOBALNE ===
bool InitializeGlobalExecutionAlgorithms(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
    if(g_execution_algorithms != NULL) delete g_execution_algorithms;
    g_execution_algorithms = new CExecutionAlgorithms();
    return g_execution_algorithms.Initialize(symbol, timeframe);
}

void ReleaseGlobalExecutionAlgorithms() {
    if(g_execution_algorithms != NULL) {
        delete g_execution_algorithms;
        g_execution_algorithms = NULL;
    }
}

ExecutionResult ExecuteBuyOrder(double volume, double price = 0, ExecutionParameters params = {}) {
    if(g_execution_algorithms != NULL) {
        if(params.algorithm == 0) {
            params = g_execution_algorithms.GetDefaultParameters();
        }
        return g_execution_algorithms.ExecuteOrder(params, ORDER_TYPE_BUY, volume, price);
    }
    return ExecutionResult{};
}

ExecutionResult ExecuteSellOrder(double volume, double price = 0, ExecutionParameters params = {}) {
    if(g_execution_algorithms != NULL) {
        if(params.algorithm == 0) {
            params = g_execution_algorithms.GetDefaultParameters();
        }
        return g_execution_algorithms.ExecuteOrder(params, ORDER_TYPE_SELL, volume, price);
    }
    return ExecutionResult{};
}

MarketAnalysis GetMarketAnalysis() {
    return g_execution_algorithms != NULL ? g_execution_algorithms.GetMarketAnalysis() : MarketAnalysis{};
}

string GetExecutionAlgorithmsReport() {
    return g_execution_algorithms != NULL ? g_execution_algorithms.GetStatusReport() : "Execution Algorithms nie zainicjalizowany";
}

#endif // EXECUTION_ALGORITHMS_H
