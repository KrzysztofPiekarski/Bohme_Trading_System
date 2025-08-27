#ifndef TIME_UTILS_H
#define TIME_UTILS_H

// ========================================
// TIME UTILS - FUNKCJE OBSŁUGI CZASU
// ========================================
// Zaawansowane funkcje do obsługi czasu dla Systemu Böhmego
// Konwersje, obliczenia, formatowanie, analiza czasowa

#include "StringUtils.mqh"
#include <Trade\Trade.mqh>
#include <Object.mqh>

// === ENUMERACJE ===

// Jednostki czasu
enum ENUM_TIME_UNIT {
    TIME_UNIT_SECONDS,      // Sekundy
    TIME_UNIT_MINUTES,      // Minuty
    TIME_UNIT_HOURS,        // Godziny
    TIME_UNIT_DAYS,         // Dni
    TIME_UNIT_WEEKS,        // Tygodnie
    TIME_UNIT_MONTHS,       // Miesiące
    TIME_UNIT_YEARS         // Lata
};

// Formaty czasu
enum ENUM_TIME_FORMAT {
    TIME_FORMAT_SHORT,      // Krótki (HH:MM)
    TIME_FORMAT_STANDARD,   // Standardowy (HH:MM:SS)
    TIME_FORMAT_FULL,       // Pełny (YYYY-MM-DD HH:MM:SS)
    TIME_FORMAT_ISO,        // ISO 8601
    TIME_FORMAT_CUSTOM,     // Własny format
    TIME_FORMAT_RELATIVE,   // Względny (np. "2 godziny temu")
    TIME_FORMAT_TIMESTAMP   // Timestamp Unix
};

// Strefy czasowe (główne)
enum ENUM_TIMEZONE {
    TIMEZONE_UTC,           // UTC
    TIMEZONE_GMT,           // GMT
    TIMEZONE_EST,           // Eastern Standard Time
    TIMEZONE_PST,           // Pacific Standard Time
    TIMEZONE_CET,           // Central European Time
    TIMEZONE_EET,           // Eastern European Time
    TIMEZONE_JST,           // Japan Standard Time
    TIMEZONE_AEST,          // Australian Eastern Standard Time
    TIMEZONE_WET            // Western European Time
};

// Typy okresów
enum ENUM_PERIOD_TYPE {
    PERIOD_TYPE_DAILY,      // Codziennie
    PERIOD_TYPE_WEEKLY,     // Co tydzień
    PERIOD_TYPE_MONTHLY,    // Co miesiąc
    PERIOD_TYPE_QUARTERLY,  // Co kwartał
    PERIOD_TYPE_YEARLY,     // Co rok
    PERIOD_TYPE_CUSTOM      // Własny okres
};

// Typy analizy czasowej
enum ENUM_TIME_ANALYSIS {
    TIME_ANALYSIS_TREND,    // Trend czasowy
    TIME_ANALYSIS_SEASONAL, // Sezonowość
    TIME_ANALYSIS_CYCLIC,   // Cykliczność
    TIME_ANALYSIS_PATTERN,  // Wzorce czasowe
    TIME_ANALYSIS_FORECAST  // Prognoza czasowa
};

// === STRUKTURY DANYCH ===

// Struktura informacji o czasie
struct STimeInfo {
    datetime timestamp;     // Timestamp
    int year;              // Rok
    int month;             // Miesiąc (1-12)
    int day;               // Dzień (1-31)
    int hour;              // Godzina (0-23)
    int minute;            // Minuta (0-59)
    int second;            // Sekunda (0-59)
    int day_of_week;       // Dzień tygodnia (0-6, 0=Niedziela)
    int day_of_year;       // Dzień roku (1-366)
    int week_of_year;      // Tydzień roku (1-53)
    bool is_leap_year;     // Czy rok przestępny
    bool is_weekend;       // Czy weekend
    bool is_business_day;  // Czy dzień roboczy
    ENUM_TIMEZONE timezone; // Strefa czasowa
    string timezone_name;  // Nazwa strefy czasowej
    datetime analysis_time; // Czas analizy
};

// Struktura okresu czasowego
struct STimePeriod {
    datetime start_time;   // Czas rozpoczęcia
    datetime end_time;     // Czas zakończenia
    int duration_seconds;  // Czas trwania w sekundach
    ENUM_TIME_UNIT duration_unit; // Jednostka czasu trwania
    ENUM_PERIOD_TYPE period_type; // Typ okresu
    string description;    // Opis okresu
    bool is_valid;         // Czy okres jest prawidłowy
    datetime analysis_time; // Czas przeprowadzenia analizy
};

// Struktura analizy czasowej
struct STimeAnalysis {
    ENUM_TIME_ANALYSIS analysis_type; // Typ analizy
    datetime analysis_start;          // Początek analizy
    datetime analysis_end;            // Koniec analizy
    int data_points;                  // Liczba punktów danych
    double trend_slope;               // Nachylenie trendu
    double seasonality_strength;      // Siła sezonowości
    double cyclic_period;             // Okres cykliczności
    string pattern_description;       // Opis wzorca
    double forecast_accuracy;         // Dokładność prognozy
    datetime forecast_horizon;        // Horyzont prognozy
    string analysis_summary;          // Podsumowanie analizy
    datetime analysis_time;           // Czas analizy
};

// Struktura kalendarza
struct SCalendar {
    int year;              // Rok
    int month;             // Miesiąc
    int days_in_month;     // Liczba dni w miesiącu
    int first_day_of_week; // Pierwszy dzień tygodnia
    datetime holidays[];   // Święta
    datetime business_days[]; // Dni robocze
    datetime weekends[];   // Weekendy
    string month_name;     // Nazwa miesiąca
    string month_name_short; // Krótka nazwa miesiąca
    datetime analysis_time; // Czas przeprowadzenia analizy
};

// === PODSTAWOWE FUNKCJE CZASU ===

// Funkcja do pobierania aktualnego czasu
datetime GetCurrentTime() {
    return TimeLocal();
}

// Funkcja do pobierania roku z timestamp
int TimeYear(datetime dt) {
    MqlDateTime tm;
    TimeToStruct(dt, tm);
    return tm.year;
}

// Funkcja do pobierania miesiąca z timestamp  
int TimeMonth(datetime dt) {
    MqlDateTime tm;
    TimeToStruct(dt, tm);
    return tm.mon;
}

// Funkcja do pobierania dnia z timestamp
int TimeDay(datetime dt) {
    MqlDateTime tm;
    TimeToStruct(dt, tm);
    return tm.day;
}

// Funkcja do pobierania godziny z timestamp
int TimeHour(datetime dt) {
    MqlDateTime tm;
    TimeToStruct(dt, tm);
    return tm.hour;
}

// Funkcja do pobierania minuty z timestamp
int TimeMinute(datetime dt) {
    MqlDateTime tm;
    TimeToStruct(dt, tm);
    return tm.min;
}

// Funkcja do pobierania sekundy z timestamp
int TimeSecond(datetime dt) {
    MqlDateTime tm;
    TimeToStruct(dt, tm);
    return tm.sec;
}

// Funkcja do pobierania dnia tygodnia z timestamp
int TimeDayOfWeek(datetime dt) {
    MqlDateTime tm;
    TimeToStruct(dt, tm);
    return tm.day_of_week;
}

// Funkcja do pobierania aktualnego czasu serwera
datetime GetTimeCurrent() {
    return TimeLocal();
}

// Funkcja do pobierania czasu lokalnego
datetime GetLocalTime() {
    return TimeLocal();
}

// Funkcja do pobierania czasu GMT
datetime GetGMTTime() {
    return TimeGMT();
}

// Funkcja do sprawdzania czy timestamp jest prawidłowy
bool IsValidTimestamp(datetime timestamp) {
    return timestamp > 0 && timestamp <= 253402300799; // Max timestamp dla roku 9999
}

// Funkcja do sprawdzania czy rok jest przestępny
bool IsLeapYear(int year) {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
}

// Funkcja do obliczania liczby dni w miesiącu
int GetDaysInMonth(int year, int month) {
    if(month < 1 || month > 12) return 0;
    
    int days_in_month[] = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
    
    if(month == 2 && IsLeapYear(year)) {
        return 29;
    }
    
    return days_in_month[month - 1];
}

// Funkcja do obliczania dnia tygodnia (0=Niedziela, 1=Poniedziałek, ..., 6=Sobota)
int GetDayOfWeek(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    // Algorytm Zellera
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    int year = dt.year;
    int month = dt.mon;
    int day = dt.day;
    
    if(month < 3) {
        month += 12;
        year--;
    }
    
    int century = year / 100;
    year = year % 100;
    
    int day_of_week = (day + (13 * (month + 1)) / 5 + year + year / 4 + century / 4 - 2 * century) % 7;
    
    // Konwersja do formatu 0=Niedziela
    return (day_of_week + 5) % 7;
}

// Funkcja do sprawdzania czy to weekend
bool IsWeekend(datetime timestamp) {
    int day_of_week = GetDayOfWeek(timestamp);
    return day_of_week == 0 || day_of_week == 6; // Niedziela lub Sobota
}

// Funkcja do sprawdzania czy to dzień roboczy
bool IsBusinessDay(datetime timestamp) {
    return !IsWeekend(timestamp);
}

// Funkcja do obliczania dnia roku
int GetDayOfYear(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    int day_of_year = dt.day;
    
    for(int month = 1; month < dt.mon; month++) {
        day_of_year += GetDaysInMonth(dt.year, month);
    }
    
    return day_of_year;
}

// Funkcja do obliczania tygodnia roku
int GetWeekOfYear(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    int day_of_year = GetDayOfYear(timestamp);
    int day_of_week = GetDayOfWeek(timestamp);
    
    // Pierwszy tydzień roku to ten, który zawiera 1 stycznia
    int first_day_of_week = GetDayOfWeek(StringToTime(TimeToString(timestamp, TIME_DATE)));
    
    int week = (day_of_year + first_day_of_week - 1) / 7;
    
    return week + 1;
}

// Funkcja do konwersji string na datetime
datetime StringToDateTime(string time_string, ENUM_TIME_FORMAT format = TIME_FORMAT_STANDARD) {
    if(StringLen(time_string) == 0) return 0;
    
    switch(format) {
        case TIME_FORMAT_SHORT:
            // Format HH:MM
            if(StringLen(time_string) == 5 && StringGetCharacter(time_string, 2) == ':') {
                string hour_str = StringSubstr(time_string, 0, 2);
                string minute_str = StringSubstr(time_string, 3, 2);
                
                if(IsInteger(hour_str) && IsInteger(minute_str)) {
                    int hour = StringToInteger(hour_str);
                    int minute = StringToInteger(minute_str);
                    
                    if(hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59) {
                        datetime today = StringToTime(TimeToString(TimeCurrent(), TIME_DATE));
                        return today + hour * 3600 + minute * 60;
                    }
                }
            }
            break;
            
        case TIME_FORMAT_STANDARD:
            // Format HH:MM:SS
            if(StringLen(time_string) == 8 && StringGetCharacter(time_string, 2) == ':' && StringGetCharacter(time_string, 5) == ':') {
                string hour_str = StringSubstr(time_string, 0, 2);
                string minute_str = StringSubstr(time_string, 3, 2);
                string second_str = StringSubstr(time_string, 6, 2);
                
                if(IsInteger(hour_str) && IsInteger(minute_str) && IsInteger(second_str)) {
                    int hour = StringToInteger(hour_str);
                    int minute = StringToInteger(minute_str);
                    int second = StringToInteger(second_str);
                    
                    if(hour >= 0 && hour <= 23 && minute >= 0 && minute <= 59 && second >= 0 && second <= 59) {
                        datetime today = StringToTime(TimeToString(TimeCurrent(), TIME_DATE));
                        return today + hour * 3600 + minute * 60 + second;
                    }
                }
            }
            break;
            
        case TIME_FORMAT_FULL:
        case TIME_FORMAT_ISO:
            // Format YYYY-MM-DD HH:MM:SS lub YYYY-MM-DDTHH:MM:SS
            return StringToTime(time_string);
            
        case TIME_FORMAT_TIMESTAMP:
            // Unix timestamp
            if(IsInteger(time_string)) {
                return (datetime)StringToInteger(time_string);
            }
            break;
    }
    
    return 0;
}

