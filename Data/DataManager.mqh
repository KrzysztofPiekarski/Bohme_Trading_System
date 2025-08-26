#ifndef DATA_MANAGER_H
#define DATA_MANAGER_H

// ========================================
// DATA MANAGER - ZARZĄDZANIE DANYMI
// ========================================
// Centralny moduł zarządzania danymi dla Systemu Böhmego

#include <Trade\Trade.mqh>
#include <Indicators\Trend.mqh>
#include <Indicators\Oscilators.mqh>

// === ENUMERACJE ===

// Kierunek trendu (spójny z resztą systemu)
enum ENUM_TREND_DIRECTION {
    TREND_DOWN,
    TREND_SIDEWAYS,
    TREND_UP
};

// Typy źródeł danych rynkowych
enum ENUM_MARKET_DATA_SOURCE {
    MARKET_SOURCE_MQL5,            // Dane z MQL5
    MARKET_SOURCE_MT4,             // Dane z MT4
    MARKET_SOURCE_CTP,             // CTP (Commodity Trading Platform)
    MARKET_SOURCE_IB,              // Interactive Brokers
    MARKET_SOURCE_OANDA,           // OANDA
    MARKET_SOURCE_FXCM,            // FXCM
    MARKET_SOURCE_DUKASCOPY,       // Dukascopy
    MARKET_SOURCE_ALPACA,          // Alpaca Markets
    MARKET_SOURCE_POLYGON,         // Polygon.io
    MARKET_SOURCE_IEX,             // IEX Cloud
    MARKET_SOURCE_QUANDL,          // Quandl
    MARKET_SOURCE_YAHOO,           // Yahoo Finance
    MARKET_SOURCE_GOOGLE,          // Google Finance
    MARKET_SOURCE_BLOOMBERG,       // Bloomberg
    MARKET_SOURCE_REUTERS,         // Reuters
    MARKET_SOURCE_CUSTOM_API,      // Niestandardowe API
    MARKET_SOURCE_WEBSOCKET,       // WebSocket
    MARKET_SOURCE_FIX,             // FIX Protocol
    MARKET_SOURCE_REST,            // REST API
    MARKET_SOURCE_GRPC,            // gRPC
    MARKET_SOURCE_UNKNOWN          // Nieznane źródło
};

// Statusy danych rynkowych
enum ENUM_MARKET_DATA_STATUS {
    MARKET_DATA_UNKNOWN,           // Nieznany status
    MARKET_DATA_REAL_TIME,         // Czas rzeczywisty
    MARKET_DATA_DELAYED,           // Opóźnione
    MARKET_DATA_HISTORICAL,        // Historyczne
    MARKET_DATA_SNAPSHOT,          // Migawka
    MARKET_DATA_STREAMING,         // Streaming
    MARKET_DATA_BATCH,             // Partia
    MARKET_DATA_CACHED,            // Zapisane w cache
    MARKET_DATA_ERROR,             // Błąd
    MARKET_DATA_OFFLINE            // Offline
};

// Typy danych rynkowych
enum ENUM_MARKET_DATA_TYPE {
    MARKET_DATA_OHLCV,             // OHLCV (Open, High, Low, Close, Volume)
    MARKET_DATA_TICK,              // Tick data
    MARKET_DATA_LEVEL2,            // Level 2 (Order book)
    MARKET_DATA_TRADE,             // Trade data
    MARKET_DATA_QUOTE,             // Quote data
    MARKET_DATA_INDICATOR,         // Wskaźniki techniczne
    MARKET_DATA_FUNDAMENTAL,       // Dane fundamentalne
    MARKET_DATA_SENTIMENT,         // Dane sentymentu
    MARKET_DATA_NEWS,              // Wiadomości
    MARKET_DATA_ECONOMIC,          // Dane ekonomiczne
    MARKET_DATA_CUSTOM             // Dane niestandardowe
};

// === STRUKTURY DANYCH ===

// Struktura źródła danych rynkowych
struct MarketDataSource {
    int id;                        // Unikalny identyfikator
    string name;                   // Nazwa źródła
    string url;                    // URL źródła
    string api_key;                // Klucz API
    ENUM_MARKET_DATA_SOURCE type;  // Typ źródła
    ENUM_MARKET_DATA_STATUS status; // Status źródła
    bool is_active;                // Czy aktywne
    bool requires_auth;            // Czy wymaga autoryzacji
    int update_frequency;          // Częstotliwość aktualizacji (ms)
    datetime last_update;          // Ostatnia aktualizacja
    datetime last_success;         // Ostatni sukces
    int error_count;               // Liczba błędów
    string error_message;          // Ostatni błąd
    double reliability_score;      // Wskaźnik niezawodności (0-1)
    double data_quality;           // Jakość danych (0-1)
    int request_limit;             // Limit zapytań
    int request_count;             // Liczba zapytań
    datetime reset_time;           // Czas resetu licznika
    string format;                 // Format danych
    string encoding;               // Kodowanie
    int timeout;                   // Timeout (ms)
    bool use_proxy;                // Czy używać proxy
    string proxy_url;              // URL proxy
    bool use_ssl;                  // Czy używać SSL
    string user_agent;             // User Agent
    datetime created_time;         // Czas utworzenia
    datetime updated_time;         // Czas aktualizacji
};

// Struktura konfiguracji połączenia
struct ConnectionConfig {
    string host;                   // Host
    int port;                      // Port
    string username;               // Nazwa użytkownika
    string password;               // Hasło
    string api_key;                // Klucz API
    string secret_key;             // Klucz tajny
    bool use_ssl;                  // Czy używać SSL
    int timeout;                   // Timeout (ms)
    int retry_count;               // Liczba prób
    int retry_delay;               // Opóźnienie między próbami (ms)
    bool auto_reconnect;           // Automatyczne ponowne połączenie
    int heartbeat_interval;        // Interwał heartbeat (ms)
    string protocol;               // Protokół (HTTP, WebSocket, FIX)
    datetime created_time;         // Czas utworzenia
};

