#ifndef RISK_MANAGER_H
#define RISK_MANAGER_H

// ========================================
// RISK MANAGER - ZARZĄDZANIE RYZYKIEM
// ========================================
// Zaawansowany system zarządzania ryzykiem dla Systemu Böhmego
// Integruje analizę ryzyka, zarządzanie pozycjami i adaptacyjne strategie

#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\OrderInfo.mqh>
#include <Trade\DealInfo.mqh>
#include "../Utils/LoggingSystem.mqh"

// === ENUMERACJE ===

// Typy ryzyka
enum ENUM_RISK_TYPE {
    RISK_TYPE_MARKET,               // Ryzyko rynkowe
    RISK_TYPE_LIQUIDITY,            // Ryzyko płynności
    RISK_TYPE_VOLATILITY,           // Ryzyko volatilności
    RISK_TYPE_CORRELATION,          // Ryzyko korelacji
    RISK_TYPE_CONCENTRATION,        // Ryzyko koncentracji
    RISK_TYPE_LEVERAGE,             // Ryzyko dźwigni
    RISK_TYPE_GAP,                  // Ryzyko gap
    RISK_TYPE_SYSTEMIC,             // Ryzyko systemowe
    RISK_TYPE_OPERATIONAL,          // Ryzyko operacyjne
    RISK_TYPE_REPUTATIONAL          // Ryzyko reputacyjne
};

// Poziomy ryzyka
enum ENUM_RISK_LEVEL {
    RISK_LEVEL_MINIMAL,             // Minimalne ryzyko
    RISK_LEVEL_LOW,                 // Niskie ryzyko
    RISK_LEVEL_MODERATE,            // Umiarkowane ryzyko
    RISK_LEVEL_HIGH,                // Wysokie ryzyko
    RISK_LEVEL_EXTREME,             // Ekstremalne ryzyko
    RISK_LEVEL_CRITICAL             // Krytyczne ryzyko
};

// Strategie zarządzania ryzykiem
enum ENUM_RISK_STRATEGY {
    RISK_STRATEGY_CONSERVATIVE,     // Strategia konserwatywna
    RISK_STRATEGY_MODERATE,         // Strategia umiarkowana
    RISK_STRATEGY_AGGRESSIVE,       // Strategia agresywna
    RISK_STRATEGY_ADAPTIVE,         // Strategia adaptacyjna
    RISK_STRATEGY_DYNAMIC,          // Strategia dynamiczna
    RISK_STRATEGY_AI_DRIVEN         // Strategia napędzana AI
};

// Akcje zarządzania ryzykiem
enum ENUM_RISK_ACTION {
    RISK_ACTION_NONE,               // Brak akcji
    RISK_ACTION_REDUCE_SIZE,        // Zmniejszenie rozmiaru
    RISK_ACTION_CLOSE_POSITION,     // Zamknięcie pozycji
    RISK_ACTION_ADD_HEDGE,          // Dodanie hedgingu
    RISK_ACTION_TIGHTEN_STOPS,      // Dokładnienie stopów
    RISK_ACTION_SUSPEND_TRADING,    // Zawieszenie handlu
    RISK_ACTION_EMERGENCY_EXIT      // Awaryjne wyjście
};

// === STRUKTURY DANYCH ===

// Struktura analizy ryzyka
struct SRiskAnalysis {
    // Podstawowe metryki ryzyka
    double total_risk_score;        // Całkowity wynik ryzyka (0-100)
    double market_risk;             // Ryzyko rynkowe
    double liquidity_risk;          // Ryzyko płynności
    double volatility_risk;         // Ryzyko volatilności
    double correlation_risk;        // Ryzyko korelacji
    double concentration_risk;      // Ryzyko koncentracji
    double leverage_risk;           // Ryzyko dźwigni
    
    // Zaawansowane metryki
    double var_95;                  // Value at Risk (95%)
    double var_99;                  // Value at Risk (99%)
    double expected_shortfall;      // Expected Shortfall
    double max_drawdown;            // Maksymalny drawdown
    double sharpe_ratio;            // Współczynnik Sharpe
    double sortino_ratio;           // Współczynnik Sortino
    double calmar_ratio;            // Współczynnik Calmar
    
    // Metryki pozycji
    double total_exposure;          // Całkowita ekspozycja
    double net_exposure;            // Netto ekspozycja
    double gross_exposure;          // Brutto ekspozycja
    double position_concentration;  // Koncentracja pozycji
    double sector_concentration;    // Koncentracja sektorowa
    
    // Metryki czasowe
    double daily_var;               // Dzienne VaR
    double weekly_var;              // Tygodniowe VaR
    double monthly_var;             // Miesięczne VaR
    double stress_test_score;       // Wynik testów stresowych
    
    // Timestamps
    datetime last_update;           // Ostatnia aktualizacja
    datetime risk_calculation_time; // Czas obliczenia ryzyka
};

// Struktura statystyk ryzyka
struct RiskStatistics {
    double current_risk;            // Obecne ryzyko
    double max_risk;                // Maksymalne ryzyko
    double risk_per_trade;          // Ryzyko na transakcję
    double daily_risk;              // Ryzyko dzienne
    double portfolio_risk;          // Ryzyko portfela
    int open_positions;             // Otwarte pozycje
    double total_exposure;          // Całkowita ekspozycja
    double max_drawdown;            // Maksymalny drawdown
    double current_drawdown;        // Obecny drawdown
    double profit_factor;           // Współczynnik zysku
    double win_rate;                // Wskaźnik wygranych
    double avg_win;                 // Średni zysk
    double avg_loss;                // Średnia strata
    int total_trades;               // Całkowita liczba transakcji
    int winning_trades;             // Wygrane transakcje
    int losing_trades;              // Przegrane transakcje
};

// Struktura parametrów zarządzania ryzykiem
struct SRiskParameters {
    // Limity ryzyka
    double max_position_size;       // Maksymalny rozmiar pozycji
    double max_daily_loss;          // Maksymalna dzienna strata
    double max_drawdown_limit;      // Limit drawdown
    double max_leverage;            // Maksymalna dźwignia
    double max_concentration;       // Maksymalna koncentracja
    
    // Parametry VaR
    double var_confidence_level;    // Poziom ufności VaR (0.95, 0.99)
    int var_lookback_period;        // Okres lookback dla VaR
    double var_multiplier;          // Mnożnik VaR
    
    // Parametry zarządzania
    double risk_per_trade;          // Ryzyko na transakcję
    double risk_per_day;            // Ryzyko dzienne
    double risk_per_week;           // Ryzyko tygodniowe
    double risk_per_month;          // Ryzyko miesięczne
    
    // Parametry adaptacyjne
    double volatility_adjustment;   // Dostosowanie do volatilności
    double correlation_adjustment;  // Dostosowanie do korelacji
    double market_regime_adjustment; // Dostosowanie do reżimu rynku
    
    // Parametry AI
    double ai_confidence_threshold; // Próg pewności AI
    double ai_risk_multiplier;      // Mnożnik ryzyka AI
    bool ai_adaptive_sizing;        // Adaptacyjny sizing AI
    bool ai_dynamic_stops;          // Dynamiczne stopy AI
    
    // Parametry ostrzeżeń
    double warning_threshold;       // Próg ostrzeżeń
    double alert_threshold;         // Próg alertów
    double critical_threshold;      // Próg krytyczny
    double emergency_threshold;     // Próg awaryjny
};

// Struktura alertów ryzyka
struct SRiskAlert {
    ENUM_RISK_TYPE risk_type;       // Typ ryzyka
    ENUM_RISK_LEVEL risk_level;     // Poziom ryzyka
    ENUM_RISK_ACTION recommended_action; // Zalecana akcja
    string alert_message;           // Wiadomość alertu
    double risk_value;              // Wartość ryzyka
    double threshold_value;         // Wartość progu
    datetime alert_time;            // Czas alertu
    bool is_active;                 // Czy aktywny
    bool is_acknowledged;           // Czy potwierdzony
    string action_taken;            // Podjęta akcja
    datetime action_time;           // Czas akcji
};

