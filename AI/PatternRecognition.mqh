#ifndef PATTERN_RECOGNITION_H
#define PATTERN_RECOGNITION_H

// ========================================
// PATTERN RECOGNITION - ROZPOZNAWANIE WZORCÓW
// ========================================
// Zaawansowane algorytmy rozpoznawania wzorców dla Systemu Böhmego
// Wzorce techniczne, wzorce cenowe, wzorce czasowe, wzorce behawioralne

// === PODSTAWOWE ENUMERACJE ===

// Typy wzorców
enum ENUM_PATTERN_TYPE {
    PATTERN_NONE,                   // Brak wzorca
    PATTERN_CANDLESTICK,            // Wzorce świecowe
    PATTERN_CHART,                  // Wzorce wykresowe
    PATTERN_TECHNICAL,              // Wzorce techniczne
    PATTERN_PRICE,                  // Wzorce cenowe
    PATTERN_VOLUME,                 // Wzorce wolumenu
    PATTERN_TIME,                   // Wzorce czasowe
    PATTERN_BEHAVIORAL,             // Wzorce behawioralne
    PATTERN_CORRELATION,            // Wzorce korelacji
    PATTERN_CYCLIC,                 // Wzorce cykliczne
    PATTERN_SEASONAL,               // Wzorce sezonowe
    PATTERN_TREND,                  // Wzorce trendów
    PATTERN_REVERSAL,               // Wzorce odwrócenia
    PATTERN_CONTINUATION,           // Wzorce kontynuacji
    PATTERN_CONSOLIDATION,          // Wzorce konsolidacji
    PATTERN_BREAKOUT,               // Wzorce wybicia
    PATTERN_ANOMALY,                // Wzorce anomalii
    PATTERN_COMPOSITE               // Wzorce złożone
};

// Typy świecowe
enum ENUM_CANDLESTICK_PATTERN {
    CANDLE_DOJI,                    // Doji
    CANDLE_HAMMER,                  // Młot
    CANDLE_HANGING_MAN,             // Wisielec
    CANDLE_SHOOTING_STAR,           // Spadająca gwiazda
    CANDLE_ENGULFING_BULLISH,       // Objęcie bycze
    CANDLE_ENGULFING_BEARISH,       // Objęcie niedźwiedzie
    CANDLE_MORNING_STAR,            // Gwiazda poranna
    CANDLE_EVENING_STAR,            // Gwiazda wieczorna
    CANDLE_THREE_WHITE_SOLDIERS,    // Trzej biali żołnierze
    CANDLE_THREE_BLACK_CROWS,       // Trzy czarne kruki
    CANDLE_HARAMI_BULLISH,          // Harami bycze
    CANDLE_HARAMI_BEARISH,          // Harami niedźwiedzie
    CANDLE_PIERCING,                // Przeniknięcie
    CANDLE_DARK_CLOUD_COVER,        // Ciemna chmura
    CANDLE_TRISTAR_BULLISH,         // Trójgwiazdka bycza
    CANDLE_TRISTAR_BEARISH,         // Trójgwiazdka niedźwiedzia
    CANDLE_ABANDONED_BABY_BULLISH,  // Porzucone dziecko bycze
    CANDLE_ABANDONED_BABY_BEARISH,  // Porzucone dziecko niedźwiedzie
    CANDLE_INSIDE_BAR,              // Pasek wewnętrzny
    CANDLE_OUTSIDE_BAR,             // Pasek zewnętrzny
    CANDLE_SPINNING_TOP,            // Bączek
    CANDLE_MARUBOZU,                // Marubozu
    CANDLE_UMBRELLA,                // Parasol
    CANDLE_GRAVESTONE,              // Nagrobek
    CANDLE_DRAGONFLY,               // Ważka
    CANDLE_LONG_LEGGED,             // Długonogi
    CANDLE_HIGH_WAVE,               // Wysoka fala
    CANDLE_TWEZERS_TOP,             // Pęseta szczytowa
    CANDLE_TWEZERS_BOTTOM,          // Pęseta denna
    CANDLE_UNKNOWN                  // Nieznany wzorzec
};

// Typy wzorców wykresowych
enum ENUM_CHART_PATTERN {
    CHART_HEAD_AND_SHOULDERS,       // Głowa i ramiona
    CHART_INVERSE_HEAD_SHOULDERS,   // Odwrócona głowa i ramiona
    CHART_DOUBLE_TOP,               // Podwójny szczyt
    CHART_DOUBLE_BOTTOM,            // Podwójne dno
    CHART_TRIPLE_TOP,               // Potrójny szczyt
    CHART_TRIPLE_BOTTOM,            // Potrójne dno
    CHART_ASCENDING_TRIANGLE,       // Trójkąt rosnący
    CHART_DESCENDING_TRIANGLE,      // Trójkąt malejący
    CHART_SYMMETRICAL_TRIANGLE,     // Trójkąt symetryczny
    CHART_WEDGE_RISING,             // Klin rosnący
    CHART_WEDGE_FALLING,            // Klin malejący
    CHART_RECTANGLE,                // Prostokąt
    CHART_FLAG_BULLISH,             // Flaga bycza
    CHART_FLAG_BEARISH,             // Flaga niedźwiedzia
    CHART_PENNANT_BULLISH,          // Chorągiewka bycza
    CHART_PENNANT_BEARISH,          // Chorągiewka niedźwiedzia
    CHART_CUP_AND_HANDLE,           // Kubek z uchwytem
    CHART_INVERSE_CUP_HANDLE,       // Odwrócony kubek z uchwytem
    CHART_DIAMOND,                  // Diament
    CHART_ROUNDING_BOTTOM,          // Zaokrąglone dno
    CHART_ROUNDING_TOP,             // Zaokrąglony szczyt
    CHART_CHANNEL_ASCENDING,        // Kanał rosnący
    CHART_CHANNEL_DESCENDING,       // Kanał malejący
    CHART_CHANNEL_HORIZONTAL,       // Kanał poziomy
    CHART_WEDGE_ASCENDING,          // Klin wznoszący
    CHART_WEDGE_DESCENDING,         // Klin opadający
    CHART_UNKNOWN                   // Nieznany wzorzec
};

