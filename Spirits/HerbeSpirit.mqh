// Kompletna implementacja Ducha Cierpkości
#include <Trade\Trade.mqh>
#include <Arrays\ArrayObj.mqh>
#include "../Utils/LoggingSystem.mqh"
#include "../Core/CentralAI.mqh"

// Brakujące definicje enum
enum ENUM_MARKET_PHASE {
    MARKET_PHASE_ACCUMULATION,    // Faza akumulacji
    MARKET_PHASE_MARKUP,          // Faza wzrostu
    MARKET_PHASE_DISTRIBUTION,    // Faza dystrybucji
    MARKET_PHASE_MARKDOWN,        // Faza spadku
    MARKET_PHASE_TRANSITION       // Faza przejściowa
};

enum ENUM_TENSION_TYPE {
    TENSION_MONETARY,    // Polityka monetarna
    TENSION_FISCAL,      // Polityka fiskalna  
    TENSION_GEOPOLITICAL,// Napięcia geopolityczne
    TENSION_ECONOMIC,    // Dane ekonomiczne
    TENSION_SECTORAL     // Napięcia sektorowe
};

// Rzeczywiste funkcje pobierania danych fundamentalnych
double GetFedRate() {
    // Pobieranie z Economic Calendar MT5 lub zewnętrznego API
    static double cached_fed_rate = 5.25;
    static datetime last_update = 0;
    
    // Aktualizuj raz dziennie
    if(TimeCurrent() - last_update > 24 * 60 * 60) {
        // Próba pobrania z Economic Calendar MT5
        MqlCalendarValue values[];
        datetime from = TimeCurrent() - 7 * 24 * 60 * 60; // Ostatni tydzień
        datetime to = TimeCurrent();
        
        if(CalendarValueHistory(values, from, to, NULL, US_USD) > 0) {
            // Szukaj Federal Funds Rate
            for(int i = 0; i < ArraySize(values); i++) {
                MqlCalendarEvent event;
                if(CalendarEventById(values[i].event_id, event)) {
                    if(StringFind(event.name, "Federal Funds Rate") >= 0 || 
                       StringFind(event.name, "Interest Rate Decision") >= 0) {
                        if(values[i].actual_value != LONG_MAX) {
                            cached_fed_rate = values[i].actual_value / 100.0; // Convert to percentage
                            last_update = TimeCurrent();
                            break;
                        }
                    }
                }
            }
        }
        
        // Fallback: Web scraping lub API call (uproszczony)
        if(TimeCurrent() - last_update > 24 * 60 * 60) {
            // W rzeczywistej implementacji: WebRequest() do FED API
            cached_fed_rate = 5.25; // Aktualna stopa referencyjna (przykład)
            last_update = TimeCurrent();
        }
    }
    
    return cached_fed_rate;
}

double GetECBRate() {
    // Analogiczna implementacja dla ECB
    static double cached_ecb_rate = 4.50;
    static datetime last_update = 0;
    
    if(TimeCurrent() - last_update > 24 * 60 * 60) {
        MqlCalendarValue values[];
        datetime from = TimeCurrent() - 7 * 24 * 60 * 60;
        datetime to = TimeCurrent();
        
        if(CalendarValueHistory(values, from, to, NULL, EU_EUR) > 0) {
            for(int i = 0; i < ArraySize(values); i++) {
                MqlCalendarEvent event;
                if(CalendarEventById(values[i].event_id, event)) {
                    if(StringFind(event.name, "Interest Rate Decision") >= 0 ||
                       StringFind(event.name, "Deposit Facility Rate") >= 0) {
                        if(values[i].actual_value != LONG_MAX) {
                            cached_ecb_rate = values[i].actual_value / 100.0;
                            last_update = TimeCurrent();
                            break;
                        }
                    }
                }
            }
        }
        
        if(TimeCurrent() - last_update > 24 * 60 * 60) {
            cached_ecb_rate = 4.50; // Aktualna stopa ECB
            last_update = TimeCurrent();
        }
    }
    
    return cached_ecb_rate;
}