// Struktura historii ryzyka
struct SRiskHistory {
    datetime timestamp;             // Timestamp
    double total_risk_score;        // Całkowity wynik ryzyka
    double market_risk;             // Ryzyko rynkowe
    double liquidity_risk;          // Ryzyko płynności
    double volatility_risk;         // Ryzyko volatilności
    double var_95;                  // VaR 95%
    double max_drawdown;            // Maksymalny drawdown
    double total_exposure;          // Całkowita ekspozycja
    int active_positions;           // Aktywne pozycje
    string market_condition;        // Stan rynku
    string risk_strategy;           // Strategia ryzyka
};

// === KLASA GŁÓWNA RISK MANAGER ===

class CRiskManager {
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
    
    // Zarządzanie ryzykiem
    SRiskAnalysis m_risk_analysis;
    SRiskParameters m_risk_parameters;
    SRiskAlert m_active_alerts[];
    SRiskHistory m_risk_history[];
    
    // Cache i stan
    datetime m_last_update;
    bool m_initialized;
    ENUM_RISK_STRATEGY m_current_strategy;
    bool m_trading_suspended;
    datetime m_suspension_time;
    
    // Callback functions - MQL5 doesn't support function pointers, using flags instead
    bool m_has_risk_alert_callback;
    bool m_has_risk_action_callback;
    bool m_has_trading_suspended_callback;
    bool m_has_trading_resumed_callback;
    
    // Metody prywatne - analiza ryzyka
    double CalculateMarketRisk();
    double CalculateLiquidityRisk();
    double CalculateVolatilityRisk();
    double CalculateCorrelationRisk();
    double CalculateConcentrationRisk();
    double CalculateLeverageRisk();
    
    // Metody prywatne - zaawansowane metryki
    double CalculateVaR(double confidence_level, int lookback_period);
    double CalculateExpectedShortfall(double confidence_level, int lookback_period);
    double CalculateMaxDrawdown();
    double CalculateSharpeRatio();
    double CalculateSortinoRatio();
    double CalculateCalmarRatio();
    
    // Metody prywatne - zarządzanie
    void UpdateRiskAnalysis();
    void CheckRiskThresholds();
    void GenerateRiskAlerts();
    void GenerateRiskAlert(ENUM_RISK_TYPE risk_type, ENUM_RISK_LEVEL risk_level, ENUM_RISK_ACTION recommended_action, string message);
    void ExecuteRiskActions();
    void UpdateRiskHistory();
    
    // Metody prywatne - akcje zarządzania ryzykiem
    void ReducePositionSizes();
    void CloseAllPositions();
    void AddHedgingPositions();
    void TightenStopLosses();
    void SuspendTrading();
    void SuspendTrading(string reason);
    void EmergencyExit();
    void EmergencyExit(string reason);
    
    // Metody prywatne - pomocnicze
    bool GetSymbolInfo();
    bool InitializeTrading();
    void InitializeRiskParameters();
    double GetReturns(double &returns[], int bars);
    double CalculatePortfolioVariance();
    
public:
    // === KONSTRUKTOR I DESTRUKTOR ===
    CRiskManager();
    ~CRiskManager();
    
    // === INICJALIZACJA ===
    bool Initialize(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT);
    void SetRiskStrategy(ENUM_RISK_STRATEGY strategy);
    void SetRiskParameters(SRiskParameters &parameters);
    
    // === GŁÓWNE METODY ===
    void Update();
    SRiskAnalysis GetRiskAnalysis();
    SRiskParameters GetRiskParameters();
    void GetActiveAlerts(SRiskAlert &alerts[]);
    void GetRiskHistory(SRiskHistory &history[]);
    
    // === ANALIZA RYZYKA ===
    double GetTotalRiskScore();
    double GetMarketRisk();
    double GetLiquidityRisk();
    double GetVolatilityRisk();
    double GetVaR(double confidence_level = 0.95);
    double GetMaxDrawdown();
    double GetSharpeRatio();
    
    // === ZARZĄDZANIE RYZYKIEM ===
    bool IsTradingAllowed();
    bool IsRiskAcceptable();
    ENUM_RISK_ACTION GetRecommendedAction();
    void ExecuteRiskAction(ENUM_RISK_ACTION action, string reason = "");
    
    // === ALERTY I OSTRZEŻENIA ===
    int GetActiveAlertCount();
    void AcknowledgeAlert(int alert_index);
    void ClearAlert(int alert_index);
    void ClearAllAlerts();
    
    // === RAPORTY I ANALIZY ===
    RiskStatistics GetStatistics();
    string GetRiskReport();
    string GetRiskSummary();
    string GetAlertReport();
    void ExportRiskHistory(string filename);
    
    // === SETTERY CALLBACKÓW ===
    void SetOnRiskAlert(bool enable);
    void SetOnRiskAction(bool enable);
    void SetOnTradingSuspended(bool enable);
    void SetOnTradingResumed(bool enable);
};

// === IMPLEMENTACJA KONSTRUKTORA I DESTRUKTORA ===

CRiskManager::CRiskManager() {
    m_symbol = _Symbol;
    m_timeframe = PERIOD_CURRENT;
    m_initialized = false;
    m_last_update = 0;
    m_current_strategy = RISK_STRATEGY_MODERATE;
    m_trading_suspended = false;
    m_suspension_time = 0;
    
    // Resetowanie callbacków
    m_has_risk_alert_callback = false;
    m_has_risk_action_callback = false;
    m_has_trading_suspended_callback = false;
    m_has_trading_resumed_callback = false;
    
    // Inicjalizacja parametrów ryzyka
    InitializeRiskParameters();
    
    // Inicjalizacja tablic
    ArrayResize(m_active_alerts, 0);
    ArrayResize(m_risk_history, 0);
    
    LogInfo(LOG_COMPONENT_RISK, "Risk Manager zainicjalizowany");
}

CRiskManager::~CRiskManager() {
    // Zwalnianie zasobów
    ArrayFree(m_active_alerts);
    ArrayFree(m_risk_history);
    
    LogInfo(LOG_COMPONENT_RISK, "Risk Manager zniszczony");
}

// === INICJALIZACJA PARAMETRÓW RYZYKA ===

void CRiskManager::InitializeRiskParameters() {
    // Limity ryzyka - konserwatywne wartości domyślne
    m_risk_parameters.max_position_size = 1.0;        // 1 lot max
    m_risk_parameters.max_daily_loss = 5.0;           // 5% dziennej straty
    m_risk_parameters.max_drawdown_limit = 20.0;      // 20% max drawdown
    m_risk_parameters.max_leverage = 10.0;            // 10:1 max dźwignia
    m_risk_parameters.max_concentration = 25.0;       // 25% max koncentracja
    
    // Parametry VaR
    m_risk_parameters.var_confidence_level = 0.95;    // 95% ufności
    m_risk_parameters.var_lookback_period = 252;      // 1 rok danych
    m_risk_parameters.var_multiplier = 1.0;           // Mnożnik VaR
    
    // Parametry zarządzania
    m_risk_parameters.risk_per_trade = 2.0;           // 2% na transakcję
    m_risk_parameters.risk_per_day = 5.0;             // 5% dziennie
    m_risk_parameters.risk_per_week = 15.0;           // 15% tygodniowo
    m_risk_parameters.risk_per_month = 30.0;          // 30% miesięcznie
    
    // Parametry adaptacyjne
    m_risk_parameters.volatility_adjustment = 1.0;    // Dostosowanie volatilności
    m_risk_parameters.correlation_adjustment = 1.0;   // Dostosowanie korelacji
    m_risk_parameters.market_regime_adjustment = 1.0; // Dostosowanie reżimu
    
    // Parametry AI
    m_risk_parameters.ai_confidence_threshold = 0.7;  // 70% pewności AI
    m_risk_parameters.ai_risk_multiplier = 1.0;       // Mnożnik ryzyka AI
    m_risk_parameters.ai_adaptive_sizing = true;      // Adaptacyjny sizing
    m_risk_parameters.ai_dynamic_stops = true;        // Dynamiczne stopy
    
    // Parametry ostrzeżeń
    m_risk_parameters.warning_threshold = 50.0;       // 50% - ostrzeżenie
    m_risk_parameters.alert_threshold = 70.0;         // 70% - alert
    m_risk_parameters.critical_threshold = 85.0;      // 85% - krytyczne
    m_risk_parameters.emergency_threshold = 95.0;     // 95% - awaryjne
}

