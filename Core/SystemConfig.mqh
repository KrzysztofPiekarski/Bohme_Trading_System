#ifndef SYSTEM_CONFIG_H
#define SYSTEM_CONFIG_H

// ========================================
// KONFIGURACJA SYSTEMU BÖHMEGO
// ========================================

#include "../Utils/LoggingSystem.mqh"

// Globalne ustawienia systemu
struct SystemConfig {
    // === PODSTAWOWE PARAMETRY ===
    double confidence_threshold;      // Próg pewności dla decyzji (0-100)
    double alignment_threshold;       // Próg zgodności duchów (0-100)
    double max_risk_per_trade;       // Maksymalne ryzyko na transakcję (%)
    double max_daily_risk;           // Maksymalne dzienne ryzyko (%)
    double min_position_size;        // Minimalny rozmiar pozycji
    double max_position_size;        // Maksymalny rozmiar pozycji
    bool learning_enabled;           // Czy włączyć uczenie systemu
    bool evolution_enabled;          // Czy włączyć ewolucję parametrów
    
    // === AKTYWACJA DUCHÓW ===
    bool enable_herbe_spirit;        // Duch Cierpkości - fundamentalne napięcia
    bool enable_sweetness_spirit;    // Duch Słodyczy - harmonia nastrojów
    bool enable_bitterness_spirit;   // Duch Goryczki - momentum i przełomy
    bool enable_fire_spirit;         // Duch Ognia - intensywność i energia
    bool enable_light_spirit;        // Duch Światła - jasność sygnałów
    bool enable_sound_spirit;        // Duch Dźwięku - harmonia cykli
    bool enable_body_spirit;         // Duch Ciała - wykonanie transakcji
    
    // === WAGI DUCHÓW (0.0 - 2.0) ===
    double herbe_weight;             // Waga Ducha Cierpkości
    double sweetness_weight;         // Waga Ducha Słodyczy
    double bitterness_weight;        // Waga Ducha Goryczki
    double fire_weight;              // Waga Ducha Ognia
    double light_weight;             // Waga Ducha Światła
    double sound_weight;             // Waga Ducha Dźwięku
    double body_weight;              // Waga Ducha Ciała
    
    // === PARAMETRY MASTER CONSCIOUSNESS ===
    int transformer_heads;           // Liczba głów w transformerze
    int transformer_layers;          // Liczba warstw w transformerze
    int system_memory_size;          // Rozmiar pamięci systemowej
    double learning_rate;            // Szybkość uczenia
    
    // === PARAMETRY ZARZĄDZANIA RYZYKIEM ===
    double stop_loss_multiplier;     // Mnożnik stop loss
    double take_profit_multiplier;   // Mnożnik take profit
    double trailing_stop_distance;   // Odległość trailing stop
    bool use_trailing_stop;          // Czy używać trailing stop
    
    // === PARAMETRY CZASOWE ===
    int analysis_interval;           // Interwał analizy (sekundy)
    int model_update_interval;       // Interwał aktualizacji modeli (godziny)
    int evolution_interval;          // Interwał ewolucji (dni)
    
    // === PARAMETRY DIAGNOSTYKI ===
    bool enable_debug_logging;       // Czy włączyć szczegółowe logowanie
    bool enable_performance_tracking; // Czy śledzić wydajność
    int max_history_size;            // Maksymalny rozmiar historii
    
    // === PARAMETRY LOGOWANIA ===
    bool enable_logging_system;      // Czy włączyć system logowania
    ENUM_LOG_LEVEL logging_level;    // Poziom logowania
    bool enable_log_file_output;     // Czy zapisywać do pliku
    bool enable_log_console_output;  // Czy wyświetlać w konsoli
    bool enable_log_performance;     // Czy logować wydajność
    bool enable_log_risk;            // Czy logować ryzyko
    bool enable_log_trade;           // Czy logować transakcje
    bool enable_log_ai;              // Czy logować AI
    int max_log_entries;             // Maksymalna liczba wpisów logów
    string log_file_path;            // Ścieżka do pliku logów
};

// === GLOBALNA INSTANCJA KONFIGURACJI ===
// g_config jest zdefiniowany w BohmeMainSystem.mq5
extern SystemConfig g_config;

