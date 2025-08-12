#ifndef LOGGING_SYSTEM_H
#define LOGGING_SYSTEM_H

// ========================================
// LOGGING SYSTEM - SYSTEM LOGOWANIA
// ========================================
// Centralny system logowania dla Systemu Böhmego
// Integruje logowanie wszystkich komponentów z poziomami, filtrowaniem i eksportem

#include <Trade\Trade.mqh>

// === ENUMERACJE ===

// Poziomy logowania
enum ENUM_LOG_LEVEL {
    LOG_LEVEL_DEBUG,     // Szczegółowe debugowanie
    LOG_LEVEL_INFO,      // Informacje ogólne
    LOG_LEVEL_WARNING,   // Ostrzeżenia
    LOG_LEVEL_ERROR,     // Błędy
    LOG_LEVEL_CRITICAL   // Błędy krytyczne
};

// Komponenty systemu
enum ENUM_LOG_COMPONENT {
    LOG_COMPONENT_SYSTEM,        // System główny
    LOG_COMPONENT_HERBE,         // Duch Herbe (sentiment)
    LOG_COMPONENT_SWEETNESS,     // Duch Sweetness (momentum)
    LOG_COMPONENT_BITTERNESS,    // Duch Bitterness (momentum)
    LOG_COMPONENT_FIRE,          // Duch Fire (volatility)
    LOG_COMPONENT_LIGHT,         // Duch Light (signals)
    LOG_COMPONENT_SOUND,         // Duch Sound (cycles)
    LOG_COMPONENT_BODY,          // Duch Body (execution)
    LOG_COMPONENT_MASTER,        // Master Consciousness
    LOG_COMPONENT_RISK,          // Risk Manager
    LOG_COMPONENT_POSITION,      // Position Manager
    LOG_COMPONENT_ORDER,         // Order Manager
    LOG_COMPONENT_EXECUTION,     // Execution Algorithms
    LOG_COMPONENT_AI,            // Master AI Controller
    LOG_COMPONENT_NEWS,          // News Processor
    LOG_COMPONENT_TEST,          // Testy
    LOG_COMPONENT_INTEGRATION    // Integracja systemu
};

// Typy logów
enum ENUM_LOG_TYPE {
    LOG_TYPE_GENERAL,    // Log ogólny
    LOG_TYPE_PERFORMANCE, // Log wydajności
    LOG_TYPE_RISK,       // Log ryzyka
    LOG_TYPE_TRADE,      // Log transakcji
    LOG_TYPE_AI,         // Log AI
    LOG_TYPE_ERROR,      // Log błędów
    LOG_TYPE_DEBUG       // Log debug
};

// === STRUKTURY DANYCH ===

// Struktura wpisu logu
struct SLogEntry {
    datetime timestamp;          // Timestamp
    ENUM_LOG_LEVEL level;        // Poziom logowania
    ENUM_LOG_COMPONENT component; // Komponent
    ENUM_LOG_TYPE type;          // Typ logu
    string message;              // Wiadomość
    string details;              // Szczegóły
    double value;                // Wartość numeryczna
    string data;                 // Dane dodatkowe
    string function_name;        // Nazwa funkcji
    string file_name;            // Nazwa pliku
};

// Struktura konfiguracji logowania
struct SLogConfig {
    bool enable_logging;         // Czy włączyć logowanie
    ENUM_LOG_LEVEL min_level;    // Minimalny poziom logowania
    bool enable_console_output;  // Czy wyświetlać w konsoli
    bool enable_file_output;     // Czy zapisywać do pliku
    bool enable_performance_logging; // Czy logować wydajność
    bool enable_risk_logging;    // Czy logować ryzyko
    bool enable_trade_logging;   // Czy logować transakcje
    bool enable_ai_logging;      // Czy logować AI
    int max_log_entries;         // Maksymalna liczba wpisów w pamięci
    string log_file_path;        // Ścieżka do pliku logów
    bool enable_timestamp;       // Czy dodawać timestamp
    bool enable_component_prefix; // Czy dodawać prefiks komponentu
    bool enable_emoji;           // Czy używać emoji
    bool enable_color;           // Czy używać kolorów
};

// Struktura statystyk logowania
struct SLogStats {
    int total_logs;              // Całkowita liczba logów
    int debug_logs;              // Liczba logów debug
    int info_logs;               // Liczba logów info
    int warning_logs;            // Liczba logów warning
    int error_logs;              // Liczba logów error
    int critical_logs;           // Liczba logów critical
    int performance_logs;        // Liczba logów wydajności
    int risk_logs;               // Liczba logów ryzyka
    int trade_logs;              // Liczba logów transakcji
    int ai_logs;                 // Liczba logów AI
    datetime first_log_time;     // Czas pierwszego logu
    datetime last_log_time;      // Czas ostatniego logu
    double average_log_interval; // Średni interwał między logami
};

// === KLASA GŁÓWNA LOGGING SYSTEM ===

class CLoggingSystem {
private:
    // Konfiguracja
    SLogConfig m_config;
    SLogStats m_stats;
    
    // Bufor logów w pamięci
    SLogEntry m_log_buffer[];
    int m_current_index;
    int m_total_logs;
    
    // Handle do pliku logów
    int m_log_file_handle;
    bool m_file_opened;
    
    // Cache
    datetime m_last_flush_time;
    bool m_initialized;
    
    // Callbacki usunięte
    
    // Metody prywatne - formatowanie
    string FormatLogEntry(SLogEntry &entry);
    string GetLevelString(ENUM_LOG_LEVEL level);
    string GetComponentString(ENUM_LOG_COMPONENT component);
    string GetTypeString(ENUM_LOG_TYPE type);
    string GetLevelEmoji(ENUM_LOG_LEVEL level);
    string GetComponentEmoji(ENUM_LOG_COMPONENT component);
    string GetTimestampString(datetime timestamp);
    
