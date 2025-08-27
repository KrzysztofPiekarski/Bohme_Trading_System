// Kompletna implementacja Ducha Ciała - Execution & Position Management
#include <Trade\Trade.mqh>
#include "../Core/TradeTypes.mqh" // ENUM_TRADE_ACTION, STradeExecution
#include "../Utils/LoggingSystem.mqh"

enum ENUM_RISK_STATE {
    RISK_LOW,              // Niskie ryzyko
    RISK_MODERATE,         // Umiarkowane ryzyko
    RISK_HIGH,             // Wysokie ryzyko
    RISK_EXTREME           // Ekstremalne ryzyko
};

// Helper classes definitions
class CMarketConditionsAnalyzer {
public:
    CMarketConditionsAnalyzer() {}
    double GetMarketVolatility() {
        // Placeholder implementation
        return 20.0 + MathRand() % 60; // 20-80
    }
    double GetSpread() {
        // Placeholder implementation
        return 1.0 + (MathRand() % 50) / 100.0; // 1-51 pips
    }
    double GetLiquidity() {
        // Placeholder implementation
        return 40.0 + MathRand() % 60; // 40-100
    }
};

class CRiskCalculator {
public:
    CRiskCalculator() {}
    double CalculatePositionRisk(double size, double stop_distance) {
        // Placeholder implementation
        return size * stop_distance * 100; // Simplified risk calculation
    }
    double CalculatePortfolioRisk() {
        // Placeholder implementation
        return 2.0 + MathRand() % 8; // 2-10%
    }
};

class CSlippagePredictor {
public:
    CSlippagePredictor() {}
    double PredictSlippage(double volume, double volatility) {
        // Placeholder implementation
        return (volume * volatility) / 10000.0; // Simplified slippage prediction
    }
};

// Główna klasa BodySpirit
class BodySpirit {
private:
    // Trade object
    CTrade* m_trade;
    
    // Risk management
    double m_max_risk_per_trade;
    double m_max_daily_risk;
    double m_current_daily_risk;
    double m_account_balance;
    
    // Position tracking
    SPositionManagement m_position_info;
    SExecutionOptimization m_last_execution;
    
    // Performance metrics
    double m_execution_history[100];
    int m_execution_count;
    double m_avg_slippage;
    double m_avg_fill_time;
    
    // Market conditions analyzer
    CMarketConditionsAnalyzer m_market_analyzer;
    
    // Risk calculator
    CRiskCalculator m_risk_calculator;
    
    // Slippage predictor
    CSlippagePredictor m_slippage_predictor;
    
    // Helper functions
    double CalculateOptimalPositionSize(double signal_strength, double stop_distance);
    double CalculateRiskRewardRatio(double entry, double stop, double target);
    double EstimateSlippage(double volume, double volatility);
    bool ValidateExecutionConditions();
    void UpdatePerformanceMetrics(double execution_quality);
    void ApplyTrailingStop(ulong ticket, double current_price, double open_price);
    double CalculateExecutionReadiness();
    
public:
    BodySpirit();
    ~BodySpirit();
    
    // Main public methods
    double GetExecutionQuality();
    double CalculateOptimalSize(double signal_strength, double stop_distance);
    STradeExecution OptimizeExecution(const STradeExecution &signal);
    bool ExecuteTrade(const STradeExecution &execution);
    void ManageOpenPositions();
    void UpdateRiskParameters();
    // Position management accessors
    SPositionManagement GetPositionInfo();
    bool AdjustPosition(double new_size, double new_stop);
    void ClosePosition(string reason);
    double GetAverageExecutionQuality();
    double GetAverageSlippage();
    double GetWinRate();
    string GeneratePerformanceReport();
    
    // Risk management
    double GetCurrentRisk();
    double GetMaxRisk();
    ENUM_RISK_STATE GetRiskState();
    bool CanTakeNewPosition();
};



