#ifndef MATH_UTILS_H
#define MATH_UTILS_H

// ========================================
// MATH UTILS - FUNKCJE MATEMATYCZNE
// ========================================
// Zaawansowane funkcje matematyczne dla Systemu Böhmego
// Statystyki, analiza techniczna, optymalizacja i AI

#include <Math\Stat\Stat.mqh>
#include <Math\Alglib\alglib.mqh>

// === ENUMERACJE ===

// Typy rozkładów statystycznych
enum ENUM_DISTRIBUTION_TYPE {
    DISTRIBUTION_NORMAL,      // Rozkład normalny
    DISTRIBUTION_LOG_NORMAL,  // Rozkład logarytmiczno-normalny
    DISTRIBUTION_STUDENT_T,   // Rozkład t-Studenta
    DISTRIBUTION_CHI_SQUARE,  // Rozkład chi-kwadrat
    DISTRIBUTION_F,           // Rozkład F
    DISTRIBUTION_EXPONENTIAL, // Rozkład wykładniczy
    DISTRIBUTION_GAMMA,       // Rozkład gamma
    DISTRIBUTION_BETA,        // Rozkład beta
    DISTRIBUTION_WEIBULL,     // Rozkład Weibulla
    DISTRIBUTION_CAUCHY       // Rozkład Cauchy'ego
};

// Typy testów statystycznych
enum ENUM_STATISTICAL_TEST {
    TEST_T_STUDENT,           // Test t-Studenta
    TEST_WILCOXON,            // Test Wilcoxona
    TEST_KS,                  // Test Kołmogorowa-Smirnowa
    TEST_CHI_SQUARE,          // Test chi-kwadrat
    TEST_FISHER,              // Test Fishera
    TEST_ANDERSON_DARLING,    // Test Andersona-Darlinga
    TEST_SHAPIRO_WILK,        // Test Shapiro-Wilka
    TEST_JARQUE_BERA,         // Test Jarque-Bera
    TEST_DURBIN_WATSON,       // Test Durbina-Watsona
    TEST_BREUSCH_PAGAN        // Test Breusch-Pagan
};

// Typy optymalizacji
enum ENUM_OPTIMIZATION_METHOD {
    OPTIMIZATION_GRADIENT_DESCENT,    // Spadek gradientu
    OPTIMIZATION_NEWTON_RAPHSON,      // Newton-Raphson
    OPTIMIZATION_GENETIC_ALGORITHM,   // Algorytm genetyczny
    OPTIMIZATION_PARTICLE_SWARM,      // Rój cząstek
    OPTIMIZATION_SIMULATED_ANNEALING, // Symulowane wyżarzanie
    OPTIMIZATION_BRENT,               // Metoda Brenta
    OPTIMIZATION_GOLDEN_SECTION,      // Złoty podział
    OPTIMIZATION_BISECTION,           // Metoda bisekcji
    OPTIMIZATION_SECANT,              // Metoda siecznych
    OPTIMIZATION_LEVENBERG_MARQUARDT  // Levenberg-Marquardt
};

// === STRUKTURY DANYCH ===

// Struktura statystyk opisowych
struct SDescriptiveStats {
    int sample_size;          // Rozmiar próby
    double mean;              // Średnia
    double median;            // Mediana
    double mode;              // Dominanta
    double variance;          // Wariancja
    double standard_deviation; // Odchylenie standardowe
    double skewness;          // Skośność
    double kurtosis;          // Kurtoza
    double min_value;         // Wartość minimalna
    double max_value;         // Wartość maksymalna
    double range;             // Zakres
    double q1;                // Pierwszy kwartyl
    double q3;                // Trzeci kwartyl
    double iqr;               // Rozstęp międzykwartylowy
    double cv;                // Współczynnik zmienności
    double mad;               // Średnie odchylenie bezwzględne
    datetime calculation_time; // Czas obliczenia
};

// Struktura wyników testu statystycznego
struct SStatisticalTestResult {
    ENUM_STATISTICAL_TEST test_type;  // Typ testu
    double test_statistic;            // Statystyka testowa
    double p_value;                   // Wartość p
    double critical_value;            // Wartość krytyczna
    bool reject_null_hypothesis;      // Czy odrzucić H0
    double confidence_level;          // Poziom ufności
    string interpretation;            // Interpretacja
    datetime test_time;               // Czas testu
};

// Struktura optymalizacji
struct SOptimizationResult {
    ENUM_OPTIMIZATION_METHOD method;  // Metoda optymalizacji
    double optimal_value;             // Wartość optymalna
    double optimal_parameters[];      // Parametry optymalne
    int iterations;                   // Liczba iteracji
    double convergence_error;         // Błąd zbieżności
    bool converged;                   // Czy zbieżne
    double execution_time;            // Czas wykonania
    string status_message;            // Komunikat statusu
};

// === PODSTAWOWE FUNKCJE MATEMATYCZNE ===

// Funkcja do obliczania silni
double Factorial(int n) {
    if(n < 0) return 0.0;
    if(n == 0 || n == 1) return 1.0;
    
    double result = 1.0;
    for(int i = 2; i <= n; i++) {
        result *= i;
    }
    return result;
}

// Funkcja do obliczania współczynnika dwumianowego
double BinomialCoefficient(int n, int k) {
    if(k < 0 || k > n) return 0.0;
    if(k == 0 || k == n) return 1.0;
    
    // Użycie wzoru: C(n,k) = n! / (k! * (n-k)!)
    return Factorial(n) / (Factorial(k) * Factorial(n - k));
}

// Funkcja do obliczania logarytmu naturalnego z silni (dla dużych liczb)
double LogFactorial(int n) {
    if(n < 0) return 0.0;
    if(n == 0 || n == 1) return 0.0;
    
    double result = 0.0;
    for(int i = 2; i <= n; i++) {
        result += MathLog(i);
    }
    return result;
}

// Funkcja do obliczania funkcji gamma (uproszczona)
double GammaFunction(double x) {
    if(x <= 0) return 0.0;
    if(x == 1) return 1.0;
    if(x == 0.5) return MathSqrt(M_PI);
    
    // Aproksymacja Stirlinga dla dużych x
    if(x > 10) {
        return MathSqrt(2 * M_PI / x) * MathPow(x / M_E, x);
    }
    
    // Rekurencyjna definicja dla małych x
    return (x - 1) * GammaFunction(x - 1);
}

// Funkcja do obliczania funkcji beta
double BetaFunction(double a, double b) {
    if(a <= 0 || b <= 0) return 0.0;
    
    return GammaFunction(a) * GammaFunction(b) / GammaFunction(a + b);
}

// Funkcja do obliczania funkcji błędu (error function)
double ErrorFunction(double x) {
    // Aproksymacja Abramowitz-Stegun
    double a1 = 0.254829592;
    double a2 = -0.284496736;
    double a3 = 1.421413741;
    double a4 = -1.453152027;
    double a5 = 1.061405429;
    double p = 0.3275911;
    
    double sign = (x >= 0) ? 1.0 : -1.0;
    x = MathAbs(x);
    
    double t = 1.0 / (1.0 + p * x);
    double y = 1.0 - (((((a5 * t + a4) * t) + a3) * t + a2) * t + a1) * t * MathExp(-x * x);
    
    return sign * y;
}

// Funkcja do obliczania funkcji komplementarnej błędu
double ComplementaryErrorFunction(double x) {
    return 1.0 - ErrorFunction(x);
}

// Funkcja do obliczania funkcji kwantylowej rozkładu normalnego (aproksymacja)
double NormalQuantile(double p) {
    if(p <= 0 || p >= 1) return 0.0;
    
    // Aproksymacja Moro
    double a0 = 2.50662823884;
    double a1 = -18.61500062529;
    double a2 = 41.39119773534;
    double a3 = -25.44106049637;
    double b0 = -8.47351093090;
    double b1 = 23.08336743743;
    double b2 = -21.06224101826;
    double b3 = 3.13082909833;
    double c0 = 0.3374754822726147;
    double c1 = 0.9761690190917186;
    double c2 = 0.1607979714918209;
    double c3 = 0.0276438810333863;
    double c4 = 0.0038405729373609;
    double c5 = 0.0003951896511919;
    double c6 = 0.0000321767881768;
    double c7 = 0.0000002888167364;
    double c8 = 0.0000003960315187;
    
    double y = p - 0.5;
    double r, s, t, u, v, w, x_result;
    
    if(MathAbs(y) < 0.42) {
        r = y * y;
        x_result = y * (((a3 * r + a2) * r + a1) * r + a0) / 
                   ((((b3 * r + b2) * r + b1) * r + b0) * r + 1.0);
    } else {
        r = p;
        if(y > 0) r = 1.0 - p;
        
        s = MathLog(-MathLog(r));
        t = c0 + s * (c1 + s * (c2 + s * (c3 + s * (c4 + s * (c5 + s * (c6 + s * (c7 + s * c8)))))));
        
        x_result = (y > 0) ? t : -t;
    }
    
    return x_result;
}

// Funkcja do obliczania funkcji gęstości rozkładu normalnego
double NormalPDF(double x, double mean = 0.0, double std_dev = 1.0) {
    if(std_dev <= 0) return 0.0;
    
    double z = (x - mean) / std_dev;
    return MathExp(-0.5 * z * z) / (std_dev * MathSqrt(2 * M_PI));
}

// Funkcja do obliczania funkcji dystrybuanty rozkładu normalnego
double NormalCDF(double x, double mean = 0.0, double std_dev = 1.0) {
    if(std_dev <= 0) return 0.0;
    
    double z = (x - mean) / std_dev;
    return 0.5 * (1.0 + ErrorFunction(z / MathSqrt(2.0)));
}

// Funkcja do obliczania funkcji gęstości rozkładu t-Studenta
double StudentTPDF(double x, int degrees_of_freedom) {
    if(degrees_of_freedom <= 0) return 0.0;
    
    double v = (double)degrees_of_freedom;
    double numerator = GammaFunction((v + 1.0) / 2.0);
    double denominator = MathSqrt(v * M_PI) * GammaFunction(v / 2.0);
    
    return (numerator / denominator) * MathPow(1.0 + x * x / v, -(v + 1.0) / 2.0);
}

// Funkcja do obliczania funkcji gęstości rozkładu chi-kwadrat
double ChiSquarePDF(double x, int degrees_of_freedom) {
    if(degrees_of_freedom <= 0 || x < 0) return 0.0;
    
    double v = (double)degrees_of_freedom;
    double numerator = MathPow(x, v / 2.0 - 1.0) * MathExp(-x / 2.0);
    double denominator = MathPow(2.0, v / 2.0) * GammaFunction(v / 2.0);
    
    return numerator / denominator;
}

// Funkcja do obliczania funkcji gęstości rozkładu F
double FDistributionPDF(double x, int df1, int df2) {
    if(df1 <= 0 || df2 <= 0 || x < 0) return 0.0;
    
    double v1 = (double)df1;
    double v2 = (double)df2;
    
    double numerator = MathPow(v1 * x, v1 / 2.0) * MathPow(v2, v2 / 2.0);
    double denominator = MathPow(v1 * x + v2, (v1 + v2) / 2.0) * BetaFunction(v1 / 2.0, v2 / 2.0);
    
    return numerator / denominator;
}

// === STATYSTYKI OPISOWE I ANALIZA DANYCH ===