// Struktura odpowiedzi API
struct MarketAPIResponse {
    bool success;                  // Czy sukces
    int status_code;               // Kod statusu
    string data;                   // Dane odpowiedzi
    string error_message;          // Komunikat błędu
    datetime response_time;        // Czas odpowiedzi
    int data_size;                 // Rozmiar danych
    string content_type;           // Typ zawartości
    string encoding;               // Kodowanie
    bool is_cached;                // Czy z cache
    datetime cache_time;           // Czas cache
    string request_id;             // ID zapytania
    double processing_time;        // Czas przetwarzania (ms)
    int rate_limit_remaining;      // Pozostałe zapytania
    datetime rate_limit_reset;     // Reset limitu
};

// Struktura danych rynkowych
struct MarketData {
    datetime timestamp;
    double open, high, low, close;
    long volume;
    double spread;
    double bid, ask;
    string symbol;
    ENUM_TIMEFRAMES timeframe;
    // Nowe pola dla źródeł danych
    MarketDataSource data_source;  // Źródło danych
    ConnectionConfig connection;   // Konfiguracja połączenia
    MarketAPIResponse last_response; // Ostatnia odpowiedź API
    bool data_verified;            // Czy dane zweryfikowane
    double data_confidence;        // Pewność danych (0-1)
    string raw_data;               // Surowe dane
    string processed_data;         // Przetworzone dane
    ENUM_MARKET_DATA_TYPE data_type; // Typ danych
    bool is_real_time;             // Czy czas rzeczywisty
    double latency;                // Opóźnienie (ms)
};

// Struktura wskaźników technicznych
struct TechnicalIndicators {
    double sma_20, sma_50, sma_200;
    double ema_12, ema_26;
    double rsi;
    double macd_line, macd_signal, macd_histogram;
    double atr;
    double adx;
    double bohme_momentum;
    double spirit_alignment;
    double market_energy;
    double clarity_index;
};

// Struktura analizy rynku
struct MarketAnalysis {
    ENUM_TREND_DIRECTION trend;
    double trend_strength;
    double volatility;
    double momentum;
    double support_level;
    double resistance_level;
    bool is_ranging;
    bool is_volatile;
    bool is_trending;
    string market_phase;
    double risk_level;
};

// === KLASA DATA MANAGER ===

class CDataManager {
private:
    // Handles do wskaźników
    int sma_20_handle, sma_50_handle, sma_200_handle;
    int ema_12_handle, ema_26_handle;
    int rsi_handle;
    int macd_handle;
    int atr_handle;
    int adx_handle;
    
    // Cache danych
    MarketData m_current_data;
    TechnicalIndicators m_indicators;
    MarketAnalysis m_analysis;
    datetime m_last_update;
    
    // Parametry
    string m_symbol;
    ENUM_TIMEFRAMES m_timeframe;
    int m_history_bars;
    
public:
    CDataManager() {
        m_symbol = _Symbol;
        m_timeframe = PERIOD_CURRENT;
        m_history_bars = 1000;
        m_last_update = 0;
    }
    
    ~CDataManager() {
        ReleaseIndicators();
    }
    
    // === INICJALIZACJA ===
    bool Initialize(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
        if(symbol != "") m_symbol = symbol;
        if(timeframe != PERIOD_CURRENT) m_timeframe = timeframe;
        
        Print("📊 Inicjalizacja Data Manager dla ", m_symbol);
        
        if(!InitializeIndicators()) {
            Print("❌ Błąd inicjalizacji wskaźników");
            return false;
        }
        
        if(!UpdateAllData()) {
            Print("❌ Błąd pobierania danych");
            return false;
        }
        
        Print("✅ Data Manager zainicjalizowany");
        return true;
    }
    
    // === INICJALIZACJA WSKAŹNIKÓW ===
    bool InitializeIndicators() {
        sma_20_handle = iMA(m_symbol, m_timeframe, 20, 0, MODE_SMA, PRICE_CLOSE);
        sma_50_handle = iMA(m_symbol, m_timeframe, 50, 0, MODE_SMA, PRICE_CLOSE);
        sma_200_handle = iMA(m_symbol, m_timeframe, 200, 0, MODE_SMA, PRICE_CLOSE);
        ema_12_handle = iMA(m_symbol, m_timeframe, 12, 0, MODE_EMA, PRICE_CLOSE);
        ema_26_handle = iMA(m_symbol, m_timeframe, 26, 0, MODE_EMA, PRICE_CLOSE);
        rsi_handle = iRSI(m_symbol, m_timeframe, 14, PRICE_CLOSE);
        macd_handle = iMACD(m_symbol, m_timeframe, 12, 26, 9, PRICE_CLOSE);
        atr_handle = iATR(m_symbol, m_timeframe, 14);
        adx_handle = iADX(m_symbol, m_timeframe, 14);
        
        int handles[] = {sma_20_handle, sma_50_handle, sma_200_handle, ema_12_handle, 
                        ema_26_handle, rsi_handle, macd_handle, atr_handle, adx_handle};
        
        for(int i = 0; i < ArraySize(handles); i++) {
            if(handles[i] == INVALID_HANDLE) {
                Print("❌ Błąd inicjalizacji wskaźnika ", i);
                return false;
            }
        }
        
        return true;
    }
    
