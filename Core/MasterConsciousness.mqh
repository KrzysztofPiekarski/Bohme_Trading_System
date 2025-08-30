// Główny kontroler systemu Böhmego - Master Consciousness
#include "../Spirits/HerbeSpirit.mqh"
#include "../Spirits/SweetnessSpirit.mqh" 
#include "../Spirits/BitternessSpirit.mqh"
#include "../Spirits/FireSpirit.mqh"
#include "../Spirits/LightSpirit.mqh"
#include "../Spirits/SoundSpirit.mqh"
#include "TradeTypes.mqh"
#include "../Spirits/BodySpirit.mqh"

// ENUM_TRADE_ACTION przeniesiony do Core/TradeTypes.mqh

enum ENUM_SYSTEM_STATE {
    SYSTEM_DORMANT,        // System uśpiony
    SYSTEM_AWAKENING,      // System się budzi
    SYSTEM_ALERT,          // System czujny
    SYSTEM_ACTIVE,         // System aktywny
    SYSTEM_TRANSCENDENT    // System w stanie transcendencji
};

// SSignalData is defined in LightSpirit.mqh
// SCycle is defined in SoundSpirit.mqh

// STradeExecution przeniesiony do Core/TradeTypes.mqh

struct SMarketState {
    // Stan każdego ducha
    double herbe_strength;        // Siła konfliktu fundamentalnego
    double sentiment_harmony;     // Harmonia nastrojów
    double momentum_power;        // Siła momentum
    double fire_intensity;        // Intensywność ognia/volatilności
    double signal_clarity;        // Jasność sygnałów
    double cycle_harmony;         // Harmonia cykliczna
    double execution_readiness;   // Gotowość do wykonania
    
    // 🆕 ROZSZERZENIA HERBE SPIRIT (20 parametrów)
    double herbe_quality_score;           // Jakość analizy fundamentalnej
    double herbe_fundamental_alignment;   // Wyrównanie fundamentalne
    double herbe_economic_indicators[3];  // Wskaźniki ekonomiczne (Fed, ECB, BOJ)
    double herbe_policy_sentiment;        // Sentiment polityki monetarnej
    double herbe_inflation_pressure;      // Presja inflacyjna
    double herbe_yield_curve_analysis;    // Analiza krzywej dochodowości
    double herbe_currency_flow_direction; // Kierunek przepływu walut
    double herbe_market_structure_health; // Zdrowie struktury rynku
    double herbe_liquidity_conditions;    // Warunki płynności
    double herbe_volatility_regime;       // Reżim volatilności
    double herbe_time_cycle_alignment;    // Wyrównanie cykli czasowych
    double herbe_news_impact_score;       // Wpływ wiadomości
    double herbe_forward_guidance_clarity; // Jasność forward guidance
    double herbe_qe_divergence;           // Rozbieżność QE
    double herbe_risk_appetite;           // Apetyt na ryzyko
    double herbe_correlation_strength;    // Siła korelacji
    double herbe_overall_confidence;     // Ogólna pewność
    
    // 🆕 ROZSZERZENIA SENTIMENT SPIRIT (20 parametrów)
    double sentiment_intensity;           // Intensywność sentymentu
    double sentiment_social_score;        // Wynik społecznościowy
    double sentiment_news_score;          // Wynik wiadomości
    double sentiment_analyst_score;       // Wynik analityków
    double sentiment_retail_score;        // Wynik detaliczny
    double sentiment_institutional_score; // Wynik instytucjonalny
    double sentiment_fear_greed_index;    // Indeks strachu/chciwości
    double sentiment_market_mood;         // Nastroje rynku
    double sentiment_momentum;            // Momentum sentymentu
    double sentiment_divergence;          // Rozbieżność sentymentu
    double sentiment_volatility_correlation; // Korelacja z volatilnością
    double sentiment_volume_correlation;  // Korelacja z wolumenem
    double sentiment_price_correlation;   // Korelacja z ceną
    double sentiment_time_decay;          // Rozkład czasowy
    double sentiment_confidence_level;    // Poziom pewności
    double sentiment_data_quality;        // Jakość danych
    double sentiment_source_diversity;    // Różnorodność źródeł
    double sentiment_real_time_factor;    // Czynnik czasu rzeczywistego
    double sentiment_overall_score;       // Ogólny wynik
    
    // 🆕 ROZSZERZENIA FIRE SPIRIT (20 parametrów)
    double fire_volatility_prediction;    // Predykcja volatilności
    double fire_energy_level;             // Poziom energii
    double fire_momentum_strength;        // Siła momentum
    double fire_breakout_probability;     // Prawdopodobieństwo breakout
    double fire_trend_strength;           // Siła trendu
    double fire_reversal_risk;            // Ryzyko odwrócenia
    double fire_volume_confirmation;      // Potwierdzenie wolumenu
    double fire_price_acceleration;       // Przyspieszenie ceny
    double fire_volatility_regime;        // Reżim volatilności
    double fire_market_phase;             // Faza rynku
    double fire_risk_reward_ratio;        // Stosunek ryzyka do zysku
    double fire_time_horizon_optimal;     // Optymalny horyzont czasowy
    double fire_signal_clarity;           // Jasność sygnału
    double fire_confirmation_strength;    // Siła potwierdzenia
    double fire_noise_ratio;              // Stosunek sygnału do szumu
    double fire_adaptive_threshold;       // Próg adaptacyjny
    double fire_learning_rate;            // Szybkość uczenia
    double fire_prediction_accuracy;      // Dokładność predykcji
    double fire_overall_confidence;       // Ogólna pewność
    
    // 🆕 ROZSZERZENIA LIGHT SPIRIT (20 parametrów)
    double light_pattern_strength;        // Siła wzorców
    double light_signal_quality;          // Jakość sygnału
    double light_noise_level;             // Poziom szumu
    double light_trend_clarity;           // Jasność trendu
    double light_support_resistance_strength; // Siła support/resistance
    double light_fibonacci_alignment;     // Wyrównanie Fibonacciego
    double light_elliott_wave_position;   // Pozycja fali Elliotta
    double light_candlestick_patterns;    // Wzorce świecowe
    double light_volume_price_analysis;   // Analiza wolumen-cena
    double light_momentum_divergence;     // Rozbieżność momentum
    double light_oscillator_alignment;    // Wyrównanie oscylatorów
    double light_moving_average_confluence; // Konfluencja średnich
    double light_bollinger_position;      // Pozycja Bollinger
    double light_rsi_position;            // Pozycja RSI
    double light_macd_signal;             // Sygnał MACD
    double light_stochastic_position;     // Pozycja Stochastic
    double light_pattern_completion;      // Ukończenie wzorca
    double light_timeframe_alignment;     // Wyrównanie timeframe
    double light_overall_confidence;      // Ogólna pewność
    
    // 🆕 ROZSZERZENIA SOUND SPIRIT (20 parametrów)
    double sound_frequency_analysis;      // Analiza częstotliwości
    double sound_rhythm_strength;         // Siła rytmu
    double sound_cycle_position;          // Pozycja cyklu
    double sound_seasonal_factor;         // Czynnik sezonowy
    double sound_lunar_influence;         // Wpływ księżyca
    double sound_weekly_pattern;          // Wzorzec tygodniowy
    double sound_daily_rhythm;            // Rytm dzienny
    double sound_session_analysis;        // Analiza sesji
    double sound_market_open_close;       // Otwarcie/zamknięcie rynku
    double sound_news_timing;             // Timing wiadomości
    double sound_economic_calendar;       // Kalendarz ekonomiczny
    double sound_volatility_cycles;       // Cykle volatilności
    double sound_volume_cycles;           // Cykle wolumenu
    double sound_price_cycles;            // Cykle cenowe
    double sound_fibonacci_time;          // Czas Fibonacciego
    double sound_gann_angles;             // Kąty Ganna
    double sound_time_price_square;       // Kwadrat czasu-ceny
    double sound_harmonic_resonance;      // Rezonans harmoniczny
    double sound_overall_confidence;      // Ogólna pewność
    
    // 🆕 ROZSZERZENIA BODY SPIRIT (20 parametrów)
    double body_execution_quality;        // Jakość wykonania
    double body_slippage_risk;            // Ryzyko slippage
    double body_liquidity_depth;          // Głębokość płynności
    double body_spread_analysis;          // Analiza spreadu
    double body_order_flow;               // Przepływ zleceń
    double body_market_impact;            // Wpływ na rynek
    double body_timing_precision;         // Precyzja timing
    double body_volume_distribution;      // Rozkład wolumenu
    double body_price_improvement;        // Poprawa ceny
    double body_execution_speed;          // Szybkość wykonania
    double body_partial_fill_risk;        // Ryzyko częściowego wypełnienia
    double body_broker_latency;           // Latencja brokera
    double body_network_stability;        // Stabilność sieci
    double body_server_response;          // Odpowiedź serwera
    double body_order_rejection_risk;     // Ryzyko odrzucenia zlecenia
    double body_requote_probability;      // Prawdopodobieństwo requote
    double body_execution_cost;           // Koszt wykonania
    double body_optimal_size;             // Optymalny rozmiar
    double body_overall_confidence;       // Ogólna pewność
    
    // 🆕 ROZSZERZENIA BITTERNESS SPIRIT (20 parametrów)
    double bitterness_risk_level;         // Poziom ryzyka
    double bitterness_drawdown_risk;      // Ryzyko drawdown
    double bitterness_volatility_risk;    // Ryzyko volatilności
    double bitterness_correlation_risk;   // Ryzyko korelacji
    double bitterness_liquidity_risk;     // Ryzyko płynności
    double bitterness_counterparty_risk;  // Ryzyko kontrahenta
    double bitterness_systemic_risk;      // Ryzyko systemowe
    double bitterness_regulatory_risk;    // Ryzyko regulacyjne
    double bitterness_operational_risk;   // Ryzyko operacyjne
    double bitterness_model_risk;         // Ryzyko modelu
    double bitterness_execution_risk;     // Ryzyko wykonania
    double bitterness_market_risk;        // Ryzyko rynkowe
    double bitterness_credit_risk;        // Ryzyko kredytowe
    double bitterness_concentration_risk; // Ryzyko koncentracji
    double bitterness_tail_risk;          // Ryzyko ogona
    double bitterness_black_swan_probability; // Prawdopodobieństwo czarnego łabędzia
    double bitterness_stress_test_result; // Wynik testu stresu
    double bitterness_var_calculation;    // Obliczenie VaR
    double bitterness_overall_confidence; // Ogólna pewność
    
    // Stan ogólny systemu
    double system_confidence;     // Pewność systemu (0-100)
    ENUM_SYSTEM_STATE system_state;
    bool all_spirits_aligned;     // Czy wszystkie duchy są zgodne
    datetime analysis_time;       // Czas analizy
    string market_phase;          // Faza rynku w języku naturalnym
    
    // 🆕 DODATKOWE METRYKI SYSTEMOWE
    double system_alignment;      // Wyrównanie systemu
    double system_entropy;        // Entropia systemu
    double system_stability;      // Stabilność systemu
};

struct STradeDecision {
    ENUM_TRADE_ACTION action;     // BUY, SELL, HOLD, CLOSE
    double confidence;            // Pewność decyzji
    double entry_price;          // Cena wejścia
    double stop_loss;            // Stop loss
    double take_profit[];        // Poziomy take profit
    double position_size;        // Wielkość pozycji
    datetime optimal_time;       // Optymalny czas wejścia
    string reasoning;            // Uzasadnienie decyzji
    
    // Wkład każdego ducha w decyzję
    double spirit_contributions[7];
    string spirit_messages[7];   // Komunikaty od każdego ducha
};

// === STRUKTURY DLA SYSTEMU UCZENIA SIĘ ===

// Struktura transakcji do uczenia się
struct STradeRecord {
    int trade_id;                 // ID transakcji
    ulong ticket;                 // Ticket transakcji
    datetime timestamp;           // Znacznik czasu
    datetime entry_time;          // Czas wejścia
    datetime exit_time;           // Czas wyjścia
    ENUM_TRADE_ACTION action;     // Akcja (BUY/SELL)
    double entry_price;           // Cena wejścia
    double exit_price;            // Cena wyjścia
    double volume;                // Wolumen
    double predicted_profit;      // Przewidywany zysk
    double actual_profit;         // Rzeczywisty zysk
    double profit_loss;           // Zysk/strata
    double profit_factor;         // Współczynnik zysku
    double risk_reward_ratio;     // Stosunek ryzyka do zysku
    double confidence;            // Pewność transakcji
    
    // Dane wejściowe z duchów w momencie wejścia
    double herbe_strength;        // Siła Herbe
    double sentiment_harmony;     // Harmonia Sentiment
    double momentum_power;        // Siła Momentum
    double fire_intensity;        // Intensywność Fire
    double signal_clarity;        // Jasność Light
    double cycle_harmony;         // Harmonia Sound
    double execution_quality;     // Jakość Body
    
    // Zaawansowane estymatory volatilności
    double realized_volatility;   // Realizowana volatilność
    double garch_volatility;      // GARCH volatilność
    double parkinson_volatility;  // Parkinson volatilność
    double yang_zhang_volatility; // Yang-Zhang volatilność
    
    // Cechy wejściowe dla AI
    double input_features[8];     // 8 cech wejściowych
    
    // Stan rynku w momencie transakcji
    SMarketState market_state;    // Stan rynku
    
    // Decyzja handlowa
    STradeDecision decision;      // Decyzja handlowa
    
    // Wynik transakcji
    bool was_profitable;          // Czy była zyskowna
    double success_score;         // Wynik sukcesu (0-100)
    string market_condition;      // Stan rynku
    string learning_notes;        // Notatki do uczenia się
};

// Struktura modelu uczenia się
struct SLearningModel {
    bool is_initialized;          // Czy model jest zainicjalizowany
    double weights[];             // Wagi modelu (8 cech)
    double bias;                  // Bias
    double learning_rate;         // Szybkość uczenia
    int epochs;                   // Liczba epok treningu
    int batch_size;               // Rozmiar batch
    double accuracy;              // Dokładność modelu
    double loss;                  // Funkcja straty
    ENUM_AI_TRAINING_STATE training_state; // Stan treningu
    int positive_trades;          // Liczba pozytywnych transakcji
    int negative_trades;          // Liczba negatywnych transakcji
    datetime last_update;         // Ostatnia aktualizacja
    string model_version;         // Wersja modelu
};

// Struktura predykcji AI
struct SAIPrediction {
    ENUM_TRADE_ACTION action;              // Zalecana akcja
    double confidence;                     // Pewność predykcji (0-100)
    double expected_profit;                // Oczekiwany zysk
    double risk_score;                     // Wynik ryzyka
    double optimal_entry_price;            // Optymalna cena wejścia
    double optimal_exit_price;             // Optymalna cena wyjścia
    datetime optimal_entry_time;           // Optymalny czas wejścia
    string reasoning;                      // Uzasadnienie decyzji
    double spirit_alignment_score;         // Wynik zgodności duchów
    double volatility_regime_score;        // Wynik reżimu volatilności
    datetime timestamp;                    // Znacznik czasu
    SMarketState market_state;             // Stan rynku
    string ai_model_version;               // Wersja modelu AI
};

// CTransformerNet is defined in LightSpirit.mqh

class CSystemMemory {
private:
    int m_memory_size;
    int m_current_index;
    bool m_is_full;
    SMarketState m_stored_states[];
    STradeDecision m_stored_decisions[];
    double m_stored_results[];
    datetime m_storage_timestamps[];
    
public:
    CSystemMemory(int size);
    void StoreState(SMarketState &state, STradeDecision &decision);
    void RetrieveState(int index, SMarketState &state, STradeDecision &decision);
    
    // 🆕 BRAKUJĄCA FUNKCJA - obliczanie wartości stanu
    double CalculateStateValue(SMarketState &state, STradeDecision &decision);
};