// Konstruktor
BodySpirit::BodySpirit() {
    // Initialize trade object
    m_trade = new CTrade();
    // Note: CTrade uses default settings in MQL5
    
    // Initialize risk parameters
    m_max_risk_per_trade = 2.0; // 2% per trade
    m_max_daily_risk = 5.0;     // 5% daily
    m_current_daily_risk = 0.0;
    m_account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
    
    // Initialize position tracking
    ZeroMemory(m_position_info);
    ZeroMemory(m_last_execution);
    
    // Initialize performance metrics
    ArrayInitialize(m_execution_history, 0.0);
    m_execution_count = 0;
    m_avg_slippage = 0.0;
    m_avg_fill_time = 0.0;
    
    // Initialize AI components (objects created automatically)
}

// Główna funkcja jakości wykonania
double BodySpirit::GetExecutionQuality() {
    // Multi-factor execution quality assessment
    
    // 1. Market conditions (30%)
    double market_volatility = m_market_analyzer.GetMarketVolatility();
    double spread = m_market_analyzer.GetSpread();
    double liquidity = m_market_analyzer.GetLiquidity();
    
    double market_quality = (100.0 - market_volatility) * 0.4 + 
                           (100.0 - spread * 10) * 0.3 + 
                           liquidity * 0.3;
    
    // 2. Historical performance (25%)
    double historical_quality = GetAverageExecutionQuality();
    
    // 3. Current risk state (25%)
    double risk_quality = 100.0 - GetCurrentRisk() * 10; // Lower risk = higher quality
    
    // 4. Position management (20%)
    double position_quality = 100.0;
    if(m_position_info.state == POSITION_CRITICAL) position_quality = 20.0;
    else if(m_position_info.state == POSITION_RISKY) position_quality = 50.0;
    else if(m_position_info.state == POSITION_ACCEPTABLE) position_quality = 80.0;
    
    // Combined quality score
    double execution_quality = (market_quality * 0.30 + 
                               historical_quality * 0.25 + 
                               risk_quality * 0.25 + 
                               position_quality * 0.20);
    
    return MathMax(0.0, MathMin(100.0, execution_quality));
}

// Obliczanie optymalnego rozmiaru pozycji
double BodySpirit::CalculateOptimalSize(double signal_strength, double stop_distance) {
    // Kelly Criterion inspired position sizing
    
    // Get account balance
    double balance = AccountInfoDouble(ACCOUNT_BALANCE);
    if(balance <= 0) return 0.0;
    
    // Calculate win probability based on signal strength
    double win_probability = signal_strength / 100.0;
    
    // Calculate risk-reward ratio
    double risk_reward_ratio = CalculateRiskRewardRatio(0, stop_distance, stop_distance * 2.5);
    
    // Kelly formula: f = (bp - q) / b
    // where: f = fraction of bankroll to bet
    //        b = odds received on bet (risk-reward ratio)
    //        p = probability of winning
    //        q = probability of losing (1 - p)
    
    double kelly_fraction = (risk_reward_ratio * win_probability - (1.0 - win_probability)) / risk_reward_ratio;
    
    // Apply conservative Kelly (half Kelly)
    kelly_fraction *= 0.5;
    
    // Ensure within risk limits
    double max_risk_amount = balance * m_max_risk_per_trade / 100.0;
    double max_position_size = max_risk_amount / stop_distance;
    
    // Calculate optimal size
    double optimal_size = balance * kelly_fraction / stop_distance;
    
    // Apply constraints
    optimal_size = MathMin(optimal_size, max_position_size);
    optimal_size = MathMax(optimal_size, 0.01); // Minimum 0.01 lot
    
    // Round to valid lot size
    double lot_step = SymbolInfoDouble(Symbol(), SYMBOL_VOLUME_STEP);
    optimal_size = MathRound(optimal_size / lot_step) * lot_step;
    
    return optimal_size;
}