// === METODY INICJALIZACJI ===

bool CRiskManager::Initialize(string symbol, ENUM_TIMEFRAMES timeframe) {
    if(symbol != "") m_symbol = symbol;
    if(timeframe != PERIOD_CURRENT) m_timeframe = timeframe;
    
    LogInfo(LOG_COMPONENT_RISK, "Inicjalizacja Risk Manager", "Symbol: " + m_symbol);
    
    // Pobranie informacji o symbolu
    if(!GetSymbolInfo()) {
        LogError(LOG_COMPONENT_RISK, "Błąd pobierania informacji o symbolu", m_symbol);
        return false;
    }
    
    // Inicjalizacja handlu
    if(!InitializeTrading()) {
        LogError(LOG_COMPONENT_RISK, "Błąd inicjalizacji handlu", 0.0, m_symbol);
        return false;
    }
    
    // Pierwsza analiza ryzyka
    UpdateRiskAnalysis();
    
    m_initialized = true;
    m_last_update = TimeCurrent();
    
    LogInfo(LOG_COMPONENT_RISK, "Risk Manager zainicjalizowany", 
            "Strategia: " + EnumToString(m_current_strategy));
    
    return true;
}

bool CRiskManager::GetSymbolInfo() {
    m_point = SymbolInfoDouble(m_symbol, SYMBOL_POINT);
    m_digits = (int)SymbolInfoInteger(m_symbol, SYMBOL_DIGITS);
    m_tick_size = SymbolInfoDouble(m_symbol, SYMBOL_TRADE_TICK_SIZE);
    m_contract_size = SymbolInfoDouble(m_symbol, SYMBOL_TRADE_CONTRACT_SIZE);
    
    if(m_point <= 0 || m_digits <= 0 || m_tick_size <= 0) {
        return false;
    }
    
    return true;
}

bool CRiskManager::InitializeTrading() {
    m_trade.SetExpertMagicNumber(123456);
    m_trade.SetDeviationInPoints(10);
    m_trade.SetTypeFilling(ORDER_FILLING_FOK);
    m_trade.SetMarginMode();
    m_trade.LogLevel(LOG_LEVEL_ALL);
    
    return true;
}

void CRiskManager::SetRiskStrategy(ENUM_RISK_STRATEGY strategy) {
    m_current_strategy = strategy;
    
    // Dostosowanie parametrów do strategii
    switch(strategy) {
        case RISK_STRATEGY_CONSERVATIVE:
            m_risk_parameters.risk_per_trade = 1.0;
            m_risk_parameters.max_daily_loss = 3.0;
            m_risk_parameters.max_drawdown_limit = 15.0;
            break;
            
        case RISK_STRATEGY_MODERATE:
            m_risk_parameters.risk_per_trade = 2.0;
            m_risk_parameters.max_daily_loss = 5.0;
            m_risk_parameters.max_drawdown_limit = 20.0;
            break;
            
        case RISK_STRATEGY_AGGRESSIVE:
            m_risk_parameters.risk_per_trade = 3.0;
            m_risk_parameters.max_daily_loss = 8.0;
            m_risk_parameters.max_drawdown_limit = 25.0;
            break;
            
        case RISK_STRATEGY_ADAPTIVE:
            // Parametry będą dostosowywane dynamicznie
            break;
            
        case RISK_STRATEGY_DYNAMIC:
            // Parametry będą dostosowywane w czasie rzeczywistym
            break;
            
        case RISK_STRATEGY_AI_DRIVEN:
            // Parametry będą kontrolowane przez AI
            break;
    }
    
    LogInfo(LOG_COMPONENT_RISK, "Strategia ryzyka zmieniona", EnumToString(strategy));
}

void CRiskManager::SetRiskParameters(SRiskParameters &parameters) {
    m_risk_parameters = parameters;
    LogInfo(LOG_COMPONENT_RISK, "Parametry ryzyka zaktualizowane");
}

// === METODY POMOCNICZE ===

double CRiskManager::GetReturns(double &returns[], int bars) {
    double prices[];
    if(CopyClose(m_symbol, m_timeframe, 0, bars + 1, prices) != bars + 1) {
        return 0;
    }
    
    ArrayResize(returns, bars);
    
    for(int i = 0; i < bars; i++) {
        if(prices[i + 1] > 0) {
            returns[i] = MathLog(prices[i] / prices[i + 1]);
        } else {
            returns[i] = 0.0;
        }
    }
    
    return bars;
}

double CRiskManager::CalculatePortfolioVariance() {
    // Uproszczone obliczenie wariancji portfela
    // W rzeczywistej implementacji uwzględniłoby korelacje między pozycjami
    
    double total_variance = 0.0;
    int position_count = 0;
    
    for(int i = 0; i < PositionsTotal(); i++) {
        if(PositionSelectByTicket(PositionGetTicket(i))) {
            if(PositionGetString(POSITION_SYMBOL) == m_symbol) {
                double volume = PositionGetDouble(POSITION_VOLUME);
                double price = PositionGetDouble(POSITION_PRICE_CURRENT);
                
                // Uproszczona wariancja pozycji
                double position_variance = MathPow(volume * price * 0.01, 2); // 1% volatilność
                total_variance += position_variance;
                position_count++;
            }
        }
    }
    
    return total_variance;
}

// === IMPLEMENTACJA METOD ANALIZY RYZYKA ===

double CRiskManager::CalculateMarketRisk() {
    // Ryzyko rynkowe - oparte na volatilności i trendzie
    double returns[];
    int bars = 20;
    
    if(GetReturns(returns, bars) < bars) return 0.0;
    
    // Obliczenie volatilności
    double mean_return = 0.0;
    for(int i = 0; i < bars; i++) {
        mean_return += returns[i];
    }
    mean_return /= bars;
    
    double variance = 0.0;
    for(int i = 0; i < bars; i++) {
        variance += MathPow(returns[i] - mean_return, 2);
    }
    variance /= bars;
    double volatility = MathSqrt(variance * 252.0); // Annualized
    
    // Obliczenie trendu
    double prices[];
    if(CopyClose(m_symbol, m_timeframe, 0, 10, prices) == 10) {
        double trend = (prices[0] - prices[9]) / prices[9] * 100.0;
        
        // Ryzyko rynkowe = volatilność + trend + korekta
        double market_risk = volatility * 100.0 + MathAbs(trend) * 0.5;
        
        return MathMax(0.0, MathMin(100.0, market_risk));
    }
    
    return volatility * 100.0;
}

double CRiskManager::CalculateLiquidityRisk() {
    // Ryzyko płynności - oparte na wolumenie i spreadzie
    long volumes[];
    int bars = 20;
    
    if(CopyTickVolume(m_symbol, m_timeframe, 0, bars, volumes) != bars) {
        return 50.0; // Neutral risk
    }
    
    // Obliczenie średniego wolumenu
    double avg_volume = 0.0;
    for(int i = 0; i < bars; i++) {
        avg_volume += volumes[i];
    }
    avg_volume /= bars;
    
    // Obliczenie aktualnego wolumenu
    double current_volume = volumes[0];
    
    // Ryzyko płynności = odwrotność względnego wolumenu
    double volume_ratio = current_volume / avg_volume;
    double liquidity_risk = 100.0 - MathMin(100.0, volume_ratio * 50.0);
    
    // Dodanie ryzyka spreadu (uproszczone)
    int atr_handle = iATR(m_symbol, m_timeframe, 14);
    double atr_buffer[1];
    double price_buffer[1];
    double spread_risk = 0.0;
    
    if(CopyBuffer(atr_handle, 0, 0, 1, atr_buffer) > 0 && 
       CopyClose(m_symbol, m_timeframe, 0, 1, price_buffer) > 0) {
        double atr = atr_buffer[0];
        double current_price = price_buffer[0];
        
        if(current_price > 0) {
            spread_risk = (atr / current_price) * 1000.0; // Scale up
        }
    }
    
    return MathMax(0.0, MathMin(100.0, liquidity_risk + spread_risk));
}