    // Metody prywatne - zarządzanie
    void AddLogEntry(SLogEntry &entry);
    void FlushToFile();
    void UpdateStats(SLogEntry &entry);
    void RotateLogFile();
    bool OpenLogFile();
    void CloseLogFile();
    
    // Metody prywatne - pomocnicze
    void InitializeDefaultConfig();
    bool ValidateConfig(SLogConfig &config);
    string SanitizeString(string text);
    
public:
    // === KONSTRUKTOR I DESTRUKTOR ===
    CLoggingSystem();
    ~CLoggingSystem();
    
    // === INICJALIZACJA ===
    bool Initialize(SLogConfig &config);
    void SetConfig(SLogConfig &config);
    SLogConfig GetConfig();
    
    // === GŁÓWNE METODY LOGOWANIA ===
    void Log(ENUM_LOG_LEVEL level, ENUM_LOG_COMPONENT component, ENUM_LOG_TYPE type, 
             string message, string details = "", double value = 0.0, string data = "");
    
    // === WYGODNE METODY LOGOWANIA ===
    void LogDebug(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0);
    void LogInfo(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0);
    void LogWarning(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0);
    void LogError(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0);
    void LogCritical(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0);
    
    // === SPECJALIZOWANE METODY LOGOWANIA ===
    void LogPerformance(ENUM_LOG_COMPONENT component, string operation, double execution_time, string details = "");
    void LogRisk(ENUM_LOG_COMPONENT component, string risk_type, double risk_value, string action = "");
    void LogTrade(ENUM_LOG_COMPONENT component, string action, double profit_loss, string details = "");
    void LogAI(ENUM_LOG_COMPONENT component, string prediction, double confidence, string reasoning = "");
    void LogIntegration(ENUM_LOG_COMPONENT component, string integration_type, string status, string details = "");
    
    // === ZARZĄDZANIE LOGAMI ===
    void Flush();
    void Clear();
    void Rotate();
    SLogEntry GetLogEntry(int index);
    void GetLogs(SLogEntry &logs[]);
    int GetLogCount();
    
    // === STATYSTYKI I RAPORTY ===
    SLogStats GetStats();
    string GetStatsReport();
    string GetLogReport(int max_entries = 100);
    void ExportLogs(string filename, ENUM_LOG_LEVEL min_level = LOG_LEVEL_DEBUG);
    void ExportLogsByComponent(string filename, ENUM_LOG_COMPONENT component);
    void ExportLogsByType(string filename, ENUM_LOG_TYPE type);
    
    // === FILTROWANIE I WYSZUKIWANIE ===
    void GetLogsByLevel(ENUM_LOG_LEVEL level, SLogEntry &logs[]);
    void GetLogsByComponent(ENUM_LOG_COMPONENT component, SLogEntry &logs[]);
    void GetLogsByType(ENUM_LOG_TYPE type, SLogEntry &logs[]);
    void GetLogsByTimeRange(datetime start_time, datetime end_time, SLogEntry &logs[]);
    void GetLogsByKeyword(string keyword, SLogEntry &logs[]);
    
    // Settery callbacków usunięte
    
    // === FUNKCJE POMOCNICZE ===
    bool IsLoggingEnabled();
    bool IsLevelEnabled(ENUM_LOG_LEVEL level);
    bool IsComponentEnabled(ENUM_LOG_COMPONENT component);
    bool IsTypeEnabled(ENUM_LOG_TYPE type);
    string GetLogFilePath();
    void SetLogFilePath(string file_path);
};

// === IMPLEMENTACJA KONSTRUKTORA I INICJALIZACJI ===

CLoggingSystem::CLoggingSystem() {
    m_initialized = false;
    m_current_index = 0;
    m_total_logs = 0;
    m_log_file_handle = INVALID_HANDLE;
    m_file_opened = false;
    m_last_flush_time = 0;
    
    // Inicjalizacja domyślnej konfiguracji
    InitializeDefaultConfig();
    
    // Inicjalizacja statystyk
    m_stats.total_logs = 0;
    m_stats.debug_logs = 0;
    m_stats.info_logs = 0;
    m_stats.warning_logs = 0;
    m_stats.error_logs = 0;
    m_stats.critical_logs = 0;
    m_stats.performance_logs = 0;
    m_stats.risk_logs = 0;
    m_stats.trade_logs = 0;
    m_stats.ai_logs = 0;
    m_stats.first_log_time = 0;
    m_stats.last_log_time = 0;
    m_stats.average_log_interval = 0.0;
    
    // Inicjalizacja bufora logów
    ArrayResize(m_log_buffer, m_config.max_log_entries);
    
    Print("📝 Logging System zainicjalizowany");
}

CLoggingSystem::~CLoggingSystem() {
    // Zapisanie pozostałych logów
    Flush();
    
    // Zamknięcie pliku logów
    CloseLogFile();
    
    // Zwalnianie zasobów
    ArrayFree(m_log_buffer);
    
    Print("📝 Logging System zniszczony");
}

void CLoggingSystem::InitializeDefaultConfig() {
    m_config.enable_logging = true;
    m_config.min_level = LOG_LEVEL_INFO;
    m_config.enable_console_output = true;
    m_config.enable_file_output = true;
    m_config.enable_performance_logging = true;
    m_config.enable_risk_logging = true;
    m_config.enable_trade_logging = true;
    m_config.enable_ai_logging = true;
    m_config.max_log_entries = 10000;
    m_config.log_file_path = "Logs/Bohme_System_" + TimeToString(TimeCurrent(), TIME_DATE) + ".log";
    m_config.enable_timestamp = true;
    m_config.enable_component_prefix = true;
    m_config.enable_emoji = true;
    m_config.enable_color = false; // MetaTrader nie obsługuje kolorów w konsoli
}