// Typy wzorców technicznych
enum ENUM_TECHNICAL_PATTERN {
    TECHNICAL_SUPPORT_RESISTANCE,   // Wsparcie i opór
    TECHNICAL_TREND_LINE,           // Linia trendu
    TECHNICAL_CHANNEL,              // Kanał
    TECHNICAL_FIBONACCI,            // Wzorce Fibonacciego
    TECHNICAL_GANN,                 // Wzorce Ganna
    TECHNICAL_EWAVE,                // Fale Elliotta
    TECHNICAL_DIVERGENCE,           // Dywergencja
    TECHNICAL_CONVERGENCE,          // Konwergencja
    TECHNICAL_BREAKOUT,             // Wybicie
    TECHNICAL_BREAKDOWN,            // Załamanie
    TECHNICAL_GAP,                  // Luka
    TECHNICAL_ISLAND,               // Wyspa
    TECHNICAL_WEDGE,                // Klin
    TECHNICAL_TRIANGLE,             // Trójkąt
    TECHNICAL_RECTANGLE,            // Prostokąt
    TECHNICAL_DIAMOND,              // Diament
    TECHNICAL_FLAG,                 // Flaga
    TECHNICAL_PENNANT,              // Chorągiewka
    TECHNICAL_CUP,                  // Kubek
    TECHNICAL_SAUCER,               // Spodek
    TECHNICAL_ROUNDING,             // Zaokrąglenie
    TECHNICAL_SPIKE,                // Szpica
    TECHNICAL_PLATEAU,              // Płaskowyż
    TECHNICAL_UNKNOWN               // Nieznany wzorzec
};

// Typy wzorców cenowych
enum ENUM_PRICE_PATTERN {
    PRICE_UPTREND,                  // Trend wzrostowy
    PRICE_DOWNTREND,                // Trend spadkowy
    PRICE_SIDEWAYS,                 // Trend boczny
    PRICE_BREAKOUT_UP,              // Wybicie w górę
    PRICE_BREAKOUT_DOWN,            // Wybicie w dół
    PRICE_REVERSAL_UP,              // Odwrócenie w górę
    PRICE_REVERSAL_DOWN,            // Odwrócenie w dół
    PRICE_CONSOLIDATION,            // Konsolidacja
    PRICE_ACCELERATION,             // Przyspieszenie
    PRICE_DECELERATION,             // Zwolnienie
    PRICE_MOMENTUM,                 // Momentum
    PRICE_MEAN_REVERSION,           // Powrót do średniej
    PRICE_OVERBOUGHT,               // Przewartościowanie
    PRICE_OVERSOLD,                 // Niedowartościowanie
    PRICE_RANGE_BOUND,              // Zakres
    PRICE_VOLATILE,                 // Zmienność
    PRICE_STABLE,                   // Stabilność
    PRICE_UNKNOWN                   // Nieznany wzorzec
};

// Typy wzorców czasowych
enum ENUM_TIME_PATTERN {
    TIME_CYCLIC,                    // Cykliczny
    TIME_SEASONAL,                  // Sezonowy
    TIME_TREND,                     // Trend czasowy
    TIME_MEAN_REVERSION,            // Powrót do średniej czasowej
    TIME_MOMENTUM,                  // Momentum czasowe
    TIME_BREAKOUT,                  // Wybicie czasowe
    TIME_CONSOLIDATION,             // Konsolidacja czasowa
    TIME_ACCELERATION,              // Przyspieszenie czasowe
    TIME_DECELERATION,              // Zwolnienie czasowe
    TIME_PATTERN,                   // Wzorzec czasowy
    TIME_ANOMALY,                   // Anomalia czasowa
    TIME_UNKNOWN                    // Nieznany wzorzec
};

// Typy wzorców behawioralnych
enum ENUM_BEHAVIORAL_PATTERN {
    BEHAVIORAL_FOMO,                // Strach przed przegapieniem
    BEHAVIORAL_FEAR,                // Strach
    BEHAVIORAL_GREED,               // Chciwość
    BEHAVIORAL_PANIC,               // Panika
    BEHAVIORAL_EUPHORIA,            // Euforia
    BEHAVIORAL_COMPLACENCY,         // Samozadowolenie
    BEHAVIORAL_DENIAL,              // Zaprzeczenie
    BEHAVIORAL_ACCEPTANCE,          // Akceptacja
    BEHAVIORAL_HOPE,                // Nadzieja
    BEHAVIORAL_DESPAIR,             // Rozpacz
    BEHAVIORAL_OPTIMISM,            // Optymizm
    BEHAVIORAL_PESSIMISM,           // Pesymizm
    BEHAVIORAL_CONFIDENCE,          // Pewność siebie
    BEHAVIORAL_UNCERTAINTY,         // Niepewność
    BEHAVIORAL_MOMENTUM,            // Momentum behawioralne
    BEHAVIORAL_REVERSAL,            // Odwrócenie behawioralne
    BEHAVIORAL_UNKNOWN              // Nieznany wzorzec
};

// Typy algorytmów rozpoznawania
enum ENUM_RECOGNITION_ALGORITHM {
    RECOGNITION_TEMPLATE_MATCHING,  // Dopasowanie szablonów
    RECOGNITION_PATTERN_MATCHING,   // Dopasowanie wzorców
    RECOGNITION_MACHINE_LEARNING,   // Uczenie maszynowe
    RECOGNITION_NEURAL_NETWORK,     // Sieci neuronowe
    RECOGNITION_FUZZY_LOGIC,        // Logika rozmyta
    RECOGNITION_GENETIC_ALGORITHM,  // Algorytmy genetyczne
    RECOGNITION_SIGNAL_PROCESSING,  // Przetwarzanie sygnałów
    RECOGNITION_TIME_SERIES,        // Analiza szeregów czasowych
    RECOGNITION_STATISTICAL,        // Analiza statystyczna
    RECOGNITION_GEOMETRIC,          // Analiza geometryczna
    RECOGNITION_FRACTAL,            // Analiza fraktalna
    RECOGNITION_WAVELET,            // Analiza falkowa
    RECOGNITION_FOURIER,            // Analiza Fouriera
    RECOGNITION_CORRELATION,        // Analiza korelacji
    RECOGNITION_CLUSTERING,         // Klasteryzacja
    RECOGNITION_CLASSIFICATION,     // Klasyfikacja
    RECOGNITION_REGRESSION,         // Regresja
    RECOGNITION_ANOMALY_DETECTION,  // Wykrywanie anomalii
    RECOGNITION_PREDICTION,         // Predykcja
    RECOGNITION_OPTIMIZATION        // Optymalizacja
};