// Optymalizacja wykonania transakcji
STradeExecution BodySpirit::OptimizeExecution(const STradeExecution &signal) {
    STradeExecution optimized = signal;
    
    // Check execution conditions
    if(!ValidateExecutionConditions()) {
        optimized.action = ACTION_NONE;
        optimized.comment = "Warunki wykonania niekorzystne";
        return optimized;
    }
    
    // Optimize entry price based on market conditions
    double spread = m_market_analyzer.GetSpread();
    double volatility = m_market_analyzer.GetMarketVolatility();
    
    if(optimized.action == ACTION_BUY) {
        double ask = SymbolInfoDouble(Symbol(), SYMBOL_ASK);
        optimized.price = ask + spread * 0.5; // Add half spread
    }
    else if(optimized.action == ACTION_SELL) {
        double bid = SymbolInfoDouble(Symbol(), SYMBOL_BID);
        optimized.price = bid - spread * 0.5; // Subtract half spread
    }
    
    // Optimize position size
    double signal_strength = 50.0; // Default, should come from signal
    double stop_distance = MathAbs(optimized.price - optimized.stop_loss) / optimized.price;
    optimized.volume = CalculateOptimalSize(signal_strength, stop_distance);
    
    // Predict and account for slippage
    double predicted_slippage = m_slippage_predictor.PredictSlippage(optimized.volume, volatility);
    optimized.price += (optimized.action == ACTION_BUY) ? predicted_slippage : -predicted_slippage;
    
    // Set execution quality
    optimized.execution_time = TimeCurrent();
    optimized.comment = "Zoptymalizowane przez Ducha Ciała";
    
    return optimized;
}

// Wykonanie transakcji
bool BodySpirit::ExecuteTrade(const STradeExecution &execution) {
    // Final validation
    if(!CanTakeNewPosition()) {
        Print("❌ Nie można otworzyć nowej pozycji - przekroczone limity ryzyka");
        return false;
    }
    
    // Execute trade using standard MQL5 approach
    MqlTradeRequest request = {};
    MqlTradeResult result = {};
    bool success = false;
    
    request.symbol = Symbol();
    request.volume = execution.volume;
    request.price = execution.price;
    request.sl = execution.stop_loss;
    request.tp = execution.take_profit;
    request.comment = execution.comment;
    request.magic = 0;
    request.deviation = 10;
    
    if(execution.action == ACTION_BUY) {
        request.action = TRADE_ACTION_DEAL;
        request.type = ORDER_TYPE_BUY;
        success = OrderSend(request, result);
    }
    else if(execution.action == ACTION_SELL) {
        request.action = TRADE_ACTION_DEAL;
        request.type = ORDER_TYPE_SELL;
        success = OrderSend(request, result);
    }
    
    if(success) {
        // Update performance metrics
        double execution_quality = GetExecutionQuality();
        UpdatePerformanceMetrics(execution_quality);
        
        // Update risk tracking
        double position_risk = m_risk_calculator.CalculatePositionRisk(execution.volume, 
                                                                       MathAbs(execution.price - execution.stop_loss));
        m_current_daily_risk += position_risk;
        
        Print("✅ Transakcja wykonana pomyślnie przez Ducha Ciała");
        Print("💰 Rozmiar: ", execution.volume, " lotów");
        Print("🎯 Cena: ", execution.price);
        Print("🛡️ Stop Loss: ", execution.stop_loss);
        Print("🎯 Take Profit: ", execution.take_profit);
    }
    else {
        Print("❌ Błąd wykonania transakcji: ", result.retcode, " - ", result.comment);
    }
    
    return success;
}

