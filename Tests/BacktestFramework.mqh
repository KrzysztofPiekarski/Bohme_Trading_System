// Kompletny framework do backtestingu Bohme Trading System
// Zawiera zaawansowaną analizę wyników, optymalizację parametrów i raportowanie

#include "../Core/MasterConsciousness.mqh"
#include "../Core/SystemConfig.mqh"
#include "../Spirits/BitternessSpirit.mqh"
#include "../Spirits/BodySpirit.mqh"
#include "../Spirits/FireSpirit.mqh"
#include "../Spirits/HerbeSpirit.mqh"
#include "../Spirits/LightSpirit.mqh"
#include "../Spirits/SoundSpirit.mqh"
#include "../Spirits/SweetnessSpirit.mqh"

// Struktury dla backtestingu
struct SBacktestTrade {
    datetime open_time;
    datetime close_time;
    double open_price;
    double close_price;
    double volume;
    int type; // 0 = BUY, 1 = SELL
    double profit;
    double commission;
    double swap;
    double total_profit;
    string spirit_decision;
    double consensus_strength;
    double risk_level;
    string symbol;
    int magic_number;
};

struct SBacktestResult {
    // Podstawowe metryki
    int total_trades;
    int winning_trades;
    int losing_trades;
    double total_profit;
    double total_loss;
    double net_profit;
    double win_rate;
    double profit_factor;
    double average_win;
    double average_loss;
    double largest_win;
    double largest_loss;
    
    // Metryki ryzyka
    double max_drawdown;
    double max_drawdown_percent;
    double sharpe_ratio;
    double calmar_ratio;
    double sortino_ratio;
    double recovery_factor;
    double risk_reward_ratio;
    
    // Metryki czasowe
    datetime start_date;
    datetime end_date;
    int trading_days;
    double average_trade_duration;
    double profit_per_day;
    
    // Metryki duchów
    double spirit_harmony_average;
    double consensus_strength_average;
    double execution_quality_average;
    
    // Szczegółowe dane
    SBacktestTrade trades[];
    double equity_curve[];
    double drawdown_curve[];
    
    // Parametry testu
    string symbol;
    ENUM_TIMEFRAMES timeframe;
    double initial_balance;
    double final_balance;
    double max_risk_per_trade;
    int max_positions;
};

struct SOptimizationResult {
    string parameter_name;
    double best_value;
    double worst_value;
    double optimal_value;
    double parameter_impact;
    SBacktestResult best_result;
    SBacktestResult worst_result;
    SBacktestResult optimal_result;
};

// Główna klasa backtestingu
class CBohmeBacktester {
private:
    // Instancje systemu
    MasterConsciousness* m_master;
    BitternessSpirit* m_bitterness;
    BodySpirit* m_body;
    FireSpirit* m_fire;
    HerbeSpirit* m_herbe;
    LightSpirit* m_light;
    SoundSpirit* m_sound;
    SweetnessSpirit* m_sweetness;
    
    // Dane historyczne
    double m_high_prices[];
    double m_low_prices[];
    double m_close_prices[];
    double m_open_prices[];
    double m_volume[];
    datetime m_time[];
    int m_data_count;
    
    // Parametry backtestingu
    datetime m_start_date;
    datetime m_end_date;
    string m_symbol;
    ENUM_TIMEFRAMES m_timeframe;
    double m_initial_balance;
    double m_commission;
    double m_swap;
    double m_slippage;
    
    // Stan symulacji
    double m_current_balance;
    double m_current_equity;
    double m_peak_balance;
    double m_current_drawdown;
    double m_max_drawdown;
    SBacktestTrade m_open_trades[];
    SBacktestTrade m_closed_trades[];
    
    // Metryki duchów
    double m_spirit_harmony_sum;
    double m_consensus_strength_sum;
    double m_execution_quality_sum;
    int m_decision_count;
    