double CRiskManager::CalculateVolatilityRisk() {
    // Ryzyko volatilności - oparte na różnych miarach volatilności
    double returns[];
    int bars = 50;
    
    if(GetReturns(returns, bars) < bars) return 0.0;
    
    // Realized volatility
    double mean_return = 0.0;
    for(int i = 0; i < bars; i++) {
        mean_return += returns[i];
    }
    mean_return /= bars;
    
    double variance = 0.0;
    for(int i = 0; i < bars; i++) {
        variance += MathPow(returns[i] - mean_return, 2);
    }
    variance /= bars;
    double realized_vol = MathSqrt(variance * 252.0);
    
    // Parkinson volatility (High-Low)
    double highs[], lows[];
    if(CopyHigh(m_symbol, m_timeframe, 0, bars, highs) == bars &&
       CopyLow(m_symbol, m_timeframe, 0, bars, lows) == bars) {
        
        double sum_log_hl = 0.0;
        for(int i = 0; i < bars; i++) {
            if(highs[i] > 0 && lows[i] > 0) {
                sum_log_hl += MathPow(MathLog(highs[i] / lows[i]), 2);
            }
        }
        double parkinson_vol = MathSqrt(sum_log_hl / (4.0 * MathLog(2.0) * bars) * 252.0);
        
        // Średnia z różnych miar volatilności
        double avg_volatility = (realized_vol + parkinson_vol) / 2.0;
        
        // Ryzyko volatilności = skalowana volatilność
        return MathMax(0.0, MathMin(100.0, avg_volatility * 500.0));
    }
    
    return MathMax(0.0, MathMin(100.0, realized_vol * 500.0));
}

double CRiskManager::CalculateCorrelationRisk() {
    // Ryzyko korelacji - uproszczone obliczenie
    // W rzeczywistej implementacji uwzględniłoby korelacje między różnymi instrumentami
    
    double correlation_risk = 0.0;
    int position_count = 0;
    
    // Sprawdzenie pozycji na tym samym symbolu
    for(int i = 0; i < PositionsTotal(); i++) {
        if(PositionSelectByTicket(PositionGetTicket(i))) {
            if(PositionGetString(POSITION_SYMBOL) == m_symbol) {
                position_count++;
            }
        }
    }
    
    // Ryzyko korelacji wzrasta z liczbą pozycji
    if(position_count > 1) {
        correlation_risk = (position_count - 1) * 10.0; // 10% na dodatkową pozycję
    }
    
    return MathMax(0.0, MathMin(100.0, correlation_risk));
}

double CRiskManager::CalculateConcentrationRisk() {
    // Ryzyko koncentracji - oparte na rozkładzie pozycji
    double total_exposure = 0.0;
    double max_position_exposure = 0.0;
    
    for(int i = 0; i < PositionsTotal(); i++) {
        if(PositionSelectByTicket(PositionGetTicket(i))) {
            if(PositionGetString(POSITION_SYMBOL) == m_symbol) {
                double volume = PositionGetDouble(POSITION_VOLUME);
                double price = PositionGetDouble(POSITION_PRICE_CURRENT);
                double exposure = volume * price;
                
                total_exposure += exposure;
                max_position_exposure = MathMax(max_position_exposure, exposure);
            }
        }
    }
    
    if(total_exposure > 0) {
        // Ryzyko koncentracji = udział największej pozycji
        double concentration = (max_position_exposure / total_exposure) * 100.0;
        return MathMax(0.0, MathMin(100.0, concentration));
    }
    
    return 0.0;
}

double CRiskManager::CalculateLeverageRisk() {
    // Ryzyko dźwigni - oparte na stosunku margin do equity
    double account_equity = AccountInfoDouble(ACCOUNT_EQUITY);
    double account_margin = AccountInfoDouble(ACCOUNT_MARGIN);
    
    if(account_equity > 0) {
        double leverage_ratio = account_margin / account_equity;
        
        // Ryzyko dźwigni = skalowana dźwignia
        return MathMax(0.0, MathMin(100.0, leverage_ratio * 20.0));
    }
    
    return 0.0;
}

// === IMPLEMENTACJA ZAAWANSOWANYCH METRYK ===

double CRiskManager::CalculateVaR(double confidence_level, int lookback_period) {
    // Value at Risk - historyczna metoda
    double returns[];
    
    if(GetReturns(returns, lookback_period) < lookback_period) return 0.0;
    
    // Sortowanie returns (malejąco)
    ArraySort(returns);
    
    // Obliczenie percentyla
    int percentile_index = (int)((1.0 - confidence_level) * lookback_period);
    if(percentile_index >= lookback_period) percentile_index = lookback_period - 1;
    if(percentile_index < 0) percentile_index = 0;
    
    double var = MathAbs(returns[percentile_index]);
    
    // Konwersja na procenty
    return var * 100.0;
}

double CRiskManager::CalculateExpectedShortfall(double confidence_level, int lookback_period) {
    // Expected Shortfall (Conditional VaR)
    double returns[];
    
    if(GetReturns(returns, lookback_period) < lookback_period) return 0.0;
    
    // Sortowanie returns (malejąco)
    ArraySort(returns);
    
    // Obliczenie liczby obserwacji w ogonie
    int tail_count = (int)((1.0 - confidence_level) * lookback_period);
    if(tail_count <= 0) tail_count = 1;
    
    // Obliczenie średniej z ogona
    double tail_sum = 0.0;
    for(int i = 0; i < tail_count; i++) {
        tail_sum += MathAbs(returns[i]);
    }
    
    double expected_shortfall = tail_sum / tail_count;
    
    // Konwersja na procenty
    return expected_shortfall * 100.0;
}

double CRiskManager::CalculateMaxDrawdown() {
    // Maksymalny drawdown - oparty na historii equity
    double account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
    double account_equity = AccountInfoDouble(ACCOUNT_EQUITY);
    
    if(account_balance <= 0) return 0.0;
    
    // Obliczenie aktualnego drawdown
    double current_drawdown = (account_balance - account_equity) / account_balance * 100.0;
    
    // W rzeczywistej implementacji śledziłoby się historyczny max drawdown
    // Tutaj uproszczone obliczenie
    return MathMax(0.0, current_drawdown);
}

double CRiskManager::CalculateSharpeRatio() {
    // Współczynnik Sharpe - oparty na returns i risk-free rate
    double returns[];
    int bars = 252; // 1 rok danych
    
    if(GetReturns(returns, bars) < bars) return 0.0;
    
    // Obliczenie średniego return
    double mean_return = 0.0;
    for(int i = 0; i < bars; i++) {
        mean_return += returns[i];
    }
    mean_return /= bars;
    
    // Obliczenie odchylenia standardowego
    double variance = 0.0;
    for(int i = 0; i < bars; i++) {
        variance += MathPow(returns[i] - mean_return, 2);
    }
    variance /= bars;
    double std_dev = MathSqrt(variance);
    
    // Risk-free rate (uproszczone - 2% rocznie)
    double risk_free_rate = 0.02 / 252.0; // Dzienna stopa
    
    // Sharpe ratio
    if(std_dev > 0) {
        double sharpe = (mean_return - risk_free_rate) / std_dev;
        return sharpe * MathSqrt(252.0); // Annualized
    }
    
    return 0.0;
}

double CRiskManager::CalculateSortinoRatio() {
    // Współczynnik Sortino - uwzględnia tylko downside risk
    double returns[];
    int bars = 252; // 1 rok danych
    
    if(GetReturns(returns, bars) < bars) return 0.0;
    
    // Obliczenie średniego return
    double mean_return = 0.0;
    for(int i = 0; i < bars; i++) {
        mean_return += returns[i];
    }
    mean_return /= bars;
    
    // Obliczenie downside deviation
    double downside_sum = 0.0;
    int downside_count = 0;
    
    for(int i = 0; i < bars; i++) {
        if(returns[i] < mean_return) {
            downside_sum += MathPow(returns[i] - mean_return, 2);
            downside_count++;
        }
    }
    
    double downside_deviation = 0.0;
    if(downside_count > 0) {
        downside_deviation = MathSqrt(downside_sum / downside_count);
    }
    
    // Risk-free rate (uproszczone - 2% rocznie)
    double risk_free_rate = 0.02 / 252.0; // Dzienna stopa
    
    // Sortino ratio
    if(downside_deviation > 0) {
        double sortino = (mean_return - risk_free_rate) / downside_deviation;
        return sortino * MathSqrt(252.0); // Annualized
    }
    
    return 0.0;
}