// === FUNKCJE POMOCNICZE KONFIGURACJI ===

// Sprawdzenie czy konfiguracja jest poprawna
bool ValidateSystemConfig(SystemConfig &config) {
    // Sprawdź podstawowe parametry
    if(config.confidence_threshold < 0 || config.confidence_threshold > 100) {
        Print("❌ Błąd: confidence_threshold musi być między 0 a 100");
        return false;
    }
    
    if(config.max_risk_per_trade <= 0 || config.max_risk_per_trade > 10) {
        Print("❌ Błąd: max_risk_per_trade musi być między 0 a 10%");
        return false;
    }
    
    if(config.max_daily_risk <= 0 || config.max_daily_risk > 20) {
        Print("❌ Błąd: max_daily_risk musi być między 0 a 20%");
        return false;
    }
    
    // Sprawdź wagi duchów
    double weights[] = {config.herbe_weight, config.sweetness_weight, config.bitterness_weight,
                       config.fire_weight, config.light_weight, config.sound_weight, config.body_weight};
    
    for(int i = 0; i < 7; i++) {
        if(weights[i] < 0 || weights[i] > 2) {
            Print("❌ Błąd: waga ducha ", i, " musi być między 0 a 2");
            return false;
        }
    }
    
    // Sprawdź czy przynajmniej jeden duch jest włączony
    bool any_spirit_enabled = config.enable_herbe_spirit || config.enable_sweetness_spirit ||
                             config.enable_bitterness_spirit || config.enable_fire_spirit ||
                             config.enable_light_spirit || config.enable_sound_spirit ||
                             config.enable_body_spirit;
    
    if(!any_spirit_enabled) {
        Print("❌ Błąd: przynajmniej jeden duch musi być włączony");
        return false;
    }
    
    Print("✅ Konfiguracja systemu Böhmego jest poprawna");
    return true;
}

// Funkcja do resetowania konfiguracji do domyślnych wartości
void ResetToDefaultConfig(SystemConfig &config) {
    config = g_config;
    Print("🔄 Konfiguracja zresetowana do wartości domyślnych");
}

// Funkcja do dostosowania wag duchów
void AdjustSpiritWeights(SystemConfig &config, double herbe, double sweetness, double bitterness,
                        double fire, double light, double sound, double body) {
    config.herbe_weight = MathMax(0.0, MathMin(2.0, herbe));
    config.sweetness_weight = MathMax(0.0, MathMin(2.0, sweetness));
    config.bitterness_weight = MathMax(0.0, MathMin(2.0, bitterness));
    config.fire_weight = MathMax(0.0, MathMin(2.0, fire));
    config.light_weight = MathMax(0.0, MathMin(2.0, light));
    config.sound_weight = MathMax(0.0, MathMin(2.0, sound));
    config.body_weight = MathMax(0.0, MathMin(2.0, body));
    
    Print("⚖️ Wagi duchów dostosowane");
}

// Funkcja do generowania raportu konfiguracji
string GenerateConfigReport(SystemConfig &config) {
    string report = "=== KONFIGURACJA SYSTEMU BÖHMEGO ===\n";
    report += "Próg pewności: " + DoubleToString(config.confidence_threshold, 1) + "%\n";
    report += "Próg zgodności: " + DoubleToString(config.alignment_threshold, 1) + "%\n";
    report += "Maks. ryzyko/transakcja: " + DoubleToString(config.max_risk_per_trade, 1) + "%\n";
    report += "Maks. ryzyko dzienne: " + DoubleToString(config.max_daily_risk, 1) + "%\n";
    report += "Uczenie: " + (config.learning_enabled ? "WŁĄCZONE" : "WYŁĄCZONE") + "\n";
    report += "Ewolucja: " + (config.evolution_enabled ? "WŁĄCZONA" : "WYŁĄCZONA") + "\n";
    report += "\n=== AKTYWNE DUCHY ===\n";
    report += "Duch Cierpkości: " + (config.enable_herbe_spirit ? "AKTYWNY" : "NIEAKTYWNY") + 
              " (waga: " + DoubleToString(config.herbe_weight, 1) + ")\n";
    report += "Duch Słodyczy: " + (config.enable_sweetness_spirit ? "AKTYWNY" : "NIEAKTYWNY") + 
              " (waga: " + DoubleToString(config.sweetness_weight, 1) + ")\n";
    report += "Duch Goryczki: " + (config.enable_bitterness_spirit ? "AKTYWNY" : "NIEAKTYWNY") + 
              " (waga: " + DoubleToString(config.bitterness_weight, 1) + ")\n";
    report += "Duch Ognia: " + (config.enable_fire_spirit ? "AKTYWNY" : "NIEAKTYWNY") + 
              " (waga: " + DoubleToString(config.fire_weight, 1) + ")\n";
    report += "Duch Światła: " + (config.enable_light_spirit ? "AKTYWNY" : "NIEAKTYWNY") + 
              " (waga: " + DoubleToString(config.light_weight, 1) + ")\n";
    report += "Duch Dźwięku: " + (config.enable_sound_spirit ? "AKTYWNY" : "NIEAKTYWNY") + 
              " (waga: " + DoubleToString(config.sound_weight, 1) + ")\n";
    report += "Duch Ciała: " + (config.enable_body_spirit ? "AKTYWNY" : "NIEAKTYWNY") + 
              " (waga: " + DoubleToString(config.body_weight, 1) + ")\n";
    report += "================================";
    
    return report;
}