// Typy wiarygodności wzorców
enum ENUM_PATTERN_RELIABILITY {
    RELIABILITY_VERY_LOW,           // Bardzo niska (0-20%)
    RELIABILITY_LOW,                // Niska (20-40%)
    RELIABILITY_MEDIUM,             // Średnia (40-60%)
    RELIABILITY_HIGH,               // Wysoka (60-80%)
    RELIABILITY_VERY_HIGH,          // Bardzo wysoka (80-100%)
    RELIABILITY_UNKNOWN             // Nieznana
};

// Typy kierunków wzorców
enum ENUM_PATTERN_DIRECTION {
    DIRECTION_BULLISH,              // Byczy
    DIRECTION_BEARISH,              // Niedźwiedzi
    DIRECTION_NEUTRAL,              // Neutralny
    DIRECTION_MIXED,                // Mieszany
    DIRECTION_UNKNOWN               // Nieznany
};

// === STRUKTURY DANYCH ===

// Struktura danych świecy
struct SCandleData {
    double open;                    // Cena otwarcia
    double high;                    // Cena maksymalna
    double low;                     // Cena minimalna
    double close;                   // Cena zamknięcia
    long volume;                    // Wolumen
    datetime time;                  // Czas
    double body_size;               // Rozmiar korpusu
    double upper_shadow;            // Górny cień
    double lower_shadow;            // Dolny cień
    bool is_bullish;                // Czy bycza
    bool is_bearish;                // Czy niedźwiedzia
    double body_ratio;              // Stosunek korpusu do całej świecy
    double shadow_ratio;            // Stosunek cieni do całej świecy
};

// Struktura wzorca świecowego
struct SCandlestickPattern {
    ENUM_CANDLESTICK_PATTERN pattern_type; // Typ wzorca
    int start_index;                // Indeks początkowy
    int end_index;                  // Indeks końcowy
    double reliability;             // Wiarygodność (0-1)
    ENUM_PATTERN_DIRECTION direction; // Kierunek
    double strength;                // Siła wzorca
    string description;             // Opis wzorca
    datetime detection_time;        // Czas wykrycia
    double price_level;             // Poziom cenowy
    bool is_complete;               // Czy wzorzec jest kompletny
    bool is_confirmed;              // Czy wzorzec jest potwierdzony
    double target_price;            // Cena docelowa
    double stop_loss;               // Stop loss
    double risk_reward_ratio;       // Stosunek ryzyka do zysku
};

// Struktura wzorca wykresowego
struct SChartPattern {
    ENUM_CHART_PATTERN pattern_type; // Typ wzorca
    int start_index;                // Indeks początkowy
    int end_index;                  // Indeks końcowy
    double reliability;             // Wiarygodność (0-1)
    ENUM_PATTERN_DIRECTION direction; // Kierunek
    double strength;                // Siła wzorca
    string description;             // Opis wzorca
    datetime detection_time;        // Czas wykrycia
    double breakout_level;          // Poziom wybicia
    double target_price;            // Cena docelowa
    double stop_loss;               // Stop loss
    double risk_reward_ratio;       // Stosunek ryzyka do zysku
    bool is_complete;               // Czy wzorzec jest kompletny
    bool is_confirmed;              // Czy wzorzec jest potwierdzony
    double volume_confirmation;     // Potwierdzenie wolumenem
    double pattern_height;          // Wysokość wzorca
    double pattern_width;           // Szerokość wzorca
    double neckline_level;          // Poziom linii szyi (dla głowy i ramion)
    double resistance_level;        // Poziom oporu
    double support_level;           // Poziom wsparcia
};

// Struktura wzorca technicznego
struct STechnicalPattern {
    ENUM_TECHNICAL_PATTERN pattern_type; // Typ wzorca
    int start_index;                // Indeks początkowy
    int end_index;                  // Indeks końcowy
    double reliability;             // Wiarygodność (0-1)
    ENUM_PATTERN_DIRECTION direction; // Kierunek
    double strength;                // Siła wzorca
    string description;             // Opis wzorca
    datetime detection_time;        // Czas wykrycia
    double key_level;               // Kluczowy poziom
    double target_price;            // Cena docelowa
    double stop_loss;               // Stop loss
    double risk_reward_ratio;       // Stosunek ryzyka do zysku
    bool is_complete;               // Czy wzorzec jest kompletny
    bool is_confirmed;              // Czy wzorzec jest potwierdzony
    double fibonacci_levels[];      // Poziomy Fibonacciego
    double gann_levels[];           // Poziomy Ganna
    int ewave_count;                // Liczba fal Elliotta
    double divergence_strength;     // Siła dywergencji
    double convergence_strength;    // Siła konwergencji
};

// Struktura wzorca cenowego
struct SPricePattern {
    ENUM_PRICE_PATTERN pattern_type; // Typ wzorca
    int start_index;                // Indeks początkowy
    int end_index;                  // Indeks końcowy
    double reliability;             // Wiarygodność (0-1)
    ENUM_PATTERN_DIRECTION direction; // Kierunek
    double strength;                // Siła wzorca
    string description;             // Opis wzorca
    datetime detection_time;        // Czas wykrycia
    double trend_slope;             // Nachylenie trendu
    double momentum_value;          // Wartość momentum
    double volatility_level;        // Poziom zmienności
    double mean_reversion_strength; // Siła powrotu do średniej
    double overbought_level;        // Poziom przewartościowania
    double oversold_level;          // Poziom niedowartościowania
    double range_high;              // Górna granica zakresu
    double range_low;               // Dolna granica zakresu
    double acceleration_rate;       // Tempo przyspieszenia
    double deceleration_rate;       // Tempo zwolnienia
    bool is_stable;                 // Czy stabilny
    bool is_volatile;               // Czy zmienny
};