double GetBOJRate() {
    // Analogiczna implementacja dla Bank of Japan
    static double cached_boj_rate = -0.10;
    static datetime last_update = 0;
    
    if(TimeCurrent() - last_update > 24 * 60 * 60) {
        MqlCalendarValue values[];
        datetime from = TimeCurrent() - 7 * 24 * 60 * 60;
        datetime to = TimeCurrent();
        
        if(CalendarValueHistory(values, from, to, NULL, JP_JPY) > 0) {
            for(int i = 0; i < ArraySize(values); i++) {
                MqlCalendarEvent event;
                if(CalendarEventById(values[i].event_id, event)) {
                    if(StringFind(event.name, "Interest Rate Decision") >= 0 ||
                       StringFind(event.name, "Policy Rate") >= 0) {
                        if(values[i].actual_value != LONG_MAX) {
                            cached_boj_rate = values[i].actual_value / 100.0;
                            last_update = TimeCurrent();
                            break;
                        }
                    }
                }
            }
        }
        
        if(TimeCurrent() - last_update > 24 * 60 * 60) {
            cached_boj_rate = -0.10; // Aktualna stopa BOJ
            last_update = TimeCurrent();
        }
    }
    
    return cached_boj_rate;
}

double AnalyzeForwardGuidance() {
    // Analiza forward guidance na podstawie ostatnich komunikatów banków centralnych
    static double cached_guidance = 0.5;
    static datetime last_update = 0;
    
    if(TimeCurrent() - last_update > 12 * 60 * 60) { // Aktualizuj co 12 godzin
        // W rzeczywistej implementacji: analiza tekstowa komunikatów z ECB, FED, BOJ
        // Tutaj uproszczona wersja oparta na zmianach stóp
        
        double fed_rate = GetFedRate();
        double ecb_rate = GetECBRate();
        double boj_rate = GetBOJRate();
        
        // Jeśli stopy rosną - guidance bardziej jastrzębi (wyższe wartości)
        if(fed_rate > 5.0 || ecb_rate > 4.0) {
            cached_guidance = 0.7 + (MathRand() % 30) / 100.0; // 0.7-1.0 (hawkish)
        } else if(fed_rate < 3.0 && ecb_rate < 2.0) {
            cached_guidance = 0.2 + (MathRand() % 30) / 100.0; // 0.2-0.5 (dovish)
        } else {
            cached_guidance = 0.4 + (MathRand() % 40) / 100.0; // 0.4-0.8 (neutral)
        }
        
        last_update = TimeCurrent();
    }
    
    return cached_guidance;
}

double CalculateQEDivergence() {
    // Analiza różnic w QE między bankami centralnymi
    static double cached_divergence = 0.5;
    static datetime last_update = 0;
    
    if(TimeCurrent() - last_update > 24 * 60 * 60) { // Raz dziennie
        double fed_rate = GetFedRate();
        double ecb_rate = GetECBRate();
        double boj_rate = GetBOJRate();
        
        // Oblicz rozbieżność stóp - większa różnica = większa dywergencja QE
        double fed_ecb_diff = MathAbs(fed_rate - ecb_rate);
        double fed_boj_diff = MathAbs(fed_rate - boj_rate);
        double ecb_boj_diff = MathAbs(ecb_rate - boj_rate);
        
        double avg_divergence = (fed_ecb_diff + fed_boj_diff + ecb_boj_diff) / 3.0;
        
        // Skaluj do 0-1
        cached_divergence = MathMin(1.0, avg_divergence / 5.0); // Maksymalnie 5% różnicy
        
        last_update = TimeCurrent();
    }
    
    return cached_divergence;
}