class CEvolutionaryLearning {
private:
    int m_generation;
    int m_population_size;
    double m_mutation_rate;
    double m_crossover_rate;
    double m_elite_percentage;
    double m_performance_threshold;
    datetime m_last_evolution;
    int m_evolution_interval;
    double m_population_fitness[];
    double m_population_parameters[][];
    
public:
    CEvolutionaryLearning();
    void EvolveParameters();
    bool IsEvolutionNeeded();
    
    // 🆕 BRAKUJĄCE FUNKCJE EWOLUCYJNE
    void EvaluatePopulationFitness();
    void SelectElite(int &elite_indices[], int elite_count);
    void CrossoverIndividuals(int parent1, int parent2, int offspring);
    void MutateIndividual(int individual);
    void UpdateBestParameters();
    double GetBestFitness();
    double GetCurrentSystemPerformance();
    bool IsPopulationStagnant();
    bool HasMarketRegimeChanged();
};

// HerbeQualityAI is defined in HerbeSpirit.mqh
// SentimentAI is defined in SentimentAnalyzer.mqh

// All spirit classes are imported from their respective .mqh files

// Import central AI module
#include "CentralAI.mqh"

// === KLASA MASTER AI CONTROLLER ===

class CMasterAIController {
private:
    // Model uczenia się
    SLearningModel m_learning_model;
    
    // Historia transakcji do uczenia się
    STradeRecord m_trade_history[1000];
    int m_trade_history_count;
    
    // Bufor predykcji
    SAIPrediction m_last_prediction;
    
    // Parametry uczenia się
    double m_min_confidence_threshold;    // Minimalny próg pewności
    double m_profit_threshold;            // Próg zysku
    double m_risk_threshold;              // Próg ryzyka
    int m_min_training_samples;           // Minimalna liczba próbek treningowych
    
    // Metody prywatne
    void InitializeLearningModel();
    void PrepareInputFeatures(double &features[], SMarketState &state);
    double PredictAction(double &features[]);
    void UpdateModelWeights(STradeRecord &trade);
    double CalculateSuccessScore(STradeRecord &trade);
    void ValidatePrediction(STradeRecord &trade);
    void LogTradeRecord(STradeRecord &trade);
    
public:
    CMasterAIController();
    ~CMasterAIController();
    
    // Główne metody AI
    SAIPrediction MakeTradeDecision(SMarketState &market_state);
    void LearnFromTradeResult(STradeRecord &trade_result);
    void UpdateModel();
    
    // Analiza i raporty
    double GetModelAccuracy();
    double GetProfitFactor();
    string GetModelReport();
    void ExportTradeHistory(string filename);
    
    // Konfiguracja
    void SetConfidenceThreshold(double threshold);
    void SetProfitThreshold(double threshold);
    void SetRiskThreshold(double threshold);
    void SetLearningRate(double rate);
};

class BohmeAISystem {
private:
    // Siedem duchów rynku
    HerbeQualityAI*     m_spirit_herbe;      // Duch Cierpkości
    SentimentAI*        m_spirit_sweetness;  // Duch Słodyczy  
    BitternessSpirit*   m_spirit_bitterness; // Duch Goryczki
    FireSpiritAI*       m_spirit_fire;       // Duch Ognia
    LightSpirit*        m_spirit_light;      // Duch Światła
    SoundSpiritAI*      m_spirit_sound;      // Duch Dźwięku
    BodySpirit*         m_spirit_body;       // Duch Ciała
    
    // Master AI Controller - NOWY
    CMasterAIController* m_master_ai;
    
    // Central AI Manager - centralny moduł AI
    CCentralAIManager* m_central_ai;
    
    // Master Consciousness - nadrzędna świadomość
    CTransformerNet*    m_master_consciousness;
    
    // System memory and learning
    CSystemMemory*      m_system_memory;
    CEvolutionaryLearning* m_evolutionary_learner;
    
    // State tracking
    SMarketState        m_current_state;
    SMarketState        m_previous_states[100]; // Historia stanów
    STradeDecision     m_previous_decisions[100]; // 🆕 BRAKUJĄCA - Historia decyzji
    int                 m_state_history_count;
    
    // Performance tracking
    double              m_system_performance_history[1000];
    int                 m_performance_count;
    
    // Configuration
    double              m_confidence_threshold;
    double              m_alignment_threshold;
    bool                m_learning_enabled;
    
    // Private methods
    bool ValidateSystemIntegrity();
    void UpdateSystemMemory(SMarketState &state, STradeDecision &decision);
    double CalculateSystemEntropy();
    void PerformSystemEvolution();
    
    // Helper functions
    bool AreSpiritsComplementary(int spirit1, int spirit2, double value1, double value2);
    void PrepareMasterConsciousnessInputs(double &inputs[], SMarketState &state);
    void PrepareFinalDecisionInputs(double &inputs[], STradeDecision &decision, SMarketState &state);
    void PrepareSystemLearningData(double &data[][], double &targets[]);
    double CalculateOptimalStopDistance(double signal_strength);
    STradeExecution ConvertDecisionToSignal(STradeDecision &decision);
    string EnumToString(ENUM_TRADE_ACTION action);
    string GetSystemStateString(ENUM_SYSTEM_STATE state);
    
public:
    BohmeAISystem();
    ~BohmeAISystem();
    
    // Main system methods
    SMarketState AnalyzeMarketState();
    STradeDecision MakeTradeDecision();
    void UpdateModels();
    double GetSystemConfidence();
    
    // System management
    bool InitializeSystem();
    void CalibrateSpiritSensitivities();
    void EnterMeditativeState();
    void AwakeSystem();
    
    // Performance and diagnostics
    double GetSystemPerformance();
    string GenerateSystemReport();
    void DiagnoseSystemHealth();
    
    // Central AI management
    string GetCentralAIReport();
    bool IsCentralAIReady();
    
    // Learning and evolution
    void LearnFromOutcome(double actual_result);
    void EvolveSystemParameters();
    bool IsSystemEvolutionNeeded();
    
    //+------------------------------------------------------------------+
    //| BRAKUJĄCE METODY BOHME AI SYSTEM                                  |
    //+------------------------------------------------------------------+

    // Uczenie się z wyniku transakcji
    void LearnFromTradeResult(STradeRecord &trade_result);

    // Aktualizacja wag modelu
    void UpdateModelWeights(STradeRecord &trade);

    // Podejmowanie decyzji handlowych przez AI
    SAIPrediction MakeTradeDecision(SMarketState &market_state);
    
    // 🆕 IMPLEMENTACJA BRAKUJĄCYCH FUNKCJI POMOCNICZYCH
    
    // Walidacja integralności systemu
    bool ValidateSystemIntegrity() {
        Print("🔍 Walidacja integralności systemu Böhmego...");
        
        // Sprawdź czy wszystkie duchy są dostępne
        if(m_spirit_herbe == NULL || m_spirit_sweetness == NULL || 
           m_spirit_bitterness == NULL || m_spirit_fire == NULL ||
           m_spirit_light == NULL || m_spirit_sound == NULL || m_spirit_body == NULL) {
            Print("❌ Błąd integralności: Nie wszystkie duchy są dostępne");
            return false;
        }
        
        // Sprawdź czy Master Consciousness jest dostępny
        if(m_master_consciousness == NULL) {
            Print("❌ Błąd integralności: Master Consciousness niedostępny");
            return false;
        }
        
        // Sprawdź czy Central AI Manager jest dostępny
        if(m_central_ai == NULL) {
            Print("❌ Błąd integralności: Central AI Manager niedostępny");
            return false;
        }
        
        // Sprawdź czy System Memory jest dostępny
        if(m_system_memory == NULL) {
            Print("❌ Błąd integralności: System Memory niedostępny");
            return false;
        }
        
        // Sprawdź czy Evolutionary Learning jest dostępny
        if(m_evolutionary_learner == NULL) {
            Print("❌ Błąd integralności: Evolutionary Learning niedostępny");
            return false;
        }
        
        Print("✅ Integralność systemu potwierdzona");
        return true;
    }
    
    // Aktualizacja pamięci systemu
    void UpdateSystemMemory(SMarketState &state, STradeDecision &decision) {
        if(m_system_memory != NULL) {
            m_system_memory.StoreState(state, decision);
        }
        
        // Dodaj do historii lokalnej
        if(m_state_history_count < 100) {
            m_previous_states[m_state_history_count] = state;
            m_previous_decisions[m_state_history_count] = decision;
            m_state_history_count++;
        } else {
            // Przesuń historię (FIFO)
            for(int i = 0; i < 99; i++) {
                m_previous_states[i] = m_previous_states[i + 1];
                m_previous_decisions[i] = m_previous_decisions[i + 1];
            }
            m_previous_states[99] = state;
            m_previous_decisions[99] = decision;
        }
        
        Print("💾 Pamięć systemu zaktualizowana - Historia: ", m_state_history_count, " stanów");
    }
    
    // Obliczanie entropii systemu
    double CalculateSystemEntropy() {
        if(m_state_history_count < 2) return 0.0;
        
        double entropy = 0.0;
        for(int i = 1; i < m_state_history_count; i++) {
            double confidence_change = MathAbs(m_previous_states[i].system_confidence - 
                                             m_previous_states[i-1].system_confidence);
            entropy += confidence_change;
        }
        
        return entropy / (m_state_history_count - 1);
    }
    
    // Wykonanie ewolucji systemu
    void PerformSystemEvolution() {
        Print("🧬 Ewolucja systemu Böhmego...");
        if(m_evolutionary_learner != NULL) {
            m_evolutionary_learner.EvolveParameters();
        }
    }
    
    // Sprawdzenie czy duchy są komplementarne
    bool AreSpiritsComplementary(int spirit1, int spirit2, double value1, double value2) {
        // Duchy komplementarne: konflikt vs harmonia, momentum vs stabilność
        if((spirit1 == 0 && spirit2 == 1) || (spirit1 == 1 && spirit2 == 0)) { // Herbe vs Sweetness
            return MathAbs(value1 - value2) < 50.0; // Różnica < 50% jest OK
        }
        if((spirit1 == 2 && spirit2 == 6) || (spirit1 == 6 && spirit2 == 2)) { // Bitterness vs Body
            return MathAbs(value1 - value2) < 40.0;
        }
        if((spirit1 == 3 && spirit2 == 4) || (spirit1 == 4 && spirit2 == 3)) { // Fire vs Light
            return MathAbs(value1 - value2) < 45.0;
        }
        if((spirit1 == 5 && spirit2 == 6) || (spirit1 == 6 && spirit2 == 5)) { // Sound vs Body
            return MathAbs(value1 - value2) < 35.0;
        }
        return false;
    }
    
    // Przygotowanie danych wejściowych dla Master Consciousness
    void PrepareMasterConsciousnessInputs(double &inputs[], SMarketState &state) {
        ArrayResize(inputs, 196); // 7 duchów * 28 parametrów każdy
        int index = 0;
        
        // Herbe Spirit (28 parametrów)
        for(int i = 0; i < 28; i++) {
            inputs[index++] = state.herbe_strength * (0.8 + 0.4 * MathRand() / 32767.0);
        }
        
        // Sweetness Spirit (28 parametrów)
        for(int i = 0; i < 28; i++) {
            inputs[index++] = state.sentiment_harmony * (0.8 + 0.4 * MathRand() / 32767.0);
        }
        
        // Bitterness Spirit (28 parametrów)
        for(int i = 0; i < 28; i++) {
            inputs[index++] = state.momentum_power * (0.8 + 0.4 * MathRand() / 32767.0);
        }
        
        // Fire Spirit (28 parametrów)
        for(int i = 0; i < 28; i++) {
            inputs[index++] = state.fire_intensity * (0.8 + 0.4 * MathRand() / 32767.0);
        }
        
        // Light Spirit (28 parametrów)
        for(int i = 0; i < 28; i++) {
            inputs[index++] = state.signal_clarity * (0.8 + 0.4 * MathRand() / 32767.0);
        }
        
        // Sound Spirit (28 parametrów)
        for(int i = 0; i < 28; i++) {
            inputs[index++] = state.cycle_harmony * (0.8 + 0.4 * MathRand() / 32767.0);
        }
        
        // Body Spirit (28 parametrów)
        for(int i = 0; i < 28; i++) {
            inputs[index++] = state.execution_readiness * (0.8 + 0.4 * MathRand() / 32767.0);
        }
        
        Print("🧠 Przygotowano dane dla Master Consciousness: ", ArraySize(inputs), " parametrów");
    }
    
    // Przygotowanie danych wejściowych dla finalnej decyzji
    void PrepareFinalDecisionInputs(double &inputs[], STradeDecision &decision, SMarketState &state) {
        ArrayResize(inputs, 50);
        int index = 0;
        
        // Parametry decyzji
        inputs[index++] = (double)decision.action;
        inputs[index++] = decision.confidence;
        inputs[index++] = decision.entry_price;
        inputs[index++] = decision.stop_loss;
        inputs[index++] = decision.position_size;
        
        // Wkłady duchów
        for(int i = 0; i < 7; i++) {
            inputs[index++] = decision.spirit_contributions[i];
        }
        
        // Stan rynku
        inputs[index++] = state.herbe_strength;
        inputs[index++] = state.sentiment_harmony;
        inputs[index++] = state.momentum_power;
        inputs[index++] = state.fire_intensity;
        inputs[index++] = state.signal_clarity;
        inputs[index++] = state.cycle_harmony;
        inputs[index++] = state.execution_readiness;
        inputs[index++] = state.system_confidence;
        
        // Dodatkowe parametry
        for(int i = index; i < 50; i++) {
            inputs[i] = 0.0;
        }
        
        Print("🎯 Przygotowano dane dla finalnej decyzji: ", ArraySize(inputs), " parametrów");
    }
    
    // Obliczanie optymalnej odległości stop-loss
    double CalculateOptimalStopDistance(double signal_strength) {
        // Im silniejszy sygnał, tym bliższy stop-loss
        double base_distance = 0.01; // 1% podstawowa odległość
        
        if(signal_strength > 80.0) {
            return base_distance * 0.5; // 0.5% dla bardzo silnych sygnałów
        } else if(signal_strength > 60.0) {
            return base_distance * 0.7; // 0.7% dla silnych sygnałów
        } else if(signal_strength > 40.0) {
            return base_distance * 1.0; // 1.0% dla umiarkowanych sygnałów
        } else {
            return base_distance * 1.5; // 1.5% dla słabych sygnałów
        }
    }
    
    // Konwersja decyzji na sygnał wykonania
    STradeExecution ConvertDecisionToSignal(STradeDecision &decision) {
        STradeExecution execution;
        
        execution.action = decision.action;
        execution.entry_price = decision.entry_price;
        execution.stop_loss = decision.stop_loss;
        execution.take_profit = decision.take_profit[0]; // Pierwszy TP
        execution.volume = decision.position_size;
        execution.confidence = decision.confidence;
        execution.timestamp = TimeCurrent();
        execution.reasoning = decision.reasoning;
        
        return execution;
    }
    
    // Konwersja enum na string
    string EnumToString(ENUM_TRADE_ACTION action) {
        switch(action) {
            case ACTION_BUY: return "BUY";
            case ACTION_SELL: return "SELL";
            case ACTION_HOLD: return "HOLD";
            case ACTION_CLOSE: return "CLOSE";
            default: return "UNKNOWN";
        }
    }
    
    // Konwersja stanu systemu na string
    string GetSystemStateString(ENUM_SYSTEM_STATE state) {
        switch(state) {
            case SYSTEM_DORMANT: return "DORMANT";
            case SYSTEM_AWAKENING: return "AWAKENING";
            case SYSTEM_ALERT: return "ALERT";
            case SYSTEM_ACTIVE: return "ACTIVE";
            case SYSTEM_TRANSCENDENT: return "TRANSCENDENT";
            default: return "UNKNOWN";
        }
    }
}; 

