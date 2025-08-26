#ifndef POSITION_MANAGER_H
#define POSITION_MANAGER_H

// ========================================
// POSITION MANAGER - ZARZĄDZANIE POZYCJAMI
// ========================================
// Praktyczny system zarządzania pozycjami z OGRANICZONĄ liczbą estymatorów
// Skupia się na estymatorach mających rzeczywiste zastosowanie na rynku

#include <Trade\Trade.mqh>
#include <Trade\PositionInfo.mqh>
#include <Trade\OrderInfo.mqh>
#include "../Utils/LoggingSystem.mqh"

// === ENUMERACJE ===

// Stany pozycji (dla Position Manager)
enum ENUM_PM_POSITION_STATE {
    PM_POSITION_STATE_OPEN,            // Pozycja otwarta
    PM_POSITION_STATE_PROFIT,          // Pozycja na plusie
    PM_POSITION_STATE_LOSS,            // Pozycja na minusie
    PM_POSITION_STATE_BREAKEVEN,       // Pozycja na zero
    PM_POSITION_STATE_CRITICAL,        // Pozycja krytyczna
    PM_POSITION_STATE_CLOSED           // Pozycja zamknięta
};

// Typy pozycji (dla Position Manager)
enum ENUM_PM_POSITION_TYPE {
    PM_POSITION_TYPE_LONG,             // Pozycja długa
    PM_POSITION_TYPE_SHORT,            // Pozycja krótka
    PM_POSITION_TYPE_SCALP,            // Pozycja skalpowa
    PM_POSITION_TYPE_SWING,            // Pozycja swingowa
    PM_POSITION_TYPE_GRID              // Pozycja grid
};

// Poziomy ryzyka (dla Position Manager)
enum ENUM_PM_RISK_LEVEL {
    PM_RISK_LOW,                       // Niskie ryzyko
    PM_RISK_MODERATE,                  // Umiarkowane ryzyko
    PM_RISK_HIGH,                      // Wysokie ryzyko
    PM_RISK_EXTREME                    // Ekstremalne ryzyko
};

// === STRUKTURY DANYCH ===

// Struktura pozycji
struct SPosition {
    ulong ticket;                   // Ticket pozycji
    string symbol;                  // Symbol
    ENUM_PM_POSITION_TYPE type;        // Typ pozycji
    ENUM_PM_POSITION_STATE state;      // Stan pozycji
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
    double risk_reward_ratio;       // Stosunek ryzyko/nagroda
    double drawdown;                // Drawdown
    double max_drawdown;            // Maksymalny drawdown
    string strategy_name;           // Nazwa strategii
    bool is_managed;                // Czy zarządzane
    string custom_data;             // Dane niestandardowe
};

// Struktura estymatorów rynkowych - OGRANICZONA LICZBA (5 praktycznych)
struct SMarketEstimators {
    double realized_volatility;     // 1. Realizowana zmienność (klasyczna)
    double atr_volatility;          // 2. ATR-based zmienność (praktyczna)
    double price_momentum;          // 3. Momentum cenowe (trend strength)
    double volume_profile;          // 4. Profil wolumenu (liquidity)
    double market_strength;         // 5. Siła rynku (composite)
    
    // === ZAAWANSOWANE ESTYMATORY Z FIRE SPIRIT ===
    double garch_volatility;        // 6. GARCH volatilność (modelowanie)
    double parkinson_volatility;    // 7. Parkinson volatilność (High-Low)
    double yang_zhang_volatility;   // 8. Yang-Zhang volatilność (OHLC)
    double rogers_satchell_volatility; // 9. Rogers-Satchell volatilność
    double price_energy;            // 10. Energia cenowa (acceleration)
    double volume_energy;           // 11. Energia wolumenu (surge)
    double momentum_energy;         // 12. Energia momentum (trend strength)
    double microstructure_energy;   // 13. Energia mikrostruktury (spread)
    double energy_dissipation;      // 14. Rozpraszanie energii
    double energy_trend;            // 15. Trend energii
    double energy_acceleration;     // 16. Przyspieszenie energii
    double volatility_clustering;   // 17. Klasteryzacja volatilności
    double local_volatility;        // 18. Lokalna volatilność
    
    double risk_level;              // Poziom ryzyka
    string market_condition;        // Stan rynku
    datetime last_update;           // Ostatnia aktualizacja
};

// Struktura zarządzania ryzykiem
struct SRiskManagement {
    double max_position_size;       // Maksymalny rozmiar pozycji
    double max_daily_loss;          // Maksymalna dzienna strata
    double max_drawdown_limit;      // Limit drawdown
    double risk_per_trade;          // Ryzyko na transakcję
    double total_risk;              // Całkowite ryzyko
    bool auto_hedge;                // Automatyczny hedging
    bool dynamic_sizing;            // Dynamiczny sizing
    string risk_strategy;           // Strategia ryzyka
    double risk_score;              // Wynik ryzyka
    string risk_warnings;           // Ostrzeżenia ryzyka
};

// Struktura statystyk pozycji
struct PositionStatistics {
    int total_positions;            // Całkowita liczba pozycji
    int long_positions;             // Pozycje długie
    int short_positions;            // Pozycje krótkie
    double total_position_value;    // Całkowita wartość pozycji
    double unrealized_pnl;          // Niezrealizowany P&L
    double realized_pnl;            // Zrealizowany P&L
    double total_pnl;               // Całkowity P&L
    double average_position_size;   // Średni rozmiar pozycji
    double max_position_size;       // Maksymalny rozmiar pozycji
    double min_position_size;       // Minimalny rozmiar pozycji
    double win_rate;                // Wskaźnik wygranych
    double avg_win;                 // Średni zysk
    double avg_loss;                // Średnia strata
    double profit_factor;           // Współczynnik zysku
    int winning_positions;          // Wygrane pozycje
    int losing_positions;           // Przegrane pozycje
    datetime last_position_time;    // Czas ostatniej pozycji
};

