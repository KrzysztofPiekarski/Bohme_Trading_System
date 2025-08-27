//+------------------------------------------------------------------+
//| BohmeGUI.mqh - Zaawansowane GUI dla Systemu Böhmego             |
//+------------------------------------------------------------------+
#property copyright "Bohme Trading System"
#property version   "2.00"
#property description "Zaawansowane GUI z monitoringiem czasu rzeczywistego"

// GUI Advanced Features
#define ADVANCED_GUI_WIDTH 800
#define ADVANCED_GUI_HEIGHT 700
#define CHART_PANEL_WIDTH 300
#define CHART_PANEL_HEIGHT 200
#define LOG_PANEL_HEIGHT 150
#define ALERT_PANEL_HEIGHT 100

// Advanced GUI Colors
#define GUI_CHART_COLOR clrDarkBlue
#define GUI_LOG_COLOR clrBlack
#define GUI_ALERT_COLOR clrDarkRed
#define GUI_SUCCESS_LIGHT clrLightGreen
#define GUI_WARNING_LIGHT clrLightYellow
#define GUI_ERROR_LIGHT clrLightCoral

// Basic GUI Colors
#define GUI_BACKGROUND_COLOR clrDarkSlateGray
#define GUI_PANEL_COLOR clrSlateGray
#define GUI_TEXT_COLOR clrWhite
#define GUI_BUTTON_COLOR clrGray
#define GUI_SUCCESS_COLOR clrGreen
#define GUI_ERROR_COLOR clrRed
#define GUI_WARNING_COLOR clrOrange
#define GUI_INFO_COLOR clrCyan

// GUI Layout Constants
#define GUI_MARGIN 10

// Advanced GUI Structures
struct SAdvancedGUIElement {
    string name;
    int x, y, width, height;
    string text;
    color bg_color;
    color text_color;
    bool is_visible;
    bool is_enabled;
    bool is_hovered;
    bool is_clicked;
    int element_type; // 0=panel, 1=button, 2=chart, 3=log, 4=alert
    double value;
    datetime timestamp;
};

struct SSpiritAdvancedStatus {
    string name;
    bool is_active;
    bool is_initialized;
    double performance_score;
    double accuracy_score;
    double speed_score;
    double reliability_score;
    string status_text;
    color status_color;
    datetime last_update;
    int test_results;
    double execution_time;
    double memory_usage;
    int error_count;
    string last_error;
    double profit_loss;
    int trade_count;
    double win_rate;
};

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

// Advanced GUI State
struct SAdvancedGUIState {
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
    bool show_charts;
    bool show_logs;
    bool show_alerts;
    bool show_metrics;
    bool enable_sounds;
    bool enable_notifications;
    int log_level;
    int max_log_entries;
    bool enable_auto_testing;
    int auto_test_interval;
};

// Global Advanced GUI Variables
SAdvancedGUIState g_advanced_gui_state;
SAdvancedGUIElement g_advanced_gui_elements[];
SSpiritAdvancedStatus g_spirit_advanced_status[7];
SSystemMetrics g_system_metrics;

// Global System State Variables
bool g_system_initialized = false;
int g_analysis_counter = 0;

// Logging Constants
#define LOG_COMPONENT_SYSTEM "SYSTEM"

// Performance Charts Data
struct SChartData {
    datetime time[];
    double values[];
    int max_points;
    string name;
    color line_color;
};

SChartData g_performance_charts[7];
SChartData g_system_charts[3];

// Alert System
struct SAlert {
    string message;
    int level; // 0=info, 1=warning, 2=error, 3=critical
    datetime timestamp;
    bool is_read;
    string source;
};

SAlert g_alerts[];
int g_alert_count = 0;