// Struktura wzorca czasowego
struct STimePattern {
    ENUM_TIME_PATTERN pattern_type; // Typ wzorca
    int start_index;                // Indeks początkowy
    int end_index;                  // Indeks końcowy
    double reliability;             // Wiarygodność (0-1)
    ENUM_PATTERN_DIRECTION direction; // Kierunek
    double strength;                // Siła wzorca
    string description;             // Opis wzorca
    datetime detection_time;        // Czas wykrycia
    int cycle_period;               // Okres cyklu
    double seasonal_strength;       // Siła sezonowości
    double trend_strength;          // Siła trendu czasowego
    double mean_reversion_strength; // Siła powrotu do średniej czasowej
    double momentum_strength;       // Siła momentum czasowego
    datetime breakout_time;         // Czas wybicia
    datetime consolidation_start;   // Początek konsolidacji
    datetime consolidation_end;     // Koniec konsolidacji
    double acceleration_rate;       // Tempo przyspieszenia czasowego
    double deceleration_rate;       // Tempo zwolnienia czasowego
    bool is_anomaly;                // Czy anomalia czasowa
    double anomaly_score;           // Skala anomalii czasowej
};

// Struktura wzorca behawioralnego
struct SBehavioralPattern {
    ENUM_BEHAVIORAL_PATTERN pattern_type; // Typ wzorca
    int start_index;                // Indeks początkowy
    int end_index;                  // Indeks końcowy
    double reliability;             // Wiarygodność (0-1)
    ENUM_PATTERN_DIRECTION direction; // Kierunek
    double strength;                // Siła wzorca
    string description;             // Opis wzorca
    datetime detection_time;        // Czas wykrycia
    double fear_level;              // Poziom strachu
    double greed_level;             // Poziom chciwości
    double panic_level;             // Poziom paniki
    double euphoria_level;          // Poziom euforii
    double confidence_level;        // Poziom pewności siebie
    double uncertainty_level;       // Poziom niepewności
    double optimism_level;          // Poziom optymizmu
    double pessimism_level;         // Poziom pesymizmu
    double fomo_strength;           // Siła FOMO
    double momentum_strength;       // Siła momentum behawioralnego
    double reversal_strength;       // Siła odwrócenia behawioralnego
    bool is_extreme;                // Czy ekstremalne
    double sentiment_score;         // Wynik sentymentu
};

// Struktura wyniku rozpoznawania
struct SPatternRecognitionResult {
    bool success;                   // Czy rozpoznanie się powiodło
    int patterns_found;             // Liczba znalezionych wzorców
    double total_reliability;       // Łączna wiarygodność
    ENUM_PATTERN_DIRECTION overall_direction; // Ogólny kierunek
    double overall_strength;        // Ogólna siła
    string summary;                 // Podsumowanie
    datetime analysis_time;         // Czas analizy
    double processing_time;         // Czas przetwarzania
    string error_message;           // Komunikat błędu
    SCandlestickPattern candlestick_patterns[]; // Wzorce świecowe
    SChartPattern chart_patterns[]; // Wzorce wykresowe
    STechnicalPattern technical_patterns[]; // Wzorce techniczne
    SPricePattern price_patterns[]; // Wzorce cenowe
    STimePattern time_patterns[];   // Wzorce czasowe
    SBehavioralPattern behavioral_patterns[]; // Wzorce behawioralne
};

// Struktura parametrów rozpoznawania
struct SPatternRecognitionParams {
    bool enable_candlestick_patterns; // Włącz wzorce świecowe
    bool enable_chart_patterns;     // Włącz wzorce wykresowe
    bool enable_technical_patterns; // Włącz wzorce techniczne
    bool enable_price_patterns;     // Włącz wzorce cenowe
    bool enable_time_patterns;      // Włącz wzorce czasowe
    bool enable_behavioral_patterns; // Włącz wzorce behawioralne
    double min_reliability;         // Minimalna wiarygodność
    double min_strength;            // Minimalna siła
    int min_pattern_length;         // Minimalna długość wzorca
    int max_pattern_length;         // Maksymalna długość wzorca
    bool require_confirmation;      // Wymagaj potwierdzenia
    bool use_volume_confirmation;   // Użyj potwierdzenia wolumenem
    bool use_momentum_confirmation; // Użyj potwierdzenia momentum
    bool use_trend_confirmation;    // Użyj potwierdzenia trendu
    double confirmation_threshold;  // Próg potwierdzenia
    bool enable_anomaly_detection;  // Włącz wykrywanie anomalii
    double anomaly_threshold;       // Próg anomalii
    bool enable_prediction;         // Włącz predykcję
    int prediction_horizon;         // Horyzont predykcji
    bool verbose;                   // Czy wyświetlać szczegóły
    string pattern_name;            // Nazwa wzorca
    datetime analysis_start_time;   // Czas rozpoczęcia analizy
};

// === KLASA GŁÓWNA PATTERN RECOGNITION ===

class CPatternRecognition {
private:
    // Parametry rozpoznawania
    SPatternRecognitionParams m_params;      // Parametry rozpoznawania
    SPatternRecognitionResult m_last_result; // Ostatni wynik
    
    // Dane historyczne
    SCandleData m_candles[];                 // Dane świecowe
    int m_candles_count;                     // Liczba świec
    double m_prices[];                       // Ceny
    long m_volumes[];                        // Wolumeny
    datetime m_times[];                      // Czasy
    
    // Cache i buforowanie
    bool m_data_loaded;                      // Czy dane są załadowane
    bool m_patterns_analyzed;                // Czy wzorce są przeanalizowane
    double m_analysis_time;                  // Czas analizy
    
    // Statystyki
    int m_total_patterns_found;              // Łączna liczba znalezionych wzorców
    int m_total_analyses;                    // Łączna liczba analiz
    double m_avg_analysis_time;              // Średni czas analizy
    double m_avg_reliability;                // Średnia wiarygodność
    
public:
    // Konstruktor i destruktor
    CPatternRecognition();
    ~CPatternRecognition();
    
    // Inicjalizacja i konfiguracja
    bool Initialize(SPatternRecognitionParams &params);
    bool LoadData(double &prices[], long &volumes[], datetime &times[]);
    bool SetParameters(SPatternRecognitionParams &params);
    SPatternRecognitionParams GetParameters();
    