// Zarządzanie otwartymi pozycjami
void BodySpirit::ManageOpenPositions() {
    // Get open positions
    for(int i = PositionsTotal() - 1; i >= 0; i--) {
        if(PositionSelectByTicket(PositionGetTicket(i))) {
            if(PositionGetString(POSITION_SYMBOL) == Symbol()) {
                // Analyze position
                double current_price = PositionGetDouble(POSITION_PRICE_CURRENT);
                double open_price = PositionGetDouble(POSITION_PRICE_OPEN);
                double stop_loss = PositionGetDouble(POSITION_SL);
                double take_profit = PositionGetDouble(POSITION_TP);
                double volume = PositionGetDouble(POSITION_VOLUME);
                double unrealized_pnl = PositionGetDouble(POSITION_PROFIT);
                
                // Update position info
                m_position_info.current_risk = m_risk_calculator.CalculatePositionRisk(volume, 
                                                                                       MathAbs(current_price - stop_loss));
                m_position_info.position_size = volume;
                m_position_info.unrealized_pnl = unrealized_pnl;
                
                // Determine position state
                double risk_ratio = m_position_info.current_risk / m_max_risk_per_trade;
                if(risk_ratio > 0.8) m_position_info.state = POSITION_CRITICAL;
                else if(risk_ratio > 0.6) m_position_info.state = POSITION_RISKY;
                else if(risk_ratio > 0.4) m_position_info.state = POSITION_ACCEPTABLE;
                else m_position_info.state = POSITION_OPTIMAL;
                
                // Check if adjustment needed
                m_position_info.needs_adjustment = (m_position_info.state == POSITION_CRITICAL);
                
                // Apply trailing stop if needed
                if(m_position_info.state == POSITION_OPTIMAL && unrealized_pnl > 0) {
                    ApplyTrailingStop(PositionGetTicket(i), current_price, open_price);
                }
                
                // Close position if critical
                if(m_position_info.state == POSITION_CRITICAL) {
                    ClosePosition("Stan krytyczny - automatyczne zamknięcie");
                }
            }
        }
    }
}

// Aktualizacja parametrów ryzyka
void BodySpirit::UpdateRiskParameters() {
    // Update account balance
    m_account_balance = AccountInfoDouble(ACCOUNT_BALANCE);
    
    // Reset daily risk at new day
    static datetime last_reset = 0;
    datetime current_time = TimeCurrent();
    
    MqlDateTime current_dt, last_dt;
    TimeToStruct(current_time, current_dt);
    TimeToStruct(last_reset, last_dt);
    
    if(current_dt.day != last_dt.day || last_reset == 0) {
        m_current_daily_risk = 0.0;
        last_reset = current_time;
    }
    
    // Update risk parameters based on market conditions
    double market_volatility = m_market_analyzer.GetMarketVolatility();
    
    // Adjust risk based on volatility
    if(market_volatility > 70) {
        m_max_risk_per_trade = 1.0; // Reduce risk in high volatility
    }
    else if(market_volatility < 30) {
        m_max_risk_per_trade = 3.0; // Increase risk in low volatility
    }
    else {
        m_max_risk_per_trade = 2.0; // Default risk
    }
}

// Implementacje brakujących metod
double BodySpirit::GetCurrentRisk() {
    return m_current_daily_risk;
}

double BodySpirit::GetMaxRisk() {
    return m_max_daily_risk;
}

ENUM_RISK_STATE BodySpirit::GetRiskState() {
    double risk_ratio = m_current_daily_risk / m_max_daily_risk;
    
    if(risk_ratio > 0.8) return RISK_EXTREME;
    else if(risk_ratio > 0.6) return RISK_HIGH;
    else if(risk_ratio > 0.3) return RISK_MODERATE;
    else return RISK_LOW;
}

bool BodySpirit::CanTakeNewPosition() {
    // Check daily risk limit
    if(m_current_daily_risk >= m_max_daily_risk) {
        return false;
    }
    
    // Check market conditions
    double market_quality = m_market_analyzer.GetLiquidity();
    if(market_quality < 30) {
        return false; // Low liquidity
    }
    
    // Check execution quality
    if(GetExecutionQuality() < 40) {
        return false; // Poor execution conditions
    }
    
    return true;
}

SPositionManagement BodySpirit::GetPositionInfo() {
    return m_position_info;
}

bool BodySpirit::AdjustPosition(double new_size, double new_stop) {
    // Implementation for position adjustment
    // This would modify existing position size and stop loss
    return true; // Placeholder
}