//+------------------------------------------------------------------+
//| Initialize Advanced GUI                                           |
//+------------------------------------------------------------------+
void InitializeAdvancedGUI() {
    Print("🎨 Inicjalizacja zaawansowanego GUI...");
    
    // Initialize advanced GUI state
    g_advanced_gui_state.is_visible = true;
    g_advanced_gui_state.is_minimized = false;
    g_advanced_gui_state.is_dragging = false;
    g_advanced_gui_state.window_x = 50;
    g_advanced_gui_state.window_y = 50;
    g_advanced_gui_state.active_tab = 0;
    g_advanced_gui_state.show_details = true;
    g_advanced_gui_state.auto_refresh = true;
    g_advanced_gui_state.refresh_interval = 2; // seconds
    g_advanced_gui_state.last_refresh = TimeCurrent();
    g_advanced_gui_state.show_charts = true;
    g_advanced_gui_state.show_logs = true;
    g_advanced_gui_state.show_alerts = true;
    g_advanced_gui_state.show_metrics = true;
    g_advanced_gui_state.enable_sounds = true;
    g_advanced_gui_state.enable_notifications = true;
    g_advanced_gui_state.log_level = 2; // INFO
    g_advanced_gui_state.max_log_entries = 1000;
    g_advanced_gui_state.enable_auto_testing = true;
    g_advanced_gui_state.auto_test_interval = 300; // 5 minutes
    
    // Initialize spirit advanced status
    string spirit_names[] = {"Light", "Fire", "Bitterness", "Body", "Herbe", "Sweetness", "Sound"};
    for(int i = 0; i < 7; i++) {
        g_spirit_advanced_status[i].name = spirit_names[i];
        g_spirit_advanced_status[i].is_active = false;
        g_spirit_advanced_status[i].is_initialized = false;
        g_spirit_advanced_status[i].performance_score = 0.0;
        g_spirit_advanced_status[i].accuracy_score = 0.0;
        g_spirit_advanced_status[i].speed_score = 0.0;
        g_spirit_advanced_status[i].reliability_score = 0.0;
        g_spirit_advanced_status[i].status_text = "Nieaktywny";
        g_spirit_advanced_status[i].status_color = GUI_ERROR_COLOR;
        g_spirit_advanced_status[i].last_update = 0;
        g_spirit_advanced_status[i].test_results = 0;
        g_spirit_advanced_status[i].execution_time = 0.0;
        g_spirit_advanced_status[i].memory_usage = 0.0;
        g_spirit_advanced_status[i].error_count = 0;
        g_spirit_advanced_status[i].last_error = "";
        g_spirit_advanced_status[i].profit_loss = 0.0;
        g_spirit_advanced_status[i].trade_count = 0;
        g_spirit_advanced_status[i].win_rate = 0.0;
    }
    
    // Initialize system metrics
    g_system_metrics.cpu_usage = 0.0;
    g_system_metrics.memory_usage = 0.0;
    g_system_metrics.network_usage = 0.0;
    g_system_metrics.active_connections = 0;
    g_system_metrics.response_time = 0.0;
    g_system_metrics.error_rate = 0;
    g_system_metrics.throughput = 0.0;
    g_system_metrics.last_update = TimeCurrent();
    
    // Initialize performance charts
    InitializePerformanceCharts();
    
    // Create advanced GUI elements
    CreateAdvancedGUIElements();
    
    Print("✅ Zaawansowane GUI zainicjalizowane");
}

//+------------------------------------------------------------------+
//| Initialize Performance Charts                                     |
//+------------------------------------------------------------------+
void InitializePerformanceCharts() {
    string spirit_names[] = {"Light", "Fire", "Bitterness", "Body", "Herbe", "Sweetness", "Sound"};
    color chart_colors[] = {clrLightBlue, clrRed, clrOrange, clrGreen, clrPurple, clrPink, clrYellow};
    
    for(int i = 0; i < 7; i++) {
        g_performance_charts[i].name = spirit_names[i] + " Performance";
        g_performance_charts[i].max_points = 100;
        g_performance_charts[i].line_color = chart_colors[i];
        ArrayResize(g_performance_charts[i].time, 0);
        ArrayResize(g_performance_charts[i].values, 0);
    }
    
    // System charts
    string system_chart_names[] = {"CPU Usage", "Memory Usage", "Network Usage"};
    color system_chart_colors[] = {clrCyan, clrMagenta, clrLime};
    
    for(int i = 0; i < 3; i++) {
        g_system_charts[i].name = system_chart_names[i];
        g_system_charts[i].max_points = 100;
        g_system_charts[i].line_color = system_chart_colors[i];
        ArrayResize(g_system_charts[i].time, 0);
        ArrayResize(g_system_charts[i].values, 0);
    }
}