    // Analiza wzorców świecowych
    bool AnalyzeCandlestickPatterns();
    bool DetectDoji(int index);
    bool DetectHammer(int index);
    bool DetectHangingMan(int index);
    bool DetectShootingStar(int index);
    bool DetectEngulfing(int index);
    bool DetectMorningStar(int index);
    bool DetectEveningStar(int index);
    bool DetectThreeWhiteSoldiers(int index);
    bool DetectThreeBlackCrows(int index);
    bool DetectHarami(int index);
    bool DetectPiercing(int index);
    bool DetectDarkCloudCover(int index);
    bool DetectTristar(int index);
    bool DetectAbandonedBaby(int index);
    bool DetectInsideBar(int index);
    bool DetectOutsideBar(int index);
    bool DetectSpinningTop(int index);
    bool DetectMarubozu(int index);
    bool DetectUmbrella(int index);
    bool DetectGravestone(int index);
    bool DetectDragonfly(int index);
    bool DetectLongLegged(int index);
    bool DetectHighWave(int index);
    bool DetectTweezers(int index);
    
    // Analiza wzorców wykresowych
    bool AnalyzeChartPatterns();
    bool DetectHeadAndShoulders(int start_index, int end_index);
    bool DetectDoubleTop(int start_index, int end_index);
    bool DetectDoubleBottom(int start_index, int end_index);
    bool DetectTripleTop(int start_index, int end_index);
    bool DetectTripleBottom(int start_index, int end_index);
    bool DetectTriangle(int start_index, int end_index);
    bool DetectWedge(int start_index, int end_index);
    bool DetectRectangle(int start_index, int end_index);
    bool DetectFlag(int start_index, int end_index);
    bool DetectPennant(int start_index, int end_index);
    bool DetectCupAndHandle(int start_index, int end_index);
    bool DetectDiamond(int start_index, int end_index);
    bool DetectRounding(int start_index, int end_index);
    bool DetectChannel(int start_index, int end_index);
    
    // Analiza wzorców technicznych
    bool AnalyzeTechnicalPatterns();
    bool DetectSupportResistance(int index);
    bool DetectTrendLine(int start_index, int end_index);
    bool DetectFibonacci(int start_index, int end_index);
    bool DetectGann(int start_index, int end_index);
    bool DetectEWave(int start_index, int end_index);
    bool DetectDivergence(int start_index, int end_index);
    bool DetectConvergence(int start_index, int end_index);
    bool DetectBreakout(int index);
    bool DetectBreakdown(int index);
    bool DetectGap(int index);
    bool DetectIsland(int start_index, int end_index);
    
    // Analiza wzorców cenowych
    bool AnalyzePricePatterns();
    bool DetectTrend(int start_index, int end_index);
    bool DetectReversal(int index);
    bool DetectConsolidation(int start_index, int end_index);
    bool DetectAcceleration(int index);
    bool DetectDeceleration(int index);
    bool DetectMomentum(int index);
    bool DetectMeanReversion(int index);
    bool DetectOverbought(int index);
    bool DetectOversold(int index);
    bool DetectRange(int start_index, int end_index);
    bool DetectVolatility(int index);
    bool DetectStability(int start_index, int end_index);
    
    // Analiza wzorców czasowych
    bool AnalyzeTimePatterns();
    bool DetectCyclic(int start_index, int end_index);
    bool DetectSeasonal(int start_index, int end_index);
    bool DetectTimeTrend(int start_index, int end_index);
    bool DetectTimeMeanReversion(int index);
    bool DetectTimeMomentum(int index);
    bool DetectTimeBreakout(int index);
    bool DetectTimeConsolidation(int start_index, int end_index);
    bool DetectTimeAcceleration(int index);
    bool DetectTimeDeceleration(int index);
    bool DetectTimePattern(int start_index, int end_index);
    bool DetectTimeAnomaly(int index);
    
    // Analiza wzorców behawioralnych
    bool AnalyzeBehavioralPatterns();
    bool DetectFOMO(int index);
    bool DetectFear(int index);
    bool DetectGreed(int index);
    bool DetectPanic(int index);
    bool DetectEuphoria(int index);
    bool DetectComplacency(int index);
    bool DetectDenial(int index);
    bool DetectAcceptance(int index);
    bool DetectHope(int index);
    bool DetectDespair(int index);
    bool DetectOptimism(int index);
    bool DetectPessimism(int index);
    bool DetectConfidence(int index);
    bool DetectUncertainty(int index);
    bool DetectBehavioralMomentum(int index);
    bool DetectBehavioralReversal(int index);
    
    // Główne funkcje rozpoznawania
    SPatternRecognitionResult RecognizePatterns();
    SPatternRecognitionResult RecognizePatterns(int start_index, int end_index);
    bool ValidatePattern(SCandlestickPattern &pattern);
    bool ValidatePattern(SChartPattern &pattern);
    bool ValidatePattern(STechnicalPattern &pattern);
    bool ValidatePattern(SPricePattern &pattern);
    bool ValidatePattern(STimePattern &pattern);
    bool ValidatePattern(SBehavioralPattern &pattern);
    
    // Funkcje pomocnicze
    double CalculateReliability(SCandlestickPattern &pattern);
    double CalculateReliability(SChartPattern &pattern);
    double CalculateReliability(STechnicalPattern &pattern);
    double CalculateReliability(SPricePattern &pattern);
    double CalculateReliability(STimePattern &pattern);
    double CalculateReliability(SBehavioralPattern &pattern);
    
    double CalculateStrength(SCandlestickPattern &pattern);
    double CalculateStrength(SChartPattern &pattern);
    double CalculateStrength(STechnicalPattern &pattern);
    double CalculateStrength(SPricePattern &pattern);
    double CalculateStrength(STimePattern &pattern);
    double CalculateStrength(SBehavioralPattern &pattern);
    
    ENUM_PATTERN_DIRECTION DetermineDirection(SCandlestickPattern &pattern);
    ENUM_PATTERN_DIRECTION DetermineDirection(SChartPattern &pattern);
    ENUM_PATTERN_DIRECTION DetermineDirection(STechnicalPattern &pattern);
    ENUM_PATTERN_DIRECTION DetermineDirection(SPricePattern &pattern);
    ENUM_PATTERN_DIRECTION DetermineDirection(STimePattern &pattern);
    ENUM_PATTERN_DIRECTION DetermineDirection(SBehavioralPattern &pattern);
    