bool CLoggingSystem::Initialize(SLogConfig &config) {
    // Walidacja konfiguracji
    if(!ValidateConfig(config)) {
        Print("❌ Błąd walidacji konfiguracji logowania");
        return false;
    }
    
    m_config = config;
    
    // Otwarcie pliku logów
    if(m_config.enable_file_output) {
        if(!OpenLogFile()) {
            Print("❌ Błąd otwierania pliku logów: ", m_config.log_file_path);
            return false;
        }
    }
    
    // Inicjalizacja bufora
    ArrayResize(m_log_buffer, m_config.max_log_entries);
    
    m_initialized = true;
    m_last_flush_time = TimeCurrent();
    
    // Pierwszy log
    LogInfo(LOG_COMPONENT_SYSTEM, "Logging System initialized", 
            "Config: " + (m_config.enable_file_output ? "File+Console" : "Console only"));
    
    Print("✅ Logging System zainicjalizowany");
    Print("📁 Plik logów: ", m_config.log_file_path);
    Print("📊 Maksymalny bufor: ", m_config.max_log_entries, " wpisów");
    
    return true;
}

void CLoggingSystem::SetConfig(SLogConfig &config) {
    if(ValidateConfig(config)) {
        m_config = config;
        
        // Ponowne otwarcie pliku jeśli ścieżka się zmieniła
        if(m_config.enable_file_output && m_config.log_file_path != "") {
            CloseLogFile();
            OpenLogFile();
        }
        
        LogInfo(LOG_COMPONENT_SYSTEM, "Logging configuration updated");
    }
}

SLogConfig CLoggingSystem::GetConfig() {
    return m_config;
}

bool CLoggingSystem::ValidateConfig(SLogConfig &config) {
    if(config.max_log_entries <= 0 || config.max_log_entries > 100000) {
        Print("❌ Błąd: max_log_entries musi być między 1 a 100000");
        return false;
    }
    
    if(config.min_level < LOG_LEVEL_DEBUG || config.min_level > LOG_LEVEL_CRITICAL) {
        Print("❌ Błąd: min_level musi być między LOG_LEVEL_DEBUG a LOG_LEVEL_CRITICAL");
        return false;
    }
    
    if(config.enable_file_output && config.log_file_path == "") {
        Print("❌ Błąd: log_file_path nie może być puste gdy enable_file_output = true");
        return false;
    }
    
    return true;
}

bool CLoggingSystem::OpenLogFile() {
    if(m_file_opened) {
        CloseLogFile();
    }
    
    // Utworzenie katalogu jeśli nie istnieje
    string directory = StringSubstr(m_config.log_file_path, 0, StringFind(m_config.log_file_path, "\\"));
    if(directory != "") {
        // W MetaTrader 5 nie ma bezpośredniego API do tworzenia katalogów
        // Plik zostanie utworzony automatycznie
    }
    
    m_log_file_handle = FileOpen(m_config.log_file_path, FILE_WRITE | FILE_TXT);
    
    if(m_log_file_handle != INVALID_HANDLE) {
        m_file_opened = true;
        
        // Nagłówek pliku logów
        FileWriteString(m_log_file_handle, "=== BOHME TRADING SYSTEM LOG ===\n");
        FileWriteString(m_log_file_handle, "Started: " + TimeToString(TimeCurrent()) + "\n");
        FileWriteString(m_log_file_handle, "Configuration: " + (m_config.enable_emoji ? "Emoji ON" : "Emoji OFF") + 
                       ", " + (m_config.enable_timestamp ? "Timestamp ON" : "Timestamp OFF") + "\n");
        FileWriteString(m_log_file_handle, "================================\n\n");
        
        return true;
    }
    
    return false;
}

void CLoggingSystem::CloseLogFile() {
    if(m_file_opened && m_log_file_handle != INVALID_HANDLE) {
        FileClose(m_log_file_handle);
        m_file_opened = false;
        m_log_file_handle = INVALID_HANDLE;
    }
}

// === IMPLEMENTACJA METOD FORMATOWANIA ===

string CLoggingSystem::FormatLogEntry(SLogEntry &entry) {
    string formatted = "";
    
    // Timestamp
    if(m_config.enable_timestamp) {
        formatted += GetTimestampString(entry.timestamp) + " ";
    }
    
    // Emoji poziomu
    if(m_config.enable_emoji) {
        formatted += GetLevelEmoji(entry.level) + " ";
    }
    
    // Poziom logowania
    formatted += "[" + GetLevelString(entry.level) + "] ";
    
    // Prefiks komponentu
    if(m_config.enable_component_prefix) {
        if(m_config.enable_emoji) {
            formatted += GetComponentEmoji(entry.component) + " ";
        }
        formatted += "[" + GetComponentString(entry.component) + "] ";
    }
    
    // Typ logu
    formatted += "(" + GetTypeString(entry.type) + ") ";
    
    // Wiadomość
    formatted += entry.message;
    
    // Szczegóły
    if(entry.details != "") {
        formatted += " | " + entry.details;
    }
    
    // Wartość numeryczna
    if(entry.value != 0.0) {
        formatted += " | Value: " + DoubleToString(entry.value, 4);
    }
    
    // Dane dodatkowe
    if(entry.data != "") {
        formatted += " | Data: " + entry.data;
    }
    
    // Nazwa funkcji (dla debug)
    if(entry.level == LOG_LEVEL_DEBUG && entry.function_name != "") {
        formatted += " | " + entry.function_name;
    }
    
    return formatted;
}

string CLoggingSystem::GetLevelString(ENUM_LOG_LEVEL level) {
    switch(level) {
        case LOG_LEVEL_DEBUG: return "DEBUG";
        case LOG_LEVEL_INFO: return "INFO";
        case LOG_LEVEL_WARNING: return "WARN";
        case LOG_LEVEL_ERROR: return "ERROR";
        case LOG_LEVEL_CRITICAL: return "CRIT";
        default: return "UNKNOWN";
    }
}

