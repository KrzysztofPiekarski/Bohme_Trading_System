#!/bin/bash

# ========================================
# SKRYPT KOMPILACJI SYSTEMU BÖHMEGO W MT5
# ========================================

# Kolory dla lepszej czytelności
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Konfiguracja ścieżek
MT5_BASE_PATH="/home/krispi/.wine/drive_c/Program Files/Orbex Global MT5"
MT5_EXE="$MT5_BASE_PATH/terminal64.exe"
PROJECT_NAME="Bohme_Trading_System"
MAIN_FILE="Core/BohmeMainSystem.mq5"

# Funkcja do wyświetlania nagłówków
print_header() {
    echo -e "${BLUE}========================================${NC}"
    echo -e "${BLUE}$1${NC}"
    echo -e "${BLUE}========================================${NC}"
}

# Funkcja do wyświetlania statusu
print_status() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

# Funkcja sprawdzająca czy plik istnieje
check_file() {
    if [ ! -f "$1" ]; then
        print_error "Plik nie istnieje: $1"
        return 1
    fi
    return 0
}

# Funkcja sprawdzająca czy MT5 jest uruchomiony
check_mt5_running() {
    if pgrep -f "terminal64.exe" > /dev/null; then
        return 0
    else
        return 1
    fi
}

# Funkcja uruchamiająca MT5
start_mt5() {
    print_header "URUCHAMIANIE META TRADER 5"
    
    if check_mt5_running; then
        print_status "MT5 jest już uruchomiony"
        return 0
    fi
    
    if [ -f "$MT5_EXE" ]; then
        print_status "Uruchamiam MT5..."
        wine "$MT5_EXE" &
        sleep 10  # Czekaj na uruchomienie
        print_status "MT5 został uruchomiony"
    else
        print_error "Nie znaleziono MT5: $MT5_EXE"
        return 1
    fi
}

# Funkcja kompilacji przez MT5
compile_in_mt5() {
    print_header "KOMPILACJA W META TRADER 5"
    
    local mq5_file="$MT5_BASE_PATH/MQL5/Experts/$PROJECT_NAME/$MAIN_FILE"
    
    if ! check_file "$mq5_file"; then
        print_error "Nie znaleziono pliku do kompilacji: $mq5_file"
        print_error "Uruchom najpierw: ./deploy_to_mt5.sh"
        return 1
    fi
    
    print_status "Znaleziono plik: $mq5_file"
    
    # Sprawdź czy MT5 jest uruchomiony
    if ! check_mt5_running; then
        print_warning "MT5 nie jest uruchomiony. Uruchamiam..."
        start_mt5
    fi
    
    print_status "Przygotowuję kompilację..."
    
    # Otwórz MetaEditor przez MT5
    print_status "Otwieram MetaEditor..."
    
    # Użyj xdotool do automatyzacji (jeśli dostępne)
    if command -v xdotool >/dev/null 2>&1; then
        # Znajdź okno MT5
        local mt5_window=$(xdotool search --name "Orbex" 2>/dev/null)
        
        if [ -n "$mt5_window" ]; then
            # Aktywuj okno MT5
            xdotool windowactivate "$mt5_window"
            sleep 1
            
            # Otwórz MetaEditor (F4)
            xdotool key F4
            sleep 3
            
            # Otwórz plik (Ctrl+O)
            xdotool key ctrl+o
            sleep 2
            
            # Wpisz ścieżkę do pliku
            local file_path="$PROJECT_NAME/$MAIN_FILE"
            xdotool type "$file_path"
            sleep 1
            xdotool key Return
            sleep 2
            
            # Skompiluj (F7)
            xdotool key F7
            sleep 5
            
            print_status "Kompilacja została zainicjowana"
        else
            print_warning "Nie można znaleźć okna MT5. Kompilacja ręczna wymagana."
        fi
    else
        print_warning "xdotool nie jest zainstalowany. Kompilacja ręczna wymagana."
    fi
    
    print_status "Instrukcje kompilacji ręcznej:"
    echo "1. W MT5 naciśnij F4 (MetaEditor)"
    echo "2. Otwórz plik: $PROJECT_NAME/$MAIN_FILE"
    echo "3. Naciśnij F7 (Compile)"
    echo "4. Sprawdź logi kompilacji"
}

# Funkcja sprawdzająca logi kompilacji
check_compilation_logs() {
    print_header "SPRAWDZANIE LOGÓW KOMPILACJI"
    
    local log_dir="$MT5_BASE_PATH/MQL5/Logs"
    local latest_log=$(find "$log_dir" -name "*.log" -type f -printf '%T@ %p\n' 2>/dev/null | sort -n | tail -1 | cut -d' ' -f2-)
    
    if [ -n "$latest_log" ] && [ -f "$latest_log" ]; then
        print_status "Znaleziono log: $latest_log"
        echo ""
        echo -e "${BLUE}Ostatnie wpisy z logu:${NC}"
        tail -20 "$latest_log" | grep -E "(error|warning|compilation)" || echo "Brak błędów w logu"
    else
        print_warning "Nie znaleziono logów kompilacji"
    fi
}

# Funkcja sprawdzająca czy plik .ex5 został utworzony
check_compiled_file() {
    print_header "SPRAWDZANIE SKOMPILOWANEGO PLIKU"
    
    local ex5_file="$MT5_BASE_PATH/MQL5/Experts/$PROJECT_NAME/Core/BohmeMainSystem.ex5"
    
    if [ -f "$ex5_file" ]; then
        print_status "Plik .ex5 został utworzony: $ex5_file"
        ls -la "$ex5_file"
    else
        print_warning "Plik .ex5 nie został utworzony"
        print_warning "Sprawdź błędy kompilacji w MetaEditor"
    fi
}

# Funkcja wyświetlająca pomoc
show_help() {
    echo -e "${BLUE}SKRYPT KOMPILACJI SYSTEMU BÖHMEGO${NC}"
    echo ""
    echo "Użycie: $0 [OPCJE]"
    echo ""
    echo "Opcje:"
    echo "  --compile    Skompiluj system w MT5 (domyślne)"
    echo "  --start      Uruchom MT5"
    echo "  --logs       Sprawdź logi kompilacji"
    echo "  --check      Sprawdź skompilowany plik"
    echo "  --help       Wyświetl tę pomoc"
    echo ""
    echo "Przykłady:"
    echo "  $0              # Skompiluj system"
    echo "  $0 --compile    # Skompiluj system"
    echo "  $0 --start      # Uruchom MT5"
    echo "  $0 --logs       # Sprawdź logi"
    echo ""
}

# Główna logika skryptu
main() {
    case "${1:---compile}" in
        --compile)
            compile_in_mt5
            sleep 2
            check_compiled_file
            ;;
        --start)
            start_mt5
            ;;
        --logs)
            check_compilation_logs
            ;;
        --check)
            check_compiled_file
            ;;
        --help|-h)
            show_help
            ;;
        *)
            echo -e "${RED}Nieznana opcja: $1${NC}"
            show_help
            exit 1
            ;;
    esac
}

# Uruchom główną funkcję
main "$@" 