// Funkcja do obliczania statystyk opisowych
SDescriptiveStats CalculateDescriptiveStats(double &data[]) {
    SDescriptiveStats stats;
    int n = ArraySize(data);
    
    if(n == 0) {
        stats.sample_size = 0;
        return stats;
    }
    
    stats.sample_size = n;
    stats.calculation_time = TimeCurrent();
    
    // Podstawowe statystyki
    double sum = 0.0;
    double sum_sq = 0.0;
    stats.min_value = data[0];
    stats.max_value = data[0];
    
    for(int i = 0; i < n; i++) {
        sum += data[i];
        sum_sq += data[i] * data[i];
        
        if(data[i] < stats.min_value) stats.min_value = data[i];
        if(data[i] > stats.max_value) stats.max_value = data[i];
    }
    
    stats.mean = sum / n;
    stats.range = stats.max_value - stats.min_value;
    
    // Wariancja i odchylenie standardowe
    stats.variance = (sum_sq / n) - (stats.mean * stats.mean);
    stats.standard_deviation = MathSqrt(stats.variance);
    
    // Współczynnik zmienności
    if(stats.mean != 0) {
        stats.cv = stats.standard_deviation / MathAbs(stats.mean);
    } else {
        stats.cv = 0.0;
    }
    
    // Mediana
    double sorted_data[];
    ArrayCopy(sorted_data, data);
    ArraySort(sorted_data);
    
    if(n % 2 == 0) {
        stats.median = (sorted_data[n/2 - 1] + sorted_data[n/2]) / 2.0;
    } else {
        stats.median = sorted_data[n/2];
    }
    
    // Kwartyle
    int q1_index = (int)(n * 0.25);
    int q3_index = (int)(n * 0.75);
    stats.q1 = sorted_data[q1_index];
    stats.q3 = sorted_data[q3_index];
    stats.iqr = stats.q3 - stats.q1;
    
    // Skośność i kurtoza
    double sum_cubed = 0.0;
    double sum_quartic = 0.0;
    
    for(int i = 0; i < n; i++) {
        double z = (data[i] - stats.mean) / stats.standard_deviation;
        sum_cubed += MathPow(z, 3);
        sum_quartic += MathPow(z, 4);
    }
    
    stats.skewness = (sum_cubed / n);
    stats.kurtosis = (sum_quartic / n) - 3.0; // Kurtoza nadmiarowa
    
    // Średnie odchylenie bezwzględne
    double sum_abs = 0.0;
    for(int i = 0; i < n; i++) {
        sum_abs += MathAbs(data[i] - stats.median);
    }
    stats.mad = sum_abs / n;
    
    // Dominanta (uproszczona - najczęstsza wartość)
    stats.mode = stats.mean; // Domyślnie średnia
    
    return stats;
}

// Funkcja do obliczania korelacji Pearsona
double CalculatePearsonCorrelation(double &x[], double &y[]) {
    int n = ArraySize(x);
    int m = ArraySize(y);
    
    if(n != m || n < 2) return 0.0;
    
    double sum_x = 0.0, sum_y = 0.0, sum_xy = 0.0;
    double sum_x2 = 0.0, sum_y2 = 0.0;
    
    for(int i = 0; i < n; i++) {
        sum_x += x[i];
        sum_y += y[i];
        sum_xy += x[i] * y[i];
        sum_x2 += x[i] * x[i];
        sum_y2 += y[i] * y[i];
    }
    
    double numerator = n * sum_xy - sum_x * sum_y;
    double denominator = MathSqrt((n * sum_x2 - sum_x * sum_x) * (n * sum_y2 - sum_y * sum_y));
    
    if(denominator == 0) return 0.0;
    
    return numerator / denominator;
}

// Funkcja do obliczania korelacji Spearmana
double CalculateSpearmanCorrelation(double &x[], double &y[]) {
    int n = ArraySize(x);
    int m = ArraySize(y);
    
    if(n != m || n < 2) return 0.0;
    
    // Obliczenie rang
    double rank_x[], rank_y[];
    ArrayResize(rank_x, n);
    ArrayResize(rank_y, n);
    
    // Sortowanie i przypisanie rang
    for(int i = 0; i < n; i++) {
        int rank = 1;
        for(int j = 0; j < n; j++) {
            if(x[j] < x[i]) rank++;
        }
        rank_x[i] = rank;
    }
    
    for(int i = 0; i < n; i++) {
        int rank = 1;
        for(int j = 0; j < n; j++) {
            if(y[j] < y[i]) rank++;
        }
        rank_y[i] = rank;
    }
    
    // Obliczenie korelacji Pearsona dla rang
    return CalculatePearsonCorrelation(rank_x, rank_y);
}

// Funkcja do obliczania autokorelacji
double CalculateAutocorrelation(double &data[], int lag) {
    int n = ArraySize(data);
    
    if(lag >= n || lag < 0) return 0.0;
    
    double mean = 0.0;
    for(int i = 0; i < n; i++) {
        mean += data[i];
    }
    mean /= n;
    
    double numerator = 0.0;
    double denominator = 0.0;
    
    for(int i = 0; i < n - lag; i++) {
        numerator += (data[i] - mean) * (data[i + lag] - mean);
    }
    
    for(int i = 0; i < n; i++) {
        denominator += MathPow(data[i] - mean, 2);
    }
    
    if(denominator == 0) return 0.0;
    
    return numerator / denominator;
}

// Funkcja do obliczania funkcji autokorelacji (ACF)
void CalculateACF(double &data[], double &acf[], int max_lag) {
    int n = ArraySize(data);
    
    if(max_lag > n - 1) max_lag = n - 1;
    
    ArrayResize(acf, max_lag + 1);
    
    for(int lag = 0; lag <= max_lag; lag++) {
        acf[lag] = CalculateAutocorrelation(data, lag);
    }
}

// Funkcja do obliczania funkcji częściowej autokorelacji (PACF)
void CalculatePACF(double &data[], double &pacf[], int max_lag) {
    int n = ArraySize(data);
    
    if(max_lag > n - 1) max_lag = n - 1;
    
    ArrayResize(pacf, max_lag + 1);
    
    // PACF(1) = ACF(1)
    pacf[0] = 1.0;
    if(max_lag >= 1) {
        pacf[1] = CalculateAutocorrelation(data, 1);
    }
    
    // Obliczenie pozostałych wartości PACF metodą Durbina-Levinsona
    for(int k = 2; k <= max_lag; k++) {
        double phi[];
        ArrayResize(phi, k);
        ArrayInitialize(phi, 0.0);
        
        // Inicjalizacja
        phi[k-1] = CalculateAutocorrelation(data, k);
        
        // Iteracyjne obliczenie
        for(int j = 1; j < k; j++) {
            double sum = 0.0;
            for(int i = 0; i < j; i++) {
                sum += phi[i] * CalculateAutocorrelation(data, k - i - 1);
            }
            phi[k-j-1] = (CalculateAutocorrelation(data, k - j) - sum) / (1.0 - sum);
        }
        
        pacf[k] = phi[k-1];
    }
}

// Funkcja do obliczania entropii Shannona
double CalculateShannonEntropy(double &data[], int bins = 10) {
    int n = ArraySize(data);
    
    if(n < 2) return 0.0;
    
    // Znalezienie zakresu danych
    double min_val = data[0], max_val = data[0];
    for(int i = 1; i < n; i++) {
        if(data[i] < min_val) min_val = data[i];
        if(data[i] > max_val) max_val = data[i];
    }
    
    if(max_val == min_val) return 0.0;
    
    // Obliczenie histogramu
    int histogram[];
    ArrayResize(histogram, bins);
    ArrayInitialize(histogram, 0);
    
    double bin_width = (max_val - min_val) / bins;
    
    for(int i = 0; i < n; i++) {
        int bin_index = (int)((data[i] - min_val) / bin_width);
        if(bin_index >= bins) bin_index = bins - 1;
        histogram[bin_index]++;
    }
    
    // Obliczenie entropii
    double entropy = 0.0;
    for(int i = 0; i < bins; i++) {
        if(histogram[i] > 0) {
            double p = (double)histogram[i] / n;
            entropy -= p * MathLog(p);
        }
    }
    
    return entropy;
}

// Funkcja do obliczania entropii Rényi
double CalculateRenyiEntropy(double &data[], double alpha, int bins = 10) {
    int n = ArraySize(data);
    
    if(n < 2 || alpha <= 0 || alpha == 1) return 0.0;
    
    // Znalezienie zakresu danych
    double min_val = data[0], max_val = data[0];
    for(int i = 1; i < n; i++) {
        if(data[i] < min_val) min_val = data[i];
        if(data[i] > max_val) max_val = data[i];
    }
    
    if(max_val == min_val) return 0.0;
    
    // Obliczenie histogramu
    int histogram[];
    ArrayResize(histogram, bins);
    ArrayInitialize(histogram, 0);
    
    double bin_width = (max_val - min_val) / bins;
    
    for(int i = 0; i < n; i++) {
        int bin_index = (int)((data[i] - min_val) / bin_width);
        if(bin_index >= bins) bin_index = bins - 1;
        histogram[bin_index]++;
    }
    
    // Obliczenie entropii Rényi
    double sum = 0.0;
    for(int i = 0; i < bins; i++) {
        if(histogram[i] > 0) {
            double p = (double)histogram[i] / n;
            sum += MathPow(p, alpha);
        }
    }
    
    return MathLog(sum) / (1.0 - alpha);
}

// Funkcja do obliczania entropii Tsallis
double CalculateTsallisEntropy(double &data[], double q, int bins = 10) {
    int n = ArraySize(data);
    
    if(n < 2 || q <= 0 || q == 1) return 0.0;
    
    // Znalezienie zakresu danych
    double min_val = data[0], max_val = data[0];
    for(int i = 1; i < n; i++) {
        if(data[i] < min_val) min_val = data[i];
        if(data[i] > max_val) max_val = data[i];
    }
    
    if(max_val == min_val) return 0.0;
    
    // Obliczenie histogramu
    int histogram[];
    ArrayResize(histogram, bins);
    ArrayInitialize(histogram, 0);
    
    double bin_width = (max_val - min_val) / bins;
    
    for(int i = 0; i < n; i++) {
        int bin_index = (int)((data[i] - min_val) / bin_width);
        if(bin_index >= bins) bin_index = bins - 1;
        histogram[bin_index]++;
    }
    
    // Obliczenie entropii Tsallis
    double sum = 0.0;
    for(int i = 0; i < bins; i++) {
        if(histogram[i] > 0) {
            double p = (double)histogram[i] / n;
            sum += MathPow(p, q);
        }
    }
    
    return (1.0 - sum) / (q - 1.0);
}

// Funkcja do obliczania współczynnika Hursta (Hurst exponent)
double CalculateHurstExponent(double &data[], int min_lag = 4, int max_lag = 20) {
    int n = ArraySize(data);
    
    if(n < max_lag * 2) return 0.5;
    
    double lags[], rs_values[];
    int lag_count = 0;
    
    for(int lag = min_lag; lag <= max_lag; lag++) {
        if(lag * 2 > n) break;
        
        // Obliczenie R/S dla danego lag
        double rs = CalculateRSStatistic(data, lag);
        
        if(rs > 0) {
            ArrayResize(lags, lag_count + 1);
            ArrayResize(rs_values, lag_count + 1);
            
            lags[lag_count] = MathLog(lag);
            rs_values[lag_count] = MathLog(rs);
            lag_count++;
        }
    }
    
    if(lag_count < 2) return 0.5;
    
    // Obliczenie współczynnika Hursta przez regresję liniową
    double hurst = CalculateLinearRegression(lags, rs_values);
    
    return hurst;
}

// Funkcja pomocnicza do obliczania statystyki R/S
double CalculateRSStatistic(double &data[], int lag) {
    int n = ArraySize(data);
    int segments = n / lag;
    
    if(segments < 1) return 0.0;
    
    double rs_sum = 0.0;
    
    for(int i = 0; i < segments; i++) {
        double segment[];
        ArrayResize(segment, lag);
        
        for(int j = 0; j < lag; j++) {
            segment[j] = data[i * lag + j];
        }
        
        // Obliczenie średniej
        double mean = 0.0;
        for(int j = 0; j < lag; j++) {
            mean += segment[j];
        }
        mean /= lag;
        
        // Obliczenie odchyleń skumulowanych
        double deviations[];
        ArrayResize(deviations, lag);
        for(int j = 0; j < lag; j++) {
            deviations[j] = segment[j] - mean;
        }
        
        // Obliczenie sum skumulowanych
        double cumulative[];
        ArrayResize(cumulative, lag);
        cumulative[0] = deviations[0];
        for(int j = 1; j < lag; j++) {
            cumulative[j] = cumulative[j-1] + deviations[j];
        }
        
        // Obliczenie R (range)
        double min_cum = cumulative[0], max_cum = cumulative[0];
        for(int j = 1; j < lag; j++) {
            if(cumulative[j] < min_cum) min_cum = cumulative[j];
            if(cumulative[j] > max_cum) max_cum = cumulative[j];
        }
        double R = max_cum - min_cum;
        
        // Obliczenie S (standard deviation)
        double variance = 0.0;
        for(int j = 0; j < lag; j++) {
            variance += deviations[j] * deviations[j];
        }
        variance /= lag;
        double S = MathSqrt(variance);
        
        if(S > 0) {
            rs_sum += R / S;
        }
    }
    
    return rs_sum / segments;
}

