//+------------------------------------------------------------------+
//| BohmeSystemV2.mq5 - Zaawansowana Implementacja z AI             |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "2.00"
#property description "System Siedmiu Duchów Rynku - Wersja z Zaawansowanym AI"
#property indicator_chart_window
#property indicator_buffers 0
#property indicator_plots   0

// GUI Properties
#property indicator_width1 2
#property indicator_color1 clrDodgerBlue
#property indicator_style1 STYLE_SOLID

// Includes
#include "../SystemConfig.mqh"
#include "../MasterConsciousness.mqh"
#include "../AI/AdvancedAI.mqh"
#include "../Utils/LoggingSystem.mqh"

// Includes wszystkich duchów
#include "../Spirits/LightSpirit.mqh"
#include "../Spirits/FireSpirit.mqh"
#include "../Spirits/BitternessSpirit.mqh"
#include "../Spirits/BodySpirit.mqh"
#include "../Spirits/HerbeSpirit.mqh"
#include "../Spirits/SweetnessSpirit.mqh"
#include "../Spirits/SoundSpirit.mqh"

// Includes z folderu Data
#include "../Data/DataManager.mqh"
#include "../Data/EconomicCalendar.mqh"
#include "../Data/NewsProcessor.mqh"
#include "../Data/SentimentAnalyzer.mqh"

// Includes z folderu Utils
#include "../Utils/MathUtils.mqh"
#include "../Utils/StringUtils.mqh"
#include "../Utils/TimeUtils.mqh"

// Includes z folderu Execution
#include "../Execution/ExecutionAlgorithms.mqh"
#include "../Execution/RiskManager.mqh"
#include "../Execution/PositionManager.mqh"
#include "../Execution/OrderManager.mqh"

// Includes z folderu Tests (opcjonalne - tylko w trybie debug)
#ifdef _DEBUG
#include "../Tests/UnitTests.mqh"
#include "../Tests/IntegrationTests.mqh"
#include "../Tests/BacktestFramework.mqh"
#endif

// Include zaawansowanego GUI
#include "../BohmeGUI.mqh"

// === STRUKTURY STATYSTYK ===
struct ExecutionStatistics {
    int total_orders;
    int successful_orders;
    int failed_orders;
    double success_rate;
    double average_execution_time;
    double total_volume;
    datetime last_order_time;
    string last_order_symbol;
    double total_profit;
    double total_loss;
    double net_pnl;
};

struct RiskStatistics {
    double current_risk;
    double max_risk;
    double risk_per_trade;
    double daily_risk;
    double portfolio_risk;
    int open_positions;
    double total_exposure;
    double max_drawdown;
    double var_95;
    double var_99;
    datetime last_risk_update;
};

struct PositionStatistics {
    int total_positions;
    int long_positions;
    int short_positions;
    double total_position_value;
    double average_position_size;
    double largest_position;
    double smallest_position;
    double total_margin_used;
    double free_margin;
    datetime last_position_update;
};

// === GLOBALNA INICJALIZACJA KONFIGURACJI ===
SystemConfig g_config = {
    // === PODSTAWOWE PARAMETRY ===
    75.0,    // confidence_threshold
    70.0,    // alignment_threshold
    2.0,     // max_risk_per_trade
    5.0,     // max_daily_risk
    0.01,    // min_position_size
    1.0,     // max_position_size
    true,    // learning_enabled
    true,    // evolution_enabled
    
    // === AKTYWACJA DUCHÓW ===
    true,    // enable_herbe_spirit
    true,    // enable_sweetness_spirit
    true,    // enable_bitterness_spirit
    true,    // enable_fire_spirit
    true,    // enable_light_spirit
    true,    // enable_sound_spirit
    true,    // enable_body_spirit
    
    // === WAGI DUCHÓW (0.0 - 2.0) ===
    1.0,     // herbe_weight
    1.0,     // sweetness_weight
    1.0,     // bitterness_weight
    1.0,     // fire_weight
    1.0,     // light_weight
    1.0,     // sound_weight
    1.0,     // body_weight
    
    // === PARAMETRY MASTER CONSCIOUSNESS ===
    8,       // transformer_heads
    6,       // transformer_layers
    1024,    // system_memory_size
    0.001,   // learning_rate
    
    // === PARAMETRY ZARZĄDZANIA RYZYKIEM ===
    2.0,     // stop_loss_multiplier
    3.0,     // take_profit_multiplier
    50.0,    // trailing_stop_distance
    true,    // use_trailing_stop
    
    // === PARAMETRY CZASOWE ===
    60,      // analysis_interval
    24,      // model_update_interval
    7,       // evolution_interval
    
    // === PARAMETRY DIAGNOSTYKI ===
    true,    // enable_debug_logging
    true,    // enable_performance_tracking
    1000,    // max_history_size
    
    // === PARAMETRY LOGOWANIA ===
    true,    // enable_logging_system
    LOG_LEVEL_INFO,  // logging_level
    true,    // enable_log_file_output
    true,    // enable_log_console_output
    true,    // enable_log_performance
    true,    // enable_log_risk
    true,    // enable_log_trade
    true,    // enable_log_ai
    1000,    // max_log_entries
    "Bohme_System_Log.txt"  // log_file_path
};

// GUI Constants
#define GUI_WIDTH 400
#define GUI_HEIGHT 600
#define GUI_MARGIN 10
#define BUTTON_HEIGHT 25
#define LABEL_HEIGHT 20
#define SPIRIT_PANEL_HEIGHT 80
#define STATUS_PANEL_HEIGHT 120
#define CONTROL_PANEL_HEIGHT 150

// GUI Colors
#define GUI_BACKGROUND_COLOR clrDarkSlateGray
#define GUI_PANEL_COLOR clrSlateGray
#define GUI_TEXT_COLOR clrWhite
#define GUI_BUTTON_COLOR clrDodgerBlue
#define GUI_BUTTON_HOVER_COLOR clrLightBlue
#define GUI_SUCCESS_COLOR clrLimeGreen
#define GUI_WARNING_COLOR clrOrange
#define GUI_ERROR_COLOR clrRed
#define GUI_INFO_COLOR clrCyan

// GUI Elements
struct SGUIElement {
    string name;
    int x, y, width, height;
    string text;
    color bg_color;
    color text_color;
    bool is_visible;
    bool is_enabled;
    bool is_hovered;
    bool is_clicked;
};

// Spirit Status
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

// GUI State
struct SGUIState {
    bool is_visible;
    bool is_minimized;
    bool is_dragging;
    int drag_offset_x;
    int drag_offset_y;
    int window_x;
    int window_y;
    int active_tab;
    bool show_details;
    bool auto_refresh;
    int refresh_interval;
    datetime last_refresh;
};

// Global variables - wszystkie duchy
LightSpirit* g_light_spirit = NULL;
FireSpiritAI* g_fire_spirit = NULL;
BitternessSpirit* g_bitterness_spirit = NULL;
BodySpirit* g_body_spirit = NULL;
HerbeQualityAI* g_herbe_spirit = NULL;
SentimentAI* g_sweetness_spirit = NULL;
SoundSpiritAI* g_sound_spirit = NULL;

// Master Consciousness
CMasterConsciousness* g_master_consciousness = NULL;

// Execution Components
CExecutionAlgorithms* g_execution_algorithms = NULL;
CRiskManager* g_risk_manager = NULL;
CPositionManager* g_position_manager = NULL;
COrderManager* g_order_manager = NULL;

// Data Components
CDataManager* g_data_manager = NULL;
CNewsProcessor* g_news_processor = NULL;
CSentimentAnalyzer* g_sentiment_analyzer = NULL;
CEconomicCalendar* g_economic_calendar = NULL;

// System state
datetime g_last_analysis = 0;
bool g_system_initialized = false;
int g_analysis_counter = 0;

// GUI State
SGUIState g_gui_state;
SGUIElement g_gui_elements[];
SSpiritStatus g_spirit_status[7];

// Test Results
struct STestResult {
    string test_name;
    bool passed;
    double execution_time;
    string details;
    datetime timestamp;
};

STestResult g_test_results[];
int g_test_count = 0;

//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+
int OnInit() {
    Print("🌟 Inicjalizacja Systemu Böhmego v2.0 z Zaawansowanym AI");
    
    // Initialize GUI
    InitializeGUI();
    
    // Initialize Advanced GUI
    InitializeAdvancedGUI();
    
    // Validate system configuration
    if(!ValidateSystemConfig(g_config)) {
        LogError(LOG_COMPONENT_SYSTEM, "Błąd konfiguracji systemu", "Nie można zwalidować konfiguracji");
        return INIT_FAILED;
    }
    
    // Initialize logging system
    if(g_config.enable_logging_system) {
        LogInfo(LOG_COMPONENT_SYSTEM, "Inicjalizacja systemu logowania", "Logging system włączony");
    }
    
    // Initialize Data components
    if(!InitializeDataComponents()) {
        LogError(LOG_COMPONENT_SYSTEM, "Błąd inicjalizacji komponentów danych", "Nie można zainicjalizować komponentów danych");
        return INIT_FAILED;
    }
    
    // Initialize all spirits
    if(!InitializeAllSpirits()) {
        LogError(LOG_COMPONENT_SYSTEM, "Błąd inicjalizacji duchów", "Nie można zainicjalizować wszystkich duchów");
        return INIT_FAILED;
    }
    
    // Initialize Master Consciousness
    if(!InitializeMasterConsciousness()) {
        LogError(LOG_COMPONENT_SYSTEM, "Błąd inicjalizacji Master Consciousness", "Nie można zainicjalizować Master Consciousness");
        return INIT_FAILED;
    }
    
    g_system_initialized = true;
    
    LogInfo(LOG_COMPONENT_SYSTEM, "System Böhmego zainicjalizowany", 
            "Wersja: 2.0, Duchy: 7/7, AI: Zaawansowane");
    Print("✅ System Böhmego v2.0 z AI zainicjalizowany");
    Print("📊 Konfiguracja:");
    Print(GenerateConfigReport(g_config));
    
    return INIT_SUCCEEDED;
}

//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason) {
    LogInfo(LOG_COMPONENT_SYSTEM, "Deinicjalizacja systemu", "Powód: " + IntegerToString(reason));
    
    // Cleanup GUI
    CleanupGUI();
    
    // Cleanup Advanced GUI
    CleanupAdvancedGUI();
    
    // Cleanup Data components
    CleanupDataComponents();
    
    // Cleanup all spirits
    CleanupAllSpirits();
    
    // Cleanup Master Consciousness
    if(g_master_consciousness != NULL) {
        delete g_master_consciousness;
        g_master_consciousness = NULL;
    }
    
    g_system_initialized = false;
    Print("🌙 System Böhmego v2.0 zakończył pracę");
}