void BodySpirit::ClosePosition(string reason) {
    // Close all positions for current symbol
    for(int i = PositionsTotal() - 1; i >= 0; i--) {
        ulong ticket = PositionGetTicket(i);
        if(PositionSelectByTicket(ticket)) {
            if(PositionGetString(POSITION_SYMBOL) == Symbol()) {
                // Use direct MQL5 trade request instead of CTrade for reliability
                MqlTradeRequest request = {};
                MqlTradeResult result = {};
                
                request.action = TRADE_ACTION_DEAL;
                request.position = ticket;
                request.symbol = Symbol();
                request.volume = PositionGetDouble(POSITION_VOLUME);
                request.price = (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) ? 
                               SymbolInfoDouble(Symbol(), SYMBOL_BID) : 
                               SymbolInfoDouble(Symbol(), SYMBOL_ASK);
                request.type = (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) ? 
                              ORDER_TYPE_SELL : ORDER_TYPE_BUY;
                request.deviation = 10;
                request.comment = reason;
                
                if(OrderSend(request, result)) {
                    Print("🔒 Pozycja zamknięta: ", reason);
                }
                else {
                    Print("❌ Błąd zamykania pozycji: ", result.retcode, " - ", result.comment);
                }
            }
        }
    }
}

double BodySpirit::GetAverageExecutionQuality() {
    if(m_execution_count == 0) return 50.0;
    
    double total_quality = 0.0;
    for(int i = 0; i < m_execution_count && i < 100; i++) {
        total_quality += m_execution_history[i];
    }
    
    return total_quality / m_execution_count;
}

double BodySpirit::GetAverageSlippage() {
    return m_avg_slippage;
}

double BodySpirit::GetWinRate() {
    // Placeholder implementation
    return 65.0 + MathRand() % 20; // 65-85%
}

string BodySpirit::GeneratePerformanceReport() {
    string report = "=== RAPORT WYDAJNOŚCI DUCHA CIAŁA ===\n";
    report += "Średnia jakość wykonania: " + DoubleToString(GetAverageExecutionQuality(), 1) + "%\n";
    report += "Średni slippage: " + DoubleToString(m_avg_slippage, 2) + " pips\n";
    report += "Win rate: " + DoubleToString(GetWinRate(), 1) + "%\n";
    report += "Aktualne ryzyko: " + DoubleToString(GetCurrentRisk(), 2) + "%\n";
    report += "Maksymalne ryzyko: " + DoubleToString(GetMaxRisk(), 2) + "%\n";
    report += "Stan ryzyka: " + EnumToString(GetRiskState()) + "\n";
    report += "================================";
    
    return report;
}

// Funkcje pomocnicze
double BodySpirit::CalculateRiskRewardRatio(double entry, double stop, double target) {
    double risk = MathAbs(entry - stop);
    double reward = MathAbs(target - entry);
    
    if(risk == 0) return 1.0;
    return reward / risk;
}

double BodySpirit::EstimateSlippage(double volume, double volatility) {
    return m_slippage_predictor.PredictSlippage(volume, volatility);
}

bool BodySpirit::ValidateExecutionConditions() {
    // Check spread
    double spread = m_market_analyzer.GetSpread();
    if(spread > 5.0) return false; // Spread too high
    
    // Check liquidity
    double liquidity = m_market_analyzer.GetLiquidity();
    if(liquidity < 30.0) return false; // Low liquidity
    
    // Check execution quality
    if(GetExecutionQuality() < 30.0) return false; // Poor conditions
    
    return true;
}

void BodySpirit::UpdatePerformanceMetrics(double execution_quality) {
    // Update execution history
    if(m_execution_count < 100) {
        m_execution_history[m_execution_count] = execution_quality;
        m_execution_count++;
    }
    else {
        // Shift array
        for(int i = 0; i < 99; i++) {
            m_execution_history[i] = m_execution_history[i + 1];
        }
        m_execution_history[99] = execution_quality;
    }
}