// Funkcja do obliczania regresji liniowej
double CalculateLinearRegression(double &x[], double &y[]) {
    int n = ArraySize(x);
    int m = ArraySize(y);
    
    if(n != m || n < 2) return 0.0;
    
    double sum_x = 0.0, sum_y = 0.0, sum_xy = 0.0, sum_x2 = 0.0;
    
    for(int i = 0; i < n; i++) {
        sum_x += x[i];
        sum_y += y[i];
        sum_xy += x[i] * y[i];
        sum_x2 += x[i] * x[i];
    }
    
    double numerator = n * sum_xy - sum_x * sum_y;
    double denominator = n * sum_x2 - sum_x * sum_x;
    
    if(denominator == 0) return 0.0;
    
    return numerator / denominator;
}

// === TESTY STATYSTYCZNE ===

// Test t-Studenta dla jednej próby
SStatisticalTestResult PerformTTest(double &data[], double hypothesized_mean = 0.0) {
    SStatisticalTestResult result;
    result.test_type = TEST_T_STUDENT;
    result.test_time = TimeCurrent();
    
    int n = ArraySize(data);
    if(n < 2) {
        result.interpretation = "Niewystarczająca liczba obserwacji";
        return result;
    }
    
    // Obliczenie statystyk
    double mean = 0.0;
    for(int i = 0; i < n; i++) {
        mean += data[i];
    }
    mean /= n;
    
    double variance = 0.0;
    for(int i = 0; i < n; i++) {
        variance += MathPow(data[i] - mean, 2);
    }
    variance /= (n - 1);
    double std_dev = MathSqrt(variance);
    
    // Statystyka testowa
    result.test_statistic = (mean - hypothesized_mean) / (std_dev / MathSqrt(n));
    
    // Stopnie swobody
    int df = n - 1;
    
    // Wartość p (uproszczona aproksymacja)
    double t_abs = MathAbs(result.test_statistic);
    if(df > 30) {
        // Dla dużych df używamy rozkładu normalnego
        result.p_value = 2.0 * (1.0 - NormalCDF(t_abs));
    } else {
        // Uproszczona aproksymacja dla małych df
        result.p_value = 2.0 * (1.0 - NormalCDF(t_abs * MathSqrt((df - 1.0) / (df - 2.0 + t_abs * t_abs))));
    }
    
    // Wartość krytyczna (dla alpha = 0.05)
    result.critical_value = 1.96; // Dla dużych df
    if(df <= 30) {
        result.critical_value = 2.042; // Dla df = 30
    }
    
    result.confidence_level = 0.95;
    result.reject_null_hypothesis = (MathAbs(result.test_statistic) > result.critical_value);
    
    if(result.reject_null_hypothesis) {
        result.interpretation = "Odrzucamy H0: średnia różni się od " + DoubleToString(hypothesized_mean, 4);
    } else {
        result.interpretation = "Nie ma podstaw do odrzucenia H0";
    }
    
    return result;
}

// Test t-Studenta dla dwóch prób niezależnych
SStatisticalTestResult PerformTwoSampleTTest(double &data1[], double &data2[]) {
    SStatisticalTestResult result;
    result.test_type = TEST_T_STUDENT;
    result.test_time = TimeCurrent();
    
    int n1 = ArraySize(data1);
    int n2 = ArraySize(data2);
    
    if(n1 < 2 || n2 < 2) {
        result.interpretation = "Niewystarczająca liczba obserwacji";
        return result;
    }
    
    // Średnie
    double mean1 = 0.0, mean2 = 0.0;
    for(int i = 0; i < n1; i++) mean1 += data1[i];
    for(int i = 0; i < n2; i++) mean2 += data2[i];
    mean1 /= n1;
    mean2 /= n2;
    
    // Wariancje
    double var1 = 0.0, var2 = 0.0;
    for(int i = 0; i < n1; i++) var1 += MathPow(data1[i] - mean1, 2);
    for(int i = 0; i < n2; i++) var2 += MathPow(data2[i] - mean2, 2);
    var1 /= (n1 - 1);
    var2 /= (n2 - 1);
    
    // Statystyka testowa
    double pooled_var = ((n1 - 1) * var1 + (n2 - 1) * var2) / (n1 + n2 - 2);
    result.test_statistic = (mean1 - mean2) / MathSqrt(pooled_var * (1.0/n1 + 1.0/n2));
    
    // Stopnie swobody
    int df = n1 + n2 - 2;
    
    // Wartość p
    double t_abs = MathAbs(result.test_statistic);
    if(df > 30) {
        result.p_value = 2.0 * (1.0 - NormalCDF(t_abs));
    } else {
        result.p_value = 2.0 * (1.0 - NormalCDF(t_abs * MathSqrt((df - 1.0) / (df - 2.0 + t_abs * t_abs))));
    }
    
    // Wartość krytyczna
    result.critical_value = 1.96;
    if(df <= 30) result.critical_value = 2.042;
    
    result.confidence_level = 0.95;
    result.reject_null_hypothesis = (MathAbs(result.test_statistic) > result.critical_value);
    
    if(result.reject_null_hypothesis) {
        result.interpretation = "Odrzucamy H0: średnie są różne";
    } else {
        result.interpretation = "Nie ma podstaw do odrzucenia H0";
    }
    
    return result;
}

// Test Kołmogorowa-Smirnowa
SStatisticalTestResult PerformKSTest(double &data[], ENUM_DISTRIBUTION_TYPE distribution = DISTRIBUTION_NORMAL) {
    SStatisticalTestResult result;
    result.test_type = TEST_KS;
    result.test_time = TimeCurrent();
    
    int n = ArraySize(data);
    if(n < 2) {
        result.interpretation = "Niewystarczająca liczba obserwacji";
        return result;
    }
    
    // Sortowanie danych
    double sorted_data[];
    ArrayCopy(sorted_data, data);
    ArraySort(sorted_data);
    
    // Obliczenie statystyki KS
    double max_diff = 0.0;
    
    for(int i = 0; i < n; i++) {
        double empirical_cdf = (double)(i + 1) / n;
        double theoretical_cdf = 0.0;
        
        // Obliczenie teoretycznej CDF
        switch(distribution) {
            case DISTRIBUTION_NORMAL:
                theoretical_cdf = NormalCDF(sorted_data[i]);
                break;
            case DISTRIBUTION_EXPONENTIAL:
                theoretical_cdf = 1.0 - MathExp(-sorted_data[i]);
                break;
            default:
                theoretical_cdf = NormalCDF(sorted_data[i]);
                break;
        }
        
        double diff = MathAbs(empirical_cdf - theoretical_cdf);
        if(diff > max_diff) max_diff = diff;
    }
    
    result.test_statistic = max_diff;
    
    // Wartość p (aproksymacja)
    double ks_stat = max_diff * MathSqrt(n);
    result.p_value = 2.0 * MathExp(-2.0 * ks_stat * ks_stat);
    
    // Wartość krytyczna dla alpha = 0.05
    result.critical_value = 1.36 / MathSqrt(n);
    
    result.confidence_level = 0.95;
    result.reject_null_hypothesis = (result.test_statistic > result.critical_value);
    
    if(result.reject_null_hypothesis) {
        result.interpretation = "Odrzucamy H0: dane nie pochodzą z rozkładu " + EnumToString(distribution);
    } else {
        result.interpretation = "Nie ma podstaw do odrzucenia H0";
    }
    
    return result;
}

// Test Jarque-Bera (normalność)
SStatisticalTestResult PerformJarqueBeraTest(double &data[]) {
    SStatisticalTestResult result;
    result.test_type = TEST_JARQUE_BERA;
    result.test_time = TimeCurrent();
    
    int n = ArraySize(data);
    if(n < 3) {
        result.interpretation = "Niewystarczająca liczba obserwacji";
        return result;
    }
    
    // Obliczenie skośności i kurtozy
    SDescriptiveStats stats = CalculateDescriptiveStats(data);
    
    // Statystyka testowa
    double jb = n * (MathPow(stats.skewness, 2) / 6.0 + MathPow(stats.kurtosis, 2) / 24.0);
    result.test_statistic = jb;
    
    // Wartość p (rozkład chi-kwadrat z 2 stopniami swobody)
    result.p_value = 1.0 - ChiSquareCDF(jb, 2);
    
    // Wartość krytyczna dla alpha = 0.05
    result.critical_value = 5.991; // Chi-kwadrat(2, 0.95)
    
    result.confidence_level = 0.95;
    result.reject_null_hypothesis = (result.test_statistic > result.critical_value);
    
    if(result.reject_null_hypothesis) {
        result.interpretation = "Odrzucamy H0: dane nie są normalnie rozłożone";
    } else {
        result.interpretation = "Nie ma podstaw do odrzucenia H0";
    }
    
    return result;
}

// Test Durbina-Watsona (autokorelacja)
SStatisticalTestResult PerformDurbinWatsonTest(double &residuals[]) {
    SStatisticalTestResult result;
    result.test_type = TEST_DURBIN_WATSON;
    result.test_time = TimeCurrent();
    
    int n = ArraySize(residuals);
    if(n < 3) {
        result.interpretation = "Niewystarczająca liczba obserwacji";
        return result;
    }
    
    // Obliczenie statystyki DW
    double numerator = 0.0;
    double denominator = 0.0;
    
    for(int i = 1; i < n; i++) {
        numerator += MathPow(residuals[i] - residuals[i-1], 2);
    }
    
    for(int i = 0; i < n; i++) {
        denominator += MathPow(residuals[i], 2);
    }
    
    if(denominator == 0) {
        result.interpretation = "Błąd: zerowa suma kwadratów reszt";
        return result;
    }
    
    result.test_statistic = numerator / denominator;
    
    // Wartości krytyczne (uproszczone)
    double d_l = 1.5; // Dolna granica
    double d_u = 1.7; // Górna granica
    
    result.critical_value = d_u;
    result.confidence_level = 0.95;
    
    // Interpretacja
    if(result.test_statistic < d_l) {
        result.reject_null_hypothesis = true;
        result.interpretation = "Dodatnia autokorelacja";
    } else if(result.test_statistic > (4 - d_l)) {
        result.reject_null_hypothesis = true;
        result.interpretation = "Ujemna autokorelacja";
    } else if(result.test_statistic > d_u && result.test_statistic < (4 - d_u)) {
        result.reject_null_hypothesis = false;
        result.interpretation = "Brak autokorelacji";
    } else {
        result.reject_null_hypothesis = false;
        result.interpretation = "Test niejednoznaczny";
    }
    
    return result;
}

// Test chi-kwadrat dla dobroci dopasowania
SStatisticalTestResult PerformChiSquareGoodnessOfFitTest(double &observed[], double &expected[]) {
    SStatisticalTestResult result;
    result.test_type = TEST_CHI_SQUARE;
    result.test_time = TimeCurrent();
    
    int n = ArraySize(observed);
    int m = ArraySize(expected);
    
    if(n != m || n < 2) {
        result.interpretation = "Nieprawidłowe wymiary danych";
        return result;
    }
    
    // Obliczenie statystyki chi-kwadrat
    double chi_square = 0.0;
    int df = 0;
    
    for(int i = 0; i < n; i++) {
        if(expected[i] > 0) {
            chi_square += MathPow(observed[i] - expected[i], 2) / expected[i];
            df++;
        }
    }
    
    df--; // Odejmujemy jeden stopień swobody
    
    result.test_statistic = chi_square;
    
    // Wartość p
    result.p_value = 1.0 - ChiSquareCDF(chi_square, df);
    
    // Wartość krytyczna dla alpha = 0.05
    result.critical_value = ChiSquareQuantile(0.95, df);
    
    result.confidence_level = 0.95;
    result.reject_null_hypothesis = (result.test_statistic > result.critical_value);
    
    if(result.reject_null_hypothesis) {
        result.interpretation = "Odrzucamy H0: rozkłady są różne";
    } else {
        result.interpretation = "Nie ma podstaw do odrzucenia H0";
    }
    
    return result;
}

// Funkcja pomocnicza - CDF rozkładu chi-kwadrat
double ChiSquareCDF(double x, int degrees_of_freedom) {
    if(x < 0 || degrees_of_freedom <= 0) return 0.0;
    
    // Aproksymacja dla dużych stopni swobody
    if(degrees_of_freedom > 30) {
        double z = (MathPow(x / degrees_of_freedom, 1.0/3.0) - 1.0 + 2.0/(9.0 * degrees_of_freedom)) / 
                   MathSqrt(2.0/(9.0 * degrees_of_freedom));
        return NormalCDF(z);
    }
    
    // Uproszczona aproksymacja
    return 1.0 - MathExp(-x / 2.0) * MathPow(x / 2.0, degrees_of_freedom / 2.0 - 1.0) / 
           (MathPow(2.0, degrees_of_freedom / 2.0) * GammaFunction(degrees_of_freedom / 2.0));
}

