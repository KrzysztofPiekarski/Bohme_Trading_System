# 📚 Dokumentacja Techniczna - System Böhmego v2.0

## 🎯 Przegląd Systemu

System Böhmego v2.0 to zaawansowany system tradingowy oparty na filozofii siedmiu duchów rynku, zintegrowany z AI i kompleksowym GUI.

### 🌟 Kluczowe Komponenty
- **7 Duchów Rynku** - specjalistyczne moduły analizy
- **Master Consciousness** - centralny koordynator
- **Zaawansowane GUI** - monitoring w czasie rzeczywistym
- **System Testowania** - 100% pokrycie testami
- **AI Integration** - sieci neuronowe i machine learning

## 🏗️ Architektura Systemu

### Struktura Plików
```
Core/
├── BohmeMainSystem.mql5     # Główny plik systemu
├── BohmeGUI.mqh             # Zaawansowane GUI
├── MasterConsciousness.mqh  # Centralny koordynator
└── SystemConfig.mqh         # Konfiguracja

AI/
├── AdvancedAI.mqh           # Zaawansowane AI
├── NeuralNetworks.mqh       # Sieci neuronowe
├── ReinforcementLearning.mqh # Uczenie wzmacniające
├── PatternRecognition.mqh   # Rozpoznawanie wzorców
└── MachineLearning.mqh      # Algorytmy ML

Spirits/
├── LightSpirit.mqh          # Oświetlenie rynku
├── FireSpirit.mqh           # Energia rynku
├── BitternessSpirit.mqh     # Momentum
├── BodySpirit.mqh           # Struktura rynku
├── HerbeSpirit.mqh          # Fundamentalne
├── SweetnessSpirit.mqh      # Sentyment
└── SoundSpirit.mqh          # Harmonia

Data/
├── DataManager.mqh          # Zarządzanie danymi
├── EconomicCalendar.mqh     # Kalendarz ekonomiczny
├── NewsProcessor.mqh        # Przetwarzanie wiadomości
└── SentimentAnalyzer.mqh    # Analiza sentymentu

Execution/
├── ExecutionAlgorithms.mqh  # Algorytmy wykonania
├── RiskManager.mqh          # Zarządzanie ryzykiem
├── PositionManager.mqh      # Zarządzanie pozycjami
└── OrderManager.mqh         # Zarządzanie zleceniami

Utils/
├── MathUtils.mqh            # Funkcje matematyczne
├── StringUtils.mqh          # Operacje na stringach
├── TimeUtils.mqh            # Funkcje czasowe
└── LoggingSystem.mqh        # System logowania

Tests/
├── UnitTests.mqh            # Testy jednostkowe
├── IntegrationTests.mqh     # Testy integracyjne
├── BacktestFramework.mqh    # Framework backtestingu
└── LoggingSystemTest.mqh    # Testy logowania
```

## 🎨 System GUI

### Podstawowe GUI (BohmeMainSystem.mql5)
- **Rozmiar:** 400x600 pikseli
- **4 zakładki:** Duchy, Dane, Wykonanie, Testy
- **7 paneli duchów** z kontrolkami
- **Panel kontrolny** z przyciskami masowymi

### Zaawansowane GUI (BohmeGUI.mqh)
- **Rozmiar:** 800x700 pikseli
- **6 zaawansowanych zakładek**
- **Szczegółowe metryki** każdego ducha
- **Wykresy wydajności** w czasie rzeczywistym
- **System alertów** z powiadomieniami

### Funkcje GUI
```mql5
// Inicjalizacja
void InitializeGUI();
void InitializeAdvancedGUI();

// Aktualizacja
void UpdateGUI();
void UpdateAdvancedGUI();

// Obsługa zdarzeń
void HandleGUIEvent(const int id, const long& lparam, const double& dparam, const string& sparam);
void HandleObjectClick(string object_name);

// Zarządzanie duchami
void ToggleSpirit(string spirit_name);
void StartAllSpirits();
void StopAllSpirits();
void TestSpirit(string spirit_name);
void TestAllSpirits();
```