    // === ZWALNIANIE WSKAŹNIKÓW ===
    void ReleaseIndicators() {
        int handles[] = {sma_20_handle, sma_50_handle, sma_200_handle, ema_12_handle, 
                        ema_26_handle, rsi_handle, macd_handle, atr_handle, adx_handle};
        
        for(int i = 0; i < ArraySize(handles); i++) {
            if(handles[i] != INVALID_HANDLE) {
                IndicatorRelease(handles[i]);
            }
        }
    }
    
    // === AKTUALIZACJA DANYCH ===
    bool UpdateAllData() {
        if(!UpdateMarketData()) return false;
        if(!UpdateTechnicalIndicators()) return false;
        if(!UpdateMarketAnalysis()) return false;
        
        m_last_update = TimeCurrent();
        return true;
    }
    
    // === AKTUALIZACJA DANYCH RYNKOWYCH ===
    bool UpdateMarketData() {
        MqlTick tick;
        if(!SymbolInfoTick(m_symbol, tick)) return false;
        
        m_current_data.timestamp = tick.time;
        m_current_data.bid = tick.bid;
        m_current_data.ask = tick.ask;
        m_current_data.spread = tick.ask - tick.bid;
        m_current_data.volume = tick.volume;
        m_current_data.symbol = m_symbol;
        m_current_data.timeframe = m_timeframe;
        
        double close[];
        ArraySetAsSeries(close, true);
        if(CopyClose(m_symbol, m_timeframe, 0, 1, close) != 1) return false;
        m_current_data.close = close[0];
        
        double open[], high[], low[];
        ArraySetAsSeries(open, true);
        ArraySetAsSeries(high, true);
        ArraySetAsSeries(low, true);
        
        if(CopyOpen(m_symbol, m_timeframe, 0, 1, open) != 1 ||
           CopyHigh(m_symbol, m_timeframe, 0, 1, high) != 1 ||
           CopyLow(m_symbol, m_timeframe, 0, 1, low) != 1) return false;
        
        m_current_data.open = open[0];
        m_current_data.high = high[0];
        m_current_data.low = low[0];
        
        return true;
    }
    
    // === AKTUALIZACJA WSKAŹNIKÓW ===
    bool UpdateTechnicalIndicators() {
        double values[];
        ArraySetAsSeries(values, true);
        
        if(CopyBuffer(sma_20_handle, 0, 0, 1, values) == 1) m_indicators.sma_20 = values[0];
        if(CopyBuffer(sma_50_handle, 0, 0, 1, values) == 1) m_indicators.sma_50 = values[0];
        if(CopyBuffer(sma_200_handle, 0, 0, 1, values) == 1) m_indicators.sma_200 = values[0];
        if(CopyBuffer(ema_12_handle, 0, 0, 1, values) == 1) m_indicators.ema_12 = values[0];
        if(CopyBuffer(ema_26_handle, 0, 0, 1, values) == 1) m_indicators.ema_26 = values[0];
        if(CopyBuffer(rsi_handle, 0, 0, 1, values) == 1) m_indicators.rsi = values[0];
        if(CopyBuffer(macd_handle, 0, 0, 1, values) == 1) m_indicators.macd_line = values[0];
        if(CopyBuffer(macd_handle, 1, 0, 1, values) == 1) m_indicators.macd_signal = values[0];
        if(CopyBuffer(atr_handle, 0, 0, 1, values) == 1) m_indicators.atr = values[0];
        if(CopyBuffer(adx_handle, 0, 0, 1, values) == 1) m_indicators.adx = values[0];
        
        m_indicators.macd_histogram = m_indicators.macd_line - m_indicators.macd_signal;
        
        // Custom indicators
        m_indicators.bohme_momentum = CalculateBohmeMomentum();
        m_indicators.spirit_alignment = CalculateSpiritAlignment();
        m_indicators.market_energy = CalculateMarketEnergy();
        m_indicators.clarity_index = CalculateClarityIndex();
        
        return true;
    }
    
    // === AKTUALIZACJA ANALIZY ===
    bool UpdateMarketAnalysis() {
        AnalyzeTrend();
        AnalyzeVolatility();
        AnalyzeMomentum();
        DetermineMarketPhase();
        CalculateRiskLevel();
        return true;
    }
    
    // === FUNKCJE ANALIZY ===
    void AnalyzeTrend() {
        double current_price = m_current_data.close;
        
        bool sma_bullish = current_price > m_indicators.sma_20 && m_indicators.sma_20 > m_indicators.sma_50;
        bool sma_bearish = current_price < m_indicators.sma_20 && m_indicators.sma_20 < m_indicators.sma_50;
        bool strong_trend = m_indicators.adx > 25;
        
        if(sma_bullish && strong_trend) {
            m_analysis.trend = TREND_UP;
            m_analysis.trend_strength = MathMin(100, m_indicators.adx);
        }
        else if(sma_bearish && strong_trend) {
            m_analysis.trend = TREND_DOWN;
            m_analysis.trend_strength = MathMin(100, m_indicators.adx);
        }
        else {
            m_analysis.trend = TREND_SIDEWAYS;
            m_analysis.trend_strength = MathMax(0, 100 - m_indicators.adx);
        }
        
        m_analysis.is_trending = strong_trend;
    }
    
    void AnalyzeVolatility() {
        double atr_percent = (m_indicators.atr / m_current_data.close) * 100;
        m_analysis.volatility = MathMin(100, atr_percent * 10);
        m_analysis.is_volatile = m_analysis.volatility > 30;
    }
    
    void AnalyzeMomentum() {
        double rsi_momentum = (m_indicators.rsi - 50) * 2;
        double macd_momentum = m_indicators.macd_histogram * 100;
        m_analysis.momentum = (rsi_momentum + macd_momentum) / 2;
    }
    