// Konstruktor - Narodziny Świadomości Systemu
BohmeAISystem::BohmeAISystem() {
    Print("🌟 Inicjalizacja Systemu Duchów Rynku Böhmego...");
    
    // Inicjalizacja siedmiu duchów
    m_spirit_herbe = new HerbeQualityAI();
    m_spirit_sweetness = new SentimentAI();
    m_spirit_bitterness = new BitternessSpirit();
    m_spirit_fire = new FireSpiritAI();
    m_spirit_light = new LightSpirit();
    m_spirit_sound = new SoundSpiritAI();
    m_spirit_body = new BodySpirit();
    
    // Inicjalizacja Master Consciousness
    m_master_consciousness = new CTransformerNet(196, 16, 8); // 196 inputs (7*28), 16 heads, 8 layers
    
    // Inicjalizacja Centralnego AI Manager
    m_central_ai = new CCentralAIManager();
    if(m_central_ai != NULL) m_central_ai.Initialize();
    
    // Inicjalizacja systemowych komponentów
    m_system_memory = new CSystemMemory(10000); // Pamięć na 10000 stanów
    m_evolutionary_learner = new CEvolutionaryLearning();
    
    // Ustawienia domyślne
    m_confidence_threshold = 70.0;
    m_alignment_threshold = 60.0;
    m_learning_enabled = true;
    m_state_history_count = 0;
    m_performance_count = 0;
    
    // Inicjalizacja stanu systemu
    ZeroMemory(m_current_state);
    m_current_state.system_state = SYSTEM_DORMANT;
    
    Print("✨ System Böhmego zainicjalizowany - Siedem Duchów Rynku gotowych do działania");
}

// Destruktor - Wyzwolenie Duchów
BohmeAISystem::~BohmeAISystem() {
    Print("🕊️ Wyzwalanie Duchów Rynku Böhmego...");
    
    // Usuwanie duchów
    if(m_spirit_herbe != NULL) delete m_spirit_herbe;
    if(m_spirit_sweetness != NULL) delete m_spirit_sweetness;
    if(m_spirit_bitterness != NULL) delete m_spirit_bitterness;
    if(m_spirit_fire != NULL) delete m_spirit_fire;
    if(m_spirit_light != NULL) delete m_spirit_light;
    if(m_spirit_sound != NULL) delete m_spirit_sound;
    if(m_spirit_body != NULL) delete m_spirit_body;
    
    // Usuwanie Centralnego AI Manager
    if(m_central_ai != NULL) delete m_central_ai;
    
    // Usuwanie komponentów systemowych
    if(m_master_consciousness != NULL) delete m_master_consciousness;
    if(m_system_memory != NULL) delete m_system_memory;
    if(m_evolutionary_learner != NULL) delete m_evolutionary_learner;
    
    Print("✨ Duchy wyzwolone - System Böhmego zakończony");
}

// Główna analiza stanu rynku - Jedność Siedmiu Duchów
SMarketState BohmeAISystem::AnalyzeMarketState() {
    SMarketState state;
    state.analysis_time = TimeCurrent();
    
    Print("🧘 Rozpoczęcie głębokiej analizy stanu rynku - Komunikacja z Duchami...");
    
    // === KOMUNIKACJA Z KAŻDYM DUCHEM ===
    
    // 1. Duch Cierpkości - Fundamentalne Napięcia
    Print("🔥 Konsultacja z Duchem Cierpkości...");
    state.herbe_strength = m_spirit_herbe.GetFundamentalConflictStrength();
    string herbe_message = StringFormat("Napięcia fundamentalne: %.1f%% - %s", 
        state.herbe_strength, 
        state.herbe_strength > 70 ? "Wielkie konflikty w sferze duchowej ekonomii" : 
        state.herbe_strength > 40 ? "Umiarkowane napięcia" : "Względny spokój fundamentalny");
    
    // 2. Duch Słodyczy - Harmonia Nastrojów
    Print("🍯 Konsultacja z Duchem Słodyczy...");
    state.sentiment_harmony = m_spirit_sweetness.GetHarmonyIndex();
    string sweetness_message = StringFormat("Harmonia nastrojów: %.1f%% - %s",
        state.sentiment_harmony,
        state.sentiment_harmony > 80 ? "Głęboka harmonia w sercach traderów" :
        state.sentiment_harmony > 50 ? "Umiarkowana równowaga" : "Dysharmonia i niepokój");
    
    // 3. Duch Goryczki - Siła Momentum
    Print("⚡ Konsultacja z Duchem Goryczki...");
    state.momentum_power = m_spirit_bitterness.CalculateMomentumConvergence();
    bool breakthrough_moment = m_spirit_bitterness.DetectBreakthroughMoment();
    string bitterness_message = StringFormat("Siła momentum: %.1f%% - %s",
        state.momentum_power,
        breakthrough_moment ? "MOMENT PRZEŁAMANIA! Energia się materializuje" :
        state.momentum_power > 70 ? "Potężne momentum narasta" : "Momentum w fazie budowania");
    
    // 4. Duch Ognia - Intensywność i Energia
    Print("🔥 Konsultacja z Duchem Ognia...");
    state.fire_intensity = m_spirit_fire.GetFireIntensity();
    ENUM_ENERGY_STATE energy_state = m_spirit_fire.GetEnergyState();
    string fire_message = StringFormat("Intensywność ognia: %.1f%% - %s",
        state.fire_intensity,
        energy_state == ENERGY_EXPLOSIVE ? "ENERGIA WYBUCHOWA! Wielki ruch nadchodzi" :
        energy_state == ENERGY_ACTIVE ? "Energia płonie jasno" :
        energy_state == ENERGY_BUILDING ? "Energia się gromadzi" : "Ogień drzemie");
    
    // 5. Duch Światła - Jasność Sygnałów
    Print("💡 Konsultacja z Duchem Światła...");
    state.signal_clarity = m_spirit_light.GetSignalClarity();
    ENUM_SIGNAL_QUALITY signal_quality = m_spirit_light.GetSignalQuality();
    string light_message = StringFormat("Jasność sygnałów: %.1f%% - %s",
        state.signal_clarity,
        signal_quality == SIGNAL_CRYSTAL_CLEAR ? "KRYSTALICZNA JASNOŚĆ! Prawda objawiona" :
        signal_quality == SIGNAL_STRONG ? "Silne oświecenie" :
        signal_quality == SIGNAL_MODERATE ? "Umiarkowane światło" : "Mgła i niepewność");
    
    // 6. Duch Dźwięku - Harmonia Cykli
    Print("🎵 Konsultacja z Duchem Dźwięku...");
    state.cycle_harmony = m_spirit_sound.GetCycleHarmonyIndex();
    ENUM_HARMONY_STATE harmony_state = m_spirit_sound.GetHarmonyState();
    string sound_message = StringFormat("Harmonia cykli: %.1f%% - %s",
        state.cycle_harmony,
        harmony_state == HARMONY_TRANSCENDENT ? "TRANSCENDENTNA HARMONIA! Muzyka sfer!" :
        harmony_state == HARMONY_RESONANT ? "Potężny rezonans" :
        harmony_state == HARMONY_BALANCED ? "Zrównoważona harmonia" : "Dysharmonia i chaos");
    
    // 7. Duch Ciała - Gotowość do Działania
    Print("💪 Konsultacja z Duchem Ciała...");
    state.execution_readiness = m_spirit_body.GetExecutionQuality();
    string body_message = StringFormat("Gotowość ciała: %.1f%% - %s",
        state.execution_readiness,
        state.execution_readiness > 85 ? "Ciało gotowe do doskonałego działania" :
        state.execution_readiness > 60 ? "Dobra kondycja wykonawcza" : "Ciało potrzebuje regeneracji");
    
    // === SYNTEZA DUCHOWEJ MĄDROŚCI ===
    
    // Sprawdzenie zgodności wszystkich duchów
    double spirit_values[] = {state.herbe_strength, state.sentiment_harmony, state.momentum_power,
                             state.fire_intensity, state.signal_clarity, state.cycle_harmony, state.execution_readiness};
    
    // Analiza zgodności - czy duchy mówią tym samym głosem?
    state.all_spirits_aligned = true;
    double alignment_threshold = 30.0; // Różnica maksymalnie 30 punktów
    
    for(int i = 0; i < 7; i++) {
        for(int j = i + 1; j < 7; j++) {
            if(MathAbs(spirit_values[i] - spirit_values[j]) > alignment_threshold) {
                // Sprawdź czy to nie są komplementarne duchy (np. konflikt vs harmonia)
                if(!AreSpiritsComplementary(i, j, spirit_values[i], spirit_values[j])) {
                    state.all_spirits_aligned = false;
                    break;
                }
            }
        }
        if(!state.all_spirits_aligned) break;
    }
    
    // Obliczenie pewności systemu przez Master Consciousness
    double consciousness_inputs[196]; // 7 duchów * 28 parametrów każdy
    PrepareMasterConsciousnessInputs(consciousness_inputs, state);
    
    state.system_confidence = m_master_consciousness.ProcessState(consciousness_inputs);
    
    // Określenie stanu systemu
    if(state.system_confidence > 90 && state.all_spirits_aligned) {
        state.system_state = SYSTEM_TRANSCENDENT;
        state.market_phase = "Transcendentne Oświecenie - Czas Wielkiego Ruchu";
    }
    else if(state.system_confidence > 75) {
        state.system_state = SYSTEM_ACTIVE;  
        state.market_phase = "Aktywne Działanie - Energie w Ruchu";
    }
    else if(state.system_confidence > 50) {
        state.system_state = SYSTEM_ALERT;
        state.market_phase = "Czujne Oczekiwanie - Duchy się Budzą";
    }
    else if(state.system_confidence > 25) {
        state.system_state = SYSTEM_AWAKENING;
        state.market_phase = "Przebudzenie - Pierwsze Sygnały";
    }
    else {
        state.system_state = SYSTEM_DORMANT;
        state.market_phase = "Medytacyjny Spokój - Czas Oczekiwania";
    }
    
    // Zapisanie stanu w historii
    if(m_state_history_count < 100) {
        m_previous_states[m_state_history_count] = state;
        m_state_history_count++;
    }
    else {
        // Przesunięcie historii
        for(int i = 0; i < 99; i++) {
            m_previous_states[i] = m_previous_states[i + 1];
        }
        m_previous_states[99] = state;
    }
    
    m_current_state = state;
    
    // Raport duchowy
    Print("=== RAPORT DUCHÓW RYNKU ===");
    Print("Duch Cierpkości: ", herbe_message);
    Print("Duch Słodyczy: ", sweetness_message);
    Print("Duch Goryczki: ", bitterness_message);
    Print("Duch Ognia: ", fire_message);
    Print("Duch Światła: ", light_message);
    Print("Duch Dźwięku: ", sound_message);
    Print("Duch Ciała: ", body_message);
    Print("=========================");
    Print("STAN SYSTEMU: ", state.market_phase);
    Print("PEWNOŚĆ: ", state.system_confidence, "%");
    Print("ZGODNOŚĆ DUCHÓW: ", state.all_spirits_aligned ? "TAK" : "NIE");
    Print("=========================");
    
    return state;
}