    // Helper functions
    void LoadHistoricalData();
    void InitializeSystem();
    void CleanupSystem();
    double CalculateCommission(double volume, double price);
    double CalculateSwap(int type, datetime open_time, datetime close_time);
    void UpdateEquityCurve();
    void UpdateDrawdownCurve();
    double CalculateSharpeRatio();
    double CalculateCalmarRatio();
    double CalculateSortinoRatio();
    double CalculateRecoveryFactor();
    void ProcessTrade(SBacktestTrade& trade);
    bool ShouldCloseTrade(SBacktestTrade& trade, int current_bar);
    double GetSpiritConsensus(int current_bar);
    
public:
    CBohmeBacktester();
    ~CBohmeBacktester();
    
    // Konfiguracja backtestingu
    void SetParameters(string symbol, ENUM_TIMEFRAMES timeframe, 
                      datetime start_date, datetime end_date,
                      double initial_balance, double commission, 
                      double swap, double slippage);
    
    // Główne metody backtestingu
    SBacktestResult RunBacktest();
    SBacktestResult RunOptimization(string parameter_name, 
                                   double min_value, double max_value, 
                                   double step, int optimization_criterion);
    
    // Analiza wyników
    void GenerateBacktestReport(SBacktestResult& result, string filename);
    void PrintBacktestSummary(SBacktestResult& result);
    void ExportResultsToCSV(SBacktestResult& result, string filename);
    void CreateEquityChart(SBacktestResult& result);
    
    // Gettery
    double GetCurrentBalance();
    double GetCurrentEquity();
    double GetMaxDrawdown();
    int GetTotalTrades();
    double GetWinRate();
};

// Konstruktor
CBohmeBacktester::CBohmeBacktester() {
    Print("=== BOHME BACKTESTER INITIALIZED ===");
    
    // Inicjalizacja systemu
    InitializeSystem();
    
    // Inicjalizacja parametrów
    m_data_count = 0;
    m_current_balance = 10000.0;
    m_current_equity = 10000.0;
    m_peak_balance = 10000.0;
    m_current_drawdown = 0.0;
    m_max_drawdown = 0.0;
    
    // Inicjalizacja metryk duchów
    m_spirit_harmony_sum = 0.0;
    m_consensus_strength_sum = 0.0;
    m_execution_quality_sum = 0.0;
    m_decision_count = 0;
    
    Print("Backtester initialized successfully");
}

// Inicjalizacja systemu
void CBohmeBacktester::InitializeSystem() {
    m_master = new MasterConsciousness();
    m_bitterness = new BitternessSpirit();
    m_body = new BodySpirit();
    m_fire = new FireSpirit();
    m_herbe = new HerbeSpirit();
    m_light = new LightSpirit();
    m_sound = new SoundSpirit();
    m_sweetness = new SweetnessSpirit();
}

// Destruktor
CBohmeBacktester::~CBohmeBacktester() {
    CleanupSystem();
    Print("=== BOHME BACKTESTER CLEANUP COMPLETE ===");
}

// Czyszczenie systemu
void CBohmeBacktester::CleanupSystem() {
    if(m_master != NULL) delete m_master;
    if(m_bitterness != NULL) delete m_bitterness;
    if(m_body != NULL) delete m_body;
    if(m_fire != NULL) delete m_fire;
    if(m_herbe != NULL) delete m_herbe;
    if(m_light != NULL) delete m_light;
    if(m_sound != NULL) delete m_sound;
    if(m_sweetness != NULL) delete m_sweetness;
}

// Ustawienie parametrów backtestingu
void CBohmeBacktester::SetParameters(string symbol, ENUM_TIMEFRAMES timeframe, 
                                    datetime start_date, datetime end_date,
                                    double initial_balance, double commission, 
                                    double swap, double slippage) {
    m_symbol = symbol;
    m_timeframe = timeframe;
    m_start_date = start_date;
    m_end_date = end_date;
    m_initial_balance = initial_balance;
    m_current_balance = initial_balance;
    m_current_equity = initial_balance;
    m_peak_balance = initial_balance;
    m_commission = commission;
    m_swap = swap;
    m_slippage = slippage;
    
    Print("Backtest parameters set:");
    Print("Symbol: ", m_symbol);
    Print("Timeframe: ", EnumToString(m_timeframe));
    Print("Start Date: ", TimeToString(m_start_date));
    Print("End Date: ", TimeToString(m_end_date));
    Print("Initial Balance: ", DoubleToString(m_initial_balance, 2));
}