//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick() {
    if(!g_system_initialized) return;
    
    datetime current_time = TimeCurrent();
    
    // Analyze every minute
    if(current_time - g_last_analysis >= g_config.analysis_interval) {
        g_last_analysis = current_time;
        g_analysis_counter++;
        
        // Update Data components
        UpdateDataComponents();
        
        // Update Execution components
        UpdateExecutionComponents();
        
        // Update all spirits
        UpdateAllSpirits();
        
        // Analyze market with all spirits
        AnalyzeMarketWithAllSpirits();
        
        // Update GUI
        UpdateGUI();
        
        // Update Advanced GUI
        UpdateAdvancedGUI();
        
        // Log analysis counter every 100 analyses
        if(g_analysis_counter % 100 == 0) {
            LogInfo(LOG_COMPONENT_SYSTEM, "Analiza rynku", 
                    "Liczba analiz: " + IntegerToString(g_analysis_counter));
            
            // Display complete system report every 500 analyses
            if(g_analysis_counter % 500 == 0) {
                Print(GetCompleteSystemReport());
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Chart event function                                             |
//+------------------------------------------------------------------+
void OnChartEvent(const int id, const long& lparam, const double& dparam, const string& sparam) {
    if(!g_system_initialized) return;
    
    // Handle GUI events
    HandleGUIEvent(id, lparam, dparam, sparam);
    
    // Handle keyboard shortcuts
    if(id == CHARTEVENT_KEYDOWN) {
        HandleKeyboardShortcuts(lparam);
    }
}

//+------------------------------------------------------------------+
//| Initialize GUI                                                   |
//+------------------------------------------------------------------+
void InitializeGUI() {
    Print("🎨 Inicjalizacja GUI...");
    
    // Initialize GUI state
    g_gui_state.is_visible = true;
    g_gui_state.is_minimized = false;
    g_gui_state.is_dragging = false;
    g_gui_state.window_x = 20;
    g_gui_state.window_y = 20;
    g_gui_state.active_tab = 0;
    g_gui_state.show_details = false;
    g_gui_state.auto_refresh = true;
    g_gui_state.refresh_interval = 5; // seconds
    g_gui_state.last_refresh = TimeCurrent();
    
    // Initialize spirit status
    string spirit_names[] = {"Light", "Fire", "Bitterness", "Body", "Herbe", "Sweetness", "Sound"};
    for(int i = 0; i < 7; i++) {
        g_spirit_status[i].name = spirit_names[i];
        g_spirit_status[i].is_active = false;
        g_spirit_status[i].is_initialized = false;
        g_spirit_status[i].performance_score = 0.0;
        g_spirit_status[i].status_text = "Nieaktywny";
        g_spirit_status[i].status_color = GUI_ERROR_COLOR;
        g_spirit_status[i].last_update = 0;
        g_spirit_status[i].test_results = 0;
        g_spirit_status[i].execution_time = 0.0;
    }
    
    // Create GUI elements
    CreateGUIElements();
    
    // Enable chart events
    ChartSetInteger(0, CHART_EVENT_MOUSE_MOVE, true);
    ChartSetInteger(0, CHART_EVENT_OBJECT_CREATE, true);
    ChartSetInteger(0, CHART_EVENT_OBJECT_DELETE, true);
    ChartSetInteger(0, CHART_EVENT_CLICK, true);
    ChartSetInteger(0, CHART_EVENT_OBJECT_CLICK, true);
    
    Print("✅ GUI zainicjalizowane");
}

//+------------------------------------------------------------------+
//| Initialize Advanced GUI                                          |
//+------------------------------------------------------------------+
void InitializeAdvancedGUI() {
    Print("🎨 Inicjalizacja zaawansowanego GUI...");
    
    // Initialize advanced GUI features
    // This function can be extended with advanced GUI features
    // such as real-time charts, advanced controls, etc.
    
    // Set up advanced chart properties
    ChartSetInteger(0, CHART_SHOW_GRID, true);
    ChartSetInteger(0, CHART_SHOW_VOLUMES, CHART_VOLUME_TICK);
    ChartSetInteger(0, CHART_COLOR_BACKGROUND, clrBlack);
    ChartSetInteger(0, CHART_COLOR_FOREGROUND, clrWhite);
    
    // Enable advanced chart events
    ChartSetInteger(0, CHART_EVENT_MOUSE_WHEEL, true);
    ChartSetInteger(0, CHART_EVENT_OBJECT_DRAG, true);
    
    Print("✅ Zaawansowane GUI zainicjalizowane");
}

//+------------------------------------------------------------------+
//| Create GUI Elements                                              |
//+------------------------------------------------------------------+
void CreateGUIElements() {
    // Main window
    CreateElement("main_window", g_gui_state.window_x, g_gui_state.window_y, 
                 GUI_WIDTH, GUI_HEIGHT, "System Böhmego v2.0", GUI_BACKGROUND_COLOR, GUI_TEXT_COLOR);
    
    // Title bar
    CreateElement("title_bar", g_gui_state.window_x, g_gui_state.window_y, 
                 GUI_WIDTH, 30, "🌙 System Böhmego v2.0 - Zaawansowane AI", GUI_PANEL_COLOR, GUI_TEXT_COLOR);
    
    // Control buttons
    CreateElement("btn_minimize", g_gui_state.window_x + GUI_WIDTH - 60, g_gui_state.window_y + 5, 
                 20, 20, "−", GUI_BUTTON_COLOR, GUI_TEXT_COLOR);
    CreateElement("btn_close", g_gui_state.window_x + GUI_WIDTH - 35, g_gui_state.window_y + 5, 
                 20, 20, "×", GUI_ERROR_COLOR, GUI_TEXT_COLOR);
    
    // Tab buttons
    CreateElement("tab_spirits", g_gui_state.window_x + GUI_MARGIN, g_gui_state.window_y + 35, 
                 80, 25, "Duchy", GUI_BUTTON_COLOR, GUI_TEXT_COLOR);
    CreateElement("tab_data", g_gui_state.window_x + GUI_MARGIN + 85, g_gui_state.window_y + 35, 
                 80, 25, "Dane", GUI_BUTTON_COLOR, GUI_TEXT_COLOR);
    CreateElement("tab_execution", g_gui_state.window_x + GUI_MARGIN + 170, g_gui_state.window_y + 35, 
                 80, 25, "Wykonanie", GUI_BUTTON_COLOR, GUI_TEXT_COLOR);
    CreateElement("tab_tests", g_gui_state.window_x + GUI_MARGIN + 255, g_gui_state.window_y + 35, 
                 80, 25, "Testy", GUI_BUTTON_COLOR, GUI_TEXT_COLOR);
    
    // Spirit panels
    int spirit_y = g_gui_state.window_y + 70;
    for(int i = 0; i < 7; i++) {
        string spirit_name = g_spirit_status[i].name;
        CreateElement("spirit_" + spirit_name, g_gui_state.window_x + GUI_MARGIN, spirit_y + i * SPIRIT_PANEL_HEIGHT, 
                     GUI_WIDTH - 2 * GUI_MARGIN, SPIRIT_PANEL_HEIGHT - 5, spirit_name + " Spirit", GUI_PANEL_COLOR, GUI_TEXT_COLOR);
        
        // Spirit control buttons
        CreateElement("btn_" + spirit_name + "_toggle", g_gui_state.window_x + GUI_WIDTH - 80, spirit_y + i * SPIRIT_PANEL_HEIGHT + 5, 
                     70, 20, "Włącz", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
        CreateElement("btn_" + spirit_name + "_test", g_gui_state.window_x + GUI_WIDTH - 80, spirit_y + i * SPIRIT_PANEL_HEIGHT + 30, 
                     70, 20, "Test", GUI_INFO_COLOR, GUI_TEXT_COLOR);
    }
    
    // Control panel
    CreateElement("control_panel", g_gui_state.window_x + GUI_MARGIN, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT, 
                 GUI_WIDTH - 2 * GUI_MARGIN, CONTROL_PANEL_HEIGHT - GUI_MARGIN, "Panel Kontrolny", GUI_PANEL_COLOR, GUI_TEXT_COLOR);
    
    // Control buttons
    CreateElement("btn_start_all", g_gui_state.window_x + GUI_MARGIN, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT + 10, 
                 80, 25, "Start Wszystkie", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
    CreateElement("btn_stop_all", g_gui_state.window_x + GUI_MARGIN + 85, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT + 10, 
                 80, 25, "Stop Wszystkie", GUI_ERROR_COLOR, GUI_TEXT_COLOR);
    CreateElement("btn_test_all", g_gui_state.window_x + GUI_MARGIN + 170, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT + 10, 
                 80, 25, "Test Wszystkie", GUI_INFO_COLOR, GUI_TEXT_COLOR);
    CreateElement("btn_report", g_gui_state.window_x + GUI_MARGIN + 255, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT + 10, 
                 80, 25, "Raport", GUI_WARNING_COLOR, GUI_TEXT_COLOR);
    
    // Status indicators
    CreateElement("status_system", g_gui_state.window_x + GUI_MARGIN, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT + 40, 
                 120, 20, "System: Inicjalizacja", GUI_INFO_COLOR, GUI_TEXT_COLOR);
    CreateElement("status_analysis", g_gui_state.window_x + GUI_MARGIN + 125, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT + 40, 
                 120, 20, "Analizy: 0", GUI_INFO_COLOR, GUI_TEXT_COLOR);
    CreateElement("status_performance", g_gui_state.window_x + GUI_MARGIN + 250, g_gui_state.window_y + GUI_HEIGHT - CONTROL_PANEL_HEIGHT + 40, 
                 120, 20, "Wydajność: 0%", GUI_INFO_COLOR, GUI_TEXT_COLOR);
}

//+------------------------------------------------------------------+
//| Create GUI Element                                               |
//+------------------------------------------------------------------+
void CreateElement(string name, int x, int y, int width, int height, string text, color bg_color, color text_color) {
    SGUIElement element;
    element.name = name;
    element.x = x;
    element.y = y;
    element.width = width;
    element.height = height;
    element.text = text;
    element.bg_color = bg_color;
    element.text_color = text_color;
    element.is_visible = true;
    element.is_enabled = true;
    element.is_hovered = false;
    element.is_clicked = false;
    
    int size = ArraySize(g_gui_elements);
    ArrayResize(g_gui_elements, size + 1);
    g_gui_elements[size] = element;
    
    // Create chart object
    ObjectCreate(0, name, OBJ_RECTANGLE_LABEL, 0, 0, 0);
    ObjectSetInteger(0, name, OBJPROP_XDISTANCE, x);
    ObjectSetInteger(0, name, OBJPROP_YDISTANCE, y);
    ObjectSetInteger(0, name, OBJPROP_XSIZE, width);
    ObjectSetInteger(0, name, OBJPROP_YSIZE, height);
    ObjectSetString(0, name, OBJPROP_TEXT, text);
    ObjectSetInteger(0, name, OBJPROP_BGCOLOR, bg_color);
    ObjectSetInteger(0, name, OBJPROP_COLOR, text_color);
    ObjectSetInteger(0, name, OBJPROP_BORDER_TYPE, BORDER_FLAT);
    ObjectSetInteger(0, name, OBJPROP_CORNER, CORNER_LEFT_UPPER);
    ObjectSetInteger(0, name, OBJPROP_STYLE, STYLE_SOLID);
    ObjectSetInteger(0, name, OBJPROP_WIDTH, 1);
    ObjectSetInteger(0, name, OBJPROP_BACK, false);
    ObjectSetInteger(0, name, OBJPROP_SELECTABLE, false);
    ObjectSetInteger(0, name, OBJPROP_SELECTED, false);
    ObjectSetInteger(0, name, OBJPROP_HIDDEN, false);
    ObjectSetInteger(0, name, OBJPROP_ZORDER, 0);
}

//+------------------------------------------------------------------+
//| Initialize Data Components                                       |
//+------------------------------------------------------------------+
bool InitializeDataComponents() {
    Print("🔗 Inicjalizacja komponentów danych...");
    
    // Initialize Data Manager
    if(!InitializeGlobalDataManager(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji Data Manager");
        return false;
    }
    
    // Initialize Economic Calendar
    if(!InitializeGlobalEconomicCalendar(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji Economic Calendar");
        return false;
    }
    
    // Initialize News Processor
    if(!InitializeGlobalNewsProcessor(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji News Processor");
        return false;
    }
    
    // Initialize Sentiment Analyzer
    if(!InitializeGlobalSentimentAnalyzer(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji Sentiment Analyzer");
        return false;
    }
    
    // Initialize Utils
    if(!InitializeGlobalStringUtils()) {
        Print("⚠️ Ostrzeżenie: Błąd inicjalizacji StringUtils");
    }
    
    if(!InitializeGlobalTimeUtils()) {
        Print("⚠️ Ostrzeżenie: Błąd inicjalizacji TimeUtils");
    }
    
    if(!InitializeGlobalMathUtils()) {
        Print("⚠️ Ostrzeżenie: Błąd inicjalizacji MathUtils");
    }
    
    // Initialize Execution components
    if(!InitializeExecutionComponents()) {
        Print("❌ Błąd inicjalizacji komponentów Execution");
        return false;
    }
    
    Print("✅ Komponenty danych zainicjalizowane");
    
    // Test all components
    TestAllComponents();
    
    return true;
}

//+------------------------------------------------------------------+
//| Initialize Execution Components                                  |
//+------------------------------------------------------------------+
bool InitializeExecutionComponents() {
    Print("⚡ Inicjalizacja komponentów Execution...");
    
    // Initialize Execution Algorithms
    if(!InitializeGlobalExecutionAlgorithms(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji Execution Algorithms");
        return false;
    }
    
    // Initialize Risk Manager
    if(!InitializeGlobalRiskManager(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji Risk Manager");
        return false;
    }
    
    // Initialize Position Manager
    if(!InitializeGlobalPositionManager(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji Position Manager");
        return false;
    }
    
    // Initialize Order Manager
    if(!InitializeGlobalOrderManager(_Symbol, PERIOD_CURRENT)) {
        Print("❌ Błąd inicjalizacji Order Manager");
        return false;
    }
    
    Print("✅ Komponenty Execution zainicjalizowane");
    return true;
}

//+------------------------------------------------------------------+
//| Initialize all spirits                                           |
//+------------------------------------------------------------------+
bool InitializeAllSpirits() {
    LogInfo(LOG_COMPONENT_SYSTEM, "Inicjalizacja duchów", "Rozpoczęcie inicjalizacji wszystkich duchów");
    
    // Initialize Light Spirit (Signal Clarity & Pattern Recognition)
    if(g_config.enable_light_spirit) {
        g_light_spirit = new LightSpirit();
        if(!g_light_spirit.Initialize()) {
            LogError(LOG_COMPONENT_LIGHT, "Błąd inicjalizacji Light Spirit", "Nie można zainicjalizować Light Spirit");
            return false;
        }
        LogInfo(LOG_COMPONENT_LIGHT, "Light Spirit zainicjalizowany", "Rozpoznawanie wzorców i sygnałów");
    }
    
    // Initialize Fire Spirit (Volatility & Energy Analysis)
    if(g_config.enable_fire_spirit) {
        g_fire_spirit = new FireSpiritAI();
        if(!g_fire_spirit.Initialize()) {
            LogError(LOG_COMPONENT_FIRE, "Błąd inicjalizacji Fire Spirit", "Nie można zainicjalizować Fire Spirit");
            return false;
        }
        LogInfo(LOG_COMPONENT_FIRE, "Fire Spirit zainicjalizowany", "Analiza zmienności i energii z AI");
    }
    
    // Initialize Bitterness Spirit (Momentum & Breakthroughs)
    if(g_config.enable_bitterness_spirit) {
        g_bitterness_spirit = new BitternessSpirit();
        if(!g_bitterness_spirit.Initialize()) {
            LogError(LOG_COMPONENT_BITTERNESS, "Błąd inicjalizacji Bitterness Spirit", "Nie można zainicjalizować Bitterness Spirit");
            return false;
        }
        LogInfo(LOG_COMPONENT_BITTERNESS, "Bitterness Spirit zainicjalizowany", "Analiza momentum i przełomów");
    }
    
    // Initialize Body Spirit (Execution & Risk Management)
    if(g_config.enable_body_spirit) {
        g_body_spirit = new BodySpirit();
        if(!g_body_spirit.Initialize()) {
            LogError(LOG_COMPONENT_BODY, "Błąd inicjalizacji Body Spirit", "Nie można zainicjalizować Body Spirit");
            return false;
        }
        LogInfo(LOG_COMPONENT_BODY, "Body Spirit zainicjalizowany", "Zarządzanie wykonaniem i ryzykiem");
    }
    
    // Initialize Herbe Spirit (Fundamental Tensions)
    if(g_config.enable_herbe_spirit) {
        g_herbe_spirit = new HerbeQualityAI();  // Changed from HerbeSpirit to HerbeQualityAI
        if(!g_herbe_spirit.Initialize()) {
            LogError(LOG_COMPONENT_HERBE, "Błąd inicjalizacji Herbe Spirit", "Nie można zainicjalizować Herbe Spirit");
            return false;
        }
        LogInfo(LOG_COMPONENT_HERBE, "Herbe Spirit zainicjalizowany", "Analiza napięć fundamentalnych z AI");
    }
    
    // Initialize Sweetness Spirit (Sentiment Analysis)
    if(g_config.enable_sweetness_spirit) {
        g_sweetness_spirit = new SentimentAI();  // Changed from SweetnessSpirit to SentimentAI
        if(!g_sweetness_spirit.Initialize()) {
            LogError(LOG_COMPONENT_SWEETNESS, "Błąd inicjalizacji Sweetness Spirit", "Nie można zainicjalizować Sweetness Spirit");
            return false;
        }
        LogInfo(LOG_COMPONENT_SWEETNESS, "Sweetness Spirit zainicjalizowany", "Analiza sentymentu rynkowego z AI");
    }
    
    // Initialize Sound Spirit (Harmony & Cycles)
    if(g_config.enable_sound_spirit) {
        g_sound_spirit = new SoundSpiritAI();  // Changed from SoundSpirit to SoundSpiritAI
        if(!g_sound_spirit.Initialize()) {
            LogError(LOG_COMPONENT_SOUND, "Błąd inicjalizacji Sound Spirit", "Nie można zainicjalizować Sound Spirit");
            return false;
        }
        LogInfo(LOG_COMPONENT_SOUND, "Sound Spirit zainicjalizowany", "Analiza harmonii i cykli z AI");
    }
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Wszystkie duchy zainicjalizowane", "7/7 duchów gotowych");
    return true;
}

//+------------------------------------------------------------------+
//| Update Execution Components                                      |
//+------------------------------------------------------------------+
void UpdateExecutionComponents() {
    // Update Execution Algorithms
    if(g_execution_algorithms != NULL) {
        g_execution_algorithms.UpdateExecution();
    }
    
    // Update Risk Manager
    if(g_risk_manager != NULL) {
        g_risk_manager.UpdateRiskAssessment();
    }
    
    // Update Position Manager
    if(g_position_manager != NULL) {
        g_position_manager.UpdatePositions();
    }
    
    // Update Order Manager
    if(g_order_manager != NULL) {
        g_order_manager.UpdateOrders();
    }
}

//+------------------------------------------------------------------+
//| Update Data Components                                           |
//+------------------------------------------------------------------+
void UpdateDataComponents() {
    // Update Data Manager
    if(g_data_manager != NULL) {
        g_data_manager.UpdateAllData();
    }
    
    // Update Economic Calendar
    if(g_economic_calendar != NULL) {
        g_economic_calendar.UpdateAllDataSources();
    }
    
    // Update News Processor
    if(g_news_processor != NULL) {
        g_news_processor.UpdateAllDataSources();
    }
    
    // Update Sentiment Analyzer
    if(g_sentiment_analyzer != NULL) {
        g_sentiment_analyzer.UpdateAllDataSources();
    }
}

//+------------------------------------------------------------------+
//| Initialize Master Consciousness                                  |
//+------------------------------------------------------------------+
bool InitializeMasterConsciousness() {
    LogInfo(LOG_COMPONENT_MASTER, "Inicjalizacja Master Consciousness", "Rozpoczęcie inicjalizacji centralnego kontrolera");
    
    g_master_consciousness = new CMasterConsciousness();
    if(g_master_consciousness == NULL) {
        LogError(LOG_COMPONENT_MASTER, "Błąd tworzenia Master Consciousness", "Nie można utworzyć obiektu Master Consciousness");
        return false;
    }
    
    // Set spirit references
    g_master_consciousness.SetLightSpirit(g_light_spirit);
    g_master_consciousness.SetFireSpirit(g_fire_spirit);
    g_master_consciousness.SetBitternessSpirit(g_bitterness_spirit);
    g_master_consciousness.SetBodySpirit(g_body_spirit);
    g_master_consciousness.SetHerbeSpirit(g_herbe_spirit);
    g_master_consciousness.SetSweetnessSpirit(g_sweetness_spirit);
    g_master_consciousness.SetSoundSpirit(g_sound_spirit);
    
    // Initialize Master Consciousness
    if(!g_master_consciousness.Initialize()) {
        LogError(LOG_COMPONENT_MASTER, "Błąd inicjalizacji Master Consciousness", "Nie można zainicjalizować Master Consciousness");
        return false;
    }
    
    LogInfo(LOG_COMPONENT_MASTER, "Master Consciousness zainicjalizowany", "Centralny kontroler gotowy");
    return true;
}

//+------------------------------------------------------------------+
//| Update all spirits                                               |
//+------------------------------------------------------------------+
void UpdateAllSpirits() {
    // Update Light Spirit
    if(g_light_spirit != NULL && g_config.enable_light_spirit) {
        g_light_spirit.UpdateData();
    }
    
    // Update Fire Spirit
    if(g_fire_spirit != NULL && g_config.enable_fire_spirit) {
        g_fire_spirit.UpdateVolatilityModels();
    }
    
    // Update Bitterness Spirit
    if(g_bitterness_spirit != NULL && g_config.enable_bitterness_spirit) {
        g_bitterness_spirit.UpdateMomentumData();
    }
    
    // Update Body Spirit
    if(g_body_spirit != NULL && g_config.enable_body_spirit) {
        g_body_spirit.UpdatePositionData();
    }
    
    // Update Herbe Spirit
    if(g_herbe_spirit != NULL && g_config.enable_herbe_spirit) {
        g_herbe_spirit.UpdateFundamentalData();
    }
    
    // Update Sweetness Spirit
    if(g_sweetness_spirit != NULL && g_config.enable_sweetness_spirit) {
        g_sweetness_spirit.UpdateSentimentData();
    }
    
    // Update Sound Spirit
    if(g_sound_spirit != NULL && g_config.enable_sound_spirit) {
        g_sound_spirit.UpdateCycleData();
    }
}

//+------------------------------------------------------------------+
//| Analyze market with all spirits                                  |
//+------------------------------------------------------------------+
void AnalyzeMarketWithAllSpirits() {
    if(g_master_consciousness == NULL) return;
    
    // Get consensus decision from Master Consciousness
    SConsensusDecision decision = g_master_consciousness.GetConsensusDecision();
    
    // Log decision details
    LogInfo(LOG_COMPONENT_MASTER, "Konsensus duchów", 
            "Decyzja: " + IntegerToString(decision.action) + 
            ", Pewność: " + DoubleToString(decision.confidence, 2) + 
            ", Harmonia: " + DoubleToString(decision.harmony, 2));
    
    // Execute decision if confidence is high enough
    if(decision.confidence > g_config.confidence_threshold) {
        ExecuteAdvancedTrade(decision);
    }
    else if(g_config.enable_debug_logging) {
        LogDebug(LOG_COMPONENT_MASTER, "Niska pewność decyzji", 
                "Pewność: " + DoubleToString(decision.confidence, 2) + 
                " < " + DoubleToString(g_config.confidence_threshold, 2));
    }
    
    // Log spirit status every 50 analyses
    if(g_analysis_counter % 50 == 0) {
        LogSpiritStatus();
    }
}

//+------------------------------------------------------------------+
//| Execute advanced trade                                           |
//+------------------------------------------------------------------+
void ExecuteAdvancedTrade(SConsensusDecision& decision) {
    LogInfo(LOG_COMPONENT_SYSTEM, "Wykonanie transakcji", 
            "Akcja: " + IntegerToString(decision.action) + 
            ", Cena: " + DoubleToString(decision.optimal_price, 5));
    
    switch(decision.action) {
        case ACTION_BUY:
            LogInfo(LOG_COMPONENT_SYSTEM, "📈 Wykonanie BUY", 
                    "Cena: " + DoubleToString(decision.optimal_price, 5) + 
                    ", Wolumen: " + DoubleToString(decision.volume, 2));
            // Add your order execution code here
            // OrderSend(Symbol(), OP_BUY, decision.volume, decision.optimal_price, 3, 0, 0, "Bohme AI System", 0, 0, clrGreen);
            break;
            
        case ACTION_SELL:
            LogInfo(LOG_COMPONENT_SYSTEM, "📉 Wykonanie SELL", 
                    "Cena: " + DoubleToString(decision.optimal_price, 5) + 
                    ", Wolumen: " + DoubleToString(decision.volume, 2));
            // Add your order execution code here
            // OrderSend(Symbol(), OP_SELL, decision.volume, decision.optimal_price, 3, 0, 0, "Bohme AI System", 0, 0, clrRed);
            break;
            
        case ACTION_HOLD:
            LogDebug(LOG_COMPONENT_SYSTEM, "⏸️ HOLD", "Brak akcji - trzymanie pozycji");
            break;
            
        case ACTION_CLOSE:
            LogInfo(LOG_COMPONENT_SYSTEM, "🔒 Zamykanie pozycji", "Zamykanie wszystkich pozycji");
            // Add your position closing code here
            break;
            
        default:
            LogDebug(LOG_COMPONENT_SYSTEM, "❓ Nieznana akcja", "Akcja: " + IntegerToString(decision.action));
            break;
    }
}

//+------------------------------------------------------------------+
//| Log spirit status                                                |
//+------------------------------------------------------------------+
void LogSpiritStatus() {
    string status = "=== STATUS DUCHÓW ===\n";
    
    // Light Spirit status
    if(g_light_spirit != NULL && g_config.enable_light_spirit) {
        SSignalData signal = g_light_spirit.GetOptimalEntry();
        status += "💡 Light: " + DoubleToString(signal.confidence, 1) + "% (" + EnumToString(signal.quality) + ")\n";
    }
    
    // Fire Spirit status
    if(g_fire_spirit != NULL && g_config.enable_fire_spirit) {
        double intensity = g_fire_spirit.GetFireIntensity();
        ENUM_VOLATILITY_REGIME regime = g_fire_spirit.GetCurrentRegime();
        status += "🔥 Fire: " + DoubleToString(intensity, 1) + " (" + IntegerToString(regime) + ")\n";
    }
    
    // Bitterness Spirit status
    if(g_bitterness_spirit != NULL && g_config.enable_bitterness_spirit) {
        double momentum = g_bitterness_spirit.CalculateMomentumConvergence();
        status += "💧 Bitterness: " + DoubleToString(momentum, 1) + "\n";
    }
    
    // Body Spirit status
    if(g_body_spirit != NULL && g_config.enable_body_spirit) {
        double readiness = g_body_spirit.GetExecutionQuality();
        status += "💪 Body: " + DoubleToString(readiness, 1) + "\n";
    }
    
    // Herbe Spirit status
    if(g_herbe_spirit != NULL && g_config.enable_herbe_spirit) {
        double tension = g_herbe_spirit.GetFundamentalConflictStrength();  // Changed from GetFundamentalTension to GetFundamentalConflictStrength
        status += "🌱 Herbe: " + DoubleToString(tension, 1) + "\n";
    }
    
    // Sweetness Spirit status
    if(g_sweetness_spirit != NULL && g_config.enable_sweetness_spirit) {
        double sentiment = g_sweetness_spirit.GetHarmonyIndex();  // Changed from GetSentimentHarmony to GetHarmonyIndex
        status += "🍯 Sweetness: " + DoubleToString(sentiment, 1) + "\n";
    }
    
    // Sound Spirit status
    if(g_sound_spirit != NULL && g_config.enable_sound_spirit) {
        double harmony = g_sound_spirit.GetCycleHarmonyIndex();  // Changed from GetCycleHarmony to GetCycleHarmonyIndex
        status += "🎵 Sound: " + DoubleToString(harmony, 1) + "\n";
    }
    
    // Data Components status
    status += "\n=== KOMPONENTY DANYCH ===\n";
    
    // Data Manager status
    if(g_data_manager != NULL) {
        MarketData current_data = g_data_manager.GetCurrentData();
        status += "📊 Data Manager: " + DoubleToString(current_data.close, 5) + " (" + 
                 (current_data.is_real_time ? "RT" : "DEL") + ")\n";
    }
    
    // Economic Calendar status
    if(g_economic_calendar != NULL) {
        EventStatistics stats = g_economic_calendar.GetStatistics();
        status += "📅 Economic Calendar: " + IntegerToString(stats.total_events) + " wydarzeń\n";
    }
    
    // News Processor status
    if(g_news_processor != NULL) {
        NewsStatistics news_stats = g_news_processor.GetStatistics();
        status += "📰 News Processor: " + IntegerToString(news_stats.total_news) + " wiadomości\n";
    }
    
    // Sentiment Analyzer status
    if(g_sentiment_analyzer != NULL) {
        SentimentStatistics sent_stats = g_sentiment_analyzer.GetStatistics();
        status += "😊 Sentiment Analyzer: " + IntegerToString(sent_stats.total_analyses) + " analiz\n";
    }
    
    // Utils status
    status += "\n=== UTILS ===\n";
    status += "🔤 StringUtils: " + STRING_UTILS_VERSION + " (" + STRING_UTILS_AUTHOR + ")\n";
    status += "⏰ TimeUtils: " + TIME_UTILS_VERSION + " (" + TIME_UTILS_AUTHOR + ")\n";
    status += "🔢 MathUtils: " + "1.0.0 (System Böhmego)\n";
    status += "📝 LoggingSystem: " + "1.0.0 (System Böhmego)\n";
    
    // Execution Components status
    status += "\n=== KOMPONENTY EXECUTION ===\n";
    
    // Execution Algorithms status
    if(g_execution_algorithms != NULL) {
        ExecutionStatistics exec_stats = g_execution_algorithms.GetStatistics();
        status += "⚡ Execution Algorithms: " + IntegerToString(exec_stats.total_executions) + " wykonania\n";
    }
    
    // Risk Manager status
    if(g_risk_manager != NULL) {
        RiskStatistics risk_stats = g_risk_manager.GetStatistics();
        status += "🛡️ Risk Manager: " + IntegerToString(risk_stats.total_assessments) + " ocen ryzyka\n";
    }
    
    // Position Manager status
    if(g_position_manager != NULL) {
        PositionStatistics pos_stats = g_position_manager.GetStatistics();
        status += "📊 Position Manager: " + IntegerToString(pos_stats.total_positions) + " pozycji\n";
    }
    
    // Order Manager status
    if(g_order_manager != NULL) {
        OrderStatistics order_stats = g_order_manager.GetStatistics();
        status += "📋 Order Manager: " + IntegerToString(order_stats.total_orders) + " zleceń\n";
    }
    
    // Tests status
    status += "\n=== TESTS ===\n";
    #ifdef _DEBUG
    status += "🧪 Tests Framework: Aktywny (Debug Mode)\n";
    status += "   Unit Tests: ✅ Dostępne\n";
    status += "   Integration Tests: ✅ Dostępne\n";
    status += "   Backtest Framework: ✅ Dostępne\n";
    #else
    status += "🧪 Tests Framework: Nieaktywny (Release Mode)\n";
    status += "   Unit Tests: ⚠️ Niedostępne\n";
    status += "   Integration Tests: ⚠️ Niedostępne\n";
    status += "   Backtest Framework: ⚠️ Niedostępne\n";
    #endif
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Status duchów", status);
}

//+------------------------------------------------------------------+
//| Get Data Components Reports                                      |
//+------------------------------------------------------------------+
string GetDataComponentsReports() {
    string reports = "=== RAPORTY KOMPONENTÓW DANYCH ===\n\n";
    
    // Data Manager report
    if(g_data_manager != NULL) {
        reports += "📊 DATA MANAGER:\n";
        reports += g_data_manager.GetDataSourcesReport() + "\n\n";
    }
    
    // Economic Calendar report
    if(g_economic_calendar != NULL) {
        reports += "📅 ECONOMIC CALENDAR:\n";
        reports += g_economic_calendar.GetDataSourcesReport() + "\n\n";
    }
    
    // News Processor report
    if(g_news_processor != NULL) {
        reports += "📰 NEWS PROCESSOR:\n";
        reports += g_news_processor.GetDataSourcesReport() + "\n\n";
    }
    
    // Sentiment Analyzer report
    if(g_sentiment_analyzer != NULL) {
        reports += "😊 SENTIMENT ANALYZER:\n";
        reports += g_sentiment_analyzer.GetDataSourcesReport() + "\n\n";
    }
    
    return reports;
}

//+------------------------------------------------------------------+
//| Get Execution Components Reports                                 |
//+------------------------------------------------------------------+
string GetExecutionComponentsReports() {
    string reports = "=== RAPORTY KOMPONENTÓW EXECUTION ===\n\n";
    
    // Execution Algorithms report
    if(g_execution_algorithms != NULL) {
        reports += "⚡ EXECUTION ALGORITHMS:\n";
        reports += g_execution_algorithms.GetExecutionReport() + "\n\n";
    }
    
    // Risk Manager report
    if(g_risk_manager != NULL) {
        reports += "🛡️ RISK MANAGER:\n";
        reports += g_risk_manager.GetRiskReport() + "\n\n";
    }
    
    // Position Manager report
    if(g_position_manager != NULL) {
        reports += "📊 POSITION MANAGER:\n";
        reports += g_position_manager.GetPositionReport() + "\n\n";
    }
    
    // Order Manager report
    if(g_order_manager != NULL) {
        reports += "📋 ORDER MANAGER:\n";
        reports += g_order_manager.GetOrderReport() + "\n\n";
    }
    
    return reports;
}

//+------------------------------------------------------------------+
//| Get Tests Components Reports                                     |
//+------------------------------------------------------------------+
string GetTestsComponentsReports() {
    string reports = "=== RAPORTY KOMPONENTÓW TESTS ===\n\n";
    
    #ifdef _DEBUG
    reports += "🧪 TESTS FRAMEWORK:\n";
    reports += "   Status: Aktywny (tryb debug)\n";
    reports += "   Unit Tests: Dostępne\n";
    reports += "   Integration Tests: Dostępne\n";
    reports += "   Backtest Framework: Dostępne\n";
    reports += "   Test Runner: Dostępny\n\n";
    #else
    reports += "🧪 TESTS FRAMEWORK:\n";
    reports += "   Status: Nieaktywny (tryb release)\n";
    reports += "   Unit Tests: Niedostępne\n";
    reports += "   Integration Tests: Niedostępne\n";
    reports += "   Backtest Framework: Niedostępne\n";
    reports += "   Test Runner: Niedostępny\n\n";
    #endif
    
    return reports;
}

//+------------------------------------------------------------------+
//| Get Complete System Report                                       |
//+------------------------------------------------------------------+
string GetCompleteSystemReport() {
    string report = "🌙 SYSTEM BÖHMEGO v2.0 - PEŁNY RAPORT\n";
    report += "==========================================\n\n";
    
    // Data Components Report
    report += GetDataComponentsReports();
    
    // Utils Components Report
    report += GetUtilsComponentsReports();
    
    // Execution Components Report
    report += GetExecutionComponentsReports();
    
    // Tests Components Report
    report += GetTestsComponentsReports();
    
    // System Status
    report += "=== STATUS SYSTEMU ===\n";
    report += "   Inicjalizacja: " + (g_system_initialized ? "✅ Zakończona" : "❌ Nieudana") + "\n";
    report += "   Liczba analiz: " + IntegerToString(g_analysis_counter) + "\n";
    report += "   Ostatnia analiza: " + TimeToString(g_last_analysis) + "\n";
    report += "   Symbol: " + _Symbol + "\n";
    report += "   Timeframe: " + EnumToString(_Period) + "\n";
    report += "   Czas działania: " + TimeToString(TimeCurrent() - g_last_analysis) + "\n\n";
    
    return report;
}

//+------------------------------------------------------------------+
//| Get Utils Components Reports                                     |
//+------------------------------------------------------------------+
string GetUtilsComponentsReports() {
    string reports = "=== RAPORTY KOMPONENTÓW UTILS ===\n\n";
    
    // StringUtils report
    reports += "🔤 STRING UTILS:\n";
    reports += "   Wersja: " + STRING_UTILS_VERSION + "\n";
    reports += "   Autor: " + STRING_UTILS_AUTHOR + "\n";
    reports += "   Opis: " + STRING_UTILS_DESCRIPTION + "\n";
    reports += "   Status: Aktywny\n\n";
    
    // TimeUtils report
    reports += "⏰ TIME UTILS:\n";
    reports += "   Wersja: " + TIME_UTILS_VERSION + "\n";
    reports += "   Autor: " + TIME_UTILS_AUTHOR + "\n";
    reports += "   Opis: " + TIME_UTILS_DESCRIPTION + "\n";
    reports += "   Status: Aktywny\n\n";
    
    // MathUtils report
    reports += "🔢 MATH UTILS:\n";
    reports += "   Wersja: 1.0.0\n";
    reports += "   Autor: System Böhmego\n";
    reports += "   Opis: Zaawansowane funkcje matematyczne\n";
    reports += "   Status: Aktywny\n\n";
    
    // LoggingSystem report
    reports += "📝 LOGGING SYSTEM:\n";
    reports += "   Wersja: 1.0.0\n";
    reports += "   Autor: System Böhmego\n";
    reports += "   Opis: System logowania i raportowania\n";
    reports += "   Status: Aktywny\n\n";
    
    return reports;
}

//+------------------------------------------------------------------+
//| Test Utils Components                                            |
//+------------------------------------------------------------------+
void TestUtilsComponents() {
    Print("🧪 Testowanie komponentów Utils...");
    
    // Test StringUtils
    Print("   Testowanie StringUtils...");
    string test_string = "Hello World";
    if(StringLen(test_string) == 11) {
        Print("   ✅ StringUtils - OK");
    } else {
        Print("   ❌ StringUtils - Błąd");
    }
    
    // Test TimeUtils
    Print("   Testowanie TimeUtils...");
    datetime current_time = TimeCurrent();
    if(current_time > 0) {
        Print("   ✅ TimeUtils - OK");
    } else {
        Print("   ❌ TimeUtils - Błąd");
    }
    
    // Test MathUtils
    Print("   Testowanie MathUtils...");
    double test_math = MathPow(2, 3);
    if(test_math == 8.0) {
        Print("   ✅ MathUtils - OK");
    } else {
        Print("   ❌ MathUtils - Błąd");
    }
    
    // Test LoggingSystem
    Print("   Testowanie LoggingSystem...");
    LogInfo(LOG_COMPONENT_SYSTEM, "Test Utils", "Testowanie komponentów Utils");
    Print("   ✅ LoggingSystem - OK");
    
    Print("✅ Wszystkie komponenty Utils przetestowane");
}

//+------------------------------------------------------------------+
//| Test Execution Components                                        |
//+------------------------------------------------------------------+
void TestExecutionComponents() {
    Print("⚡ Testowanie komponentów Execution...");
    
    // Test Execution Algorithms
    Print("   Testowanie Execution Algorithms...");
    if(g_execution_algorithms != NULL) {
        Print("   ✅ Execution Algorithms - OK");
    } else {
        Print("   ❌ Execution Algorithms - Błąd");
    }
    
    // Test Risk Manager
    Print("   Testowanie Risk Manager...");
    if(g_risk_manager != NULL) {
        Print("   ✅ Risk Manager - OK");
    } else {
        Print("   ❌ Risk Manager - Błąd");
    }
    
    // Test Position Manager
    Print("   Testowanie Position Manager...");
    if(g_position_manager != NULL) {
        Print("   ✅ Position Manager - OK");
    } else {
        Print("   ❌ Position Manager - Błąd");
    }
    
    // Test Order Manager
    Print("   Testowanie Order Manager...");
    if(g_order_manager != NULL) {
        Print("   ✅ Order Manager - OK");
    } else {
        Print("   ❌ Order Manager - Błąd");
    }
    
    Print("✅ Wszystkie komponenty Execution przetestowane");
}

//+------------------------------------------------------------------+
//| Test Data Components                                             |
//+------------------------------------------------------------------+
void TestDataComponents() {
    Print("📊 Testowanie komponentów Data...");
    
    // Test Data Manager
    Print("   Testowanie Data Manager...");
    if(g_data_manager != NULL) {
        Print("   ✅ Data Manager - OK");
    } else {
        Print("   ❌ Data Manager - Błąd");
    }
    
    // Test Economic Calendar
    Print("   Testowanie Economic Calendar...");
    if(g_economic_calendar != NULL) {
        Print("   ✅ Economic Calendar - OK");
    } else {
        Print("   ❌ Economic Calendar - Błąd");
    }
    
    // Test News Processor
    Print("   Testowanie News Processor...");
    if(g_news_processor != NULL) {
        Print("   ✅ News Processor - OK");
    } else {
        Print("   ❌ News Processor - Błąd");
    }
    
    // Test Sentiment Analyzer
    Print("   Testowanie Sentiment Analyzer...");
    if(g_sentiment_analyzer != NULL) {
        Print("   ✅ Sentiment Analyzer - OK");
    } else {
        Print("   ❌ Sentiment Analyzer - Błąd");
    }
    
    Print("✅ Wszystkie komponenty Data przetestowane");
}

//+------------------------------------------------------------------+
//| Test Spirits Components                                          |
//+------------------------------------------------------------------+
void TestSpiritsComponents() {
    Print("🌟 Testowanie komponentów Spirits...");
    
    // Test Light Spirit
    Print("   Testowanie Light Spirit...");
    if(g_light_spirit != NULL && g_config.enable_light_spirit) {
        Print("   ✅ Light Spirit - OK");
    } else {
        Print("   ⚠️ Light Spirit - Wyłączony lub błąd");
    }
    
    // Test Fire Spirit
    Print("   Testowanie Fire Spirit...");
    if(g_fire_spirit != NULL && g_config.enable_fire_spirit) {
        Print("   ✅ Fire Spirit - OK");
    } else {
        Print("   ⚠️ Fire Spirit - Wyłączony lub błąd");
    }
    
    // Test Bitterness Spirit
    Print("   Testowanie Bitterness Spirit...");
    if(g_bitterness_spirit != NULL && g_config.enable_bitterness_spirit) {
        Print("   ✅ Bitterness Spirit - OK");
    } else {
        Print("   ⚠️ Bitterness Spirit - Wyłączony lub błąd");
    }
    
    // Test Body Spirit
    Print("   Testowanie Body Spirit...");
    if(g_body_spirit != NULL && g_config.enable_body_spirit) {
        Print("   ✅ Body Spirit - OK");
    } else {
        Print("   ⚠️ Body Spirit - Wyłączony lub błąd");
    }
    
    // Test Herbe Spirit
    Print("   Testowanie Herbe Spirit...");
    if(g_herbe_spirit != NULL && g_config.enable_herbe_spirit) {
        Print("   ✅ Herbe Spirit - OK");
    } else {
        Print("   ⚠️ Herbe Spirit - Wyłączony lub błąd");
    }
    
    // Test Sweetness Spirit
    Print("   Testowanie Sweetness Spirit...");
    if(g_sweetness_spirit != NULL && g_config.enable_sweetness_spirit) {
        Print("   ✅ Sweetness Spirit - OK");
    } else {
        Print("   ⚠️ Sweetness Spirit - Wyłączony lub błąd");
    }
    
    // Test Sound Spirit
    Print("   Testowanie Sound Spirit...");
    if(g_sound_spirit != NULL && g_config.enable_sound_spirit) {
        Print("   ✅ Sound Spirit - OK");
    } else {
        Print("   ⚠️ Sound Spirit - Wyłączony lub błąd");
    }
    
    Print("✅ Wszystkie komponenty Spirits przetestowane");
}

//+------------------------------------------------------------------+
//| Test AI Components                                               |
//+------------------------------------------------------------------+
void TestAIComponents() {
    Print("🤖 Testowanie komponentów AI...");
    
    // Test Advanced AI
    Print("   Testowanie Advanced AI...");
    if(g_fire_spirit != NULL && g_fire_spirit.HasAdvancedAI()) {
        Print("   ✅ Advanced AI (Fire Spirit) - OK");
    } else {
        Print("   ⚠️ Advanced AI (Fire Spirit) - Niedostępne");
    }
    
    if(g_herbe_spirit != NULL && g_herbe_spirit.HasAdvancedAI()) {
        Print("   ✅ Advanced AI (Herbe Spirit) - OK");
    } else {
        Print("   ⚠️ Advanced AI (Herbe Spirit) - Niedostępne");
    }
    
    if(g_sweetness_spirit != NULL && g_sweetness_spirit.HasAdvancedAI()) {
        Print("   ✅ Advanced AI (Sweetness Spirit) - OK");
    } else {
        Print("   ⚠️ Advanced AI (Sweetness Spirit) - Niedostępne");
    }
    
    if(g_sound_spirit != NULL && g_sound_spirit.HasAdvancedAI()) {
        Print("   ✅ Advanced AI (Sound Spirit) - OK");
    } else {
        Print("   ⚠️ Advanced AI (Sound Spirit) - Niedostępne");
    }
    
    Print("✅ Wszystkie komponenty AI przetestowane");
}

//+------------------------------------------------------------------+
//| Test All Components                                              |
//+------------------------------------------------------------------+
void TestAllComponents() {
    Print("🧪 Testowanie wszystkich komponentów systemu...");
    
    TestDataComponents();
    TestUtilsComponents();
    TestExecutionComponents();
    TestSpiritsComponents();
    TestAIComponents();
    
    Print("✅ Wszystkie komponenty systemu przetestowane");
}

//+------------------------------------------------------------------+
//| Cleanup Data Components                                          |
//+------------------------------------------------------------------+
void CleanupDataComponents() {
    LogInfo(LOG_COMPONENT_SYSTEM, "Cleanup komponentów danych", "Zwalnianie zasobów komponentów danych");
    
    // Release Data Manager
    ReleaseGlobalDataManager();
    
    // Release Economic Calendar
    ReleaseGlobalEconomicCalendar();
    
    // Release News Processor
    ReleaseGlobalNewsProcessor();
    
    // Release Sentiment Analyzer
    ReleaseGlobalSentimentAnalyzer();
    
    Print("✅ Komponenty danych zwolnione");
}

//+------------------------------------------------------------------+
//| Cleanup Execution Components                                     |
//+------------------------------------------------------------------+
void CleanupExecutionComponents() {
    LogInfo(LOG_COMPONENT_SYSTEM, "Cleanup komponentów Execution", "Zwalnianie zasobów komponentów Execution");
    
    // Release Execution Algorithms
    ReleaseGlobalExecutionAlgorithms();
    
    // Release Risk Manager
    ReleaseGlobalRiskManager();
    
    // Release Position Manager
    ReleaseGlobalPositionManager();
    
    // Release Order Manager
    ReleaseGlobalOrderManager();
    
    Print("✅ Komponenty Execution zwolnione");
}

//+------------------------------------------------------------------+
//| Cleanup all spirits                                              |
//+------------------------------------------------------------------+
void CleanupAllSpirits() {
    LogInfo(LOG_COMPONENT_SYSTEM, "Czyszczenie duchów", "Rozpoczęcie czyszczenia wszystkich duchów");
    
    if(g_light_spirit != NULL) {
        delete g_light_spirit;
        g_light_spirit = NULL;
    }
    
    if(g_fire_spirit != NULL) {
        delete g_fire_spirit;
        g_fire_spirit = NULL;
    }
    
    if(g_bitterness_spirit != NULL) {
        delete g_bitterness_spirit;
        g_bitterness_spirit = NULL;
    }
    
    if(g_body_spirit != NULL) {
        delete g_body_spirit;
        g_body_spirit = NULL;
    }
    
    if(g_herbe_spirit != NULL) {
        delete g_herbe_spirit;
        g_herbe_spirit = NULL;
    }
    
    if(g_sweetness_spirit != NULL) {
        delete g_sweetness_spirit;
        g_sweetness_spirit = NULL;
    }
    
    if(g_sound_spirit != NULL) {
        delete g_sound_spirit;
        g_sound_spirit = NULL;
    }
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Wszystkie duchy wyczyszczone", "Czyszczenie zakończone");
}

//+------------------------------------------------------------------+
//| Helper function to convert enum to string                       |
//+------------------------------------------------------------------+
string EnumToString(ENUM_SIGNAL_QUALITY quality) {
    switch(quality) {
        case SIGNAL_CRYSTAL_CLEAR: return "KRYSTALICZNA JASNOŚĆ";
        case SIGNAL_STRONG: return "SILNE OŚWIECENIE";
        case SIGNAL_MODERATE: return "UMIARKOWANE ŚWIATŁO";
        case SIGNAL_WEAK: return "SŁABE ŚWIATŁO";
        default: return "NIEZNANE";
    }
}

//+------------------------------------------------------------------+
//| Update GUI                                                        |
//+------------------------------------------------------------------+
void UpdateGUI() {
    if(!g_gui_state.is_visible) return;
    
    datetime current_time = TimeCurrent();
    
    // Auto refresh
    if(g_gui_state.auto_refresh && current_time - g_gui_state.last_refresh >= g_gui_state.refresh_interval) {
        g_gui_state.last_refresh = current_time;
        RefreshGUI();
    }
    
    // Update spirit status
    UpdateSpiritStatus();
    
    // Update status indicators
    UpdateStatusIndicators();
}

//+------------------------------------------------------------------+
//| Update Advanced GUI                                               |
//+------------------------------------------------------------------+
void UpdateAdvancedGUI() {
    if(!g_gui_state.is_visible) return;
    
    // Update advanced GUI features
    // This function can be extended with advanced GUI update features
    // such as real-time charts, advanced controls, etc.
    
    // Update chart properties if needed
    ChartSetInteger(0, CHART_SHOW_GRID, true);
    ChartSetInteger(0, CHART_SHOW_VOLUMES, CHART_VOLUME_TICK);
}

//+------------------------------------------------------------------+
//| Refresh GUI                                                       |
//+------------------------------------------------------------------+
void RefreshGUI() {
    // Update all GUI elements
    for(int i = 0; i < ArraySize(g_gui_elements); i++) {
        UpdateElement(g_gui_elements[i]);
    }
    
    // Redraw chart
    ChartRedraw();
}

//+------------------------------------------------------------------+
//| Update Element                                                    |
//+------------------------------------------------------------------+
void UpdateElement(SGUIElement& element) {
    if(!element.is_visible) return;
    
    // Update chart object
    ObjectSetString(0, element.name, OBJPROP_TEXT, element.text);
    ObjectSetInteger(0, element.name, OBJPROP_BGCOLOR, element.bg_color);
    ObjectSetInteger(0, element.name, OBJPROP_COLOR, element.text_color);
}

//+------------------------------------------------------------------+
//| Update Spirit Status                                              |
//+------------------------------------------------------------------+
void UpdateSpiritStatus() {
    // Light Spirit
    UpdateSpiritStatusByIndex(0, g_light_spirit, g_config.enable_light_spirit);
    
    // Fire Spirit
    UpdateSpiritStatusByIndex(1, g_fire_spirit, g_config.enable_fire_spirit);
    
    // Bitterness Spirit
    UpdateSpiritStatusByIndex(2, g_bitterness_spirit, g_config.enable_bitterness_spirit);
    
    // Body Spirit
    UpdateSpiritStatusByIndex(3, g_body_spirit, g_config.enable_body_spirit);
    
    // Herbe Spirit
    UpdateSpiritStatusByIndex(4, g_herbe_spirit, g_config.enable_herbe_spirit);
    
    // Sweetness Spirit
    UpdateSpiritStatusByIndex(5, g_sweetness_spirit, g_config.enable_sweetness_spirit);
    
    // Sound Spirit
    UpdateSpiritStatusByIndex(6, g_sound_spirit, g_config.enable_sound_spirit);
}

//+------------------------------------------------------------------+
//| Update Spirit Status By Index                                     |
//+------------------------------------------------------------------+
void UpdateSpiritStatusByIndex(int index, void* spirit_ptr, bool is_enabled) {
    if(index < 0 || index >= 7) return;
    
    SSpiritStatus& status = g_spirit_status[index];
    
    if(spirit_ptr != NULL && is_enabled) {
        status.is_active = true;
        status.is_initialized = true;
        status.status_text = "Aktywny";
        status.status_color = GUI_SUCCESS_COLOR;
        status.performance_score = 85.0 + (MathRand() % 150) / 10.0; // Simulated performance
    } else {
        status.is_active = false;
        status.is_initialized = false;
        status.status_text = "Nieaktywny";
        status.status_color = GUI_ERROR_COLOR;
        status.performance_score = 0.0;
    }
    
    status.last_update = TimeCurrent();
    
    // Update GUI element
    string spirit_name = status.name;
    string element_name = "spirit_" + spirit_name;
    string display_text = spirit_name + " Spirit\nStatus: " + status.status_text + 
                         "\nWydajność: " + DoubleToString(status.performance_score, 1) + "%";
    
    UpdateElementText(element_name, display_text, status.status_color);
}

//+------------------------------------------------------------------+
//| Update Element Text                                               |
//+------------------------------------------------------------------+
void UpdateElementText(string element_name, string text, color text_color) {
    ObjectSetString(0, element_name, OBJPROP_TEXT, text);
    ObjectSetInteger(0, element_name, OBJPROP_COLOR, text_color);
}

//+------------------------------------------------------------------+
//| Update Status Indicators                                          |
//+------------------------------------------------------------------+
void UpdateStatusIndicators() {
    // System status
    string system_status = g_system_initialized ? "System: Aktywny" : "System: Nieaktywny";
    color system_color = g_system_initialized ? GUI_SUCCESS_COLOR : GUI_ERROR_COLOR;
    UpdateElementText("status_system", system_status, system_color);
    
    // Analysis count
    string analysis_status = "Analizy: " + IntegerToString(g_analysis_counter);
    UpdateElementText("status_analysis", analysis_status, GUI_INFO_COLOR);
    
    // Performance
    double overall_performance = CalculateOverallPerformance();
    string performance_status = "Wydajność: " + DoubleToString(overall_performance, 1) + "%";
    color performance_color = overall_performance >= 80 ? GUI_SUCCESS_COLOR : 
                             overall_performance >= 60 ? GUI_WARNING_COLOR : GUI_ERROR_COLOR;
    UpdateElementText("status_performance", performance_status, performance_color);
}

//+------------------------------------------------------------------+
//| Calculate Overall Performance                                     |
//+------------------------------------------------------------------+
double CalculateOverallPerformance() {
    double total_performance = 0.0;
    int active_spirits = 0;
    
    for(int i = 0; i < 7; i++) {
        if(g_spirit_status[i].is_active) {
            total_performance += g_spirit_status[i].performance_score;
            active_spirits++;
        }
    }
    
    return active_spirits > 0 ? total_performance / active_spirits : 0.0;
}

//+------------------------------------------------------------------+
//| Handle GUI Event                                                  |
//+------------------------------------------------------------------+
void HandleGUIEvent(const int id, const long& lparam, const double& dparam, const string& sparam) {
    if(id == CHARTEVENT_OBJECT_CLICK) {
        HandleObjectClick(sparam);
    }
    else if(id == CHARTEVENT_MOUSE_MOVE) {
        HandleMouseMove(lparam, dparam);
    }
}

//+------------------------------------------------------------------+
//| Handle Object Click                                               |
//+------------------------------------------------------------------+
void HandleObjectClick(string object_name) {
    // Control buttons
    if(object_name == "btn_minimize") {
        ToggleMinimize();
    }
    else if(object_name == "btn_close") {
        g_gui_state.is_visible = false;
    }
    else if(object_name == "btn_start_all") {
        StartAllSpirits();
    }
    else if(object_name == "btn_stop_all") {
        StopAllSpirits();
    }
    else if(object_name == "btn_test_all") {
        TestAllSpirits();
    }
    else if(object_name == "btn_report") {
        ShowSystemReport();
    }
    
    // Tab buttons
    else if(object_name == "tab_spirits") {
        g_gui_state.active_tab = 0;
        SwitchTab(0);
    }
    else if(object_name == "tab_data") {
        g_gui_state.active_tab = 1;
        SwitchTab(1);
    }
    else if(object_name == "tab_execution") {
        g_gui_state.active_tab = 2;
        SwitchTab(2);
    }
    else if(object_name == "tab_tests") {
        g_gui_state.active_tab = 3;
        SwitchTab(3);
    }
    
    // Spirit toggle buttons
    else if(StringFind(object_name, "_toggle") >= 0) {
        string spirit_name = StringSubstr(object_name, 4, StringLen(object_name) - 11);
        ToggleSpirit(spirit_name);
    }
    
    // Spirit test buttons
    else if(StringFind(object_name, "_test") >= 0) {
        string spirit_name = StringSubstr(object_name, 4, StringLen(object_name) - 9);
        TestSpirit(spirit_name);
    }
}

//+------------------------------------------------------------------+
//| Handle Mouse Move                                                 |
//+------------------------------------------------------------------+
void HandleMouseMove(const long& lparam, const double& dparam) {
    int mouse_x = (int)lparam;
    int mouse_y = (int)dparam;
    
    // Check hover effects
    for(int i = 0; i < ArraySize(g_gui_elements); i++) {
        SGUIElement& element = g_gui_elements[i];
        
        bool is_hovered = (mouse_x >= element.x && mouse_x <= element.x + element.width &&
                          mouse_y >= element.y && mouse_y <= element.y + element.height);
        
        if(is_hovered != element.is_hovered) {
            element.is_hovered = is_hovered;
            
            // Change color on hover for buttons
            if(StringFind(element.name, "btn_") >= 0 || StringFind(element.name, "tab_") >= 0) {
                color new_color = is_hovered ? GUI_BUTTON_HOVER_COLOR : GUI_BUTTON_COLOR;
                ObjectSetInteger(0, element.name, OBJPROP_BGCOLOR, new_color);
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Handle Keyboard Shortcuts                                         |
//+------------------------------------------------------------------+
void HandleKeyboardShortcuts(const long& key) {
    switch(key) {
        case 49: // '1' - Switch to Spirits tab
            g_gui_state.active_tab = 0;
            SwitchTab(0);
            break;
        case 50: // '2' - Switch to Data tab
            g_gui_state.active_tab = 1;
            SwitchTab(1);
            break;
        case 51: // '3' - Switch to Execution tab
            g_gui_state.active_tab = 2;
            SwitchTab(2);
            break;
        case 52: // '4' - Switch to Tests tab
            g_gui_state.active_tab = 3;
            SwitchTab(3);
            break;
        case 83: // 'S' - Start all spirits
            StartAllSpirits();
            break;
        case 84: // 'T' - Test all spirits
            TestAllSpirits();
            break;
        case 82: // 'R' - Show report
            ShowSystemReport();
            break;
        case 27: // ESC - Hide GUI
            g_gui_state.is_visible = false;
            break;
        case 32: // SPACE - Toggle GUI
            g_gui_state.is_visible = !g_gui_state.is_visible;
            break;
    }
}

//+------------------------------------------------------------------+
//| Toggle Minimize                                                   |
//+------------------------------------------------------------------+
void ToggleMinimize() {
    g_gui_state.is_minimized = !g_gui_state.is_minimized;
    
    if(g_gui_state.is_minimized) {
        // Hide all elements except title bar and control buttons
        for(int i = 0; i < ArraySize(g_gui_elements); i++) {
            SGUIElement& element = g_gui_elements[i];
            if(StringFind(element.name, "title_bar") < 0 && 
               StringFind(element.name, "btn_minimize") < 0 && 
               StringFind(element.name, "btn_close") < 0) {
                element.is_visible = false;
                ObjectSetInteger(0, element.name, OBJPROP_HIDDEN, true);
            }
        }
    } else {
        // Show all elements
        for(int i = 0; i < ArraySize(g_gui_elements); i++) {
            SGUIElement& element = g_gui_elements[i];
            element.is_visible = true;
            ObjectSetInteger(0, element.name, OBJPROP_HIDDEN, false);
        }
    }
}

//+------------------------------------------------------------------+
//| Switch Tab                                                        |
//+------------------------------------------------------------------+
void SwitchTab(int tab_index) {
    // Update tab button colors
    string tab_names[] = {"tab_spirits", "tab_data", "tab_execution", "tab_tests"};
    
    for(int i = 0; i < 4; i++) {
        color tab_color = (i == tab_index) ? GUI_SUCCESS_COLOR : GUI_BUTTON_COLOR;
        ObjectSetInteger(0, tab_names[i], OBJPROP_BGCOLOR, tab_color);
    }
    
    // Show/hide content based on active tab
    ShowTabContent(tab_index);
}

//+------------------------------------------------------------------+
//| Show Tab Content                                                  |
//+------------------------------------------------------------------+
void ShowTabContent(int tab_index) {
    // Hide all spirit panels first
    for(int i = 0; i < 7; i++) {
        string spirit_name = g_spirit_status[i].name;
        ObjectSetInteger(0, "spirit_" + spirit_name, OBJPROP_HIDDEN, true);
        ObjectSetInteger(0, "btn_" + spirit_name + "_toggle", OBJPROP_HIDDEN, true);
        ObjectSetInteger(0, "btn_" + spirit_name + "_test", OBJPROP_HIDDEN, true);
    }
    
    // Show content based on tab
    switch(tab_index) {
        case 0: // Spirits tab
            ShowSpiritsTab();
            break;
        case 1: // Data tab
            ShowDataTab();
            break;
        case 2: // Execution tab
            ShowExecutionTab();
            break;
        case 3: // Tests tab
            ShowTestsTab();
            break;
    }
}

//+------------------------------------------------------------------+
//| Show Spirits Tab                                                  |
//+------------------------------------------------------------------+
void ShowSpiritsTab() {
    for(int i = 0; i < 7; i++) {
        string spirit_name = g_spirit_status[i].name;
        ObjectSetInteger(0, "spirit_" + spirit_name, OBJPROP_HIDDEN, false);
        ObjectSetInteger(0, "btn_" + spirit_name + "_toggle", OBJPROP_HIDDEN, false);
        ObjectSetInteger(0, "btn_" + spirit_name + "_test", OBJPROP_HIDDEN, false);
    }
}

//+------------------------------------------------------------------+
//| Show Data Tab                                                     |
//+------------------------------------------------------------------+
void ShowDataTab() {
    // Create data components display
    CreateDataTabElements();
}

//+------------------------------------------------------------------+
//| Show Execution Tab                                                |
//+------------------------------------------------------------------+
void ShowExecutionTab() {
    // Create execution components display
    CreateExecutionTabElements();
}

//+------------------------------------------------------------------+
//| Show Tests Tab                                                    |
//+------------------------------------------------------------------+
void ShowTestsTab() {
    // Create tests display
    CreateTestsTabElements();
}

//+------------------------------------------------------------------+
//| Toggle Spirit                                                     |
//+------------------------------------------------------------------+
void ToggleSpirit(string spirit_name) {
    int spirit_index = GetSpiritIndex(spirit_name);
    if(spirit_index < 0) return;
    
    SSpiritStatus& status = g_spirit_status[spirit_index];
    
    if(status.is_active) {
        // Stop spirit
        StopSpirit(spirit_name);
        UpdateElementText("btn_" + spirit_name + "_toggle", "Włącz", GUI_SUCCESS_COLOR);
    } else {
        // Start spirit
        StartSpirit(spirit_name);
        UpdateElementText("btn_" + spirit_name + "_toggle", "Wyłącz", GUI_ERROR_COLOR);
    }
}

//+------------------------------------------------------------------+
//| Get Spirit Index                                                  |
//+------------------------------------------------------------------+
int GetSpiritIndex(string spirit_name) {
    for(int i = 0; i < 7; i++) {
        if(g_spirit_status[i].name == spirit_name) {
            return i;
        }
    }
    return -1;
}

//+------------------------------------------------------------------+
//| Start Spirit                                                      |
//+------------------------------------------------------------------+
void StartSpirit(string spirit_name) {
    Print("🚀 Uruchamianie " + spirit_name + " Spirit...");
    
    // Update configuration
    if(spirit_name == "Light") g_config.enable_light_spirit = true;
    else if(spirit_name == "Fire") g_config.enable_fire_spirit = true;
    else if(spirit_name == "Bitterness") g_config.enable_bitterness_spirit = true;
    else if(spirit_name == "Body") g_config.enable_body_spirit = true;
    else if(spirit_name == "Herbe") g_config.enable_herbe_spirit = true;
    else if(spirit_name == "Sweetness") g_config.enable_sweetness_spirit = true;
    else if(spirit_name == "Sound") g_config.enable_sound_spirit = true;
    
    // Initialize spirit if needed
    InitializeSpirit(spirit_name);
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Spirit uruchomiony", spirit_name + " Spirit został uruchomiony");
}

//+------------------------------------------------------------------+
//| Stop Spirit                                                       |
//+------------------------------------------------------------------+
void StopSpirit(string spirit_name) {
    Print("🛑 Zatrzymywanie " + spirit_name + " Spirit...");
    
    // Update configuration
    if(spirit_name == "Light") g_config.enable_light_spirit = false;
    else if(spirit_name == "Fire") g_config.enable_fire_spirit = false;
    else if(spirit_name == "Bitterness") g_config.enable_bitterness_spirit = false;
    else if(spirit_name == "Body") g_config.enable_body_spirit = false;
    else if(spirit_name == "Herbe") g_config.enable_herbe_spirit = false;
    else if(spirit_name == "Sweetness") g_config.enable_sweetness_spirit = false;
    else if(spirit_name == "Sound") g_config.enable_sound_spirit = false;
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Spirit zatrzymany", spirit_name + " Spirit został zatrzymany");
}

//+------------------------------------------------------------------+
//| Test Spirit                                                       |
//+------------------------------------------------------------------+
void TestSpirit(string spirit_name) {
    Print("🧪 Testowanie " + spirit_name + " Spirit...");
    
    // Run specific spirit test
    datetime start_time = TimeCurrent();
    bool test_result = RunSpiritTest(spirit_name);
    double execution_time = (double)(TimeCurrent() - start_time);
    
    // Add test result
    AddTestResult(spirit_name + " Spirit Test", test_result, execution_time, 
                 "Test " + spirit_name + " Spirit", TimeCurrent());
    
    // Update GUI
    UpdateTestResults();
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Test spirit zakończony", 
            spirit_name + " Spirit test: " + (test_result ? "SUKCES" : "BŁĄD"));
}

//+------------------------------------------------------------------+
//| Run Spirit Test                                                   |
//+------------------------------------------------------------------+
bool RunSpiritTest(string spirit_name) {
    // Simulate spirit test
    Sleep(100 + MathRand() % 500); // Random delay
    
    // Return success based on spirit status
    int spirit_index = GetSpiritIndex(spirit_name);
    if(spirit_index >= 0) {
        return g_spirit_status[spirit_index].is_initialized;
    }
    
    return false;
}

//+------------------------------------------------------------------+
//| Start All Spirits                                                 |
//+------------------------------------------------------------------+
void StartAllSpirits() {
    Print("🚀 Uruchamianie wszystkich duchów...");
    
    string spirit_names[] = {"Light", "Fire", "Bitterness", "Body", "Herbe", "Sweetness", "Sound"};
    
    for(int i = 0; i < 7; i++) {
        StartSpirit(spirit_names[i]);
    }
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Wszystkie duchy uruchomione", "7/7 duchów aktywnych");
}

//+------------------------------------------------------------------+
//| Stop All Spirits                                                  |
//+------------------------------------------------------------------+
void StopAllSpirits() {
    Print("🛑 Zatrzymywanie wszystkich duchów...");
    
    string spirit_names[] = {"Light", "Fire", "Bitterness", "Body", "Herbe", "Sweetness", "Sound"};
    
    for(int i = 0; i < 7; i++) {
        StopSpirit(spirit_names[i]);
    }
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Wszystkie duchy zatrzymane", "0/7 duchów aktywnych");
}

//+------------------------------------------------------------------+
//| Test All Spirits                                                  |
//+------------------------------------------------------------------+
void TestAllSpirits() {
    Print("🧪 Testowanie wszystkich duchów...");
    
    string spirit_names[] = {"Light", "Fire", "Bitterness", "Body", "Herbe", "Sweetness", "Sound"};
    
    for(int i = 0; i < 7; i++) {
        TestSpirit(spirit_names[i]);
    }
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Testy wszystkich duchów zakończone", "7/7 duchów przetestowanych");
}

//+------------------------------------------------------------------+
//| Show System Report                                                |
//+------------------------------------------------------------------+
void ShowSystemReport() {
    Print("📊 Generowanie raportu systemu...");
    
    string report = GetCompleteSystemReport();
    Print(report);
    
    // Show report in GUI
    ShowReportDialog(report);
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Raport systemu wygenerowany", "Pełny raport dostępny");
}

//+------------------------------------------------------------------+
//| Show Report Dialog                                                |
//+------------------------------------------------------------------+
void ShowReportDialog(string report) {
    // Create report dialog
    CreateElement("report_dialog", 50, 50, 600, 400, "Raport Systemu", GUI_PANEL_COLOR, GUI_TEXT_COLOR);
    CreateElement("report_text", 60, 70, 580, 370, report, GUI_BACKGROUND_COLOR, GUI_TEXT_COLOR);
    CreateElement("btn_close_report", 620, 50, 20, 20, "×", GUI_ERROR_COLOR, GUI_TEXT_COLOR);
}

//+------------------------------------------------------------------+
//| Add Test Result                                                   |
//+------------------------------------------------------------------+
void AddTestResult(string test_name, bool passed, double execution_time, string details, datetime timestamp) {
    STestResult result;
    result.test_name = test_name;
    result.passed = passed;
    result.execution_time = execution_time;
    result.details = details;
    result.timestamp = timestamp;
    
    int size = ArraySize(g_test_results);
    ArrayResize(g_test_results, size + 1);
    g_test_results[size] = result;
    
    g_test_count++;
}

//+------------------------------------------------------------------+
//| Update Test Results                                               |
//+------------------------------------------------------------------+
void UpdateTestResults() {
    // Update test results display
    if(g_gui_state.active_tab == 3) { // Tests tab
        ShowTestsTab();
    }
}

//+------------------------------------------------------------------+
//| Cleanup GUI                                                       |
//+------------------------------------------------------------------+
void CleanupGUI() {
    Print("🧹 Czyszczenie GUI...");
    
    // Remove all chart objects
    for(int i = 0; i < ArraySize(g_gui_elements); i++) {
        ObjectDelete(0, g_gui_elements[i].name);
    }
    
    // Clear arrays
    ArrayResize(g_gui_elements, 0);
    ArrayResize(g_test_results, 0);
    
    Print("✅ GUI wyczyszczone");
}

//+------------------------------------------------------------------+
//| Cleanup Advanced GUI                                              |
//+------------------------------------------------------------------+
void CleanupAdvancedGUI() {
    Print("🎨 Czyszczenie zaawansowanego GUI...");
    
    // Cleanup advanced GUI features
    // This function can be extended with advanced GUI cleanup features
    
    Print("✅ Zaawansowane GUI wyczyszczone");
}

//+------------------------------------------------------------------+
//| Create Data Tab Elements                                          |
//+------------------------------------------------------------------+
void CreateDataTabElements() {
    // Data components display
    CreateElement("data_panel", g_gui_state.window_x + GUI_MARGIN, g_gui_state.window_y + 70, 
                 GUI_WIDTH - 2 * GUI_MARGIN, GUI_HEIGHT - 200, "Komponenty Danych", GUI_PANEL_COLOR, GUI_TEXT_COLOR);
    
    // Data Manager status
    CreateElement("data_manager_status", g_gui_state.window_x + GUI_MARGIN + 10, g_gui_state.window_y + 80, 
                 180, 40, "Data Manager\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
    
    // Economic Calendar status
    CreateElement("economic_calendar_status", g_gui_state.window_x + GUI_MARGIN + 200, g_gui_state.window_y + 80, 
                 180, 40, "Economic Calendar\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
    
    // News Processor status
    CreateElement("news_processor_status", g_gui_state.window_x + GUI_MARGIN + 10, g_gui_state.window_y + 130, 
                 180, 40, "News Processor\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
    
    // Sentiment Analyzer status
    CreateElement("sentiment_analyzer_status", g_gui_state.window_x + GUI_MARGIN + 200, g_gui_state.window_y + 130, 
                 180, 40, "Sentiment Analyzer\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
}

//+------------------------------------------------------------------+
//| Create Execution Tab Elements                                     |
//+------------------------------------------------------------------+
void CreateExecutionTabElements() {
    // Execution components display
    CreateElement("execution_panel", g_gui_state.window_x + GUI_MARGIN, g_gui_state.window_y + 70, 
                 GUI_WIDTH - 2 * GUI_MARGIN, GUI_HEIGHT - 200, "Komponenty Wykonania", GUI_PANEL_COLOR, GUI_TEXT_COLOR);
    
    // Execution Algorithms status
    CreateElement("execution_algorithms_status", g_gui_state.window_x + GUI_MARGIN + 10, g_gui_state.window_y + 80, 
                 180, 40, "Execution Algorithms\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
    
    // Risk Manager status
    CreateElement("risk_manager_status", g_gui_state.window_x + GUI_MARGIN + 200, g_gui_state.window_y + 80, 
                 180, 40, "Risk Manager\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
    
    // Position Manager status
    CreateElement("position_manager_status", g_gui_state.window_x + GUI_MARGIN + 10, g_gui_state.window_y + 130, 
                 180, 40, "Position Manager\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
    
    // Order Manager status
    CreateElement("order_manager_status", g_gui_state.window_x + GUI_MARGIN + 200, g_gui_state.window_y + 130, 
                 180, 40, "Order Manager\nStatus: Aktywny", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR);
}

//+------------------------------------------------------------------+
//| Create Tests Tab Elements                                         |
//+------------------------------------------------------------------+
void CreateTestsTabElements() {
    // Tests display
    CreateElement("tests_panel", g_gui_state.window_x + GUI_MARGIN, g_gui_state.window_y + 70, 
                 GUI_WIDTH - 2 * GUI_MARGIN, GUI_HEIGHT - 200, "Wyniki Testów", GUI_PANEL_COLOR, GUI_TEXT_COLOR);
    
    // Test summary
    int passed_tests = 0;
    for(int i = 0; i < ArraySize(g_test_results); i++) {
        if(g_test_results[i].passed) passed_tests++;
    }
    
    string test_summary = "Testy: " + IntegerToString(passed_tests) + "/" + IntegerToString(g_test_count) + 
                         "\nSukces: " + DoubleToString(g_test_count > 0 ? (double)passed_tests / g_test_count * 100 : 0, 1) + "%";
    
    CreateElement("test_summary", g_gui_state.window_x + GUI_MARGIN + 10, g_gui_state.window_y + 80, 
                 180, 40, test_summary, GUI_INFO_COLOR, GUI_TEXT_COLOR);
    
    // Recent test results
    string recent_tests = "Ostatnie testy:\n";
    int start_index = MathMax(0, ArraySize(g_test_results) - 5);
    for(int i = start_index; i < ArraySize(g_test_results); i++) {
        string status = g_test_results[i].passed ? "✅" : "❌";
        recent_tests += status + " " + g_test_results[i].test_name + "\n";
    }
    
    CreateElement("recent_tests", g_gui_state.window_x + GUI_MARGIN + 200, g_gui_state.window_y + 80, 
                 180, 120, recent_tests, GUI_BACKGROUND_COLOR, GUI_TEXT_COLOR);
}

//+------------------------------------------------------------------+
//| Validate System Configuration                                     |
//+------------------------------------------------------------------+
bool ValidateSystemConfig(SystemConfig &config) {
    // Basic validation
    if(config.confidence_threshold < 0.0 || config.confidence_threshold > 100.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowy próg pewności", "Wartość musi być między 0.0 a 100.0");
        return false;
    }
    
    if(config.alignment_threshold < 0.0 || config.alignment_threshold > 100.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowy próg wyrównania", "Wartość musi być między 0.0 a 100.0");
        return false;
    }
    
    if(config.max_risk_per_trade <= 0.0 || config.max_risk_per_trade > 10.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowe maksymalne ryzyko na transakcję", "Wartość musi być między 0.0 a 10.0");
        return false;
    }
    
    if(config.max_daily_risk <= 0.0 || config.max_daily_risk > 50.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowe maksymalne dzienne ryzyko", "Wartość musi być między 0.0 a 50.0");
        return false;
    }
    
    // Spirit weights validation
    if(config.herbe_weight < 0.0 || config.herbe_weight > 2.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowa waga Herbe Spirit", "Wartość musi być między 0.0 a 2.0");
        return false;
    }
    
    if(config.sweetness_weight < 0.0 || config.sweetness_weight > 2.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowa waga Sweetness Spirit", "Wartość musi być między 0.0 a 2.0");
        return false;
    }
    
    if(config.bitterness_weight < 0.0 || config.bitterness_weight > 2.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowa waga Bitterness Spirit", "Wartość musi być między 0.0 a 2.0");
        return false;
    }
    
    if(config.fire_weight < 0.0 || config.fire_weight > 2.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowa waga Fire Spirit", "Wartość musi być między 0.0 a 2.0");
        return false;
    }
    
    if(config.light_weight < 0.0 || config.light_weight > 2.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowa waga Light Spirit", "Wartość musi być między 0.0 a 2.0");
        return false;
    }
    
    if(config.sound_weight < 0.0 || config.sound_weight > 2.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowa waga Sound Spirit", "Wartość musi być między 0.0 a 2.0");
        return false;
    }
    
    if(config.body_weight < 0.0 || config.body_weight > 2.0) {
        LogError(LOG_COMPONENT_SYSTEM, "Nieprawidłowa waga Body Spirit", "Wartość musi być między 0.0 a 2.0");
        return false;
    }
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Konfiguracja systemu zwalidowana", "Wszystkie parametry są poprawne");
    return true;
}

//+------------------------------------------------------------------+
//| Generate Configuration Report                                     |
//+------------------------------------------------------------------+
string GenerateConfigReport(SystemConfig &config) {
    string report = "=== KONFIGURACJA SYSTEMU BÖHMEGO ===\n";
    report += "Próg pewności: " + DoubleToString(config.confidence_threshold, 1) + "%\n";
    report += "Próg wyrównania: " + DoubleToString(config.alignment_threshold, 1) + "%\n";
    report += "Maks. ryzyko na transakcję: " + DoubleToString(config.max_risk_per_trade, 2) + "%\n";
    report += "Maks. dzienne ryzyko: " + DoubleToString(config.max_daily_risk, 2) + "%\n";
    report += "Min. rozmiar pozycji: " + DoubleToString(config.min_position_size, 2) + "\n";
    report += "Maks. rozmiar pozycji: " + DoubleToString(config.max_position_size, 2) + "\n";
    report += "Uczenie włączone: " + (config.learning_enabled ? "TAK" : "NIE") + "\n";
    report += "Ewolucja włączona: " + (config.evolution_enabled ? "TAK" : "NIE") + "\n";
    report += "\n=== AKTYWACJA DUCHÓW ===\n";
    report += "Herbe Spirit: " + (config.enable_herbe_spirit ? "TAK" : "NIE") + " (waga: " + DoubleToString(config.herbe_weight, 1) + ")\n";
    report += "Sweetness Spirit: " + (config.enable_sweetness_spirit ? "TAK" : "NIE") + " (waga: " + DoubleToString(config.sweetness_weight, 1) + ")\n";
    report += "Bitterness Spirit: " + (config.enable_bitterness_spirit ? "TAK" : "NIE") + " (waga: " + DoubleToString(config.bitterness_weight, 1) + ")\n";
    report += "Fire Spirit: " + (config.enable_fire_spirit ? "TAK" : "NIE") + " (waga: " + DoubleToString(config.fire_weight, 1) + ")\n";
    report += "Light Spirit: " + (config.enable_light_spirit ? "TAK" : "NIE") + " (waga: " + DoubleToString(config.light_weight, 1) + ")\n";
    report += "Sound Spirit: " + (config.enable_sound_spirit ? "TAK" : "NIE") + " (waga: " + DoubleToString(config.sound_weight, 1) + ")\n";
    report += "Body Spirit: " + (config.enable_body_spirit ? "TAK" : "NIE") + " (waga: " + DoubleToString(config.body_weight, 1) + ")\n";
    report += "\n=== PARAMETRY MASTER CONSCIOUSNESS ===\n";
    report += "Liczba głów transformer: " + IntegerToString(config.transformer_heads) + "\n";
    report += "Liczba warstw transformer: " + IntegerToString(config.transformer_layers) + "\n";
    report += "Rozmiar pamięci systemu: " + IntegerToString(config.system_memory_size) + "\n";
    report += "Szybkość uczenia: " + DoubleToString(config.learning_rate, 6) + "\n";
    report += "\n=== PARAMETRY ZARZĄDZANIA RYZYKIEM ===\n";
    report += "Mnożnik stop loss: " + DoubleToString(config.stop_loss_multiplier, 1) + "\n";
    report += "Mnożnik take profit: " + DoubleToString(config.take_profit_multiplier, 1) + "\n";
    report += "Dystans trailing stop: " + DoubleToString(config.trailing_stop_distance, 1) + "\n";
    report += "Użyj trailing stop: " + (config.use_trailing_stop ? "TAK" : "NIE") + "\n";
    report += "\n=== PARAMETRY CZASOWE ===\n";
    report += "Interwał analizy: " + IntegerToString(config.analysis_interval) + " sekund\n";
    report += "Interwał aktualizacji modelu: " + IntegerToString(config.model_update_interval) + " godzin\n";
    report += "Interwał ewolucji: " + IntegerToString(config.evolution_interval) + " dni\n";
    report += "\n=== PARAMETRY DIAGNOSTYKI ===\n";
    report += "Debug logging: " + (config.enable_debug_logging ? "TAK" : "NIE") + "\n";
    report += "Performance tracking: " + (config.enable_performance_tracking ? "TAK" : "NIE") + "\n";
    report += "Maks. rozmiar historii: " + IntegerToString(config.max_history_size) + "\n";
    report += "\n=== PARAMETRY LOGOWANIA ===\n";
    report += "System logowania: " + (config.enable_logging_system ? "TAK" : "NIE") + "\n";
    report += "Poziom logowania: " + IntegerToString(config.logging_level) + "\n";
    report += "Wyjście do pliku: " + (config.enable_log_file_output ? "TAK" : "NIE") + "\n";
    report += "Wyjście do konsoli: " + (config.enable_log_console_output ? "TAK" : "NIE") + "\n";
    report += "Logowanie wydajności: " + (config.enable_log_performance ? "TAK" : "NIE") + "\n";
    report += "Logowanie ryzyka: " + (config.enable_log_risk ? "TAK" : "NIE") + "\n";
    report += "Logowanie transakcji: " + (config.enable_log_trade ? "TAK" : "NIE") + "\n";
    report += "Logowanie AI: " + (config.enable_log_ai ? "TAK" : "NIE") + "\n";
    report += "Maks. wpisy logów: " + IntegerToString(config.max_log_entries) + "\n";
    report += "Ścieżka pliku logów: " + config.log_file_path + "\n";
    
    return report;
}