// Funkcja pomocnicza - kwantyl rozkładu chi-kwadrat
double ChiSquareQuantile(double p, int degrees_of_freedom) {
    if(p <= 0 || p >= 1 || degrees_of_freedom <= 0) return 0.0;
    
    // Aproksymacja Wilson-Hilferty
    if(degrees_of_freedom > 30) {
        double z = NormalQuantile(p);
        double h = 1.0 - 2.0/(9.0 * degrees_of_freedom);
        return degrees_of_freedom * MathPow(z * MathSqrt(2.0/(9.0 * degrees_of_freedom)) + h, 3);
    }
    
    // Uproszczona aproksymacja
    double z = NormalQuantile(p);
    return degrees_of_freedom + z * MathSqrt(2.0 * degrees_of_freedom);
}

// Test Wilcoxona (nieparametryczny odpowiednik testu t)
SStatisticalTestResult PerformWilcoxonTest(double &data1[], double &data2[]) {
    SStatisticalTestResult result;
    result.test_type = TEST_WILCOXON;
    result.test_time = TimeCurrent();
    
    int n1 = ArraySize(data1);
    int n2 = ArraySize(data2);
    
    if(n1 < 2 || n2 < 2) {
        result.interpretation = "Niewystarczająca liczba obserwacji";
        return result;
    }
    
    // Połączenie danych i obliczenie rang
    int total_n = n1 + n2;
    double combined_data[];
    ArrayResize(combined_data, total_n);
    
    for(int i = 0; i < n1; i++) combined_data[i] = data1[i];
    for(int i = 0; i < n2; i++) combined_data[i + n1] = data2[i];
    
    // Obliczenie rang
    double ranks[];
    ArrayResize(ranks, total_n);
    
    for(int i = 0; i < total_n; i++) {
        int rank = 1;
        for(int j = 0; j < total_n; j++) {
            if(combined_data[j] < combined_data[i]) rank++;
        }
        ranks[i] = rank;
    }
    
    // Suma rang dla pierwszej próby
    double sum_ranks = 0.0;
    for(int i = 0; i < n1; i++) {
        sum_ranks += ranks[i];
    }
    
    // Statystyka testowa
    double expected_sum = n1 * (total_n + 1) / 2.0;
    double variance = n1 * n2 * (total_n + 1) / 12.0;
    
    result.test_statistic = (sum_ranks - expected_sum) / MathSqrt(variance);
    
    // Wartość p (uproszczona)
    result.p_value = 2.0 * (1.0 - NormalCDF(MathAbs(result.test_statistic)));
    
    // Wartość krytyczna
    result.critical_value = 1.96;
    result.confidence_level = 0.95;
    result.reject_null_hypothesis = (MathAbs(result.test_statistic) > result.critical_value);
    
    if(result.reject_null_hypothesis) {
        result.interpretation = "Odrzucamy H0: mediany są różne";
    } else {
        result.interpretation = "Nie ma podstaw do odrzucenia H0";
    }
    
    return result;
}

// === OPTYMALIZACJA I ALGORYTMY NUMERYCZNE ===

// Funkcja do optymalizacji metodą złotego podziału
SOptimizationResult GoldenSectionOptimization(double &function_values[], double tolerance = 1e-6, int max_iterations = 1000) {
    SOptimizationResult result;
    result.method = OPTIMIZATION_GOLDEN_SECTION;
    result.execution_time = 0.0;
    result.converged = false;
    
    int n = ArraySize(function_values);
    if(n < 3) {
        result.status_message = "Niewystarczająca liczba punktów";
        return result;
    }
    
    datetime start_time = TimeCurrent();
    
    // Stała złotego podziału
    double phi = (MathSqrt(5.0) - 1.0) / 2.0;
    double a = 0.0, b = (double)(n - 1);
    double c = b - phi * (b - a);
    double d = a + phi * (b - a);
    
    int iterations = 0;
    
    while(MathAbs(b - a) > tolerance && iterations < max_iterations) {
        int c_idx = (int)MathRound(c);
        int d_idx = (int)MathRound(d);
        
        if(c_idx < 0) c_idx = 0;
        if(c_idx >= n) c_idx = n - 1;
        if(d_idx < 0) d_idx = 0;
        if(d_idx >= n) d_idx = n - 1;
        
        double fc = function_values[c_idx];
        double fd = function_values[d_idx];
        
        if(fc < fd) {
            b = d;
            d = c;
            c = b - phi * (b - a);
        } else {
            a = c;
            c = d;
            d = a + phi * (b - a);
        }
        
        iterations++;
    }
    
    result.iterations = iterations;
    result.optimal_value = function_values[(int)MathRound((a + b) / 2.0)];
    result.convergence_error = MathAbs(b - a);
    result.converged = (iterations < max_iterations);
    result.execution_time = (double)(TimeCurrent() - start_time);
    
    if(result.converged) {
        result.status_message = "Optymalizacja zakończona sukcesem";
    } else {
        result.status_message = "Przekroczono maksymalną liczbę iteracji";
    }
    
    return result;
}

// Funkcja do optymalizacji metodą bisekcji
SOptimizationResult BisectionOptimization(double &function_values[], double tolerance = 1e-6, int max_iterations = 1000) {
    SOptimizationResult result;
    result.method = OPTIMIZATION_BISECTION;
    result.execution_time = 0.0;
    result.converged = false;
    
    int n = ArraySize(function_values);
    if(n < 3) {
        result.status_message = "Niewystarczająca liczba punktów";
        return result;
    }
    
    datetime start_time = TimeCurrent();
    
    double a = 0.0, b = (double)(n - 1);
    int iterations = 0;
    
    while(MathAbs(b - a) > tolerance && iterations < max_iterations) {
        double c = (a + b) / 2.0;
        int c_idx = (int)MathRound(c);
        
        if(c_idx < 0) c_idx = 0;
        if(c_idx >= n) c_idx = n - 1;
        
        int a_idx = (int)MathRound(a);
        int b_idx = (int)MathRound(b);
        
        if(a_idx < 0) a_idx = 0;
        if(a_idx >= n) a_idx = n - 1;
        if(b_idx < 0) b_idx = 0;
        if(b_idx >= n) b_idx = n - 1;
        
        double fa = function_values[a_idx];
        double fb = function_values[b_idx];
        double fc = function_values[c_idx];
        
        // Sprawdzenie znaku pochodnej (uproszczone)
        if(fc > fa && fc > fb) {
            // Maksimum w środku
            break;
        } else if(fc < fa) {
            b = c;
        } else {
            a = c;
        }
        
        iterations++;
    }
    
    result.iterations = iterations;
    result.optimal_value = function_values[(int)MathRound((a + b) / 2.0)];
    result.convergence_error = MathAbs(b - a);
    result.converged = (iterations < max_iterations);
    result.execution_time = (double)(TimeCurrent() - start_time);
    
    if(result.converged) {
        result.status_message = "Optymalizacja zakończona sukcesem";
    } else {
        result.status_message = "Przekroczono maksymalną liczbę iteracji";
    }
    
    return result;
}

// Funkcja do optymalizacji metodą spadku gradientu
SOptimizationResult GradientDescentOptimization(double &function_values[], double learning_rate = 0.01, double tolerance = 1e-6, int max_iterations = 1000) {
    SOptimizationResult result;
    result.method = OPTIMIZATION_GRADIENT_DESCENT;
    result.execution_time = 0.0;
    result.converged = false;
    
    int n = ArraySize(function_values);
    if(n < 3) {
        result.status_message = "Niewystarczająca liczba punktów";
        return result;
    }
    
    datetime start_time = TimeCurrent();
    
    // Początkowa pozycja
    double x = (double)(n / 2);
    int iterations = 0;
    
    while(iterations < max_iterations) {
        int x_idx = (int)MathRound(x);
        if(x_idx < 1) x_idx = 1;
        if(x_idx >= n - 1) x_idx = n - 2;
        
        // Obliczenie gradientu (różnica skończona)
        double gradient = (function_values[x_idx + 1] - function_values[x_idx - 1]) / 2.0;
        
        // Aktualizacja pozycji
        double x_new = x - learning_rate * gradient;
        
        // Sprawdzenie zbieżności
        if(MathAbs(x_new - x) < tolerance) {
            result.converged = true;
            break;
        }
        
        x = x_new;
        iterations++;
    }
    
    result.iterations = iterations;
    int optimal_idx = (int)MathRound(x);
    if(optimal_idx < 0) optimal_idx = 0;
    if(optimal_idx >= n) optimal_idx = n - 1;
    
    result.optimal_value = function_values[optimal_idx];
    result.convergence_error = MathAbs(x - (double)optimal_idx);
    result.execution_time = (double)(TimeCurrent() - start_time);
    
    if(result.converged) {
        result.status_message = "Optymalizacja zakończona sukcesem";
    } else {
        result.status_message = "Przekroczono maksymalną liczbę iteracji";
    }
    
    return result;
}

// Funkcja do interpolacji Lagrange'a
double LagrangeInterpolation(double &x_points[], double &y_points[], double x) {
    int n = ArraySize(x_points);
    int m = ArraySize(y_points);
    
    if(n != m || n < 2) return 0.0;
    
    double result = 0.0;
    
    for(int i = 0; i < n; i++) {
        double term = y_points[i];
        
        for(int j = 0; j < n; j++) {
            if(i != j) {
                term *= (x - x_points[j]) / (x_points[i] - x_points[j]);
            }
        }
        
        result += term;
    }
    
    return result;
}

// Funkcja do interpolacji spline kubicznej (uproszczona)
double CubicSplineInterpolation(double &x_points[], double &y_points[], double x) {
    int n = ArraySize(x_points);
    int m = ArraySize(y_points);
    
    if(n != m || n < 4) return 0.0;
    
    // Znalezienie segmentu
    int segment = 0;
    for(int i = 0; i < n - 1; i++) {
        if(x >= x_points[i] && x <= x_points[i + 1]) {
            segment = i;
            break;
        }
    }
    
    if(segment >= n - 1) segment = n - 2;
    
    // Interpolacja liniowa w segmencie (uproszczona)
    double x0 = x_points[segment];
    double x1 = x_points[segment + 1];
    double y0 = y_points[segment];
    double y1 = y_points[segment + 1];
    
    return y0 + (y1 - y0) * (x - x0) / (x1 - x0);
}

// Funkcja do obliczania całki numerycznej metodą trapezów
double TrapezoidalIntegration(double &function_values[], double a, double b) {
    int n = ArraySize(function_values);
    
    if(n < 2) return 0.0;
    
    double h = (b - a) / (n - 1);
    double sum = 0.5 * (function_values[0] + function_values[n - 1]);
    
    for(int i = 1; i < n - 1; i++) {
        sum += function_values[i];
    }
    
    return h * sum;
}

// Funkcja do obliczania całki numerycznej metodą Simpsona
double SimpsonIntegration(double &function_values[], double a, double b) {
    int n = ArraySize(function_values);
    
    if(n < 3 || n % 2 == 0) return 0.0;
    
    double h = (b - a) / (n - 1);
    double sum = function_values[0] + function_values[n - 1];
    
    for(int i = 1; i < n - 1; i++) {
        if(i % 2 == 1) {
            sum += 4.0 * function_values[i];
        } else {
            sum += 2.0 * function_values[i];
        }
    }
    
    return h * sum / 3.0;
}

// Funkcja do obliczania pochodnej numerycznej
double NumericalDerivative(double &function_values[], int index, double h = 1.0) {
    int n = ArraySize(function_values);
    
    if(n < 3 || index < 1 || index >= n - 1) return 0.0;
    
    // Metoda różnic centralnych
    return (function_values[index + 1] - function_values[index - 1]) / (2.0 * h);
}

// Funkcja do obliczania drugiej pochodnej numerycznej
double NumericalSecondDerivative(double &function_values[], int index, double h = 1.0) {
    int n = ArraySize(function_values);
    
    if(n < 3 || index < 1 || index >= n - 1) return 0.0;
    
    return (function_values[index + 1] - 2.0 * function_values[index] + function_values[index - 1]) / (h * h);
}