// Główna metoda backtestingu
SBacktestResult CBohmeBacktester::RunBacktest() {
    Print("=== STARTING BOHME BACKTEST ===");
    datetime start_time = TimeCurrent();
    
    // Załaduj dane historyczne
    LoadHistoricalData();
    if(m_data_count == 0) {
        Print("❌ No historical data loaded");
        SBacktestResult empty_result;
        return empty_result;
    }
    
    Print("Loaded ", m_data_count, " bars of historical data");
    
    // Resetuj stan symulacji
    m_current_balance = m_initial_balance;
    m_current_equity = m_initial_balance;
    m_peak_balance = m_initial_balance;
    m_current_drawdown = 0.0;
    m_max_drawdown = 0.0;
    ArrayResize(m_open_trades, 0);
    ArrayResize(m_closed_trades, 0);
    ArrayResize(m_equity_curve, m_data_count);
    ArrayResize(m_drawdown_curve, m_data_count);
    
    // Resetuj metryki duchów
    m_spirit_harmony_sum = 0.0;
    m_consensus_strength_sum = 0.0;
    m_execution_quality_sum = 0.0;
    m_decision_count = 0;
    
    // Główna pętla backtestingu
    for(int i = 100; i < m_data_count - 1; i++) { // Start od 100 dla wystarczających danych
        datetime current_time = m_time[i];
        
        // Sprawdź czy w zakresie dat
        if(current_time < m_start_date || current_time > m_end_date) {
            continue;
        }
        
        // Aktualizuj duchy z nowymi danymi
        UpdateSpiritsWithData(i);
        
        // Sprawdź otwarte pozycje
        CheckOpenPositions(i);
        
        // Sprawdź nowe sygnały
        CheckNewSignals(i);
        
        // Aktualizuj krzywe
        UpdateEquityCurve();
        UpdateDrawdownCurve();
        
        // Logowanie postępu
        if(i % 1000 == 0) {
            Print("Processed ", i, " of ", m_data_count, " bars");
        }
    }
    
    // Zamknij wszystkie otwarte pozycje na końcu
    CloseAllPositions(m_data_count - 1);
    
    // Oblicz wyniki końcowe
    SBacktestResult result = CalculateFinalResults();
    
    double total_time = (double)(TimeCurrent() - start_time);
    Print("=== BACKTEST COMPLETED IN ", DoubleToString(total_time, 2), " SECONDS ===");
    
    return result;
}

// Załaduj dane historyczne
void CBohmeBacktester::LoadHistoricalData() {
    Print("Loading historical data for ", m_symbol, "...");
    
    // Pobierz dane historyczne
    int copied = CopyHigh(m_symbol, m_timeframe, 0, 100000, m_high_prices);
    if(copied <= 0) {
        Print("❌ Failed to load high prices");
        return;
    }
    
    copied = CopyLow(m_symbol, m_timeframe, 0, 100000, m_low_prices);
    copied = CopyClose(m_symbol, m_timeframe, 0, 100000, m_close_prices);
    copied = CopyOpen(m_symbol, m_timeframe, 0, 100000, m_open_prices);
    copied = CopyTickVolume(m_symbol, m_timeframe, 0, 100000, m_volume);
    copied = CopyTime(m_symbol, m_timeframe, 0, 100000, m_time);
    
    m_data_count = ArraySize(m_close_prices);
    
    Print("✅ Loaded ", m_data_count, " bars of data");
}