double CRiskManager::CalculateCalmarRatio() {
    // Współczynnik Calmar - return vs max drawdown
    double returns[];
    int bars = 252; // 1 rok danych
    
    if(GetReturns(returns, bars) < bars) return 0.0;
    
    // Obliczenie średniego return
    double mean_return = 0.0;
    for(int i = 0; i < bars; i++) {
        mean_return += returns[i];
    }
    mean_return /= bars;
    
    // Annualized return
    double annual_return = mean_return * 252.0;
    
    // Max drawdown
    double max_drawdown = CalculateMaxDrawdown();
    
    // Calmar ratio
    if(max_drawdown > 0) {
        return annual_return / (max_drawdown / 100.0);
    }
    
    return 0.0;
}

// === IMPLEMENTACJA METOD ZARZĄDZANIA ===

void CRiskManager::UpdateRiskAnalysis() {
    if(!m_initialized) return;
    
    // Obliczenie podstawowych metryk ryzyka
    m_risk_analysis.market_risk = CalculateMarketRisk();
    m_risk_analysis.liquidity_risk = CalculateLiquidityRisk();
    m_risk_analysis.volatility_risk = CalculateVolatilityRisk();
    m_risk_analysis.correlation_risk = CalculateCorrelationRisk();
    m_risk_analysis.concentration_risk = CalculateConcentrationRisk();
    m_risk_analysis.leverage_risk = CalculateLeverageRisk();
    
    // Obliczenie zaawansowanych metryk
    m_risk_analysis.var_95 = CalculateVaR(0.95, m_risk_parameters.var_lookback_period);
    m_risk_analysis.var_99 = CalculateVaR(0.99, m_risk_parameters.var_lookback_period);
    m_risk_analysis.expected_shortfall = CalculateExpectedShortfall(0.95, m_risk_parameters.var_lookback_period);
    m_risk_analysis.max_drawdown = CalculateMaxDrawdown();
    m_risk_analysis.sharpe_ratio = CalculateSharpeRatio();
    m_risk_analysis.sortino_ratio = CalculateSortinoRatio();
    m_risk_analysis.calmar_ratio = CalculateCalmarRatio();
    
    // Obliczenie metryk pozycji
    double total_exposure = 0.0;
    double net_exposure = 0.0;
    int position_count = 0;
    
    for(int i = 0; i < PositionsTotal(); i++) {
        if(PositionSelectByTicket(PositionGetTicket(i))) {
            if(PositionGetString(POSITION_SYMBOL) == m_symbol) {
                double volume = PositionGetDouble(POSITION_VOLUME);
                double price = PositionGetDouble(POSITION_PRICE_CURRENT);
                double exposure = volume * price;
                
                total_exposure += exposure;
                if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) {
                    net_exposure += exposure;
                } else {
                    net_exposure -= exposure;
                }
                position_count++;
            }
        }
    }
    
    m_risk_analysis.total_exposure = total_exposure;
    m_risk_analysis.net_exposure = MathAbs(net_exposure);
    m_risk_analysis.gross_exposure = total_exposure;
    m_risk_analysis.position_concentration = position_count > 0 ? 100.0 / position_count : 0.0;
    
    // Obliczenie metryk czasowych
    m_risk_analysis.daily_var = m_risk_analysis.var_95;
    m_risk_analysis.weekly_var = m_risk_analysis.var_95 * MathSqrt(5.0); // 5 dni roboczych
    m_risk_analysis.monthly_var = m_risk_analysis.var_95 * MathSqrt(21.0); // 21 dni roboczych
    
    // Obliczenie całkowitego wyniku ryzyka
    double total_risk = (m_risk_analysis.market_risk * 0.25 +
                        m_risk_analysis.liquidity_risk * 0.20 +
                        m_risk_analysis.volatility_risk * 0.20 +
                        m_risk_analysis.correlation_risk * 0.15 +
                        m_risk_analysis.concentration_risk * 0.10 +
                        m_risk_analysis.leverage_risk * 0.10);
    
    m_risk_analysis.total_risk_score = MathMax(0.0, MathMin(100.0, total_risk));
    
    // Aktualizacja timestampów
    m_risk_analysis.last_update = TimeCurrent();
    m_risk_analysis.risk_calculation_time = TimeCurrent();
}

void CRiskManager::CheckRiskThresholds() {
    double total_risk = m_risk_analysis.total_risk_score;
    
    // Sprawdzenie progów i generowanie alertów
    if(total_risk >= m_risk_parameters.emergency_threshold) {
        GenerateRiskAlert(RISK_TYPE_SYSTEMIC, RISK_LEVEL_CRITICAL, 
                         RISK_ACTION_EMERGENCY_EXIT, "Krytyczne ryzyko systemowe");
    }
    else if(total_risk >= m_risk_parameters.critical_threshold) {
        GenerateRiskAlert(RISK_TYPE_SYSTEMIC, RISK_LEVEL_EXTREME, 
                         RISK_ACTION_SUSPEND_TRADING, "Ekstremalne ryzyko systemowe");
    }
    else if(total_risk >= m_risk_parameters.alert_threshold) {
        GenerateRiskAlert(RISK_TYPE_SYSTEMIC, RISK_LEVEL_HIGH, 
                         RISK_ACTION_REDUCE_SIZE, "Wysokie ryzyko systemowe");
    }
    else if(total_risk >= m_risk_parameters.warning_threshold) {
        GenerateRiskAlert(RISK_TYPE_SYSTEMIC, RISK_LEVEL_MODERATE, 
                         RISK_ACTION_TIGHTEN_STOPS, "Umiarkowane ryzyko systemowe");
    }
    
    // Sprawdzenie specyficznych typów ryzyka
    if(m_risk_analysis.leverage_risk >= 80.0) {
        GenerateRiskAlert(RISK_TYPE_LEVERAGE, RISK_LEVEL_HIGH, 
                         RISK_ACTION_REDUCE_SIZE, "Wysokie ryzyko dźwigni");
    }
    
    if(m_risk_analysis.concentration_risk >= 50.0) {
        GenerateRiskAlert(RISK_TYPE_CONCENTRATION, RISK_LEVEL_MODERATE, 
                         RISK_ACTION_ADD_HEDGE, "Ryzyko koncentracji pozycji");
    }
    
    if(m_risk_analysis.liquidity_risk >= 70.0) {
        GenerateRiskAlert(RISK_TYPE_LIQUIDITY, RISK_LEVEL_HIGH, 
                         RISK_ACTION_REDUCE_SIZE, "Wysokie ryzyko płynności");
    }
}

void CRiskManager::GenerateRiskAlert(ENUM_RISK_TYPE risk_type, ENUM_RISK_LEVEL risk_level, 
                                    ENUM_RISK_ACTION recommended_action, string message) {
    // Sprawdzenie czy alert już istnieje
    for(int i = 0; i < ArraySize(m_active_alerts); i++) {
        if(m_active_alerts[i].risk_type == risk_type && 
           m_active_alerts[i].is_active) {
            // Aktualizacja istniejącego alertu
            m_active_alerts[i].risk_level = risk_level;
            m_active_alerts[i].recommended_action = recommended_action;
            m_active_alerts[i].alert_message = message;
            m_active_alerts[i].alert_time = TimeCurrent();
            return;
        }
    }
    
    // Tworzenie nowego alertu
    SRiskAlert new_alert;
    new_alert.risk_type = risk_type;
    new_alert.risk_level = risk_level;
    new_alert.recommended_action = recommended_action;
    new_alert.alert_message = message;
    new_alert.risk_value = m_risk_analysis.total_risk_score;
    new_alert.threshold_value = m_risk_parameters.alert_threshold;
    new_alert.alert_time = TimeCurrent();
    new_alert.is_active = true;
    new_alert.is_acknowledged = false;
    new_alert.action_taken = "";
    new_alert.action_time = 0;
    
    // Dodanie do tablicy alertów
    ArrayResize(m_active_alerts, ArraySize(m_active_alerts) + 1);
    m_active_alerts[ArraySize(m_active_alerts) - 1] = new_alert;
    
    // Callback
    if(m_has_risk_alert_callback) {
        // Callback wykonany
    }
    
    LogRisk(LOG_COMPONENT_RISK, "Alert ryzyka", (double)risk_level, message);
}