// Funkcja do rozwiązywania układu równań liniowych metodą Gaussa
bool SolveLinearSystem(double &coeff_matrix[][], double &input_vector[], double &solution[]) {
    int n = ArraySize(input_vector);
    int rows = ArrayRange(coeff_matrix, 0);
    int cols = ArrayRange(coeff_matrix, 1);
    
    if(rows != n || cols != n) return false;
    
    // Kopia macierzy i wektora
    double A[][];
    ArrayResize(A, rows);
    ArrayResize(A, rows, cols);
    ArrayCopy(A, coeff_matrix);
    
    double b[];
    ArrayResize(b, n);
    ArrayCopy(b, input_vector);
    
    // Eliminacja Gaussa
    for(int k = 0; k < n - 1; k++) {
        // Znalezienie elementu głównego
        int max_row = k;
        for(int i = k + 1; i < n; i++) {
            if(MathAbs(A[i][k]) > MathAbs(A[max_row][k])) {
                max_row = i;
            }
        }
        
        // Zamiana wierszy
        if(max_row != k) {
            for(int j = k; j < n; j++) {
                double temp = A[k][j];
                A[k][j] = A[max_row][j];
                A[max_row][j] = temp;
            }
            double temp = b[k];
            b[k] = b[max_row];
            b[max_row] = temp;
        }
        
        // Eliminacja
        for(int i = k + 1; i < n; i++) {
            double factor = A[i][k] / A[k][k];
            for(int j = k; j < n; j++) {
                A[i][j] -= factor * A[k][j];
            }
            b[i] -= factor * b[k];
        }
    }
    
    // Podstawienie wsteczne
    ArrayResize(solution, n);
    for(int i = n - 1; i >= 0; i--) {
        double sum = 0.0;
        for(int j = i + 1; j < n; j++) {
            sum += A[i][j] * solution[j];
        }
        solution[i] = (b[i] - sum) / A[i][i];
    }
    
    return true;
}

// Funkcja do obliczania wyznacznika macierzy
double MatrixDeterminant(double &input_matrix[][]) {
    int rows = ArrayRange(input_matrix, 0);
    int cols = ArrayRange(input_matrix, 1);
    
    if(rows != cols) return 0.0;
    
    int n = rows;
    
    // Kopia macierzy
    double A[][];
    ArrayResize(A, n);
    ArrayResize(A, n, n);
    ArrayCopy(A, input_matrix);
    
    double det = 1.0;
    
    for(int k = 0; k < n - 1; k++) {
        // Znalezienie elementu głównego
        int max_row = k;
        for(int i = k + 1; i < n; i++) {
            if(MathAbs(A[i][k]) > MathAbs(A[max_row][k])) {
                max_row = i;
            }
        }
        
        // Zamiana wierszy
        if(max_row != k) {
            for(int j = k; j < n; j++) {
                double temp = A[k][j];
                A[k][j] = A[max_row][j];
                A[max_row][j] = temp;
            }
            det = -det;
        }
        
        // Eliminacja
        for(int i = k + 1; i < n; i++) {
            double factor = A[i][k] / A[k][k];
            for(int j = k; j < n; j++) {
                A[i][j] -= factor * A[k][j];
            }
        }
    }
    
    // Obliczenie wyznacznika
    for(int i = 0; i < n; i++) {
        det *= A[i][i];
    }
    
    return det;
}

// Funkcja do obliczania macierzy odwrotnej
bool MatrixInverse(double &input_matrix[][], double &inverse[][]) {
    int rows = ArrayRange(input_matrix, 0);
    int cols = ArrayRange(input_matrix, 1);
    
    if(rows != cols) return false;
    
    int n = rows;
    
    // Macierz rozszerzona [A|I]
    double augmented[];
    ArrayResize(augmented, n * 2 * n);
    
    // Kopiowanie macierzy A
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            augmented[i * (2 * n) + j] = input_matrix[i][j];
        }
    }
    
    // Dodanie macierzy jednostkowej
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            augmented[i * (2 * n) + (j + n)] = (i == j) ? 1.0 : 0.0;
        }
    }
    
    // Eliminacja Gaussa-Jordana
    for(int k = 0; k < n; k++) {
        // Znalezienie elementu głównego
        int max_row = k;
        for(int i = k + 1; i < n; i++) {
            if(MathAbs(augmented[i * (2 * n) + k]) > MathAbs(augmented[max_row * (2 * n) + k])) {
                max_row = i;
            }
        }
        
        // Zamiana wierszy
        if(max_row != k) {
            for(int j = k; j < 2 * n; j++) {
                double temp = augmented[k * (2 * n) + j];
                augmented[k * (2 * n) + j] = augmented[max_row * (2 * n) + j];
                augmented[max_row * (2 * n) + j] = temp;
            }
        }
        
        // Normalizacja wiersza
        double pivot = augmented[k * (2 * n) + k];
        if(MathAbs(pivot) < 1e-10) return false; // Macierz osobliwa
        
        for(int j = k; j < 2 * n; j++) {
            augmented[k * (2 * n) + j] /= pivot;
        }
        
        // Eliminacja
        for(int i = 0; i < n; i++) {
            if(i != k) {
                double factor = augmented[i * (2 * n) + k];
                for(int j = k; j < 2 * n; j++) {
                    augmented[i * (2 * n) + j] -= factor * augmented[k * (2 * n) + j];
                }
            }
        }
    }
    
    // Kopiowanie macierzy odwrotnej
    ArrayResize(inverse, n, n);
    for(int i = 0; i < n; i++) {
        for(int j = 0; j < n; j++) {
            inverse[i][j] = augmented[i * (2 * n) + (j + n)];
        }
    }
    
    return true;
}

// Funkcja do obliczania wartości własnych (uproszczona - tylko największa)
double MatrixLargestEigenvalue(double &input_matrix[][], int max_iterations = 100) {
    int rows = ArrayRange(input_matrix, 0);
    int cols = ArrayRange(input_matrix, 1);
    
    if(rows != cols) return 0.0;
    
    int n = rows;
    
    // Wektor początkowy
    double v[];
    ArrayResize(v, n);
    for(int i = 0; i < n; i++) {
        v[i] = 1.0;
    }
    
    double eigenvalue = 0.0;
    
    for(int iter = 0; iter < max_iterations; iter++) {
        // Mnożenie macierzy przez wektor
        double Av[];
        ArrayResize(Av, n);
        
        for(int i = 0; i < n; i++) {
            Av[i] = 0.0;
            for(int j = 0; j < n; j++) {
                Av[i] += input_matrix[i][j] * v[j];
            }
        }
        
        // Obliczenie normy
        double norm = 0.0;
        for(int i = 0; i < n; i++) {
            norm += Av[i] * Av[i];
        }
        norm = MathSqrt(norm);
        
        if(norm < 1e-10) break;
        
        // Normalizacja wektora
        for(int i = 0; i < n; i++) {
            v[i] = Av[i] / norm;
        }
        
        // Obliczenie wartości własnej (iloraz Rayleigha)
        double numerator = 0.0;
        double denominator = 0.0;
        
        for(int i = 0; i < n; i++) {
            numerator += Av[i] * v[i];
            denominator += v[i] * v[i];
        }
        
        eigenvalue = numerator / denominator;
    }
    
    return eigenvalue;
}

// === FUNKCJE POMOCNICZE I KONWERSJE ===

// Funkcja do konwersji enum na string
string EnumToString(ENUM_DISTRIBUTION_TYPE distribution) {
    switch(distribution) {
        case DISTRIBUTION_NORMAL: return "Normalny";
        case DISTRIBUTION_LOG_NORMAL: return "Logarytmiczno-normalny";
        case DISTRIBUTION_STUDENT_T: return "t-Studenta";
        case DISTRIBUTION_CHI_SQUARE: return "Chi-kwadrat";
        case DISTRIBUTION_F: return "F";
        case DISTRIBUTION_EXPONENTIAL: return "Wykładniczy";
        case DISTRIBUTION_GAMMA: return "Gamma";
        case DISTRIBUTION_BETA: return "Beta";
        case DISTRIBUTION_WEIBULL: return "Weibull";
        case DISTRIBUTION_CAUCHY: return "Cauchy";
        default: return "Nieznany";
    }
}

string EnumToString(ENUM_STATISTICAL_TEST test) {
    switch(test) {
        case TEST_T_STUDENT: return "t-Studenta";
        case TEST_WILCOXON: return "Wilcoxona";
        case TEST_KS: return "Kołmogorowa-Smirnowa";
        case TEST_CHI_SQUARE: return "Chi-kwadrat";
        case TEST_FISHER: return "Fishera";
        case TEST_ANDERSON_DARLING: return "Andersona-Darlinga";
        case TEST_SHAPIRO_WILK: return "Shapiro-Wilka";
        case TEST_JARQUE_BERA: return "Jarque-Bera";
        case TEST_DURBIN_WATSON: return "Durbina-Watsona";
        case TEST_BREUSCH_PAGAN: return "Breusch-Pagan";
        default: return "Nieznany";
    }
}

string EnumToString(ENUM_OPTIMIZATION_METHOD method) {
    switch(method) {
        case OPTIMIZATION_GRADIENT_DESCENT: return "Spadek gradientu";
        case OPTIMIZATION_NEWTON_RAPHSON: return "Newton-Raphson";
        case OPTIMIZATION_GENETIC_ALGORITHM: return "Algorytm genetyczny";
        case OPTIMIZATION_PARTICLE_SWARM: return "Rój cząstek";
        case OPTIMIZATION_SIMULATED_ANNEALING: return "Symulowane wyżarzanie";
        case OPTIMIZATION_BRENT: return "Brent";
        case OPTIMIZATION_GOLDEN_SECTION: return "Złoty podział";
        case OPTIMIZATION_BISECTION: return "Bisekcja";
        case OPTIMIZATION_SECANT: return "Sieczne";
        case OPTIMIZATION_LEVENBERG_MARQUARDT: return "Levenberg-Marquardt";
        default: return "Nieznany";
    }
}

// Funkcja do generowania raportu statystyk opisowych
string GenerateDescriptiveStatsReport(SDescriptiveStats &stats) {
    string report = "=== STATYSTYKI OPISOWE ===\n";
    report += "Rozmiar próby: " + IntegerToString(stats.sample_size) + "\n";
    report += "Średnia: " + DoubleToString(stats.mean, 6) + "\n";
    report += "Mediana: " + DoubleToString(stats.median, 6) + "\n";
    report += "Odchylenie standardowe: " + DoubleToString(stats.standard_deviation, 6) + "\n";
    report += "Wariancja: " + DoubleToString(stats.variance, 6) + "\n";
    report += "Skośność: " + DoubleToString(stats.skewness, 6) + "\n";
    report += "Kurtoza: " + DoubleToString(stats.kurtosis, 6) + "\n";
    report += "Minimum: " + DoubleToString(stats.min_value, 6) + "\n";
    report += "Maksimum: " + DoubleToString(stats.max_value, 6) + "\n";
    report += "Zakres: " + DoubleToString(stats.range, 6) + "\n";
    report += "Q1: " + DoubleToString(stats.q1, 6) + "\n";
    report += "Q3: " + DoubleToString(stats.q3, 6) + "\n";
    report += "IQR: " + DoubleToString(stats.iqr, 6) + "\n";
    report += "CV: " + DoubleToString(stats.cv, 6) + "\n";
    report += "MAD: " + DoubleToString(stats.mad, 6) + "\n";
    report += "Czas obliczenia: " + TimeToString(stats.calculation_time) + "\n";
    
    return report;
}

// Funkcja do generowania raportu testu statystycznego
string GenerateStatisticalTestReport(SStatisticalTestResult &result) {
    string report = "=== WYNIK TESTU STATYSTYCZNEGO ===\n";
    report += "Typ testu: " + EnumToString(result.test_type) + "\n";
    report += "Statystyka testowa: " + DoubleToString(result.test_statistic, 6) + "\n";
    report += "Wartość p: " + DoubleToString(result.p_value, 6) + "\n";
    report += "Wartość krytyczna: " + DoubleToString(result.critical_value, 6) + "\n";
    report += "Poziom ufności: " + DoubleToString(result.confidence_level * 100, 1) + "%\n";
    report += "Decyzja: " + (result.reject_null_hypothesis ? "ODRZUĆ H0" : "NIE ODRZUCAJ H0") + "\n";
    report += "Interpretacja: " + result.interpretation + "\n";
    report += "Czas testu: " + TimeToString(result.test_time) + "\n";
    
    return report;
}