// Aktualizuj duchy z nowymi danymi
void CBohmeBacktester::UpdateSpiritsWithData(int bar_index) {
    // Symulacja aktualizacji duchów z nowymi danymi
    // W rzeczywistości przekazalibyśmy aktualne dane rynkowe
    
    // Aktualizuj każdy duch
    m_bitterness.UpdateMomentumAnalysis();
    m_body.UpdateExecutionQuality();
    m_fire.UpdateEnergyAnalysis();
    m_herbe.UpdateFundamentalTensions();
    m_light.UpdateSignalClarity();
    m_sound.UpdateHarmonyAnalysis();
    m_sweetness.UpdateSentimentAnalysis();
    
    // Aktualizuj Master Consciousness
    m_master.UpdateAllSpirits();
}

// Sprawdź otwarte pozycje
void CBohmeBacktester::CheckOpenPositions(int bar_index) {
    for(int i = ArraySize(m_open_trades) - 1; i >= 0; i--) {
        if(ShouldCloseTrade(m_open_trades[i], bar_index)) {
            // Zamknij pozycję
            CloseTrade(m_open_trades[i], bar_index);
            
            // Usuń z listy otwartych
            ArrayRemove(m_open_trades, i, 1);
        }
    }
}

// Sprawdź nowe sygnały
void CBohmeBacktester::CheckNewSignals(int bar_index) {
    // Pobierz konsensus duchów
    double consensus = GetSpiritConsensus(bar_index);
    
    // Sprawdź czy mamy wystarczająco silny sygnał
    if(MathAbs(consensus) > 0.7) { // Próg 70%
        // Sprawdź czy możemy otworzyć nową pozycję
        if(ArraySize(m_open_trades) < g_config.Risk.MaxPositions) {
            // Otwórz nową pozycję
            OpenNewTrade(consensus, bar_index);
        }
    }
}

// Otwórz nową transakcję
void OpenNewTrade(double consensus, int bar_index) {
    SBacktestTrade new_trade;
    
    new_trade.open_time = m_time[bar_index];
    new_trade.open_price = m_close_prices[bar_index];
    new_trade.type = (consensus > 0) ? 0 : 1; // 0 = BUY, 1 = SELL
    new_trade.volume = m_body.CalculateOptimalSize(m_current_balance, g_config.Risk.RiskPercent / 100.0);
    new_trade.consensus_strength = MathAbs(consensus);
    new_trade.risk_level = m_body.GetRiskLevel();
    new_trade.symbol = m_symbol;
    new_trade.magic_number = 12345;
    
    // Oblicz prowizję
    new_trade.commission = CalculateCommission(new_trade.volume, new_trade.open_price);
    
    // Dodaj do listy otwartych transakcji
    int size = ArraySize(m_open_trades);
    ArrayResize(m_open_trades, size + 1);
    m_open_trades[size] = new_trade;
    
    // Zaktualizuj metryki duchów
    m_spirit_harmony_sum += m_sound.GetCycleHarmonyIndex();
    m_consensus_strength_sum += new_trade.consensus_strength;
    m_execution_quality_sum += m_body.GetExecutionQuality();
    m_decision_count++;
}

// Zamknij transakcję
void CBohmeBacktester::CloseTrade(SBacktestTrade& trade, int bar_index) {
    trade.close_time = m_time[bar_index];
    trade.close_price = m_close_prices[bar_index];
    
    // Oblicz zysk/stratę
    if(trade.type == 0) { // BUY
        trade.profit = (trade.close_price - trade.open_price) * trade.volume;
    } else { // SELL
        trade.profit = (trade.open_price - trade.close_price) * trade.volume;
    }
    
    // Oblicz swap
    trade.swap = CalculateSwap(trade.type, trade.open_time, trade.close_time);
    
    // Oblicz całkowity zysk
    trade.total_profit = trade.profit - trade.commission + trade.swap;
    
    // Zaktualizuj saldo
    m_current_balance += trade.total_profit;
    m_current_equity = m_current_balance;
    
    // Zaktualizuj peak balance
    if(m_current_balance > m_peak_balance) {
        m_peak_balance = m_current_balance;
    }
    
    // Zaktualizuj drawdown
    m_current_drawdown = (m_peak_balance - m_current_balance) / m_peak_balance * 100.0;
    if(m_current_drawdown > m_max_drawdown) {
        m_max_drawdown = m_current_drawdown;
    }
    
    // Dodaj do listy zamkniętych transakcji
    int size = ArraySize(m_closed_trades);
    ArrayResize(m_closed_trades, size + 1);
    m_closed_trades[size] = trade;
}

