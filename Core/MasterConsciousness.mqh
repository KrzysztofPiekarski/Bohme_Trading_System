// Główny kontroler systemu Böhmego - Master Consciousness
#include "Spirits/HerbeSpirit.mqh"
#include "Spirits/SweetnessSpirit.mqh" 
#include "Spirits/BitternessSpirit.mqh"
#include "Spirits/FireSpirit.mqh"
#include "Spirits/LightSpirit.mqh"
#include "Spirits/SoundSpirit.mqh"
#include "Spirits/BodySpirit.mqh"

// Brakujące definicje enum
enum ENUM_TRADE_ACTION {
    ACTION_NONE,        // Brak akcji
    ACTION_BUY,         // Kupno
    ACTION_SELL,        // Sprzedaż
    ACTION_HOLD,        // Trzymanie
    ACTION_CLOSE        // Zamknięcie
};

enum ENUM_SYSTEM_STATE {
    SYSTEM_DORMANT,        // System uśpiony
    SYSTEM_AWAKENING,      // System się budzi
    SYSTEM_ALERT,          // System czujny
    SYSTEM_ACTIVE,         // System aktywny
    SYSTEM_TRANSCENDENT    // System w stanie transcendencji
};

enum ENUM_MARKET_PHASE {
    PHASE_BULLISH_TENSION,  // Napięcie wzrostowe
    PHASE_BEARISH_TENSION,  // Napięcie spadkowe
    PHASE_NEUTRAL,          // Neutralne
    PHASE_TRANSITION        // Przejście
};

enum ENUM_MOMENTUM_PHASE {
    MOMENTUM_ACCUMULATION,  // Akumulacja
    MOMENTUM_BREAKTHROUGH,  // Przełamanie
    MOMENTUM_ACCELERATION,  // Przyspieszenie
    MOMENTUM_EXHAUSTION     // Wyczerpanie
};

enum ENUM_SIGNAL_QUALITY {
    SIGNAL_WEAK,           // Słaby sygnał
    SIGNAL_MODERATE,       // Umiarkowany sygnał
    SIGNAL_STRONG,         // Silny sygnał
    SIGNAL_CRYSTAL_CLEAR   // Krystalicznie jasny
};

enum ENUM_HARMONY_STATE {
    HARMONY_DISSONANT,     // Dysharmonia
    HARMONY_BALANCED,      // Zrównoważona
    HARMONY_RESONANT,      // Rezonansowa
    HARMONY_TRANSCENDENT   // Transcendentna
};

enum ENUM_ENERGY_STATE {
    ENERGY_DORMANT,        // Energia uśpiona
    ENERGY_AWAKENING,      // Energia się budzi
    ENERGY_ACTIVE,         // Energia aktywna
    ENERGY_INTENSE,        // Energia intensywna
    ENERGY_EXHAUSTED       // Energia wyczerpana
};

// Brakujące struktury
struct SSignalData {
    double optimal_price;
    datetime optimal_time;
    double strength;
    ENUM_SIGNAL_QUALITY quality;
    string description;
};

struct SCycle {
    ENUM_TIMEFRAMES type;
    double phase;
    double strength;
    datetime next_peak;
};

struct STradeExecution {
    ENUM_TRADE_ACTION action;
    double price;
    double volume;
    datetime execution_time;
    string comment;
};

struct SMarketState {
    // Stan każdego ducha
    double herbe_strength;        // Siła konfliktu fundamentalnego
    double sentiment_harmony;     // Harmonia nastrojów
    double momentum_power;        // Siła momentum
    double fire_intensity;        // Intensywność ognia/volatilności
    double signal_clarity;        // Jasność sygnałów
    double cycle_harmony;         // Harmonia cykliczna
    double execution_readiness;   // Gotowość do wykonania
    
    // Stan ogólny systemu
    double system_confidence;     // Pewność systemu (0-100)
    ENUM_SYSTEM_STATE system_state;
    bool all_spirits_aligned;     // Czy wszystkie duchy są zgodne
    datetime analysis_time;       // Czas analizy
    string market_phase;          // Faza rynku w języku naturalnym
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
    ulong ticket;                 // Ticket transakcji
    datetime entry_time;          // Czas wejścia
    datetime exit_time;           // Czas wyjścia
    ENUM_TRADE_ACTION action;     // Akcja (BUY/SELL)
    double entry_price;           // Cena wejścia
    double exit_price;            // Cena wyjścia
    double volume;                // Wolumen
    double profit_loss;           // Zysk/strata
    double profit_factor;         // Współczynnik zysku
    
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
    