// Funkcja do generowania raportu optymalizacji
string GenerateOptimizationReport(SOptimizationResult &result) {
    string report = "=== WYNIK OPTYMALIZACJI ===\n";
    report += "Metoda: " + EnumToString(result.method) + "\n";
    report += "Wartość optymalna: " + DoubleToString(result.optimal_value, 6) + "\n";
    report += "Liczba iteracji: " + IntegerToString(result.iterations) + "\n";
    report += "Błąd zbieżności: " + DoubleToString(result.convergence_error, 6) + "\n";
    report += "Zbieżność: " + (result.converged ? "TAK" : "NIE") + "\n";
    report += "Czas wykonania: " + DoubleToString(result.execution_time, 3) + "s\n";
    report += "Status: " + result.status_message + "\n";
    
    return report;
}

// Funkcja do normalizacji danych (min-max)
void NormalizeData(double &data[], double min_val = 0.0, double max_val = 1.0) {
    int n = ArraySize(data);
    if(n < 2) return;
    
    double data_min = data[0], data_max = data[0];
    
    // Znalezienie min i max
    for(int i = 1; i < n; i++) {
        if(data[i] < data_min) data_min = data[i];
        if(data[i] > data_max) data_max = data[i];
    }
    
    if(data_max == data_min) {
        // Wszystkie wartości są identyczne
        for(int i = 0; i < n; i++) {
            data[i] = (min_val + max_val) / 2.0;
        }
        return;
    }
    
    // Normalizacja
    double range = data_max - data_min;
    double target_range = max_val - min_val;
    
    for(int i = 0; i < n; i++) {
        data[i] = min_val + (data[i] - data_min) * target_range / range;
    }
}

// Funkcja do standaryzacji danych (z-score)
void StandardizeData(double &data[]) {
    int n = ArraySize(data);
    if(n < 2) return;
    
    // Obliczenie średniej
    double mean = 0.0;
    for(int i = 0; i < n; i++) {
        mean += data[i];
    }
    mean /= n;
    
    // Obliczenie odchylenia standardowego
    double variance = 0.0;
    for(int i = 0; i < n; i++) {
        variance += MathPow(data[i] - mean, 2);
    }
    variance /= n;
    double std_dev = MathSqrt(variance);
    
    if(std_dev == 0) return; // Wszystkie wartości są identyczne
    
    // Standaryzacja
    for(int i = 0; i < n; i++) {
        data[i] = (data[i] - mean) / std_dev;
    }
}

// Funkcja do obliczania percentyli
double CalculatePercentile(double &data[], double percentile) {
    int n = ArraySize(data);
    if(n == 0) return 0.0;
    if(n == 1) return data[0];
    
    if(percentile <= 0) return data[0];
    if(percentile >= 100) return data[n-1];
    
    // Sortowanie danych
    double sorted_data[];
    ArrayCopy(sorted_data, data);
    ArraySort(sorted_data);
    
    // Obliczenie pozycji
    double position = (percentile / 100.0) * (n - 1);
    int lower_index = (int)MathFloor(position);
    int upper_index = (int)MathCeil(position);
    
    if(lower_index == upper_index) {
        return sorted_data[lower_index];
    }
    
    // Interpolacja liniowa
    double weight = position - lower_index;
    return sorted_data[lower_index] * (1.0 - weight) + sorted_data[upper_index] * weight;
}

// Funkcja do obliczania mody (dominanty)
double CalculateMode(double &data[]) {
    int n = ArraySize(data);
    if(n == 0) return 0.0;
    if(n == 1) return data[0];
    
    // Sortowanie danych
    double sorted_data[];
    ArrayCopy(sorted_data, data);
    ArraySort(sorted_data);
    
    // Znalezienie najczęściej występującej wartości
    double current_value = sorted_data[0];
    int current_count = 1;
    double mode_value = current_value;
    int max_count = current_count;
    
    for(int i = 1; i < n; i++) {
        if(sorted_data[i] == current_value) {
            current_count++;
        } else {
            if(current_count > max_count) {
                max_count = current_count;
                mode_value = current_value;
            }
            current_value = sorted_data[i];
            current_count = 1;
        }
    }
    
    // Sprawdzenie ostatniej grupy
    if(current_count > max_count) {
        mode_value = current_value;
    }
    
    return mode_value;
}

// Funkcja do obliczania średniej geometrycznej
double CalculateGeometricMean(double &data[]) {
    int n = ArraySize(data);
    if(n == 0) return 0.0;
    
    double product = 1.0;
    int positive_count = 0;
    
    for(int i = 0; i < n; i++) {
        if(data[i] > 0) {
            product *= data[i];
            positive_count++;
        }
    }
    
    if(positive_count == 0) return 0.0;
    
    return MathPow(product, 1.0 / positive_count);
}

// Funkcja do obliczania średniej harmonicznej
double CalculateHarmonicMean(double &data[]) {
    int n = ArraySize(data);
    if(n == 0) return 0.0;
    
    double sum_reciprocals = 0.0;
    int positive_count = 0;
    
    for(int i = 0; i < n; i++) {
        if(data[i] > 0) {
            sum_reciprocals += 1.0 / data[i];
            positive_count++;
        }
    }
    
    if(positive_count == 0) return 0.0;
    
    return positive_count / sum_reciprocals;
}

// Funkcja do obliczania średniej ucinanej
double CalculateTrimmedMean(double &data[], double trim_percent = 5.0) {
    int n = ArraySize(data);
    if(n == 0) return 0.0;
    
    // Sortowanie danych
    double sorted_data[];
    ArrayCopy(sorted_data, data);
    ArraySort(sorted_data);
    
    // Obliczenie liczby elementów do usunięcia
    int trim_count = (int)MathRound(n * trim_percent / 100.0);
    int start_index = trim_count;
    int end_index = n - trim_count - 1;
    
    if(start_index > end_index) {
        start_index = end_index = n / 2;
    }
    
    // Obliczenie średniej ucinanej
    double sum = 0.0;
    int count = 0;
    
    for(int i = start_index; i <= end_index; i++) {
        sum += sorted_data[i];
        count++;
    }
    
    return count > 0 ? sum / count : 0.0;
}

// === ANALIZA SZEREGÓW CZASOWYCH ===

// Funkcja do obliczania średniej ruchomej
void CalculateMovingAverage(double &data[], double &ma[], int period) {
    int n = ArraySize(data);
    if(n < period || period < 1) return;
    
    ArrayResize(ma, n);
    ArrayInitialize(ma, 0.0);
    
    // Obliczenie średniej ruchomej
    for(int i = period - 1; i < n; i++) {
        double sum = 0.0;
        for(int j = 0; j < period; j++) {
            sum += data[i - j];
        }
        ma[i] = sum / period;
    }
}

// Funkcja do obliczania wykładniczej średniej ruchomej (EMA)
void CalculateEMA(double &data[], double &ema[], int period, double alpha = -1.0) {
    int n = ArraySize(data);
    if(n < 1 || period < 1) return;
    
    ArrayResize(ema, n);
    ArrayInitialize(ema, 0.0);
    
    // Obliczenie współczynnika alpha
    if(alpha < 0) {
        alpha = 2.0 / (period + 1.0);
    }
    
    // Pierwsza wartość EMA
    ema[0] = data[0];
    
    // Obliczenie pozostałych wartości EMA
    for(int i = 1; i < n; i++) {
        ema[i] = alpha * data[i] + (1.0 - alpha) * ema[i - 1];
    }
}

// Funkcja do obliczania średniej ruchomej ważonej (WMA)
void CalculateWMA(double &data[], double &wma[], int period) {
    int n = ArraySize(data);
    if(n < period || period < 1) return;
    
    ArrayResize(wma, n);
    ArrayInitialize(wma, 0.0);
    
    // Suma wag
    double weight_sum = period * (period + 1) / 2.0;
    
    // Obliczenie WMA
    for(int i = period - 1; i < n; i++) {
        double sum = 0.0;
        for(int j = 0; j < period; j++) {
            sum += (j + 1) * data[i - j];
        }
        wma[i] = sum / weight_sum;
    }
}

// Funkcja do obliczania średniej ruchomej Hull (HMA)
void CalculateHMA(double &data[], double &hma[], int period) {
    int n = ArraySize(data);
    if(n < period || period < 1) return;
    
    ArrayResize(hma, n);
    ArrayInitialize(hma, 0.0);
    
    int half_period = period / 2;
    int sqrt_period = (int)MathSqrt(period);
    
    if(half_period < 1 || sqrt_period < 1) return;
    
    // WMA(period/2) - WMA(period)
    double wma1[], wma2[];
    CalculateWMA(data, wma1, half_period);
    CalculateWMA(data, wma2, period);
    
    // 2 * WMA(period/2) - WMA(period)
    double raw_hma[];
    ArrayResize(raw_hma, n);
    for(int i = 0; i < n; i++) {
        raw_hma[i] = 2.0 * wma1[i] - wma2[i];
    }
    
    // WMA(sqrt(period)) z raw_hma
    CalculateWMA(raw_hma, hma, sqrt_period);
}

// Funkcja do obliczania Bollinger Bands
void CalculateBollingerBands(double &data[], double &upper[], double &middle[], double &lower[], int period, double std_dev_multiplier = 2.0) {
    int n = ArraySize(data);
    if(n < period || period < 1) return;
    
    ArrayResize(upper, n);
    ArrayResize(middle, n);
    ArrayResize(lower, n);
    ArrayInitialize(upper, 0.0);
    ArrayInitialize(middle, 0.0);
    ArrayInitialize(lower, 0.0);
    
    // Obliczenie Bollinger Bands
    for(int i = period - 1; i < n; i++) {
        // Średnia
        double sum = 0.0;
        for(int j = 0; j < period; j++) {
            sum += data[i - j];
        }
        middle[i] = sum / period;
        
        // Odchylenie standardowe
        double variance = 0.0;
        for(int j = 0; j < period; j++) {
            variance += MathPow(data[i - j] - middle[i], 2);
        }
        double std_dev = MathSqrt(variance / period);
        
        // Górna i dolna linia
        upper[i] = middle[i] + std_dev_multiplier * std_dev;
        lower[i] = middle[i] - std_dev_multiplier * std_dev;
    }
}

// Funkcja do obliczania RSI (Relative Strength Index)
void CalculateRSI(double &data[], double &rsi[], int period) {
    int n = ArraySize(data);
    if(n < period + 1 || period < 1) return;
    
    ArrayResize(rsi, n);
    ArrayInitialize(rsi, 0.0);
    
    // Obliczenie zmian
    double gains[], losses[];
    ArrayResize(gains, n);
    ArrayResize(losses, n);
    ArrayInitialize(gains, 0.0);
    ArrayInitialize(losses, 0.0);
    
    for(int i = 1; i < n; i++) {
        double change = data[i] - data[i - 1];
        if(change > 0) {
            gains[i] = change;
        } else {
            losses[i] = -change;
        }
    }
    
    // Obliczenie średnich zysków i strat
    double avg_gain = 0.0, avg_loss = 0.0;
    
    // Pierwsza średnia
    for(int i = 1; i <= period; i++) {
        avg_gain += gains[i];
        avg_loss += losses[i];
    }
    avg_gain /= period;
    avg_loss /= period;
    
    // Pierwsza wartość RSI
    if(avg_loss > 0) {
        rsi[period] = 100.0 - (100.0 / (1.0 + avg_gain / avg_loss));
    } else {
        rsi[period] = 100.0;
    }
    
    // Pozostałe wartości RSI
    for(int i = period + 1; i < n; i++) {
        avg_gain = (avg_gain * (period - 1) + gains[i]) / period;
        avg_loss = (avg_loss * (period - 1) + losses[i]) / period;
        
        if(avg_loss > 0) {
            rsi[i] = 100.0 - (100.0 / (1.0 + avg_gain / avg_loss));
        } else {
            rsi[i] = 100.0;
        }
    }
}