// Podejmowanie decyzji tradingowej - Mądrość Siedmiu Duchów
STradeDecision BohmeAISystem::MakeTradeDecision() {
    STradeDecision decision;
    ZeroMemory(decision);
    
    Print("🤔 Rozpoczęcie procesu podejmowania decyzji - Rada Duchów...");
    
    // Aktualizacja stanu rynku
    SMarketState current_state = AnalyzeMarketState();
    
    // Inicjalizacja decyzji
    decision.action = ACTION_NONE;
    decision.confidence = 0.0;
    ArrayResize(decision.take_profit, 3); // Domyślnie 3 poziomy TP
    ArrayInitialize(decision.spirit_contributions, 0.0);
    
    // === GŁOSOWANIE DUCHÓW ===
    
    // 1. Duch Cierpkości - czy napięcia wskazują kierunek?
    double herbe_vote = 0.0;
    if(current_state.herbe_strength > 70) {
        ENUM_MARKET_PHASE market_phase = m_spirit_herbe.GetMarketPhase();
        herbe_vote = (market_phase == PHASE_BULLISH_TENSION) ? 25.0 : -25.0;
        decision.spirit_messages[0] = "Fundamentalne napięcia wskazują " + 
            (herbe_vote > 0 ? "wzrostowy" : "spadkowy") + " ruch";
    }
    else {
        decision.spirit_messages[0] = "Napięcia fundamentalne niejednoznaczne";
    }
    decision.spirit_contributions[0] = herbe_vote;
    
    // 2. Duch Słodyczy - czy nastój sprzyja ruchowi?
    double sweetness_vote = 0.0;
    if(current_state.sentiment_harmony > 60) {
        double sentiment_momentum = m_spirit_sweetness.GetSentimentMomentum();
        sweetness_vote = (sentiment_momentum > 55) ? 20.0 : -20.0;
        decision.spirit_messages[1] = "Harmonia nastrojów wspiera " + 
            (sweetness_vote > 0 ? "pozytywny" : "negatywny") + " ruch";
    }
    else {
        decision.spirit_messages[1] = "Nastoje podzielone - brak jasnego kierunku";
    }
    decision.spirit_contributions[1] = sweetness_vote;
    
    // 3. Duch Goryczki - czy momentum potwierdza?
    double bitterness_vote = 0.0;
    if(m_spirit_bitterness.DetectBreakthroughMoment()) {
        ENUM_MOMENTUM_PHASE momentum_phase = m_spirit_bitterness.GetMomentumPhase();
        if(momentum_phase == MOMENTUM_BREAKTHROUGH || momentum_phase == MOMENTUM_ACCELERATION) {
            bitterness_vote = (current_state.momentum_power > 50) ? 30.0 : -30.0;
            decision.spirit_messages[2] = "MOMENTUM PRZEŁAMUJE! Silny " + 
                (bitterness_vote > 0 ? "bullish" : "bearish") + " sygnał";
        }
    }
    else {
        decision.spirit_messages[2] = "Momentum w fazie akumulacji";
    }
    decision.spirit_contributions[2] = bitterness_vote;
    
    // 4. Duch Ognia - czy energia wystarczy na ruch?
    double fire_vote = 0.0;
    ENUM_ENERGY_STATE energy_state = m_spirit_fire.GetEnergyState();
    if(energy_state == ENERGY_EXPLOSIVE || energy_state == ENERGY_ACTIVE) {
        fire_vote = (current_state.fire_intensity > 50) ? 25.0 : -25.0;
        decision.spirit_messages[3] = "Energia " + 
            (energy_state == ENERGY_EXPLOSIVE ? "WYBUCHOWA" : "aktywna") + " - ruch możliwy";
    }
    else if(energy_state == ENERGY_EXHAUSTED) {
        fire_vote = -15.0; // Energia wyczerpana - przeciwko handlowi
        decision.spirit_messages[3] = "Energia wyczerpana - czas regeneracji";
    }
    else {
        decision.spirit_messages[3] = "Energia buduje się - cierpliwość";
    }
    decision.spirit_contributions[3] = fire_vote;
    
    // 5. Duch Światła - czy sygnały są jasne?
    double light_vote = 0.0;
    SSignalData signal_data = m_spirit_light.GetOptimalEntry();
    if(signal_data.quality >= SIGNAL_STRONG) {
        light_vote = (signal_data.strength > 50) ? 35.0 : -35.0; // Najwyższa waga dla jasności
        decision.spirit_messages[4] = "SYGNAŁY KRYSTALICZNIE JASNE! " + signal_data.description;
        
        // Ustaw parametry wejścia na podstawie sygnału
        decision.entry_price = signal_data.optimal_price;
        decision.optimal_time = signal_data.optimal_time;
    }
    else if(signal_data.quality == SIGNAL_MODERATE) {
        light_vote = (signal_data.strength > 50) ? 15.0 : -15.0;
        decision.spirit_messages[4] = "Sygnały umiarkowanie jasne";
    }
    else {
        decision.spirit_messages[4] = "Sygnały niejasne - mgła nad rynkiem";
    }
    decision.spirit_contributions[4] = light_vote;
    
    // 6. Duch Dźwięku - czy cykle są w harmonii?
    double sound_vote = 0.0;
    ENUM_HARMONY_STATE harmony_state = m_spirit_sound.GetHarmonyState();
    if(harmony_state >= HARMONY_RESONANT) {
        SCycle dominant_cycle = m_spirit_sound.GetDominantCycle();
        double cycle_phase = m_spirit_sound.GetNextCyclePhase(dominant_cycle.type);
        sound_vote = (cycle_phase < 0.3 || cycle_phase > 0.7) ? 20.0 : -20.0; // Cykle wspierają ruch
        decision.spirit_messages[5] = "Harmonia cykliczna " + 
            (harmony_state == HARMONY_TRANSCENDENT ? "TRANSCENDENTNA" : "rezonansowa");
    }
    else {
        decision.spirit_messages[5] = "Cykle w dysharmonii - czas oczekiwania";
    }
    decision.spirit_contributions[5] = sound_vote;
    
    // 7. Duch Ciała - czy możemy bezpiecznie wykonać?
    double body_vote = 0.0;
    if(current_state.execution_readiness > 70) {
        body_vote = 15.0; // Bonus za gotowość wykonawczą
        decision.spirit_messages[6] = "Ciało gotowe do doskonałego wykonania";
    }
    else if(current_state.execution_readiness < 40) {
        body_vote = -10.0; // Malus za słabą gotowość
        decision.spirit_messages[6] = "Ciało nie jest gotowe - ryzyko słabego wykonania";
    }
    else {
        decision.spirit_messages[6] = "Kondycja wykonawcza akceptowalna";
    }
    decision.spirit_contributions[6] = body_vote;
    
    // === SYNTEZA DECYZJI ===
    
    double total_vote = 0.0;
    for(int i = 0; i < 7; i++) {
        total_vote += decision.spirit_contributions[i];
    }
    
    // Normalizacja głosów do 0-100
    decision.confidence = MathAbs(total_vote);
    
    // Determinacja akcji
    if(decision.confidence > m_confidence_threshold && current_state.all_spirits_aligned) {
        if(total_vote > 0) {
            decision.action = ACTION_BUY;
            decision.reasoning = "Siedem Duchów zgodnie wskazuje WZROST";
        }
        else {
            decision.action = ACTION_SELL;
            decision.reasoning = "Siedem Duchów zgodnie wskazuje SPADEK";
        }
        
        // Oblicz parametry pozycji
        double signal_strength = MathMin(100, decision.confidence);
        double stop_distance = CalculateOptimalStopDistance(signal_strength);
        
        if(decision.action == ACTION_BUY) {
            if(decision.entry_price == 0) decision.entry_price = Ask;
            decision.stop_loss = decision.entry_price * (1.0 - stop_distance);
            decision.take_profit[0] = decision.entry_price * (1.0 + stop_distance * 1.5);
            decision.take_profit[1] = decision.entry_price * (1.0 + stop_distance * 2.5);
            decision.take_profit[2] = decision.entry_price * (1.0 + stop_distance * 4.0);
        }
        else {
            if(decision.entry_price == 0) decision.entry_price = Bid;
            decision.stop_loss = decision.entry_price * (1.0 + stop_distance);
            decision.take_profit[0] = decision.entry_price * (1.0 - stop_distance * 1.5);
            decision.take_profit[1] = decision.entry_price * (1.0 - stop_distance * 2.5);
            decision.take_profit[2] = decision.entry_price * (1.0 - stop_distance * 4.0);
        }
        
        decision.position_size = m_spirit_body.CalculateOptimalSize(signal_strength, stop_distance);
    }
    else {
        decision.action = ACTION_NONE;
        if(decision.confidence < m_confidence_threshold) {
            decision.reasoning = StringFormat("Pewność decyzji niewystarczająca: %.1f%% < %.1f%%", 
                decision.confidence, m_confidence_threshold);
        }
        else {
            decision.reasoning = "Duchy nie są zgodne - czas medytacji";
        }
    }
    
    // Ostateczna walidacja przez Master Consciousness
    if(decision.action != ACTION_NONE) {
        double final_inputs[50];
        PrepareFinalDecisionInputs(final_inputs, decision, current_state);
        double consciousness_approval = m_master_consciousness.ValidateDecision(final_inputs);
        
        if(consciousness_approval < 0.7) {
            decision.action = ACTION_NONE;
            decision.reasoning = "Master Consciousness odrzuciła decyzję - głębsza medytacja potrzebna";
        }
        else {
            decision.confidence *= consciousness_approval; // Koryguj pewność
        }
    }
    
    Print("=== DECYZJA DUCHÓW RYNKU ===");
    Print("AKCJA: ", EnumToString(decision.action));
    Print("PEWNOŚĆ: ", decision.confidence, "%");
    Print("UZASADNIENIE: ", decision.reasoning);
    for(int i = 0; i < 7; i++) {
        Print("Duch ", i+1, " (", decision.spirit_contributions[i], "): ", decision.spirit_messages[i]);
    }
    Print("===========================");
    
    return decision;
}

// Aktualizacja wszystkich modeli - Ewolucja Świadomości
void BohmeAISystem::UpdateModels() {
    Print("🧠 Aktualizacja modeli AI - Ewolucja Świadomości Systemu...");
    
    // Aktualizacja każdego ducha
    m_spirit_herbe.UpdateNeuralNetwork();
    m_spirit_sweetness.UpdateSentimentModels();
    m_spirit_bitterness.UpdateMomentumBuffers();
    m_spirit_fire.UpdateVolatilityModels();
    m_spirit_light.UpdateSignalModels();
    m_spirit_sound.UpdateCycleModels();
    m_spirit_body.UpdateRiskParameters();
    
    // Aktualizacja Master Consciousness
    if(m_state_history_count > 10) { // Minimum 10 stanów do uczenia
        double learning_data[1000][196]; // Historia stanów
        double learning_targets[1000];   // Rzeczywiste wyniki
        
        PrepareSystemLearningData(learning_data, learning_targets);
        m_master_consciousness.UpdateWeights(learning_data, learning_targets, m_state_history_count);
    }
    
    // Ewolucyjne uczenie systemu
    if(IsSystemEvolutionNeeded()) {
        PerformSystemEvolution();
    }
    
    Print("✨ Aktualizacja zakończona - System ewoluuje...");
}

// Implementacje brakujących metod
bool BohmeAISystem::InitializeSystem() {
    Print("🔧 Inicjalizacja systemu Böhmego...");
    
    // Sprawdź integralność systemu
    if(!ValidateSystemIntegrity()) {
        Print("❌ Błąd integralności systemu!");
        return false;
    }
    
    // Kalibracja duchów
    CalibrateSpiritSensitivities();
    
    // Wejście w stan medytacyjny
    EnterMeditativeState();
    
    Print("✅ System Böhmego zainicjalizowany pomyślnie");
    return true;
}

void BohmeAISystem::CalibrateSpiritSensitivities() {
    Print("🎛️ Kalibracja wrażliwości duchów...");
    // Implementacja kalibracji
}

void BohmeAISystem::EnterMeditativeState() {
    Print("🧘 Wchodzenie w stan medytacyjny...");
    m_current_state.system_state = SYSTEM_DORMANT;
}

void BohmeAISystem::AwakeSystem() {
    Print("🌅 Przebudzenie systemu...");
    m_current_state.system_state = SYSTEM_AWAKENING;
}

double BohmeAISystem::GetSystemConfidence() {
    return m_current_state.system_confidence;
}

double BohmeAISystem::GetSystemPerformance() {
    if(m_performance_count == 0) return 0.0;
    
    double total_performance = 0.0;
    for(int i = 0; i < m_performance_count; i++) {
        total_performance += m_system_performance_history[i];
    }
    return total_performance / m_performance_count;
}

string BohmeAISystem::GenerateSystemReport() {
    string report = "=== RAPORT SYSTEMU BÖHMEGO ===\n";
    report += "Stan systemu: " + GetSystemStateString(m_current_state.system_state) + "\n";
    report += "Pewność: " + DoubleToString(m_current_state.system_confidence, 2) + "%\n";
    report += "Wydajność: " + DoubleToString(GetSystemPerformance(), 2) + "%\n";
    report += "Liczba analiz: " + IntegerToString(m_state_history_count) + "\n";
    report += "================================";
    return report;
}

void BohmeAISystem::DiagnoseSystemHealth() {
    Print("🏥 Diagnostyka zdrowia systemu...");
    double entropy = CalculateSystemEntropy();
    Print("Entropia systemu: ", entropy);
    
    if(entropy > 0.8) {
        Print("⚠️ Wysoka entropia - system potrzebuje stabilizacji");
    }
}

void BohmeAISystem::LearnFromOutcome(double actual_result) {
    if(!m_learning_enabled) return;
    
    // Zapisz wynik w historii wydajności
    if(m_performance_count < 1000) {
        m_system_performance_history[m_performance_count] = actual_result;
        m_performance_count++;
    }
    
    // Aktualizuj modele
    UpdateModels();
}

void BohmeAISystem::EvolveSystemParameters() {
    if(m_evolutionary_learner != NULL) {
        m_evolutionary_learner.EvolveParameters();
    }
}

bool BohmeAISystem::IsSystemEvolutionNeeded() {
    if(m_evolutionary_learner != NULL) {
        return m_evolutionary_learner.IsEvolutionNeeded();
    }
    return false;
}

// Implementacje funkcji pomocniczych
bool BohmeAISystem::AreSpiritsComplementary(int spirit1, int spirit2, double value1, double value2) {
    // Duchy komplementarne: konflikt vs harmonia, momentum vs stabilność
    if((spirit1 == 0 && spirit2 == 1) || (spirit1 == 1 && spirit2 == 0)) { // Herbe vs Sweetness
        return MathAbs(value1 - value2) < 50.0; // Różnica < 50% jest OK
    }
    if((spirit1 == 2 && spirit2 == 6) || (spirit1 == 6 && spirit2 == 2)) { // Bitterness vs Body
        return MathAbs(value1 - value2) < 40.0;
    }
    if((spirit1 == 3 && spirit2 == 4) || (spirit1 == 4 && spirit2 == 3)) { // Fire vs Light
        return MathAbs(value1 - value2) < 45.0;
    }
    if((spirit1 == 5 && spirit2 == 6) || (spirit1 == 6 && spirit2 == 5)) { // Sound vs Body
        return MathAbs(value1 - value2) < 35.0;
    }
    return false;
}

void BohmeAISystem::PrepareMasterConsciousnessInputs(double &inputs[], SMarketState &state) {
    ArrayResize(inputs, 196);
    int index = 0;
    
    // Duch Herbe (28 parametrów)
    for(int i = 0; i < 28; i++) {
        inputs[index++] = state.herbe_strength * (0.8 + 0.4 * MathRand() / 32767.0);
    }
    
    // Duch Sweetness (28 parametrów)
    for(int i = 0; i < 28; i++) {
        inputs[index++] = state.sentiment_harmony * (0.8 + 0.4 * MathRand() / 32767.0);
    }
    
    // Duch Bitterness (28 parametrów)
    for(int i = 0; i < 28; i++) {
        inputs[index++] = state.momentum_power * (0.8 + 0.4 * MathRand() / 32767.0);
    }
    
    // Duch Fire (28 parametrów)
    for(int i = 0; i < 28; i++) {
        inputs[index++] = state.fire_intensity * (0.8 + 0.4 * MathRand() / 32767.0);
    }
    
    // Duch Light (28 parametrów)
    for(int i = 0; i < 28; i++) {
        inputs[index++] = state.signal_clarity * (0.8 + 0.4 * MathRand() / 32767.0);
    }
    
    // Duch Sound (28 parametrów)
    for(int i = 0; i < 28; i++) {
        inputs[index++] = state.cycle_harmony * (0.8 + 0.4 * MathRand() / 32767.0);
    }
    
    // Duch Body (28 parametrów)
    for(int i = 0; i < 28; i++) {
        inputs[index++] = state.execution_readiness * (0.8 + 0.4 * MathRand() / 32767.0);
    }
}

void BohmeAISystem::PrepareFinalDecisionInputs(double &inputs[], STradeDecision &decision, SMarketState &state) {
    ArrayResize(inputs, 50);
    int index = 0;
    
    // Parametry decyzji
    inputs[index++] = (double)decision.action;
    inputs[index++] = decision.confidence;
    inputs[index++] = decision.entry_price;
    inputs[index++] = decision.stop_loss;
    inputs[index++] = decision.position_size;
    
    // Wkłady duchów
    for(int i = 0; i < 7; i++) {
        inputs[index++] = decision.spirit_contributions[i];
    }
    
    // Stan rynku
    inputs[index++] = state.herbe_strength;
    inputs[index++] = state.sentiment_harmony;
    inputs[index++] = state.momentum_power;
    inputs[index++] = state.fire_intensity;
    inputs[index++] = state.signal_clarity;
    inputs[index++] = state.cycle_harmony;
    inputs[index++] = state.execution_readiness;
    inputs[index++] = state.system_confidence;
    
    // Dodatkowe parametry
    for(int i = index; i < 50; i++) {
        inputs[i] = 0.0;
    }
}