string CLoggingSystem::GetComponentString(ENUM_LOG_COMPONENT component) {
    switch(component) {
        case LOG_COMPONENT_SYSTEM: return "SYSTEM";
        case LOG_COMPONENT_HERBE: return "HERBE";
        case LOG_COMPONENT_SWEETNESS: return "SWEET";
        case LOG_COMPONENT_BITTERNESS: return "BITTER";
        case LOG_COMPONENT_FIRE: return "FIRE";
        case LOG_COMPONENT_LIGHT: return "LIGHT";
        case LOG_COMPONENT_SOUND: return "SOUND";
        case LOG_COMPONENT_BODY: return "BODY";
        case LOG_COMPONENT_MASTER: return "MASTER";
        case LOG_COMPONENT_RISK: return "RISK";
        case LOG_COMPONENT_POSITION: return "POS";
        case LOG_COMPONENT_ORDER: return "ORDER";
        case LOG_COMPONENT_EXECUTION: return "EXEC";
        case LOG_COMPONENT_AI: return "AI";
        case LOG_COMPONENT_NEWS: return "NEWS";
        case LOG_COMPONENT_TEST: return "TEST";
        case LOG_COMPONENT_INTEGRATION: return "INTEG";
        default: return "UNKNOWN";
    }
}

string CLoggingSystem::GetTypeString(ENUM_LOG_TYPE type) {
    switch(type) {
        case LOG_TYPE_GENERAL: return "GEN";
        case LOG_TYPE_PERFORMANCE: return "PERF";
        case LOG_TYPE_RISK: return "RISK";
        case LOG_TYPE_TRADE: return "TRADE";
        case LOG_TYPE_AI: return "AI";
        case LOG_TYPE_ERROR: return "ERR";
        case LOG_TYPE_DEBUG: return "DBG";
        default: return "UNK";
    }
}

string CLoggingSystem::GetLevelEmoji(ENUM_LOG_LEVEL level) {
    switch(level) {
        case LOG_LEVEL_DEBUG: return "🔍";
        case LOG_LEVEL_INFO: return "ℹ️";
        case LOG_LEVEL_WARNING: return "⚠️";
        case LOG_LEVEL_ERROR: return "❌";
        case LOG_LEVEL_CRITICAL: return "🚨";
        default: return "❓";
    }
}

string CLoggingSystem::GetComponentEmoji(ENUM_LOG_COMPONENT component) {
    switch(component) {
        case LOG_COMPONENT_SYSTEM: return "⚙️";
        case LOG_COMPONENT_HERBE: return "🌿";
        case LOG_COMPONENT_SWEETNESS: return "🍯";
        case LOG_COMPONENT_BITTERNESS: return "☕";
        case LOG_COMPONENT_FIRE: return "🔥";
        case LOG_COMPONENT_LIGHT: return "💡";
        case LOG_COMPONENT_SOUND: return "🎵";
        case LOG_COMPONENT_BODY: return "💪";
        case LOG_COMPONENT_MASTER: return "🧠";
        case LOG_COMPONENT_RISK: return "🛡️";
        case LOG_COMPONENT_POSITION: return "📊";
        case LOG_COMPONENT_ORDER: return "📋";
        case LOG_COMPONENT_EXECUTION: return "⚡";
        case LOG_COMPONENT_AI: return "🤖";
        case LOG_COMPONENT_NEWS: return "📰";
        case LOG_COMPONENT_TEST: return "🧪";
        case LOG_COMPONENT_INTEGRATION: return "🔗";
        default: return "❓";
    }
}

string CLoggingSystem::GetTimestampString(datetime timestamp) {
    return TimeToString(timestamp, TIME_DATE | TIME_MINUTES | TIME_SECONDS);
}

string CLoggingSystem::SanitizeString(string text) {
    // Usunięcie znaków nowej linii i tabulacji
    string sanitized = text;
    StringReplace(sanitized, "\n", " ");
    StringReplace(sanitized, "\r", " ");
    StringReplace(sanitized, "\t", " ");
    
    // Usunięcie wielokrotnych spacji
    while(StringFind(sanitized, "  ") >= 0) {
        StringReplace(sanitized, "  ", " ");
    }
    
    // Przytnij spacje z lewej i prawej strony
    StringTrimLeft(sanitized);
    StringTrimRight(sanitized);
    return sanitized;
}

// === IMPLEMENTACJA GŁÓWNYCH METOD LOGOWANIA ===

void CLoggingSystem::Log(ENUM_LOG_LEVEL level, ENUM_LOG_COMPONENT component, ENUM_LOG_TYPE type, 
                         string message, string details, double value, string data) {
    // Sprawdzenie czy logowanie jest włączone
    if(!m_initialized || !m_config.enable_logging) {
        return;
    }
    
    // Sprawdzenie poziomu logowania
    if(level < m_config.min_level) {
        return;
    }
    
    // Sprawdzenie typu logowania
    if(type == LOG_TYPE_PERFORMANCE && !m_config.enable_performance_logging) {
        return;
    }
    if(type == LOG_TYPE_RISK && !m_config.enable_risk_logging) {
        return;
    }
    if(type == LOG_TYPE_TRADE && !m_config.enable_trade_logging) {
        return;
    }
    if(type == LOG_TYPE_AI && !m_config.enable_ai_logging) {
        return;
    }
    
    // Utworzenie wpisu logu
    SLogEntry entry;
    entry.timestamp = TimeCurrent();
    entry.level = level;
    entry.component = component;
    entry.type = type;
    entry.message = SanitizeString(message);
    entry.details = SanitizeString(details);
    entry.value = value;
    entry.data = SanitizeString(data);
    entry.function_name = "";
    entry.file_name = "";
    
    // Dodanie wpisu do bufora
    AddLogEntry(entry);
}

void CLoggingSystem::LogDebug(ENUM_LOG_COMPONENT component, string message, string details, double value) {
    Log(LOG_LEVEL_DEBUG, component, LOG_TYPE_DEBUG, message, details, value);
}

void CLoggingSystem::LogInfo(ENUM_LOG_COMPONENT component, string message, string details, double value) {
    Log(LOG_LEVEL_INFO, component, LOG_TYPE_GENERAL, message, details, value);
}

void CLoggingSystem::LogWarning(ENUM_LOG_COMPONENT component, string message, string details, double value) {
    Log(LOG_LEVEL_WARNING, component, LOG_TYPE_GENERAL, message, details, value);
}