// Funkcja do obliczania MACD (Moving Average Convergence Divergence)
void CalculateMACD(double &data[], double &macd[], double &signal[], double &histogram[], int fast_period = 12, int slow_period = 26, int signal_period = 9) {
    int n = ArraySize(data);
    if(n < slow_period || fast_period >= slow_period) return;
    
    ArrayResize(macd, n);
    ArrayResize(signal, n);
    ArrayResize(histogram, n);
    ArrayInitialize(macd, 0.0);
    ArrayInitialize(signal, 0.0);
    ArrayInitialize(histogram, 0.0);
    
    // Obliczenie EMA dla szybkiej i wolnej linii
    double fast_ema[], slow_ema[];
    CalculateEMA(data, fast_ema, fast_period);
    CalculateEMA(data, slow_ema, slow_period);
    
    // Obliczenie MACD
    for(int i = 0; i < n; i++) {
        macd[i] = fast_ema[i] - slow_ema[i];
    }
    
    // Obliczenie linii sygnału (EMA z MACD)
    double macd_ema[];
    CalculateEMA(macd, macd_ema, signal_period);
    ArrayCopy(signal, macd_ema);
    
    // Obliczenie histogramu
    for(int i = 0; i < n; i++) {
        histogram[i] = macd[i] - signal[i];
    }
}

// Funkcja do obliczania Stochastic Oscillator
void CalculateStochastic(double &highs[], double &lows[], double &closes[], double &k_percent[], double &d_percent[], int period = 14, int smooth_period = 3) {
    int n = ArraySize(closes);
    if(n < period || period < 1) return;
    
    ArrayResize(k_percent, n);
    ArrayResize(d_percent, n);
    ArrayInitialize(k_percent, 0.0);
    ArrayInitialize(d_percent, 0.0);
    
    // Obliczenie %K
    for(int i = period - 1; i < n; i++) {
        double highest_high = highs[i];
        double lowest_low = lows[i];
        
        // Znalezienie najwyższego high i najniższego low w okresie
        for(int j = 0; j < period; j++) {
            if(highs[i - j] > highest_high) highest_high = highs[i - j];
            if(lows[i - j] < lowest_low) lowest_low = lows[i - j];
        }
        
        if(highest_high != lowest_low) {
            k_percent[i] = 100.0 * (closes[i] - lowest_low) / (highest_high - lowest_low);
        } else {
            k_percent[i] = 50.0;
        }
    }
    
    // Obliczenie %D (SMA z %K)
    double k_sma[];
    CalculateMovingAverage(k_percent, k_sma, smooth_period);
    ArrayCopy(d_percent, k_sma);
}

// Funkcja do obliczania Williams %R
void CalculateWilliamsR(double &highs[], double &lows[], double &closes[], double &williams_r[], int period = 14) {
    int n = ArraySize(closes);
    if(n < period || period < 1) return;
    
    ArrayResize(williams_r, n);
    ArrayInitialize(williams_r, 0.0);
    
    for(int i = period - 1; i < n; i++) {
        double highest_high = highs[i];
        double lowest_low = lows[i];
        
        // Znalezienie najwyższego high i najniższego low w okresie
        for(int j = 0; j < period; j++) {
            if(highs[i - j] > highest_high) highest_high = highs[i - j];
            if(lows[i - j] < lowest_low) lowest_low = lows[i - j];
        }
        
        if(highest_high != lowest_low) {
            williams_r[i] = -100.0 * (highest_high - closes[i]) / (highest_high - lowest_low);
        } else {
            williams_r[i] = -50.0;
        }
    }
}

// Funkcja do obliczania ATR (Average True Range)
void CalculateATR(double &highs[], double &lows[], double &closes[], double &atr[], int period = 14) {
    int n = ArraySize(closes);
    if(n < period + 1 || period < 1) return;
    
    ArrayResize(atr, n);
    ArrayInitialize(atr, 0.0);
    
    // Obliczenie True Range
    double true_ranges[];
    ArrayResize(true_ranges, n);
    ArrayInitialize(true_ranges, 0.0);
    
    for(int i = 1; i < n; i++) {
        double tr1 = highs[i] - lows[i];
        double tr2 = MathAbs(highs[i] - closes[i - 1]);
        double tr3 = MathAbs(lows[i] - closes[i - 1]);
        true_ranges[i] = MathMax(tr1, MathMax(tr2, tr3));
    }
    
    // Obliczenie ATR (EMA z True Range)
    CalculateEMA(true_ranges, atr, period);
}

// Funkcja do obliczania ADX (Average Directional Index)
void CalculateADX(double &highs[], double &lows[], double &closes[], double &adx[], int period = 14) {
    int n = ArraySize(closes);
    if(n < period + 1 || period < 1) return;
    
    ArrayResize(adx, n);
    ArrayInitialize(adx, 0.0);
    
    // Obliczenie +DM i -DM
    double plus_dm[], minus_dm[];
    ArrayResize(plus_dm, n);
    ArrayResize(minus_dm, n);
    ArrayInitialize(plus_dm, 0.0);
    ArrayInitialize(minus_dm, 0.0);
    
    for(int i = 1; i < n; i++) {
        double high_diff = highs[i] - highs[i - 1];
        double low_diff = lows[i - 1] - lows[i];
        
        if(high_diff > low_diff && high_diff > 0) {
            plus_dm[i] = high_diff;
        }
        
        if(low_diff > high_diff && low_diff > 0) {
            minus_dm[i] = low_diff;
        }
    }
    
    // Obliczenie ATR
    double atr[];
    CalculateATR(highs, lows, closes, atr, period);
    
    // Obliczenie +DI i -DI
    double plus_di[], minus_di[];
    ArrayResize(plus_di, n);
    ArrayResize(minus_di, n);
    ArrayInitialize(plus_di, 0.0);
    ArrayInitialize(minus_di, 0.0);
    
    double plus_dm_ema[], minus_dm_ema[];
    CalculateEMA(plus_dm, plus_dm_ema, period);
    CalculateEMA(minus_dm, minus_dm_ema, period);
    
    for(int i = 0; i < n; i++) {
        if(atr[i] > 0) {
            plus_di[i] = 100.0 * plus_dm_ema[i] / atr[i];
            minus_di[i] = 100.0 * minus_dm_ema[i] / atr[i];
        }
    }
    
    // Obliczenie DX i ADX
    double dx[];
    ArrayResize(dx, n);
    ArrayInitialize(dx, 0.0);
    
    for(int i = 0; i < n; i++) {
        double di_sum = plus_di[i] + minus_di[i];
        if(di_sum > 0) {
            dx[i] = 100.0 * MathAbs(plus_di[i] - minus_di[i]) / di_sum;
        }
    }
    
    // ADX to EMA z DX
    CalculateEMA(dx, adx, period);
}

// === FUNKCJE KOŃCOWE I ZAMYKANIE ===

// Funkcja do generowania podsumowania MathUtils
string GenerateMathUtilsSummary() {
    string summary = "=== MATH UTILS - PODSUMOWANIE ===\n";
    summary += "📊 Funkcje statystyczne:\n";
    summary += "   • Statystyki opisowe (średnia, mediana, skośność, kurtoza)\n";
    summary += "   • Korelacje (Pearson, Spearman)\n";
    summary += "   • Autokorelacja (ACF, PACF)\n";
    summary += "   • Entropie (Shannon, Rényi, Tsallis)\n";
    summary += "   • Współczynnik Hursta\n\n";
    
    summary += "🧪 Testy statystyczne:\n";
    summary += "   • Test t-Studenta (jedna i dwie próby)\n";
    summary += "   • Test Kołmogorowa-Smirnowa\n";
    summary += "   • Test Jarque-Bera (normalność)\n";
    summary += "   • Test Durbina-Watsona (autokorelacja)\n";
    summary += "   • Test chi-kwadrat (dobroć dopasowania)\n";
    summary += "   • Test Wilcoxona (nieparametryczny)\n\n";
    
    summary += "⚡ Optymalizacja:\n";
    summary += "   • Złoty podział\n";
    summary += "   • Bisekcja\n";
    summary += "   • Spadek gradientu\n";
    summary += "   • Interpolacja (Lagrange, Spline)\n";
    summary += "   • Całkowanie numeryczne (Trapezy, Simpson)\n";
    summary += "   • Pochodne numeryczne\n\n";
    
    summary += "🔢 Algebra liniowa:\n";
    summary += "   • Rozwiązywanie układów równań (Gauss)\n";
    summary += "   • Wyznacznik macierzy\n";
    summary += "   • Macierz odwrotna\n";
    summary += "   • Wartości własne\n\n";
    
    summary += "📈 Analiza szeregów czasowych:\n";
    summary += "   • Średnie ruchome (SMA, EMA, WMA, HMA)\n";
    summary += "   • Bollinger Bands\n";
    summary += "   • RSI, MACD, Stochastic\n";
    summary += "   • Williams %R, ATR, ADX\n\n";
    
    summary += "🛠️ Funkcje pomocnicze:\n";
    summary += "   • Normalizacja i standaryzacja danych\n";
    summary += "   • Obliczanie percentyli i mody\n";
    summary += "   • Średnie (geometryczna, harmoniczna, ucinana)\n";
    summary += "   • Generowanie raportów\n";
    
    return summary;
}

// Funkcja do walidacji danych wejściowych
bool ValidateInputData(double &data[], string &error_message) {
    int n = ArraySize(data);
    
    if(n == 0) {
        error_message = "Tablica danych jest pusta";
        return false;
    }
    
    // Sprawdzenie wartości NaN i nieskończonych
    for(int i = 0; i < n; i++) {
        if(MathIsValidNumber(data[i]) == false) {
            error_message = "Znaleziono nieprawidłową wartość w pozycji " + IntegerToString(i);
            return false;
        }
    }
    
    error_message = "Dane są prawidłowe";
    return true;
}

// Funkcja do sprawdzania konwergencji algorytmów
bool CheckConvergence(double &values[], double tolerance = 1e-6, int min_iterations = 5) {
    int n = ArraySize(values);
    
    if(n < min_iterations) return false;
    
    // Sprawdzenie czy ostatnie wartości są stabilne
    double last_value = values[n - 1];
    
    for(int i = n - min_iterations; i < n; i++) {
        if(MathAbs(values[i] - last_value) > tolerance) {
            return false;
        }
    }
    
    return true;
}

// Funkcja do obliczania czasu wykonania
double MeasureExecutionTime(datetime start_time) {
    return (double)(TimeCurrent() - start_time);
}

// Funkcja do formatowania czasu
string FormatExecutionTime(double seconds) {
    if(seconds < 1.0) {
        return DoubleToString(seconds * 1000.0, 2) + " ms";
    } else if(seconds < 60.0) {
        return DoubleToString(seconds, 3) + " s";
    } else {
        int minutes = (int)(seconds / 60.0);
        double remaining_seconds = seconds - minutes * 60.0;
        return IntegerToString(minutes) + "m " + DoubleToString(remaining_seconds, 1) + "s";
    }
}

// Funkcja do generowania losowych danych testowych
void GenerateRandomTestData(double &data[], int size, double min_val = 0.0, double max_val = 100.0, bool normal_distribution = true) {
    ArrayResize(data, size);
    
    if(normal_distribution) {
        // Generowanie danych z rozkładu normalnego
        for(int i = 0; i < size; i++) {
            double u1 = (MathRand() % 1000) / 1000.0;
            double u2 = (MathRand() % 1000) / 1000.0;
            
            // Transformacja Box-Muller
            double z = MathSqrt(-2.0 * MathLog(u1)) * MathCos(2.0 * M_PI * u2);
            
            // Skalowanie do zakresu [min_val, max_val]
            data[i] = min_val + (max_val - min_val) * (z + 3.0) / 6.0;
            data[i] = MathMax(min_val, MathMin(max_val, data[i]));
        }
    } else {
        // Generowanie danych z rozkładu jednostajnego
        for(int i = 0; i < size; i++) {
            data[i] = min_val + (max_val - min_val) * (MathRand() % 1000) / 1000.0;
        }
    }
}

// Funkcja do generowania trendu liniowego
void GenerateLinearTrend(double &data[], int size, double start_value, double slope) {
    ArrayResize(data, size);
    
    for(int i = 0; i < size; i++) {
        data[i] = start_value + slope * i;
    }
}

// Funkcja do generowania danych sinusoidalnych
void GenerateSinusoidalData(double &data[], int size, double amplitude, double frequency, double phase = 0.0) {
    ArrayResize(data, size);
    
    for(int i = 0; i < size; i++) {
        data[i] = amplitude * MathSin(2.0 * M_PI * frequency * i / size + phase);
    }
}

// Funkcja do dodawania szumu do danych
void AddNoise(double &data[], double noise_level = 0.1) {
    int n = ArraySize(data);
    
    for(int i = 0; i < n; i++) {
        double noise = (MathRand() % 1000) / 1000.0 - 0.5;
        data[i] += noise_level * noise;
    }
}