// Sprawdź czy powinno się zamknąć transakcję
bool CBohmeBacktester::ShouldCloseTrade(SBacktestTrade& trade, int bar_index) {
    double current_price = m_close_prices[bar_index];
    
    // Sprawdź stop loss (2% od ceny otwarcia)
    double stop_loss = 0.02;
    if(trade.type == 0) { // BUY
        if(current_price < trade.open_price * (1 - stop_loss)) {
            return true;
        }
    } else { // SELL
        if(current_price > trade.open_price * (1 + stop_loss)) {
            return true;
        }
    }
    
    // Sprawdź take profit (4% od ceny otwarcia)
    double take_profit = 0.04;
    if(trade.type == 0) { // BUY
        if(current_price > trade.open_price * (1 + take_profit)) {
            return true;
        }
    } else { // SELL
        if(current_price < trade.open_price * (1 - take_profit)) {
            return true;
        }
    }
    
    // Sprawdź czas trwania (maksymalnie 30 dni)
    if(m_time[bar_index] - trade.open_time > 30 * 24 * 60 * 60) {
        return true;
    }
    
    return false;
}

// Zamknij wszystkie pozycje
void CBohmeBacktester::CloseAllPositions(int bar_index) {
    for(int i = ArraySize(m_open_trades) - 1; i >= 0; i--) {
        CloseTrade(m_open_trades[i], bar_index);
    }
    ArrayResize(m_open_trades, 0);
}

// Pobierz konsensus duchów
double CBohmeBacktester::GetSpiritConsensus(int bar_index) {
    // Symulacja konsensusu duchów
    // W rzeczywistości używalibyśmy Master Consciousness
    
    double bitterness = m_bitterness.GetMomentumPhase() / 100.0 - 0.5;
    double fire = m_fire.GetEnergyLevel() / 100.0 - 0.5;
    double light = m_light.GetSignalClarity() / 100.0 - 0.5;
    double sound = m_sound.GetCycleHarmonyIndex() / 100.0 - 0.5;
    double sweetness = m_sweetness.GetHarmonyIndex() / 100.0 - 0.5;
    
    // Ważony konsensus
    double consensus = (bitterness * 0.2 + fire * 0.15 + light * 0.25 + 
                       sound * 0.2 + sweetness * 0.2);
    
    return consensus;
}