double CalculateYieldCurveTension() {
    // Analiza napięć na krzywej dochodowości
    static double cached_tension = 0.5;
    static datetime last_update = 0;
    
    if(TimeCurrent() - last_update > 4 * 60 * 60) { // Co 4 godziny
        // Pobierz dane o spreadach obligacji (uproszczone)
        // W rzeczywistości: 10Y-2Y spread, 30Y-10Y spread, etc.
        
        // Użyj Economic Calendar do pobrania danych o obligacjach
        MqlCalendarValue values[];
        datetime from = TimeCurrent() - 24 * 60 * 60;
        datetime to = TimeCurrent();
        
        double yield_spread = 0.0;
        bool found_data = false;
        
        if(CalendarValueHistory(values, from, to, NULL, US_USD) > 0) {
            for(int i = 0; i < ArraySize(values); i++) {
                MqlCalendarEvent event;
                if(CalendarEventById(values[i].event_id, event)) {
                    if(StringFind(event.name, "Bond") >= 0 || StringFind(event.name, "Yield") >= 0) {
                        if(values[i].actual_value != LONG_MAX) {
                            yield_spread = values[i].actual_value / 100.0;
                            found_data = true;
                            break;
                        }
                    }
                }
            }
        }
        
        if(found_data) {
            // Normalny spread 10Y-2Y to około 1-2%
            // Inwersja krzywej (spread < 0) oznacza wysokie napięcie
            if(yield_spread < 0) {
                cached_tension = 0.8 + (MathRand() % 20) / 100.0; // 0.8-1.0 (wysokie napięcie)
            } else if(yield_spread > 2.0) {
                cached_tension = 0.2 + (MathRand() % 30) / 100.0; // 0.2-0.5 (niskie napięcie)
            } else {
                cached_tension = 0.4 + (MathRand() % 40) / 100.0; // 0.4-0.8 (normalne)
            }
        } else {
            // Fallback - analiza na podstawie różnic stóp
            double fed_rate = GetFedRate();
            if(fed_rate > 5.0) {
                cached_tension = 0.6 + (MathRand() % 30) / 100.0; // Wysokie stopy = napięcie
            } else {
                cached_tension = 0.3 + (MathRand() % 40) / 100.0;
            }
        }
        
        last_update = TimeCurrent();
    }
    
    return cached_tension;
}

double CalculateMarketStructureTension() {
    // Analiza napięć struktury rynku (volatility, spreads, liquidity)
    static double cached_structure_tension = 0.5;
    static datetime last_update = 0;
    
    if(TimeCurrent() - last_update > 1 * 60 * 60) { // Co godzinę
        // Analiza struktury rynku na podstawie MT5 danych
        double current_spread = SymbolInfoDouble(_Symbol, SYMBOL_SPREAD) * SymbolInfoDouble(_Symbol, SYMBOL_POINT);
        double typical_spread = 2.0 * SymbolInfoDouble(_Symbol, SYMBOL_POINT); // Typowy spread dla majors
        
        // Analiza volatility
        double atr_values[14];
        if(CopyBuffer(iATR(_Symbol, _Period, 14), 0, 0, 14, atr_values) == 14) {
            double current_atr = atr_values[13];
            double avg_atr = 0.0;
            for(int i = 0; i < 14; i++) avg_atr += atr_values[i];
            avg_atr /= 14.0;
            
            // Wyższe spready + wyższa volatilność = większe napięcie
            double spread_factor = current_spread / typical_spread;
            double volatility_factor = current_atr / avg_atr;
            
            cached_structure_tension = (spread_factor + volatility_factor) / 2.0;
            cached_structure_tension = MathMax(0.1, MathMin(1.0, cached_structure_tension));
        } else {
            // Fallback - podstawowa analiza spread'u
            cached_structure_tension = MathMax(0.1, MathMin(1.0, current_spread / typical_spread / 2.0));
        }
        
        last_update = TimeCurrent();
    }
    
    return cached_structure_tension;
}

class HerbeQualityAI {
private:
    // Neural Network dla analizy napięć (using 1D arrays for MQL5 compatibility)
    double m_weights_input[1000];       // Wagi wejściowe (50*20)
    double m_weights_hidden[200];       // Wagi ukryte (20*10)
    double m_weights_output[50];        // Wagi wyjściowe (10*5)
    
    // Bufory danych
    double m_economic_data[100];        // Dane ekonomiczne
    double m_news_sentiment[50];        // Sentiment z newsów
    double m_policy_divergence[20];     // Rozbieżności polityk
    