void CLoggingSystem::LogError(ENUM_LOG_COMPONENT component, string message, string details, double value) {
    Log(LOG_LEVEL_ERROR, component, LOG_TYPE_ERROR, message, details, value);
}

void CLoggingSystem::LogCritical(ENUM_LOG_COMPONENT component, string message, string details, double value) {
    Log(LOG_LEVEL_CRITICAL, component, LOG_TYPE_ERROR, message, details, value);
}

void CLoggingSystem::LogPerformance(ENUM_LOG_COMPONENT component, string operation, double execution_time, string details) {
    Log(LOG_LEVEL_INFO, component, LOG_TYPE_PERFORMANCE, operation, details, execution_time);
}

void CLoggingSystem::LogRisk(ENUM_LOG_COMPONENT component, string risk_type, double risk_value, string action) {
    Log(LOG_LEVEL_WARNING, component, LOG_TYPE_RISK, risk_type, action, risk_value);
}

void CLoggingSystem::LogTrade(ENUM_LOG_COMPONENT component, string action, double profit_loss, string details) {
    Log(LOG_LEVEL_INFO, component, LOG_TYPE_TRADE, action, details, profit_loss);
}

void CLoggingSystem::LogAI(ENUM_LOG_COMPONENT component, string prediction, double confidence, string reasoning) {
    Log(LOG_LEVEL_INFO, component, LOG_TYPE_AI, prediction, reasoning, confidence);
}

void CLoggingSystem::LogIntegration(ENUM_LOG_COMPONENT component, string integration_type, string status, string details) {
    Log(LOG_LEVEL_INFO, component, LOG_TYPE_GENERAL, integration_type + " - " + status, details);
}

void CLoggingSystem::AddLogEntry(SLogEntry &entry) {
    // Dodanie do bufora
    if(m_current_index >= m_config.max_log_entries) {
        m_current_index = 0; // Przewijanie bufora
    }
    
    m_log_buffer[m_current_index] = entry;
    m_current_index++;
    m_total_logs++;
    
    // Aktualizacja statystyk
    UpdateStats(entry);
    
    // Wyświetlenie w konsoli
    if(m_config.enable_console_output) {
        string formatted = FormatLogEntry(entry);
        Print(formatted);
    }
    
    // Zapisanie do pliku
    if(m_config.enable_file_output && m_file_opened) {
        string formatted = FormatLogEntry(entry);
        FileWriteString(m_log_file_handle, formatted + "\n");
        
        // Flush co 10 logów lub co 5 sekund
        if(m_total_logs % 10 == 0 || (TimeCurrent() - m_last_flush_time) > 5) {
            FlushToFile();
        }
    }
}

void CLoggingSystem::UpdateStats(SLogEntry &entry) {
    m_stats.total_logs++;
    
    switch(entry.level) {
        case LOG_LEVEL_DEBUG: m_stats.debug_logs++; break;
        case LOG_LEVEL_INFO: m_stats.info_logs++; break;
        case LOG_LEVEL_WARNING: m_stats.warning_logs++; break;
        case LOG_LEVEL_ERROR: m_stats.error_logs++; break;
        case LOG_LEVEL_CRITICAL: m_stats.critical_logs++; break;
    }
    
    switch(entry.type) {
        case LOG_TYPE_PERFORMANCE: m_stats.performance_logs++; break;
        case LOG_TYPE_RISK: m_stats.risk_logs++; break;
        case LOG_TYPE_TRADE: m_stats.trade_logs++; break;
        case LOG_TYPE_AI: m_stats.ai_logs++; break;
    }
    
    if(m_stats.first_log_time == 0) {
        m_stats.first_log_time = entry.timestamp;
    }
    
    m_stats.last_log_time = entry.timestamp;
    
    // Obliczenie średniego interwału
    if(m_stats.total_logs > 1) {
        double total_time = (double)(m_stats.last_log_time - m_stats.first_log_time);
        m_stats.average_log_interval = total_time / (m_stats.total_logs - 1);
    }
}

void CLoggingSystem::FlushToFile() {
    if(m_file_opened && m_log_file_handle != INVALID_HANDLE) {
        FileFlush(m_log_file_handle);
        m_last_flush_time = TimeCurrent();
    }
}

// === IMPLEMENTACJA ZARZĄDZANIA LOGAMI I STATYSTYK ===

void CLoggingSystem::Flush() {
    FlushToFile();
}

void CLoggingSystem::Clear() {
    // Resetowanie bufora
    ArrayResize(m_log_buffer, 0);
    ArrayResize(m_log_buffer, m_config.max_log_entries);
    m_current_index = 0;
    m_total_logs = 0;
    
    // Resetowanie statystyk
    m_stats.total_logs = 0;
    m_stats.debug_logs = 0;
    m_stats.info_logs = 0;
    m_stats.warning_logs = 0;
    m_stats.error_logs = 0;
    m_stats.critical_logs = 0;
    m_stats.performance_logs = 0;
    m_stats.risk_logs = 0;
    m_stats.trade_logs = 0;
    m_stats.ai_logs = 0;
    m_stats.first_log_time = 0;
    m_stats.last_log_time = 0;
    m_stats.average_log_interval = 0.0;
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Log buffer cleared");
}

void CLoggingSystem::Rotate() {
    // Zamknięcie obecnego pliku
    CloseLogFile();
    
    // Utworzenie nowej nazwy pliku z timestampem
    string new_path = "Logs/Bohme_System_" + TimeToString(TimeCurrent(), TIME_DATE | TIME_MINUTES) + ".log";
    m_config.log_file_path = new_path;
    
    // Otwarcie nowego pliku
    OpenLogFile();
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Log file rotated", "New file: " + new_path);
}

SLogEntry CLoggingSystem::GetLogEntry(int index) {
    if(index < 0 || index >= m_config.max_log_entries) {
        SLogEntry empty;
        return empty;
    }
    
    return m_log_buffer[index];
}