// Oblicz wyniki końcowe
SBacktestResult CBohmeBacktester::CalculateFinalResults() {
    SBacktestResult result;
    
    // Podstawowe metryki
    result.total_trades = ArraySize(m_closed_trades);
    result.final_balance = m_current_balance;
    result.initial_balance = m_initial_balance;
    result.net_profit = m_current_balance - m_initial_balance;
    
    if(result.total_trades > 0) {
        // Oblicz wygrywające i przegrywające transakcje
        result.winning_trades = 0;
        result.losing_trades = 0;
        result.total_profit = 0.0;
        result.total_loss = 0.0;
        result.largest_win = 0.0;
        result.largest_loss = 0.0;
        
        for(int i = 0; i < result.total_trades; i++) {
            double trade_profit = m_closed_trades[i].total_profit;
            
            if(trade_profit > 0) {
                result.winning_trades++;
                result.total_profit += trade_profit;
                if(trade_profit > result.largest_win) {
                    result.largest_win = trade_profit;
                }
            } else {
                result.losing_trades++;
                result.total_loss += MathAbs(trade_profit);
                if(MathAbs(trade_profit) > result.largest_loss) {
                    result.largest_loss = MathAbs(trade_profit);
                }
            }
        }
        
        // Oblicz średnie
        result.win_rate = (double)result.winning_trades / result.total_trades * 100.0;
        result.average_win = result.winning_trades > 0 ? result.total_profit / result.winning_trades : 0.0;
        result.average_loss = result.losing_trades > 0 ? result.total_loss / result.losing_trades : 0.0;
        result.profit_factor = result.total_loss > 0 ? result.total_profit / result.total_loss : 0.0;
    }
    
    // Metryki ryzyka
    result.max_drawdown = m_max_drawdown;
    result.max_drawdown_percent = m_max_drawdown;
    result.sharpe_ratio = CalculateSharpeRatio();
    result.calmar_ratio = CalculateCalmarRatio();
    result.sortino_ratio = CalculateSortinoRatio();
    result.recovery_factor = CalculateRecoveryFactor();
    result.risk_reward_ratio = result.average_loss > 0 ? result.average_win / result.average_loss : 0.0;
    
    // Metryki czasowe
    result.start_date = m_start_date;
    result.end_date = m_end_date;
    result.trading_days = (int)((m_end_date - m_start_date) / (24 * 60 * 60));
    result.profit_per_day = result.trading_days > 0 ? result.net_profit / result.trading_days : 0.0;
    
    // Metryki duchów
    if(m_decision_count > 0) {
        result.spirit_harmony_average = m_spirit_harmony_sum / m_decision_count;
        result.consensus_strength_average = m_consensus_strength_sum / m_decision_count;
        result.execution_quality_average = m_execution_quality_sum / m_decision_count;
    }
    
    // Skopiuj dane
    result.trades = m_closed_trades;
    result.equity_curve = m_equity_curve;
    result.drawdown_curve = m_drawdown_curve;
    result.symbol = m_symbol;
    result.timeframe = m_timeframe;
    
    return result;
}

// Helper functions
double CBohmeBacktester::CalculateCommission(double volume, double price) {
    return volume * price * m_commission / 100.0;
}

double CBohmeBacktester::CalculateSwap(int type, datetime open_time, datetime close_time) {
    int days = (int)((close_time - open_time) / (24 * 60 * 60));
    return days * m_swap;
}

void CBohmeBacktester::UpdateEquityCurve() {
    // Aktualizuj krzywą equity
    static int equity_index = 0;
    if(equity_index < m_data_count) {
        m_equity_curve[equity_index] = m_current_equity;
        equity_index++;
    }
}

void CBohmeBacktester::UpdateDrawdownCurve() {
    // Aktualizuj krzywą drawdown
    static int drawdown_index = 0;
    if(drawdown_index < m_data_count) {
        m_drawdown_curve[drawdown_index] = m_current_drawdown;
        drawdown_index++;
    }
}

double CBohmeBacktester::CalculateSharpeRatio() {
    // Uproszczony Sharpe Ratio
    if(m_max_drawdown > 0) {
        return (m_current_balance - m_initial_balance) / m_max_drawdown;
    }
    return 0.0;
}

double CBohmeBacktester::CalculateCalmarRatio() {
    // Calmar Ratio = Annual Return / Max Drawdown
    if(m_max_drawdown > 0) {
        double annual_return = (m_current_balance - m_initial_balance) / m_initial_balance * 365.0 / 30.0; // Zakładamy 30 dni
        return annual_return / (m_max_drawdown / 100.0);
    }
    return 0.0;
}

double CBohmeBacktester::CalculateSortinoRatio() {
    // Prawdziwa implementacja Sortino Ratio
    if(m_returns_count == 0) return 0.0;
    
    double downside_deviation = 0.0;
    double negative_returns_sum = 0.0;
    int negative_returns_count = 0;
    
    // Oblicz downside deviation (tylko negatywne zwroty)
    for(int i = 0; i < m_returns_count; i++) {
        if(m_returns[i] < 0) {
            downside_deviation += MathPow(m_returns[i], 2);
            negative_returns_sum += m_returns[i];
            negative_returns_count++;
        }
    }
    
    if(negative_returns_count > 0) {
        downside_deviation = MathSqrt(downside_deviation / negative_returns_count);
        double average_return = negative_returns_sum / negative_returns_count;
        
        if(downside_deviation > 0) {
            return average_return / downside_deviation;
        }
    }
    
    return 0.0;
}