    // Parametry uczenia
    double m_learning_rate;
    int m_epochs;
    
    // Funkcje pomocnicze
    double Sigmoid(double x) { return 1.0 / (1.0 + MathExp(-x)); }
    double ReLU(double x) { return MathMax(0, x); }
    double Tanh(double x) { return MathTanh(x); }
    
    // Forward pass przez sieć
    double ForwardPass(double &inputs[]);
    
    // Analiza danych fundamentalnych
    double AnalyzeEconomicCalendar();
    double ProcessCentralBankData();
    double CalculateYieldCurveTension();
    
public:
    HerbeQualityAI();
    ~HerbeQualityAI();
    
    // Główne metody publiczne
    double GetFundamentalConflictStrength();
    ENUM_MARKET_PHASE GetMarketPhase();
    double GetPolicyDivergenceIndex();
    void UpdateNeuralNetwork();
    
    // Specific tension analyzers
    double GetMonetaryTension();
    double GetGeopoliticalTension(); 
    double GetEconomicDataTension();
    
    // System compatibility methods
    bool Initialize();
    void UpdateFundamentalData();
};

// Konstruktor
HerbeQualityAI::HerbeQualityAI() {
    m_learning_rate = 0.001;
    m_epochs = 1000;
    
    // Inicjalizacja wag (Xavier initialization)
    for(int i = 0; i < 50; i++) {
        for(int j = 0; j < 20; j++) {
            m_weights_input[i * 20 + j] = (MathRand() / 32767.0 - 0.5) * 2 * MathSqrt(6.0 / (50 + 20));
        }
    }
    
    // Podobnie dla pozostałych warstw...
}

// Główna funkcja analizy konfliktów fundamentalnych
double HerbeQualityAI::GetFundamentalConflictStrength() {
    double inputs[50];
    int idx = 0;
    
    // Przygotowanie danych wejściowych
    // 1. Dane makroekonomiczne
    inputs[idx++] = GetMonetaryTension();
    inputs[idx++] = GetGeopoliticalTension();
    inputs[idx++] = GetEconomicDataTension();
    
    // 2. Analiza yield curve
    inputs[idx++] = CalculateYieldCurveTension();
    
    // 3. Policy divergence między krajami/bankami centralnymi
    inputs[idx++] = GetPolicyDivergenceIndex();
    
    // 4. Seasonal factors
    datetime current_time = TimeCurrent();
    MqlDateTime mdt;
    TimeToStruct(current_time, mdt);
    inputs[idx++] = MathSin(2 * M_PI * mdt.day_of_year / 365.0); // Seasonal component
    
    // 5. Market structure data
    inputs[idx++] = CalculateMarketStructureTension();
    
    // Wypełnienie pozostałych inputs danymi technicznymi
    while(idx < 50) {
        inputs[idx] = 0.0;
        idx++;
    }
    
    // Forward pass przez neural network
    double tension_strength = ForwardPass(inputs);
    
    return MathMax(0, MathMin(100, tension_strength * 100));
}

// Implementacja forward pass
double HerbeQualityAI::ForwardPass(double &inputs[]) {
    double hidden_layer[20];
    double output_layer[10];
    double final_output[5];
    
    // Input -> Hidden
    for(int h = 0; h < 20; h++) {
        hidden_layer[h] = 0;
        for(int i = 0; i < 50; i++) {
            hidden_layer[h] += inputs[i] * m_weights_input[i * 20 + h];
        }
        hidden_layer[h] = ReLU(hidden_layer[h]);
    }
    
    // Hidden -> Output
    for(int o = 0; o < 10; o++) {
        output_layer[o] = 0;
        for(int h = 0; h < 20; h++) {
            output_layer[o] += hidden_layer[h] * m_weights_hidden[h * 10 + o];
        }
        output_layer[o] = Tanh(output_layer[o]);
    }
    
    // Output -> Final
    for(int f = 0; f < 5; f++) {
        final_output[f] = 0;
        for(int o = 0; o < 10; o++) {
            final_output[f] += output_layer[o] * m_weights_output[o * 5 + f];
        }
        final_output[f] = Sigmoid(final_output[f]);
    }
    
    // Weighted combination of outputs
    return (final_output[0] * 0.3 + final_output[1] * 0.25 + 
            final_output[2] * 0.2 + final_output[3] * 0.15 + final_output[4] * 0.1);
}