//+------------------------------------------------------------------+
//| Create Advanced GUI Elements                                      |
//+------------------------------------------------------------------+
void CreateAdvancedGUIElements() {
    // Main advanced window
    CreateAdvancedElement("advanced_main_window", g_advanced_gui_state.window_x, g_advanced_gui_state.window_y, 
                         ADVANCED_GUI_WIDTH, ADVANCED_GUI_HEIGHT, "System Böhmego v2.0 - Zaawansowane GUI", 
                         GUI_BACKGROUND_COLOR, GUI_TEXT_COLOR, 0);
    
    // Advanced title bar
    CreateAdvancedElement("advanced_title_bar", g_advanced_gui_state.window_x, g_advanced_gui_state.window_y, 
                         ADVANCED_GUI_WIDTH, 35, "🌙 System Böhmego v2.0 - Zaawansowane AI z Monitoringiem", 
                         GUI_PANEL_COLOR, GUI_TEXT_COLOR, 0);
    
    // Advanced control buttons
    CreateAdvancedElement("btn_advanced_minimize", g_advanced_gui_state.window_x + ADVANCED_GUI_WIDTH - 80, g_advanced_gui_state.window_y + 5, 
                         25, 25, "−", GUI_BUTTON_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("btn_advanced_close", g_advanced_gui_state.window_x + ADVANCED_GUI_WIDTH - 50, g_advanced_gui_state.window_y + 5, 
                         25, 25, "×", GUI_ERROR_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("btn_advanced_settings", g_advanced_gui_state.window_x + ADVANCED_GUI_WIDTH - 110, g_advanced_gui_state.window_y + 5, 
                         25, 25, "⚙", GUI_INFO_COLOR, GUI_TEXT_COLOR, 1);
    
    // Advanced tab buttons
    CreateAdvancedElement("tab_advanced_spirits", g_advanced_gui_state.window_x + GUI_MARGIN, g_advanced_gui_state.window_y + 40, 
                         100, 30, "Duchy", GUI_BUTTON_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("tab_advanced_data", g_advanced_gui_state.window_x + GUI_MARGIN + 105, g_advanced_gui_state.window_y + 40, 
                         100, 30, "Dane", GUI_BUTTON_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("tab_advanced_execution", g_advanced_gui_state.window_x + GUI_MARGIN + 210, g_advanced_gui_state.window_y + 40, 
                         100, 30, "Wykonanie", GUI_BUTTON_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("tab_advanced_tests", g_advanced_gui_state.window_x + GUI_MARGIN + 315, g_advanced_gui_state.window_y + 40, 
                         100, 30, "Testy", GUI_BUTTON_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("tab_advanced_monitoring", g_advanced_gui_state.window_x + GUI_MARGIN + 420, g_advanced_gui_state.window_y + 40, 
                         100, 30, "Monitoring", GUI_BUTTON_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("tab_advanced_alerts", g_advanced_gui_state.window_x + GUI_MARGIN + 525, g_advanced_gui_state.window_y + 40, 
                         100, 30, "Alerty", GUI_BUTTON_COLOR, GUI_TEXT_COLOR, 1);
    
    // Advanced spirit panels with detailed information
    int spirit_y = g_advanced_gui_state.window_y + 80;
    for(int i = 0; i < 7; i++) {
        string spirit_name = g_spirit_advanced_status[i].name;
        CreateAdvancedElement("advanced_spirit_" + spirit_name, g_advanced_gui_state.window_x + GUI_MARGIN, spirit_y + i * 120, 
                             ADVANCED_GUI_WIDTH - 2 * GUI_MARGIN, 115, spirit_name + " Spirit - Zaawansowane", 
                             GUI_PANEL_COLOR, GUI_TEXT_COLOR, 0);
        
        // Advanced spirit control buttons
        CreateAdvancedElement("btn_advanced_" + spirit_name + "_toggle", g_advanced_gui_state.window_x + ADVANCED_GUI_WIDTH - 100, spirit_y + i * 120 + 5, 
                             90, 25, "Włącz", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR, 1);
        CreateAdvancedElement("btn_advanced_" + spirit_name + "_test", g_advanced_gui_state.window_x + ADVANCED_GUI_WIDTH - 100, spirit_y + i * 120 + 35, 
                             90, 25, "Test", GUI_INFO_COLOR, GUI_TEXT_COLOR, 1);
        CreateAdvancedElement("btn_advanced_" + spirit_name + "_config", g_advanced_gui_state.window_x + ADVANCED_GUI_WIDTH - 100, spirit_y + i * 120 + 65, 
                             90, 25, "Konfiguracja", GUI_WARNING_COLOR, GUI_TEXT_COLOR, 1);
    }
    
    // Advanced control panel
    CreateAdvancedElement("advanced_control_panel", g_advanced_gui_state.window_x + GUI_MARGIN, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 180, 
                         ADVANCED_GUI_WIDTH - 2 * GUI_MARGIN, 175, "Zaawansowany Panel Kontrolny", 
                         GUI_PANEL_COLOR, GUI_TEXT_COLOR, 0);
    
    // Advanced control buttons
    CreateAdvancedElement("btn_advanced_start_all", g_advanced_gui_state.window_x + GUI_MARGIN, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 170, 
                         100, 30, "Start Wszystkie", GUI_SUCCESS_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("btn_advanced_stop_all", g_advanced_gui_state.window_x + GUI_MARGIN + 105, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 170, 
                         100, 30, "Stop Wszystkie", GUI_ERROR_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("btn_advanced_test_all", g_advanced_gui_state.window_x + GUI_MARGIN + 210, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 170, 
                         100, 30, "Test Wszystkie", GUI_INFO_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("btn_advanced_report", g_advanced_gui_state.window_x + GUI_MARGIN + 315, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 170, 
                         100, 30, "Raport", GUI_WARNING_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("btn_advanced_optimize", g_advanced_gui_state.window_x + GUI_MARGIN + 420, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 170, 
                         100, 30, "Optymalizuj", GUI_INFO_COLOR, GUI_TEXT_COLOR, 1);
    CreateAdvancedElement("btn_advanced_backup", g_advanced_gui_state.window_x + GUI_MARGIN + 525, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 170, 
                         100, 30, "Backup", GUI_WARNING_COLOR, GUI_TEXT_COLOR, 1);
    
    // Advanced status indicators
    CreateAdvancedElement("advanced_status_system", g_advanced_gui_state.window_x + GUI_MARGIN, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 130, 
                         150, 25, "System: Inicjalizacja", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_status_analysis", g_advanced_gui_state.window_x + GUI_MARGIN + 155, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 130, 
                         150, 25, "Analizy: 0", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_status_performance", g_advanced_gui_state.window_x + GUI_MARGIN + 310, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 130, 
                         150, 25, "Wydajność: 0%", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_status_cpu", g_advanced_gui_state.window_x + GUI_MARGIN + 465, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 130, 
                         150, 25, "CPU: 0%", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    
    // Advanced metrics
    CreateAdvancedElement("advanced_metrics_panel", g_advanced_gui_state.window_x + GUI_MARGIN, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 95, 
                         ADVANCED_GUI_WIDTH - 2 * GUI_MARGIN, 90, "Metryki Systemu", 
                         GUI_PANEL_COLOR, GUI_TEXT_COLOR, 0);
    
    // Performance indicators
    CreateAdvancedElement("advanced_perf_memory", g_advanced_gui_state.window_x + GUI_MARGIN + 10, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 85, 
                         120, 20, "Pamięć: 0 MB", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_perf_network", g_advanced_gui_state.window_x + GUI_MARGIN + 140, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 85, 
                         120, 20, "Sieć: 0 KB/s", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_perf_response", g_advanced_gui_state.window_x + GUI_MARGIN + 270, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 85, 
                         120, 20, "Odpowiedź: 0ms", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_perf_errors", g_advanced_gui_state.window_x + GUI_MARGIN + 400, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 85, 
                         120, 20, "Błędy: 0", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_perf_throughput", g_advanced_gui_state.window_x + GUI_MARGIN + 530, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 85, 
                         120, 20, "Przepustowość: 0", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    
    // Trade metrics
    CreateAdvancedElement("advanced_trade_pnl", g_advanced_gui_state.window_x + GUI_MARGIN + 10, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 60, 
                         120, 20, "P&L: $0.00", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_trade_count", g_advanced_gui_state.window_x + GUI_MARGIN + 140, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 60, 
                         120, 20, "Trades: 0", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_trade_winrate", g_advanced_gui_state.window_x + GUI_MARGIN + 270, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 60, 
                         120, 20, "Win Rate: 0%", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_trade_drawdown", g_advanced_gui_state.window_x + GUI_MARGIN + 400, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 60, 
                         120, 20, "Drawdown: 0%", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
    CreateAdvancedElement("advanced_trade_sharpe", g_advanced_gui_state.window_x + GUI_MARGIN + 530, g_advanced_gui_state.window_y + ADVANCED_GUI_HEIGHT - 60, 
                         120, 20, "Sharpe: 0.00", GUI_INFO_COLOR, GUI_TEXT_COLOR, 0);
}

//+------------------------------------------------------------------+
//| Create Advanced Element                                           |
//+------------------------------------------------------------------+
void CreateAdvancedElement(string name, int x, int y, int width, int height, string text, color bg_color, color text_color, int element_type) {
    SAdvancedGUIElement element;
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
    element.element_type = element_type;
    element.value = 0.0;
    element.timestamp = TimeCurrent();
    
    int size = ArraySize(g_advanced_gui_elements);
    ArrayResize(g_advanced_gui_elements, size + 1);
    g_advanced_gui_elements[size] = element;
    
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
//| Update Advanced GUI                                               |
//+------------------------------------------------------------------+
void UpdateAdvancedGUI() {
    if(!g_advanced_gui_state.is_visible) return;
    
    datetime current_time = TimeCurrent();
    
    // Auto refresh
    if(g_advanced_gui_state.auto_refresh && current_time - g_advanced_gui_state.last_refresh >= g_advanced_gui_state.refresh_interval) {
        g_advanced_gui_state.last_refresh = current_time;
        RefreshAdvancedGUI();
    }
    
    // Update advanced spirit status
    UpdateAdvancedSpiritStatus();
    
    // Update system metrics
    UpdateSystemMetrics();
    
    // Update performance charts
    UpdatePerformanceCharts();
    
    // Update advanced status indicators
    UpdateAdvancedStatusIndicators();
    
    // Check for alerts
    CheckForAlerts();
    
    // Auto testing
    if(g_advanced_gui_state.enable_auto_testing && 
       current_time - g_advanced_gui_state.last_refresh >= g_advanced_gui_state.auto_test_interval) {
        RunAutoTests();
    }
}

//+------------------------------------------------------------------+
//| Update Advanced Spirit Status                                     |
//+------------------------------------------------------------------+
void UpdateAdvancedSpiritStatus() {
    // Update each spirit with advanced metrics
    for(int i = 0; i < 7; i++) {
        SSpiritAdvancedStatus status = g_spirit_advanced_status[i];
        
        // Simulate advanced metrics
        if(status.is_active) {
            status.performance_score = 85.0 + (MathRand() % 150) / 10.0;
            status.accuracy_score = 80.0 + (MathRand() % 200) / 10.0;
            status.speed_score = 90.0 + (MathRand() % 100) / 10.0;
            status.reliability_score = 95.0 + (MathRand() % 50) / 10.0;
            status.memory_usage = 10.0 + (MathRand() % 50) / 10.0;
            status.profit_loss = (MathRand() % 2000 - 1000) / 10.0;
            status.trade_count = MathRand() % 100;
            status.win_rate = 60.0 + (MathRand() % 400) / 10.0;
            
            // Simulate occasional errors
            if(MathRand() % 100 < 5) { // 5% chance of error
                status.error_count++;
                status.last_error = "Simulated error " + IntegerToString(status.error_count);
                AddAlert("Błąd " + status.name + " Spirit: " + status.last_error, 1, status.name);
            }
        }
        
        status.last_update = TimeCurrent();
        
        // Apply changes back to the original array
        g_spirit_advanced_status[i] = status;
        
        // Update GUI element with detailed information
        string spirit_name = status.name;
        string element_name = "advanced_spirit_" + spirit_name;
        string display_text = spirit_name + " Spirit\n" +
                             "Status: " + status.status_text + "\n" +
                             "Wydajność: " + DoubleToString(status.performance_score, 1) + "% | " +
                             "Dokładność: " + DoubleToString(status.accuracy_score, 1) + "%\n" +
                             "P&L: $" + DoubleToString(status.profit_loss, 2) + " | " +
                             "Trades: " + IntegerToString(status.trade_count) + " | " +
                             "Win Rate: " + DoubleToString(status.win_rate, 1) + "%";
        
        UpdateAdvancedElementText(element_name, display_text, status.status_color);
    }
}

//+------------------------------------------------------------------+
//| Update System Metrics                                             |
//+------------------------------------------------------------------+
void UpdateSystemMetrics() {
    // Simulate system metrics
    g_system_metrics.cpu_usage = 20.0 + (MathRand() % 600) / 10.0;
    g_system_metrics.memory_usage = 50.0 + (MathRand() % 500) / 10.0;
    g_system_metrics.network_usage = 10.0 + (MathRand() % 200) / 10.0;
    g_system_metrics.active_connections = MathRand() % 10;
    g_system_metrics.response_time = 5.0 + (MathRand() % 500) / 10.0;
    g_system_metrics.error_rate = MathRand() % 5;
    g_system_metrics.throughput = 100.0 + (MathRand() % 900) / 10.0;
    g_system_metrics.last_update = TimeCurrent();
    
    // Add to charts
    AddToSystemChart(0, g_system_metrics.cpu_usage);
    AddToSystemChart(1, g_system_metrics.memory_usage);
    AddToSystemChart(2, g_system_metrics.network_usage);
}

//+------------------------------------------------------------------+
//| Update Performance Charts                                         |
//+------------------------------------------------------------------+
void UpdatePerformanceCharts() {
    if(!g_advanced_gui_state.show_charts) return;
    
    // Update spirit performance charts
    for(int i = 0; i < 7; i++) {
        if(g_spirit_advanced_status[i].is_active) {
            AddToPerformanceChart(i, g_spirit_advanced_status[i].performance_score);
        }
    }
}

//+------------------------------------------------------------------+
//| Add To Performance Chart                                          |
//+------------------------------------------------------------------+
void AddToPerformanceChart(int chart_index, double value) {
    if(chart_index < 0 || chart_index >= 7) return;
    
    SChartData chart = g_performance_charts[chart_index];
    
    int size = ArraySize(chart.time);
    ArrayResize(chart.time, size + 1);
    ArrayResize(chart.values, size + 1);
    
    chart.time[size] = TimeCurrent();
    chart.values[size] = value;
    
    // Keep only max_points
    if(size >= chart.max_points) {
        for(int i = 0; i < size - 1; i++) {
            chart.time[i] = chart.time[i + 1];
            chart.values[i] = chart.values[i + 1];
        }
        ArrayResize(chart.time, chart.max_points - 1);
        ArrayResize(chart.values, chart.max_points - 1);
    }
    
    // Apply changes back to the original array
    g_performance_charts[chart_index] = chart;
}

//+------------------------------------------------------------------+
//| Add To System Chart                                               |
//+------------------------------------------------------------------+
void AddToSystemChart(int chart_index, double value) {
    if(chart_index < 0 || chart_index >= 3) return;
    
    SChartData chart = g_system_charts[chart_index];
    
    int size = ArraySize(chart.time);
    ArrayResize(chart.time, size + 1);
    ArrayResize(chart.values, size + 1);
    
    chart.time[size] = TimeCurrent();
    chart.values[size] = value;
    
    // Keep only max_points
    if(size >= chart.max_points) {
        for(int i = 0; i < size - 1; i++) {
            chart.time[i] = chart.time[i + 1];
            chart.values[i] = chart.values[i + 1];
        }
        ArrayResize(chart.time, chart.max_points - 1);
        ArrayResize(chart.values, chart.max_points - 1);
    }
    
    // Apply changes back to the original array
    g_system_charts[chart_index] = chart;
}

//+------------------------------------------------------------------+
//| Update Advanced Status Indicators                                 |
//+------------------------------------------------------------------+
void UpdateAdvancedStatusIndicators() {
    // System status
    string system_status = g_system_initialized ? "System: Aktywny" : "System: Nieaktywny";
    color system_color = g_system_initialized ? GUI_SUCCESS_COLOR : GUI_ERROR_COLOR;
    UpdateAdvancedElementText("advanced_status_system", system_status, system_color);
    
    // Analysis count
    string analysis_status = "Analizy: " + IntegerToString(g_analysis_counter);
    UpdateAdvancedElementText("advanced_status_analysis", analysis_status, GUI_INFO_COLOR);
    
    // Performance
    double overall_performance = CalculateAdvancedOverallPerformance();
    string performance_status = "Wydajność: " + DoubleToString(overall_performance, 1) + "%";
    color performance_color = overall_performance >= 80 ? GUI_SUCCESS_COLOR : 
                             overall_performance >= 60 ? GUI_WARNING_COLOR : GUI_ERROR_COLOR;
    UpdateAdvancedElementText("advanced_status_performance", performance_status, performance_color);
    
    // CPU usage
    string cpu_status = "CPU: " + DoubleToString(g_system_metrics.cpu_usage, 1) + "%";
    color cpu_color = g_system_metrics.cpu_usage < 50 ? GUI_SUCCESS_COLOR : 
                     g_system_metrics.cpu_usage < 80 ? GUI_WARNING_COLOR : GUI_ERROR_COLOR;
    UpdateAdvancedElementText("advanced_status_cpu", cpu_status, cpu_color);
    
    // Metrics
    UpdateAdvancedElementText("advanced_perf_memory", "Pamięć: " + DoubleToString(g_system_metrics.memory_usage, 1) + " MB", GUI_INFO_COLOR);
    UpdateAdvancedElementText("advanced_perf_network", "Sieć: " + DoubleToString(g_system_metrics.network_usage, 1) + " KB/s", GUI_INFO_COLOR);
    UpdateAdvancedElementText("advanced_perf_response", "Odpowiedź: " + DoubleToString(g_system_metrics.response_time, 1) + "ms", GUI_INFO_COLOR);
    UpdateAdvancedElementText("advanced_perf_errors", "Błędy: " + IntegerToString(g_system_metrics.error_rate), GUI_INFO_COLOR);
    UpdateAdvancedElementText("advanced_perf_throughput", "Przepustowość: " + DoubleToString(g_system_metrics.throughput, 1), GUI_INFO_COLOR);
    
    // Trade metrics
    double total_pnl = CalculateTotalPnL();
    int total_trades = CalculateTotalTrades();
    double total_winrate = CalculateTotalWinRate();
    double max_drawdown = CalculateMaxDrawdown();
    double sharpe_ratio = CalculateSharpeRatio();
    
    UpdateAdvancedElementText("advanced_trade_pnl", "P&L: $" + DoubleToString(total_pnl, 2), 
                             total_pnl >= 0 ? GUI_SUCCESS_COLOR : GUI_ERROR_COLOR);
    UpdateAdvancedElementText("advanced_trade_count", "Trades: " + IntegerToString(total_trades), GUI_INFO_COLOR);
    UpdateAdvancedElementText("advanced_trade_winrate", "Win Rate: " + DoubleToString(total_winrate, 1) + "%", GUI_INFO_COLOR);
    UpdateAdvancedElementText("advanced_trade_drawdown", "Drawdown: " + DoubleToString(max_drawdown, 1) + "%", GUI_INFO_COLOR);
    UpdateAdvancedElementText("advanced_trade_sharpe", "Sharpe: " + DoubleToString(sharpe_ratio, 2), GUI_INFO_COLOR);
}

//+------------------------------------------------------------------+
//| Calculate Advanced Overall Performance                            |
//+------------------------------------------------------------------+
double CalculateAdvancedOverallPerformance() {
    double total_performance = 0.0;
    int active_spirits = 0;
    
    for(int i = 0; i < 7; i++) {
        if(g_spirit_advanced_status[i].is_active) {
            total_performance += g_spirit_advanced_status[i].performance_score;
            active_spirits++;
        }
    }
    
    return active_spirits > 0 ? total_performance / active_spirits : 0.0;
}

//+------------------------------------------------------------------+
//| Calculate Total PnL                                               |
//+------------------------------------------------------------------+
double CalculateTotalPnL() {
    double total_pnl = 0.0;
    for(int i = 0; i < 7; i++) {
        total_pnl += g_spirit_advanced_status[i].profit_loss;
    }
    return total_pnl;
}

//+------------------------------------------------------------------+
//| Calculate Total Trades                                            |
//+------------------------------------------------------------------+
int CalculateTotalTrades() {
    int total_trades = 0;
    for(int i = 0; i < 7; i++) {
        total_trades += g_spirit_advanced_status[i].trade_count;
    }
    return total_trades;
}

//+------------------------------------------------------------------+
//| Calculate Total Win Rate                                          |
//+------------------------------------------------------------------+
double CalculateTotalWinRate() {
    double total_winrate = 0.0;
    int active_spirits = 0;
    
    for(int i = 0; i < 7; i++) {
        if(g_spirit_advanced_status[i].is_active) {
            total_winrate += g_spirit_advanced_status[i].win_rate;
            active_spirits++;
        }
    }
    
    return active_spirits > 0 ? total_winrate / active_spirits : 0.0;
}

//+------------------------------------------------------------------+
//| Calculate Max Drawdown                                            |
//+------------------------------------------------------------------+
double CalculateMaxDrawdown() {
    // Simulate drawdown calculation
    return 5.0 + (MathRand() % 200) / 10.0;
}

//+------------------------------------------------------------------+
//| Calculate Sharpe Ratio                                            |
//+------------------------------------------------------------------+
double CalculateSharpeRatio() {
    // Simulate Sharpe ratio calculation
    return 1.0 + (MathRand() % 200) / 100.0;
}

//+------------------------------------------------------------------+
//| Add Alert                                                         |
//+------------------------------------------------------------------+
void AddAlert(string message, int level, string source) {
    SAlert alert;
    alert.message = message;
    alert.level = level;
    alert.timestamp = TimeCurrent();
    alert.is_read = false;
    alert.source = source;
    
    int size = ArraySize(g_alerts);
    ArrayResize(g_alerts, size + 1);
    g_alerts[size] = alert;
    
    g_alert_count++;
    
    // Show notification if enabled
    if(g_advanced_gui_state.enable_notifications) {
        ShowNotification(message, level);
    }
}

//+------------------------------------------------------------------+
//| Show Notification                                                 |
//+------------------------------------------------------------------+
void ShowNotification(string message, int level) {
    string level_text = "";
    color level_color = GUI_INFO_COLOR;
    
    switch(level) {
        case 0: level_text = "INFO"; level_color = GUI_INFO_COLOR; break;
        case 1: level_text = "WARNING"; level_color = GUI_WARNING_COLOR; break;
        case 2: level_text = "ERROR"; level_color = GUI_ERROR_COLOR; break;
        case 3: level_text = "CRITICAL"; level_color = GUI_ERROR_COLOR; break;
    }
    
    // Create notification popup
    string notification_name = "notification_" + IntegerToString(TimeCurrent());
    CreateAdvancedElement(notification_name, 50, 50, 400, 100, 
                         level_text + "\n" + message, level_color, GUI_TEXT_COLOR, 4);
    
    // Auto-remove after 5 seconds
    EventSetTimer(5);
}

//+------------------------------------------------------------------+
//| Check For Alerts                                                  |
//+------------------------------------------------------------------+
void CheckForAlerts() {
    // Check system metrics for alerts
    if(g_system_metrics.cpu_usage > 90) {
        AddAlert("Wysokie użycie CPU: " + DoubleToString(g_system_metrics.cpu_usage, 1) + "%", 1, "System");
    }
    
    if(g_system_metrics.memory_usage > 90) {
        AddAlert("Wysokie użycie pamięci: " + DoubleToString(g_system_metrics.memory_usage, 1) + "%", 1, "System");
    }
    
    if(g_system_metrics.error_rate > 3) {
        AddAlert("Wysoka liczba błędów: " + IntegerToString(g_system_metrics.error_rate), 2, "System");
    }
    
    // Check spirit performance for alerts
    for(int i = 0; i < 7; i++) {
        if(g_spirit_advanced_status[i].is_active) {
            if(g_spirit_advanced_status[i].performance_score < 50) {
                AddAlert("Niska wydajność " + g_spirit_advanced_status[i].name + " Spirit: " + 
                        DoubleToString(g_spirit_advanced_status[i].performance_score, 1) + "%", 1, 
                        g_spirit_advanced_status[i].name);
            }
            
            if(g_spirit_advanced_status[i].error_count > 5) {
                AddAlert("Wiele błędów " + g_spirit_advanced_status[i].name + " Spirit: " + 
                        IntegerToString(g_spirit_advanced_status[i].error_count), 2, 
                        g_spirit_advanced_status[i].name);
            }
        }
    }
}

//+------------------------------------------------------------------+
//| Run Auto Tests                                                    |
//+------------------------------------------------------------------+
void RunAutoTests() {
    Print("🤖 Uruchamianie automatycznych testów...");
    
    // Run tests for active spirits
    for(int i = 0; i < 7; i++) {
        if(g_spirit_advanced_status[i].is_active) {
            TestSpirit(g_spirit_advanced_status[i].name);
        }
    }
    
    // Run system tests
    TestSystemComponents();
    
    LogInfo(LOG_COMPONENT_SYSTEM, "Automatyczne testy zakończone", "Testy wykonane automatycznie");
}

//+------------------------------------------------------------------+
//| Test System Components                                            |
//+------------------------------------------------------------------+
void TestSystemComponents() {
    // Test data components
    TestDataComponents();
    
    // Test execution components
    TestExecutionComponents();
    
    // Test utils components
    TestUtilsComponents();
}

//+------------------------------------------------------------------+
//| Update Advanced Element Text                                      |
//+------------------------------------------------------------------+
void UpdateAdvancedElementText(string element_name, string text, color text_color) {
    ObjectSetString(0, element_name, OBJPROP_TEXT, text);
    ObjectSetInteger(0, element_name, OBJPROP_COLOR, text_color);
}

//+------------------------------------------------------------------+
//| Refresh Advanced GUI                                              |
//+------------------------------------------------------------------+
void RefreshAdvancedGUI() {
    // Update all advanced GUI elements
    for(int i = 0; i < ArraySize(g_advanced_gui_elements); i++) {
        UpdateAdvancedElement(g_advanced_gui_elements[i]);
    }
    
    // Redraw chart
    ChartRedraw();
}

//+------------------------------------------------------------------+
//| Update Advanced Element                                           |
//+------------------------------------------------------------------+
void UpdateAdvancedElement(SAdvancedGUIElement& element) {
    if(!element.is_visible) return;
    
    // Update chart object
    ObjectSetString(0, element.name, OBJPROP_TEXT, element.text);
    ObjectSetInteger(0, element.name, OBJPROP_BGCOLOR, element.bg_color);
    ObjectSetInteger(0, element.name, OBJPROP_COLOR, element.text_color);
}

//+------------------------------------------------------------------+
//| Cleanup Advanced GUI                                              |
//+------------------------------------------------------------------+
void CleanupAdvancedGUI() {
    Print("🧹 Czyszczenie zaawansowanego GUI...");
    
    // Remove all chart objects
    for(int i = 0; i < ArraySize(g_advanced_gui_elements); i++) {
        ObjectDelete(0, g_advanced_gui_elements[i].name);
    }
    
    // Clear arrays
    ArrayResize(g_advanced_gui_elements, 0);
    ArrayResize(g_alerts, 0);
    
    // Clear charts
    for(int i = 0; i < 7; i++) {
        ArrayResize(g_performance_charts[i].time, 0);
        ArrayResize(g_performance_charts[i].values, 0);
    }
    
    for(int i = 0; i < 3; i++) {
        ArrayResize(g_system_charts[i].time, 0);
        ArrayResize(g_system_charts[i].values, 0);
    }
    
    Print("✅ Zaawansowane GUI wyczyszczone");
}

//+------------------------------------------------------------------+
//| Test Spirit Function (Stub)                                      |
//+------------------------------------------------------------------+
void TestSpirit(string spirit_name) {
    Print("🧪 Testowanie " + spirit_name + " Spirit...");
    // Placeholder for spirit testing logic
}

//+------------------------------------------------------------------+
//| Test Data Components (Stub)                                      |
//+------------------------------------------------------------------+
void TestDataComponents() {
    Print("🔍 Testowanie komponentów danych...");
    // Placeholder for data components testing
}

//+------------------------------------------------------------------+
//| Test Execution Components (Stub)                                 |
//+------------------------------------------------------------------+
void TestExecutionComponents() {
    Print("⚡ Testowanie komponentów wykonania...");
    // Placeholder for execution components testing
}

//+------------------------------------------------------------------+
//| Test Utils Components (Stub)                                     |
//+------------------------------------------------------------------+
void TestUtilsComponents() {
    Print("🛠️ Testowanie komponentów narzędziowych...");
    // Placeholder for utils components testing
}

//+------------------------------------------------------------------+
//| Log Info Function (Stub)                                         |
//+------------------------------------------------------------------+
void LogInfo(string component, string message, string details) {
    Print("📝 [" + component + "] " + message + " - " + details);
    // Placeholder for logging functionality
} 