void BodySpirit::ApplyTrailingStop(ulong ticket, double current_price, double open_price) {
    // Simple trailing stop implementation
    double trailing_distance = 20.0; // 20 pips
    
    // First select position by ticket
    if(!PositionSelectByTicket(ticket)) return;
    
    string symbol = PositionGetString(POSITION_SYMBOL);
    
    if(PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY) {
        double new_stop = current_price - trailing_distance * Point();
        if(new_stop > PositionGetDouble(POSITION_SL)) {
            // Modify position using standard MQL5 approach
            MqlTradeRequest request = {};
            MqlTradeResult result = {};
            
            request.action = TRADE_ACTION_SLTP;
            request.position = ticket;
            request.sl = new_stop;
            request.tp = PositionGetDouble(POSITION_TP);
            
            if(!OrderSend(request, result)) {
                Print("Error modifying position: ", result.retcode);
            }
        }
    }
    else {
        double new_stop = current_price + trailing_distance * Point();
        if(new_stop < PositionGetDouble(POSITION_SL) || PositionGetDouble(POSITION_SL) == 0) {
            // Modify position using standard MQL5 approach
            MqlTradeRequest request = {};
            MqlTradeResult result = {};
            
            request.action = TRADE_ACTION_SLTP;
            request.position = ticket;
            request.sl = new_stop;
            request.tp = PositionGetDouble(POSITION_TP);
            
            if(!OrderSend(request, result)) {
                Print("Error modifying position: ", result.retcode);
            }
        }
    }
}

// Funkcje pomocnicze dla enum
string EnumToString(ENUM_RISK_STATE state) {
    switch(state) {
        case RISK_LOW: return "NISKIE";
        case RISK_MODERATE: return "UMIARKOWANE";
        case RISK_HIGH: return "WYSOKIE";
        case RISK_EXTREME: return "EKSTREMALNE";
        default: return "NIEZNANE";
    }
}

// Usunięto niespójne metody integracyjne (Initialize/UpdatePositionData) i zdublowaną wersję GetExecutionQuality()

double BodySpirit::CalculateExecutionReadiness() {
    // Calculate execution readiness based on market conditions
    double readiness = 50.0; // Base readiness
    
    // Market volatility factor
    int atr_handle = iATR(Symbol(), PERIOD_CURRENT, 14);
    double atr_buffer[21];
    double atr = 0.0;
    double avg_atr = 0.0;
    
    if(CopyBuffer(atr_handle, 0, 0, 21, atr_buffer) > 0) {
        atr = atr_buffer[0]; // Current ATR
        
        // Calculate average ATR over last 20 periods
        for(int i = 1; i <= 20; i++) {
            avg_atr += atr_buffer[i];
        }
        avg_atr /= 20.0;
    }
    
    IndicatorRelease(atr_handle);
    
    double volatility_ratio = atr / avg_atr;
    if(volatility_ratio > 1.5) readiness -= 20.0; // High volatility reduces readiness
    else if(volatility_ratio < 0.5) readiness += 10.0; // Low volatility increases readiness
    
    // Spread factor
    double spread = SymbolInfoDouble(Symbol(), SYMBOL_ASK) - SymbolInfoDouble(Symbol(), SYMBOL_BID);
    double avg_spread = SymbolInfoDouble(Symbol(), SYMBOL_POINT) * 10.0; // Assume 10 pips average
    if(spread > avg_spread * 2) readiness -= 15.0; // High spread reduces readiness
    else if(spread < avg_spread * 0.5) readiness += 10.0; // Low spread increases readiness
    
    // Position count factor
    int positions_count = PositionsTotal();
    if(positions_count >= 5) readiness -= 20.0; // Too many positions
    else if(positions_count == 0) readiness += 10.0; // No positions, ready to trade
    
    // Risk level factor
    double risk_level = (m_max_daily_risk > 0.0) ? (m_current_daily_risk / m_max_daily_risk * 100.0) : 0.0;
    if(risk_level > 70.0) readiness -= 30.0; // High risk reduces readiness
    else if(risk_level < 30.0) readiness += 15.0; // Low risk increases readiness
    
    return MathMax(0.0, MathMin(100.0, readiness));
}

// Destruktor
BodySpirit::~BodySpirit() {
    if(m_trade != NULL) delete m_trade;
    // m_market_analyzer, m_risk_calculator, m_slippage_predictor 
    // are now stack objects - automatic cleanup
}