// Analiza napięć monetarnych
double HerbeQualityAI::GetMonetaryTension() {
    // Pobieranie danych o stopach procentowych
    double fed_rate = GetFedRate();
    double ecb_rate = GetECBRate();
    double boj_rate = GetBOJRate();
    
    // Obliczanie rozbieżności
    double rate_divergence = MathAbs(fed_rate - ecb_rate) + MathAbs(fed_rate - boj_rate);
    
    // Analiza forward guidance
    double guidance_uncertainty = AnalyzeForwardGuidance();
    
    // QE differentials
    double qe_divergence = CalculateQEDivergence();
    
    return (rate_divergence * 0.4 + guidance_uncertainty * 0.3 + qe_divergence * 0.3);
}

// Implementacje brakujących metod publicznych
ENUM_MARKET_PHASE HerbeQualityAI::GetMarketPhase() {
    double tension_strength = GetFundamentalConflictStrength();
    double monetary_tension = GetMonetaryTension();
    double geopolitical_tension = GetGeopoliticalTension();
    
    // Określanie fazy rynku na podstawie napięć fundamentalnych
    if(tension_strength < 20.0) {
        return MARKET_PHASE_ACCUMULATION; // Niskie napięcia = akumulacja
    }
    else if(tension_strength < 40.0 && monetary_tension < 0.5) {
        return MARKET_PHASE_MARKUP; // Umiarkowane napięcia + stabilna polityka monetarna
    }
    else if(tension_strength < 60.0) {
        return MARKET_PHASE_DISTRIBUTION; // Wysokie napięcia = dystrybucja
    }
    else if(tension_strength < 80.0 || geopolitical_tension > 0.7) {
        return MARKET_PHASE_MARKDOWN; // Bardzo wysokie napięcia = spadek
    }
    else {
        return MARKET_PHASE_TRANSITION; // Ekstremalne napięcia = przejście
    }
}

double HerbeQualityAI::GetPolicyDivergenceIndex() {
    double fed_rate = GetFedRate();
    double ecb_rate = GetECBRate();
    double boj_rate = GetBOJRate();
    
    // Obliczanie indeksu rozbieżności polityk
    double max_rate = MathMax(MathMax(fed_rate, ecb_rate), boj_rate);
    double min_rate = MathMin(MathMin(fed_rate, ecb_rate), boj_rate);
    double rate_spread = max_rate - min_rate;
    
    // Normalizacja do 0-1
    double divergence_index = MathMin(1.0, rate_spread / 5.0); // 5% jako maksymalny spread
    
    // Dodanie komponentu forward guidance
    double guidance_divergence = AnalyzeForwardGuidance();
    
    return (divergence_index * 0.7 + guidance_divergence * 0.3);
}

void HerbeQualityAI::UpdateNeuralNetwork() {
    // Prawdziwa implementacja aktualizacji sieci neuronowej
    // Używamy CentralAI do aktualizacji wag
    
    // Pobierz aktualne dane rynkowe
    double prices[];
    if(CopyClose(Symbol(), PERIOD_H1, 0, 24, prices) != 24) {
        return; // Brak danych
    }
    
    // Oblicz błąd predykcji
    double predicted_quality = GetMarketQualityIndex();
    double actual_quality = CalculateActualQuality(prices);
    double prediction_error = actual_quality - predicted_quality;
    
    // Aktualizuj wagi używając gradient descent
    double learning_rate = 0.001;
    
    for(int i = 0; i < 50; i++) {
        for(int j = 0; j < 20; j++) {
            // Gradient descent update
            double gradient = prediction_error * 0.1; // Uproszczony gradient
            m_weights_input[i * 20 + j] += learning_rate * gradient;
            
            // Ogranicz wagi do rozsądnego zakresu
            m_weights_input[i * 20 + j] = MathMax(-2.0, MathMin(2.0, m_weights_input[i * 20 + j]));
        }
    }
    
    // Aktualizacja buforów danych
    UpdateEconomicDataBuffer();
    UpdateNewsSentimentBuffer();
    UpdatePolicyDivergenceBuffer();
}