// === KLASA POSITION MANAGER ===

class CPositionManager {
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
    
    // Zarządzanie pozycjami
    SPosition m_positions[];
    SMarketEstimators m_estimators;
    SRiskManagement m_risk_management;
    
    // Cache
    datetime m_last_update;
    bool m_initialized;
    int m_max_positions;
    
    // Callback functions - MQL5 doesn't support function pointers, using flags instead
    bool m_has_position_opened_callback;
    bool m_has_position_closed_callback;
    bool m_has_risk_alert_callback;
    
public:
    // === KONSTRUKTOR I DESTRUKTOR ===
    CPositionManager() {
        m_symbol = _Symbol;
        m_timeframe = PERIOD_CURRENT;
        m_initialized = false;
        m_last_update = 0;
        m_max_positions = 50;
        
        // Resetowanie callbacków
        m_has_position_opened_callback = false;
        m_has_position_closed_callback = false;
        m_has_risk_alert_callback = false;
        
        // Inicjalizacja zarządzania ryzykiem
        InitializeRiskManagement();
    }
    
    ~CPositionManager() {
        // Zwalnianie zasobów
        ArrayFree(m_positions);
    }
    
    // === INICJALIZACJA ===
    bool Initialize(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
        if(symbol != "") m_symbol = symbol;
        if(timeframe != PERIOD_CURRENT) m_timeframe = timeframe;
        
        LogInfo(LOG_COMPONENT_POSITION, "Inicjalizacja Position Manager", "Symbol: " + m_symbol);
        
        // Pobranie informacji o symbolu
        if(!GetSymbolInfo()) {
            LogError(LOG_COMPONENT_POSITION, "Błąd pobierania informacji o symbolu", 0.0, m_symbol);
            return false;
        }
        
        // Inicjalizacja handlu
        if(!InitializeTrading()) {
            LogError(LOG_COMPONENT_POSITION, "Błąd inicjalizacji handlu", 0.0, m_symbol);
            return false;
        }
        
        // Wczytanie istniejących pozycji
        if(!LoadExistingPositions()) {
            LogError(LOG_COMPONENT_POSITION, "Błąd wczytywania istniejących pozycji", 0.0, m_symbol);
            return false;
        }
        
        // Inicjalizacja estymatorów
        UpdateMarketEstimators();
        
        m_initialized = true;
        m_last_update = TimeCurrent();
        
        LogInfo(LOG_COMPONENT_POSITION, "Position Manager zainicjalizowany", 
                "Pozycje: " + IntegerToString(ArraySize(m_positions)));
        
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
    
    // === WCZYTANIE ISTNIEJĄCYCH POZYCJI ===
    bool LoadExistingPositions() {
        ArrayResize(m_positions, 0);
        
        for(int i = 0; i < PositionsTotal(); i++) {
            if(PositionSelectByTicket(PositionGetTicket(i))) {
                if(PositionGetString(POSITION_SYMBOL) == m_symbol) {
                    SPosition position;
                    if(ConvertToPosition(position)) {
                        ArrayResize(m_positions, ArraySize(m_positions) + 1);
                        m_positions[ArraySize(m_positions) - 1] = position;
                    }
                }
            }
        }
        
        return true;
    }
    
    // === KONWERSJA POZYCJI ===
    bool ConvertToPosition(SPosition &position) {
        position.ticket = PositionGetTicket(0);
        position.symbol = PositionGetString(POSITION_SYMBOL);
        position.type = (ENUM_PM_POSITION_TYPE)PositionGetInteger(POSITION_TYPE);
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
        position.risk_reward_ratio = 0;
        position.drawdown = 0;
        position.max_drawdown = 0;
        position.strategy_name = "";
        position.is_managed = true;
        position.custom_data = "";
        
        // Określenie stanu pozycji
        UpdatePositionState(position);
        
        return true;
    }
    
    // === INICJALIZACJA ZARZĄDZANIA RYZYKIEM ===
    void InitializeRiskManagement() {
        m_risk_management.max_position_size = 1.0;
        m_risk_management.max_daily_loss = 5.0;
        m_risk_management.max_drawdown_limit = 20.0;
        m_risk_management.risk_per_trade = 2.0;
        m_risk_management.total_risk = 0;
        m_risk_management.auto_hedge = false;
        m_risk_management.dynamic_sizing = true;
        m_risk_management.risk_strategy = "CONSERVATIVE";
        m_risk_management.risk_score = 0;
        m_risk_management.risk_warnings = "";
    }
    
    // === ESTYMATORY RYNKOWE - OGRANICZONA LICZBA (5 praktycznych) ===
    
    // 1. REALIZOWANA ZMIENNOŚĆ (klasyczna)
    double CalculateRealizedVolatility() {
        double prices[];
        int bars = 20;
        
        if(CopyClose(m_symbol, m_timeframe, 0, bars, prices) != bars) {
            return 0.0;
        }
        
        double returns[];
        ArrayResize(returns, bars - 1);
        
        for(int i = 1; i < bars; i++) {
            if(prices[i-1] > 0) {
                returns[i-1] = MathLog(prices[i] / prices[i-1]);
            }
        }
        
        double mean_return = 0.0;
        for(int i = 0; i < bars - 1; i++) {
            mean_return += returns[i];
        }
        mean_return /= (bars - 1);
        
        double variance = 0.0;
        for(int i = 0; i < bars - 1; i++) {
            variance += MathPow(returns[i] - mean_return, 2);
        }
        variance /= (bars - 1);
        
        return MathSqrt(variance * 252.0); // Annualized
    }
    
    // 2. ATR-BASED ZMIENNOŚĆ (praktyczna)
    double CalculateATRVolatility() {
        double atr = iATR(m_symbol, m_timeframe, 14, 0);
        double current_price = iClose(m_symbol, m_timeframe, 0);
        
        if(current_price > 0) {
            return (atr / current_price) * 100.0; // Procentowa zmienność
        }
        
        return 0.0;
    }
    
    // 3. MOMENTUM CENOWE (trend strength)
    double CalculatePriceMomentum() {
        double prices[];
        int bars = 10;
        
        if(CopyClose(m_symbol, m_timeframe, 0, bars, prices) != bars) {
            return 0.0;
        }
        
        // Momentum jako zmiana ceny w czasie
        double momentum = (prices[0] - prices[bars-1]) / prices[bars-1] * 100.0;
        
        return momentum;
    }
    
    // 4. PROFIL WOLUMENU (liquidity)
    double CalculateVolumeProfile() {
        long volumes[];
        int bars = 20;
        
        if(CopyTickVolume(m_symbol, m_timeframe, 0, bars, volumes) != bars) {
            return 0.0;
        }
        
        double avg_volume = 0.0;
        for(int i = 0; i < bars; i++) {
            avg_volume += volumes[i];
        }
        avg_volume /= bars;
        
        double current_volume = volumes[0];
        
        if(avg_volume > 0) {
            return (current_volume / avg_volume) * 100.0; // Procent względem średniej
        }
        
        return 100.0; // Neutral
    }
    
    // 5. SIŁA RYNKU (composite indicator)
    double CalculateMarketStrength() {
        double volatility = m_estimators.realized_volatility;
        double momentum = m_estimators.price_momentum;
        double volume = m_estimators.volume_profile;
        
        // Normalizacja do 0-100
        double vol_score = MathMin(100.0, volatility * 1000.0);
        double mom_score = 50.0 + (momentum * 10.0); // -50 do +50
        double vol_score_norm = MathMin(100.0, volume);
        
        // Ważona średnia
        double strength = (vol_score * 0.3 + 
                          MathAbs(mom_score) * 0.4 + 
                          vol_score_norm * 0.3);
        
        return MathMax(0.0, MathMin(100.0, strength));
    }
    
    // === ZAAWANSOWANE ESTYMATORY Z FIRE SPIRIT ===
    
    // 6. GARCH VOLATILITY (modelowanie)
    double CalculateGARCHVolatility() {
        double returns[];
        int bars = 20;
        
        if(GetReturns(returns, bars) < bars) return 0.0;
        
        // GARCH(1,1) parameters (typical values)
        double omega = 0.000001;  // Long-term variance
        double alpha = 0.1;       // ARCH coefficient
        double beta = 0.85;       // GARCH coefficient
        
        double variance = omega / (1.0 - alpha - beta); // Unconditional variance
        
        // GARCH iteration
        for(int i = 1; i < bars; i++) {
            variance = omega + alpha * MathPow(returns[i-1], 2) + beta * variance;
        }
        
        return MathSqrt(variance * 252.0); // Annualized volatility
    }
    
    // 7. PARKINSON VOLATILITY (using High-Low)
    double CalculateParkinsonVolatility() {
        double highs[], lows[];
        int bars = 20;
        
        if(CopyHigh(m_symbol, m_timeframe, 0, bars, highs) != bars ||
           CopyLow(m_symbol, m_timeframe, 0, bars, lows) != bars) {
            return 0.0;
        }
        
        double sum_log_hl = 0.0;
        for(int i = 0; i < bars; i++) {
            if(highs[i] > 0 && lows[i] > 0) {
                sum_log_hl += MathPow(MathLog(highs[i] / lows[i]), 2);
            }
        }
        
        // Parkinson estimator
        double parkinson_var = sum_log_hl / (4.0 * MathLog(2.0) * bars);
        return MathSqrt(parkinson_var * 252.0); // Annualized
    }
    
    // 8. YANG-ZHANG VOLATILITY (complete OHLC information)
    double CalculateYangZhangVolatility() {
        double opens[], highs[], lows[], closes[];
        int bars = 20;
        
        if(CopyOpen(m_symbol, m_timeframe, 0, bars, opens) != bars ||
           CopyHigh(m_symbol, m_timeframe, 0, bars, highs) != bars ||
           CopyLow(m_symbol, m_timeframe, 0, bars, lows) != bars ||
           CopyClose(m_symbol, m_timeframe, 0, bars, closes) != bars) {
            return 0.0;
        }
        
        double overnight_sum = 0.0;
        double rs_sum = 0.0;
        double close_to_close_sum = 0.0;
        
        for(int i = 1; i < bars; i++) {
            // Overnight return
            if(opens[i] > 0 && closes[i-1] > 0) {
                double overnight = MathLog(opens[i] / closes[i-1]);
                overnight_sum += MathPow(overnight, 2);
            }
            
            // Rogers-Satchell component
            if(highs[i] > 0 && opens[i] > 0 && lows[i] > 0 && closes[i] > 0) {
                double rs = MathLog(highs[i] / closes[i]) * MathLog(highs[i] / opens[i]) +
                           MathLog(lows[i] / closes[i]) * MathLog(lows[i] / opens[i]);
                rs_sum += rs;
            }
            
            // Close-to-close
            if(closes[i] > 0 && closes[i-1] > 0) {
                double cc = MathLog(closes[i] / closes[i-1]);
                close_to_close_sum += MathPow(cc, 2);
            }
        }
        
        // Yang-Zhang estimator
        double k = 0.34 / (1.34 + (bars + 1.0) / (bars - 1.0));
        double yang_zhang_var = overnight_sum / (bars - 1.0) + 
                               k * close_to_close_sum / (bars - 1.0) + 
                               (1.0 - k) * rs_sum / (bars - 1.0);
        
        return MathSqrt(yang_zhang_var * 252.0); // Annualized
    }
    
    // 9. ROGERS-SATCHELL VOLATILITY
    double CalculateRogersSatchellVolatility() {
        double opens[], highs[], lows[], closes[];
        int bars = 20;
        
        if(CopyOpen(m_symbol, m_timeframe, 0, bars, opens) != bars ||
           CopyHigh(m_symbol, m_timeframe, 0, bars, highs) != bars ||
           CopyLow(m_symbol, m_timeframe, 0, bars, lows) != bars ||
           CopyClose(m_symbol, m_timeframe, 0, bars, closes) != bars) {
            return 0.0;
        }
        
        double rs_sum = 0.0;
        
        for(int i = 0; i < bars; i++) {
            if(highs[i] > 0 && opens[i] > 0 && lows[i] > 0 && closes[i] > 0) {
                double rs = MathLog(highs[i] / closes[i]) * MathLog(highs[i] / opens[i]) +
                           MathLog(lows[i] / closes[i]) * MathLog(lows[i] / opens[i]);
                rs_sum += rs;
            }
        }
        
        // Rogers-Satchell estimator
        double rs_var = rs_sum / bars;
        return MathSqrt(MathAbs(rs_var) * 252.0); // Annualized
    }
    
    // 10. PRICE ENERGY (acceleration)
    double CalculatePriceEnergy() {
        double prices[];
        int bars = 50;
        
        if(CopyClose(m_symbol, m_timeframe, 0, bars, prices) != bars) {
            return 0.0;
        }
        
        // Price acceleration energy
        double energy = 0.0;
        for(int i = 2; i < bars; i++) {
            double velocity = (prices[i] - prices[i-1]) / prices[i-1];
            double acceleration = velocity - (prices[i-1] - prices[i-2]) / prices[i-2];
            energy += MathPow(acceleration, 2);
        }
        
        // Normalize energy
        energy = MathSqrt(energy / (bars - 2)) * 10000.0; // Scale up
        
        return MathMax(0, MathMin(100, energy));
    }
    
    // 11. VOLUME ENERGY (surge)
    double CalculateVolumeEnergy() {
        long volumes[];
        int bars = 50;
        
        if(CopyTickVolume(m_symbol, m_timeframe, 0, bars, volumes) != bars) {
            return 0.0;
        }
        
        // Volume surge energy
        double avg_volume = 0.0;
        for(int i = 0; i < bars - 1; i++) {
            avg_volume += volumes[i];
        }
        avg_volume /= (bars - 1);
        
        double current_volume = volumes[bars - 1];
        double volume_energy = (current_volume / avg_volume - 1.0) * 100.0;
        
        return MathMax(0, MathMin(100, volume_energy));
    }
    
    // 12. MOMENTUM ENERGY (trend strength)
    double CalculateMomentumEnergy() {
        double prices[];
        int bars = 10;
        
        if(CopyClose(m_symbol, m_timeframe, 0, bars, prices) != bars) {
            return 0.0;
        }
        
        // Momentum as price acceleration
        double momentum = (prices[0] - prices[bars-1]) / prices[bars-1] * 100.0;
        
        return MathAbs(momentum);
    }
    
    // 13. MICROSTRUCTURE ENERGY (spread)
    double CalculateMicrostructureEnergy() {
        // Bid-ask spread approximation using ATR
        double atr = iATR(m_symbol, m_timeframe, 14, 0);
        double current_price = iClose(m_symbol, m_timeframe, 0);
        
        if(current_price > 0) {
            double spread_ratio = (atr / current_price) * 100.0;
            return MathMin(100.0, spread_ratio * 1000.0); // Scale up
        }
        
        return 0.0;
    }
    
    // 14. ENERGY DISSIPATION
    double CalculateEnergyDissipation() {
        // Simplified energy dissipation calculation
        double recent_energy = m_estimators.price_energy;
        double older_energy = m_estimators.price_energy * 0.9; // Approximation
        
        if(older_energy > 0) {
            double dissipation = (older_energy - recent_energy) / older_energy * 100.0;
            return MathMax(0.0, MathMin(100.0, dissipation));
        }
        
        return 0.0;
    }
    
    // 15. ENERGY TREND
    double CalculateEnergyTrend() {
        // Simplified energy trend calculation
        double current_energy = m_estimators.price_energy;
        double previous_energy = current_energy * 0.95; // Approximation
        
        return current_energy - previous_energy;
    }
    
    // 16. ENERGY ACCELERATION
    double CalculateEnergyAcceleration() {
        double current_trend = CalculateEnergyTrend();
        double previous_trend = current_trend * 0.9; // Approximation
        
        return current_trend - previous_trend;
    }
    
    // 17. VOLATILITY CLUSTERING
    double CalculateVolatilityClustering() {
        double returns[];
        int bars = 100;
        
        if(GetReturns(returns, bars) < bars) return 0.0;
        
        double cluster_score = 0.0;
        int window = 10;
        
        for(int i = window; i < bars - window; i++) {
            double local_vol = CalculateLocalVolatility(returns, i, window);
            double prev_vol = CalculateLocalVolatility(returns, i - window, window);
            
            // High volatility following high volatility = clustering
            if(local_vol > 0.02 && prev_vol > 0.02) { // Both above 2%
                cluster_score += 1.0;
            }
        }
        
        return cluster_score / (bars - 2 * window) * 100.0;
    }
    
    // 18. LOCAL VOLATILITY
    double CalculateLocalVolatility(double &returns[], int index, int window) {
        if(index < window || index >= ArraySize(returns) - window) {
            return 0.0;
        }
        
        double local_returns[];
        ArrayResize(local_returns, window);
        
        for(int i = 0; i < window; i++) {
            local_returns[i] = returns[index - window/2 + i];
        }
        
        double mean = 0.0;
        for(int i = 0; i < window; i++) {
            mean += local_returns[i];
        }
        mean /= window;
        
        double variance = 0.0;
        for(int i = 0; i < window; i++) {
            variance += MathPow(local_returns[i] - mean, 2);
        }
        variance /= window;
        
        return MathSqrt(variance * 252.0);
    }
    
    // Helper function for returns calculation
    int GetReturns(double &returns[], int bars) {
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
    
    // === AKTUALIZACJA ESTYMATORÓW ===
    void UpdateMarketEstimators() {
        // Podstawowe estymatory
        m_estimators.realized_volatility = CalculateRealizedVolatility();
        m_estimators.atr_volatility = CalculateATRVolatility();
        m_estimators.price_momentum = CalculatePriceMomentum();
        m_estimators.volume_profile = CalculateVolumeProfile();
        m_estimators.market_strength = CalculateMarketStrength();
        
        // Zaawansowane estymatory z Fire Spirit
        m_estimators.garch_volatility = CalculateGARCHVolatility();
        m_estimators.parkinson_volatility = CalculateParkinsonVolatility();
        m_estimators.yang_zhang_volatility = CalculateYangZhangVolatility();
        m_estimators.rogers_satchell_volatility = CalculateRogersSatchellVolatility();
        m_estimators.price_energy = CalculatePriceEnergy();
        m_estimators.volume_energy = CalculateVolumeEnergy();
        m_estimators.momentum_energy = CalculateMomentumEnergy();
        m_estimators.microstructure_energy = CalculateMicrostructureEnergy();
        m_estimators.energy_dissipation = CalculateEnergyDissipation();
        m_estimators.energy_trend = CalculateEnergyTrend();
        m_estimators.energy_acceleration = CalculateEnergyAcceleration();
        m_estimators.volatility_clustering = CalculateVolatilityClustering();
        double returns[];
        if(GetReturns(returns, 100) >= 100) {
            m_estimators.local_volatility = CalculateLocalVolatility(returns, 50, 10);
        } else {
            m_estimators.local_volatility = 0.0;
        }
        
        m_estimators.last_update = TimeCurrent();
        
        // Określenie stanu rynku
        DetermineMarketCondition();
        
        // Obliczenie poziomu ryzyka
        CalculateRiskLevel();
    }
    
    // === OKREŚLENIE STANU RYNKU ===
    void DetermineMarketCondition() {
        double volatility = m_estimators.realized_volatility;
        double momentum = MathAbs(m_estimators.price_momentum);
        double volume = m_estimators.volume_profile;
        
        // Zaawansowane estymatory
        double garch_vol = m_estimators.garch_volatility;
        double yang_zhang_vol = m_estimators.yang_zhang_volatility;
        double price_energy = m_estimators.price_energy;
        double energy_trend = m_estimators.energy_trend;
        double volatility_clustering = m_estimators.volatility_clustering;
        
        // Zaawansowana analiza stanu rynku
        if(volatility > 0.03 && garch_vol > 0.03 && yang_zhang_vol > 0.03 && momentum > 2.0 && volume > 120.0) {
            m_estimators.market_condition = "EXPLOSIVE_TRENDING";
        } else if(volatility > 0.03 && momentum > 2.0 && volume > 120.0) {
            m_estimators.market_condition = "TRENDING_HIGH_VOL";
        } else if(volatility > 0.02 && momentum > 1.0 && price_energy > 50.0) {
            m_estimators.market_condition = "ENERGETIC_TRENDING";
        } else if(volatility > 0.02 && momentum > 1.0) {
            m_estimators.market_condition = "TRENDING";
        } else if(volatility < 0.01 && momentum < 0.5 && energy_trend < 0) {
            m_estimators.market_condition = "DORMANT_LOW_VOL";
        } else if(volatility < 0.01 && momentum < 0.5) {
            m_estimators.market_condition = "SIDEWAYS_LOW_VOL";
        } else if(volatility > 0.025 && volatility_clustering > 50.0) {
            m_estimators.market_condition = "CLUSTERED_VOLATILE";
        } else if(volatility > 0.025 && volume > 150.0) {
            m_estimators.market_condition = "VOLATILE";
        } else if(volume < 80.0 && m_estimators.microstructure_energy > 30.0) {
            m_estimators.market_condition = "ILLIQUID_WIDE_SPREAD";
        } else if(volume < 80.0) {
            m_estimators.market_condition = "LOW_LIQUIDITY";
        } else if(energy_trend > 10.0 && price_energy > 60.0) {
            m_estimators.market_condition = "ENERGY_BUILDUP";
        } else if(m_estimators.energy_dissipation > 20.0) {
            m_estimators.market_condition = "ENERGY_DISSIPATING";
        } else {
            m_estimators.market_condition = "NORMAL";
        }
    }
    
    // === OBLICZENIE POZIOMU RYZYKA ===
    void CalculateRiskLevel() {
        double volatility = m_estimators.realized_volatility;
        double volume = m_estimators.volume_profile;
        double momentum = MathAbs(m_estimators.price_momentum);
        
        // Zaawansowane estymatory
        double garch_vol = m_estimators.garch_volatility;
        double yang_zhang_vol = m_estimators.yang_zhang_volatility;
        double price_energy = m_estimators.price_energy;
        double energy_trend = m_estimators.energy_trend;
        double volatility_clustering = m_estimators.volatility_clustering;
        double microstructure_energy = m_estimators.microstructure_energy;
        
        double risk_score = 0.0;
        
        // Czynnik zmienności (25%)
        double avg_volatility = (volatility + garch_vol + yang_zhang_vol) / 3.0;
        if(avg_volatility > 0.03) risk_score += 25.0;
        else if(avg_volatility > 0.02) risk_score += 15.0;
        else if(avg_volatility > 0.01) risk_score += 10.0;
        else risk_score += 3.0;
        
        // Czynnik płynności (20%)
        if(volume < 50.0) risk_score += 20.0;
        else if(volume < 80.0) risk_score += 15.0;
        else if(volume < 120.0) risk_score += 8.0;
        else risk_score += 3.0;
        
        // Czynnik momentum (15%)
        if(momentum > 3.0) risk_score += 15.0;
        else if(momentum > 2.0) risk_score += 10.0;
        else if(momentum > 1.0) risk_score += 5.0;
        else risk_score += 2.0;
        
        // Czynnik energii (15%)
        if(price_energy > 80.0) risk_score += 15.0;
        else if(price_energy > 60.0) risk_score += 10.0;
        else if(price_energy > 40.0) risk_score += 5.0;
        else risk_score += 2.0;
        
        // Czynnik klasteryzacji volatilności (10%)
        if(volatility_clustering > 70.0) risk_score += 10.0;
        else if(volatility_clustering > 50.0) risk_score += 7.0;
        else if(volatility_clustering > 30.0) risk_score += 4.0;
        else risk_score += 1.0;
        
        // Czynnik mikrostruktury (10%)
        if(microstructure_energy > 50.0) risk_score += 10.0;
        else if(microstructure_energy > 30.0) risk_score += 7.0;
        else if(microstructure_energy > 15.0) risk_score += 4.0;
        else risk_score += 1.0;
        
        // Czynnik trendu energii (5%)
        if(MathAbs(energy_trend) > 20.0) risk_score += 5.0;
        else if(MathAbs(energy_trend) > 10.0) risk_score += 3.0;
        else if(MathAbs(energy_trend) > 5.0) risk_score += 1.0;
        else risk_score += 0.5;
        
        m_estimators.risk_level = MathMax(0.0, MathMin(100.0, risk_score));
    }
    
    // === AKTUALIZACJA STANU POZYCJI ===
    void UpdatePositionState(SPosition &position) {
        if(position.unrealized_profit > 0) {
            position.state = PM_POSITION_STATE_PROFIT;
        } else if(position.unrealized_profit < 0) {
            position.state = PM_POSITION_STATE_LOSS;
            
            // Obliczenie drawdown
            position.drawdown = MathAbs(position.unrealized_profit);
            position.max_drawdown = MathMax(position.max_drawdown, position.drawdown);
            
            // Sprawdzenie czy pozycja krytyczna
            double account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
            if(account_balance > 0) {
                double loss_percentage = (position.drawdown / account_balance) * 100.0;
                if(loss_percentage > m_risk_management.max_drawdown_limit) {
                    position.state = PM_POSITION_STATE_CRITICAL;
                }
            }
        } else {
            position.state = PM_POSITION_STATE_BREAKEVEN;
        }
        
        // Obliczenie stosunku ryzyko/nagroda
        if(position.stop_loss > 0 && position.take_profit > 0) {
            double risk = MathAbs(position.current_price - position.stop_loss);
            double reward = MathAbs(position.take_profit - position.current_price);
            if(risk > 0) {
                position.risk_reward_ratio = reward / risk;
            }
        }
    }
    
    // === ZARZĄDZANIE POZYCJAMI ===
    void ManagePositions() {
        if(!m_initialized) return;
        
        // Aktualizacja estymatorów
        UpdateMarketEstimators();
        
        // Sprawdzenie każdej pozycji
        for(int i = 0; i < ArraySize(m_positions); i++) {
            SPosition &position = m_positions[i];
            
            if(PositionSelectByTicket(position.ticket)) {
                // Aktualizacja danych pozycji
                position.current_price = PositionGetDouble(POSITION_PRICE_CURRENT);
                position.unrealized_profit = PositionGetDouble(POSITION_PROFIT);
                position.swap = PositionGetDouble(POSITION_SWAP);
                position.margin = PositionGetDouble(POSITION_MARGIN);
                
                // Aktualizacja stanu
                UpdatePositionState(position);
                
                // Sprawdzenie czy pozycja wymaga zarządzania
                if(position.is_managed) {
                    ManageSinglePosition(position);
                }
            }
        }
        
        // Sprawdzenie ostrzeżeń ryzyka
        CheckRiskAlerts();
    }
    
    // === ZARZĄDZANIE POJEDYNCZĄ POZYCJĄ ===
    void ManageSinglePosition(SPosition &position) {
        // Trailing stop dla pozycji na plusie
        if(position.state == PM_POSITION_STATE_PROFIT && position.unrealized_profit > 0) {
            ApplyTrailingStop(position);
        }
        
        // Zamknięcie pozycji krytycznej
        if(position.state == PM_POSITION_STATE_CRITICAL) {
            ClosePosition(position.ticket, "Pozycja krytyczna - automatyczne zamknięcie");
        }
        
        // Dostosowanie stop loss na podstawie estymatorów
        if(m_estimators.risk_level > 70.0) {
            TightenStopLoss(position);
        }
    }
    
    // === TRAILING STOP ===
    void ApplyTrailingStop(SPosition &position) {
        double trailing_distance = m_estimators.atr_volatility * 2.0; // 2x ATR
        
        if(position.type == PM_POSITION_TYPE_LONG) {
            double new_stop = position.current_price - trailing_distance;
            if(new_stop > position.stop_loss) {
                ModifyStopLoss(position.ticket, new_stop);
                position.stop_loss = new_stop;
            }
        } else if(position.type == PM_POSITION_TYPE_SHORT) {
            double new_stop = position.current_price + trailing_distance;
            if(new_stop < position.stop_loss || position.stop_loss == 0) {
                ModifyStopLoss(position.ticket, new_stop);
                position.stop_loss = new_stop;
            }
        }
    }
    
    // === DOKŁADANIE STOP LOSS ===
    void TightenStopLoss(SPosition &position) {
        double tight_distance = m_estimators.atr_volatility * 1.5; // 1.5x ATR
        
        if(position.type == PM_POSITION_TYPE_LONG) {
            double new_stop = position.current_price - tight_distance;
            if(new_stop > position.stop_loss) {
                ModifyStopLoss(position.ticket, new_stop);
                position.stop_loss = new_stop;
            }
        } else if(position.type == PM_POSITION_TYPE_SHORT) {
            double new_stop = position.current_price + tight_distance;
            if(new_stop < position.stop_loss || position.stop_loss == 0) {
                ModifyStopLoss(position.ticket, new_stop);
                position.stop_loss = new_stop;
            }
        }
    }
    
    // === MODYFIKACJA STOP LOSS ===
    bool ModifyStopLoss(ulong ticket, double new_stop) {
        return m_trade.PositionModify(ticket, new_stop, 0);
    }
    
    // === ZAMKNIĘCIE POZYCJI ===
    bool ClosePosition(ulong ticket, string reason = "") {
        if(!m_initialized) return false;
        
        // Znalezienie pozycji
        int index = FindPositionByTicket(ticket);
        if(index == -1) {
            LogError(LOG_COMPONENT_POSITION, "Pozycja nie znaleziona", (double)ticket);
            return false;
        }
        
        SPosition &position = m_positions[index];
        
        // Zamknięcie pozycji
        if(m_trade.PositionClose(ticket)) {
            position.state = PM_POSITION_STATE_CLOSED;
            
            // Callback
            if(m_has_position_closed_callback) {
                // Callback wykonany
            }
            
            // Usunięcie z listy
            for(int i = index; i < ArraySize(m_positions) - 1; i++) {
                m_positions[i] = m_positions[i + 1];
            }
            ArrayResize(m_positions, ArraySize(m_positions) - 1);
            
            LogTrade(LOG_COMPONENT_POSITION, "Pozycja zamknięta", position.unrealized_profit, 
                    "Ticket: " + IntegerToString(ticket) + ", Powód: " + reason);
            return true;
        } else {
            LogError(LOG_COMPONENT_POSITION, "Błąd zamykania pozycji", (double)ticket, 
                    m_trade.ResultRetcodeDescription());
            return false;
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
        
        if(m_estimators.risk_level > 80.0) {
            warnings += "WYSOKIE RYZYKO RYNKOWE; ";
        }
        
        if(ArraySize(m_positions) > 10) {
            warnings += "ZBYT WIELE POZYCJI; ";
        }
        
        if(warnings != "") {
            m_risk_management.risk_warnings = warnings;
            m_risk_management.risk_score = drawdown;
            
            if(m_has_risk_alert_callback) {
                // Callback wykonany
            }
        }
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
    
    // === AKTUALIZACJA ===
    void Update() {
        if(!m_initialized) return;
        
        datetime current_time = TimeCurrent();
        
        // Aktualizacja co 5 sekund
        if(current_time - m_last_update >= 5) {
            m_last_update = current_time;
            
            // Zarządzanie pozycjami
            ManagePositions();
        }
    }
    
    // === FUNKCJE DOSTĘPU ===
    
    SPosition GetPosition(ulong ticket) {
        int index = FindPositionByTicket(ticket);
        if(index != -1) {
            return m_positions[index];
        }
        return SPosition{};
    }
    
    void GetPositions(SPosition &positions[]) {
        ArrayResize(positions, ArraySize(m_positions));
        for(int i = 0; i < ArraySize(m_positions); i++) {
            positions[i] = m_positions[i];
        }
    }
    
    SMarketEstimators GetMarketEstimators() {
        return m_estimators;
    }
    
    SRiskManagement GetRiskManagement() {
        return m_risk_management;
    }
    
    void SetRiskManagement(SRiskManagement &risk) {
        m_risk_management = risk;
    }
    
    // === SETTERY CALLBACKÓW ===
    void SetOnPositionOpened(bool enable) {
        m_has_position_opened_callback = enable;
    }
    
    void SetOnPositionClosed(bool enable) {
        m_has_position_closed_callback = enable;
    }
    
    void SetOnRiskAlert(bool enable) {
        m_has_risk_alert_callback = enable;
    }
    
    // === FUNKCJE POMOCNICZE ===
    
    PositionStatistics GetStatistics() {
        PositionStatistics stats;
        stats.total_positions = ArraySize(m_positions);
        stats.long_positions = 0;
        stats.short_positions = 0;
        stats.total_position_value = 0;
        stats.average_position_size = 0;
        stats.largest_position = 0;
        stats.smallest_position = 0;
        stats.total_margin_used = 0;
        stats.free_margin = 0;
        stats.last_position_update = m_last_update;
        
        // Calculate position statistics
        for(int i = 0; i < ArraySize(m_positions); i++) {
            if(m_positions[i].type == POSITION_TYPE_BUY) {
                stats.long_positions++;
            } else {
                stats.short_positions++;
            }
            
            double position_value = m_positions[i].volume * m_positions[i].current_price;
            stats.total_position_value += position_value;
            stats.total_margin_used += m_positions[i].margin;
            
            if(m_positions[i].volume > stats.largest_position) {
                stats.largest_position = m_positions[i].volume;
            }
            
            if(stats.smallest_position == 0 || m_positions[i].volume < stats.smallest_position) {
                stats.smallest_position = m_positions[i].volume;
            }
        }
        
        if(stats.total_positions > 0) {
            stats.average_position_size = stats.total_position_value / stats.total_positions;
        }
        
        return stats;
    }
    
    string GetPositionReport() {
        return GetStatusReport();
    }
    
    string GetStatusReport() {
        string report = "=== POSITION MANAGER STATUS ===\n";
        report += "Symbol: " + m_symbol + "\n";
        report += "Pozycje otwarte: " + IntegerToString(ArraySize(m_positions)) + "\n";
        report += "\n--- PODSTAWOWE ESTYMATORY ---\n";
        report += "Realizowana zmienność: " + DoubleToString(m_estimators.realized_volatility, 4) + "\n";
        report += "ATR zmienność: " + DoubleToString(m_estimators.atr_volatility, 2) + "%\n";
        report += "Momentum cenowe: " + DoubleToString(m_estimators.price_momentum, 2) + "%\n";
        report += "Profil wolumenu: " + DoubleToString(m_estimators.volume_profile, 1) + "%\n";
        report += "Siła rynku: " + DoubleToString(m_estimators.market_strength, 1) + "\n";
        report += "\n--- ZAAWANSOWANE ESTYMATORY ---\n";
        report += "GARCH volatilność: " + DoubleToString(m_estimators.garch_volatility, 4) + "\n";
        report += "Parkinson volatilność: " + DoubleToString(m_estimators.parkinson_volatility, 4) + "\n";
        report += "Yang-Zhang volatilność: " + DoubleToString(m_estimators.yang_zhang_volatility, 4) + "\n";
        report += "Rogers-Satchell volatilność: " + DoubleToString(m_estimators.rogers_satchell_volatility, 4) + "\n";
        report += "Energia cenowa: " + DoubleToString(m_estimators.price_energy, 2) + "\n";
        report += "Energia wolumenu: " + DoubleToString(m_estimators.volume_energy, 2) + "\n";
        report += "Energia momentum: " + DoubleToString(m_estimators.momentum_energy, 2) + "\n";
        report += "Energia mikrostruktury: " + DoubleToString(m_estimators.microstructure_energy, 2) + "\n";
        report += "Rozpraszanie energii: " + DoubleToString(m_estimators.energy_dissipation, 2) + "\n";
        report += "Trend energii: " + DoubleToString(m_estimators.energy_trend, 2) + "\n";
        report += "Przyspieszenie energii: " + DoubleToString(m_estimators.energy_acceleration, 2) + "\n";
        report += "Klasteryzacja volatilności: " + DoubleToString(m_estimators.volatility_clustering, 2) + "\n";
        report += "Lokalna volatilność: " + DoubleToString(m_estimators.local_volatility, 4) + "\n";
        report += "\n--- RYZYKO I STAN ---\n";
        report += "Poziom ryzyka: " + DoubleToString(m_estimators.risk_level, 1) + "\n";
        report += "Stan rynku: " + m_estimators.market_condition + "\n";
        report += "Wynik ryzyka: " + DoubleToString(m_risk_management.risk_score, 2) + "\n";
        report += "Ostrzeżenia: " + m_risk_management.risk_warnings + "\n";
        report += "Ostatnia aktualizacja: " + TimeToString(m_estimators.last_update) + "\n";
        report += "================================";
        
        return report;
    }
    
    string GetMarketConditionDescription() {
        return m_estimators.market_condition;
    }
    
    double GetRiskLevel() {
        return m_estimators.risk_level;
    }
    
    bool IsMarketVolatile() {
        return m_estimators.realized_volatility > 0.02;
    }
    
    bool IsMarketTrending() {
        return MathAbs(m_estimators.price_momentum) > 1.0;
    }
    
    bool IsMarketLiquid() {
        return m_estimators.volume_profile > 80.0;
    }
};

// === GLOBALNA INSTANCJA ===
// g_position_manager is declared in BohmeMainSystem.mq5
extern CPositionManager* g_position_manager;

// === FUNKCJE GLOBALNE ===
bool InitializeGlobalPositionManager(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
    if(g_position_manager != NULL) delete g_position_manager;
    g_position_manager = new CPositionManager();
    return g_position_manager.Initialize(symbol, timeframe);
}

void ReleaseGlobalPositionManager() {
    if(g_position_manager != NULL) {
        delete g_position_manager;
        g_position_manager = NULL;
    }
}

SPosition GetPosition(ulong ticket) {
    return g_position_manager != NULL ? g_position_manager.GetPosition(ticket) : SPosition{};
}

void GetPositions(SPosition &positions[]) {
    if(g_position_manager != NULL) {
        g_position_manager.GetPositions(positions);
    } else {
        ArrayResize(positions, 0);
    }
}

SMarketEstimators GetMarketEstimators() {
    return g_position_manager != NULL ? g_position_manager.GetMarketEstimators() : SMarketEstimators{};
}

SRiskManagement GetRiskManagement() {
    return g_position_manager != NULL ? g_position_manager.GetRiskManagement() : SRiskManagement{};
}

bool ClosePosition(ulong ticket, string reason = "") {
    return g_position_manager != NULL ? g_position_manager.ClosePosition(ticket, reason) : false;
}

string GetPositionManagerReport() {
    return g_position_manager != NULL ? g_position_manager.GetStatusReport() : "Position Manager nie zainicjalizowany";
}

#endif // POSITION_MANAGER_H