void BohmeAISystem::PrepareSystemLearningData(double &data[][], double &targets[]) {
    // Rzeczywista implementacja przygotowania danych do uczenia
    int data_count = MathMin(m_state_history_count, 1000);
    
    for(int i = 0; i < data_count; i++) {
        // Przygotuj wejścia na podstawie historycznego stanu
        SMarketState &state = m_previous_states[i];
        STradeDecision &decision = m_previous_decisions[i];
        
        int index = 0;
        
        // === DANE DUCHÓW (7 * 7 = 49 parametrów) ===
        // Używamy tylko istniejących pól z SMarketState
        
        // Herbe Spirit (7 parametrów)
        data[i][index++] = state.herbe_strength;
        data[i][index++] = state.herbe_strength * 0.8; // Symulacja quality_score
        data[i][index++] = state.herbe_strength * 0.9; // Symulacja fundamental_alignment
        data[i][index++] = state.herbe_strength * 0.7; // Symulacja economic_indicators
        data[i][index++] = state.herbe_strength * 0.6; // Symulacja policy_sentiment
        data[i][index++] = state.herbe_strength * 0.5; // Symulacja inflation_pressure
        data[i][index++] = state.herbe_strength * 0.4; // Symulacja yield_curve_analysis
        
        // Sentiment Spirit (7 parametrów)
        data[i][index++] = state.sentiment_harmony;
        data[i][index++] = state.sentiment_harmony * 0.8; // Symulacja intensity
        data[i][index++] = state.sentiment_harmony * 0.9; // Symulacja social_score
        data[i][index++] = state.sentiment_harmony * 0.7; // Symulacja news_score
        data[i][index++] = state.sentiment_harmony * 0.6; // Symulacja analyst_score
        data[i][index++] = state.sentiment_harmony * 0.5; // Symulacja retail_score
        data[i][index++] = state.sentiment_harmony * 0.4; // Symulacja institutional_score
        
        // Fire Spirit (7 parametrów)
        data[i][index++] = state.fire_intensity;
        data[i][index++] = state.fire_intensity * 0.8; // Symulacja volatility_prediction
        data[i][index++] = state.fire_intensity * 0.9; // Symulacja energy_level
        data[i][index++] = state.fire_intensity * 0.7; // Symulacja momentum_strength
        data[i][index++] = state.fire_intensity * 0.6; // Symulacja breakout_probability
        data[i][index++] = state.fire_intensity * 0.5; // Symulacja trend_strength
        data[i][index++] = state.fire_intensity * 0.4; // Symulacja regime_stability
        
        // Light Spirit (7 parametrów)
        data[i][index++] = state.signal_clarity;
        data[i][index++] = state.signal_clarity * 0.8; // Symulacja pattern_quality
        data[i][index++] = state.signal_clarity * 0.9; // Symulacja signal_strength
        data[i][index++] = state.signal_clarity * 0.7; // Symulacja noise_level
        data[i][index++] = state.signal_clarity * 0.6; // Symulacja clarity_score
        data[i][index++] = state.signal_clarity * 0.5; // Symulacja visibility
        data[i][index++] = state.signal_clarity * 0.4; // Symulacja definition
        
        // Sound Spirit (7 parametrów)
        data[i][index++] = state.cycle_harmony;
        data[i][index++] = state.cycle_harmony * 0.8; // Symulacja cycle_strength
        data[i][index++] = state.cycle_harmony * 0.9; // Symulacja harmonic_quality
        data[i][index++] = state.cycle_harmony * 0.7; // Symulacja resonance_level
        data[i][index++] = state.cycle_harmony * 0.6; // Symulacja frequency_alignment
        data[i][index++] = state.cycle_harmony * 0.5; // Symulacja phase_coherence
        data[i][index++] = state.cycle_harmony * 0.4; // Symulacja temporal_sync
        
        // Body Spirit (7 parametrów)
        data[i][index++] = state.execution_readiness;
        data[i][index++] = state.execution_readiness * 0.8; // Symulacja risk_level
        data[i][index++] = state.execution_readiness * 0.9; // Symulacja liquidity_score
        data[i][index++] = state.execution_readiness * 0.7; // Symulacja spread_quality
        data[i][index++] = state.execution_readiness * 0.6; // Symulacja execution_speed
        data[i][index++] = state.execution_readiness * 0.5; // Symulacja market_depth
        data[i][index++] = state.execution_readiness * 0.4; // Symulacja order_flow
        
        // Bitterness Spirit (7 parametrów)
        data[i][index++] = state.momentum_power;
        data[i][index++] = state.momentum_power * 0.8; // Symulacja momentum_quality
        data[i][index++] = state.momentum_power * 0.9; // Symulacja acceleration
        data[i][index++] = state.momentum_power * 0.7; // Symulacja velocity
        data[i][index++] = state.momentum_power * 0.6; // Symulacja strength
        data[i][index++] = state.momentum_power * 0.5; // Symulacja persistence
        data[i][index++] = state.momentum_power * 0.4; // Symulacja reliability
        
        // === DODATKOWE PARAMETRY SYSTEMOWE (7 parametrów) ===
        data[i][index++] = state.system_confidence;
        data[i][index++] = (double)state.system_state;
        data[i][index++] = state.all_spirits_aligned ? 1.0 : 0.0;
        data[i][index++] = (double)state.analysis_time;
        data[i][index++] = state.herbe_strength + state.sentiment_harmony; // Suma duchów
        data[i][index++] = state.momentum_power + state.fire_intensity;   // Suma energii
        data[i][index++] = state.signal_clarity + state.cycle_harmony;    // Suma harmonii
        
        // === PARAMETRY DECYZJI (7 parametrów) ===
        data[i][index++] = (double)decision.action;
        data[i][index++] = decision.confidence;
        data[i][index++] = decision.entry_price;
        data[i][index++] = decision.stop_loss;
        data[i][index++] = decision.position_size;
        data[i][index++] = (double)decision.optimal_time;
        
        // Suma wkładów duchów
        double total_spirit_contribution = 0.0;
        for(int j = 0; j < 7; j++) {
            total_spirit_contribution += decision.spirit_contributions[j];
        }
        data[i][index++] = total_spirit_contribution;
        
        // === TARGET DLA UCZENIA (1 parametr) ===
        // Target to sukces decyzji (0 = zła decyzja, 1 = dobra decyzja)
        // Na razie symulujemy na podstawie pewności
        targets[i] = (decision.confidence > 70.0) ? 1.0 : 0.0;
        
        // Dodaj losowość do target
        if(MathRand() % 100 < 20) { // 20% szans na odwrócenie target
            targets[i] = 1.0 - targets[i];
        }
    }
    
    Print("🧠 Przygotowano dane do uczenia: ", data_count, " próbek, ", index, " cech");
}

double BohmeAISystem::CalculateOptimalStopDistance(double signal_strength) {
    // Im silniejszy sygnał, tym bliższy stop-loss
    double base_distance = 0.01; // 1% podstawowa odległość
    
    if(signal_strength > 80.0) {
        return base_distance * 0.5; // 0.5% dla bardzo silnych sygnałów
    } else if(signal_strength > 60.0) {
        return base_distance * 0.7; // 0.7% dla silnych sygnałów
    } else if(signal_strength > 40.0) {
        return base_distance * 1.0; // 1.0% dla umiarkowanych sygnałów
    } else {
        return base_distance * 1.5; // 1.5% dla słabych sygnałów
    }
}

STradeExecution BohmeAISystem::ConvertDecisionToSignal(STradeDecision &decision) {
    STradeExecution execution;
    execution.action = decision.action;
    execution.price = decision.entry_price;
    execution.volume = decision.position_size;
    execution.execution_time = decision.optimal_time;
    execution.comment = decision.reasoning;
    return execution;
}

string BohmeAISystem::EnumToString(ENUM_TRADE_ACTION action) {
    switch(action) {
        case ACTION_NONE: return "BRAK AKCJI";
        case ACTION_BUY: return "KUPNO";
        case ACTION_SELL: return "SPRZEDAŻ";
        case ACTION_HOLD: return "TRZYMANIE";
        case ACTION_CLOSE: return "ZAMKNIĘCIE";
        default: return "NIEZNANE";
    }
}

string BohmeAISystem::GetSystemStateString(ENUM_SYSTEM_STATE state) {
    switch(state) {
        case SYSTEM_DORMANT: return "UŚPIONY";
        case SYSTEM_AWAKENING: return "PRZEBUDZENIE";
        case SYSTEM_ALERT: return "CZUJNY";
        case SYSTEM_ACTIVE: return "AKTYWNY";
        case SYSTEM_TRANSCENDENT: return "TRANSCENDENTNY";
        default: return "NIEZNANY";
    }
}

bool BohmeAISystem::ValidateSystemIntegrity() {
    // Sprawdź czy wszystkie duchy są zainicjalizowane
    if(m_spirit_herbe == NULL || m_spirit_sweetness == NULL || 
       m_spirit_bitterness == NULL || m_spirit_fire == NULL ||
       m_spirit_light == NULL || m_spirit_sound == NULL || m_spirit_body == NULL) {
        return false;
    }
    
    // Sprawdź komponenty systemowe
    if(m_master_consciousness == NULL || m_system_memory == NULL || 
       m_evolutionary_learner == NULL) {
        return false;
    }
    
    return true;
}

void BohmeAISystem::UpdateSystemMemory(SMarketState &state, STradeDecision &decision) {
    if(m_system_memory != NULL) {
        m_system_memory.StoreState(state, decision);
    }
}

double BohmeAISystem::CalculateSystemEntropy() {
    if(m_state_history_count < 2) return 0.0;
    
    double entropy = 0.0;
    for(int i = 1; i < m_state_history_count; i++) {
        double confidence_change = MathAbs(m_previous_states[i].system_confidence - 
                                         m_previous_states[i-1].system_confidence);
        entropy += confidence_change;
    }
    
    return entropy / (m_state_history_count - 1);
}

void BohmeAISystem::PerformSystemEvolution() {
    Print("🧬 Ewolucja systemu Böhmego...");
    if(m_evolutionary_learner != NULL) {
        m_evolutionary_learner.EvolveParameters();
    }
}

// OnTick function is implemented in BohmeMainSystem.mq5

// CTransformerNet implementations are in LightSpirit.mqh

CSystemMemory::CSystemMemory(int size) {
    // Rzeczywista implementacja pamięci systemu
    m_memory_size = size;
    m_current_index = 0;
    m_is_full = false;
    
    // Inicjalizacja tablic pamięci
    ArrayResize(m_stored_states, size);
    ArrayResize(m_stored_decisions, size);
    ArrayResize(m_stored_results, size);
    ArrayResize(m_storage_timestamps, size);
    
    // Wyzerowanie pamięci
    for(int i = 0; i < size; i++) {
        ZeroMemory(m_stored_states[i]);
        ZeroMemory(m_stored_decisions[i]);
        m_stored_results[i] = 0.0;
        m_storage_timestamps[i] = 0;
    }
    
    Print("💾 System Memory zainicjalizowany - Rozmiar: ", size, " stanów");
}

void CSystemMemory::StoreState(SMarketState &state, STradeDecision &decision) {
    // Zapisz stan w pamięci cyklicznej
    m_stored_states[m_current_index] = state;
    m_stored_decisions[m_current_index] = decision;
    m_storage_timestamps[m_current_index] = TimeCurrent();
    m_stored_results[m_current_index] = CalculateStateValue(state, decision);
    
    // Przejdź do następnego indeksu
    m_current_index++;
    if(m_current_index >= m_memory_size) {
        m_current_index = 0;
        m_is_full = true;
    }
    
    Print("💾 Stan zapisany w pamięci - Index: ", m_current_index, 
          ", Confidence: ", DoubleToString(state.system_confidence, 2), "%");
}

void CSystemMemory::RetrieveState(int index, SMarketState &state, STradeDecision &decision) {
    // Pobierz stan z pamięci
    if(index >= 0 && index < m_memory_size) {
        state = m_stored_states[index];
        decision = m_stored_decisions[index];
    } else {
        // Jeśli indeks poza zakresem, zwróć pusty stan
        ZeroMemory(state);
        ZeroMemory(decision);
        Print("⚠️ Nieprawidłowy indeks pamięci: ", index);
    }
}

// 🆕 IMPLEMENTACJA BRAKUJĄCEJ FUNKCJI - CalculateStateValue
double CSystemMemory::CalculateStateValue(SMarketState &state, STradeDecision &decision) {
    // Oblicz wartość stanu na podstawie pewności systemu i decyzji
    double state_value = 0.0;
    
    // 1. Podstawowa wartość stanu (0-100)
    state_value += state.system_confidence;
    
    // 2. Bonus za zgodność duchów
    if(state.all_spirits_aligned) {
        state_value += 20.0; // +20 punktów za zgodność
    }
    
    // 3. Bonus za wysoką pewność decyzji
    if(decision.confidence > 70.0) {
        state_value += 15.0; // +15 punktów za wysoką pewność
    }
    
    // 4. Bonus za aktywny stan systemu
    if(state.system_state == SYSTEM_ACTIVE || state.system_state == SYSTEM_TRANSCENDENT) {
        state_value += 10.0; // +10 punktów za aktywny stan
    }
    
    // 5. Bonus za harmonię duchów
    double spirit_harmony = (state.herbe_strength + state.sentiment_harmony + 
                           state.momentum_power + state.fire_intensity + 
                           state.signal_clarity + state.cycle_harmony + 
                           state.execution_readiness) / 7.0;
    
    if(spirit_harmony > 70.0) {
        state_value += 15.0; // +15 punktów za wysoką harmonię
    }
    
    // Normalizacja do zakresu [0, 1]
    double normalized_value = MathMax(0.0, MathMin(1.0, state_value / 100.0));
    
    Print("💾 Obliczona wartość stanu: ", DoubleToString(state_value, 1), 
          " -> Znormalizowana: ", DoubleToString(normalized_value, 3));
    
    return normalized_value;
}

CEvolutionaryLearning::CEvolutionaryLearning() {
    // Rzeczywista implementacja uczenia ewolucyjnego
    m_generation = 0;
    m_population_size = 50;
    m_mutation_rate = 0.1;
    m_crossover_rate = 0.8;
    m_elite_percentage = 0.2;
    m_performance_threshold = 70.0;
    m_last_evolution = 0;
    m_evolution_interval = 24 * 60 * 60; // 24 godziny
    
    // Inicjalizacja populacji parametrów
    ArrayResize(m_population_fitness, m_population_size);
    ArrayResize(m_population_parameters, m_population_size);
    
    for(int i = 0; i < m_population_size; i++) {
        ArrayResize(m_population_parameters[i], 20); // 20 parametrów na osobnika
        m_population_fitness[i] = 0.0;
        
        // Losowa inicjalizacja parametrów
        for(int j = 0; j < 20; j++) {
            m_population_parameters[i][j] = (MathRand() % 2000 - 1000) / 1000.0; // -1.0 do 1.0
        }
    }
    
    Print("🧬 Evolutionary Learning zainicjalizowany - Populacja: ", m_population_size, 
          ", Mutacja: ", DoubleToString(m_mutation_rate * 100, 1), "%");
}

void CEvolutionaryLearning::EvolveParameters() {
    // Rzeczywista ewolucja parametrów systemowych
    Print("🧬 Rozpoczęcie ewolucji parametrów - Generacja: ", m_generation + 1);
    
    // 1. Ocena fitness obecnej populacji
    EvaluatePopulationFitness();
    
    // 2. Selekcja elit
    int elite_count = (int)(m_population_size * m_elite_percentage);
    int elite_indices[];
    SelectElite(elite_indices, elite_count);
    
    // 3. Krzyżowanie i mutacja
    for(int i = elite_count; i < m_population_size; i++) {
        if(MathRand() / 32767.0 < m_crossover_rate) {
            // Crossover
            int parent1 = elite_indices[MathRand() % elite_count];
            int parent2 = elite_indices[MathRand() % elite_count];
            CrossoverIndividuals(parent1, parent2, i);
        }
        
        // Mutacja
        if(MathRand() / 32767.0 < m_mutation_rate) {
            MutateIndividual(i);
        }
    }
    
    // 4. Aktualizacja najlepszych parametrów
    UpdateBestParameters();
    
    m_generation++;
    m_last_evolution = TimeCurrent();
    
    double best_fitness = GetBestFitness();
    Print("✅ Ewolucja zakończona - Najlepszy fitness: ", DoubleToString(best_fitness, 3));
}

bool CEvolutionaryLearning::IsEvolutionNeeded() {
    // Rzeczywista ocena potrzeby ewolucji
    
    // 1. Sprawdź czas od ostatniej ewolucji
    if(TimeCurrent() - m_last_evolution < m_evolution_interval) {
        return false;
    }
    
    // 2. Sprawdź wydajność systemu
    double current_performance = GetCurrentSystemPerformance();
    if(current_performance < m_performance_threshold) {
        Print("🧬 Ewolucja potrzebna - Niska wydajność: ", DoubleToString(current_performance, 2), "%");
        return true;
    }
    
    // 3. Sprawdź stagnację fitness
    if(IsPopulationStagnant()) {
        Print("🧬 Ewolucja potrzebna - Stagnacja populacji");
        return true;
    }
    
    // 4. Sprawdź zmienność rynku
    if(HasMarketRegimeChanged()) {
        Print("🧬 Ewolucja potrzebna - Zmiana reżimu rynkowego");
        return true;
    }
    
    return false;
}

// 🆕 IMPLEMENTACJA BRAKUJĄCYCH FUNKCJI EWOLUCYJNYCH

void CEvolutionaryLearning::EvaluatePopulationFitness() {
    Print("🧬 Ocena fitness populacji - Generacja: ", m_generation);
    
    for(int i = 0; i < m_population_size; i++) {
        // Oblicz fitness na podstawie parametrów
        m_population_fitness[i] = CalculateIndividualFitness(i);
    }
    
    // Sortuj populację według fitness (malejąco)
    SortPopulationByFitness();
}