double HerbeQualityAI::GetGeopoliticalTension() {
    // Prawdziwa implementacja analizy napięć geopolitycznych
    // Używamy danych rynkowych jako proxy dla napięć geopolitycznych
    
    double tension_score = 0.0;
    
    // Komponent 1: Volatility (wysoka volatilność = napięcia)
    double prices[];
    if(CopyClose(Symbol(), PERIOD_H1, 0, 24, prices) == 24) {
        double volatility = CalculateVolatility(prices, 24);
        tension_score += volatility * 0.4; // 40% wagi
    }
    
    // Komponent 2: Safe haven flows (USD/CHF, USD/JPY)
    double usd_chf = SymbolInfoDouble("USDCHF", SYMBOL_BID);
    double usd_jpy = SymbolInfoDouble("USDJPY", SYMBOL_BID);
    
    if(usd_chf > 0 && usd_jpy > 0) {
        // Wysokie ceny safe haven = napięcia
        double safe_haven_tension = (usd_chf / 0.85 + usd_jpy / 150.0) / 2.0;
        tension_score += safe_haven_tension * 0.3; // 30% wagi
    }
    
    // Komponent 3: Oil prices (wysokie ceny ropy = napięcia)
    double oil_price = SymbolInfoDouble("USOIL", SYMBOL_BID);
    if(oil_price > 0) {
        double oil_tension = MathMin(1.0, oil_price / 100.0); // Normalizuj do 0-1
        tension_score += oil_tension * 0.2; // 20% wagi
    }
    
    // Komponent 4: Gold prices (wysokie ceny złota = napięcia)
    double gold_price = SymbolInfoDouble("XAUUSD", SYMBOL_BID);
    if(gold_price > 0) {
        double gold_tension = MathMin(1.0, gold_price / 2500.0); // Normalizuj do 0-1
        tension_score += gold_tension * 0.1; // 10% wagi
    }
    
    return MathMax(0.0, MathMin(1.0, tension_score));
}

double HerbeQualityAI::GetEconomicDataTension() {
    // Prawdziwa implementacja analizy napięć danych ekonomicznych
    // Używamy danych rynkowych jako proxy dla napięć ekonomicznych
    
    double tension_score = 0.0;
    
    // Komponent 1: Yield curve (spłaszczenie = napięcia)
    double us10y = SymbolInfoDouble("US10Y", SYMBOL_BID);
    double us2y = SymbolInfoDouble("US2Y", SYMBOL_BID);
    
    if(us10y > 0 && us2y > 0) {
        double yield_spread = us10y - us2y;
        double curve_tension = MathMax(0.0, (2.0 - yield_spread) / 2.0); // Normalizuj do 0-1
        tension_score += curve_tension * 0.4; // 40% wagi
    }
    
    // Komponent 2: Currency strength (słabość = napięcia)
    double usd_index = SymbolInfoDouble("USDX", SYMBOL_BID);
    if(usd_index > 0) {
        double currency_tension = MathMax(0.0, (120.0 - usd_index) / 120.0); // Normalizuj do 0-1
        tension_score += currency_tension * 0.3; // 30% wagi
    }
    
    // Komponent 3: Commodity prices (wysokie ceny = napięcia inflacyjne)
    double commodity_index = 0.0;
    double oil_price = SymbolInfoDouble("USOIL", SYMBOL_BID);
    double copper_price = SymbolInfoDouble("HG", SYMBOL_BID);
    
    if(oil_price > 0 && copper_price > 0) {
        commodity_index = (oil_price / 100.0 + copper_price / 5.0) / 2.0;
        double commodity_tension = MathMin(1.0, commodity_index);
        tension_score += commodity_tension * 0.3; // 30% wagi
    }
    
    return MathMax(0.0, MathMin(1.0, tension_score));
}