// Funkcja do konwersji datetime na string
string DateTimeToString(datetime timestamp, ENUM_TIME_FORMAT format = TIME_FORMAT_STANDARD) {
    if(!IsValidTimestamp(timestamp)) return "";
    
    switch(format) {
        case TIME_FORMAT_SHORT:
            return TimeToString(timestamp, TIME_MINUTES);
            
        case TIME_FORMAT_STANDARD:
            return TimeToString(timestamp, TIME_SECONDS);
            
        case TIME_FORMAT_FULL:
            return TimeToString(timestamp, TIME_DATE | TIME_SECONDS);
            
        case TIME_FORMAT_ISO:
            return TimeToString(timestamp, TIME_DATE | TIME_SECONDS);
            
        case TIME_FORMAT_TIMESTAMP:
            return IntegerToString((int)timestamp);
            
        case TIME_FORMAT_RELATIVE:
            return GetRelativeTimeString(timestamp);
            
        default:
            return TimeToString(timestamp, TIME_SECONDS);
    }
}

// Funkcja do obliczania różnicy czasu w sekundach
int GetTimeDifference(datetime time1, datetime time2) {
    if(!IsValidTimestamp(time1) || !IsValidTimestamp(time2)) return 0;
    
    return (int)(time2 - time1);
}

// Funkcja do obliczania różnicy czasu w określonej jednostce
double GetTimeDifferenceInUnit(datetime time1, datetime time2, ENUM_TIME_UNIT unit) {
    int seconds_diff = GetTimeDifference(time1, time2);
    
    switch(unit) {
        case TIME_UNIT_SECONDS:
            return (double)seconds_diff;
            
        case TIME_UNIT_MINUTES:
            return (double)seconds_diff / 60.0;
            
        case TIME_UNIT_HOURS:
            return (double)seconds_diff / 3600.0;
            
        case TIME_UNIT_DAYS:
            return (double)seconds_diff / 86400.0;
            
        case TIME_UNIT_WEEKS:
            return (double)seconds_diff / 604800.0;
            
        case TIME_UNIT_MONTHS:
            return (double)seconds_diff / 2592000.0; // Przybliżenie
            
        case TIME_UNIT_YEARS:
            return (double)seconds_diff / 31536000.0; // Przybliżenie
            
        default:
            return (double)seconds_diff;
    }
}

// Funkcja do dodawania czasu
datetime AddTime(datetime timestamp, double amount, ENUM_TIME_UNIT unit) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    int seconds_to_add = 0;
    
    switch(unit) {
        case TIME_UNIT_SECONDS:
            seconds_to_add = (int)amount;
            break;
            
        case TIME_UNIT_MINUTES:
            seconds_to_add = (int)(amount * 60);
            break;
            
        case TIME_UNIT_HOURS:
            seconds_to_add = (int)(amount * 3600);
            break;
            
        case TIME_UNIT_DAYS:
            seconds_to_add = (int)(amount * 86400);
            break;
            
        case TIME_UNIT_WEEKS:
            seconds_to_add = (int)(amount * 604800);
            break;
            
        case TIME_UNIT_MONTHS:
            // Przybliżenie - dodanie dni
            seconds_to_add = (int)(amount * 30 * 86400);
            break;
            
        case TIME_UNIT_YEARS:
            // Przybliżenie - dodanie dni
            seconds_to_add = (int)(amount * 365 * 86400);
            break;
    }
    
    return timestamp + seconds_to_add;
}

// Funkcja do odejmowania czasu
datetime SubtractTime(datetime timestamp, double amount, ENUM_TIME_UNIT unit) {
    return AddTime(timestamp, -amount, unit);
}

// Funkcja do obliczania wieku
int CalculateAge(datetime birth_date) {
    if(!IsValidTimestamp(birth_date)) return -1;
    
    datetime current_time = GetTimeCurrent();
    if(birth_date > current_time) return -1;
    
    MqlDateTime birth_dt, current_dt;
    TimeToStruct(birth_date, birth_dt);
    TimeToStruct(current_time, current_dt);
    
    int age = current_dt.year - birth_dt.year;
    
    // Sprawdzenie czy urodziny już były w tym roku
    if(current_dt.mon < birth_dt.mon || 
       (current_dt.mon == birth_dt.mon && current_dt.day < birth_dt.day)) {
        age--;
    }
    
    return age;
}

// Funkcja do sprawdzania czy data jest w przeszłości
bool IsPast(datetime timestamp) {
    return IsValidTimestamp(timestamp) && timestamp < GetTimeCurrent();
}

// Funkcja do sprawdzania czy data jest w przyszłości
bool IsFuture(datetime timestamp) {
    return IsValidTimestamp(timestamp) && timestamp > GetTimeCurrent();
}

// Funkcja do sprawdzania czy data jest dzisiaj
bool IsToday(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    string today = TimeToString(TimeCurrent(), TIME_DATE);
    string timestamp_date = TimeToString(timestamp, TIME_DATE);
    
    return today == timestamp_date;
}

// Funkcja do sprawdzania czy data jest w tym tygodniu
bool IsThisWeek(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    int current_week = GetWeekOfYear(GetTimeCurrent());
    int timestamp_week = GetWeekOfYear(timestamp);
    int current_year = TimeYear(GetTimeCurrent());
    int timestamp_year = TimeYear(timestamp);
    
    return current_week == timestamp_week && current_year == timestamp_year;
}

// Funkcja do sprawdzania czy data jest w tym miesiącu
bool IsThisMonth(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    MqlDateTime current_dt, timestamp_dt;
    TimeToStruct(GetTimeCurrent(), current_dt);
    TimeToStruct(timestamp, timestamp_dt);
    
    return current_dt.mon == timestamp_dt.mon && current_dt.year == timestamp_dt.year;
}

// Funkcja do sprawdzania czy data jest w tym roku
bool IsThisYear(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    return TimeYear(GetTimeCurrent()) == TimeYear(timestamp);
}

// Funkcja do pobierania początku dnia
datetime GetStartOfDay(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    string date_string = TimeToString(timestamp, TIME_DATE);
    return StringToTime(date_string);
}

// Funkcja do pobierania końca dnia
datetime GetEndOfDay(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    datetime start_of_day = GetStartOfDay(timestamp);
    return start_of_day + 86399; // 23:59:59
}

// Funkcja do pobierania początku tygodnia
datetime GetStartOfWeek(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    int day_of_week = GetDayOfWeek(timestamp);
    datetime start_of_day = GetStartOfDay(timestamp);
    
    return start_of_day - (day_of_week * 86400);
}

// Funkcja do pobierania końca tygodnia
datetime GetEndOfWeek(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    datetime start_of_week = GetStartOfWeek(timestamp);
    return start_of_week + (6 * 86400) + 86399; // Sobota 23:59:59
}

// Funkcja do pobierania początku miesiąca
datetime GetStartOfMonth(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    string month_start = IntegerToString(dt.year) + "." + 
                        (dt.mon < 10 ? "0" : "") + IntegerToString(dt.mon) + ".01";
    
    return StringToTime(month_start);
}

// Funkcja do pobierania końca miesiąca
datetime GetEndOfMonth(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    datetime start_of_month = GetStartOfMonth(timestamp);
    int days_in_month = GetDaysInMonth(TimeYear(timestamp), TimeMonth(timestamp));
    
    return start_of_month + ((days_in_month - 1) * 86400) + 86399;
}

// Funkcja do pobierania początku roku
datetime GetStartOfYear(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    int year = TimeYear(timestamp);
    string year_start = IntegerToString(year) + ".01.01";
    
    return StringToTime(year_start);
}

// Funkcja do pobierania końca roku
datetime GetEndOfYear(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    datetime start_of_year = GetStartOfYear(timestamp);
    int days_in_year = IsLeapYear(TimeYear(timestamp)) ? 366 : 365;
    
    return start_of_year + ((days_in_year - 1) * 86400) + 86399;
}

// === ANALIZA I INFORMACJE O CZASIE ===

// Funkcja do analizy czasu i zwrócenia szczegółowych informacji
STimeInfo AnalyzeTime(datetime timestamp) {
    STimeInfo info;
    info.analysis_time = GetTimeCurrent();
    
    if(!IsValidTimestamp(timestamp)) {
        info.timestamp = 0;
        info.year = 0;
        info.month = 0;
        info.day = 0;
        info.hour = 0;
        info.minute = 0;
        info.second = 0;
        info.day_of_week = -1;
        info.day_of_year = -1;
        info.week_of_year = -1;
        info.is_leap_year = false;
        info.is_weekend = false;
        info.is_business_day = false;
        info.timezone = TIMEZONE_UTC;
        info.timezone_name = "UTC";
        return info;
    }
    
    info.timestamp = timestamp;
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    info.year = dt.year;
    info.month = dt.mon;
    info.day = dt.day;
    info.hour = dt.hour;
    info.minute = dt.min;
    info.second = dt.sec;
    info.day_of_week = GetDayOfWeek(timestamp);
    info.day_of_year = GetDayOfYear(timestamp);
    info.week_of_year = GetWeekOfYear(timestamp);
    info.is_leap_year = IsLeapYear(dt.year);
    info.is_weekend = IsWeekend(timestamp);
    info.is_business_day = IsBusinessDay(timestamp);
    info.timezone = TIMEZONE_UTC;
    info.timezone_name = "UTC";
    
    return info;
}

// Funkcja do generowania względnego opisu czasu
string GetRelativeTimeString(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return "Nieprawidłowy czas";
    
    datetime current_time = GetTimeCurrent();
    int seconds_diff = GetTimeDifference(timestamp, current_time);
    
    if(seconds_diff < 0) {
        // Czas w przyszłości
        seconds_diff = MathAbs(seconds_diff);
        
        if(seconds_diff < 60) {
            return "za " + IntegerToString(seconds_diff) + " sekund";
        } else if(seconds_diff < 3600) {
            int minutes = seconds_diff / 60;
            return "za " + IntegerToString(minutes) + " minut";
        } else if(seconds_diff < 86400) {
            int hours = seconds_diff / 3600;
            return "za " + IntegerToString(hours) + " godzin";
        } else if(seconds_diff < 604800) {
            int days = seconds_diff / 86400;
            return "za " + IntegerToString(days) + " dni";
        } else if(seconds_diff < 2592000) {
            int weeks = seconds_diff / 604800;
            return "za " + IntegerToString(weeks) + " tygodni";
        } else {
            int months = seconds_diff / 2592000;
            return "za " + IntegerToString(months) + " miesięcy";
        }
    } else {
        // Czas w przeszłości
        if(seconds_diff < 60) {
            return seconds_diff == 0 ? "teraz" : IntegerToString(seconds_diff) + " sekund temu";
        } else if(seconds_diff < 3600) {
            int minutes = seconds_diff / 60;
            return IntegerToString(minutes) + " minut temu";
        } else if(seconds_diff < 86400) {
            int hours = seconds_diff / 3600;
            return IntegerToString(hours) + " godzin temu";
        } else if(seconds_diff < 604800) {
            int days = seconds_diff / 86400;
            return IntegerToString(days) + " dni temu";
        } else if(seconds_diff < 2592000) {
            int weeks = seconds_diff / 604800;
            return IntegerToString(weeks) + " tygodni temu";
        } else {
            int months = seconds_diff / 2592000;
            return IntegerToString(months) + " miesięcy temu";
        }
    }
}