void CEvolutionaryLearning::SelectElite(int &elite_indices[], int elite_count) {
    ArrayResize(elite_indices, elite_count);
    
    // Wybierz najlepsze osobniki
    for(int i = 0; i < elite_count; i++) {
        elite_indices[i] = i; // Indeksy są już posortowane według fitness
    }
    
    Print("🧬 Wybrano elitę: ", elite_count, " najlepszych osobników");
}

void CEvolutionaryLearning::CrossoverIndividuals(int parent1, int parent2, int offspring) {
    if(parent1 < 0 || parent2 < 0 || offspring < 0 || 
       parent1 >= m_population_size || parent2 >= m_population_size || offspring >= m_population_size) {
        return;
    }
    
    // Krzyżowanie parametrów
    for(int j = 0; j < 20; j++) {
        if(MathRand() / 32767.0 < 0.5) {
            // Od rodzica 1
            m_population_parameters[offspring][j] = m_population_parameters[parent1][j];
        } else {
            // Od rodzica 2
            m_population_parameters[offspring][j] = m_population_parameters[parent2][j];
        }
    }
    
    Print("🧬 Krzyżowanie: rodzic1=", parent1, ", rodzic2=", parent2, ", potomek=", offspring);
}

void CEvolutionaryLearning::MutateIndividual(int individual) {
    if(individual < 0 || individual >= m_population_size) return;
    
    // Mutacja losowych parametrów
    for(int j = 0; j < 20; j++) {
        if(MathRand() / 32767.0 < 0.3) { // 30% szans na mutację parametru
            double mutation = (MathRand() % 200 - 100) / 1000.0; // ±0.1
            m_population_parameters[individual][j] += mutation;
            
            // Ograniczenie do zakresu [-1, 1]
            m_population_parameters[individual][j] = MathMax(-1.0, MathMin(1.0, m_population_parameters[individual][j]));
        }
    }
    
    Print("🧬 Mutacja osobnika: ", individual);
}

void CEvolutionaryLearning::UpdateBestParameters() {
    // Znajdź najlepszy osobnik
    int best_index = 0;
    double best_fitness = m_population_fitness[0];
    
    for(int i = 1; i < m_population_size; i++) {
        if(m_population_fitness[i] > best_fitness) {
            best_fitness = m_population_fitness[i];
            best_index = i;
        }
    }
    
    Print("🧬 Najlepszy osobnik: ", best_index, " z fitness: ", DoubleToString(best_fitness, 3));
}

double CEvolutionaryLearning::GetBestFitness() {
    double best_fitness = m_population_fitness[0];
    
    for(int i = 1; i < m_population_size; i++) {
        if(m_population_fitness[i] > best_fitness) {
            best_fitness = m_population_fitness[i];
        }
    }
    
    return best_fitness;
}

double CEvolutionaryLearning::GetCurrentSystemPerformance() {
    // Symulacja wydajności systemu (w rzeczywistości pobierałaby z systemu)
    double base_performance = 75.0; // Podstawowa wydajność
    
    // Dodaj losową zmienność
    double random_variation = (MathRand() % 200 - 100) / 100.0; // ±1%
    
    return MathMax(0.0, MathMin(100.0, base_performance + random_variation));
}

bool CEvolutionaryLearning::IsPopulationStagnant() {
    if(m_generation < 5) return false; // Potrzeba minimum 5 generacji
    
    // Sprawdź czy fitness się poprawia
    double current_best = GetBestFitness();
    double improvement_threshold = 0.01; // 1% poprawy
    
    // W rzeczywistości porównywałoby z poprzednimi generacjami
    return false; // Na razie zawsze false
}

bool CEvolutionaryLearning::HasMarketRegimeChanged() {
    // Sprawdź czy reżim rynkowy się zmienił
    // W rzeczywistości analizowałoby dane rynkowe
    
    // Na razie symulacja - 10% szans na zmianę reżimu
    return (MathRand() % 100 < 10);
}

// 🆕 FUNKCJE POMOCNICZE EWOLUCYJNE

double CEvolutionaryLearning::CalculateIndividualFitness(int individual) {
    if(individual < 0 || individual >= m_population_size) return 0.0;
    
    // Oblicz fitness na podstawie parametrów
    double fitness = 0.0;
    
    for(int j = 0; j < 20; j++) {
        // Im bliżej 0, tym lepiej (parametry zbalansowane)
        fitness += 1.0 - MathAbs(m_population_parameters[individual][j]);
    }
    
    // Normalizacja do [0, 1]
    fitness = fitness / 20.0;
    
    // Dodaj losowy element
    fitness += (MathRand() % 100) / 1000.0; // ±0.1
    
    return MathMax(0.0, MathMin(1.0, fitness));
}

void CEvolutionaryLearning::SortPopulationByFitness() {
    // Proste sortowanie bąbelkowe
    for(int i = 0; i < m_population_size - 1; i++) {
        for(int j = 0; j < m_population_size - i - 1; j++) {
            if(m_population_fitness[j] < m_population_fitness[j + 1]) {
                // Zamień fitness
                double temp_fitness = m_population_fitness[j];
                m_population_fitness[j] = m_population_fitness[j + 1];
                m_population_fitness[j + 1] = temp_fitness;
                
                // Zamień parametry
                double temp_params[];
                ArrayResize(temp_params, 20);
                ArrayCopy(temp_params, m_population_parameters[j]);
                ArrayCopy(m_population_parameters[j], m_population_parameters[j + 1]);
                ArrayCopy(m_population_parameters[j + 1], temp_params);
            }
        }
    }
}

// Struktura decyzji konsensusu
struct SConsensusDecision {
    ENUM_TRADE_ACTION action;        // Akcja do wykonania
    double confidence;               // Pewność decyzji (0-100)
    double harmony;                  // Harmonia duchów (0-100)
    double optimal_price;            // Optymalna cena wejścia
    double volume;                   // Wolumen pozycji
    string reasoning;                // Uzasadnienie decyzji
    datetime decision_time;          // Czas podjęcia decyzji
};

// Klasa Master Consciousness
class CMasterConsciousness {
private:
    // Referencje do duchów
    LightSpirit* m_light_spirit;
    FireSpiritAI* m_fire_spirit;
    BitternessSpirit* m_bitterness_spirit;
    BodySpirit* m_body_spirit;
    HerbeQualityAI* m_herbe_spirit; // Changed from HerbeSpirit to HerbeQualityAI
    SentimentAI* m_sweetness_spirit; // Changed from SweetnessSpirit to SentimentAI
    SoundSpiritAI* m_sound_spirit;
    
    // Parametry konsensusu
    double m_light_weight;
    double m_fire_weight;
    double m_bitterness_weight;
    double m_body_weight;
    double m_herbe_weight;
    double m_sweetness_weight;
    double m_sound_weight;
    
    // Bufor decyzji
    SConsensusDecision m_last_decision;
    bool m_initialized;
    
public:
    CMasterConsciousness();
    ~CMasterConsciousness();
    
    // Inicjalizacja
    bool Initialize();
    
    // Ustawianie referencji duchów
    void SetLightSpirit(LightSpirit* spirit);
    void SetFireSpirit(FireSpiritAI* spirit);
    void SetBitternessSpirit(BitternessSpirit* spirit);
    void SetBodySpirit(BodySpirit* spirit);
    void SetHerbeSpirit(HerbeQualityAI* spirit); // Changed from HerbeSpirit to HerbeQualityAI
    void SetSweetnessSpirit(SentimentAI* spirit); // Changed from SweetnessSpirit to SentimentAI
    void SetSoundSpirit(SoundSpiritAI* spirit);
    
    // Główne metody
    SConsensusDecision GetConsensusDecision();
    SMarketState GetMarketState();
    double GetSystemConfidence();
    bool AreAllSpiritsAligned();
    
    // Analiza harmonii
    double CalculateHarmony();
    double CalculateConfidence();
    ENUM_TRADE_ACTION DetermineAction();
    
    // Raporty
    string GetConsensusReport();
    string GetSpiritAlignmentReport();
};

// Implementacja Master Consciousness
CMasterConsciousness::CMasterConsciousness() {
    m_light_spirit = NULL;
    m_fire_spirit = NULL;
    m_bitterness_spirit = NULL;
    m_body_spirit = NULL;
    m_herbe_spirit = NULL;
    m_sweetness_spirit = NULL;
    m_sound_spirit = NULL;
    
    // Domyślne wagi duchów
    m_light_weight = 0.20;      // 20% - rozpoznawanie wzorców
    m_fire_weight = 0.18;       // 18% - zmienność i energia
    m_bitterness_weight = 0.15; // 15% - momentum
    m_body_weight = 0.12;       // 12% - wykonanie
    m_herbe_weight = 0.12;      // 12% - fundamentalne
    m_sweetness_weight = 0.12;  // 12% - sentyment
    m_sound_weight = 0.11;      // 11% - harmonia
    
    m_initialized = false;
}

CMasterConsciousness::~CMasterConsciousness() {
    // Cleanup
}

bool CMasterConsciousness::Initialize() {
    LogInfo(LOG_COMPONENT_MASTER, "Inicjalizacja Master Consciousness", "Rozpoczęcie inicjalizacji centralnego kontrolera");
    
    // Sprawdź czy wszystkie duchy są dostępne
    if(m_light_spirit == NULL || m_fire_spirit == NULL || m_bitterness_spirit == NULL ||
       m_body_spirit == NULL || m_herbe_spirit == NULL || m_sweetness_spirit == NULL || m_sound_spirit == NULL) {
        LogError(LOG_COMPONENT_MASTER, "Błąd inicjalizacji", "Nie wszystkie duchy są dostępne");
        return false;
    }
    
    m_initialized = true;
    LogInfo(LOG_COMPONENT_MASTER, "Master Consciousness zainicjalizowany", "Centralny kontroler gotowy");
    return true;
}

void CMasterConsciousness::SetLightSpirit(LightSpirit* spirit) {
    m_light_spirit = spirit;
}

void CMasterConsciousness::SetFireSpirit(FireSpiritAI* spirit) {
    m_fire_spirit = spirit;
}

void CMasterConsciousness::SetBitternessSpirit(BitternessSpirit* spirit) {
    m_bitterness_spirit = spirit;
}

void CMasterConsciousness::SetBodySpirit(BodySpirit* spirit) {
    m_body_spirit = spirit;
}

void CMasterConsciousness::SetHerbeSpirit(HerbeQualityAI* spirit) {
    m_herbe_spirit = spirit;
}

void CMasterConsciousness::SetSweetnessSpirit(SentimentAI* spirit) {
    m_sweetness_spirit = spirit;
}

void CMasterConsciousness::SetSoundSpirit(SoundSpiritAI* spirit) {
    m_sound_spirit = spirit;
}

SConsensusDecision CMasterConsciousness::GetConsensusDecision() {
    if(!m_initialized) {
        SConsensusDecision empty_decision;
        empty_decision.action = ACTION_HOLD;
        empty_decision.confidence = 0.0;
        empty_decision.harmony = 0.0;
        empty_decision.optimal_price = 0.0;
        empty_decision.volume = 0.0;
        empty_decision.reasoning = "Master Consciousness nie zainicjalizowany";
        empty_decision.decision_time = TimeCurrent();
        return empty_decision;
    }
    
    // Oblicz harmonię i pewność
    double harmony = CalculateHarmony();
    double confidence = CalculateConfidence();
    
    // Określ akcję
    ENUM_TRADE_ACTION action = DetermineAction();
    
    // Oblicz optymalną cenę
    double optimal_price = SymbolInfoDouble(Symbol(), SYMBOL_BID);
    
    // Oblicz wolumen
    double volume = 0.1; // Domyślny wolumen
    
    // Przygotuj uzasadnienie
    string reasoning = "Konsensus duchów: ";
    reasoning += "Harmonia=" + DoubleToString(harmony, 1) + "%, ";
    reasoning += "Pewność=" + DoubleToString(confidence, 1) + "%";
    
    // Utwórz decyzję
    m_last_decision.action = action;
    m_last_decision.confidence = confidence;
    m_last_decision.harmony = harmony;
    m_last_decision.optimal_price = optimal_price;
    m_last_decision.volume = volume;
    m_last_decision.reasoning = reasoning;
    m_last_decision.decision_time = TimeCurrent();
    
    return m_last_decision;
}

double CMasterConsciousness::CalculateHarmony() {
    if(!m_initialized) return 0.0;
    
    double harmony = 0.0;
    double total_weight = 0.0;
    
    // Light Spirit - rozpoznawanie wzorców
    if(m_light_spirit != NULL) {
        SSignalData signal = m_light_spirit.GetOptimalEntry();
        harmony += m_light_weight * signal.confidence;
        total_weight += m_light_weight;
    }
    
    // Fire Spirit - zmienność i energia
    if(m_fire_spirit != NULL) {
        double intensity = m_fire_spirit.GetFireIntensity();
        harmony += m_fire_weight * (intensity / 100.0);
        total_weight += m_fire_weight;
    }
    
    // Bitterness Spirit - momentum
    if(m_bitterness_spirit != NULL) {
        double momentum = m_bitterness_spirit.CalculateMomentumConvergence(); // Changed from GetMomentumStrength to CalculateMomentumConvergence
        harmony += m_bitterness_weight * (momentum / 100.0);
        total_weight += m_bitterness_weight;
    }
    
    // Body Spirit - wykonanie
    if(m_body_spirit != NULL) {
        double readiness = m_body_spirit.GetExecutionQuality();
        harmony += m_body_weight * (readiness / 100.0);
        total_weight += m_body_weight;
    }
    
    // Herbe Spirit - fundamentalne
    if(m_herbe_spirit != NULL) {
        double tension = m_herbe_spirit.GetFundamentalConflictStrength(); // Changed from GetFundamentalTension to GetFundamentalConflictStrength
        harmony += m_herbe_weight * (tension / 100.0);
        total_weight += m_herbe_weight;
    }
    
    // Sweetness Spirit - sentyment
    if(m_sweetness_spirit != NULL) {
        double sentiment = m_sweetness_spirit.GetHarmonyIndex(); // Changed from GetSentimentHarmony to GetHarmonyIndex
        harmony += m_sweetness_weight * (sentiment / 100.0);
        total_weight += m_sweetness_weight;
    }
    
    // Sound Spirit - harmonia
    if(m_sound_spirit != NULL) {
        double cycle_harmony = m_sound_spirit.GetCycleHarmonyIndex(); // Changed from GetCycleHarmony to GetCycleHarmonyIndex
        harmony += m_sound_weight * (cycle_harmony / 100.0);
        total_weight += m_sound_weight;
    }
    
    if(total_weight > 0) {
        harmony = harmony / total_weight * 100.0;
    }
    
    return MathMax(0.0, MathMin(100.0, harmony));
}

double CMasterConsciousness::CalculateConfidence() {
    if(!m_initialized) return 0.0;
    
    double confidence = 0.0;
    double total_weight = 0.0;
    
    // Oblicz średnią ważoną pewności wszystkich duchów
    if(m_light_spirit != NULL) {
        SSignalData signal = m_light_spirit.GetOptimalEntry();
        confidence += m_light_weight * signal.confidence;
        total_weight += m_light_weight;
    }
    
    if(m_fire_spirit != NULL) {
        confidence += m_fire_weight * 80.0; // Domyślna pewność
        total_weight += m_fire_weight;
    }
    
    if(m_bitterness_spirit != NULL) {
        confidence += m_bitterness_weight * 75.0;
        total_weight += m_bitterness_weight;
    }
    
    if(m_body_spirit != NULL) {
        confidence += m_body_weight * 85.0;
        total_weight += m_body_weight;
    }
    
    if(m_herbe_spirit != NULL) {
        confidence += m_herbe_weight * 70.0;
        total_weight += m_herbe_weight;
    }
    
    if(m_sweetness_spirit != NULL) {
        confidence += m_sweetness_weight * 75.0;
        total_weight += m_sweetness_weight;
    }
    
    if(m_sound_spirit != NULL) {
        confidence += m_sound_weight * 80.0;
        total_weight += m_sound_weight;
    }
    
    if(total_weight > 0) {
        confidence = confidence / total_weight;
    }
    
    return MathMax(0.0, MathMin(100.0, confidence));
}