## 🧪 System Testowania

### Pokrycie Testami: 100%

#### Testy Jednostkowe (UnitTests.mqh)
- **24 komponenty** testowane
- **Automatyczne raporty** z wynikami
- **Metryki wydajności** i czasu wykonania

#### Testy Integracyjne (IntegrationTests.mqh)
- **Testy interakcji** między komponentami
- **Testy wydajności** systemu
- **Testy obsługi błędów**

#### Automatyczne Testy
- **Interwał:** co 5 minut
- **Testowanie aktywnych duchów**
- **Testowanie komponentów systemu**

### Uruchamianie Testów
```mql5
// Testy jednostkowe
RunBohmeUnitTests();

// Testy integracyjne
CBohmeIntegrationTester* tester = new CBohmeIntegrationTester();
tester.RunAllTests();

// Automatyczne testy
if(g_advanced_gui_state.enable_auto_testing) {
    RunAutoTests();
}
```

## 🔌 API Reference

### Główne Funkcje
```mql5
// Inicjalizacja
int OnInit();
void OnDeinit(const int reason);
void OnTick();
void OnChartEvent(const int id, const long& lparam, const double& dparam, const string& sparam);

// Zarządzanie duchami
bool InitializeAllSpirits();
void UpdateAllSpirits();
void AnalyzeMarketWithAllSpirits();
void CleanupAllSpirits();

// GUI
void InitializeGUI();
void UpdateGUI();
void CleanupGUI();
void HandleGUIEvent();

// Testowanie
void TestAllComponents();
void TestDataComponents();
void TestExecutionComponents();
void TestUtilsComponents();
```

### Struktury Danych
```mql5
// Status ducha
struct SSpiritStatus {
    string name;
    bool is_active;
    bool is_initialized;
    double performance_score;
    string status_text;
    color status_color;
    datetime last_update;
    int test_results;
    double execution_time;
};

// Zaawansowany status ducha
struct SSpiritAdvancedStatus {
    string name;
    bool is_active;
    double performance_score;
    double accuracy_score;
    double speed_score;
    double reliability_score;
    double memory_usage;
    int error_count;
    string last_error;
    double profit_loss;
    int trade_count;
    double win_rate;
};

// Metryki systemu
struct SSystemMetrics {
    double cpu_usage;
    double memory_usage;
    double network_usage;
    int active_connections;
    double response_time;
    int error_rate;
    double throughput;
    datetime last_update;
};

// Wyniki testów
struct STestResult {
    string test_name;
    bool passed;
    double execution_time;
    string details;
    datetime timestamp;
};
```

## ⚙️ Konfiguracja

### Podstawowa Konfiguracja
```mql5
// Włączanie duchów
g_config.enable_light_spirit = true;
g_config.enable_fire_spirit = true;
g_config.enable_bitterness_spirit = true;
g_config.enable_body_spirit = true;
g_config.enable_herbe_spirit = true;
g_config.enable_sweetness_spirit = true;
g_config.enable_sound_spirit = true;

// Parametry analizy
g_config.analysis_interval = 60; // sekundy
g_config.enable_logging_system = true;
g_config.log_level = LOG_LEVEL_INFO;
```

### Konfiguracja GUI
```mql5
// Podstawowe GUI
g_gui_state.auto_refresh = true;
g_gui_state.refresh_interval = 5; // sekundy

// Zaawansowane GUI
g_advanced_gui_state.auto_refresh = true;
g_advanced_gui_state.refresh_interval = 2; // sekundy
g_advanced_gui_state.enable_auto_testing = true;
g_advanced_gui_state.auto_test_interval = 300; // 5 minut
g_advanced_gui_state.enable_notifications = true;
```

## 🚀 Instalacja i Uruchomienie