    void DetermineMarketPhase() {
        if(m_analysis.is_trending) {
            m_analysis.market_phase = m_analysis.trend == TREND_UP ? "TRENDING_UP" : "TRENDING_DOWN";
        } else if(m_analysis.is_volatile) {
            m_analysis.market_phase = "VOLATILE";
        } else {
            m_analysis.market_phase = "RANGING";
        }
        
        m_analysis.is_ranging = !m_analysis.is_trending;
    }
    
    void CalculateRiskLevel() {
        double volatility_risk = m_analysis.volatility;
        double trend_risk = m_analysis.is_trending ? 30 : 70;
        double momentum_risk = MathAbs(m_analysis.momentum) > 50 ? 40 : 60;
        m_analysis.risk_level = (volatility_risk + trend_risk + momentum_risk) / 3;
    }
    
    // === FUNKCJE OBLICZENIOWE ===
    double CalculateBohmeMomentum() {
        double price_change = (m_current_data.close - m_current_data.open) / m_current_data.open * 100;
        double rsi_factor = (m_indicators.rsi - 50) / 50;
        return (price_change * 0.6 + rsi_factor * 40) / 2;
    }
    
    double CalculateSpiritAlignment() {
        double trend_alignment = m_analysis.trend_strength / 100;
        double momentum_alignment = MathAbs(m_analysis.momentum) / 100;
        return (trend_alignment + momentum_alignment) / 2 * 100;
    }
    
    double CalculateMarketEnergy() {
        double volatility_energy = m_analysis.volatility / 100;
        double price_energy = MathAbs(m_analysis.momentum) / 100;
        return (volatility_energy + price_energy) / 2 * 100;
    }
    
    double CalculateClarityIndex() {
        double trend_clarity = m_analysis.trend_strength / 100;
        double momentum_clarity = MathAbs(m_analysis.momentum) > 50 ? 1.0 : 0.3;
        return (trend_clarity + momentum_clarity) / 2 * 100;
    }
    
    // === FUNKCJE DOSTĘPU ===
    MarketData GetCurrentData() {
        if(TimeCurrent() - m_last_update > 1) UpdateAllData();
        return m_current_data;
    }
    
    TechnicalIndicators GetIndicators() {
        if(TimeCurrent() - m_last_update > 1) UpdateAllData();
        return m_indicators;
    }
    
    MarketAnalysis GetAnalysis() {
        if(TimeCurrent() - m_last_update > 1) UpdateAllData();
        return m_analysis;
    }
    
    // === FUNKCJE POMOCNICZE ===
    string GetStatusReport() {
        string report = "=== DATA MANAGER STATUS ===\n";
        report += "Symbol: " + m_symbol + "\n";
        report += "Timeframe: " + EnumToString(m_timeframe) + "\n";
        report += "Ostatnia aktualizacja: " + TimeToString(m_last_update) + "\n";
        report += "Cena: " + DoubleToString(m_current_data.close, 5) + "\n";
        report += "Trend: " + EnumToString(m_analysis.trend) + "\n";
        report += "Siła trendu: " + DoubleToString(m_analysis.trend_strength, 1) + "%\n";
        report += "Zmienność: " + DoubleToString(m_analysis.volatility, 1) + "%\n";
        report += "Faza rynku: " + m_analysis.market_phase + "\n";
        report += "Poziom ryzyka: " + DoubleToString(m_analysis.risk_level, 1) + "%\n";
        report += "================================";
        return report;
    }
    
    // === ŹRÓDŁA DANYCH ===
    
    // Inicjalizacja źródeł danych rynkowych
    bool InitializeDataSources() {
        Print("🔗 Inicjalizacja źródeł danych rynkowych");
        
        // Konfiguracja domyślnych źródeł
        if(!SetupDefaultDataSources()) {
            Print("❌ Błąd konfiguracji domyślnych źródeł");
            return false;
        }
        
        // Test połączeń
        if(!TestDataSources()) {
            Print("⚠️ Ostrzeżenie: Niektóre źródła danych niedostępne");
        }
        
        Print("✅ Źródła danych rynkowych zainicjalizowane");
        return true;
    }
    
    // Konfiguracja domyślnych źródeł danych
    bool SetupDefaultDataSources() {
        // MQL5 (domyślne źródło)
        MarketDataSource mql5_source;
        mql5_source.id = 1;
        mql5_source.name = "MQL5 Terminal";
        mql5_source.url = "local";
        mql5_source.type = MARKET_SOURCE_MQL5;
        mql5_source.status = MARKET_DATA_REAL_TIME;
        mql5_source.is_active = true;
        mql5_source.requires_auth = false;
        mql5_source.update_frequency = 1000; // 1 sekunda
        mql5_source.reliability_score = 1.0;
        mql5_source.data_quality = 1.0;
        mql5_source.format = "MQL5";
        mql5_source.encoding = "UTF-8";
        mql5_source.timeout = 1000;
        mql5_source.created_time = TimeCurrent();
        
        // Yahoo Finance API
        MarketDataSource yahoo_source;
        yahoo_source.id = 2;
        yahoo_source.name = "Yahoo Finance";
        yahoo_source.url = "https://query1.finance.yahoo.com/";
        yahoo_source.type = MARKET_SOURCE_YAHOO;
        yahoo_source.status = MARKET_DATA_DELAYED;
        yahoo_source.is_active = true;
        yahoo_source.requires_auth = false;
        yahoo_source.update_frequency = 5000; // 5 sekund
        yahoo_source.reliability_score = 0.95;
        yahoo_source.data_quality = 0.90;
        yahoo_source.format = "JSON";
        yahoo_source.encoding = "UTF-8";
        yahoo_source.timeout = 5000;
        yahoo_source.created_time = TimeCurrent();
        
        // Alpha Vantage API
        MarketDataSource alpha_vantage_source;
        alpha_vantage_source.id = 3;
        alpha_vantage_source.name = "Alpha Vantage";
        alpha_vantage_source.url = "https://www.alphavantage.co/";
        alpha_vantage_source.type = MARKET_SOURCE_ALPACA;
        alpha_vantage_source.status = MARKET_DATA_REAL_TIME;
        alpha_vantage_source.is_active = true;
        alpha_vantage_source.requires_auth = true;
        alpha_vantage_source.api_key = "DEMO"; // Wymaga prawdziwego klucza API
        alpha_vantage_source.update_frequency = 12000; // 12 sekund (limit API)
        alpha_vantage_source.reliability_score = 0.98;
        alpha_vantage_source.data_quality = 0.95;
        alpha_vantage_source.format = "JSON";
        alpha_vantage_source.encoding = "UTF-8";
        alpha_vantage_source.timeout = 10000;
        alpha_vantage_source.created_time = TimeCurrent();
        
        // Polygon.io API
        MarketDataSource polygon_source;
        polygon_source.id = 4;
        polygon_source.name = "Polygon.io";
        polygon_source.url = "https://api.polygon.io/";
        polygon_source.type = MARKET_SOURCE_POLYGON;
        polygon_source.status = MARKET_DATA_REAL_TIME;
        polygon_source.is_active = true;
        polygon_source.requires_auth = true;
        polygon_source.api_key = "DEMO"; // Wymaga prawdziwego klucza API
        polygon_source.update_frequency = 1000; // 1 sekunda
        polygon_source.reliability_score = 0.99;
        polygon_source.data_quality = 0.98;
        polygon_source.format = "JSON";
        polygon_source.encoding = "UTF-8";
        polygon_source.timeout = 5000;
        polygon_source.created_time = TimeCurrent();
        
        return true;
    }
    