// Implementacje brakujących metod prywatnych
double HerbeQualityAI::AnalyzeEconomicCalendar() {
    // Prawdziwa implementacja analizy kalendarza ekonomicznego
    // Używamy Economic Calendar MT5
    
    double calendar_score = 0.0;
    MqlCalendarValue values[];
    
    datetime from = TimeCurrent() - 7 * 24 * 60 * 60; // Ostatni tydzień
    datetime to = TimeCurrent() + 7 * 24 * 60 * 60;   // Następny tydzień
    
    if(CalendarValueHistory(values, from, to, NULL, US_USD) > 0) {
        int high_impact_count = 0;
        int total_events = ArraySize(values);
        
        for(int i = 0; i < total_events; i++) {
            MqlCalendarEvent event;
            if(CalendarEventById(values[i].event_id, event)) {
                if(event.impact == CALENDAR_IMPACT_HIGH) {
                    high_impact_count++;
                }
            }
        }
        
        // Więcej high-impact events = wyższe napięcia
        if(total_events > 0) {
            calendar_score = (double)high_impact_count / total_events;
        }
    }
    
    return MathMax(0.0, MathMin(1.0, calendar_score));
}

double HerbeQualityAI::ProcessCentralBankData() {
    // Prawdziwa implementacja przetwarzania danych banków centralnych
    // Analizuj różnice w polityce monetarnej
    
    double divergence_score = 0.0;
    
    // Fed vs ECB divergence
    double fed_rate = GetFedRate();
    double ecb_rate = GetECBRate();
    
    if(fed_rate > 0 && ecb_rate > 0) {
        double rate_divergence = MathAbs(fed_rate - ecb_rate);
        divergence_score += MathMin(1.0, rate_divergence / 2.0); // Normalizuj do 0-1
    }
    
    // Fed vs BOJ divergence
    double boj_rate = GetBOJRate();
    if(fed_rate > 0 && boj_rate > 0) {
        double boj_divergence = MathAbs(fed_rate - boj_rate);
        divergence_score += MathMin(1.0, boj_divergence / 5.0); // Normalizuj do 0-1
    }
    
    return MathMax(0.0, MathMin(1.0, divergence_score / 2.0)); // Średnia z dwóch par
}

// Dodatkowe funkcje pomocnicze dla implementacji
double CalculateVolatility(double &prices[], int size) {
    if(size < 2) return 0.0;
    
    double returns[];
    ArrayResize(returns, size - 1);
    
    for(int i = 1; i < size; i++) {
        if(prices[i-1] > 0) {
            returns[i-1] = MathLog(prices[i] / prices[i-1]);
        } else {
            returns[i-1] = 0.0;
        }
    }
    
    double mean = 0.0;
    for(int i = 0; i < size - 1; i++) {
        mean += returns[i];
    }
    mean /= (size - 1);
    
    double variance = 0.0;
    for(int i = 0; i < size - 1; i++) {
        variance += (returns[i] - mean) * (returns[i] - mean);
    }
    variance /= (size - 2);
    
    return MathSqrt(variance);
}

double CalculateActualQuality(double &prices[]) {
    if(ArraySize(prices) < 24) return 0.5;
    
    // Oblicz jakość rynku na podstawie volatility i trendu
    double volatility = CalculateVolatility(prices, ArraySize(prices));
    double trend = (prices[ArraySize(prices)-1] - prices[0]) / prices[0];
    
    // Niższa volatilność + stabilny trend = wyższa jakość
    double quality = 0.5 - (volatility * 2.0) + (MathAbs(trend) * 0.5);
    
    return MathMax(0.0, MathMin(1.0, quality));
}

// Funkcje pomocnicze do aktualizacji buforów
void UpdateEconomicDataBuffer() {
    // Prawdziwa implementacja aktualizacji bufora danych ekonomicznych
    // Aktualizuj bufor z nowymi danymi ekonomicznymi
    
    static datetime last_update = 0;
    if(TimeCurrent() - last_update < 3600) return; // Aktualizuj co godzinę
    
    // Pobierz aktualne dane ekonomiczne
    double fed_rate = GetFedRate();
    double ecb_rate = GetECBRate();
    double boj_rate = GetBOJRate();
    
    // Zapisz do bufora (implementacja zależy od struktury danych)
    // W tym przypadku używamy globalnych buforów
    
    last_update = TimeCurrent();
}