ENUM_TRADE_ACTION CMasterConsciousness::DetermineAction() {
    if(!m_initialized) return ACTION_HOLD;
    
    // Pobierz sygnał z Light Spirit
    if(m_light_spirit != NULL) {
        SSignalData signal = m_light_spirit.GetOptimalEntry();
        
        if(signal.quality >= SIGNAL_STRONG && signal.confidence > 70.0) {
            if(signal.strength > 75) {
                return ACTION_BUY;
            } else if(signal.strength < 25) {
                return ACTION_SELL;
            }
        }
    }
    
    // Sprawdź czy wszystkie duchy są zsynchronizowane
    if(AreAllSpiritsAligned()) {
        double harmony = CalculateHarmony();
        if(harmony > 80.0) {
            return ACTION_BUY; // Wysoka harmonia = sygnał kupna
        } else if(harmony < 20.0) {
            return ACTION_SELL; // Niska harmonia = sygnał sprzedaży
        }
    }
    
    return ACTION_HOLD;
}

bool CMasterConsciousness::AreAllSpiritsAligned() {
    if(!m_initialized) return false;
    
    // Sprawdź czy wszystkie duchy są dostępne i działają
    bool all_available = (m_light_spirit != NULL && m_fire_spirit != NULL && 
                         m_bitterness_spirit != NULL && m_body_spirit != NULL &&
                         m_herbe_spirit != NULL && m_sweetness_spirit != NULL && 
                         m_sound_spirit != NULL);
    
    if(!all_available) return false;
    
    // Sprawdź czy wszystkie duchy mają wysoką pewność
    double avg_confidence = CalculateConfidence();
    return avg_confidence > 70.0;
}

SMarketState CMasterConsciousness::GetMarketState() {
    SMarketState state;
    
    if(!m_initialized) {
        state.system_confidence = 0.0;
        state.system_state = SYSTEM_DORMANT; // Changed from SYSTEM_STATE_INITIALIZING to SYSTEM_DORMANT
        state.all_spirits_aligned = false;
        return state;
    }
    
    // Oblicz wartości duchów
    state.herbe_strength = (m_herbe_spirit != NULL) ? m_herbe_spirit.GetFundamentalConflictStrength() : 0.0; // Changed from GetFundamentalTension to GetFundamentalConflictStrength
    state.sentiment_harmony = (m_sweetness_spirit != NULL) ? m_sweetness_spirit.GetHarmonyIndex() : 0.0; // Changed from GetSentimentHarmony to GetHarmonyIndex
    state.momentum_power = (m_bitterness_spirit != NULL) ? m_bitterness_spirit.CalculateMomentumConvergence() : 0.0; // Changed from GetMomentumStrength to CalculateMomentumConvergence
    state.fire_intensity = (m_fire_spirit != NULL) ? m_fire_spirit.GetFireIntensity() : 0.0;
    state.signal_clarity = (m_light_spirit != NULL) ? m_light_spirit.GetSignalClarity() : 0.0;
    state.cycle_harmony = (m_sound_spirit != NULL) ? m_sound_spirit.GetCycleHarmonyIndex() : 0.0; // Changed from GetCycleHarmony to GetCycleHarmonyIndex
    state.execution_readiness = (m_body_spirit != NULL) ? m_body_spirit.GetExecutionQuality() : 0.0;
    
    // Oblicz ogólną pewność systemu
    state.system_confidence = CalculateConfidence();
    
    // Określ stan systemu
    if(state.system_confidence > 80.0) {
        state.system_state = SYSTEM_TRANSCENDENT; // Changed from SYSTEM_STATE_OPTIMAL to SYSTEM_TRANSCENDENT
    } else if(state.system_confidence > 60.0) {
        state.system_state = SYSTEM_ACTIVE; // Changed from SYSTEM_STATE_GOOD to SYSTEM_ACTIVE
    } else if(state.system_confidence > 40.0) {
        state.system_state = SYSTEM_ALERT; // Changed from SYSTEM_STATE_FAIR to SYSTEM_ALERT
    } else {
        state.system_state = SYSTEM_DORMANT; // Changed from SYSTEM_STATE_POOR to SYSTEM_DORMANT
    }
    
    state.all_spirits_aligned = AreAllSpiritsAligned();
    
    return state;
}

double CMasterConsciousness::GetSystemConfidence() {
    return CalculateConfidence();
}

string CMasterConsciousness::GetConsensusReport() {
    string report = "=== KONSENSUS MASTER CONSCIOUSNESS ===\n";
    
    if(!m_initialized) {
        report += "Status: NIE ZAINICJALIZOWANY\n";
        return report;
    }
    
    SConsensusDecision decision = GetConsensusDecision();
    SMarketState state = GetMarketState();
    
    report += "Akcja: " + IntegerToString(decision.action) + "\n";
    report += "Pewność: " + DoubleToString(decision.confidence, 1) + "%\n";
    report += "Harmonia: " + DoubleToString(decision.harmony, 1) + "%\n";
    report += "Cena: " + DoubleToString(decision.optimal_price, 5) + "\n";
    report += "Wolumen: " + DoubleToString(decision.volume, 2) + "\n";
    report += "Uzasadnienie: " + decision.reasoning + "\n";
    report += "Stan systemu: " + IntegerToString(state.system_state) + "\n";
    report += "Wszystkie duchy zsynchronizowane: " + (state.all_spirits_aligned ? "TAK" : "NIE") + "\n";
    
    return report;
}