void CRiskManager::ExecuteRiskActions() {
    for(int i = 0; i < ArraySize(m_active_alerts); i++) {
        if(m_active_alerts[i].is_active && !m_active_alerts[i].is_acknowledged) {
            ENUM_RISK_ACTION action = m_active_alerts[i].recommended_action;
            string reason = m_active_alerts[i].alert_message;
            
            ExecuteRiskAction(action, reason);
            
            // Oznaczenie alertu jako przetworzonego
            m_active_alerts[i].is_acknowledged = true;
            m_active_alerts[i].action_taken = EnumToString(action);
            m_active_alerts[i].action_time = TimeCurrent();
        }
    }
}

void CRiskManager::UpdateRiskHistory() {
    // Dodanie aktualnego stanu do historii
    SRiskHistory history_entry;
    history_entry.timestamp = TimeCurrent();
    history_entry.total_risk_score = m_risk_analysis.total_risk_score;
    history_entry.market_risk = m_risk_analysis.market_risk;
    history_entry.liquidity_risk = m_risk_analysis.liquidity_risk;
    history_entry.volatility_risk = m_risk_analysis.volatility_risk;
    history_entry.var_95 = m_risk_analysis.var_95;
    history_entry.max_drawdown = m_risk_analysis.max_drawdown;
    history_entry.total_exposure = m_risk_analysis.total_exposure;
    history_entry.active_positions = PositionsTotal();
    history_entry.market_condition = "NORMAL"; // Uproszczone
    history_entry.risk_strategy = EnumToString(m_current_strategy);
    
    // Dodanie do historii (maksymalnie 1000 wpisów)
    ArrayResize(m_risk_history, ArraySize(m_risk_history) + 1);
    m_risk_history[ArraySize(m_risk_history) - 1] = history_entry;
    
    // Usunięcie starych wpisów jeśli za dużo
    if(ArraySize(m_risk_history) > 1000) {
        for(int i = 0; i < ArraySize(m_risk_history) - 1; i++) {
            m_risk_history[i] = m_risk_history[i + 1];
        }
        ArrayResize(m_risk_history, ArraySize(m_risk_history) - 1);
    }
}

// === IMPLEMENTACJA METOD PUBLICZNYCH ===

void CRiskManager::Update() {
    if(!m_initialized) return;
    
    datetime current_time = TimeCurrent();
    
    // Aktualizacja co 5 sekund
    if(current_time - m_last_update >= 5) {
        m_last_update = current_time;
        
        // Aktualizacja analizy ryzyka
        UpdateRiskAnalysis();
        
        // Sprawdzenie progów ryzyka
        CheckRiskThresholds();
        
        // Wykonanie akcji ryzyka
        ExecuteRiskActions();
        
        // Aktualizacja historii
        UpdateRiskHistory();
    }
}

SRiskAnalysis CRiskManager::GetRiskAnalysis() {
    return m_risk_analysis;
}

SRiskParameters CRiskManager::GetRiskParameters() {
    return m_risk_parameters;
}

void CRiskManager::GetActiveAlerts(SRiskAlert &alerts[]) {
    ArrayResize(alerts, ArraySize(m_active_alerts));
    for(int i = 0; i < ArraySize(m_active_alerts); i++) {
        alerts[i] = m_active_alerts[i];
    }
}

void CRiskManager::GetRiskHistory(SRiskHistory &history[]) {
    ArrayResize(history, ArraySize(m_risk_history));
    for(int i = 0; i < ArraySize(m_risk_history); i++) {
        history[i] = m_risk_history[i];
    }
}

// === METODY ANALIZY RYZYKA ===

double CRiskManager::GetTotalRiskScore() {
    return m_risk_analysis.total_risk_score;
}

double CRiskManager::GetMarketRisk() {
    return m_risk_analysis.market_risk;
}

double CRiskManager::GetLiquidityRisk() {
    return m_risk_analysis.liquidity_risk;
}

double CRiskManager::GetVolatilityRisk() {
    return m_risk_analysis.volatility_risk;
}

double CRiskManager::GetVaR(double confidence_level) {
    if(confidence_level == 0.99) return m_risk_analysis.var_99;
    return m_risk_analysis.var_95; // Domyślnie 95%
}

double CRiskManager::GetMaxDrawdown() {
    return m_risk_analysis.max_drawdown;
}

double CRiskManager::GetSharpeRatio() {
    return m_risk_analysis.sharpe_ratio;
}

// === METODY ZARZĄDZANIA RYZYKIEM ===

bool CRiskManager::IsTradingAllowed() {
    return !m_trading_suspended;
}

bool CRiskManager::IsRiskAcceptable() {
    return m_risk_analysis.total_risk_score < m_risk_parameters.alert_threshold;
}

ENUM_RISK_ACTION CRiskManager::GetRecommendedAction() {
    double total_risk = m_risk_analysis.total_risk_score;
    
    if(total_risk >= m_risk_parameters.emergency_threshold) {
        return RISK_ACTION_EMERGENCY_EXIT;
    }
    else if(total_risk >= m_risk_parameters.critical_threshold) {
        return RISK_ACTION_SUSPEND_TRADING;
    }
    else if(total_risk >= m_risk_parameters.alert_threshold) {
        return RISK_ACTION_REDUCE_SIZE;
    }
    else if(total_risk >= m_risk_parameters.warning_threshold) {
        return RISK_ACTION_TIGHTEN_STOPS;
    }
    
    return RISK_ACTION_NONE;
}

void CRiskManager::ExecuteRiskAction(ENUM_RISK_ACTION action, string reason) {
    LogRisk(LOG_COMPONENT_RISK, "Wykonywanie akcji ryzyka", (double)action, reason);
    
    switch(action) {
        case RISK_ACTION_REDUCE_SIZE:
            // Zmniejszenie rozmiaru pozycji
            ReducePositionSizes();
            break;
            
        case RISK_ACTION_CLOSE_POSITION:
            // Zamknięcie pozycji
            CloseAllPositions();
            break;
            
        case RISK_ACTION_ADD_HEDGE:
            // Dodanie hedgingu
            AddHedgingPositions();
            break;
            
        case RISK_ACTION_TIGHTEN_STOPS:
            // Dokładnienie stopów
            TightenStopLosses();
            break;
            
        case RISK_ACTION_SUSPEND_TRADING:
            // Zawieszenie handlu
            SuspendTrading(reason);
            break;
            
        case RISK_ACTION_EMERGENCY_EXIT:
            // Awaryjne wyjście
            EmergencyExit(reason);
            break;
            
        default:
            break;
    }
    
    // Callback
    if(m_has_risk_action_callback) {
        // Callback wykonany
    }
}

// === METODY ALERTÓW I OSTRZEŻEŃ ===

int CRiskManager::GetActiveAlertCount() {
    int count = 0;
    for(int i = 0; i < ArraySize(m_active_alerts); i++) {
        if(m_active_alerts[i].is_active) count++;
    }
    return count;
}

void CRiskManager::AcknowledgeAlert(int alert_index) {
    if(alert_index >= 0 && alert_index < ArraySize(m_active_alerts)) {
        m_active_alerts[alert_index].is_acknowledged = true;
        m_active_alerts[alert_index].action_time = TimeCurrent();
    }
}

void CRiskManager::ClearAlert(int alert_index) {
    if(alert_index >= 0 && alert_index < ArraySize(m_active_alerts)) {
        m_active_alerts[alert_index].is_active = false;
    }
}

void CRiskManager::ClearAllAlerts() {
    for(int i = 0; i < ArraySize(m_active_alerts); i++) {
        m_active_alerts[i].is_active = false;
    }
}

// === IMPLEMENTACJA RAPORTÓW I FUNKCJI POMOCNICZYCH ===