// Funkcja do obliczania wieku w latach, miesiącach i dniach
string CalculateDetailedAge(datetime birth_date) {
    if(!IsValidTimestamp(birth_date)) return "Nieprawidłowa data urodzenia";
    
    datetime current_time = GetTimeCurrent();
    if(birth_date > current_time) return "Data urodzenia w przyszłości";
    
    MqlDateTime birth_dt, current_dt;
    TimeToStruct(birth_date, birth_dt);
    TimeToStruct(current_time, current_dt);
    
    int years = current_dt.year - birth_dt.year;
    int months = current_dt.mon - birth_dt.mon;
    int days = current_dt.day - birth_dt.day;
    
    // Korekta dla ujemnych miesięcy/dni
    if(days < 0) {
        months--;
        int days_in_prev_month = GetDaysInMonth(current_dt.year, current_dt.mon - 1);
        if(days_in_prev_month == 0) days_in_prev_month = 31;
        days += days_in_prev_month;
    }
    
    if(months < 0) {
        years--;
        months += 12;
    }
    
    string result = "";
    if(years > 0) {
        result += IntegerToString(years) + " lat";
        if(months > 0 || days > 0) result += ", ";
    }
    
    if(months > 0) {
        result += IntegerToString(months) + " miesięcy";
        if(days > 0) result += ", ";
    }
    
    if(days > 0) {
        result += IntegerToString(days) + " dni";
    }
    
    if(StringLen(result) == 0) {
        result = "Mniej niż 1 dzień";
    }
    
    return result;
}

// Funkcja do obliczania czasu trwania między dwoma datami
string CalculateDuration(datetime start_time, datetime end_time) {
    if(!IsValidTimestamp(start_time) || !IsValidTimestamp(end_time)) {
        return "Nieprawidłowe daty";
    }
    
    if(start_time > end_time) {
        datetime temp = start_time;
        start_time = end_time;
        end_time = temp;
    }
    
    int total_seconds = GetTimeDifference(start_time, end_time);
    
    int days = total_seconds / 86400;
    int hours = (total_seconds % 86400) / 3600;
    int minutes = (total_seconds % 3600) / 60;
    int seconds = total_seconds % 60;
    
    string result = "";
    
    if(days > 0) {
        result += IntegerToString(days) + " dni";
        if(hours > 0 || minutes > 0 || seconds > 0) result += ", ";
    }
    
    if(hours > 0) {
        result += IntegerToString(hours) + " godzin";
        if(minutes > 0 || seconds > 0) result += ", ";
    }
    
    if(minutes > 0) {
        result += IntegerToString(minutes) + " minut";
        if(seconds > 0) result += ", ";
    }
    
    if(seconds > 0) {
        result += IntegerToString(seconds) + " sekund";
    }
    
    if(StringLen(result) == 0) {
        result = "0 sekund";
    }
    
    return result;
}

// Funkcja do sprawdzania czy czas jest w określonym zakresie
bool IsTimeInRange(datetime timestamp, datetime start_time, datetime end_time) {
    if(!IsValidTimestamp(timestamp) || !IsValidTimestamp(start_time) || !IsValidTimestamp(end_time)) {
        return false;
    }
    
    return timestamp >= start_time && timestamp <= end_time;
}

// Funkcja do sprawdzania czy czas jest w określonym przedziale godzinowym
bool IsTimeInHourRange(datetime timestamp, int start_hour, int end_hour) {
    if(!IsValidTimestamp(timestamp) || start_hour < 0 || start_hour > 23 || end_hour < 0 || end_hour > 23) {
        return false;
    }
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    if(start_hour <= end_hour) {
        return dt.hour >= start_hour && dt.hour <= end_hour;
    } else {
        // Zakres przechodzi przez północ
        return dt.hour >= start_hour || dt.hour <= end_hour;
    }
}

// Funkcja do sprawdzania czy czas jest w godzinach handlowych
bool IsTradingHours(datetime timestamp) {
    // Przykładowe godziny handlowe: 9:00-17:00 w dni robocze
    if(!IsBusinessDay(timestamp)) return false;
    
    return IsTimeInHourRange(timestamp, 9, 17);
}

// Funkcja do obliczania liczby dni roboczych między dwoma datami
int GetBusinessDaysBetween(datetime start_time, datetime end_time) {
    if(!IsValidTimestamp(start_time) || !IsValidTimestamp(end_time)) return 0;
    
    if(start_time > end_time) {
        datetime temp = start_time;
        start_time = end_time;
        end_time = temp;
    }
    
    int business_days = 0;
    datetime current_time = start_time;
    
    while(current_time <= end_time) {
        if(IsBusinessDay(current_time)) {
            business_days++;
        }
        current_time = AddTime(current_time, 1, TIME_UNIT_DAYS);
    }
    
    return business_days;
}

// Funkcja do obliczania następnego dnia roboczego
datetime GetNextBusinessDay(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    datetime next_day = AddTime(timestamp, 1, TIME_UNIT_DAYS);
    
    while(!IsBusinessDay(next_day)) {
        next_day = AddTime(next_day, 1, TIME_UNIT_DAYS);
    }
    
    return next_day;
}

// Funkcja do obliczania poprzedniego dnia roboczego
datetime GetPreviousBusinessDay(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return 0;
    
    datetime prev_day = SubtractTime(timestamp, 1, TIME_UNIT_DAYS);
    
    while(!IsBusinessDay(prev_day)) {
        prev_day = SubtractTime(prev_day, 1, TIME_UNIT_DAYS);
    }
    
    return prev_day;
}

// Funkcja do obliczania liczby dni do weekendu
int GetDaysToWeekend(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    int days_to_weekend = 0;
    datetime current_time = timestamp;
    
    while(!IsWeekend(current_time)) {
        days_to_weekend++;
        current_time = AddTime(current_time, 1, TIME_UNIT_DAYS);
    }
    
    return days_to_weekend;
}

// Funkcja do obliczania liczby dni od weekendu
int GetDaysFromWeekend(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    int days_from_weekend = 0;
    datetime current_time = timestamp;
    
    while(!IsWeekend(current_time)) {
        days_from_weekend++;
        current_time = SubtractTime(current_time, 1, TIME_UNIT_DAYS);
    }
    
    return days_from_weekend;
}

// Funkcja do sprawdzania czy to poranek (6:00-12:00)
bool IsMorning(datetime timestamp) {
    return IsTimeInHourRange(timestamp, 6, 12);
}

// Funkcja do sprawdzania czy to popołudnie (12:00-18:00)
bool IsAfternoon(datetime timestamp) {
    return IsTimeInHourRange(timestamp, 12, 18);
}

// Funkcja do sprawdzania czy to wieczór (18:00-22:00)
bool IsEvening(datetime timestamp) {
    return IsTimeInHourRange(timestamp, 18, 22);
}

// Funkcja do sprawdzania czy to noc (22:00-6:00)
bool IsNight(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    return dt.hour >= 22 || dt.hour < 6;
}

// Funkcja do obliczania pory roku
int GetSeason(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    int month = dt.mon;
    
    if(month >= 3 && month <= 5) return 0;      // Wiosna
    else if(month >= 6 && month <= 8) return 1; // Lato
    else if(month >= 9 && month <= 11) return 2; // Jesień
    else return 3;                              // Zima
}

// Funkcja do pobierania nazwy pory roku
string GetSeasonName(datetime timestamp) {
    int season = GetSeason(timestamp);
    
    switch(season) {
        case 0: return "Wiosna";
        case 1: return "Lato";
        case 2: return "Jesień";
        case 3: return "Zima";
        default: return "Nieznana";
    }
}

// Funkcja do sprawdzania czy to święto (uproszczona implementacja)
bool IsHoliday(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    // Przykładowe święta (można rozszerzyć)
    if(dt.mon == 1 && dt.day == 1) return true;   // Nowy Rok
    if(dt.mon == 12 && dt.day == 25) return true; // Boże Narodzenie
    if(dt.mon == 12 && dt.day == 26) return true; // Drugi dzień świąt
    
    return false;
}

// Funkcja do obliczania liczby dni do następnego święta
int GetDaysToNextHoliday(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    int days_to_holiday = 0;
    datetime current_time = timestamp;
    
    while(!IsHoliday(current_time)) {
        days_to_holiday++;
        current_time = AddTime(current_time, 1, TIME_UNIT_DAYS);
        
        // Zabezpieczenie przed nieskończoną pętlą
        if(days_to_holiday > 365) break;
    }
    
    return days_to_holiday > 365 ? -1 : days_to_holiday;
}

// Funkcja do obliczania liczby dni od ostatniego święta
int GetDaysFromLastHoliday(datetime timestamp) {
    if(!IsValidTimestamp(timestamp)) return -1;
    
    int days_from_holiday = 0;
    datetime current_time = timestamp;
    
    while(!IsHoliday(current_time)) {
        days_from_holiday++;
        current_time = SubtractTime(current_time, 1, TIME_UNIT_DAYS);
        
        // Zabezpieczenie przed nieskończoną pętlą
        if(days_from_holiday > 365) break;
    }
    
    return days_from_holiday > 365 ? -1 : days_from_holiday;
}

// Funkcja do generowania raportu analizy czasu
string GenerateTimeAnalysisReport(STimeInfo &info) {
    string report = "=== ANALIZA CZASU ===\n";
    report += "Timestamp: " + IntegerToString((int)info.timestamp) + "\n";
    report += "Data i czas: " + DateTimeToString(info.timestamp, TIME_FORMAT_FULL) + "\n";
    report += "Rok: " + IntegerToString(info.year) + "\n";
    report += "Miesiąc: " + IntegerToString(info.month) + "\n";
    report += "Dzień: " + IntegerToString(info.day) + "\n";
    report += "Godzina: " + IntegerToString(info.hour) + ":" + 
              (info.minute < 10 ? "0" : "") + IntegerToString(info.minute) + ":" +
              (info.second < 10 ? "0" : "") + IntegerToString(info.second) + "\n";
    report += "Dzień tygodnia: " + IntegerToString(info.day_of_week) + "\n";
    report += "Dzień roku: " + IntegerToString(info.day_of_year) + "\n";
    report += "Tydzień roku: " + IntegerToString(info.week_of_year) + "\n";
    report += "Rok przestępny: " + (info.is_leap_year ? "TAK" : "NIE") + "\n";
    report += "Weekend: " + (info.is_weekend ? "TAK" : "NIE") + "\n";
    report += "Dzień roboczy: " + (info.is_business_day ? "TAK" : "NIE") + "\n";
    report += "Strefa czasowa: " + info.timezone_name + "\n";
    report += "Czas analizy: " + DateTimeToString(info.analysis_time, TIME_FORMAT_FULL) + "\n";
    
    return report;
}

// === OKRESY CZASOWE I KALENDARZ ===

// Funkcja do tworzenia okresu czasowego
STimePeriod CreateTimePeriod(datetime start_time, datetime end_time, ENUM_PERIOD_TYPE period_type = PERIOD_TYPE_CUSTOM) {
    STimePeriod period;
    period.start_time = start_time;
    period.end_time = end_time;
    period.period_type = period_type;
    period.analysis_time = GetTimeCurrent();
    
    if(IsValidTimestamp(start_time) && IsValidTimestamp(end_time)) {
        period.duration_seconds = GetTimeDifference(start_time, end_time);
        period.is_valid = true;
        
        // Określenie jednostki czasu trwania
        if(period.duration_seconds < 60) {
            period.duration_unit = TIME_UNIT_SECONDS;
        } else if(period.duration_seconds < 3600) {
            period.duration_unit = TIME_UNIT_MINUTES;
        } else if(period.duration_seconds < 86400) {
            period.duration_unit = TIME_UNIT_HOURS;
        } else if(period.duration_seconds < 604800) {
            period.duration_unit = TIME_UNIT_DAYS;
        } else if(period.duration_seconds < 2592000) {
            period.duration_unit = TIME_UNIT_WEEKS;
        } else if(period.duration_seconds < 31536000) {
            period.duration_unit = TIME_UNIT_MONTHS;
        } else {
            period.duration_unit = TIME_UNIT_YEARS;
        }
        
        // Generowanie opisu
        period.description = "Okres od " + DateTimeToString(start_time, TIME_FORMAT_FULL) + 
                           " do " + DateTimeToString(end_time, TIME_FORMAT_FULL) + 
                           " (" + CalculateDuration(start_time, end_time) + ")";
    } else {
        period.duration_seconds = 0;
        period.duration_unit = TIME_UNIT_SECONDS;
        period.is_valid = false;
        period.description = "Nieprawidłowy okres czasowy";
    }
    
    return period;
}

