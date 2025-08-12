#!/bin/bash

# ========================================
# GŁÓWNY SKRYPT BUDOWANIA SYSTEMU BÖHMEGO
# ========================================

# Kolory dla lepszej czytelności
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
NC='\033[0m' # No Color

# Konfiguracja
PROJECT_NAME="Bohme Trading System"
MT5_PATH="/home/krispi/.wine/drive_c/Program Files/Orbex Global MT5"

# Funkcja do wyświetlania nagłówków
print_header() {
    echo -e "${PURPLE}========================================${NC}"
    echo -e "${PURPLE}$1${NC}"
    echo -e "${PURPLE}========================================${NC}"
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

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

# Funkcja sprawdzająca wymagania
check_requirements() {
    print_header "SPRAWDZANIE WYMAGAŃ"
    
    local errors=0
    
    # Sprawdź czy Wine jest zainstalowane
    if ! command -v wine >/dev/null 2>&1; then
        print_error "Wine nie jest zainstalowane"
        print_info "Zainstaluj: sudo pacman -S wine"
        errors=$((errors + 1))
    else
        print_status "Wine jest zainstalowane"
    fi
    
    # Sprawdź czy MT5 istnieje
    if [ ! -d "$MT5_PATH" ]; then
        print_error "MT5 nie został znaleziony w: $MT5_PATH"
        errors=$((errors + 1))
    else
        print_status "MT5 został znaleziony"
    fi
    
    # Sprawdź czy skrypty deploymentu istnieją
    if [ ! -f "./deploy_to_mt5.sh" ]; then
        print_error "Brak skryptu deploy_to_mt5.sh"
        errors=$((errors + 1))
    else
        print_status "Skrypt deploymentu istnieje"
    fi
    
    if [ ! -f "./compile_in_mt5.sh" ]; then
        print_error "Brak skryptu compile_in_mt5.sh"
        errors=$((errors + 1))
    else
        print_status "Skrypt kompilacji istnieje"
    fi
    
    # Sprawdź czy główny plik systemu istnieje
    if [ ! -f "./Core/BohmeMainSystem.mq5" ]; then
        print_error "Brak głównego pliku: Core/BohmeMainSystem.mq5"
        errors=$((errors + 1))
    else
        print_status "Główny plik systemu istnieje"
    fi
    
    if [ $errors -gt 0 ]; then
        print_error "Znaleziono $errors błędów. Napraw je przed kontynuacją."
        return 1
    fi
    
    print_status "Wszystkie wymagania są spełnione"
    return 0
}

# Funkcja deploymentu
deploy_system() {
    print_header "DEPLOYMENT SYSTEMU"
    
    if ./deploy_to_mt5.sh; then
        print_status "Deployment zakończony pomyślnie"
        return 0
    else
        print_error "Błąd podczas deploymentu"
        return 1
    fi
}

# Funkcja kompilacji
compile_system() {
    print_header "KOMPILACJA SYSTEMU"
    
    if ./compile_in_mt5.sh; then
        print_status "Kompilacja zakończona pomyślnie"
        return 0
    else
        print_error "Błąd podczas kompilacji"
        return 1
    fi
}

# Funkcja testowania
test_system() {
    print_header "TESTOWANIE SYSTEMU"
    
    local ex5_file="$MT5_PATH/MQL5/Experts/Bohme_Trading_System/Core/BohmeMainSystem.ex5"
    
    if [ -f "$ex5_file" ]; then
        print_status "Plik .ex5 został utworzony"
        print_info "Rozmiar: $(ls -lh "$ex5_file" | awk '{print $5}')"
        print_info "Data utworzenia: $(ls -la "$ex5_file" | awk '{print $6, $7, $8}')"
    else
        print_error "Plik .ex5 nie został utworzony"
        return 1
    fi
    
    # Sprawdź logi kompilacji
    print_info "Sprawdzam logi kompilacji..."
    ./compile_in_mt5.sh --logs
    
    return 0
}

# Funkcja uruchamiania MT5
start_mt5() {
    print_header "URUCHAMIANIE META TRADER 5"
    
    if ./compile_in_mt5.sh --start; then
        print_status "MT5 został uruchomiony"
        return 0
    else
        print_error "Błąd podczas uruchamiania MT5"
        return 1
    fi
}

# Funkcja czyszczenia
cleanup() {
    print_header "CZYSZCZENIE"
    
    if ./deploy_to_mt5.sh --cleanup; then
        print_status "Czyszczenie zakończone"
    else
        print_warning "Błąd podczas czyszczenia"
    fi
}

# Funkcja wyświetlająca pomoc
show_help() {
    echo -e "${PURPLE}GŁÓWNY SKRYPT BUDOWANIA SYSTEMU BÖHMEGO${NC}"
    echo ""
    echo "Użycie: $0 [OPCJE]"
    echo ""
    echo "Opcje:"
    echo "  --full       Pełny build (deploy + compile + test)"
    echo "  --deploy     Tylko deployment"
    echo "  --compile    Tylko kompilacja"
    echo "  --test       Tylko testowanie"
    echo "  --start      Uruchom MT5"
    echo "  --cleanup    Wyczyść backupy"
    echo "  --check      Sprawdź wymagania"
    echo "  --help       Wyświetl tę pomoc"
    echo ""
    echo "Przykłady:"
    echo "  $0 --full     # Pełny build systemu"
    echo "  $0 --deploy   # Tylko skopiuj pliki"
    echo "  $0 --compile  # Tylko skompiluj"
    echo "  $0 --test     # Sprawdź wynik"
    echo ""
    echo -e "${YELLOW}Ścieżka MT5:${NC} $MT5_PATH"
    echo ""
}

# Funkcja pełnego builda
full_build() {
    print_header "PEŁNY BUILD SYSTEMU BÖHMEGO"
    
    local step=1
    local total_steps=4
    
    echo -e "${BLUE}Krok $step/$total_steps: Sprawdzanie wymagań${NC}"
    if ! check_requirements; then
        return 1
    fi
    
    step=$((step + 1))
    echo -e "${BLUE}Krok $step/$total_steps: Deployment${NC}"
    if ! deploy_system; then
        return 1
    fi
    
    step=$((step + 1))
    echo -e "${BLUE}Krok $step/$total_steps: Kompilacja${NC}"
    if ! compile_system; then
        return 1
    fi
    
    step=$((step + 1))
    echo -e "${BLUE}Krok $step/$total_steps: Testowanie${NC}"
    if ! test_system; then
        return 1
    fi
    
    print_header "BUILD ZAKOŃCZONY POMYŚLNIE"
    echo -e "${GREEN}✓ System Böhmego został zbudowany i jest gotowy do użycia${NC}"
    echo ""
    echo -e "${YELLOW}Następne kroki:${NC}"
    echo "1. Otwórz MT5"
    echo "2. Dodaj BohmeMainSystem do wykresu"
    echo "3. Skonfiguruj parametry"
    echo "4. Uruchom system"
    echo ""
    return 0
}

# Główna logika skryptu
main() {
    case "${1:---full}" in
        --full)
            full_build
            ;;
        --deploy)
            check_requirements && deploy_system
            ;;
        --compile)
            check_requirements && compile_system
            ;;
        --test)
            test_system
            ;;
        --start)
            start_mt5
            ;;
        --cleanup)
            cleanup
            ;;
        --check)
            check_requirements
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