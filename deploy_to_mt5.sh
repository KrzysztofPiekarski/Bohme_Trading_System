#!/bin/bash

# ========================================
# SKRYPT DEPLOYMENTU SYSTEMU BÖHMEGO DO MT5
# ========================================

# Kolory dla lepszej czytelności
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Konfiguracja ścieżek
MT5_BASE_PATH="/home/krispi/.wine/drive_c/Program Files/Orbex Global MT5"
MT5_MQL5_PATH="$MT5_BASE_PATH/MQL5"
MT5_EXPERTS_PATH="$MT5_MQL5_PATH/Experts"
MT5_INCLUDE_PATH="$MT5_MQL5_PATH/Include"
MT5_LIBRARIES_PATH="$MT5_MQL5_PATH/Libraries"

# Ścieżka do projektu
PROJECT_PATH="$(pwd)"
PROJECT_NAME="Bohme_Trading_System"

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

# Funkcja sprawdzająca czy katalog istnieje
check_directory() {
    if [ ! -d "$1" ]; then
        print_error "Katalog nie istnieje: $1"
        return 1
    fi
    return 0
}

# Funkcja tworząca katalog jeśli nie istnieje
create_directory() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
        print_status "Utworzono katalog: $1"
    fi
}

# Funkcja kopiująca pliki z backupem
copy_with_backup() {
    local source="$1"
    local destination="$2"
    local backup_dir="$3"
    
    if [ -e "$destination" ]; then
        # Twórz backup
        local backup_path="$backup_dir/$(basename "$destination")_$(date +%Y%m%d_%H%M%S)"
        cp -r "$destination" "$backup_path"
        print_status "Utworzono backup: $backup_path"
    fi
    
    # Kopiuj nowe pliki
    cp -r "$source" "$destination"
    print_status "Skopiowano: $source -> $destination"
}