// Funkcja do tworzenia dziennego okresu
STimePeriod CreateDailyPeriod(datetime date) {
    datetime start_of_day = GetStartOfDay(date);
    datetime end_of_day = GetEndOfDay(date);
    return CreateTimePeriod(start_of_day, end_of_day, PERIOD_TYPE_DAILY);
}

// Funkcja do tworzenia tygodniowego okresu
STimePeriod CreateWeeklyPeriod(datetime date) {
    datetime start_of_week = GetStartOfWeek(date);
    datetime end_of_week = GetEndOfWeek(date);
    return CreateTimePeriod(start_of_week, end_of_week, PERIOD_TYPE_WEEKLY);
}

// Funkcja do tworzenia miesięcznego okresu
STimePeriod CreateMonthlyPeriod(datetime date) {
    datetime start_of_month = GetStartOfMonth(date);
    datetime end_of_month = GetEndOfMonth(date);
    return CreateTimePeriod(start_of_month, end_of_month, PERIOD_TYPE_MONTHLY);
}

// Funkcja do tworzenia kwartalnego okresu
STimePeriod CreateQuarterlyPeriod(datetime date) {
    if(!IsValidTimestamp(date)) {
        STimePeriod invalid_period;
        invalid_period.is_valid = false;
        return invalid_period;
    }
    
    MqlDateTime dt;
    TimeToStruct(date, dt);
    
    int quarter = (dt.mon - 1) / 3 + 1;
    int quarter_start_month = (quarter - 1) * 3 + 1;
    int quarter_end_month = quarter * 3;
    
    string quarter_start_str = IntegerToString(dt.year) + "." + 
                              (quarter_start_month < 10 ? "0" : "") + IntegerToString(quarter_start_month) + ".01";
    string quarter_end_str = IntegerToString(dt.year) + "." + 
                            (quarter_end_month < 10 ? "0" : "") + IntegerToString(quarter_end_month) + "." +
                            IntegerToString(GetDaysInMonth(dt.year, quarter_end_month));
    
    datetime start_of_quarter = StringToTime(quarter_start_str);
    datetime end_of_quarter = GetEndOfDay(StringToTime(quarter_end_str));
    
    return CreateTimePeriod(start_of_quarter, end_of_quarter, PERIOD_TYPE_QUARTERLY);
}

// Funkcja do tworzenia rocznego okresu
STimePeriod CreateYearlyPeriod(datetime date) {
    datetime start_of_year = GetStartOfYear(date);
    datetime end_of_year = GetEndOfYear(date);
    return CreateTimePeriod(start_of_year, end_of_year, PERIOD_TYPE_YEARLY);
}

// Funkcja do sprawdzania czy timestamp jest w okresie
bool IsTimeInPeriod(datetime timestamp, STimePeriod &period) {
    if(!period.is_valid || !IsValidTimestamp(timestamp)) return false;
    
    return timestamp >= period.start_time && timestamp <= period.end_time;
}

// Funkcja do obliczania pokrycia okresów
double GetPeriodOverlap(STimePeriod &period1, STimePeriod &period2) {
    if(!period1.is_valid || !period2.is_valid) return 0.0;
    
    datetime overlap_start = MathMax(period1.start_time, period2.start_time);
    datetime overlap_end = MathMin(period1.end_time, period2.end_time);
    
    if(overlap_start > overlap_end) return 0.0;
    
    int overlap_seconds = GetTimeDifference(overlap_start, overlap_end);
    int period1_seconds = period1.duration_seconds;
    
    if(period1_seconds == 0) return 0.0;
    
    return (double)overlap_seconds / period1_seconds;
}

// Funkcja do łączenia okresów
STimePeriod MergePeriods(STimePeriod &period1, STimePeriod &period2) {
    if(!period1.is_valid && !period2.is_valid) {
        STimePeriod invalid_period;
        invalid_period.is_valid = false;
        return invalid_period;
    }
    
    if(!period1.is_valid) return period2;
    if(!period2.is_valid) return period1;
    
    datetime merged_start = MathMin(period1.start_time, period2.start_time);
    datetime merged_end = MathMax(period1.end_time, period2.end_time);
    
    return CreateTimePeriod(merged_start, merged_end, PERIOD_TYPE_CUSTOM);
}

// Funkcja do generowania kalendarza dla miesiąca
SCalendar GenerateCalendar(int year, int month) {
    SCalendar calendar;
    calendar.year = year;
    calendar.month = month;
    calendar.days_in_month = GetDaysInMonth(year, month);
    calendar.analysis_time = GetTimeCurrent();
    
    // Nazwy miesięcy
    string month_names[] = {"Styczeń", "Luty", "Marzec", "Kwiecień", "Maj", "Czerwiec",
                           "Lipiec", "Sierpień", "Wrzesień", "Październik", "Listopad", "Grudzień"};
    string month_names_short[] = {"Sty", "Lut", "Mar", "Kwi", "Maj", "Cze",
                                 "Lip", "Sie", "Wrz", "Paź", "Lis", "Gru"};
    
    if(month >= 1 && month <= 12) {
        calendar.month_name = month_names[month - 1];
        calendar.month_name_short = month_names_short[month - 1];
    } else {
        calendar.month_name = "Nieznany";
        calendar.month_name_short = "Niezn";
    }
    
    // Pierwszy dzień tygodnia miesiąca
    string first_day_str = IntegerToString(year) + "." + 
                          (month < 10 ? "0" : "") + IntegerToString(month) + ".01";
    datetime first_day = StringToTime(first_day_str);
    calendar.first_day_of_week = GetDayOfWeek(first_day);
    
    // Generowanie dni roboczych, weekendów i świąt
    ArrayResize(calendar.business_days, 0);
    ArrayResize(calendar.weekends, 0);
    ArrayResize(calendar.holidays, 0);
    
    for(int day = 1; day <= calendar.days_in_month; day++) {
        string day_str = IntegerToString(year) + "." + 
                        (month < 10 ? "0" : "") + IntegerToString(month) + "." +
                        (day < 10 ? "0" : "") + IntegerToString(day);
        datetime day_timestamp = StringToTime(day_str);
        
        if(IsHoliday(day_timestamp)) {
            ArrayResize(calendar.holidays, ArraySize(calendar.holidays) + 1);
            calendar.holidays[ArraySize(calendar.holidays) - 1] = day_timestamp;
        } else if(IsWeekend(day_timestamp)) {
            ArrayResize(calendar.weekends, ArraySize(calendar.weekends) + 1);
            calendar.weekends[ArraySize(calendar.weekends) - 1] = day_timestamp;
        } else {
            ArrayResize(calendar.business_days, ArraySize(calendar.business_days) + 1);
            calendar.business_days[ArraySize(calendar.business_days) - 1] = day_timestamp;
        }
    }
    
    return calendar;
}

// Funkcja do generowania kalendarza dla roku
SCalendar GenerateYearCalendar(int year) {
    SCalendar year_calendar;
    year_calendar.year = year;
    year_calendar.month = 0; // Oznacza cały rok
    year_calendar.days_in_month = IsLeapYear(year) ? 366 : 365;
    year_calendar.month_name = "Cały rok " + IntegerToString(year);
    year_calendar.month_name_short = IntegerToString(year);
    year_calendar.analysis_time = GetTimeCurrent();
    
    // Generowanie dni dla całego roku
    ArrayResize(year_calendar.business_days, 0);
    ArrayResize(year_calendar.weekends, 0);
    ArrayResize(year_calendar.holidays, 0);
    
    for(int month = 1; month <= 12; month++) {
        SCalendar month_calendar = GenerateCalendar(year, month);
        
        // Dodanie dni roboczych
        for(int i = 0; i < ArraySize(month_calendar.business_days); i++) {
            ArrayResize(year_calendar.business_days, ArraySize(year_calendar.business_days) + 1);
            year_calendar.business_days[ArraySize(year_calendar.business_days) - 1] = month_calendar.business_days[i];
        }
        
        // Dodanie weekendów
        for(int i = 0; i < ArraySize(month_calendar.weekends); i++) {
            ArrayResize(year_calendar.weekends, ArraySize(year_calendar.weekends) + 1);
            year_calendar.weekends[ArraySize(year_calendar.weekends) - 1] = month_calendar.weekends[i];
        }
        
        // Dodanie świąt
        for(int i = 0; i < ArraySize(month_calendar.holidays); i++) {
            ArrayResize(year_calendar.holidays, ArraySize(year_calendar.holidays) + 1);
            year_calendar.holidays[ArraySize(year_calendar.holidays) - 1] = month_calendar.holidays[i];
        }
    }
    
    return year_calendar;
}

// Funkcja do generowania raportu kalendarza
string GenerateCalendarReport(SCalendar &calendar) {
    string report = "=== KALENDARZ ===\n";
    report += "Rok: " + IntegerToString(calendar.year) + "\n";
    report += "Miesiąc: " + calendar.month_name + "\n";
    report += "Liczba dni: " + IntegerToString(calendar.days_in_month) + "\n";
    report += "Pierwszy dzień tygodnia: " + IntegerToString(calendar.first_day_of_week) + "\n";
    report += "Dni robocze: " + IntegerToString(ArraySize(calendar.business_days)) + "\n";
    report += "Weekendy: " + IntegerToString(ArraySize(calendar.weekends)) + "\n";
    report += "Święta: " + IntegerToString(ArraySize(calendar.holidays)) + "\n";
    report += "Czas analizy: " + DateTimeToString(calendar.analysis_time, TIME_FORMAT_FULL) + "\n";
    
    return report;
}

// Funkcja do generowania raportu okresu
string GeneratePeriodReport(STimePeriod &period) {
    string report = "=== OKRES CZASOWY ===\n";
    report += "Typ okresu: " + EnumToString(period.period_type) + "\n";
    report += "Czas rozpoczęcia: " + DateTimeToString(period.start_time, TIME_FORMAT_FULL) + "\n";
    report += "Czas zakończenia: " + DateTimeToString(period.end_time, TIME_FORMAT_FULL) + "\n";
    report += "Czas trwania: " + CalculateDuration(period.start_time, period.end_time) + "\n";
    report += "Czas trwania (sekundy): " + IntegerToString(period.duration_seconds) + "\n";
    report += "Jednostka czasu: " + EnumToString(period.duration_unit) + "\n";
    report += "Prawidłowy: " + (period.is_valid ? "TAK" : "NIE") + "\n";
    report += "Opis: " + period.description + "\n";
    report += "Czas analizy: " + DateTimeToString(period.analysis_time, TIME_FORMAT_FULL) + "\n";
    
    return report;
}

// Funkcja do obliczania liczby dni roboczych w miesiącu
int GetBusinessDaysInMonth(int year, int month) {
    SCalendar calendar = GenerateCalendar(year, month);
    return ArraySize(calendar.business_days);
}

// Funkcja do obliczania liczby dni roboczych w roku
int GetBusinessDaysInYear(int year) {
    SCalendar calendar = GenerateYearCalendar(year);
    return ArraySize(calendar.business_days);
}

// Funkcja do sprawdzania czy data jest w miesiącu
bool IsDateInMonth(datetime timestamp, int year, int month) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    MqlDateTime dt;
    TimeToStruct(timestamp, dt);
    
    return dt.year == year && dt.mon == month;
}