    // Wynik transakcji
    bool was_profitable;          // Czy była zyskowna
    double success_score;         // Wynik sukcesu (0-100)
    string market_condition;      // Stan rynku
    string learning_notes;        // Notatki do uczenia się
};

// Struktura modelu uczenia się
struct SLearningModel {
    double weights[196];          // Wagi modelu (7 duchów * 28 cech)
    double bias;                  // Bias
    double learning_rate;         // Szybkość uczenia
    double momentum;              // Momentum
    int training_samples;         // Liczba próbek treningowych
    double accuracy;              // Dokładność modelu
    double profit_factor;         // Współczynnik zysku
    datetime last_update;         // Ostatnia aktualizacja
    string model_version;         // Wersja modelu
};

// Struktura predykcji AI
struct SAIPrediction {
    ENUM_TRADE_ACTION recommended_action;  // Zalecana akcja
    double confidence;                     // Pewność predykcji (0-100)
    double expected_profit;                // Oczekiwany zysk
    double risk_score;                     // Wynik ryzyka
    double optimal_entry_price;            // Optymalna cena wejścia
    double optimal_exit_price;             // Optymalna cena wyjścia
    datetime optimal_entry_time;           // Optymalny czas wejścia
    string reasoning;                      // Uzasadnienie decyzji
    double spirit_alignment_score;         // Wynik zgodności duchów
    double volatility_regime_score;        // Wynik reżimu volatilności
};

// Brakujące klasy (deklaracje)
class CTransformerNet {
public:
    CTransformerNet(int inputs, int heads, int layers);
    double ProcessState(double &inputs[]);
    double ValidateDecision(double &inputs[]);
    void UpdateWeights(double &data[][], double &targets[], int count);
};

class CSystemMemory {
public:
    CSystemMemory(int size);
    void StoreState(SMarketState state, STradeDecision decision);
    void RetrieveState(int index, SMarketState &state, STradeDecision &decision);
};

class CEvolutionaryLearning {
public:
    CEvolutionaryLearning();
    void EvolveParameters();
    bool IsEvolutionNeeded();
};

// Dodatkowe deklaracje metod dla duchów (placeholdery)
class HerbeQualityAI {
public:
    double GetFundamentalConflictStrength();
    ENUM_MARKET_PHASE GetMarketPhase();
    void UpdateNeuralNetwork();
};

class SentimentAI {
public:
    double GetHarmonyIndex();
    double GetSentimentMomentum();
    void UpdateSentimentModels();
};

// All spirit classes are imported from their respective .mqh files

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
    
    // Master Consciousness - nadrzędna świadomość
    CTransformerNet*    m_master_consciousness;
    
    // System memory and learning
    CSystemMemory*      m_system_memory;
    CEvolutionaryLearning* m_evolutionary_learner;
    
    // State tracking
    SMarketState        m_current_state;
    SMarketState        m_previous_states[100]; // Historia stanów
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
    void UpdateSystemMemory(SMarketState state, STradeDecision decision);
    double CalculateSystemEntropy();
    void PerformSystemEvolution();
    
    // Helper functions
    bool AreSpiritsComplementary(int spirit1, int spirit2, double value1, double value2);
    void PrepareMasterConsciousnessInputs(double &inputs[], SMarketState state);
    void PrepareFinalDecisionInputs(double &inputs[], STradeDecision decision, SMarketState state);
    void PrepareSystemLearningData(double &data[][], double &targets[]);
    double CalculateOptimalStopDistance(double signal_strength);
    STradeExecution ConvertDecisionToSignal(STradeDecision decision);
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
    
    // Learning and evolution
    void LearnFromOutcome(double actual_result);
    void EvolveSystemParameters();
    bool IsSystemEvolutionNeeded();
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
    return false;
}