void CLoggingSystem::GetLogs(SLogEntry &logs[]) {
    ArrayResize(logs, 0);
    for(int i = 0; i < m_config.max_log_entries; i++) {
        if(m_log_buffer[i].timestamp > 0) {
            int size = ArraySize(logs);
            ArrayResize(logs, size + 1);
            logs[size] = m_log_buffer[i];
        }
    }
}

int CLoggingSystem::GetLogCount() {
    return m_total_logs;
}

SLogStats CLoggingSystem::GetStats() {
    return m_stats;
}

string CLoggingSystem::GetStatsReport() {
    string report = "";
    report += "=== LOGGING STATISTICS ===\n";
    report += "Total Logs: " + IntegerToString(m_stats.total_logs) + "\n";
    report += "Debug: " + IntegerToString(m_stats.debug_logs) + "\n";
    report += "Info: " + IntegerToString(m_stats.info_logs) + "\n";
    report += "Warning: " + IntegerToString(m_stats.warning_logs) + "\n";
    report += "Error: " + IntegerToString(m_stats.error_logs) + "\n";
    report += "Critical: " + IntegerToString(m_stats.critical_logs) + "\n";
    report += "Performance: " + IntegerToString(m_stats.performance_logs) + "\n";
    report += "Risk: " + IntegerToString(m_stats.risk_logs) + "\n";
    report += "Trade: " + IntegerToString(m_stats.trade_logs) + "\n";
    report += "AI: " + IntegerToString(m_stats.ai_logs) + "\n";
    
    if(m_stats.first_log_time > 0) {
        report += "First Log: " + TimeToString(m_stats.first_log_time) + "\n";
        report += "Last Log: " + TimeToString(m_stats.last_log_time) + "\n";
        report += "Avg Interval: " + DoubleToString(m_stats.average_log_interval, 2) + "s\n";
    }
    
    return report;
}

string CLoggingSystem::GetLogReport(int max_entries) {
    string report = "";
    report += "=== RECENT LOGS ===\n";
    
    int count = MathMin(max_entries, m_config.max_log_entries);
    int start_index = m_current_index - count;
    
    if(start_index < 0) {
        start_index += m_config.max_log_entries;
    }
    
    for(int i = 0; i < count; i++) {
        int index = (start_index + i) % m_config.max_log_entries;
        SLogEntry entry = m_log_buffer[index];
        
        if(entry.timestamp > 0) {
            report += FormatLogEntry(entry) + "\n";
        }
    }
    
    return report;
}

void CLoggingSystem::ExportLogs(string filename, ENUM_LOG_LEVEL min_level) {
    int handle = FileOpen(filename, FILE_WRITE | FILE_CSV);
    
    if(handle != INVALID_HANDLE) {
        // Nagłówek CSV
        FileWriteString(handle, "Timestamp,Level,Component,Type,Message,Details,Value,Data\n");
        
        // Eksport logów
        for(int i = 0; i < m_config.max_log_entries; i++) {
            SLogEntry entry = m_log_buffer[i];
            
            if(entry.timestamp > 0 && entry.level >= min_level) {
                string line = TimeToString(entry.timestamp) + "," +
                             GetLevelString(entry.level) + "," +
                             GetComponentString(entry.component) + "," +
                             GetTypeString(entry.type) + "," +
                             "\"" + entry.message + "\"," +
                             "\"" + entry.details + "\"," +
                             DoubleToString(entry.value, 4) + "," +
                             "\"" + entry.data + "\"";
                
                FileWriteString(handle, line + "\n");
            }
        }
        
        FileClose(handle);
        LogInfo(LOG_COMPONENT_SYSTEM, "Logs exported", "File: " + filename);
    } else {
        LogError(LOG_COMPONENT_SYSTEM, "Failed to export logs", "File: " + filename);
    }
}

void CLoggingSystem::ExportLogsByComponent(string filename, ENUM_LOG_COMPONENT component) {
    int handle = FileOpen(filename, FILE_WRITE | FILE_CSV);
    
    if(handle != INVALID_HANDLE) {
        // Nagłówek CSV
        FileWriteString(handle, "Timestamp,Level,Component,Type,Message,Details,Value,Data\n");
        
        // Eksport logów dla komponentu
        for(int i = 0; i < m_config.max_log_entries; i++) {
            SLogEntry entry = m_log_buffer[i];
            
            if(entry.timestamp > 0 && entry.component == component) {
                string line = TimeToString(entry.timestamp) + "," +
                             GetLevelString(entry.level) + "," +
                             GetComponentString(entry.component) + "," +
                             GetTypeString(entry.type) + "," +
                             "\"" + entry.message + "\"," +
                             "\"" + entry.details + "\"," +
                             DoubleToString(entry.value, 4) + "," +
                             "\"" + entry.data + "\"";
                
                FileWriteString(handle, line + "\n");
            }
        }
        
        FileClose(handle);
        LogInfo(LOG_COMPONENT_SYSTEM, "Component logs exported", 
                "Component: " + GetComponentString(component) + ", File: " + filename);
    } else {
        LogError(LOG_COMPONENT_SYSTEM, "Failed to export component logs", "File: " + filename);
    }
}

void CLoggingSystem::ExportLogsByType(string filename, ENUM_LOG_TYPE type) {
    int handle = FileOpen(filename, FILE_WRITE | FILE_CSV);
    
    if(handle != INVALID_HANDLE) {
        // Nagłówek CSV
        FileWriteString(handle, "Timestamp,Level,Component,Type,Message,Details,Value,Data\n");
        
        // Eksport logów dla typu
        for(int i = 0; i < m_config.max_log_entries; i++) {
            SLogEntry entry = m_log_buffer[i];
            
            if(entry.timestamp > 0 && entry.type == type) {
                string line = TimeToString(entry.timestamp) + "," +
                             GetLevelString(entry.level) + "," +
                             GetComponentString(entry.component) + "," +
                             GetTypeString(entry.type) + "," +
                             "\"" + entry.message + "\"," +
                             "\"" + entry.details + "\"," +
                             DoubleToString(entry.value, 4) + "," +
                             "\"" + entry.data + "\"";
                
                FileWriteString(handle, line + "\n");
            }
        }
        
        FileClose(handle);
        LogInfo(LOG_COMPONENT_SYSTEM, "Type logs exported", 
                "Type: " + GetTypeString(type) + ", File: " + filename);
    } else {
        LogError(LOG_COMPONENT_SYSTEM, "Failed to export type logs", "File: " + filename);
    }
}