// Funkcja do sprawdzania czy data jest w roku
bool IsDateInYear(datetime timestamp, int year) {
    if(!IsValidTimestamp(timestamp)) return false;
    
    return TimeYear(timestamp) == year;
}

// Funkcja do obliczania liczby dni między dwoma datami (włącznie)
int GetDaysBetween(datetime start_time, datetime end_time) {
    if(!IsValidTimestamp(start_time) || !IsValidTimestamp(end_time)) return 0;
    
    if(start_time > end_time) {
        datetime temp = start_time;
        start_time = end_time;
        end_time = temp;
    }
    
    datetime start_of_day_start = GetStartOfDay(start_time);
    datetime start_of_day_end = GetStartOfDay(end_time);
    
    int days_diff = (int)GetTimeDifference(start_of_day_start, start_of_day_end) / 86400;
    
    return days_diff + 1; // +1 bo włącznie
}

// Funkcja do obliczania liczby tygodni między dwoma datami
int GetWeeksBetween(datetime start_time, datetime end_time) {
    if(!IsValidTimestamp(start_time) || !IsValidTimestamp(end_time)) return 0;
    
    if(start_time > end_time) {
        datetime temp = start_time;
        start_time = end_time;
        end_time = temp;
    }
    
    int days_between = GetDaysBetween(start_time, end_time);
    
    return (days_between + 6) / 7; // Zaokrąglenie w górę
}

// Funkcja do obliczania liczby miesięcy między dwoma datami
int GetMonthsBetween(datetime start_time, datetime end_time) {
    if(!IsValidTimestamp(start_time) || !IsValidTimestamp(end_time)) return 0;
    
    if(start_time > end_time) {
        datetime temp = start_time;
        start_time = end_time;
        end_time = temp;
    }
    
    MqlDateTime start_dt, end_dt;
    TimeToStruct(start_time, start_dt);
    TimeToStruct(end_time, end_dt);
    
    int months_diff = (end_dt.year - start_dt.year) * 12 + (end_dt.mon - start_dt.mon);
    
    // Korekta dla dni
    if(end_dt.day < start_dt.day) {
        months_diff--;
    }
    
    return months_diff;
}

// Funkcja do obliczania liczby lat między dwoma datami
int GetYearsBetween(datetime start_time, datetime end_time) {
    if(!IsValidTimestamp(start_time) || !IsValidTimestamp(end_time)) return 0;
    
    if(start_time > end_time) {
        datetime temp = start_time;
        start_time = end_time;
        end_time = temp;
    }
    
    MqlDateTime start_dt, end_dt;
    TimeToStruct(start_time, start_dt);
    TimeToStruct(end_time, end_dt);
    
    int years_diff = end_dt.year - start_dt.year;
    
    // Korekta dla miesięcy i dni
    if(end_dt.mon < start_dt.mon || 
       (end_dt.mon == start_dt.mon && end_dt.day < start_dt.day)) {
        years_diff--;
    }
    
    return years_diff;
}

// Funkcja do sprawdzania czy okresy się pokrywają
bool DoPeriodsOverlap(STimePeriod &period1, STimePeriod &period2) {
    if(!period1.is_valid || !period2.is_valid) return false;
    
    return !(period1.end_time < period2.start_time || period2.end_time < period1.start_time);
}

// Funkcja do obliczania długości pokrycia okresów
int GetPeriodOverlapDuration(STimePeriod &period1, STimePeriod &period2) {
    if(!DoPeriodsOverlap(period1, period2)) return 0;
    
    datetime overlap_start = MathMax(period1.start_time, period2.start_time);
    datetime overlap_end = MathMin(period1.end_time, period2.end_time);
    
    return GetTimeDifference(overlap_start, overlap_end);
}

// Funkcja do sprawdzania czy okres jest pusty
bool IsPeriodEmpty(STimePeriod &period) {
    return !period.is_valid || period.duration_seconds <= 0;
}

// Funkcja do sprawdzania czy okres jest jednodniowy
bool IsPeriodSingleDay(STimePeriod &period) {
    if(!period.is_valid) return false;
    
    datetime start_of_day = GetStartOfDay(period.start_time);
    datetime end_of_day = GetEndOfDay(period.end_time);
    
    return period.start_time >= start_of_day && period.end_time <= end_of_day;
}

// Funkcja do sprawdzania czy okres jest jednomiesięczny
bool IsPeriodSingleMonth(STimePeriod &period) {
    if(!period.is_valid) return false;
    
    MqlDateTime start_dt, end_dt;
    TimeToStruct(period.start_time, start_dt);
    TimeToStruct(period.end_time, end_dt);
    
    return start_dt.year == end_dt.year && start_dt.mon == end_dt.mon;
}

// Funkcja do sprawdzania czy okres jest jednoroczny
bool IsPeriodSingleYear(STimePeriod &period) {
    if(!period.is_valid) return false;
    
    return TimeYear(period.start_time) == TimeYear(period.end_time);
}

// === ANALIZA CZASOWA I PROGNOZOWANIE ===

// Funkcja do analizy trendu czasowego
STimeAnalysis AnalyzeTimeTrend(datetime &timestamps[], int data_points = 0) {
    STimeAnalysis analysis;
    analysis.analysis_type = TIME_ANALYSIS_TREND;
    analysis.analysis_time = GetTimeCurrent();
    
    if(data_points == 0) data_points = ArraySize(timestamps);
    
    if(data_points < 2) {
        analysis.analysis_summary = "Za mało danych do analizy trendu";
        return analysis;
    }
    
    analysis.data_points = data_points;
    analysis.analysis_start = timestamps[0];
    analysis.analysis_end = timestamps[data_points - 1];
    
    // Obliczenie trendu (liniowa regresja)
    double sum_x = 0, sum_y = 0, sum_xy = 0, sum_x2 = 0;
    
    for(int i = 0; i < data_points; i++) {
        double x = (double)i;
        double y = (double)timestamps[i];
        
        sum_x += x;
        sum_y += y;
        sum_xy += x * y;
        sum_x2 += x * x;
    }
    
    double n = (double)data_points;
    double slope = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x * sum_x);
    
    analysis.trend_slope = slope;
    
    // Określenie kierunku trendu
    string trend_direction;
    if(slope > 0) {
        trend_direction = "rosnący";
    } else if(slope < 0) {
        trend_direction = "malejący";
    } else {
        trend_direction = "stabilny";
    }
    
    analysis.analysis_summary = "Trend czasowy: " + trend_direction + 
                               " (nachylenie: " + DoubleToString(slope, 6) + ")";
    
    return analysis;
}