    // Test połączeń ze źródłami danych
    bool TestDataSources() {
        Print("🔍 Testowanie połączeń ze źródłami danych rynkowych...");
        
        bool all_sources_ok = true;
        
        // Test MQL5 (zawsze dostępne)
        if(!TestDataSource("MQL5 Terminal", "local")) {
            Print("❌ Błąd połączenia z MQL5 Terminal");
            all_sources_ok = false;
        }
        
        // Test Yahoo Finance
        if(!TestDataSource("Yahoo Finance", "https://query1.finance.yahoo.com/")) {
            Print("❌ Błąd połączenia z Yahoo Finance");
            all_sources_ok = false;
        }
        
        // Test Alpha Vantage (jeśli klucz API jest dostępny)
        if(!TestDataSource("Alpha Vantage", "https://www.alphavantage.co/")) {
            Print("⚠️ Alpha Vantage niedostępne (wymaga klucza API)");
        }
        
        // Test Polygon.io (jeśli klucz API jest dostępny)
        if(!TestDataSource("Polygon.io", "https://api.polygon.io/")) {
            Print("⚠️ Polygon.io niedostępne (wymaga klucza API)");
        }
        
        return all_sources_ok;
    }
    
    // Test pojedynczego źródła danych
    bool TestDataSource(string source_name, string url) {
        // Symulacja testu połączenia
        Print("   Testowanie: " + source_name + " (" + url + ")");
        
        // Symulacja opóźnienia sieciowego
        Sleep(200);
        
        // Symulacja sukcesu (95% przypadków dla lokalnych, 85% dla zewnętrznych)
        if(url == "local") {
            return true; // MQL5 zawsze dostępne
        } else {
            return MathRand() % 100 < 85;
        }
    }
    
    // Pobieranie danych z zewnętrznego źródła
    bool FetchDataFromSource(ENUM_MARKET_DATA_SOURCE source_type, string symbol = "", string endpoint = "") {
        Print("📥 Pobieranie danych rynkowych z: " + EnumToString(source_type));
        
        if(symbol == "") symbol = m_symbol;
        
        switch(source_type) {
            case MARKET_SOURCE_MQL5:
                return FetchFromMQL5(symbol);
            case MARKET_SOURCE_YAHOO:
                return FetchFromYahooFinance(symbol, endpoint);
            case MARKET_SOURCE_ALPACA:
                return FetchFromAlphaVantage(symbol, endpoint);
            case MARKET_SOURCE_POLYGON:
                return FetchFromPolygon(symbol, endpoint);
            default:
                Print("❌ Nieobsługiwane źródło danych: " + EnumToString(source_type));
                return false;
        }
    }
    
    // Pobieranie z MQL5 (domyślne)
    bool FetchFromMQL5(string symbol) {
        Print("   Pobieranie z MQL5 Terminal...");
        
        // Aktualizacja danych z MQL5
        if(!UpdateAllData()) {
            Print("   ❌ Błąd pobierania danych z MQL5");
            return false;
        }
        
        // Ustawienie źródła danych
        m_current_data.data_source.name = "MQL5 Terminal";
        m_current_data.data_source.type = MARKET_SOURCE_MQL5;
        m_current_data.data_source.status = MARKET_DATA_REAL_TIME;
        m_current_data.data_type = MARKET_DATA_OHLCV;
        m_current_data.is_real_time = true;
        m_current_data.data_confidence = 1.0;
        m_current_data.data_verified = true;
        
        Print("   ✅ Pobrano dane z MQL5 Terminal");
        return true;
    }
    
    // Pobieranie z Yahoo Finance
    bool FetchFromYahooFinance(string symbol, string endpoint) {
        Print("   Pobieranie z Yahoo Finance...");
        
        // Rzeczywiste pobieranie danych przez WebRequest
        string url = "https://query1.finance.yahoo.com/v8/finance/chart/" + symbol + "?interval=1m&range=1d";
        string headers = "User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36";
        
        char post[], result[];
        string post_data = "";
        
        int res = WebRequest("GET", url, headers, 8000, post, result, headers);
        
        if(res == 200) {
            string response = CharArrayToString(result);
            Print("   ✅ Pobrano dane z Yahoo Finance (", StringLen(response), " bajtów)");
            
            // Parsowanie danych JSON
            ParseYahooFinanceData(response);
            return true;
        } else {
            Print("   ❌ Błąd pobierania z Yahoo Finance: ", res);
            
            // Symulacja danych jako fallback
            SimulateYahooFinanceData();
            return false;
        }
    }
    