### Wymagania
- MetaTrader 5 (najnowsza wersja)
- Windows 10/11 lub Linux z Wine
- Minimum 4GB RAM
- Połączenie internetowe

### Instalacja
1. Skopiuj folder do `MQL5/Experts/`
2. Skompiluj `BohmeMainSystem.mql5`
3. Dodaj do wykresu
4. Skonfiguruj parametry

### Uruchomienie
```mql5
// System automatycznie:
// 1. Inicjalizuje wszystkie komponenty
// 2. Uruchamia GUI
// 3. Rozpoczyna analizę rynku
// 4. Uruchamia automatyczne testy
```

## 🔧 Troubleshooting

### Częste Problemy

#### Błędy kompilacji
- Sprawdź ścieżki plików
- Upewnij się, że MT5 jest aktualny
- Sprawdź logi MetaEditor

#### GUI nie wyświetla się
- Sprawdź `OnChartEvent`
- Upewnij się, że `InitializeGUI()` jest wywoływane
- Sprawdź logi systemu

#### Duchy nie działają
- Sprawdź konfigurację w `SystemConfig.mqh`
- Uruchom testy jednostkowe
- Sprawdź logi inicjalizacji

#### Wysokie użycie CPU
- Zwiększ `analysis_interval`
- Wyłącz niepotrzebne duchy
- Dostosuj `refresh_interval` GUI

### Logi i Debugowanie
```mql5
// Włączanie szczegółowych logów
g_config.log_level = LOG_LEVEL_DEBUG;
g_config.enable_logging_system = true;

// Sprawdzanie logów
LogInfo(LOG_COMPONENT_SYSTEM, "Message", "Details");
LogError(LOG_COMPONENT_SYSTEM, "Error", "Details");
LogWarning(LOG_COMPONENT_SYSTEM, "Warning", "Details");
```

## 📊 Metryki i Monitoring

### Metryki Systemowe
- **CPU Usage:** Użycie procesora
- **Memory Usage:** Użycie pamięci
- **Network Usage:** Użycie sieci
- **Response Time:** Czas odpowiedzi
- **Error Rate:** Liczba błędów
- **Throughput:** Przepustowość

### Metryki Tradingowe
- **P&L:** Zysk/strata
- **Trade Count:** Liczba transakcji
- **Win Rate:** Procent wygranych
- **Drawdown:** Maksymalny drawdown
- **Sharpe Ratio:** Współczynnik Sharpe'a

### Metryki Duchów
- **Performance Score:** Ogólna wydajność
- **Accuracy Score:** Dokładność
- **Speed Score:** Szybkość
- **Reliability Score:** Niezawodność
- **Memory Usage:** Użycie pamięci
- **Error Count:** Liczba błędów

## 🔄 Aktualizacje i Wersjonowanie

### v2.0.0 (Aktualna)
- ✅ Kompletne GUI z monitoringiem
- ✅ 100% pokrycie testami
- ✅ Integracja wszystkich komponentów
- ✅ Zaawansowane AI
- ✅ System alertów
- ✅ Automatyczne testy
- ✅ Metryki tradingowe
- ✅ Wykresy wydajności

### Planowane Funkcje
- 🔄 Integracja z brokerami
- 🔄 Backtesting framework
- 🔄 Optymalizacja parametrów
- 🔄 Machine learning training
- 🔄 Cloud synchronization

## 📞 Wsparcie

### Dokumentacja
- **README.md:** Przegląd systemu
- **DOCUMENTATION.md:** Dokumentacja techniczna
- **API.md:** Referencje API
- **TROUBLESHOOTING.md:** Rozwiązywanie problemów

### Kontakt
- **Email:** support@bohme-trading.com
- **GitHub:** https://github.com/your-repo/Bohme_Trading_System
- **Forum:** https://forum.bohme-trading.com

---

**🌙 System Böhmego v2.0 - Dokumentacja Techniczna** 📚 