// === FUNKCJE INICJALIZACJI LOGOWANIA ===

// Inicjalizacja systemu logowania na podstawie konfiguracji
bool InitializeSystemLogging(SystemConfig &config) {
    if(!config.enable_logging_system) {
        Print("📝 System logowania wyłączony w konfiguracji");
        return true;
    }
    
    // Konfiguracja logowania
    SLogConfig log_config;
    log_config.enable_logging = config.enable_logging_system;
    log_config.min_level = config.logging_level;
    log_config.enable_console_output = config.enable_log_console_output;
    log_config.enable_file_output = config.enable_log_file_output;
    log_config.enable_performance_logging = config.enable_log_performance;
    log_config.enable_risk_logging = config.enable_log_risk;
    log_config.enable_trade_logging = config.enable_log_trade;
    log_config.enable_ai_logging = config.enable_log_ai;
    log_config.max_log_entries = config.max_log_entries;
    log_config.log_file_path = config.log_file_path;
    log_config.enable_timestamp = true;
    log_config.enable_component_prefix = true;
    log_config.enable_emoji = true;
    log_config.enable_color = false;
    
    // Inicjalizacja globalnego loggera
    bool success = InitializeGlobalLogger(log_config);
    
    if(success) {
        LogInfo(LOG_COMPONENT_SYSTEM, "System logowania zainicjalizowany", 
                "Poziom: " + EnumToString(config.logging_level) + 
                ", Plik: " + config.log_file_path);
    } else {
        Print("❌ Błąd inicjalizacji systemu logowania");
    }
    
    return success;
}

// Funkcja do zamykania systemu logowania
void ShutdownSystemLogging() {
    if(g_logger != NULL) {
        LogInfo(LOG_COMPONENT_SYSTEM, "Zamykanie systemu logowania");
        FlushLogs();
        DestroyGlobalLogger();
        Print("📝 System logowania zamknięty");
    }
}

// Funkcja do aktualizacji konfiguracji logowania
void UpdateLoggingConfig(SystemConfig &config) {
    if(g_logger != NULL) {
        SLogConfig log_config;
        log_config.enable_logging = config.enable_logging_system;
        log_config.min_level = config.logging_level;
        log_config.enable_console_output = config.enable_log_console_output;
        log_config.enable_file_output = config.enable_log_file_output;
        log_config.enable_performance_logging = config.enable_log_performance;
        log_config.enable_risk_logging = config.enable_log_risk;
        log_config.enable_trade_logging = config.enable_log_trade;
        log_config.enable_ai_logging = config.enable_log_ai;
        log_config.max_log_entries = config.max_log_entries;
        log_config.log_file_path = config.log_file_path;
        log_config.enable_timestamp = true;
        log_config.enable_component_prefix = true;
        log_config.enable_emoji = true;
        log_config.enable_color = false;
        
        g_logger.SetConfig(log_config);
        LogInfo(LOG_COMPONENT_SYSTEM, "Konfiguracja logowania zaktualizowana");
    }
}

#endif // SYSTEM_CONFIG_H