    // Funkcje predykcji
    double PredictTargetPrice(SCandlestickPattern &pattern);
    double PredictTargetPrice(SChartPattern &pattern);
    double PredictTargetPrice(STechnicalPattern &pattern);
    double PredictTargetPrice(SPricePattern &pattern);
    double PredictTargetPrice(STimePattern &pattern);
    double PredictTargetPrice(SBehavioralPattern &pattern);
    
    double PredictStopLoss(SCandlestickPattern &pattern);
    double PredictStopLoss(SChartPattern &pattern);
    double PredictStopLoss(STechnicalPattern &pattern);
    double PredictStopLoss(SPricePattern &pattern);
    double PredictStopLoss(STimePattern &pattern);
    double PredictStopLoss(SBehavioralPattern &pattern);
    
    double CalculateRiskRewardRatio(SCandlestickPattern &pattern);
    double CalculateRiskRewardRatio(SChartPattern &pattern);
    double CalculateRiskRewardRatio(STechnicalPattern &pattern);
    double CalculateRiskRewardRatio(SPricePattern &pattern);
    double CalculateRiskRewardRatio(STimePattern &pattern);
    double CalculateRiskRewardRatio(SBehavioralPattern &pattern);
    
    // Funkcje potwierdzenia
    bool ConfirmPattern(SCandlestickPattern &pattern);
    bool ConfirmPattern(SChartPattern &pattern);
    bool ConfirmPattern(STechnicalPattern &pattern);
    bool ConfirmPattern(SPricePattern &pattern);
    bool ConfirmPattern(STimePattern &pattern);
    bool ConfirmPattern(SBehavioralPattern &pattern);
    
    bool ConfirmWithVolume(SCandlestickPattern &pattern);
    bool ConfirmWithVolume(SChartPattern &pattern);
    bool ConfirmWithVolume(STechnicalPattern &pattern);
    bool ConfirmWithVolume(SPricePattern &pattern);
    bool ConfirmWithVolume(STimePattern &pattern);
    bool ConfirmWithVolume(SBehavioralPattern &pattern);
    
    bool ConfirmWithMomentum(SCandlestickPattern &pattern);
    bool ConfirmWithMomentum(SChartPattern &pattern);
    bool ConfirmWithMomentum(STechnicalPattern &pattern);
    bool ConfirmWithMomentum(SPricePattern &pattern);
    bool ConfirmWithMomentum(STimePattern &pattern);
    bool ConfirmWithMomentum(SBehavioralPattern &pattern);
    
    bool ConfirmWithTrend(SCandlestickPattern &pattern);
    bool ConfirmWithTrend(SChartPattern &pattern);
    bool ConfirmWithTrend(STechnicalPattern &pattern);
    bool ConfirmWithTrend(SPricePattern &pattern);
    bool ConfirmWithTrend(STimePattern &pattern);
    bool ConfirmWithTrend(SBehavioralPattern &pattern);
    
    // Funkcje raportowania
    string GeneratePatternReport();
    string GenerateCandlestickReport();
    string GenerateChartReport();
    string GenerateTechnicalReport();
    string GeneratePriceReport();
    string GenerateTimeReport();
    string GenerateBehavioralReport();
    string GenerateSummaryReport();
    
    // Funkcje eksportu
    bool ExportPatternsToCSV(string filename);
    bool ExportPatternsToJSON(string filename);
    bool ExportPatternsToXML(string filename);
    
    // Funkcje pomocnicze
    bool IsDataLoaded();
    int GetCandlesCount();
    int GetTotalPatternsFound();
    int GetTotalAnalyses();
    double GetAverageAnalysisTime();
    double GetAverageReliability();
    double GetAnalysisTime();
    SPatternRecognitionResult GetLastResult();
    
    // Czyszczenie i reset
    void ClearData();
    void ClearPatterns();
    void ResetStatistics();
    void Cleanup();
    
private:
    // Funkcje pomocnicze
    bool ValidateInput(int start_index, int end_index);
    void UpdateStatistics(double analysis_time);
    string FormatTime(double seconds);
    double GenerateRandomDouble(double min, double max);
    int GenerateRandomInteger(int min, int max);
    double CalculateDistance(double &point1[], double &point2[]);
    double CalculateSimilarity(double &point1[], double &point2[]);
    bool IsAnomaly(double &data[], double threshold);
    string GenerateExplanation(SCandlestickPattern &pattern);
    string GenerateExplanation(SChartPattern &pattern);
    string GenerateExplanation(STechnicalPattern &pattern);
    string GenerateExplanation(SPricePattern &pattern);
    string GenerateExplanation(STimePattern &pattern);
    string GenerateExplanation(SBehavioralPattern &pattern);
};

// === IMPLEMENTACJA PODSTAWOWYCH FUNKCJI ===

// Konstruktor
CPatternRecognition::CPatternRecognition() {
    m_candles_count = 0;
    m_data_loaded = false;
    m_patterns_analyzed = false;
    m_analysis_time = 0.0;
    m_total_patterns_found = 0;
    m_total_analyses = 0;
    m_avg_analysis_time = 0.0;
    m_avg_reliability = 0.0;
    
    // Inicjalizacja parametrów domyślnych
    m_params.enable_candlestick_patterns = true;
    m_params.enable_chart_patterns = true;
    m_params.enable_technical_patterns = true;
    m_params.enable_price_patterns = true;
    m_params.enable_time_patterns = true;
    m_params.enable_behavioral_patterns = true;
    m_params.min_reliability = 0.6;
    m_params.min_strength = 0.5;
    m_params.min_pattern_length = 3;
    m_params.max_pattern_length = 50;
    m_params.require_confirmation = true;
    m_params.use_volume_confirmation = true;
    m_params.use_momentum_confirmation = true;
    m_params.use_trend_confirmation = true;
    m_params.confirmation_threshold = 0.7;
    m_params.enable_anomaly_detection = true;
    m_params.anomaly_threshold = 2.0;
    m_params.enable_prediction = true;
    m_params.prediction_horizon = 10;
    m_params.verbose = true;
    m_params.pattern_name = "PatternRecognition";
    m_params.analysis_start_time = TimeCurrent();
}

// Destruktor
CPatternRecognition::~CPatternRecognition() {
    Cleanup();
}