void BohmeAISystem::PrepareMasterConsciousnessInputs(double &inputs[], SMarketState state) {
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

void BohmeAISystem::PrepareFinalDecisionInputs(double &inputs[], STradeDecision decision, SMarketState state) {
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
    // Implementacja przygotowania danych do uczenia
    for(int i = 0; i < m_state_history_count && i < 1000; i++) {
        for(int j = 0; j < 196; j++) {
            data[i][j] = 0.0; // Placeholder
        }
        targets[i] = 0.0; // Placeholder
    }
}

double BohmeAISystem::CalculateOptimalStopDistance(double signal_strength) {
    // Adaptacyjny stop loss na podstawie siły sygnału
    double base_stop = 0.02; // 2% bazowy stop
    double strength_factor = (100.0 - signal_strength) / 100.0; // Im słabszy sygnał, tym większy stop
    return base_stop * (1.0 + strength_factor);
}

STradeExecution BohmeAISystem::ConvertDecisionToSignal(STradeDecision decision) {
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

void BohmeAISystem::UpdateSystemMemory(SMarketState state, STradeDecision decision) {
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

// Funkcja główna systemu - OnTick
void OnTick() {
    static datetime last_analysis = 0;
    static BohmeAISystem* bohme_system = NULL;
    
    // Inicjalizacja systemu przy pierwszym wywołaniu
    if(bohme_system == NULL) {
        bohme_system = new BohmeAISystem();
        if(!bohme_system.InitializeSystem()) {
            Print("❌ Błąd inicjalizacji systemu Böhmego!");
            return;
        }
    }
    
    datetime current_time = TimeCurrent();
    
    // Analiza co minutę (może być dostosowane)
    if(current_time - last_analysis >= 60) {
        last_analysis = current_time;
        
        // Główny cykl systemu
        SMarketState state = bohme_system.AnalyzeMarketState();
        
        // Sprawdź czy warunki sprzyjają podejmowaniu decyzji
        if(state.system_confidence > 70.0 && 
           (state.all_spirits_aligned || state.system_state == SYSTEM_TRANSCENDENT)) {
            
            STradeDecision decision = bohme_system.MakeTradeDecision();
            
            if(decision.action != ACTION_NONE) {
                // Wykonaj decyzję
                STradeExecution execution = bohme_system.m_spirit_body.OptimizeExecution(ConvertDecisionToSignal(decision));
                
                if(bohme_system.m_spirit_body.ExecuteTrade(execution)) {
                    Print("✅ Transakcja wykonana zgodnie z wolą Duchów!");
                }
                else {
                    Print("❌ Błąd wykonania - Duchy nie były zadowolone...");
                }
            }
        }
        
        // Zarządzanie otwartymi pozycjami
        if(bohme_system.m_spirit_body != NULL) {
            bohme_system.m_spirit_body.ManageOpenPositions();
        }
        
        // Aktualizacja modeli (co godzinę)
        if(current_time % 3600 == 0) {
            bohme_system.UpdateModels();
        }
        
        // Diagnostyka systemu (co dzień)
        if(TimeHour(current_time) == 0 && TimeMinute(current_time) == 0) {
            bohme_system.DiagnoseSystemHealth();
            string report = bohme_system.GenerateSystemReport();
            Print("📊 DZIENNY RAPORT SYSTEMU:");
            Print(report);
        }
    }
}

// Implementacje brakujących klas
CTransformerNet::CTransformerNet(int inputs, int heads, int layers) {
    // Placeholder implementation
}

double CTransformerNet::ProcessState(double &inputs[]) {
    // Placeholder implementation
    double sum = 0.0;
    for(int i = 0; i < ArraySize(inputs); i++) {
        sum += inputs[i];
    }
    return MathMax(0.0, MathMin(1.0, sum / ArraySize(inputs)));
}

double CTransformerNet::ValidateDecision(double &inputs[]) {
    // Placeholder implementation
    return 0.7 + (MathRand() % 30) / 100.0; // 0.7-1.0
}

void CTransformerNet::UpdateWeights(double &data[][], double &targets[], int count) {
    // Placeholder implementation
}

CSystemMemory::CSystemMemory(int size) {
    // Placeholder implementation
}

void CSystemMemory::StoreState(SMarketState state, STradeDecision decision) {
    // Placeholder implementation
}

void CSystemMemory::RetrieveState(int index, SMarketState &state, STradeDecision &decision) {
    // Placeholder implementation
}

CEvolutionaryLearning::CEvolutionaryLearning() {
    // Placeholder implementation
}

void CEvolutionaryLearning::EvolveParameters() {
    // Placeholder implementation
}

bool CEvolutionaryLearning::IsEvolutionNeeded() {
    // Placeholder implementation
    return (MathRand() % 100) > 80; // 20% szans na ewolucję
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