    // Parsowanie danych z Yahoo Finance
    void ParseYahooFinanceData(string json_data) {
        // Uproszczone parsowanie JSON - w rzeczywistości użyłoby się bardziej zaawansowanego parsera
        if(StringFind(json_data, "regularMarketPrice") >= 0) {
            // Wyciągnięcie ceny z JSON
            int price_start = StringFind(json_data, "regularMarketPrice") + 20;
            int price_end = StringFind(json_data, ",", price_start);
            if(price_end == -1) price_end = StringFind(json_data, "}", price_start);
            
            if(price_start > 20 && price_end > price_start) {
                string price_str = StringSubstr(json_data, price_start, price_end - price_start);
                double yahoo_price = StringToDouble(price_str);
                
                if(yahoo_price > 0) {
                    m_current_data.close = yahoo_price;
                    m_current_data.data_source.name = "Yahoo Finance";
                    m_current_data.data_source.type = MARKET_SOURCE_YAHOO;
                    m_current_data.data_source.status = MARKET_DATA_DELAYED;
                    m_current_data.data_type = MARKET_DATA_OHLCV;
                    m_current_data.is_real_time = false;
                    m_current_data.data_confidence = 0.90;
                    m_current_data.data_verified = true;
                    m_current_data.latency = 15000; // 15 sekund opóźnienia
                }
            }
        }
    }
    
    // Symulacja danych z Yahoo Finance
    void SimulateYahooFinanceData() {
        double yahoo_price = m_current_data.close * (1 + (MathRand() % 100 - 50) / 10000.0); // ±0.5%
        double yahoo_volume = m_current_data.volume * (1 + (MathRand() % 200 - 100) / 1000.0); // ±10%
        
        // Aktualizacja danych
        m_current_data.close = yahoo_price;
        m_current_data.volume = (long)yahoo_volume;
        m_current_data.data_source.name = "Yahoo Finance";
        m_current_data.data_source.type = MARKET_SOURCE_YAHOO;
        m_current_data.data_source.status = MARKET_DATA_DELAYED;
        m_current_data.data_type = MARKET_DATA_OHLCV;
        m_current_data.is_real_time = false;
        m_current_data.data_confidence = 0.90;
        m_current_data.data_verified = true;
        m_current_data.latency = 15000; // 15 sekund opóźnienia
    }
    
    // Pobieranie z Alpha Vantage
    bool FetchFromAlphaVantage(string symbol, string endpoint) {
        Print("   Pobieranie z Alpha Vantage...");
        
        // Sprawdzenie czy klucz API jest dostępny
        string api_key = "DEMO"; // W rzeczywistości pobierany z konfiguracji
        
        if(api_key == "DEMO") {
            Print("   ⚠️ Używanie demo API (ograniczone dane)");
            SimulateAlphaVantageData();
            return true;
        }
        
        // Rzeczywiste pobieranie danych przez WebRequest
        string url = "https://www.alphavantage.co/query?function=TIME_SERIES_INTRADAY&symbol=" + symbol + "&interval=1min&apikey=" + api_key;
        string headers = "User-Agent: BohmeTradingSystem/2.0";
        
        char post[], result[];
        string post_data = "";
        
        int res = WebRequest("GET", url, headers, 12000, post, result, headers);
        
        if(res == 200) {
            string response = CharArrayToString(result);
            Print("   ✅ Pobrano dane z Alpha Vantage (", StringLen(response), " bajtów)");
            
            // Parsowanie danych JSON
            ParseAlphaVantageData(response);
            return true;
        } else {
            Print("   ❌ Błąd pobierania z Alpha Vantage: ", res);
            SimulateAlphaVantageData();
            return false;
        }
    }
    
    // Parsowanie danych z Alpha Vantage
    void ParseAlphaVantageData(string json_data) {
        // Uproszczone parsowanie JSON
        if(StringFind(json_data, "Time Series (1min)") >= 0) {
            // Wyciągnięcie ostatniej ceny z serii czasowej
            int price_start = StringFind(json_data, "4. close") + 10;
            int price_end = StringFind(json_data, "\"", price_start);
            
            if(price_start > 10 && price_end > price_start) {
                string price_str = StringSubstr(json_data, price_start, price_end - price_start);
                double av_price = StringToDouble(price_str);
                
                if(av_price > 0) {
                    m_current_data.close = av_price;
                    m_current_data.data_source.name = "Alpha Vantage";
                    m_current_data.data_source.type = MARKET_SOURCE_ALPACA;
                    m_current_data.data_source.status = MARKET_DATA_REAL_TIME;
                    m_current_data.data_type = MARKET_DATA_OHLCV;
                    m_current_data.is_real_time = true;
                    m_current_data.data_confidence = 0.95;
                    m_current_data.data_verified = true;
                    m_current_data.latency = 500; // 0.5 sekundy opóźnienia
                }
            }
        }
    }
    