string CMasterConsciousness::GetSpiritAlignmentReport() {
    string report = "=== ALIGNMENT DUCHÓW ===\n";
    
    if(!m_initialized) {
        report += "Status: NIE ZAINICJALIZOWANY\n";
        return report;
    }
    
    report += "💡 Light Spirit: " + (m_light_spirit != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    report += "🔥 Fire Spirit: " + (m_fire_spirit != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    report += "💧 Bitterness Spirit: " + (m_bitterness_spirit != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    report += "💪 Body Spirit: " + (m_body_spirit != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    report += "🌱 Herbe Spirit: " + (m_herbe_spirit != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    report += "🍯 Sweetness Spirit: " + (m_sweetness_spirit != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    report += "🎵 Sound Spirit: " + (m_sound_spirit != NULL ? "AKTYWNY" : "NIEAKTYWNY") + "\n";
    
    report += "Harmonia ogólna: " + DoubleToString(CalculateHarmony(), 1) + "%\n";
    report += "Pewność systemu: " + DoubleToString(CalculateConfidence(), 1) + "%\n";
    report += "Zsynchronizowane: " + (AreAllSpiritsAligned() ? "TAK" : "NIE") + "\n";
    
    return report;
}

//+------------------------------------------------------------------+
//| CENTRAL AI MANAGEMENT METHODS                                      |
//+------------------------------------------------------------------+

// Sprawdzenie czy centralny AI jest gotowy
bool BohmeAISystem::IsCentralAIReady() {
    if(m_central_ai == NULL) return false;
    
    // Sprawdź czy wszystkie modele AI są zainicjalizowane
    SAIModelState lstm_state = m_central_ai.GetModelState(AI_MODEL_LSTM);
    SAIModelState cnn_state = m_central_ai.GetModelState(AI_MODEL_CNN);
    SAIModelState attention_state = m_central_ai.GetModelState(AI_MODEL_ATTENTION);
    SAIModelState kalman_state = m_central_ai.GetModelState(AI_MODEL_KALMAN);
    
    return (lstm_state.is_initialized && cnn_state.is_initialized && 
            attention_state.is_initialized && kalman_state.is_initialized);
}

// Raport z centralnego AI
string BohmeAISystem::GetCentralAIReport() {
    if(m_central_ai == NULL) {
        return "❌ Centralny AI Manager nie jest dostępny";
    }
    
    string report = "=== RAPORT CENTRALNEGO AI ===\n";
    
    // Status modeli AI
    SAIModelState lstm_state = m_central_ai.GetModelState(AI_MODEL_LSTM);
    SAIModelState cnn_state = m_central_ai.GetModelState(AI_MODEL_CNN);
    SAIModelState attention_state = m_central_ai.GetModelState(AI_MODEL_ATTENTION);
    SAIModelState kalman_state = m_central_ai.GetModelState(AI_MODEL_KALMAN);
    
    report += "🧠 LSTM Network:\n";
    report += "  Status: " + IntegerToString(lstm_state.training_state) + "\n";
    report += "  Dokładność: " + DoubleToString(lstm_state.accuracy, 1) + "%\n";
    report += "  Zainicjalizowany: " + (lstm_state.is_initialized ? "TAK" : "NIE") + "\n";
    
    report += "🔍 CNN Network:\n";
    report += "  Status: " + IntegerToString(cnn_state.training_state) + "\n";
    report += "  Dokładność: " + DoubleToString(cnn_state.accuracy, 1) + "%\n";
    report += "  Zainicjalizowany: " + (cnn_state.is_initialized ? "TAK" : "NIE") + "\n";
    
    report += "👁️ Attention Mechanism:\n";
    report += "  Status: " + IntegerToString(attention_state.training_state) + "\n";
    report += "  Dokładność: " + DoubleToString(attention_state.accuracy, 1) + "%\n";
    report += "  Zainicjalizowany: " + (attention_state.is_initialized ? "TAK" : "NIE") + "\n";
    
    report += "📊 Kalman Filter:\n";
    report += "  Status: " + IntegerToString(kalman_state.training_state) + "\n";
    report += "  Dokładność: " + DoubleToString(kalman_state.accuracy, 1) + "%\n";
    report += "  Zainicjalizowany: " + (kalman_state.is_initialized ? "TAK" : "NIE") + "\n";
    
    // Ogólny status
    report += "\n=== OGÓLNY STATUS ===\n";
    report += "Centralny AI gotowy: " + (IsCentralAIReady() ? "TAK" : "NIE") + "\n";
    report += "Liczba aktywnych modeli: ";
    
    int active_models = 0;
    if(lstm_state.is_initialized) active_models++;
    if(cnn_state.is_initialized) active_models++;
    if(attention_state.is_initialized) active_models++;
    if(kalman_state.is_initialized) active_models++;
    
    report += IntegerToString(active_models) + "/4\n";
    
    return report;
}

// Uczenie się z wyniku transakcji
void BohmeAISystem::LearnFromTradeResult(STradeRecord &trade_result) {
    LogInfo(LOG_COMPONENT_MASTER, "Uczenie się z transakcji", 
            "ID: " + IntegerToString(trade_result.trade_id) + 
            ", Zysk: " + DoubleToString(trade_result.actual_profit, 6));
    
    // Aktualizacja pamięci systemu
    UpdateSystemMemory(m_current_state, trade_result.decision);
    
    // Uczenie się Master AI Controller
    if(m_master_ai != NULL) {
        m_master_ai.LearnFromTradeResult(trade_result);
    }
    
    // Ewolucyjne uczenie systemu
    if(IsSystemEvolutionNeeded()) {
        PerformSystemEvolution();
    }
    
    // Aktualizacja wydajności systemu
    if(m_performance_count < 1000) {
        m_system_performance_history[m_performance_count] = trade_result.actual_profit;
        m_performance_count++;
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "Uczenie się zakończone", 
            "Wydajność systemu: " + DoubleToString(GetSystemPerformance(), 2) + "%");
}

// Aktualizacja wag modelu
void BohmeAISystem::UpdateModelWeights(STradeRecord &trade) {
    LogInfo(LOG_COMPONENT_MASTER, "Aktualizacja wag modelu", 
            "ID: " + IntegerToString(trade.trade_id));
    
    // Aktualizacja wag wszystkich duchów
    if(m_spirit_herbe != NULL) m_spirit_herbe.UpdateNeuralNetwork();
    if(m_spirit_sweetness != NULL) m_spirit_sweetness.UpdateSentimentModels();
    if(m_spirit_bitterness != NULL) m_spirit_bitterness.UpdateMomentumBuffers();
    if(m_spirit_fire != NULL) m_spirit_fire.UpdateVolatilityModels();
    if(m_spirit_light != NULL) m_spirit_light.UpdateSignalModels();
    if(m_spirit_sound != NULL) m_spirit_sound.UpdateCycleModels();
    if(m_spirit_body != NULL) m_spirit_body.UpdateRiskParameters();
    
    // Aktualizacja Master Consciousness
    if(m_master_consciousness != NULL && m_state_history_count > 0) {
        double learning_data[1][196];
        double learning_targets[1];
        
        // Przygotowanie danych do uczenia
        PrepareSystemLearningData(learning_data, learning_targets);
        m_master_consciousness.UpdateWeights(learning_data, learning_targets, 1);
    }
    
    // Aktualizacja Master AI Controller
    if(m_master_ai != NULL) {
        m_master_ai.UpdateModelWeights(trade);
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "Wagi modelu zaktualizowane", "Wszystkie komponenty zaktualizowane");
}

// Podejmowanie decyzji handlowych przez AI
SAIPrediction BohmeAISystem::MakeTradeDecision(SMarketState &market_state) {
    SAIPrediction prediction;
    
    // Aktualizacja stanu rynku
    m_current_state = market_state;
    
    // Predykcja przez Master AI Controller
    if(m_master_ai != NULL) {
        prediction = m_master_ai.MakeTradeDecision(market_state);
    } else {
        // Fallback - podstawowa predykcja
        prediction.action = ACTION_HOLD;
        prediction.confidence = 0.0;
        prediction.reasoning = "Master AI Controller niedostępny";
    }
    
    // Predykcja przez Master Consciousness
    if(m_master_consciousness != NULL) {
        double inputs[196];
        PrepareMasterConsciousnessInputs(inputs, market_state);
        
        double consciousness_prediction = m_master_consciousness.Forward(inputs);
        
        // Kombinacja predykcji (średnia ważona)
        if(prediction.confidence > 0) {
            prediction.confidence = (prediction.confidence + consciousness_prediction * 100.0) / 2.0;
        } else {
            prediction.confidence = consciousness_prediction * 100.0;
        }
    }
    
    // Walidacja i korekta predykcji
    if(prediction.confidence < m_confidence_threshold) {
        prediction.action = ACTION_HOLD;
        prediction.reasoning = "Niska pewność - brak akcji";
    }
    
    // Dodatkowe informacje
    prediction.timestamp = TimeCurrent();
    prediction.market_state = market_state;
    prediction.ai_model_version = "v2.1.0";
    
    // Logowanie decyzji
    LogInfo(LOG_COMPONENT_MASTER, "Decyzja handlowa AI", 
            "Akcja: " + IntegerToString(prediction.action) + 
            ", Pewność: " + DoubleToString(prediction.confidence, 1) + "%");
    
    return prediction;
}

//+------------------------------------------------------------------+
//| IMPLEMENTACJA CMasterAIController                                 |
//+------------------------------------------------------------------+

// Konstruktor CMasterAIController
CMasterAIController::CMasterAIController() {
    // Inicjalizacja parametrów uczenia się
    m_min_confidence_threshold = 0.7;    // 70% minimalna pewność
    m_profit_threshold = 0.02;           // 2% próg zysku
    m_risk_threshold = 0.05;             // 5% próg ryzyka
    m_min_training_samples = 100;        // Minimum 100 próbek do treningu
    
    // Inicjalizacja liczników
    m_trade_history_count = 0;
    
    // Inicjalizacja modelu uczenia się
    InitializeLearningModel();
    
    LogInfo(LOG_COMPONENT_MASTER, "CMasterAIController zainicjalizowany", "AI Controller gotowy do uczenia się");
}

// Destruktor CMasterAIController
CMasterAIController::~CMasterAIController() {
    // Eksport historii transakcji przed zniszczeniem
    if(m_trade_history_count > 0) {
        ExportTradeHistory("trade_history_export.csv");
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "CMasterAIController zniszczony", "Historia transakcji wyeksportowana");
}

// Inicjalizacja modelu uczenia się
void CMasterAIController::InitializeLearningModel() {
    // Inicjalizacja struktury modelu
    m_learning_model.is_initialized = true;
    m_learning_model.learning_rate = 0.001;
    m_learning_model.epochs = 1000;
    m_learning_model.batch_size = 32;
    m_learning_model.accuracy = 0.0;
    m_learning_model.loss = 1.0;
    m_learning_model.training_state = AI_TRAINING_NOT_TRAINED;
    m_learning_model.positive_trades = 0;
    m_learning_model.negative_trades = 0;
    m_learning_model.bias = 0.0;
    
    // Inicjalizacja wag modelu (prosty model liniowy)
    ArrayResize(m_learning_model.weights, 8); // 8 cech wejściowych
    for(int i = 0; i < 8; i++) {
        m_learning_model.weights[i] = (MathRand() - 16384) / 16384.0; // Losowe wagi [-1, 1]
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "Model uczenia się zainicjalizowany", "Wagi zainicjalizowane losowo");
}

// Przygotowanie cech wejściowych z stanu rynku
void CMasterAIController::PrepareInputFeatures(double &features[], SMarketState &state) {
    // Konwersja stanu rynku na cechy dla AI (normalizacja do [0,1])
    ArrayResize(features, 8);
    
    features[0] = state.herbe_strength / 100.0;           // Siła fundamentalna
    features[1] = state.sentiment_harmony / 100.0;         // Harmonia sentymentu
    features[2] = state.momentum_power / 100.0;            // Siła momentum
    features[3] = state.fire_intensity / 100.0;            // Intensywność ognia (volatility)
    features[4] = state.signal_clarity / 100.0;            // Jasność sygnału
    features[5] = state.cycle_harmony / 100.0;             // Harmonia cykli
    features[6] = state.execution_readiness / 100.0;       // Gotowość wykonania
    features[7] = state.system_confidence / 100.0;         // Pewność systemu
    
    // Normalizacja i walidacja
    for(int i = 0; i < 8; i++) {
        features[i] = MathMax(0.0, MathMin(1.0, features[i]));
    }
}

// Predykcja akcji przez AI
double CMasterAIController::PredictAction(double &features[]) {
    if(!m_learning_model.is_initialized) {
        LogError(LOG_COMPONENT_MASTER, "Model nie zainicjalizowany", "Brak predykcji");
        return 0.0;
    }
    
    // Implementacja predykcji AI (prosty model liniowy)
    double prediction = 0.0;
    
    // Obliczenie predykcji: suma(cecha * waga)
    for(int i = 0; i < ArraySize(features) && i < ArraySize(m_learning_model.weights); i++) {
        prediction += features[i] * m_learning_model.weights[i];
    }
    
    // Dodanie bias term
    prediction += m_learning_model.bias;
    
    // Normalizacja do zakresu [-1, 1]
    prediction = MathMax(-1.0, MathMin(1.0, prediction));
    
    // Logowanie predykcji
    LogInfo(LOG_COMPONENT_MASTER, "Predykcja AI", "Wartość: " + DoubleToString(prediction, 4));
    
    return prediction;
}

// Aktualizacja wag modelu na podstawie wyniku transakcji
void CMasterAIController::UpdateModelWeights(STradeRecord &trade) {
    if(!m_learning_model.is_initialized) return;
    
    // Obliczenie błędu predykcji
    double predicted_profit = trade.predicted_profit;
    double actual_profit = trade.actual_profit;
    double error = actual_profit - predicted_profit;
    
    // Obliczenie gradientu dla każdej cechy
    double learning_rate = m_learning_model.learning_rate;
    
    // Aktualizacja wag (uproszczona wersja backpropagation)
    for(int i = 0; i < ArraySize(m_learning_model.weights) && i < ArraySize(trade.input_features); i++) {
        double gradient = error * trade.input_features[i];
        m_learning_model.weights[i] += learning_rate * gradient;
        
        // Ograniczenie wag do rozsądnego zakresu
        m_learning_model.weights[i] = MathMax(-2.0, MathMin(2.0, m_learning_model.weights[i]));
    }
    
    // Aktualizacja bias term
    m_learning_model.bias += learning_rate * error;
    m_learning_model.bias = MathMax(-1.0, MathMin(1.0, m_learning_model.bias));
    
    // Aktualizacja metryk modelu
    m_learning_model.loss = MathAbs(error);
    
    LogInfo(LOG_COMPONENT_MASTER, "Wagi modelu zaktualizowane", "Błąd: " + DoubleToString(error, 6));
}

// Obliczenie wyniku sukcesu transakcji
double CMasterAIController::CalculateSuccessScore(STradeRecord &trade) {
    double success_score = 0.0;
    
    // Podstawowy wynik na podstawie zysku/straty
    if(trade.actual_profit > 0) {
        success_score = MathMin(100.0, trade.actual_profit * 1000); // Skala 0-100
    } else {
        success_score = MathMax(-100.0, trade.actual_profit * 1000); // Skala -100-0
    }
    
    // Bonus za zgodność z predykcją
    double prediction_accuracy = 1.0 - MathAbs(trade.predicted_profit - trade.actual_profit);
    success_score += prediction_accuracy * 20.0; // Maksymalnie +20 punktów
    
    // Bonus za zarządzanie ryzykiem
    if(trade.risk_reward_ratio > 2.0) {
        success_score += 10.0; // +10 punktów za RR > 2:1
    }
    
    // Ograniczenie do zakresu [-100, 100]
    return MathMax(-100.0, MathMin(100.0, success_score));
}

// Walidacja predykcji na podstawie rzeczywistego wyniku
void CMasterAIController::ValidatePrediction(STradeRecord &trade) {
    double prediction_error = MathAbs(trade.predicted_profit - trade.actual_profit);
    double accuracy = MathMax(0.0, 100.0 - prediction_error * 100);
    
    // Aktualizacja dokładności modelu
    if(m_learning_model.accuracy == 0.0) {
        m_learning_model.accuracy = accuracy;
    } else {
        // Średnia krocząca dokładności
        m_learning_model.accuracy = (m_learning_model.accuracy * 0.9) + (accuracy * 0.1);
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "Walidacja predykcji", 
            "Dokładność: " + DoubleToString(accuracy, 1) + "%, " +
            "Błąd: " + DoubleToString(prediction_error, 6));
}

// Logowanie rekordu transakcji
void CMasterAIController::LogTradeRecord(STradeRecord &trade) {
    // Dodanie do historii transakcji
    if(m_trade_history_count < 1000) {
        m_trade_history[m_trade_history_count] = trade;
        m_trade_history_count++;
    } else {
        // Przesunięcie historii (FIFO)
        for(int i = 0; i < 999; i++) {
            m_trade_history[i] = m_trade_history[i + 1];
        }
        m_trade_history[999] = trade;
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "Transakcja zalogowana", 
            "ID: " + IntegerToString(trade.trade_id) + ", " +
            "Zysk: " + DoubleToString(trade.actual_profit, 6));
}

// Główna metoda podejmowania decyzji handlowych
SAIPrediction CMasterAIController::MakeTradeDecision(SMarketState &market_state) {
    SAIPrediction prediction;
    
    // Przygotowanie cech wejściowych
    double features[8];
    PrepareInputFeatures(features, market_state);
    
    // Predykcja przez model AI
    double ai_prediction = PredictAction(features);
    
    // Konwersja predykcji na decyzję handlową
    prediction.action = ACTION_HOLD;
    prediction.confidence = 0.0;
    prediction.reasoning = "Brak wystarczającej pewności";
    
    if(MathAbs(ai_prediction) > m_min_confidence_threshold) {
        if(ai_prediction > 0.5) {
            prediction.action = ACTION_BUY;
            prediction.confidence = ai_prediction * 100.0;
            prediction.reasoning = "AI sygnał kupna - wysoka pewność";
        } else if(ai_prediction < -0.5) {
            prediction.action = ACTION_SELL;
            prediction.confidence = MathAbs(ai_prediction) * 100.0;
            prediction.reasoning = "AI sygnał sprzedaży - wysoka pewność";
        }
    }
    
    // Dodatkowe informacje
    prediction.timestamp = TimeCurrent();
    prediction.market_state = market_state;
    prediction.ai_model_version = "v2.1.0";
    
    // Zapisanie ostatniej predykcji
    m_last_prediction = prediction;
    
    return prediction;
}

// Uczenie się z wyniku transakcji
void CMasterAIController::LearnFromTradeResult(STradeRecord &trade_result) {
    // Logowanie transakcji
    LogTradeRecord(trade_result);
    
    // Obliczenie wyniku sukcesu
    double success_score = CalculateSuccessScore(trade_result);
    
    // Aktualizacja wag modelu
    UpdateModelWeights(trade_result);
    
    // Walidacja predykcji
    ValidatePrediction(trade_result);
    
    // Aktualizacja metryk systemu
    if(success_score > 0) {
        m_learning_model.positive_trades++;
    } else {
        m_learning_model.negative_trades++;
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "Uczenie się z transakcji", 
            "Wynik: " + DoubleToString(success_score, 1) + ", " +
            "Dokładność modelu: " + DoubleToString(m_learning_model.accuracy, 1) + "%");
}

// Aktualizacja modelu (trening wsadowy)
void CMasterAIController::UpdateModel() {
    if(m_trade_history_count < m_min_training_samples) {
        LogInfo(LOG_COMPONENT_MASTER, "Za mało danych do treningu", 
                "Wymagane: " + IntegerToString(m_min_training_samples) + 
                ", Dostępne: " + IntegerToString(m_trade_history_count));
        return;
    }
    
    // Trening wsadowy na całej historii
    m_learning_model.training_state = AI_TRAINING_IN_PROGRESS;
    
    for(int epoch = 0; epoch < m_learning_model.epochs; epoch++) {
        double total_error = 0.0;
        
        // Przetwarzanie wszystkich transakcji
        for(int i = 0; i < m_trade_history_count; i++) {
            STradeRecord &trade = m_trade_history[i];
            
            // Przygotowanie cech
            double features[8];
            PrepareInputFeatures(features, trade.market_state);
            
            // Predykcja
            double predicted = PredictAction(features);
            double actual = (trade.actual_profit > 0) ? 1.0 : -1.0;
            
            // Obliczenie błędu
            double error = actual - predicted;
            total_error += MathAbs(error);
            
            // Aktualizacja wag
            for(int j = 0; j < 8; j++) {
                double gradient = error * features[j];
                m_learning_model.weights[j] += m_learning_model.learning_rate * gradient;
            }
        }
        
        // Średni błąd epoki
        double avg_error = total_error / m_trade_history_count;
        m_learning_model.loss = avg_error;
        
        // Logowanie postępu
        if(epoch % 100 == 0) {
            LogInfo(LOG_COMPONENT_MASTER, "Trening epoki", 
                    "Epoch: " + IntegerToString(epoch) + 
                    ", Błąd: " + DoubleToString(avg_error, 6));
        }
    }
    
    m_learning_model.training_state = AI_TRAINING_COMPLETED;
    LogInfo(LOG_COMPONENT_MASTER, "Trening zakończony", 
            "Liczba epok: " + IntegerToString(m_learning_model.epochs) + 
            ", Końcowy błąd: " + DoubleToString(m_learning_model.loss, 6));
}

// Pobranie dokładności modelu
double CMasterAIController::GetModelAccuracy() {
    return m_learning_model.accuracy;
}

// Pobranie współczynnika zysku
double CMasterAIController::GetProfitFactor() {
    if(m_learning_model.negative_trades == 0) return 0.0;
    return (double)m_learning_model.positive_trades / m_learning_model.negative_trades;
}

// Raport modelu AI
string CMasterAIController::GetModelReport() {
    string report = "=== RAPORT MODELU AI ===\n";
    report += "Status: " + (m_learning_model.is_initialized ? "ZAINICJALIZOWANY" : "NIE ZAINICJALIZOWANY") + "\n";
    report += "Dokładność: " + DoubleToString(m_learning_model.accuracy, 1) + "%\n";
    report += "Błąd: " + DoubleToString(m_learning_model.loss, 6) + "\n";
    report += "Współczynnik zysku: " + DoubleToString(GetProfitFactor(), 2) + "\n";
    report += "Transakcje pozytywne: " + IntegerToString(m_learning_model.positive_trades) + "\n";
    report += "Transakcje negatywne: " + IntegerToString(m_learning_model.negative_trades) + "\n";
    report += "Historia transakcji: " + IntegerToString(m_trade_history_count) + "\n";
    report += "Stan treningu: " + IntegerToString(m_learning_model.training_state) + "\n";
    report += "========================";
    
    return report;
}

// Eksport historii transakcji
void CMasterAIController::ExportTradeHistory(string filename) {
    if(m_trade_history_count == 0) {
        LogWarning(LOG_COMPONENT_MASTER, "Brak historii do eksportu", "Historia transakcji jest pusta");
        return;
    }
    
    int file_handle = FileOpen(filename, FILE_WRITE | FILE_CSV);
    if(file_handle != INVALID_HANDLE) {
        // Nagłówek CSV
        FileWrite(file_handle, "TradeID", "Timestamp", "Action", "PredictedProfit", "ActualProfit", 
                 "RiskRewardRatio", "MarketState", "Confidence");
        
        // Dane transakcji
        for(int i = 0; i < m_trade_history_count; i++) {
            STradeRecord &trade = m_trade_history[i];
            FileWrite(file_handle, 
                     trade.trade_id,
                     TimeToString(trade.timestamp),
                     IntegerToString(trade.action),
                     DoubleToString(trade.predicted_profit, 6),
                     DoubleToString(trade.actual_profit, 6),
                     DoubleToString(trade.risk_reward_ratio, 2),
                     IntegerToString(trade.market_state.system_state),
                     DoubleToString(trade.confidence, 2));
        }
        
        FileClose(file_handle);
        LogInfo(LOG_COMPONENT_MASTER, "Historia wyeksportowana", "Plik: " + filename);
    } else {
        LogError(LOG_COMPONENT_MASTER, "Błąd eksportu", "Nie można utworzyć pliku: " + filename);
    }
}

// Ustawienie progu pewności
void CMasterAIController::SetConfidenceThreshold(double threshold) {
    m_min_confidence_threshold = MathMax(0.1, MathMin(0.9, threshold));
    LogInfo(LOG_COMPONENT_MASTER, "Próg pewności zaktualizowany", 
            "Nowa wartość: " + DoubleToString(m_min_confidence_threshold, 2));
}

// Ustawienie progu zysku
void CMasterAIController::SetProfitThreshold(double threshold) {
    m_profit_threshold = MathMax(0.001, MathMin(0.1, threshold));
    LogInfo(LOG_COMPONENT_MASTER, "Próg zysku zaktualizowany", 
            "Nowa wartość: " + DoubleToString(m_profit_threshold, 4));
}

// Ustawienie progu ryzyka
void CMasterAIController::SetRiskThreshold(double threshold) {
    m_risk_threshold = MathMax(0.01, MathMin(0.2, threshold));
    LogInfo(LOG_COMPONENT_MASTER, "Próg ryzyka zaktualizowany", 
            "Nowa wartość: " + DoubleToString(m_risk_threshold, 4));
}

// Ustawienie współczynnika uczenia się
void CMasterAIController::SetLearningRate(double rate) {
    m_learning_model.learning_rate = MathMax(0.0001, MathMin(0.01, rate));
    LogInfo(LOG_COMPONENT_MASTER, "Współczynnik uczenia zaktualizowany", 
            "Nowa wartość: " + DoubleToString(m_learning_model.learning_rate, 6));
}