// Inicjalizacja
bool CPatternRecognition::Initialize(SPatternRecognitionParams &params) {
    m_params = params;
    m_data_loaded = false;
    m_patterns_analyzed = false;
    m_total_patterns_found = 0;
    m_total_analyses = 0;
    m_avg_analysis_time = 0.0;
    m_avg_reliability = 0.0;
    
    return true;
}

// Wczytanie danych
bool CPatternRecognition::LoadData(double &prices[], long &volumes[], datetime &times[]) {
    if(ArraySize(prices) <= 0 || ArraySize(volumes) <= 0 || ArraySize(times) <= 0) {
        return false;
    }
    
    int size = MathMin(MathMin(ArraySize(prices), ArraySize(volumes)), ArraySize(times));
    if(size <= 0) return false;
    
    // Alokacja pamięci
    ArrayResize(m_candles, size);
    ArrayResize(m_prices, size);
    ArrayResize(m_volumes, size);
    ArrayResize(m_times, size);
    
    // Kopiowanie danych
    for(int i = 0; i < size; i++) {
        m_prices[i] = prices[i];
        m_volumes[i] = volumes[i];
        m_times[i] = times[i];
        
        // Przygotowanie danych świecowych (uproszczone - zakładamy OHLC)
        m_candles[i].open = prices[i];
        m_candles[i].high = prices[i];
        m_candles[i].low = prices[i];
        m_candles[i].close = prices[i];
        m_candles[i].volume = volumes[i];
        m_candles[i].time = times[i];
        
        // Obliczenie parametrów świecy
        m_candles[i].body_size = MathAbs(m_candles[i].close - m_candles[i].open);
        m_candles[i].upper_shadow = m_candles[i].high - MathMax(m_candles[i].open, m_candles[i].close);
        m_candles[i].lower_shadow = MathMin(m_candles[i].open, m_candles[i].close) - m_candles[i].low;
        m_candles[i].is_bullish = m_candles[i].close > m_candles[i].open;
        m_candles[i].is_bearish = m_candles[i].close < m_candles[i].open;
        
        double total_range = m_candles[i].high - m_candles[i].low;
        if(total_range > 0) {
            m_candles[i].body_ratio = m_candles[i].body_size / total_range;
            m_candles[i].shadow_ratio = (m_candles[i].upper_shadow + m_candles[i].lower_shadow) / total_range;
        } else {
            m_candles[i].body_ratio = 0.0;
            m_candles[i].shadow_ratio = 0.0;
        }
    }
    
    m_candles_count = size;
    m_data_loaded = true;
    
    return true;
}

// Główna funkcja rozpoznawania wzorców
SPatternRecognitionResult CPatternRecognition::RecognizePatterns() {
    SPatternRecognitionResult result;
    result.success = false;
    result.patterns_found = 0;
    result.total_reliability = 0.0;
    result.overall_direction = DIRECTION_UNKNOWN;
    result.overall_strength = 0.0;
    result.summary = "";
    result.analysis_time = TimeCurrent();
    result.processing_time = 0.0;
    result.error_message = "";
    
    if(!IsDataLoaded()) {
        result.error_message = "Brak załadowanych danych";
        return result;
    }
    
    datetime start_time = TimeCurrent();
    
    // Analiza wzorców świecowych
    if(m_params.enable_candlestick_patterns) {
        if(AnalyzeCandlestickPatterns()) {
            result.patterns_found += ArraySize(result.candlestick_patterns);
        }
    }
    
    // Analiza wzorców wykresowych
    if(m_params.enable_chart_patterns) {
        if(AnalyzeChartPatterns()) {
            result.patterns_found += ArraySize(result.chart_patterns);
        }
    }
    
    // Analiza wzorców technicznych
    if(m_params.enable_technical_patterns) {
        if(AnalyzeTechnicalPatterns()) {
            result.patterns_found += ArraySize(result.technical_patterns);
        }
    }
    
    // Analiza wzorców cenowych
    if(m_params.enable_price_patterns) {
        if(AnalyzePricePatterns()) {
            result.patterns_found += ArraySize(result.price_patterns);
        }
    }
    
    // Analiza wzorców czasowych
    if(m_params.enable_time_patterns) {
        if(AnalyzeTimePatterns()) {
            result.patterns_found += ArraySize(result.time_patterns);
        }
    }
    
    // Analiza wzorców behawioralnych
    if(m_params.enable_behavioral_patterns) {
        if(AnalyzeBehavioralPatterns()) {
            result.patterns_found += ArraySize(result.behavioral_patterns);
        }
    }
    
    result.processing_time = (double)(TimeCurrent() - start_time);
    result.success = true;
    
    // Obliczenie ogólnych statystyk
    if(result.patterns_found > 0) {
        result.total_reliability = m_avg_reliability;
        result.overall_strength = m_avg_reliability; // Uproszczone
        result.overall_direction = DIRECTION_MIXED; // Uproszczone
        result.summary = "Znaleziono " + IntegerToString(result.patterns_found) + " wzorców";
    } else {
        result.summary = "Nie znaleziono wzorców";
    }
    
    m_last_result = result;
    m_patterns_analyzed = true;
    m_analysis_time = result.processing_time;
    UpdateStatistics(result.processing_time);
    
    return result;
}

// Analiza wzorców świecowych
bool CPatternRecognition::AnalyzeCandlestickPatterns() {
    if(!IsDataLoaded()) return false;
    
    // Implementacja wykrywania wzorców świecowych
    // To jest uproszczona implementacja - w rzeczywistości wymaga bardziej zaawansowanych algorytmów
    
    for(int i = 2; i < m_candles_count - 2; i++) {
        // Wykrywanie Doji
        if(DetectDoji(i)) {
            // Dodaj wzorzec do wyników
        }
        
        // Wykrywanie Hammer
        if(DetectHammer(i)) {
            // Dodaj wzorzec do wyników
        }
        
        // Wykrywanie Shooting Star
        if(DetectShootingStar(i)) {
            // Dodaj wzorzec do wyników
        }
        
        // Wykrywanie Engulfing
        if(DetectEngulfing(i)) {
            // Dodaj wzorzec do wyników
        }
        
        // Wykrywanie Morning Star
        if(DetectMorningStar(i)) {
            // Dodaj wzorzec do wyników
        }
        
        // Wykrywanie Evening Star
        if(DetectEveningStar(i)) {
            // Dodaj wzorzec do wyników
        }
    }
    
    return true;
}