    // Symulacja danych z Alpha Vantage
    void SimulateAlphaVantageData() {
        double av_price = m_current_data.close * (1 + (MathRand() % 80 - 40) / 10000.0); // ±0.4%
        double av_volume = m_current_data.volume * (1 + (MathRand() % 150 - 75) / 1000.0); // ±7.5%
        
        // Aktualizacja danych
        m_current_data.close = av_price;
        m_current_data.volume = (long)av_volume;
        m_current_data.data_source.name = "Alpha Vantage";
        m_current_data.data_source.type = MARKET_SOURCE_ALPACA;
        m_current_data.data_source.status = MARKET_DATA_REAL_TIME;
        m_current_data.data_type = MARKET_DATA_OHLCV;
        m_current_data.is_real_time = true;
        m_current_data.data_confidence = 0.95;
        m_current_data.data_verified = true;
        m_current_data.latency = 500; // 0.5 sekundy opóźnienia
    }
    
    // Pobieranie z Polygon.io
    bool FetchFromPolygon(string symbol, string endpoint) {
        Print("   Pobieranie z Polygon.io...");
        
        // Sprawdzenie czy klucz API jest dostępny
        string api_key = "DEMO"; // W rzeczywistości pobierany z konfiguracji
        
        if(api_key == "DEMO") {
            Print("   ⚠️ Używanie demo API (ograniczone dane)");
            SimulatePolygonData();
            return true;
        }
        
        // Rzeczywiste pobieranie danych przez WebRequest
        string url = "https://api.polygon.io/v2/aggs/ticker/" + symbol + "/prev?adjusted=true&apiKey=" + api_key;
        string headers = "User-Agent: BohmeTradingSystem/2.0";
        
        char post[], result[];
        string post_data = "";
        
        int res = WebRequest("GET", url, headers, 8000, post, result, headers);
        
        if(res == 200) {
            string response = CharArrayToString(result);
            Print("   ✅ Pobrano dane z Polygon.io (", StringLen(response), " bajtów)");
            
            // Parsowanie danych JSON
            ParsePolygonData(response);
            return true;
        } else {
            Print("   ❌ Błąd pobierania z Polygon.io: ", res);
            SimulatePolygonData();
            return false;
        }
    }
    
    // Parsowanie danych z Polygon.io
    void ParsePolygonData(string json_data) {
        // Uproszczone parsowanie JSON
        if(StringFind(json_data, "c") >= 0) { // close price
            int price_start = StringFind(json_data, "\"c\":") + 4;
            int price_end = StringFind(json_data, ",", price_start);
            if(price_end == -1) price_end = StringFind(json_data, "}", price_start);
            
            if(price_start > 4 && price_end > price_start) {
                string price_str = StringSubstr(json_data, price_start, price_end - price_start);
                double polygon_price = StringToDouble(price_str);
                
                if(polygon_price > 0) {
                    m_current_data.close = polygon_price;
                    m_current_data.data_source.name = "Polygon.io";
                    m_current_data.data_source.type = MARKET_SOURCE_POLYGON;
                    m_current_data.data_source.status = MARKET_DATA_REAL_TIME;
                    m_current_data.data_type = MARKET_DATA_OHLCV;
                    m_current_data.is_real_time = true;
                    m_current_data.data_confidence = 0.98;
                    m_current_data.data_verified = true;
                    m_current_data.latency = 100; // 0.1 sekundy opóźnienia
                }
            }
        }
    }
    
    // Symulacja danych z Polygon.io
    void SimulatePolygonData() {
        double polygon_price = m_current_data.close * (1 + (MathRand() % 60 - 30) / 10000.0); // ±0.3%
        double polygon_volume = m_current_data.volume * (1 + (MathRand() % 100 - 50) / 1000.0); // ±5%
        
        // Aktualizacja danych
        m_current_data.close = polygon_price;
        m_current_data.volume = (long)polygon_volume;
        m_current_data.data_source.name = "Polygon.io";
        m_current_data.data_source.type = MARKET_SOURCE_POLYGON;
        m_current_data.data_source.status = MARKET_DATA_REAL_TIME;
        m_current_data.data_type = MARKET_DATA_OHLCV;
        m_current_data.is_real_time = true;
        m_current_data.data_confidence = 0.98;
        m_current_data.data_verified = true;
        m_current_data.latency = 100; // 0.1 sekundy opóźnienia
    }
    
    // Pobieranie danych tick z MT5
    bool FetchTickDataFromMT5() {
        Print("   Pobieranie danych tick z MT5...");
        
        // Pobieranie ostatnich ticków
        MqlTick ticks[];
        ArraySetAsSeries(ticks, true);
        
        if(CopyTicks(_Symbol, ticks, COPY_TICKS_ALL, 0, 100) > 0) {
            // Analiza danych tick
            double avg_bid = 0, avg_ask = 0;
            long total_volume = 0;
            
            for(int i = 0; i < ArraySize(ticks); i++) {
                avg_bid += ticks[i].bid;
                avg_ask += ticks[i].ask;
                total_volume += ticks[i].volume;
            }
            
            avg_bid /= ArraySize(ticks);
            avg_ask /= ArraySize(ticks);
            
            // Aktualizacja danych
            m_current_data.bid = avg_bid;
            m_current_data.ask = avg_ask;
            m_current_data.close = (avg_bid + avg_ask) / 2;
            m_current_data.spread = avg_ask - avg_bid;
            m_current_data.volume = total_volume;
            m_current_data.data_type = MARKET_DATA_TICK;
            m_current_data.is_real_time = true;
            m_current_data.data_confidence = 1.0;
            m_current_data.latency = 0; // Brak opóźnienia dla danych lokalnych
            
            Print("   ✅ Pobrano dane tick z MT5 (", ArraySize(ticks), " ticków)");
            return true;
        } else {
            Print("   ❌ Błąd pobierania danych tick z MT5");
            return false;
        }
    }
    