# Główna funkcja deploymentu
deploy_to_mt5() {
    print_header "DEPLOYMENT SYSTEMU BÖHMEGO DO MT5"
    
    echo -e "${BLUE}Ścieżka MT5:${NC} $MT5_BASE_PATH"
    echo -e "${BLUE}Ścieżka projektu:${NC} $PROJECT_PATH"
    echo ""
    
    # Sprawdź czy katalogi MT5 istnieją
    print_header "SPRAWDZANIE KATALOGÓW MT5"
    
    if ! check_directory "$MT5_BASE_PATH"; then
        print_error "Nie znaleziono MT5 w: $MT5_BASE_PATH"
        print_error "Sprawdź czy MT5 jest zainstalowany i ścieżka jest poprawna"
        exit 1
    fi
    
    if ! check_directory "$MT5_MQL5_PATH"; then
        print_error "Nie znaleziono katalogu MQL5 w MT5"
        exit 1
    fi
    
    print_status "Wszystkie katalogi MT5 istnieją"
    
    # Utwórz katalogi jeśli nie istnieją
    print_header "TWORZENIE KATALOGÓW"
    create_directory "$MT5_EXPERTS_PATH/$PROJECT_NAME"
    create_directory "$MT5_INCLUDE_PATH/$PROJECT_NAME"
    create_directory "$MT5_LIBRARIES_PATH/$PROJECT_NAME"
    
    # Utwórz katalog backup
    local backup_dir="$PROJECT_PATH/backup_$(date +%Y%m%d_%H%M%S)"
    create_directory "$backup_dir"
    
    # Kopiuj pliki do MT5
    print_header "KOPIOWANIE PLIKÓW"
    
    # Główny plik systemu
    if [ -f "$PROJECT_PATH/Core/BohmeMainSystem.mq5" ]; then
        copy_with_backup "$PROJECT_PATH/Core/BohmeMainSystem.mq5" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    else
        print_warning "Nie znaleziono głównego pliku: Core/BohmeMainSystem.mq5"
    fi
    
    # Katalog Core
    if [ -d "$PROJECT_PATH/Core" ]; then
        copy_with_backup "$PROJECT_PATH/Core" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Katalog AI
    if [ -d "$PROJECT_PATH/AI" ]; then
        copy_with_backup "$PROJECT_PATH/AI" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Katalog Spirits
    if [ -d "$PROJECT_PATH/Spirits" ]; then
        copy_with_backup "$PROJECT_PATH/Spirits" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Katalog Data
    if [ -d "$PROJECT_PATH/Data" ]; then
        copy_with_backup "$PROJECT_PATH/Data" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Katalog Utils
    if [ -d "$PROJECT_PATH/Utils" ]; then
        copy_with_backup "$PROJECT_PATH/Utils" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Katalog Execution
    if [ -d "$PROJECT_PATH/Execution" ]; then
        copy_with_backup "$PROJECT_PATH/Execution" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Katalog Tests (opcjonalnie)
    if [ -d "$PROJECT_PATH/Tests" ]; then
        copy_with_backup "$PROJECT_PATH/Tests" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Kopiuj pliki dokumentacji
    if [ -f "$PROJECT_PATH/README.md" ]; then
        copy_with_backup "$PROJECT_PATH/README.md" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    if [ -f "$PROJECT_PATH/DOCUMENTATION.md" ]; then
        copy_with_backup "$PROJECT_PATH/DOCUMENTATION.md" "$MT5_EXPERTS_PATH/$PROJECT_NAME/" "$backup_dir"
    fi
    
    # Ustaw uprawnienia
    print_header "USTAWIANIE UPRAWNIEŃ"
    chmod -R 755 "$MT5_EXPERTS_PATH/$PROJECT_NAME"
    print_status "Ustawiono uprawnienia dla plików"
    
    # Sprawdź czy pliki zostały skopiowane
    print_header "WERYFIKACJA DEPLOYMENTU"
    
    if [ -f "$MT5_EXPERTS_PATH/$PROJECT_NAME/Core/BohmeMainSystem.mq5" ]; then
        print_status "Główny plik systemu został skopiowany"
    else
        print_error "Błąd: Główny plik systemu nie został skopiowany"
    fi
    
    local copied_dirs=("Core" "AI" "Spirits" "Data" "Utils" "Execution")
    for dir in "${copied_dirs[@]}"; do
        if [ -d "$MT5_EXPERTS_PATH/$PROJECT_NAME/$dir" ]; then
            print_status "Katalog $dir został skopiowany"
        else
            print_warning "Katalog $dir nie został skopiowany"
        fi
    done
    
    # Podsumowanie
    print_header "PODSUMOWANIE DEPLOYMENTU"
    echo -e "${GREEN}✓ System Böhmego został wdrożony do MT5${NC}"
    echo -e "${BLUE}Lokalizacja:${NC} $MT5_EXPERTS_PATH/$PROJECT_NAME"
    echo -e "${BLUE}Backup:${NC} $backup_dir"
    echo ""
    echo -e "${YELLOW}Następne kroki:${NC}"
    echo "1. Uruchom MetaTrader 5"
    echo "2. Otwórz MetaEditor (F4)"
    echo "3. Skompiluj plik: $PROJECT_NAME/Core/BohmeMainSystem.mq5"
    echo "4. Dodaj eksperta do wykresu"
    echo ""
    echo -e "${GREEN}Deployment zakończony pomyślnie!${NC}"
}

# Funkcja czyszczenia backupów
cleanup_backups() {
    print_header "CZYSZCZENIE STARYCH BACKUPÓW"
    
    local backup_pattern="$PROJECT_PATH/backup_*"
    local backup_count=$(find "$PROJECT_PATH" -maxdepth 1 -name "backup_*" -type d | wc -l)
    
    if [ "$backup_count" -gt 5 ]; then
        echo "Znaleziono $backup_count backupów. Usuwam najstarsze..."
        find "$PROJECT_PATH" -maxdepth 1 -name "backup_*" -type d -printf '%T@ %p\n' | sort -n | head -n -5 | cut -d' ' -f2- | xargs rm -rf
        print_status "Usunięto stare backupy"
    else
        print_status "Liczba backupów jest w normie ($backup_count)"
    fi
}

# Funkcja wyświetlająca pomoc
show_help() {
    echo -e "${BLUE}SKRYPT DEPLOYMENTU SYSTEMU BÖHMEGO${NC}"
    echo ""
    echo "Użycie: $0 [OPCJE]"
    echo ""
    echo "Opcje:"
    echo "  --deploy     Wdróż system do MT5 (domyślne)"
    echo "  --cleanup    Wyczyść stare backupy"
    echo "  --help       Wyświetl tę pomoc"
    echo ""
    echo "Przykłady:"
    echo "  $0              # Wdróż system"
    echo "  $0 --deploy     # Wdróż system"
    echo "  $0 --cleanup    # Wyczyść backupy"
    echo ""
}

# Główna logika skryptu
main() {
    case "${1:---deploy}" in
        --deploy)
            deploy_to_mt5
            cleanup_backups
            ;;
        --cleanup)
            cleanup_backups
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