// Wykrywanie Doji
bool CPatternRecognition::DetectDoji(int index) {
    if(index < 0 || index >= m_candles_count) return false;
    
    SCandleData candle = m_candles[index];
    
    // Doji - bardzo mały korpus w porównaniu do całego zakresu
    double total_range = candle.high - candle.low;
    if(total_range > 0) {
        double body_ratio = candle.body_size / total_range;
        return body_ratio < 0.1; // Korpus mniejszy niż 10% całego zakresu
    }
    
    return false;
}

// Wykrywanie Hammer
bool CPatternRecognition::DetectHammer(int index) {
    if(index < 0 || index >= m_candles_count) return false;
    
    SCandleData candle = m_candles[index];
    
    // Hammer - mały korpus na górze, długi dolny cień
    double total_range = candle.high - candle.low;
    if(total_range > 0) {
        double body_ratio = candle.body_size / total_range;
        double lower_shadow_ratio = candle.lower_shadow / total_range;
        
        return body_ratio < 0.3 && lower_shadow_ratio > 0.6 && candle.upper_shadow < candle.body_size * 0.1;
    }
    
    return false;
}

// Wykrywanie Shooting Star
bool CPatternRecognition::DetectShootingStar(int index) {
    if(index < 0 || index >= m_candles_count) return false;
    
    SCandleData candle = m_candles[index];
    
    // Shooting Star - mały korpus na dole, długi górny cień
    double total_range = candle.high - candle.low;
    if(total_range > 0) {
        double body_ratio = candle.body_size / total_range;
        double upper_shadow_ratio = candle.upper_shadow / total_range;
        
        return body_ratio < 0.3 && upper_shadow_ratio > 0.6 && candle.lower_shadow < candle.body_size * 0.1;
    }
    
    return false;
}

// Wykrywanie Engulfing
bool CPatternRecognition::DetectEngulfing(int index) {
    if(index < 1 || index >= m_candles_count) return false;
    
    SCandleData current = m_candles[index];
    SCandleData previous = m_candles[index - 1];
    
    // Bullish Engulfing
    if(current.is_bullish && previous.is_bearish) {
        return current.open < previous.close && current.close > previous.open;
    }
    
    // Bearish Engulfing
    if(current.is_bearish && previous.is_bullish) {
        return current.open > previous.close && current.close < previous.open;
    }
    
    return false;
}

// Wykrywanie Morning Star
bool CPatternRecognition::DetectMorningStar(int index) {
    if(index < 2 || index >= m_candles_count) return false;
    
    SCandleData first = m_candles[index - 2];
    SCandleData second = m_candles[index - 1];
    SCandleData third = m_candles[index];
    
    // Morning Star: niedźwiedzia świeca, mała świeca (doji), bycza świeca
    return first.is_bearish && 
           MathAbs(second.close - second.open) < (second.high - second.low) * 0.1 && // Doji
           third.is_bullish &&
           third.close > (first.open + first.close) / 2; // Zamknięcie powyżej połowy pierwszej świecy
}

// Wykrywanie Evening Star
bool CPatternRecognition::DetectEveningStar(int index) {
    if(index < 2 || index >= m_candles_count) return false;
    
    SCandleData first = m_candles[index - 2];
    SCandleData second = m_candles[index - 1];
    SCandleData third = m_candles[index];
    
    // Evening Star: bycza świeca, mała świeca (doji), niedźwiedzia świeca
    return first.is_bullish && 
           MathAbs(second.close - second.open) < (second.high - second.low) * 0.1 && // Doji
           third.is_bearish &&
           third.close < (first.open + first.close) / 2; // Zamknięcie poniżej połowy pierwszej świecy
}

// Funkcje pomocnicze
bool CPatternRecognition::IsDataLoaded() {
    return m_data_loaded && m_candles_count > 0;
}

int CPatternRecognition::GetCandlesCount() {
    return m_candles_count;
}

int CPatternRecognition::GetTotalPatternsFound() {
    return m_total_patterns_found;
}

int CPatternRecognition::GetTotalAnalyses() {
    return m_total_analyses;
}

double CPatternRecognition::GetAverageAnalysisTime() {
    return m_avg_analysis_time;
}

double CPatternRecognition::GetAverageReliability() {
    return m_avg_reliability;
}

double CPatternRecognition::GetAnalysisTime() {
    return m_analysis_time;
}

SPatternRecognitionResult CPatternRecognition::GetLastResult() {
    return m_last_result;
}

void CPatternRecognition::UpdateStatistics(double analysis_time) {
    m_total_analyses++;
    m_avg_analysis_time = (m_avg_analysis_time * (m_total_analyses - 1) + analysis_time) / m_total_analyses;
}

string CPatternRecognition::FormatTime(double seconds) {
    if(seconds < 60) {
        return DoubleToString(seconds, 2) + "s";
    } else if(seconds < 3600) {
        return DoubleToString(seconds / 60, 2) + "m";
    } else {
        return DoubleToString(seconds / 3600, 2) + "h";
    }
}

double CPatternRecognition::GenerateRandomDouble(double min, double max) {
    return min + (max - min) * ((double)MathRand() / 32767.0);
}

int CPatternRecognition::GenerateRandomInteger(int min, int max) {
    return min + (int)((max - min + 1) * ((double)MathRand() / 32768.0));
}

void CPatternRecognition::Cleanup() {
    ArrayFree(m_candles);
    ArrayFree(m_prices);
    ArrayFree(m_volumes);
    ArrayFree(m_times);
    
    m_candles_count = 0;
    m_data_loaded = false;
    m_patterns_analyzed = false;
    m_analysis_time = 0.0;
    m_total_patterns_found = 0;
    m_total_analyses = 0;
    m_avg_analysis_time = 0.0;
    m_avg_reliability = 0.0;
}

// Stałe dla Pattern Recognition
#define PATTERN_RECOGNITION_VERSION "1.0.0"
#define PATTERN_RECOGNITION_AUTHOR "System Böhmego"
#define PATTERN_RECOGNITION_DESCRIPTION "Zaawansowane rozpoznawanie wzorców"

#endif