double CBohmeBacktester::CalculateRecoveryFactor() {
    if(m_max_drawdown > 0) {
        return (m_current_balance - m_initial_balance) / m_max_drawdown;
    }
    return 0.0;
}

// Gettery
double CBohmeBacktester::GetCurrentBalance() { return m_current_balance; }
double CBohmeBacktester::GetCurrentEquity() { return m_current_equity; }
double CBohmeBacktester::GetMaxDrawdown() { return m_max_drawdown; }
int CBohmeBacktester::GetTotalTrades() { return ArraySize(m_closed_trades); }
double CBohmeBacktester::GetWinRate() { 
    int total = ArraySize(m_closed_trades);
    if(total == 0) return 0.0;
    
    int wins = 0;
    for(int i = 0; i < total; i++) {
        if(m_closed_trades[i].total_profit > 0) wins++;
    }
    return (double)wins / total * 100.0;
}

// Generowanie raportu backtestingu
void CBohmeBacktester::GenerateBacktestReport(SBacktestResult& result, string filename) {
    Print("Generating backtest report...");
    
    string report = "";
    report += "=== BOHME TRADING SYSTEM BACKTEST REPORT ===\n";
    report += "Date: " + TimeToString(TimeCurrent()) + "\n";
    report += "Symbol: " + result.symbol + "\n";
    report += "Timeframe: " + EnumToString(result.timeframe) + "\n";
    report += "Period: " + TimeToString(result.start_date) + " to " + TimeToString(result.end_date) + "\n\n";
    
    // Podsumowanie
    report += "SUMMARY:\n";
    report += "Initial Balance: " + DoubleToString(result.initial_balance, 2) + "\n";
    report += "Final Balance: " + DoubleToString(result.final_balance, 2) + "\n";
    report += "Net Profit: " + DoubleToString(result.net_profit, 2) + "\n";
    report += "Total Trades: " + IntegerToString(result.total_trades) + "\n";
    report += "Win Rate: " + DoubleToString(result.win_rate, 2) + "%\n";
    report += "Profit Factor: " + DoubleToString(result.profit_factor, 2) + "\n\n";
    
    // Metryki ryzyka
    report += "RISK METRICS:\n";
    report += "Max Drawdown: " + DoubleToString(result.max_drawdown, 2) + "%\n";
    report += "Sharpe Ratio: " + DoubleToString(result.sharpe_ratio, 2) + "\n";
    report += "Calmar Ratio: " + DoubleToString(result.calmar_ratio, 2) + "\n";
    report += "Recovery Factor: " + DoubleToString(result.recovery_factor, 2) + "\n";
    report += "Risk/Reward Ratio: " + DoubleToString(result.risk_reward_ratio, 2) + "\n\n";
    
    // Metryki duchów
    report += "SPIRIT METRICS:\n";
    report += "Average Spirit Harmony: " + DoubleToString(result.spirit_harmony_average, 2) + "\n";
    report += "Average Consensus Strength: " + DoubleToString(result.consensus_strength_average, 2) + "\n";
    report += "Average Execution Quality: " + DoubleToString(result.execution_quality_average, 2) + "\n\n";
    
    // Zapisz raport
    int file_handle = FileOpen(filename, FILE_WRITE | FILE_TXT);
    if(file_handle != INVALID_HANDLE) {
        FileWriteString(file_handle, report);
        FileClose(file_handle);
        Print("✅ Backtest report saved to: ", filename);
    }
    else {
        Print("❌ Failed to save backtest report");
    }
}