RiskStatistics CRiskManager::GetStatistics() {
    RiskStatistics stats;
    stats.current_risk = m_risk_analysis.total_risk_score;
    stats.max_risk = m_risk_parameters.emergency_threshold;
    stats.risk_per_trade = m_risk_parameters.risk_per_trade;
    stats.daily_risk = m_risk_parameters.risk_per_day;
    stats.portfolio_risk = m_risk_analysis.total_risk_score;
    stats.open_positions = 0; // TODO: Implement position counting
    stats.total_exposure = m_risk_analysis.total_exposure;
    stats.max_drawdown = m_risk_analysis.max_drawdown;
    // Note: var_95, var_99, and last_risk_update fields don't exist in RiskStatistics struct
    return stats;
}

string CRiskManager::GetRiskReport() {
    string report = "=== RAPORT RYZYKA ===\n";
    report += "Symbol: " + m_symbol + "\n";
    report += "Strategia: " + EnumToString(m_current_strategy) + "\n";
    report += "Status handlu: " + (m_trading_suspended ? "ZAWIESZONY" : "AKTYWNY") + "\n";
    report += "Ostatnia aktualizacja: " + TimeToString(m_risk_analysis.last_update) + "\n\n";
    
    report += "--- PODSTAWOWE METRYKI RYZYKA ---\n";
    report += "Całkowity wynik ryzyka: " + DoubleToString(m_risk_analysis.total_risk_score, 2) + "%\n";
    report += "Ryzyko rynkowe: " + DoubleToString(m_risk_analysis.market_risk, 2) + "%\n";
    report += "Ryzyko płynności: " + DoubleToString(m_risk_analysis.liquidity_risk, 2) + "%\n";
    report += "Ryzyko volatilności: " + DoubleToString(m_risk_analysis.volatility_risk, 2) + "%\n";
    report += "Ryzyko korelacji: " + DoubleToString(m_risk_analysis.correlation_risk, 2) + "%\n";
    report += "Ryzyko koncentracji: " + DoubleToString(m_risk_analysis.concentration_risk, 2) + "%\n";
    report += "Ryzyko dźwigni: " + DoubleToString(m_risk_analysis.leverage_risk, 2) + "%\n\n";
    
    report += "--- ZAAWANSOWANE METRYKI ---\n";
    report += "VaR (95%): " + DoubleToString(m_risk_analysis.var_95, 4) + "%\n";
    report += "VaR (99%): " + DoubleToString(m_risk_analysis.var_99, 4) + "%\n";
    report += "Expected Shortfall: " + DoubleToString(m_risk_analysis.expected_shortfall, 4) + "%\n";
    report += "Maksymalny drawdown: " + DoubleToString(m_risk_analysis.max_drawdown, 2) + "%\n";
    report += "Współczynnik Sharpe: " + DoubleToString(m_risk_analysis.sharpe_ratio, 3) + "\n";
    report += "Współczynnik Sortino: " + DoubleToString(m_risk_analysis.sortino_ratio, 3) + "\n";
    report += "Współczynnik Calmar: " + DoubleToString(m_risk_analysis.calmar_ratio, 3) + "\n\n";
    
    report += "--- METRYKI POZYCJI ---\n";
    report += "Całkowita ekspozycja: " + DoubleToString(m_risk_analysis.total_exposure, 2) + "\n";
    report += "Netto ekspozycja: " + DoubleToString(m_risk_analysis.net_exposure, 2) + "\n";
    report += "Brutto ekspozycja: " + DoubleToString(m_risk_analysis.gross_exposure, 2) + "\n";
    report += "Koncentracja pozycji: " + DoubleToString(m_risk_analysis.position_concentration, 2) + "%\n\n";
    
    report += "--- METRYKI CZASOWE ---\n";
    report += "Dzienne VaR: " + DoubleToString(m_risk_analysis.daily_var, 4) + "%\n";
    report += "Tygodniowe VaR: " + DoubleToString(m_risk_analysis.weekly_var, 4) + "%\n";
    report += "Miesięczne VaR: " + DoubleToString(m_risk_analysis.monthly_var, 4) + "%\n";
    report += "Wynik testów stresowych: " + DoubleToString(m_risk_analysis.stress_test_score, 2) + "\n\n";
    
    report += "--- ALERTY ---\n";
    report += "Liczba aktywnych alertów: " + IntegerToString(GetActiveAlertCount()) + "\n";
    
    return report;
}

string CRiskManager::GetRiskSummary() {
    string summary = "🛡️ RYZYKO: " + DoubleToString(m_risk_analysis.total_risk_score, 1) + "%";
    
    if(m_risk_analysis.total_risk_score >= m_risk_parameters.emergency_threshold) {
        summary += " [🚨 KRYTYCZNE]";
    }
    else if(m_risk_analysis.total_risk_score >= m_risk_parameters.critical_threshold) {
        summary += " [⚠️ EKSTREMALNE]";
    }
    else if(m_risk_analysis.total_risk_score >= m_risk_parameters.alert_threshold) {
        summary += " [🔴 WYSOKIE]";
    }
    else if(m_risk_analysis.total_risk_score >= m_risk_parameters.warning_threshold) {
        summary += " [🟡 UMIARKOWANE]";
    }
    else {
        summary += " [🟢 NISKIE]";
    }
    
    summary += " | VaR: " + DoubleToString(m_risk_analysis.var_95, 2) + "%";
    summary += " | DD: " + DoubleToString(m_risk_analysis.max_drawdown, 1) + "%";
    summary += " | Sharpe: " + DoubleToString(m_risk_analysis.sharpe_ratio, 2);
    
    return summary;
}

string CRiskManager::GetAlertReport() {
    string report = "=== RAPORT ALERTÓW ===\n";
    report += "Liczba aktywnych alertów: " + IntegerToString(GetActiveAlertCount()) + "\n\n";
    
    for(int i = 0; i < ArraySize(m_active_alerts); i++) {
        if(m_active_alerts[i].is_active) {
            report += "Alert #" + IntegerToString(i + 1) + ":\n";
            report += "  Typ: " + EnumToString(m_active_alerts[i].risk_type) + "\n";
            report += "  Poziom: " + EnumToString(m_active_alerts[i].risk_level) + "\n";
            report += "  Akcja: " + EnumToString(m_active_alerts[i].recommended_action) + "\n";
            report += "  Wiadomość: " + m_active_alerts[i].alert_message + "\n";
            report += "  Wartość ryzyka: " + DoubleToString(m_active_alerts[i].risk_value, 2) + "%\n";
            report += "  Próg: " + DoubleToString(m_active_alerts[i].threshold_value, 2) + "%\n";
            report += "  Czas: " + TimeToString(m_active_alerts[i].alert_time) + "\n";
            report += "  Status: " + (m_active_alerts[i].is_acknowledged ? "PRZETWORZONY" : "OCZEKUJĄCY") + "\n";
            
            if(m_active_alerts[i].action_taken != "") {
                report += "  Akcja wykonana: " + m_active_alerts[i].action_taken + "\n";
                report += "  Czas akcji: " + TimeToString(m_active_alerts[i].action_time) + "\n";
            }
            
            report += "\n";
        }
    }
    
    return report;
}

void CRiskManager::ExportRiskHistory(string filename) {
    int handle = FileOpen(filename, FILE_WRITE | FILE_CSV);
    
    if(handle != INVALID_HANDLE) {
        // Nagłówek CSV
        FileWrite(handle, "Timestamp", "TotalRisk", "MarketRisk", "LiquidityRisk", "VolatilityRisk", 
                 "VaR95", "MaxDrawdown", "TotalExposure", "ActivePositions", "MarketCondition", "RiskStrategy");
        
        // Dane
        for(int i = 0; i < ArraySize(m_risk_history); i++) {
            FileWrite(handle, 
                     TimeToString(m_risk_history[i].timestamp),
                     DoubleToString(m_risk_history[i].total_risk_score, 2),
                     DoubleToString(m_risk_history[i].market_risk, 2),
                     DoubleToString(m_risk_history[i].liquidity_risk, 2),
                     DoubleToString(m_risk_history[i].volatility_risk, 2),
                     DoubleToString(m_risk_history[i].var_95, 4),
                     DoubleToString(m_risk_history[i].max_drawdown, 2),
                     DoubleToString(m_risk_history[i].total_exposure, 2),
                     IntegerToString(m_risk_history[i].active_positions),
                     m_risk_history[i].market_condition,
                     m_risk_history[i].risk_strategy);
        }
        
        FileClose(handle);
        Print("📊 Historia ryzyka wyeksportowana do: ", filename);
    } else {
        Print("❌ Błąd eksportu historii ryzyka");
    }
}