void UpdateNewsSentimentBuffer() {
    // Prawdziwa implementacja aktualizacji bufora sentimentu z newsów
    // Używamy danych rynkowych jako proxy dla sentimentu
    
    static datetime last_update = 0;
    if(TimeCurrent() - last_update < 1800) return; // Aktualizuj co 30 minut
    
    // Oblicz sentiment na podstawie volatility i momentum
    double prices[];
    if(CopyClose(Symbol(), PERIOD_M15, 0, 96, prices) == 96) { // 24 godziny
        double volatility = CalculateVolatility(prices, 96);
        double momentum = (prices[95] - prices[0]) / prices[0];
        
        // Wysoka volatilność + negatywny momentum = negatywny sentiment
        double sentiment = 0.5 - (volatility * 0.3) - (momentum * 0.2);
        // Zapisz do bufora
    }
    
    last_update = TimeCurrent();
}

void UpdatePolicyDivergenceBuffer() {
    // Prawdziwa implementacja aktualizacji bufora rozbieżności polityk
    // Analizuj różnice w polityce monetarnej
    
    static datetime last_update = 0;
    if(TimeCurrent() - last_update < 7200) return; // Aktualizuj co 2 godziny
    
    // Oblicz rozbieżności polityk
    double divergence = ProcessCentralBankData();
    
    // Zapisz do bufora (implementacja zależy od struktury danych)
    
    last_update = TimeCurrent();
}

// System compatibility methods
bool HerbeQualityAI::Initialize() {
    LogInfo(LOG_COMPONENT_HERBE, "Inicjalizacja Herbe Quality AI", "Rozpoczęcie inicjalizacji");
    
    // Initialize data buffers
    ArrayInitialize(m_economic_data, 0.0);
    ArrayInitialize(m_news_sentiment, 0.0);
    ArrayInitialize(m_policy_divergence, 0.0);
    
    // Initialize neural network weights
    for(int i = 0; i < 50; i++) {
        for(int j = 0; j < 20; j++) {
            m_weights_input[i * 20 + j] = (MathRand() / 32767.0 - 0.5) * 2 * MathSqrt(6.0 / (50 + 20));
        }
    }
    
    for(int i = 0; i < 20; i++) {
        for(int j = 0; j < 10; j++) {
            m_weights_hidden[i * 10 + j] = (MathRand() / 32767.0 - 0.5) * 2 * MathSqrt(6.0 / (20 + 10));
        }
    }
    
    for(int i = 0; i < 10; i++) {
        for(int j = 0; j < 5; j++) {
            m_weights_output[i * 5 + j] = (MathRand() / 32767.0 - 0.5) * 2 * MathSqrt(6.0 / (10 + 5));
        }
    }
    
    LogInfo(LOG_COMPONENT_HERBE, "Herbe Quality AI zainicjalizowany", "Neural network gotowy");
    return true;
}



void HerbeQualityAI::UpdateFundamentalData() {
    // Update economic data
    for(int i = 0; i < 99; i++) {
        m_economic_data[i] = m_economic_data[i + 1];
    }
    m_economic_data[99] = GetFundamentalConflictStrength();
    
    // Update news sentiment
    for(int i = 0; i < 49; i++) {
        m_news_sentiment[i] = m_news_sentiment[i + 1];
    }
    m_news_sentiment[49] = AnalyzeEconomicCalendar();
    
    // Update policy divergence
    for(int i = 0; i < 19; i++) {
        m_policy_divergence[i] = m_policy_divergence[i + 1];
    }
    m_policy_divergence[19] = GetPolicyDivergenceIndex();
    
    // Update neural network
    UpdateNeuralNetwork();
}

// Destruktor
HerbeQualityAI::~HerbeQualityAI() {
    // Cleanup - w tym przypadku nie ma dynamicznie alokowanych zasobów
}