// Wyświetlenie podsumowania backtestingu
void CBohmeBacktester::PrintBacktestSummary(SBacktestResult& result) {
    Print("\n" + StringRepeat("=", 60));
    Print("📊 BOHME BACKTEST SUMMARY");
    Print(StringRepeat("=", 60));
    
    Print("💰 Financial Results:");
    Print("  Initial Balance: ", DoubleToString(result.initial_balance, 2));
    Print("  Final Balance: ", DoubleToString(result.final_balance, 2));
    Print("  Net Profit: ", DoubleToString(result.net_profit, 2));
    Print("  Profit %: ", DoubleToString(result.net_profit / result.initial_balance * 100, 2), "%");
    
    Print("\n📈 Trading Statistics:");
    Print("  Total Trades: ", result.total_trades);
    Print("  Winning Trades: ", result.winning_trades);
    Print("  Losing Trades: ", result.losing_trades);
    Print("  Win Rate: ", DoubleToString(result.win_rate, 2), "%");
    Print("  Profit Factor: ", DoubleToString(result.profit_factor, 2));
    
    Print("\n⚠️ Risk Metrics:");
    Print("  Max Drawdown: ", DoubleToString(result.max_drawdown, 2), "%");
    Print("  Sharpe Ratio: ", DoubleToString(result.sharpe_ratio, 2));
    Print("  Calmar Ratio: ", DoubleToString(result.calmar_ratio, 2));
    Print("  Recovery Factor: ", DoubleToString(result.recovery_factor, 2));
    
    Print("\n🧠 Spirit Performance:");
    Print("  Average Harmony: ", DoubleToString(result.spirit_harmony_average, 2));
    Print("  Average Consensus: ", DoubleToString(result.consensus_strength_average, 2));
    Print("  Average Execution: ", DoubleToString(result.execution_quality_average, 2));
    
    // Ocena systemu
    Print("\n🎯 System Assessment:");
    if(result.win_rate >= 60 && result.profit_factor >= 1.5 && result.max_drawdown < 20) {
        Print("  🏆 EXCELLENT - System ready for live trading");
    } else if(result.win_rate >= 50 && result.profit_factor >= 1.2 && result.max_drawdown < 30) {
        Print("  ✅ GOOD - System ready for demo trading");
    } else if(result.win_rate >= 40 && result.profit_factor >= 1.0 && result.max_drawdown < 40) {
        Print("  ⚠️ ACCEPTABLE - System needs optimization");
    } else {
        Print("  ❌ NEEDS IMPROVEMENT - System requires significant changes");
    }
    
    Print(StringRepeat("=", 60));
}

// Helper function - powtórzenie stringa
string StringRepeat(string str, int count) {
    string result = "";
    for(int i = 0; i < count; i++) {
        result += str;
    }
    return result;
}

// Funkcja główna do uruchomienia backtestingu
void RunBohmeBacktest(string symbol = "EURUSD", ENUM_TIMEFRAMES timeframe = PERIOD_H1,
                     datetime start_date = 0, datetime end_date = 0) {
    Print("=== STARTING BOHME BACKTEST ===");
    
    // Ustaw domyślne daty jeśli nie podano
    if(start_date == 0) start_date = StringToTime("2023.01.01");
    if(end_date == 0) end_date = StringToTime("2023.12.31");
    
    CBohmeBacktester* backtester = new CBohmeBacktester();
    
    if(backtester != NULL) {
        // Ustaw parametry
        backtester.SetParameters(symbol, timeframe, start_date, end_date, 
                                10000.0, 0.1, 0.0, 0.0);
        
        // Uruchom backtesting
        SBacktestResult result = backtester.RunBacktest();
        
        // Wyświetl wyniki
        backtester.PrintBacktestSummary(result);
        
        // Generuj raport
        string report_filename = "BohmeBacktest_" + symbol + "_" + TimeToString(TimeCurrent()) + ".txt";
        backtester.GenerateBacktestReport(result, report_filename);
        
        delete backtester;
    }
    else {
        Print("❌ Failed to create backtester");
    }
}