// === FUNKCJE POMOCNICZE DLA AKCJI RYZYKA ===

void CRiskManager::ReducePositionSizes() {
    Print("🛡️ Zmniejszanie rozmiarów pozycji...");
    // Implementacja zmniejszania rozmiarów pozycji
}

void CRiskManager::CloseAllPositions() {
    Print("🛡️ Zamykanie wszystkich pozycji...");
    // Implementacja zamykania pozycji
}

void CRiskManager::AddHedgingPositions() {
    Print("🛡️ Dodawanie pozycji hedgingowych...");
    // Implementacja dodawania hedgingu
}

void CRiskManager::TightenStopLosses() {
    Print("🛡️ Dokładnienie stop loss...");
    // Implementacja dokładnienia stopów
}

void CRiskManager::SuspendTrading() {
    SuspendTrading("Ręczne zawieszenie");
}

void CRiskManager::SuspendTrading(string reason) {
    if(!m_trading_suspended) {
        m_trading_suspended = true;
        m_suspension_time = TimeCurrent();
        
        Print("🛡️ Handel zawieszony: ", reason);
        
        if(m_has_trading_suspended_callback) {
            // Callback wykonany
        }
    }
}

void CRiskManager::EmergencyExit() {
    EmergencyExit("Ręczne awaryjne wyjście");
}

void CRiskManager::EmergencyExit(string reason) {
    Print("🚨 AWARYJNE WYJŚCIE: ", reason);
    
    // Zamknięcie wszystkich pozycji
    CloseAllPositions();
    
    // Zawieszenie handlu
    SuspendTrading("Awaryjne wyjście - " + reason);
}

// === IMPLEMENTACJA CALLBACKÓW ===

void CRiskManager::SetOnRiskAlert(bool enable) {
    m_has_risk_alert_callback = enable;
}

void CRiskManager::SetOnRiskAction(bool enable) {
    m_has_risk_action_callback = enable;
}

void CRiskManager::SetOnTradingSuspended(bool enable) {
    m_has_trading_suspended_callback = enable;
}

void CRiskManager::SetOnTradingResumed(bool enable) {
    m_has_trading_resumed_callback = enable;
}

// === GLOBALNA INSTANCJA ===
// g_risk_manager is declared in BohmeMainSystem.mq5
extern CRiskManager* g_risk_manager;

// === FUNKCJE GLOBALNE ===

bool InitializeGlobalRiskManager(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
    if(g_risk_manager != NULL) delete g_risk_manager;
    g_risk_manager = new CRiskManager();
    return g_risk_manager.Initialize(symbol, timeframe);
}

void ReleaseGlobalRiskManager() {
    if(g_risk_manager != NULL) {
        delete g_risk_manager;
        g_risk_manager = NULL;
    }
}

// === FUNKCJE DOSTĘPU GLOBALNEGO ===

SRiskAnalysis GetRiskAnalysis() {
    if(g_risk_manager != NULL) {
        return g_risk_manager.GetRiskAnalysis();
    } else {
        SRiskAnalysis default_analysis;
        ZeroMemory(default_analysis);
        return default_analysis;
    }
}

SRiskParameters GetRiskParameters() {
    if(g_risk_manager != NULL) {
        return g_risk_manager.GetRiskParameters();
    } else {
        SRiskParameters default_parameters;
        ZeroMemory(default_parameters);
        return default_parameters;
    }
}

double GetTotalRiskScore() {
    return g_risk_manager != NULL ? g_risk_manager.GetTotalRiskScore() : 0.0;
}

double GetMarketRisk() {
    return g_risk_manager != NULL ? g_risk_manager.GetMarketRisk() : 0.0;
}

double GetLiquidityRisk() {
    return g_risk_manager != NULL ? g_risk_manager.GetLiquidityRisk() : 0.0;
}

double GetVolatilityRisk() {
    return g_risk_manager != NULL ? g_risk_manager.GetVolatilityRisk() : 0.0;
}

double GetVaR(double confidence_level = 0.95) {
    return g_risk_manager != NULL ? g_risk_manager.GetVaR(confidence_level) : 0.0;
}

double GetMaxDrawdown() {
    return g_risk_manager != NULL ? g_risk_manager.GetMaxDrawdown() : 0.0;
}

double GetSharpeRatio() {
    return g_risk_manager != NULL ? g_risk_manager.GetSharpeRatio() : 0.0;
}

bool IsTradingAllowed() {
    return g_risk_manager != NULL ? g_risk_manager.IsTradingAllowed() : true;
}

bool IsRiskAcceptable() {
    return g_risk_manager != NULL ? g_risk_manager.IsRiskAcceptable() : true;
}

ENUM_RISK_ACTION GetRecommendedRiskAction() {
    return g_risk_manager != NULL ? g_risk_manager.GetRecommendedAction() : RISK_ACTION_NONE;
}

void ExecuteRiskAction(ENUM_RISK_ACTION action, string reason = "") {
    if(g_risk_manager != NULL) {
        g_risk_manager.ExecuteRiskAction(action, reason);
    }
}

// === FUNKCJE ALERTÓW ===

int GetActiveAlertCount() {
    return g_risk_manager != NULL ? g_risk_manager.GetActiveAlertCount() : 0;
}

void GetActiveAlerts(SRiskAlert &alerts[]) {
    if(g_risk_manager != NULL) {
        g_risk_manager.GetActiveAlerts(alerts);
    } else {
        ArrayResize(alerts, 0);
    }
}

void AcknowledgeAlert(int alert_index) {
    if(g_risk_manager != NULL) {
        g_risk_manager.AcknowledgeAlert(alert_index);
    }
}

void ClearAlert(int alert_index) {
    if(g_risk_manager != NULL) {
        g_risk_manager.ClearAlert(alert_index);
    }
}

void ClearAllAlerts() {
    if(g_risk_manager != NULL) {
        g_risk_manager.ClearAllAlerts();
    }
}

// === FUNKCJE RAPORTÓW ===

string GetRiskReport() {
    return g_risk_manager != NULL ? g_risk_manager.GetRiskReport() : "Risk Manager nie zainicjalizowany";
}

string GetRiskSummary() {
    return g_risk_manager != NULL ? g_risk_manager.GetRiskSummary() : "Risk Manager nie zainicjalizowany";
}

string GetAlertReport() {
    return g_risk_manager != NULL ? g_risk_manager.GetAlertReport() : "Risk Manager nie zainicjalizowany";
}

void ExportRiskHistory(string filename) {
    if(g_risk_manager != NULL) {
        g_risk_manager.ExportRiskHistory(filename);
    }
}

// === FUNKCJE ZARZĄDZANIA ===

void SetRiskStrategy(ENUM_RISK_STRATEGY strategy) {
    if(g_risk_manager != NULL) {
        g_risk_manager.SetRiskStrategy(strategy);
    }
}

void SetRiskParameters(SRiskParameters &parameters) {
    if(g_risk_manager != NULL) {
        g_risk_manager.SetRiskParameters(parameters);
    }
}

void UpdateRiskManager() {
    if(g_risk_manager != NULL) {
        g_risk_manager.Update();
    }
}

// === FUNKCJE CALLBACKÓW GLOBALNYCH ===

void SetOnRiskAlert(bool enable) {
    if(g_risk_manager != NULL) {
        g_risk_manager.SetOnRiskAlert(enable);
    }
}

void SetOnRiskAction(bool enable) {
    if(g_risk_manager != NULL) {
        g_risk_manager.SetOnRiskAction(enable);
    }
}

void SetOnTradingSuspended(bool enable) {
    if(g_risk_manager != NULL) {
        g_risk_manager.SetOnTradingSuspended(enable);
    }
}

void SetOnTradingResumed(bool enable) {
    if(g_risk_manager != NULL) {
        g_risk_manager.SetOnTradingResumed(enable);
    }
}

#endif // RISK_MANAGER_H