// Funkcja do obliczania błędu średniokwadratowego (MSE)
double CalculateMSE(double &actual[], double &predicted[]) {
    int n = ArraySize(actual);
    int m = ArraySize(predicted);
    
    if(n != m || n == 0) return 0.0;
    
    double mse = 0.0;
    for(int i = 0; i < n; i++) {
        mse += MathPow(actual[i] - predicted[i], 2);
    }
    
    return mse / n;
}

// Funkcja do obliczania błędu średniego bezwzględnego (MAE)
double CalculateMAE(double &actual[], double &predicted[]) {
    int n = ArraySize(actual);
    int m = ArraySize(predicted);
    
    if(n != m || n == 0) return 0.0;
    
    double mae = 0.0;
    for(int i = 0; i < n; i++) {
        mae += MathAbs(actual[i] - predicted[i]);
    }
    
    return mae / n;
}

// Funkcja do obliczania współczynnika determinacji (R²)
double CalculateRSquared(double &actual[], double &predicted[]) {
    int n = ArraySize(actual);
    int m = ArraySize(predicted);
    
    if(n != m || n < 2) return 0.0;
    
    // Średnia z rzeczywistych wartości
    double mean_actual = 0.0;
    for(int i = 0; i < n; i++) {
        mean_actual += actual[i];
    }
    mean_actual /= n;
    
    // Suma kwadratów całkowita (TSS)
    double tss = 0.0;
    for(int i = 0; i < n; i++) {
        tss += MathPow(actual[i] - mean_actual, 2);
    }
    
    // Suma kwadratów reszt (RSS)
    double rss = 0.0;
    for(int i = 0; i < n; i++) {
        rss += MathPow(actual[i] - predicted[i], 2);
    }
    
    if(tss == 0) return 0.0;
    
    return 1.0 - (rss / tss);
}

// Funkcja do obliczania MAPE (Mean Absolute Percentage Error)
double CalculateMAPE(double &actual[], double &predicted[]) {
    int n = ArraySize(actual);
    int m = ArraySize(predicted);
    
    if(n != m || n == 0) return 0.0;
    
    double mape = 0.0;
    int valid_count = 0;
    
    for(int i = 0; i < n; i++) {
        if(actual[i] != 0) {
            mape += MathAbs((actual[i] - predicted[i]) / actual[i]);
            valid_count++;
        }
    }
    
    return valid_count > 0 ? (mape / valid_count) * 100.0 : 0.0;
}

// Funkcja do obliczania symetrycznego MAPE (sMAPE)
double CalculateSMAPE(double &actual[], double &predicted[]) {
    int n = ArraySize(actual);
    int m = ArraySize(predicted);
    
    if(n != m || n == 0) return 0.0;
    
    double smape = 0.0;
    int valid_count = 0;
    
    for(int i = 0; i < n; i++) {
        double denominator = MathAbs(actual[i]) + MathAbs(predicted[i]);
        if(denominator != 0) {
            smape += 2.0 * MathAbs(predicted[i] - actual[i]) / denominator;
            valid_count++;
        }
    }
    
    return valid_count > 0 ? (smape / valid_count) * 100.0 : 0.0;
}

// Funkcja do generowania raportu błędów predykcji
string GeneratePredictionErrorReport(double &actual[], double &predicted[]) {
    string report = "=== RAPORT BŁĘDÓW PREDYKCJI ===\n";
    
    double mse = CalculateMSE(actual, predicted);
    double mae = CalculateMAE(actual, predicted);
    double r_squared = CalculateRSquared(actual, predicted);
    double mape = CalculateMAPE(actual, predicted);
    double smape = CalculateSMAPE(actual, predicted);
    
    report += "MSE (Mean Squared Error): " + DoubleToString(mse, 6) + "\n";
    report += "MAE (Mean Absolute Error): " + DoubleToString(mae, 6) + "\n";
    report += "R² (Coefficient of Determination): " + DoubleToString(r_squared, 6) + "\n";
    report += "MAPE (Mean Absolute Percentage Error): " + DoubleToString(mape, 2) + "%\n";
    report += "sMAPE (Symmetric MAPE): " + DoubleToString(smape, 2) + "%\n";
    
    // Interpretacja R²
    if(r_squared >= 0.9) {
        report += "Interpretacja R²: Doskonałe dopasowanie (≥90%)\n";
    } else if(r_squared >= 0.7) {
        report += "Interpretacja R²: Dobre dopasowanie (70-90%)\n";
    } else if(r_squared >= 0.5) {
        report += "Interpretacja R²: Umiarkowane dopasowanie (50-70%)\n";
    } else {
        report += "Interpretacja R²: Słabe dopasowanie (<50%)\n";
    }
    
    return report;
}

// Funkcja do eksportu danych do CSV
bool ExportDataToCSV(double &data[], string filename, string header = "Value") {
    int handle = FileOpen(filename, FILE_WRITE | FILE_CSV);
    
    if(handle == INVALID_HANDLE) {
        return false;
    }
    
    // Nagłówek
    FileWrite(handle, "Index", header);
    
    // Dane
    int n = ArraySize(data);
    for(int i = 0; i < n; i++) {
        FileWrite(handle, i, data[i]);
    }
    
    FileClose(handle);
    return true;
}

// Funkcja do eksportu wielu serii danych do CSV
bool ExportMultipleDataToCSV(double &data1[], double &data2[], double &data3[], string filename, 
                            string header1 = "Series1", string header2 = "Series2", string header3 = "Series3") {
    int handle = FileOpen(filename, FILE_WRITE | FILE_CSV);
    
    if(handle == INVALID_HANDLE) {
        return false;
    }
    
    int n1 = ArraySize(data1);
    int n2 = ArraySize(data2);
    int n3 = ArraySize(data3);
    int max_n = MathMax(n1, MathMax(n2, n3));
    
    // Nagłówek
    FileWrite(handle, "Index", header1, header2, header3);
    
    // Dane
    for(int i = 0; i < max_n; i++) {
        double val1 = (i < n1) ? data1[i] : 0.0;
        double val2 = (i < n2) ? data2[i] : 0.0;
        double val3 = (i < n3) ? data3[i] : 0.0;
        FileWrite(handle, i, val1, val2, val3);
    }
    
    FileClose(handle);
    return true;
}

// Funkcja do wczytywania danych z CSV
bool ImportDataFromCSV(string filename, double &data[]) {
    int handle = FileOpen(filename, FILE_READ | FILE_CSV);
    
    if(handle == INVALID_HANDLE) {
        return false;
    }
    
    // Pominięcie nagłówka
    FileReadString(handle);
    
    // Wczytywanie danych
    int count = 0;
    while(!FileIsEnding(handle)) {
        string line = FileReadString(handle);
        if(line != "") {
            ArrayResize(data, count + 1);
            data[count] = StringToDouble(line);
            count++;
        }
    }
    
    FileClose(handle);
    return count > 0;
}

// Funkcja do generowania wykresu ASCII (uproszczony)
string GenerateASCIIChart(double &data[], int width = 50, int height = 20) {
    int n = ArraySize(data);
    if(n == 0) return "Brak danych";
    
    // Znalezienie min i max
    double min_val = data[0], max_val = data[0];
    for(int i = 1; i < n; i++) {
        if(data[i] < min_val) min_val = data[i];
        if(data[i] > max_val) max_val = data[i];
    }
    
    if(max_val == min_val) {
        return "Wszystkie wartości są identyczne: " + DoubleToString(min_val, 2);
    }
    
    string chart = "Wykres ASCII (min: " + DoubleToString(min_val, 2) + 
                   ", max: " + DoubleToString(max_val, 2) + ")\n";
    chart += "┌" + StringRepeat("─", width) + "┐\n";
    
    // Generowanie wykresu
    for(int y = height - 1; y >= 0; y--) {
        chart += "│";
        for(int x = 0; x < width; x++) {
            int data_index = (int)(x * n / width);
            if(data_index >= n) data_index = n - 1;
            
            double normalized_y = (data[data_index] - min_val) / (max_val - min_val);
            int chart_y = (int)(normalized_y * height);
            
            if(y == chart_y) {
                chart += "●";
            } else if(y < chart_y) {
                chart += " ";
            } else {
                chart += " ";
            }
        }
        chart += "│\n";
    }
    
    chart += "└" + StringRepeat("─", width) + "┘\n";
    
    return chart;
}

// Funkcja pomocnicza do powtarzania stringów
string StringRepeat(string str, int count) {
    string result = "";
    for(int i = 0; i < count; i++) {
        result += str;
    }
    return result;
}

// Funkcja do konwersji string na double
double Util_StringToDouble(string str) { return StringToDouble(str); }

// Funkcja do konwersji double na string z określoną precyzją
string Util_DoubleToString(double value, int digits) { return DoubleToString(value, digits); }

// Funkcja do konwersji int na string
string Util_IntegerToString(int value) { return IntegerToString(value); }

// Funkcja do konwersji datetime na string
string Util_TimeToString(datetime time) { return TimeToString(time); }

// Funkcja do sprawdzania czy liczba jest prawidłowa
bool Util_MathIsValidNumber(double value) { return MathIsValidNumber(value); }

// Funkcja do obliczania wartości bezwzględnej
double Util_MathAbs(double value) { return MathAbs(value); }

// Funkcja do obliczania pierwiastka kwadratowego
double Util_MathSqrt(double value) { return MathSqrt(value); }

// Funkcja do obliczania potęgi
double Util_MathPow(double base, double exponent) { return MathPow(base, exponent); }

// Funkcja do obliczania logarytmu naturalnego
double Util_MathLog(double value) { return MathLog(value); }

// Funkcja do obliczania funkcji wykładniczej
double Util_MathExp(double value) { return MathExp(value); }

// Funkcja do obliczania funkcji sinus
double Util_MathSin(double value) { return MathSin(value); }

// Funkcja do obliczania funkcji cosinus
double Util_MathCos(double value) { return MathCos(value); }

// Funkcja do obliczania funkcji tangens
double Util_MathTan(double value) { return MathTan(value); }

// Funkcja do obliczania funkcji tangens hiperboliczny
double Util_MathTanh(double value) { return MathTanh(value); }

// Funkcja do obliczania funkcji arcus tangens
double Util_MathArctan(double value) { return MathArctan(value); }

// Funkcja do obliczania maksimum z dwóch wartości
double Util_MathMax(double value1, double value2) { return MathMax(value1, value2); }

// Funkcja do obliczania minimum z dwóch wartości
double Util_MathMin(double value1, double value2) { return MathMin(value1, value2); }

// Funkcja do zaokrąglania w górę
double Util_MathCeil(double value) { return MathCeil(value); }

// Funkcja do zaokrąglania w dół
double Util_MathFloor(double value) { return MathFloor(value); }

// Funkcja do zaokrąglania do najbliższej liczby całkowitej
double Util_MathRound(double value) { return MathRound(value); }

// Funkcja do generowania losowej liczby całkowitej
int Util_MathRand() { return MathRand(); }

// Funkcja do ustawienia seed dla generatora liczb losowych
void Util_MathSrand(int seed) { MathSrand(seed); }

// Stałe matematyczne
#define M_PI 3.14159265358979323846
#define M_E 2.71828182845904523536

//+------------------------------------------------------------------+
//| Initialize Math Utils                                            |
//+------------------------------------------------------------------+
bool InitializeMathUtils() {
    Print("🔢 Inicjalizacja Math Utils...");
    
    // Inicjalizacja generatora liczb losowych
    MathSrand((int)TimeCurrent());
    
    // Sprawdzenie dostępności podstawowych funkcji matematycznych
    if(!MathIsValidNumber(M_PI) || !MathIsValidNumber(M_E)) {
        Print("❌ Błąd inicjalizacji Math Utils - problem z stałymi matematycznymi");
        return false;
    }
    
    // Test podstawowych operacji matematycznych
    double test_result = MathPow(2, 3);
    if(test_result != 8.0) {
        Print("❌ Błąd inicjalizacji Math Utils - problem z funkcjami matematycznymi");
        return false;
    }
    
    Print("✅ Math Utils zainicjalizowane");
    return true;
}

//+------------------------------------------------------------------+
//| Global initialization function for Math Utils                    |
//+------------------------------------------------------------------+
bool InitializeGlobalMathUtils() {
    return InitializeMathUtils();
}

#endif // MATH_UTILS_H