// === IMPLEMENTACJA FILTROWANIA I WYSZUKIWANIA ===

void CLoggingSystem::GetLogsByLevel(ENUM_LOG_LEVEL level, SLogEntry &logs[]) {
    ArrayResize(logs, 0);
    
    for(int i = 0; i < m_config.max_log_entries; i++) {
        SLogEntry entry = m_log_buffer[i];
        
        if(entry.timestamp > 0 && entry.level == level) {
            int size = ArraySize(logs);
            ArrayResize(logs, size + 1);
            logs[size] = entry;
        }
    }
}

void CLoggingSystem::GetLogsByComponent(ENUM_LOG_COMPONENT component, SLogEntry &logs[]) {
    ArrayResize(logs, 0);
    
    for(int i = 0; i < m_config.max_log_entries; i++) {
        SLogEntry entry = m_log_buffer[i];
        
        if(entry.timestamp > 0 && entry.component == component) {
            int size = ArraySize(logs);
            ArrayResize(logs, size + 1);
            logs[size] = entry;
        }
    }
}

void CLoggingSystem::GetLogsByType(ENUM_LOG_TYPE type, SLogEntry &logs[]) {
    ArrayResize(logs, 0);
    
    for(int i = 0; i < m_config.max_log_entries; i++) {
        SLogEntry entry = m_log_buffer[i];
        
        if(entry.timestamp > 0 && entry.type == type) {
            int size = ArraySize(logs);
            ArrayResize(logs, size + 1);
            logs[size] = entry;
        }
    }
}

void CLoggingSystem::GetLogsByTimeRange(datetime start_time, datetime end_time, SLogEntry &logs[]) {
    ArrayResize(logs, 0);
    
    for(int i = 0; i < m_config.max_log_entries; i++) {
        SLogEntry entry = m_log_buffer[i];
        
        if(entry.timestamp > 0 && entry.timestamp >= start_time && entry.timestamp <= end_time) {
            int size = ArraySize(logs);
            ArrayResize(logs, size + 1);
            logs[size] = entry;
        }
    }
}

void CLoggingSystem::GetLogsByKeyword(string keyword, SLogEntry &logs[]) {
    ArrayResize(logs, 0);
    
    if(keyword == "") return;
    
    string lower_keyword = StringToLower(keyword);
    
    for(int i = 0; i < m_config.max_log_entries; i++) {
        SLogEntry entry = m_log_buffer[i];
        
        if(entry.timestamp > 0) {
            string lower_message = StringToLower(entry.message);
            string lower_details = StringToLower(entry.details);
            string lower_data = StringToLower(entry.data);
            
            if(StringFind(lower_message, lower_keyword) >= 0 ||
               StringFind(lower_details, lower_keyword) >= 0 ||
               StringFind(lower_data, lower_keyword) >= 0) {
                
                int size = ArraySize(logs);
                ArrayResize(logs, size + 1);
                logs[size] = entry;
            }
        }
    }
}

// Implementacje setterów callbacków usunięte

// === IMPLEMENTACJA FUNKCJI POMOCNICZYCH ===

bool CLoggingSystem::IsLoggingEnabled() {
    return m_initialized && m_config.enable_logging;
}

bool CLoggingSystem::IsLevelEnabled(ENUM_LOG_LEVEL level) {
    return m_initialized && m_config.enable_logging && level >= m_config.min_level;
}

bool CLoggingSystem::IsComponentEnabled(ENUM_LOG_COMPONENT component) {
    return m_initialized && m_config.enable_logging;
}

bool CLoggingSystem::IsTypeEnabled(ENUM_LOG_TYPE type) {
    if(!m_initialized || !m_config.enable_logging) {
        return false;
    }
    
    switch(type) {
        case LOG_TYPE_PERFORMANCE: return m_config.enable_performance_logging;
        case LOG_TYPE_RISK: return m_config.enable_risk_logging;
        case LOG_TYPE_TRADE: return m_config.enable_trade_logging;
        case LOG_TYPE_AI: return m_config.enable_ai_logging;
        default: return true;
    }
}

string CLoggingSystem::GetLogFilePath() {
    return m_config.log_file_path;
}

void CLoggingSystem::SetLogFilePath(string file_path) {
    if(m_config.log_file_path != file_path) {
        m_config.log_file_path = file_path;
        
        if(m_config.enable_file_output) {
            CloseLogFile();
            OpenLogFile();
        }
        
        LogInfo(LOG_COMPONENT_SYSTEM, "Log file path changed", "New path: " + file_path);
    }
}

// === GLOBALNA INSTANCJA I FUNKCJE POMOCNICZE ===

// Globalna instancja systemu logowania
extern CLoggingSystem* g_logger;

// === FUNKCJE GLOBALNEGO DOSTĘPU ===

// Inicjalizacja globalnego loggera
bool InitializeGlobalLogger(SLogConfig &config) {
    if(g_logger != NULL) {
        delete g_logger;
    }
    
    g_logger = new CLoggingSystem();
    return g_logger.Initialize(config);
}

// Zniszczenie globalnego loggera
void DestroyGlobalLogger() {
    if(g_logger != NULL) {
        delete g_logger;
        g_logger = NULL;
    }
}

// === WYGODNE FUNKCJE LOGOWANIA ===

// Logowanie debug
void LogDebug(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0) {
    if(g_logger != NULL) {
        g_logger.LogDebug(component, message, details, value);
    }
}