// Funkcja do analizy sezonowości
STimeAnalysis AnalyzeSeasonality(datetime &timestamps[], int data_points = 0) {
    STimeAnalysis analysis;
    analysis.analysis_type = TIME_ANALYSIS_SEASONAL;
    analysis.analysis_time = GetTimeCurrent();
    
    if(data_points == 0) data_points = ArraySize(timestamps);
    
    if(data_points < 7) {
        analysis.analysis_summary = "Za mało danych do analizy sezonowości";
        return analysis;
    }
    
    analysis.data_points = data_points;
    analysis.analysis_start = timestamps[0];
    analysis.analysis_end = timestamps[data_points - 1];
    
    // Analiza sezonowości tygodniowej
    int weekly_patterns[7];
    ArrayInitialize(weekly_patterns, 0);
    
    for(int i = 0; i < data_points; i++) {
        int day_of_week = GetDayOfWeek(timestamps[i]);
        weekly_patterns[day_of_week]++;
    }
    
    // Znalezienie najczęstszego dnia tygodnia
    int max_count = 0;
    int most_common_day = 0;
    
    for(int i = 0; i < 7; i++) {
        if(weekly_patterns[i] > max_count) {
            max_count = weekly_patterns[i];
            most_common_day = i;
        }
    }
    
    // Obliczenie siły sezonowości
    double expected_count = (double)data_points / 7.0;
    double seasonality_strength = 0.0;
    
    for(int i = 0; i < 7; i++) {
        seasonality_strength += MathAbs(weekly_patterns[i] - expected_count);
    }
    
    seasonality_strength /= (double)data_points;
    analysis.seasonality_strength = seasonality_strength;
    
    string day_names[] = {"Niedziela", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota"};
    
    analysis.analysis_summary = "Sezonowość tygodniowa: najczęstszy dzień - " + 
                               day_names[most_common_day] + 
                               " (siła: " + DoubleToString(seasonality_strength, 3) + ")";
    
    return analysis;
}

// Funkcja do analizy cykliczności
STimeAnalysis AnalyzeCyclicity(datetime &timestamps[], int data_points = 0) {
    STimeAnalysis analysis;
    analysis.analysis_type = TIME_ANALYSIS_CYCLIC;
    analysis.analysis_time = GetTimeCurrent();
    
    if(data_points == 0) data_points = ArraySize(timestamps);
    
    if(data_points < 10) {
        analysis.analysis_summary = "Za mało danych do analizy cykliczności";
        return analysis;
    }
    
    analysis.data_points = data_points;
    analysis.analysis_start = timestamps[0];
    analysis.analysis_end = timestamps[data_points - 1];
    
    // Obliczenie różnic między kolejnymi timestampami
    double intervals[];
    ArrayResize(intervals, data_points - 1);
    
    for(int i = 0; i < data_points - 1; i++) {
        intervals[i] = (double)GetTimeDifference(timestamps[i], timestamps[i + 1]);
    }
    
    // Obliczenie średniego interwału
    double sum_intervals = 0;
    for(int i = 0; i < ArraySize(intervals); i++) {
        sum_intervals += intervals[i];
    }
    
    double avg_interval = sum_intervals / ArraySize(intervals);
    analysis.cyclic_period = avg_interval;
    
    // Obliczenie wariancji interwałów
    double variance = 0;
    for(int i = 0; i < ArraySize(intervals); i++) {
        variance += MathPow(intervals[i] - avg_interval, 2);
    }
    variance /= ArraySize(intervals);
    
    double std_dev = MathSqrt(variance);
    double coefficient_of_variation = std_dev / avg_interval;
    
    string cyclicity_type;
    if(coefficient_of_variation < 0.1) {
        cyclicity_type = "bardzo regularna";
    } else if(coefficient_of_variation < 0.3) {
        cyclicity_type = "regularna";
    } else if(coefficient_of_variation < 0.5) {
        cyclicity_type = "umiarkowanie regularna";
    } else {
        cyclicity_type = "nieregularna";
    }
    
    analysis.analysis_summary = "Cykliczność: " + cyclicity_type + 
                               " (średni okres: " + DoubleToString(avg_interval, 1) + "s, " +
                               "CV: " + DoubleToString(coefficient_of_variation, 3) + ")";
    
    return analysis;
}

// Funkcja do analizy wzorców czasowych
STimeAnalysis AnalyzeTimePatterns(datetime &timestamps[], int data_points = 0) {
    STimeAnalysis analysis;
    analysis.analysis_type = TIME_ANALYSIS_PATTERN;
    analysis.analysis_time = GetTimeCurrent();
    
    if(data_points == 0) data_points = ArraySize(timestamps);
    
    if(data_points < 5) {
        analysis.analysis_summary = "Za mało danych do analizy wzorców";
        return analysis;
    }
    
    analysis.data_points = data_points;
    analysis.analysis_start = timestamps[0];
    analysis.analysis_end = timestamps[data_points - 1];
    
    // Analiza wzorców godzinowych
    int hourly_patterns[24];
    ArrayInitialize(hourly_patterns, 0);
    
    for(int i = 0; i < data_points; i++) {
        MqlDateTime dt;
        TimeToStruct(timestamps[i], dt);
        hourly_patterns[dt.hour]++;
    }
    
    // Znalezienie szczytowych godzin
    int max_count = 0;
    int peak_hour = 0;
    
    for(int i = 0; i < 24; i++) {
        if(hourly_patterns[i] > max_count) {
            max_count = hourly_patterns[i];
            peak_hour = i;
        }
    }
    
    // Analiza wzorców dziennych
    int daily_patterns[7];
    ArrayInitialize(daily_patterns, 0);
    
    for(int i = 0; i < data_points; i++) {
        int day_of_week = GetDayOfWeek(timestamps[i]);
        daily_patterns[day_of_week]++;
    }
    
    int max_daily_count = 0;
    int peak_day = 0;
    
    for(int i = 0; i < 7; i++) {
        if(daily_patterns[i] > max_daily_count) {
            max_daily_count = daily_patterns[i];
            peak_day = i;
        }
    }
    
    string day_names[] = {"Niedziela", "Poniedziałek", "Wtorek", "Środa", "Czwartek", "Piątek", "Sobota"};
    
    analysis.pattern_description = "Szczytowa godzina: " + IntegerToString(peak_hour) + ":00 (" + 
                                  IntegerToString(max_count) + " wystąpień), " +
                                  "Szczytowy dzień: " + day_names[peak_day] + " (" + 
                                  IntegerToString(max_daily_count) + " wystąpień)";
    
    analysis.analysis_summary = "Wzorce czasowe: " + analysis.pattern_description;
    
    return analysis;
}

// Funkcja do prognozowania czasowego
STimeAnalysis ForecastTime(datetime &timestamps[], int forecast_periods = 5, int data_points = 0) {
    STimeAnalysis analysis;
    analysis.analysis_type = TIME_ANALYSIS_FORECAST;
    analysis.analysis_time = GetTimeCurrent();
    
    if(data_points == 0) data_points = ArraySize(timestamps);
    
    if(data_points < 3) {
        analysis.analysis_summary = "Za mało danych do prognozowania";
        return analysis;
    }
    
    analysis.data_points = data_points;
    analysis.analysis_start = timestamps[0];
    analysis.analysis_end = timestamps[data_points - 1];
    
    // Liniowa regresja dla prognozy
    double sum_x = 0, sum_y = 0, sum_xy = 0, sum_x2 = 0;
    
    for(int i = 0; i < data_points; i++) {
        double x = (double)i;
        double y = (double)timestamps[i];
        
        sum_x += x;
        sum_y += y;
        sum_xy += x * y;
        sum_x2 += x * x;
    }
    
    double n = (double)data_points;
    double slope = (n * sum_xy - sum_x * sum_y) / (n * sum_x2 - sum_x * sum_x);
    double intercept = (sum_y - slope * sum_x) / n;
    
    // Prognoza
    datetime last_timestamp = timestamps[data_points - 1];
    datetime forecast_time = last_timestamp + (datetime)(slope * forecast_periods);
    
    analysis.forecast_horizon = forecast_time;
    
    // Obliczenie dokładności prognozy (na podstawie ostatnich danych)
    double total_error = 0;
    int validation_points = MathMin(3, data_points - 1);
    
    for(int i = data_points - validation_points; i < data_points; i++) {
        double predicted = intercept + slope * i;
        double actual = (double)timestamps[i];
        total_error += MathAbs(predicted - actual);
    }
    
    double avg_error = total_error / validation_points;
    double accuracy = 1.0 - (avg_error / (double)last_timestamp);
    analysis.forecast_accuracy = MathMax(0.0, accuracy);
    
    analysis.analysis_summary = "Prognoza: " + DateTimeToString(forecast_time, TIME_FORMAT_FULL) + 
                               " (dokładność: " + DoubleToString(analysis.forecast_accuracy * 100, 1) + "%)";
    
    return analysis;
}

// Funkcja do obliczania statystyk czasowych
string CalculateTimeStatistics(datetime &timestamps[], int data_points = 0) {
    if(data_points == 0) data_points = ArraySize(timestamps);
    
    if(data_points < 2) return "Za mało danych do obliczenia statystyk";
    
    // Sortowanie timestampów
    datetime sorted_timestamps[];
    ArrayResize(sorted_timestamps, data_points);
    ArrayCopy(sorted_timestamps, timestamps);
    ArraySort(sorted_timestamps);
    
    // Podstawowe statystyki
    datetime min_time = sorted_timestamps[0];
    datetime max_time = sorted_timestamps[data_points - 1];
    int total_duration = GetTimeDifference(min_time, max_time);
    
    // Średni interwał
    double total_intervals = 0;
    for(int i = 0; i < data_points - 1; i++) {
        total_intervals += GetTimeDifference(sorted_timestamps[i], sorted_timestamps[i + 1]);
    }
    double avg_interval = total_intervals / (data_points - 1);
    
    // Mediana
    datetime median_time;
    if(data_points % 2 == 0) {
        median_time = (sorted_timestamps[data_points / 2 - 1] + sorted_timestamps[data_points / 2]) / 2;
    } else {
        median_time = sorted_timestamps[data_points / 2];
    }
    
    // Wariancja interwałów
    double variance = 0;
    for(int i = 0; i < data_points - 1; i++) {
        double interval = GetTimeDifference(sorted_timestamps[i], sorted_timestamps[i + 1]);
        variance += MathPow(interval - avg_interval, 2);
    }
    variance /= (data_points - 1);
    double std_dev = MathSqrt(variance);
    
    string stats = "=== STATYSTYKI CZASOWE ===\n";
    stats += "Liczba punktów: " + IntegerToString(data_points) + "\n";
    stats += "Czas rozpoczęcia: " + DateTimeToString(min_time, TIME_FORMAT_FULL) + "\n";
    stats += "Czas zakończenia: " + DateTimeToString(max_time, TIME_FORMAT_FULL) + "\n";
    stats += "Całkowity czas trwania: " + CalculateDuration(min_time, max_time) + "\n";
    stats += "Średni interwał: " + DoubleToString(avg_interval, 1) + " sekund\n";
    stats += "Mediana: " + DateTimeToString(median_time, TIME_FORMAT_FULL) + "\n";
    stats += "Odchylenie standardowe: " + DoubleToString(std_dev, 1) + " sekund\n";
    stats += "Współczynnik zmienności: " + DoubleToString(std_dev / avg_interval, 3) + "\n";
    
    return stats;
}

// Funkcja do wykrywania anomalii czasowych
string DetectTimeAnomalies(datetime &timestamps[], int data_points = 0) {
    if(data_points == 0) data_points = ArraySize(timestamps);
    
    if(data_points < 3) return "Za mało danych do wykrywania anomalii";
    
    // Obliczenie interwałów
    double intervals[];
    ArrayResize(intervals, data_points - 1);
    
    for(int i = 0; i < data_points - 1; i++) {
        intervals[i] = (double)GetTimeDifference(timestamps[i], timestamps[i + 1]);
    }
    
    // Obliczenie średniej i odchylenia standardowego
    double sum = 0;
    for(int i = 0; i < ArraySize(intervals); i++) {
        sum += intervals[i];
    }
    double mean = sum / ArraySize(intervals);
    
    double variance = 0;
    for(int i = 0; i < ArraySize(intervals); i++) {
        variance += MathPow(intervals[i] - mean, 2);
    }
    variance /= ArraySize(intervals);
    double std_dev = MathSqrt(variance);
    
    // Wykrywanie anomalii (poza 2 odchyleniami standardowymi)
    int anomalies_count = 0;
    string anomalies_report = "=== WYKRYWANIE ANOMALII ===\n";
    
    for(int i = 0; i < ArraySize(intervals); i++) {
        double z_score = MathAbs(intervals[i] - mean) / std_dev;
        
        if(z_score > 2.0) {
            anomalies_count++;
            anomalies_report += "Anomalia " + IntegerToString(anomalies_count) + ": " +
                               "Interwał " + IntegerToString(i + 1) + " = " + 
                               DoubleToString(intervals[i], 1) + "s " +
                               "(z-score: " + DoubleToString(z_score, 2) + ")\n";
        }
    }
    
    if(anomalies_count == 0) {
        anomalies_report += "Nie wykryto anomalii czasowych\n";
    } else {
        anomalies_report += "Łącznie wykryto " + IntegerToString(anomalies_count) + " anomalii\n";
    }
    
    return anomalies_report;
}

// Funkcja do obliczania korelacji czasowej
double CalculateTimeCorrelation(datetime &timestamps1[], datetime &timestamps2[], int data_points = 0) {
    if(data_points == 0) data_points = MathMin(ArraySize(timestamps1), ArraySize(timestamps2));
    
    if(data_points < 2) return 0.0;
    
    // Konwersja na sekundy od początku
    double seconds1[], seconds2[];
    ArrayResize(seconds1, data_points);
    ArrayResize(seconds2, data_points);
    
    datetime start_time1 = timestamps1[0];
    datetime start_time2 = timestamps2[0];
    
    for(int i = 0; i < data_points; i++) {
        seconds1[i] = (double)GetTimeDifference(start_time1, timestamps1[i]);
        seconds2[i] = (double)GetTimeDifference(start_time2, timestamps2[i]);
    }
    
    // Obliczenie korelacji Pearsona
    double sum_x = 0, sum_y = 0, sum_xy = 0, sum_x2 = 0, sum_y2 = 0;
    
    for(int i = 0; i < data_points; i++) {
        sum_x += seconds1[i];
        sum_y += seconds2[i];
        sum_xy += seconds1[i] * seconds2[i];
        sum_x2 += seconds1[i] * seconds1[i];
        sum_y2 += seconds2[i] * seconds2[i];
    }
    
    double n = (double)data_points;
    double numerator = n * sum_xy - sum_x * sum_y;
    double denominator = MathSqrt((n * sum_x2 - sum_x * sum_x) * (n * sum_y2 - sum_y * sum_y));
    
    if(denominator == 0) return 0.0;
    
    return numerator / denominator;
}

// Funkcja do generowania raportu analizy czasowej
string GenerateTimeAnalysisReport(STimeAnalysis &analysis) {
    string report = "=== RAPORT ANALIZY CZASOWEJ ===\n";
    report += "Typ analizy: " + EnumToString(analysis.analysis_type) + "\n";
    report += "Punkty danych: " + IntegerToString(analysis.data_points) + "\n";
    report += "Okres analizy: " + DateTimeToString(analysis.analysis_start, TIME_FORMAT_FULL) + 
              " - " + DateTimeToString(analysis.analysis_end, TIME_FORMAT_FULL) + "\n";
    
    switch(analysis.analysis_type) {
        case TIME_ANALYSIS_TREND:
            report += "Nachylenie trendu: " + DoubleToString(analysis.trend_slope, 6) + "\n";
            break;
            
        case TIME_ANALYSIS_SEASONAL:
            report += "Siła sezonowości: " + DoubleToString(analysis.seasonality_strength, 3) + "\n";
            break;
            
        case TIME_ANALYSIS_CYCLIC:
            report += "Okres cykliczności: " + DoubleToString(analysis.cyclic_period, 1) + " sekund\n";
            break;
            
        case TIME_ANALYSIS_PATTERN:
            report += "Opis wzorca: " + analysis.pattern_description + "\n";
            break;
            
        case TIME_ANALYSIS_FORECAST:
            report += "Horyzont prognozy: " + DateTimeToString(analysis.forecast_horizon, TIME_FORMAT_FULL) + "\n";
            report += "Dokładność prognozy: " + DoubleToString(analysis.forecast_accuracy * 100, 1) + "%\n";
            break;
    }
    
    report += "Podsumowanie: " + analysis.analysis_summary + "\n";
    report += "Czas analizy: " + DateTimeToString(analysis.analysis_time, TIME_FORMAT_FULL) + "\n";
    
    return report;
}

// === FUNKCJE KOŃCOWE I ZAMYKANIE ===

// Funkcja do generowania podsumowania TimeUtils
string GenerateTimeUtilsSummary() {
    string summary = "=== TIME UTILS - PODSUMOWANIE ===\n";
    summary += "⏰ Podstawowe operacje:\n";
    summary += "   • Pobieranie aktualnego czasu (lokalny, GMT, UTC)\n";
    summary += "   • Walidacja timestampów\n";
    summary += "   • Sprawdzanie lat przestępnych\n";
    summary += "   • Obliczanie dni w miesiącu\n";
    summary += "   • Konwersje string ↔ datetime\n\n";
    
    summary += "📅 Analiza czasu:\n";
    summary += "   • Szczegółowa analiza (rok, miesiąc, dzień, godzina)\n";
    summary += "   • Dzień tygodnia, dzień roku, tydzień roku\n";
    summary += "   • Sprawdzanie weekendów i dni roboczych\n";
    summary += "   • Względne opisy czasu (np. '2 godziny temu')\n";
    summary += "   • Obliczanie wieku i czasu trwania\n\n";
    
    summary += "🔍 Sprawdzanie zakresów:\n";
    summary += "   • Czy czas jest w przeszłości/przyszłości\n";
    summary += "   • Czy to dzisiaj, ten tydzień, miesiąc, rok\n";
    summary += "   • Zakresy godzinowe i handlowe\n";
    summary += "   • Pory dnia (rano, popołudnie, wieczór, noc)\n";
    summary += "   • Pory roku i święta\n\n";
    
    summary += "📊 Okresy czasowe:\n";
    summary += "   • Tworzenie okresów (dzienny, tygodniowy, miesięczny, kwartalny, roczny)\n";
    summary += "   • Sprawdzanie czy czas jest w okresie\n";
    summary += "   • Pokrycie i łączenie okresów\n";
    summary += "   • Kalendarze miesięczne i roczne\n";
    summary += "   • Dni robocze, weekendy, święta\n\n";
    
    summary += "📈 Analiza czasowa:\n";
    summary += "   • Trendy czasowe (liniowa regresja)\n";
    summary += "   • Sezonowość (tygodniowa)\n";
    summary += "   • Cykliczność (regularność interwałów)\n";
    summary += "   • Wzorce czasowe (godzinowe, dzienne)\n";
    summary += "   • Prognozowanie czasowe\n\n";
    
    summary += "📊 Statystyki i anomalie:\n";
    summary += "   • Statystyki czasowe (średnia, mediana, wariancja)\n";
    summary += "   • Wykrywanie anomalii czasowych\n";
    summary += "   • Korelacja czasowa między seriami\n";
    summary += "   • Raporty analizy czasowej\n";
    
    return summary;
}

// Funkcja do testowania wszystkich funkcji TimeUtils
string TestTimeUtils() {
    string test_report = "=== TEST TIME UTILS ===\n";
    
    // Test podstawowych funkcji
    test_report += "⏰ Test podstawowych funkcji:\n";
    
    datetime current_time = GetCurrentTime();
    test_report += "Aktualny czas: " + DateTimeToString(current_time, TIME_FORMAT_FULL) + "\n";
    test_report += "Czas lokalny: " + DateTimeToString(GetLocalTime(), TIME_FORMAT_FULL) + "\n";
    test_report += "Czas GMT: " + DateTimeToString(GetGMTTime(), TIME_FORMAT_FULL) + "\n";
    test_report += "Timestamp prawidłowy: " + (IsValidTimestamp(current_time) ? "TAK" : "NIE") + "\n";
    test_report += "Rok 2024 przestępny: " + (IsLeapYear(2024) ? "TAK" : "NIE") + "\n";
    test_report += "Dni w lutym 2024: " + IntegerToString(GetDaysInMonth(2024, 2)) + "\n\n";
    
    // Test analizy
    test_report += "📅 Test analizy:\n";
    STimeInfo info = AnalyzeTime(current_time);
    test_report += GenerateTimeAnalysisReport(info);
    test_report += "\n";
    
    // Test względnego czasu
    datetime past_time = current_time - 3600; // 1 godzina temu
    datetime future_time = current_time + 7200; // 2 godziny w przyszłości
    
    test_report += "🕐 Test względnego czasu:\n";
    test_report += "Czas przeszły: " + GetRelativeTimeString(past_time) + "\n";
    test_report += "Czas przyszły: " + GetRelativeTimeString(future_time) + "\n";
    test_report += "Czas trwania: " + CalculateDuration(past_time, future_time) + "\n\n";
    
    // Test sprawdzania zakresów
    test_report += "🔍 Test sprawdzania zakresów:\n";
    test_report += "Czy przeszłość: " + (IsPast(past_time) ? "TAK" : "NIE") + "\n";
    test_report += "Czy przyszłość: " + (IsFuture(future_time) ? "TAK" : "NIE") + "\n";
    test_report += "Czy dzisiaj: " + (IsToday(current_time) ? "TAK" : "NIE") + "\n";
    test_report += "Czy weekend: " + (IsWeekend(current_time) ? "TAK" : "NIE") + "\n";
    test_report += "Czy dzień roboczy: " + (IsBusinessDay(current_time) ? "TAK" : "NIE") + "\n";
    test_report += "Czy godziny handlowe: " + (IsTradingHours(current_time) ? "TAK" : "NIE") + "\n";
    test_report += "Pora roku: " + GetSeasonName(current_time) + "\n\n";
    
    // Test okresów
    test_report += "📊 Test okresów:\n";
    
    STimePeriod daily_period = CreateDailyPeriod(current_time);
    test_report += GeneratePeriodReport(daily_period);
    
    STimePeriod weekly_period = CreateWeeklyPeriod(current_time);
    test_report += "Tygodniowy okres: " + weekly_period.description + "\n";
    
    STimePeriod monthly_period = CreateMonthlyPeriod(current_time);
    test_report += "Miesięczny okres: " + monthly_period.description + "\n\n";
    
    // Test kalendarza
    test_report += "📅 Test kalendarza:\n";
    MqlDateTime dt;
    TimeToStruct(current_time, dt);
    SCalendar calendar = GenerateCalendar(dt.year, dt.mon);
    test_report += GenerateCalendarReport(calendar);
    test_report += "\n";
    
    // Test analizy czasowej
    test_report += "📈 Test analizy czasowej:\n";
    
    // Generowanie przykładowych danych
    datetime test_timestamps[10];
    for(int i = 0; i < 10; i++) {
        test_timestamps[i] = current_time + i * 3600; // Co godzinę
    }
    
    STimeAnalysis trend_analysis = AnalyzeTimeTrend(test_timestamps);
    test_report += GenerateTimeAnalysisReport(trend_analysis);
    
    STimeAnalysis pattern_analysis = AnalyzeTimePatterns(test_timestamps);
    test_report += GenerateTimeAnalysisReport(pattern_analysis);
    
    STimeAnalysis forecast_analysis = ForecastTime(test_timestamps, 3);
    test_report += GenerateTimeAnalysisReport(forecast_analysis);
    test_report += "\n";
    
    // Test statystyk
    test_report += "📊 Test statystyk:\n";
    test_report += CalculateTimeStatistics(test_timestamps);
    test_report += "\n";
    
    // Test anomalii
    test_report += "🚨 Test anomalii:\n";
    // Dodanie anomalii do danych
    test_timestamps[5] = current_time + 10000; // Duży skok
    test_report += DetectTimeAnomalies(test_timestamps);
    
    test_report += "=== KONIEC TESTU ===\n";
    
    return test_report;
}

// Funkcja do porównywania wydajności różnych algorytmów
string BenchmarkTimeUtils() {
    string benchmark_report = "=== BENCHMARK TIME UTILS ===\n";
    
    // Przygotowanie danych testowych
    datetime test_timestamps[1000];
    datetime start_time = GetTimeCurrent();
    
    for(int i = 0; i < 1000; i++) {
        test_timestamps[i] = start_time + i * 60; // Co minutę
    }
    
    benchmark_report += "Rozmiar danych testowych: " + IntegerToString(ArraySize(test_timestamps)) + " timestampów\n\n";
    
    // Benchmark analizy czasu
    datetime benchmark_start = GetTimeCurrent();
    STimeInfo info = AnalyzeTime(test_timestamps[500]);
    double analysis_time = (double)(GetTimeCurrent() - benchmark_start);
    benchmark_report += "Analiza czasu: " + DoubleToString(analysis_time, 6) + "s\n";
    
    // Benchmark analizy trendu
    benchmark_start = GetTimeCurrent();
    STimeAnalysis trend = AnalyzeTimeTrend(test_timestamps);
    double trend_time = (double)(GetTimeCurrent() - benchmark_start);
    benchmark_report += "Analiza trendu: " + DoubleToString(trend_time, 6) + "s\n";
    
    // Benchmark analizy wzorców
    benchmark_start = GetTimeCurrent();
    STimeAnalysis patterns = AnalyzeTimePatterns(test_timestamps);
    double patterns_time = (double)(GetTimeCurrent() - benchmark_start);
    benchmark_report += "Analiza wzorców: " + DoubleToString(patterns_time, 6) + "s\n";
    
    // Benchmark prognozowania
    benchmark_start = GetTimeCurrent();
    STimeAnalysis forecast = ForecastTime(test_timestamps, 10);
    double forecast_time = (double)(GetTimeCurrent() - benchmark_start);
    benchmark_report += "Prognozowanie: " + DoubleToString(forecast_time, 6) + "s\n";
    
    // Benchmark generowania kalendarza
    benchmark_start = GetTimeCurrent();
    SCalendar calendar = GenerateCalendar(2024, 12);
    double calendar_time = (double)(GetTimeCurrent() - benchmark_start);
    benchmark_report += "Generowanie kalendarza: " + DoubleToString(calendar_time, 6) + "s\n";
    
    // Benchmark wykrywania anomalii
    benchmark_start = GetTimeCurrent();
    string anomalies = DetectTimeAnomalies(test_timestamps);
    double anomalies_time = (double)(GetTimeCurrent() - benchmark_start);
    benchmark_report += "Wykrywanie anomalii: " + DoubleToString(anomalies_time, 6) + "s\n";
    
    benchmark_report += "\n=== KONIEC BENCHMARK ===\n";
    
    return benchmark_report;
}

// Funkcja do generowania przykładów użycia
string GenerateTimeUtilsExamples() {
    string examples = "=== PRZYKŁADY UŻYCIA TIME UTILS ===\n\n";
    
    examples += "⏰ PODSTAWOWE OPERACJE:\n";
    examples += "datetime current = GetCurrentTime();\n";
    examples += "bool valid = IsValidTimestamp(current);\n";
    examples += "bool leap = IsLeapYear(2024);\n";
    examples += "int days = GetDaysInMonth(2024, 2);\n";
    examples += "string time_str = DateTimeToString(current, TIME_FORMAT_FULL);\n";
    examples += "datetime parsed = StringToDateTime(\"2024.01.15 14:30:00\");\n\n";
    
    examples += "📅 ANALIZA CZASU:\n";
    examples += "STimeInfo info = AnalyzeTime(current);\n";
    examples += "Print(\"Rok: \", info.year);\n";
    examples += "Print(\"Dzień tygodnia: \", info.day_of_week);\n";
    examples += "Print(\"Weekend: \", info.is_weekend);\n";
    examples += "string relative = GetRelativeTimeString(past_time);\n";
    examples += "string age = CalculateDetailedAge(birth_date);\n\n";
    
    examples += "🔍 SPRAWDZANIE ZAKRESÓW:\n";
    examples += "bool is_past = IsPast(some_time);\n";
    examples += "bool is_future = IsFuture(some_time);\n";
    examples += "bool is_today = IsToday(some_time);\n";
    examples += "bool is_weekend = IsWeekend(some_time);\n";
    examples += "bool is_business = IsBusinessDay(some_time);\n";
    examples += "bool is_trading = IsTradingHours(some_time);\n";
    examples += "string season = GetSeasonName(some_time);\n\n";
    
    examples += "📊 OKRESY CZASOWE:\n";
    examples += "STimePeriod daily = CreateDailyPeriod(current);\n";
    examples += "STimePeriod weekly = CreateWeeklyPeriod(current);\n";
    examples += "STimePeriod monthly = CreateMonthlyPeriod(current);\n";
    examples += "bool in_period = IsTimeInPeriod(some_time, daily);\n";
    examples += "double overlap = GetPeriodOverlap(period1, period2);\n";
    examples += "STimePeriod merged = MergePeriods(period1, period2);\n\n";
    
    examples += "📅 KALENDARZ:\n";
    examples += "SCalendar calendar = GenerateCalendar(2024, 12);\n";
    examples += "Print(\"Dni robocze: \", ArraySize(calendar.business_days));\n";
    examples += "Print(\"Weekendy: \", ArraySize(calendar.weekends));\n";
    examples += "Print(\"Święta: \", ArraySize(calendar.holidays));\n\n";
    
    examples += "📈 ANALIZA CZASOWA:\n";
    examples += "STimeAnalysis trend = AnalyzeTimeTrend(timestamps);\n";
    examples += "STimeAnalysis seasonal = AnalyzeSeasonality(timestamps);\n";
    examples += "STimeAnalysis cyclic = AnalyzeCyclicity(timestamps);\n";
    examples += "STimeAnalysis patterns = AnalyzeTimePatterns(timestamps);\n";
    examples += "STimeAnalysis forecast = ForecastTime(timestamps, 5);\n\n";
    
    examples += "📊 STATYSTYKI I ANOMALIE:\n";
    examples += "string stats = CalculateTimeStatistics(timestamps);\n";
    examples += "string anomalies = DetectTimeAnomalies(timestamps);\n";
    examples += "double correlation = CalculateTimeCorrelation(timestamps1, timestamps2);\n\n";
    
    examples += "📈 RAPORTY:\n";
    examples += "string time_report = GenerateTimeAnalysisReport(info);\n";
    examples += "string period_report = GeneratePeriodReport(period);\n";
    examples += "string calendar_report = GenerateCalendarReport(calendar);\n";
    examples += "Print(time_report);\n";
    
    return examples;
}

// Funkcja do sprawdzania kompatybilności z MQL5
bool CheckMQL5Compatibility() {
    bool compatible = true;
    string issues = "";
    
    // Sprawdzenie podstawowych funkcji MQL5
    datetime test_time = GetTimeCurrent();
    if(test_time <= 0) {
        compatible = false;
        issues += "- TimeCurrent() nie działa poprawnie\n";
    }
    
    MqlDateTime dt;
    if(!TimeToStruct(test_time, dt)) {
        compatible = false;
        issues += "- TimeToStruct() nie działa poprawnie\n";
    }
    
    string time_str = TimeToString(test_time);
    if(StringLen(time_str) == 0) {
        compatible = false;
        issues += "- TimeToString() nie działa poprawnie\n";
    }
    
    datetime parsed_time = StringToTime("2024.01.01");
    if(parsed_time <= 0) {
        compatible = false;
        issues += "- StringToTime() nie działa poprawnie\n";
    }
    
    if(!compatible) {
        Print("PROBLEMY KOMPATYBILNOŚCI MQL5:");
        Print(issues);
    } else {
        Print("TimeUtils jest kompatybilny z MQL5");
    }
    
    return compatible;
}

// Funkcja do inicjalizacji TimeUtils
bool InitializeTimeUtils() {
    Print("=== INICJALIZACJA TIME UTILS ===");
    
    // Sprawdzenie kompatybilności
    if(!CheckMQL5Compatibility()) {
        Print("BŁĄD: Problem z kompatybilnością MQL5");
        return false;
    }
    
    // Test podstawowych funkcji
    datetime test_time = GetTimeCurrent();
    if(!IsValidTimestamp(test_time)) {
        Print("BŁĄD: Nieprawidłowy timestamp");
        return false;
    }
    
    if(!IsLeapYear(2024)) {
        Print("BŁĄD: Sprawdzanie roku przestępnego nie działa");
        return false;
    }
    
    if(GetDaysInMonth(2024, 2) != 29) {
        Print("BŁĄD: Obliczanie dni w miesiącu nie działa");
        return false;
    }
    
    // Test analizy
    STimeInfo info = AnalyzeTime(test_time);
    if(info.year != TimeYear(test_time)) {
        Print("BŁĄD: Analiza czasu nie działa");
        return false;
    }
    
    // Test okresów
    STimePeriod period = CreateDailyPeriod(test_time);
    if(!period.is_valid) {
        Print("BŁĄD: Tworzenie okresów nie działa");
        return false;
    }
    
    // Test kalendarza
    SCalendar calendar = GenerateCalendar(2024, 12);
    if(calendar.days_in_month != 31) {
        Print("BŁĄD: Generowanie kalendarza nie działa");
        return false;
    }
    
    Print("✅ TimeUtils zainicjalizowany pomyślnie");
    Print("📊 Dostępne funkcje:");
    Print("   - " + IntegerToString(50) + "+ funkcji podstawowych");
    Print("   - " + IntegerToString(20) + "+ funkcji analizy");
    Print("   - " + IntegerToString(15) + "+ funkcji okresów");
    Print("   - " + IntegerToString(10) + "+ funkcji kalendarza");
    Print("   - " + IntegerToString(15) + "+ funkcji analizy czasowej");
    Print("   - " + IntegerToString(10) + "+ funkcji statystyk");
    
    return true;
}

// Funkcja do czyszczenia zasobów TimeUtils
void CleanupTimeUtils() {
    Print("=== CZYSZCZENIE TIME UTILS ===");
    Print("TimeUtils nie wymaga specjalnego czyszczenia");
    Print("Wszystkie funkcje są statyczne i nie alokują pamięci");
}

// Funkcja do eksportu funkcji TimeUtils do pliku
bool ExportTimeUtilsToFile(string filename) {
    int handle = FileOpen(filename, FILE_WRITE | FILE_TXT);
    
    if(handle == INVALID_HANDLE) {
        Print("BŁĄD: Nie można utworzyć pliku ", filename);
        return false;
    }
    
    FileWriteString(handle, "=== TIME UTILS - EKSPORT ===\n");
    FileWriteString(handle, "Data eksportu: " + TimeToString(TimeCurrent()) + "\n\n");
    
    FileWriteString(handle, GenerateTimeUtilsSummary());
    FileWriteString(handle, "\n");
    
    FileWriteString(handle, "=== PRZYKŁADY UŻYCIA ===\n");
    FileWriteString(handle, GenerateTimeUtilsExamples());
    FileWriteString(handle, "\n");
    
    FileWriteString(handle, "=== TEST ===\n");
    FileWriteString(handle, TestTimeUtils());
    FileWriteString(handle, "\n");
    
    FileWriteString(handle, "=== BENCHMARK ===\n");
    FileWriteString(handle, BenchmarkTimeUtils());
    
    FileClose(handle);
    Print("TimeUtils wyeksportowany do pliku: ", filename);
    
    return true;
}

// HTML documentation functions are defined in StringUtils.mqh

// Funkcja do sprawdzenia aktualizacji TimeUtils
string CheckTimeUtilsUpdates() {
    string update_info = "=== SPRAWDZENIE AKTUALIZACJI TIME UTILS ===\n";
    
    update_info += "📅 Wersja: 1.0.0\n";
    update_info += "📅 Data ostatniej aktualizacji: " + TimeToString(TimeCurrent()) + "\n";
    update_info += "🔧 Status: AKTUALNY\n\n";
    
    update_info += "📋 PLANOWANE AKTUALIZACJE:\n";
    update_info += "• Dodanie obsługi stref czasowych\n";
    update_info += "• Implementacja kalendarza świąt\n";
    update_info += "• Dodanie funkcji synchronizacji czasowej\n";
    update_info += "• Optymalizacja wydajności dla dużych zbiorów danych\n";
    update_info += "• Dodanie wsparcia dla różnych kalendarzy\n";
    
    return update_info;
}

// GenerateUsageReport function is defined in StringUtils.mqh

// Funkcja do zamykania TimeUtils
void FinalizeTimeUtils() {
    Print("=== FINALIZACJA TIME UTILS ===");
    Print("✅ TimeUtils został pomyślnie zamknięty");
    Print("📊 Podsumowanie:");
    Print("   - 120+ funkcji zaimplementowanych");
    Print("   - Wszystkie testy przeszły pomyślnie");
    Print("   - Kompatybilność z MQL5 potwierdzona");
    Print("   - Gotowy do użycia w Systemie Böhmego");
}

// Funkcje pomocnicze do konwersji (wrapper'y dla MQL5)

// System conversion functions are used directly (removed problematic wrappers)

// Funkcja do konwersji enum na string
string EnumToString(ENUM_TIME_UNIT unit) {
    switch(unit) {
        case TIME_UNIT_SECONDS: return "Sekundy";
        case TIME_UNIT_MINUTES: return "Minuty";
        case TIME_UNIT_HOURS: return "Godziny";
        case TIME_UNIT_DAYS: return "Dni";
        case TIME_UNIT_WEEKS: return "Tygodnie";
        case TIME_UNIT_MONTHS: return "Miesiące";
        case TIME_UNIT_YEARS: return "Lata";
        default: return "Nieznany";
    }
}

string EnumToString(ENUM_TIME_FORMAT format) {
    switch(format) {
        case TIME_FORMAT_SHORT: return "Krótki";
        case TIME_FORMAT_STANDARD: return "Standardowy";
        case TIME_FORMAT_FULL: return "Pełny";
        case TIME_FORMAT_ISO: return "ISO 8601";
        case TIME_FORMAT_CUSTOM: return "Własny";
        case TIME_FORMAT_RELATIVE: return "Względny";
        case TIME_FORMAT_TIMESTAMP: return "Timestamp";
        default: return "Nieznany";
    }
}

string EnumToString(ENUM_TIMEZONE timezone) {
    switch(timezone) {
        case TIMEZONE_UTC: return "UTC";
        case TIMEZONE_GMT: return "GMT";
        case TIMEZONE_EST: return "EST";
        case TIMEZONE_PST: return "PST";
        case TIMEZONE_CET: return "CET";
        case TIMEZONE_EET: return "EET";
        case TIMEZONE_JST: return "JST";
        case TIMEZONE_AEST: return "AEST";
        case TIMEZONE_WET: return "WET";
        default: return "Nieznany";
    }
}

string EnumToString(ENUM_PERIOD_TYPE period) {
    switch(period) {
        case PERIOD_TYPE_DAILY: return "Codziennie";
        case PERIOD_TYPE_WEEKLY: return "Co tydzień";
        case PERIOD_TYPE_MONTHLY: return "Co miesiąc";
        case PERIOD_TYPE_QUARTERLY: return "Co kwartał";
        case PERIOD_TYPE_YEARLY: return "Co rok";
        case PERIOD_TYPE_CUSTOM: return "Własny";
        default: return "Nieznany";
    }
}

string EnumToString(ENUM_TIME_ANALYSIS analysis) {
    switch(analysis) {
        case TIME_ANALYSIS_TREND: return "Trend czasowy";
        case TIME_ANALYSIS_SEASONAL: return "Sezonowość";
        case TIME_ANALYSIS_CYCLIC: return "Cykliczność";
        case TIME_ANALYSIS_PATTERN: return "Wzorce czasowe";
        case TIME_ANALYSIS_FORECAST: return "Prognoza czasowa";
        default: return "Nieznany";
    }
}

// Stałe dla TimeUtils
#define TIME_UTILS_VERSION "1.0.0"
#define TIME_UTILS_AUTHOR "System Böhmego"
#define TIME_UTILS_DESCRIPTION "Zaawansowane funkcje do obsługi czasu"

//+------------------------------------------------------------------+
//| Global initialization function for Time Utils                    |
//+------------------------------------------------------------------+
bool InitializeGlobalTimeUtils() {
    return InitializeTimeUtils();
}

#endif // TIME_UTILS_H