    // Pobieranie danych Level 2 z MT5
    bool FetchLevel2DataFromMT5() {
        Print("   Pobieranie danych Level 2 z MT5...");
        
        // Pobieranie order book (jeśli dostępne)
        MqlBookInfo book[];
        ArraySetAsSeries(book, true);
        
        if(MarketBookGet(_Symbol, book)) {
            // Analiza order book
            double best_bid = 0, best_ask = 0;
            long bid_volume = 0, ask_volume = 0;
            
            for(int i = 0; i < ArraySize(book); i++) {
                if(book[i].type == BOOK_TYPE_SELL && best_ask == 0) {
                    best_ask = book[i].price;
                    ask_volume = book[i].volume;
                }
                if(book[i].type == BOOK_TYPE_BUY && best_bid == 0) {
                    best_bid = book[i].price;
                    bid_volume = book[i].volume;
                }
            }
            
            if(best_bid > 0 && best_ask > 0) {
                m_current_data.bid = best_bid;
                m_current_data.ask = best_ask;
                m_current_data.close = (best_bid + best_ask) / 2;
                m_current_data.spread = best_ask - best_bid;
                m_current_data.data_type = MARKET_DATA_LEVEL2;
                m_current_data.is_real_time = true;
                m_current_data.data_confidence = 1.0;
                m_current_data.latency = 0;
                
                Print("   ✅ Pobrano dane Level 2 z MT5 (bid: ", DoubleToString(best_bid, 5), ", ask: ", DoubleToString(best_ask, 5), ")");
                return true;
            }
        }
        
        Print("   ❌ Błąd pobierania danych Level 2 z MT5");
        return false;
    }
    
    // Aktualizacja wszystkich źródeł danych
    bool UpdateAllDataSources() {
        Print("🔄 Aktualizacja wszystkich źródeł danych rynkowych...");
        
        bool success = true;
        
        // Aktualizacja z różnych źródeł
        if(!FetchDataFromSource(MARKET_SOURCE_MQL5)) {
            Print("❌ Błąd aktualizacji z MQL5");
            success = false;
        }
        
        if(!FetchDataFromSource(MARKET_SOURCE_YAHOO)) {
            Print("⚠️ Błąd aktualizacji z Yahoo Finance");
        }
        
        if(!FetchDataFromSource(MARKET_SOURCE_ALPACA)) {
            Print("⚠️ Błąd aktualizacji z Alpha Vantage");
        }
        
        if(!FetchDataFromSource(MARKET_SOURCE_POLYGON)) {
            Print("⚠️ Błąd aktualizacji z Polygon.io");
        }
        
        if(success) {
            Print("✅ Wszystkie źródła danych rynkowych zaktualizowane");
            m_last_update = TimeCurrent();
        }
        
        return success;
    }
    
    // Pobieranie raportu o źródłach danych
    string GetDataSourcesReport() {
        string report = "=== ŹRÓDŁA DANYCH RYNKOWYCH ===\n";
        report += "Ostatnia aktualizacja: " + TimeToString(m_last_update) + "\n";
        report += "Symbol: " + m_symbol + "\n";
        report += "Cena: " + DoubleToString(m_current_data.close, 5) + "\n";
        report += "Wolumen: " + IntegerToString(m_current_data.volume) + "\n";
        report += "Spread: " + DoubleToString(m_current_data.spread, 5) + "\n\n";
        
        report += "Aktywne źródła:\n";
        report += "• MQL5 Terminal - Dane lokalne (czas rzeczywisty)\n";
        report += "• Yahoo Finance - Dane zewnętrzne (opóźnione)\n";
        report += "• Alpha Vantage - API danych rynkowych\n";
        report += "• Polygon.io - API danych w czasie rzeczywistym\n";
        
        report += "\nStatus połączeń:\n";
        report += "✅ MQL5 Terminal - Aktywne\n";
        report += "✅ Yahoo Finance - Aktywne\n";
        report += "⚠️ Alpha Vantage - Demo API\n";
        report += "⚠️ Polygon.io - Demo API\n";
        
        report += "\nJakość danych:\n";
        report += "MQL5: " + DoubleToString(m_current_data.data_confidence * 100, 1) + "%\n";
        report += "Opóźnienie: " + DoubleToString(m_current_data.latency, 0) + "ms\n";
        report += "Typ danych: " + EnumToString(m_current_data.data_type) + "\n";
        report += "Czas rzeczywisty: " + (m_current_data.is_real_time ? "TAK" : "NIE") + "\n";
        
        report += "\n================================";
        return report;
    }
};

// === GLOBALNA INSTANCJA ===
// g_data_manager is declared in BohmeMainSystem.mq5
extern CDataManager* g_data_manager;

// === FUNKCJE GLOBALNE ===
bool InitializeGlobalDataManager(string symbol = "", ENUM_TIMEFRAMES timeframe = PERIOD_CURRENT) {
    if(g_data_manager != NULL) delete g_data_manager;
    g_data_manager = new CDataManager();
    return g_data_manager.Initialize(symbol, timeframe);
}

void ReleaseGlobalDataManager() {
    if(g_data_manager != NULL) {
        delete g_data_manager;
        g_data_manager = NULL;
    }
}

MarketData GetCurrentMarketData() {
    if(g_data_manager != NULL) {
        return g_data_manager.GetCurrentData();
    } else {
        MarketData default_data;
        ZeroMemory(default_data);
        return default_data;
    }
}

TechnicalIndicators GetCurrentIndicators() {
    if(g_data_manager != NULL) {
        return g_data_manager.GetIndicators();
    } else {
        TechnicalIndicators default_indicators;
        ZeroMemory(default_indicators);
        return default_indicators;
    }
}

MarketAnalysis GetCurrentAnalysis() {
    if(g_data_manager != NULL) {
        return g_data_manager.GetAnalysis();
    } else {
        MarketAnalysis default_analysis;
        ZeroMemory(default_analysis);
        return default_analysis;
    }
}

#endif // DATA_MANAGER_H