// Logowanie informacji
void LogInfo(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0) {
    if(g_logger != NULL) {
        g_logger.LogInfo(component, message, details, value);
    }
}

// Logowanie ostrzeżeń
void LogWarning(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0) {
    if(g_logger != NULL) {
        g_logger.LogWarning(component, message, details, value);
    }
}

// Logowanie błędów
void LogError(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0) {
    if(g_logger != NULL) {
        g_logger.LogError(component, message, details, value);
    }
}

// Logowanie błędów krytycznych
void LogCritical(ENUM_LOG_COMPONENT component, string message, string details = "", double value = 0.0) {
    if(g_logger != NULL) {
        g_logger.LogCritical(component, message, details, value);
    }
}

// Logowanie wydajności
void LogPerformance(ENUM_LOG_COMPONENT component, string operation, double execution_time, string details = "") {
    if(g_logger != NULL) {
        g_logger.LogPerformance(component, operation, execution_time, details);
    }
}

// Logowanie ryzyka
void LogRisk(ENUM_LOG_COMPONENT component, string risk_type, double risk_value, string action = "") {
    if(g_logger != NULL) {
        g_logger.LogRisk(component, risk_type, risk_value, action);
    }
}

// Logowanie transakcji
void LogTrade(ENUM_LOG_COMPONENT component, string action, double profit_loss, string details = "") {
    if(g_logger != NULL) {
        g_logger.LogTrade(component, action, profit_loss, details);
    }
}

// Logowanie AI
void LogAI(ENUM_LOG_COMPONENT component, string prediction, double confidence, string reasoning = "") {
    if(g_logger != NULL) {
        g_logger.LogAI(component, prediction, confidence, reasoning);
    }
}

// Logowanie integracji
void LogIntegration(ENUM_LOG_COMPONENT component, string integration_type, string status, string details = "") {
    if(g_logger != NULL) {
        g_logger.LogIntegration(component, integration_type, status, details);
    }
}

// === FUNKCJE ZARZĄDZANIA ===

// Flush logów
void FlushLogs() {
    if(g_logger != NULL) {
        g_logger.Flush();
    }
}

// Wyczyść logi
void ClearLogs() {
    if(g_logger != NULL) {
        g_logger.Clear();
    }
}

// Rotacja pliku logów
void RotateLogs() {
    if(g_logger != NULL) {
        g_logger.Rotate();
    }
}

// Eksport logów
void ExportLogs(string filename, ENUM_LOG_LEVEL min_level = LOG_LEVEL_DEBUG) {
    if(g_logger != NULL) {
        g_logger.ExportLogs(filename, min_level);
    }
}

// Eksport logów komponentu
void ExportComponentLogs(string filename, ENUM_LOG_COMPONENT component) {
    if(g_logger != NULL) {
        g_logger.ExportLogsByComponent(filename, component);
    }
}

// Eksport logów typu
void ExportTypeLogs(string filename, ENUM_LOG_TYPE type) {
    if(g_logger != NULL) {
        g_logger.ExportLogsByType(filename, type);
    }
}

// === FUNKCJE RAPORTÓW ===

// Pobierz statystyki
SLogStats GetLogStats() {
    if(g_logger != NULL) {
        return g_logger.GetStats();
    }
    
    SLogStats empty;
    return empty;
}

// Pobierz raport statystyk
string GetLogStatsReport() {
    if(g_logger != NULL) {
        return g_logger.GetStatsReport();
    }
    return "Logger not initialized";
}

// Pobierz raport logów
string GetLogReport(int max_entries = 100) {
    if(g_logger != NULL) {
        return g_logger.GetLogReport(max_entries);
    }
    return "Logger not initialized";
}

// === FUNKCJE SPRAWDZANIA ===

// Sprawdź czy logger jest aktywny
bool IsLoggerActive() {
    return g_logger != NULL && g_logger.IsLoggingEnabled();
}

// Sprawdź czy poziom jest włączony
bool IsLogLevelEnabled(ENUM_LOG_LEVEL level) {
    return g_logger != NULL && g_logger.IsLevelEnabled(level);
}

// Sprawdź czy typ jest włączony
bool IsLogTypeEnabled(ENUM_LOG_TYPE type) {
    return g_logger != NULL && g_logger.IsTypeEnabled(type);
}

// === MAKRA DLA ŁATWEGO LOGOWANIA ===

// Makro dla logowania z automatycznym sprawdzeniem
#define LOG_DEBUG(component, message, details, value) \
    if(IsLogLevelEnabled(LOG_LEVEL_DEBUG)) LogDebug(component, message, details, value)

#define LOG_INFO(component, message, details, value) \
    if(IsLogLevelEnabled(LOG_LEVEL_INFO)) LogInfo(component, message, details, value)

#define LOG_WARNING(component, message, details, value) \
    if(IsLogLevelEnabled(LOG_LEVEL_WARNING)) LogWarning(component, message, details, value)

#define LOG_ERROR(component, message, details, value) \
    if(IsLogLevelEnabled(LOG_LEVEL_ERROR)) LogError(component, message, details, value)

#define LOG_CRITICAL(component, message, details, value) \
    if(IsLogLevelEnabled(LOG_LEVEL_CRITICAL)) LogCritical(component, message, details, value)

#define LOG_PERFORMANCE(component, operation, time, details) \
    if(IsLogTypeEnabled(LOG_TYPE_PERFORMANCE)) LogPerformance(component, operation, time, details)

#define LOG_RISK(component, risk_type, value, action) \
    if(IsLogTypeEnabled(LOG_TYPE_RISK)) LogRisk(component, risk_type, value, action)

#define LOG_TRADE(component, action, profit_loss, details) \
    if(IsLogTypeEnabled(LOG_TYPE_TRADE)) LogTrade(component, action, profit_loss, details)

#define LOG_AI(component, prediction, confidence, reasoning) \
    if(IsLogTypeEnabled(LOG_TYPE_AI)) LogAI(component, prediction, confidence, reasoning)

#endif // LOGGING_SYSTEM_H
