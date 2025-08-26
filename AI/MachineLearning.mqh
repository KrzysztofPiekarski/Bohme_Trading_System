#ifndef MACHINE_LEARNING_H
#define MACHINE_LEARNING_H

// ========================================
// MACHINE LEARNING - FUNDAMENT AI
// ========================================
// Podstawowe algorytmy uczenia maszynowego dla Systemu Böhmego
// Regresja, klasyfikacja, klasteryzacja, redukcja wymiarów

// === ENUMERACJE ===

// Typy algorytmów ML
enum ENUM_ML_ALGORITHM {
    ML_ALGORITHM_LINEAR_REGRESSION,      // Regresja liniowa
    ML_ALGORITHM_POLYNOMIAL_REGRESSION,  // Regresja wielomianowa
    ML_ALGORITHM_LOGISTIC_REGRESSION,    // Regresja logistyczna
    ML_ALGORITHM_RIDGE_REGRESSION,       // Regresja Ridge
    ML_ALGORITHM_LASSO_REGRESSION,       // Regresja Lasso
    ML_ALGORITHM_ELASTIC_NET,            // Elastic Net
    ML_ALGORITHM_SVR,                    // Support Vector Regression
    ML_ALGORITHM_DECISION_TREE,          // Drzewo decyzyjne
    ML_ALGORITHM_RANDOM_FOREST,          // Las losowy
    ML_ALGORITHM_KNN,                    // K-Nearest Neighbors
    ML_ALGORITHM_KMEANS,                 // K-Means Clustering
    ML_ALGORITHM_DBSCAN,                 // DBSCAN Clustering
    ML_ALGORITHM_PCA,                    // Principal Component Analysis
    ML_ALGORITHM_LDA,                    // Linear Discriminant Analysis
    ML_ALGORITHM_GRADIENT_BOOSTING,      // Gradient Boosting
    ML_ALGORITHM_XGBOOST,                // XGBoost
    ML_ALGORITHM_ADA_BOOST,              // AdaBoost
    ML_ALGORITHM_NAIVE_BAYES,            // Naive Bayes
    ML_ALGORITHM_SVM,                    // Support Vector Machine
    ML_ALGORITHM_NEURAL_NETWORK          // Sieć neuronowa
};

// Typy problemów ML
enum ENUM_ML_PROBLEM_TYPE {
    ML_PROBLEM_REGRESSION,               // Regresja
    ML_PROBLEM_CLASSIFICATION,           // Klasyfikacja
    ML_PROBLEM_CLUSTERING,               // Klasteryzacja
    ML_PROBLEM_DIMENSION_REDUCTION,      // Redukcja wymiarów
    ML_PROBLEM_ANOMALY_DETECTION,        // Wykrywanie anomalii
    ML_PROBLEM_TIME_SERIES,              // Szeregi czasowe
    ML_PROBLEM_REINFORCEMENT_LEARNING    // Uczenie przez wzmacnianie
};

// Metryki oceny modeli
enum ENUM_ML_METRIC {
    ML_METRIC_ACCURACY,                  // Dokładność
    ML_METRIC_PRECISION,                 // Precyzja
    ML_METRIC_RECALL,                    // Czułość
    ML_METRIC_F1_SCORE,                  // F1-Score
    ML_METRIC_ROC_AUC,                   // ROC AUC
    ML_METRIC_MAE,                       // Mean Absolute Error
    ML_METRIC_MSE,                       // Mean Squared Error
    ML_METRIC_RMSE,                      // Root Mean Squared Error
    ML_METRIC_R_SQUARED,                 // R-squared
    ML_METRIC_ADJUSTED_R_SQUARED,        // Adjusted R-squared
    ML_METRIC_SILHOUETTE_SCORE,          // Silhouette Score
    ML_METRIC_CALINSKI_HARABASZ_SCORE,   // Calinski-Harabasz Score
    ML_METRIC_DAVIES_BOULDIN_SCORE       // Davies-Bouldin Score
};

// Typy walidacji
enum ENUM_ML_VALIDATION {
    ML_VALIDATION_TRAIN_TEST,            // Train/Test split
    ML_VALIDATION_K_FOLD,                // K-Fold Cross Validation
    ML_VALIDATION_STRATIFIED_K_FOLD,     // Stratified K-Fold
    ML_VALIDATION_LEAVE_ONE_OUT,         // Leave-One-Out
    ML_VALIDATION_TIME_SERIES_SPLIT,     // Time Series Split
    ML_VALIDATION_BOOTSTRAP              // Bootstrap
};

// === STRUKTURY DANYCH ===

// Struktura danych treningowych - tylko podstawowe parametry
struct SMLDataset {
    int samples;                         // Liczba próbek
    int features_count;                  // Liczba cech
    bool is_classification;              // Czy to klasyfikacja
    int classes_count;                   // Liczba klas (dla klasyfikacji)
    bool is_time_series;                 // Czy to szereg czasowy
    bool has_weights;                    // Czy ma wagi
    
    // Data arrays - flattened for 2D access: features[sample * features_count + feature]
    double features[];                   // Cechy (spłaszczona macierz 2D)
    double targets[];                    // Cele/etykiety
    double weights[];                    // Wagi próbek (opcjonalne)
};

// Struktura parametrów modelu
struct SMLModelParams {
    ENUM_ML_ALGORITHM algorithm;         // Algorytm
    ENUM_ML_PROBLEM_TYPE problem_type;   // Typ problemu
    double learning_rate;                // Szybkość uczenia
    int max_iterations;                  // Maksymalna liczba iteracji
    double tolerance;                    // Tolerancja zbieżności
    double regularization_strength;      // Siła regularyzacji
    int random_state;                    // Ziarno losowości
    bool normalize_features;             // Czy normalizować cechy
    bool use_bias;                       // Czy używać bias
    double validation_split;             // Proporcja walidacji
    ENUM_ML_VALIDATION validation_type;  // Typ walidacji
    int k_folds;                         // Liczba foldów
    double early_stopping_patience;      // Cierpliwość early stopping
    bool verbose;                        // Czy wyświetlać postęp
    datetime training_start_time;        // Czas rozpoczęcia treningu
    datetime training_end_time;          // Czas zakończenia treningu
};

// Struktura wyników treningu
struct SMLTrainingResult {
    bool success;                        // Czy trening się powiódł
    double training_score;               // Wynik na zbiorze treningowym
    double validation_score;             // Wynik na zbiorze walidacyjnym
    double test_score;                   // Wynik na zbiorze testowym
    int iterations;                      // Liczba wykonanych iteracji
    double final_loss;                   // Końcowa funkcja straty
    double convergence_time;             // Czas zbieżności
    string error_message;                // Komunikat błędu
    double model_size;                   // Rozmiar modelu (MB)
    bool overfitting_detected;           // Czy wykryto overfitting
    double overfitting_score;            // Skala overfitting
    SMLModelParams params;               // Parametry modelu
    datetime training_time;              // Czas treningu
};

// Struktura predykcji
struct SMLPrediction {
    double predicted_value;              // Predykcja (regresja)
    int predicted_class;                 // Predykcja (klasyfikacja)
    double confidence;                   // Pewność predykcji
    double probabilities[];              // Prawdopodobieństwa klas
    double feature_importance[];         // Ważność cech
    double prediction_time;              // Czas predykcji
    bool is_anomaly;                     // Czy to anomalia
    double anomaly_score;                // Skala anomalii
    string explanation;                  // Wyjaśnienie predykcji
};

// Struktura oceny modelu
struct SMLModelEvaluation {
    double accuracy;                     // Dokładność
    double precision;                    // Precyzja
    double recall;                       // Czułość
    double f1_score;                     // F1-Score
    double roc_auc;                      // ROC AUC
    double mae;                          // Mean Absolute Error
    double mse;                          // Mean Squared Error
    double rmse;                         // Root Mean Squared Error
    double r_squared;                    // R-squared
    double adjusted_r_squared;           // Adjusted R-squared
    double silhouette_score;             // Silhouette Score
    double calinski_harabasz_score;      // Calinski-Harabasz Score
    double davies_bouldin_score;         // Davies-Bouldin Score
    string evaluation_summary;           // Podsumowanie oceny
    datetime evaluation_time;            // Czas oceny
};

// Struktura optymalizacji hiperparametrów
struct SMLHyperparameterOptimization {
    ENUM_ML_ALGORITHM algorithm;         // Algorytm do optymalizacji
    int max_trials;                      // Maksymalna liczba prób
    ENUM_ML_METRIC optimization_metric;  // Metryka optymalizacji
    ENUM_ML_VALIDATION validation_type;  // Typ walidacji
    int k_folds;                         // Liczba foldów
    bool random_search;                  // Czy używać random search
    int n_jobs;                          // Liczba równoległych zadań
    double best_score;                   // Najlepszy wynik
    int optimization_time;               // Czas optymalizacji
    bool optimization_success;           // Czy optymalizacja się powiodła
};

// === KLASA GŁÓWNA MACHINE LEARNING ===

class CMachineLearning {
private:
    // Dane i modele
    SMLDataset m_dataset;                // Zbiór danych
    SMLModelParams m_params;             // Parametry modelu
    SMLTrainingResult m_training_result; // Wyniki treningu
    SMLModelEvaluation m_evaluation;     // Ocena modelu
    
    // Wagi i parametry modelu
    double m_weights[];                  // Wagi modelu
    double m_bias;                       // Bias modelu
    double m_feature_scaler[];           // Skalowanie cech
    double m_feature_means[];            // Średnie cech
    double m_feature_stds[];             // Odchylenia standardowe cech
    
    // Cache i buforowanie
    double m_prediction_cache[];         // Cache predykcji
    bool m_model_trained;                // Czy model jest wytrenowany
    bool m_features_normalized;          // Czy cechy są znormalizowane
    
    // Statystyki
    int m_total_predictions;             // Łączna liczba predykcji
    double m_avg_prediction_time;        // Średni czas predykcji
    double m_total_training_time;        // Łączny czas treningu
    
public:
    // Konstruktor i destruktor
    CMachineLearning();
    ~CMachineLearning();
    
    // Inicjalizacja i konfiguracja
    bool Initialize(SMLModelParams &params);
    bool LoadDataset(SMLDataset &dataset);
    bool SetParameters(SMLModelParams &params);
    SMLModelParams GetParameters();
    
    // Przygotowanie danych
    bool PreprocessData();
    bool NormalizeFeatures();
    bool SplitDataset(double train_ratio, double validation_ratio, double test_ratio);
    bool FeatureSelection(int max_features);
    bool HandleMissingValues();
    bool RemoveOutliers(double threshold);
    
    // Trening modelu
    bool TrainModel();
    bool TrainLinearRegression();
    bool TrainPolynomialRegression(int degree);
    bool TrainLogisticRegression();
    bool TrainRidgeRegression();
    bool TrainLassoRegression();
    bool TrainElasticNet();
    bool TrainSVR();
    bool TrainDecisionTree();
    bool TrainRandomForest();
    bool TrainKNN();
    bool TrainKMeans();
    bool TrainDBSCAN();
    bool TrainPCA();
    bool TrainLDA();
    bool TrainGradientBoosting();
    bool TrainXGBoost();
    bool TrainAdaBoost();
    bool TrainNaiveBayes();
    bool TrainSVM();
    bool TrainNeuralNetwork();
    
    // Predykcje
    SMLPrediction Predict(double &features[]);
    SMLPrediction PredictBatch(double &features[][]);
    double PredictRegression(double &features[]);
    int PredictClassification(double &features[]);
    double PredictProbability(double &features[], int class_index);
    double PredictAnomaly(double &features[]);
    
    // Ocena modelu
    SMLModelEvaluation EvaluateModel();
    double CalculateAccuracy(double &predictions[], double &actuals[]);
    double CalculatePrecision(double &predictions[], double &actuals[], int class_index);
    double CalculateRecall(double &predictions[], double &actuals[], int class_index);
    double CalculateF1Score(double &predictions[], double &actuals[], int class_index);
    double CalculateROCAUC(double &predictions[], double &actuals[]);
    double CalculateMAE(double &predictions[], double &actuals[]);
    double CalculateMSE(double &predictions[], double &actuals[]);
    double CalculateRMSE(double &predictions[], double &actuals[]);
    double CalculateRSquared(double &predictions[], double &actuals[]);
    double CalculateAdjustedRSquared(double &predictions[], double &actuals[], int features_count);
    double CalculateSilhouetteScore(double &features[][], int &clusters[]);
    double CalculateCalinskiHarabaszScore(double &features[][], int &clusters[]);
    double CalculateDaviesBouldinScore(double &features[][], int &clusters[]);
    
    // Walidacja krzyżowa
    double CrossValidate(int k_folds);
    double StratifiedCrossValidate(int k_folds);
    double TimeSeriesCrossValidate(int n_splits);
    double BootstrapValidate(int n_bootstrap);
    
    // Optymalizacja hiperparametrów
    SMLHyperparameterOptimization OptimizeHyperparameters();
    bool GridSearch(double &param_grid[][]);
    bool RandomSearch(double &param_ranges[][], int n_iterations);
    bool BayesianOptimization(double &param_bounds[][], int n_iterations);
    
    // Zapisywanie i wczytywanie modelu
    bool SaveModel(string filename);
    bool LoadModel(string filename);
    bool ExportModel(string filename, ENUM_ML_ALGORITHM format);
    bool ImportModel(string filename, ENUM_ML_ALGORITHM format);
    
    // Analiza modelu
    double GetFeatureImportance(int feature_index);
    double GetFeatureImportances(double &importances[]);
    string GetModelSummary();
    string GetTrainingReport();
    string GetEvaluationReport();
    string GetPredictionReport();
    
    // Narzędzia pomocnicze
    bool IsModelTrained();
    bool IsDataLoaded();
    int GetSamplesCount();
    int GetFeaturesCount();
    double GetTrainingTime();
    double GetAveragePredictionTime();
    int GetTotalPredictions();
    
    // Czyszczenie i reset
    void ClearModel();
    void ClearCache();
    void ResetStatistics();
    void Cleanup();
    
private:
    // Funkcje pomocnicze
    double CalculateLoss(double &predictions[], double &actuals[]);
    double CalculateGradient(double &features[], double &targets[], double &weights[]);
    bool CheckConvergence(double &losses[], double tolerance);
    bool ValidateInput(double &features[]);
    bool ValidateTargets(double &targets[]);
    void UpdateStatistics(double prediction_time);
    string FormatTime(double seconds);
    double GenerateRandomDouble(double min, double max);
    int GenerateRandomInteger(int min, int max);
    void ShuffleArray(double &array[]);
    void ShuffleArray(int &array[]);
    double CalculateDistance(double &point1[], double &point2[]);
    double CalculateSimilarity(double &point1[], double &point2[]);
    bool IsAnomaly(double &features[], double threshold);
    string GenerateExplanation(double &features[], SMLPrediction &prediction);
};

// === IMPLEMENTACJA PODSTAWOWYCH ALGORYTMÓW ===

// Konstruktor
CMachineLearning::CMachineLearning() {
    m_model_trained = false;
    m_features_normalized = false;
    m_total_predictions = 0;
    m_avg_prediction_time = 0.0;
    m_total_training_time = 0.0;
    m_bias = 0.0;
    
    // Inicjalizacja parametrów domyślnych
    m_params.algorithm = ML_ALGORITHM_LINEAR_REGRESSION;
    m_params.problem_type = ML_PROBLEM_REGRESSION;
    m_params.learning_rate = 0.01;
    m_params.max_iterations = 1000;
    m_params.tolerance = 1e-6;
    m_params.regularization_strength = 0.0;
    m_params.random_state = 42;
    m_params.normalize_features = true;
    m_params.use_bias = true;
    m_params.validation_split = 0.2;
    m_params.validation_type = ML_VALIDATION_TRAIN_TEST;
    m_params.k_folds = 5;
    m_params.early_stopping_patience = 10;
    m_params.verbose = true;
}

// Destruktor
CMachineLearning::~CMachineLearning() {
    Cleanup();
}

// Inicjalizacja
bool CMachineLearning::Initialize(SMLModelParams &params) {
    m_params = params;
    m_model_trained = false;
    m_features_normalized = false;
    
    // Inicjalizacja ziarna losowości
    if(m_params.random_state > 0) {
        MathSrand(m_params.random_state);
    }
    
    return true;
}

// Wczytanie danych
bool CMachineLearning::LoadDataset(SMLDataset &dataset) {
    if(dataset.samples <= 0 || dataset.features_count <= 0) {
        return false;
    }
    
    m_dataset = dataset;
    
    // Inicjalizacja wag modelu
    ArrayResize(m_weights, dataset.features_count);
    ArrayInitialize(m_weights, 0.0);
    
    // Inicjalizacja skalowania cech
    if(m_params.normalize_features) {
        ArrayResize(m_feature_scaler, dataset.features_count);
        ArrayResize(m_feature_means, dataset.features_count);
        ArrayResize(m_feature_stds, dataset.features_count);
        ArrayInitialize(m_feature_scaler, 1.0);
        ArrayInitialize(m_feature_means, 0.0);
        ArrayInitialize(m_feature_stds, 1.0);
    }
    
    return true;
}

// Przygotowanie danych
bool CMachineLearning::PreprocessData() {
    if(!IsDataLoaded()) return false;
    
    // Obsługa brakujących wartości
    if(!HandleMissingValues()) return false;
    
    // Usuwanie outlierów
    if(!RemoveOutliers(3.0)) return false;
    
    // Normalizacja cech
    if(m_params.normalize_features) {
        if(!NormalizeFeatures()) return false;
    }
    
    return true;
}

// Normalizacja cech
bool CMachineLearning::NormalizeFeatures() {
    if(!IsDataLoaded()) return false;
    
    for(int feature = 0; feature < m_dataset.features_count; feature++) {
        // Obliczenie średniej i odchylenia standardowego
        double sum = 0.0, sum_sq = 0.0;
        
        for(int sample = 0; sample < m_dataset.samples; sample++) {
            int idx = sample * m_dataset.features_count + feature;
            sum += m_dataset.features[idx];
            sum_sq += m_dataset.features[idx] * m_dataset.features[idx];
        }
        
        double mean = sum / m_dataset.samples;
        double variance = (sum_sq / m_dataset.samples) - (mean * mean);
        double std = MathSqrt(variance);
        
        // Zapisz parametry skalowania
        m_feature_means[feature] = mean;
        m_feature_stds[feature] = std > 1e-10 ? std : 1.0;
        
        // Znormalizuj cechy
        for(int sample = 0; sample < m_dataset.samples; sample++) {
            int idx = sample * m_dataset.features_count + feature;
            m_dataset.features[idx] = (m_dataset.features[idx] - mean) / m_feature_stds[feature];
        }
    }
    
    m_features_normalized = true;
    return true;
}

// Trening regresji liniowej
bool CMachineLearning::TrainLinearRegression() {
    if(!IsDataLoaded()) return false;
    
    m_params.training_start_time = TimeCurrent();
    
    // Inicjalizacja wag
    ArrayInitialize(m_weights, 0.0);
    m_bias = 0.0;
    
    double learning_rate = m_params.learning_rate;
    int max_iterations = m_params.max_iterations;
    double tolerance = m_params.tolerance;
    
    double losses[];
    ArrayResize(losses, max_iterations);
    
    for(int iteration = 0; iteration < max_iterations; iteration++) {
        double total_loss = 0.0;
        double total_gradient_weights[];
        ArrayResize(total_gradient_weights, m_dataset.features_count);
        ArrayInitialize(total_gradient_weights, 0.0);
        double total_gradient_bias = 0.0;
        
        // Przejście przez wszystkie próbki
        for(int sample = 0; sample < m_dataset.samples; sample++) {
            // Predykcja
            double prediction = m_bias;
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                prediction += m_weights[feature] * m_dataset.features[sample * m_dataset.features_count + feature];
            }
            
            // Błąd
            double error = prediction - m_dataset.targets[sample];
            total_loss += error * error;
            
            // Gradient
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                total_gradient_weights[feature] += error * m_dataset.features[sample * m_dataset.features_count + feature];
            }
            total_gradient_bias += error;
        }
        
        // Aktualizacja wag
        for(int feature = 0; feature < m_dataset.features_count; feature++) {
            m_weights[feature] -= learning_rate * total_gradient_weights[feature] / m_dataset.samples;
        }
        m_bias -= learning_rate * total_gradient_bias / m_dataset.samples;
        
        // Zapisz stratę
        losses[iteration] = total_loss / m_dataset.samples;
        
        // Sprawdź zbieżność
        if(iteration > 0 && CheckConvergence(losses, tolerance)) {
            break;
        }
        
        // Early stopping
        if(iteration > m_params.early_stopping_patience) {
            bool should_stop = true;
            for(int i = iteration - m_params.early_stopping_patience; i < iteration; i++) {
                if(losses[i] > losses[i-1]) {
                    should_stop = false;
                    break;
                }
            }
            if(should_stop) break;
        }
    }
    
    m_params.training_end_time = TimeCurrent();
    m_total_training_time = (double)(m_params.training_end_time - m_params.training_start_time);
    
    m_model_trained = true;
    m_training_result.success = true;
    m_training_result.iterations = max_iterations;
    m_training_result.final_loss = losses[ArraySize(losses) - 1];
    m_training_result.convergence_time = m_total_training_time;
    m_training_result.params = m_params;
    m_training_result.training_time = m_total_training_time;
    
    return true;
}

// Trening regresji logistycznej
bool CMachineLearning::TrainLogisticRegression() {
    if(!IsDataLoaded()) return false;
    
    m_params.training_start_time = TimeCurrent();
    
    // Inicjalizacja wag
    ArrayInitialize(m_weights, 0.0);
    m_bias = 0.0;
    
    double learning_rate = m_params.learning_rate;
    int max_iterations = m_params.max_iterations;
    double tolerance = m_params.tolerance;
    
    double losses[];
    ArrayResize(losses, max_iterations);
    
    for(int iteration = 0; iteration < max_iterations; iteration++) {
        double total_loss = 0.0;
        double total_gradient_weights[];
        ArrayResize(total_gradient_weights, m_dataset.features_count);
        ArrayInitialize(total_gradient_weights, 0.0);
        double total_gradient_bias = 0.0;
        
        // Przejście przez wszystkie próbki
        for(int sample = 0; sample < m_dataset.samples; sample++) {
            // Predykcja (sigmoid)
            double z = m_bias;
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                z += m_weights[feature] * m_dataset.features[sample * m_dataset.features_count + feature];
            }
            double prediction = 1.0 / (1.0 + MathExp(-z));
            
            // Błąd (cross-entropy)
            double target = m_dataset.targets[sample];
            total_loss += -target * MathLog(prediction + 1e-15) - (1 - target) * MathLog(1 - prediction + 1e-15);
            
            // Gradient
            double error = prediction - target;
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                total_gradient_weights[feature] += error * m_dataset.features[sample * m_dataset.features_count + feature];
            }
            total_gradient_bias += error;
        }
        
        // Aktualizacja wag
        for(int feature = 0; feature < m_dataset.features_count; feature++) {
            m_weights[feature] -= learning_rate * total_gradient_weights[feature] / m_dataset.samples;
        }
        m_bias -= learning_rate * total_gradient_bias / m_dataset.samples;
        
        // Zapisz stratę
        losses[iteration] = total_loss / m_dataset.samples;
        
        // Sprawdź zbieżność
        if(iteration > 0 && CheckConvergence(losses, tolerance)) {
            break;
        }
    }
    
    m_params.training_end_time = TimeCurrent();
    m_total_training_time = (double)(m_params.training_end_time - m_params.training_start_time);
    
    m_model_trained = true;
    m_training_result.success = true;
    m_training_result.iterations = max_iterations;
    m_training_result.final_loss = losses[ArraySize(losses) - 1];
    m_training_result.convergence_time = m_total_training_time;
    m_training_result.params = m_params;
    m_training_result.training_time = m_total_training_time;
    
    return true;
}

// Trening Ridge Regression
bool CMachineLearning::TrainRidgeRegression() {
    if(!IsDataLoaded()) return false;
    
    m_params.training_start_time = TimeCurrent();
    
    // Inicjalizacja wag
    ArrayInitialize(m_weights, 0.0);
    m_bias = 0.0;
    
    double learning_rate = m_params.learning_rate;
    int max_iterations = m_params.max_iterations;
    double tolerance = m_params.tolerance;
    double alpha = m_params.regularization_strength;
    
    double losses[];
    ArrayResize(losses, max_iterations);
    
    for(int iteration = 0; iteration < max_iterations; iteration++) {
        double total_loss = 0.0;
        double total_gradient_weights[];
        ArrayResize(total_gradient_weights, m_dataset.features_count);
        ArrayInitialize(total_gradient_weights, 0.0);
        double total_gradient_bias = 0.0;
        
        // Przejście przez wszystkie próbki
        for(int sample = 0; sample < m_dataset.samples; sample++) {
            // Predykcja
            double prediction = m_bias;
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                prediction += m_weights[feature] * m_dataset.features[sample * m_dataset.features_count + feature];
            }
            
            // Błąd
            double error = prediction - m_dataset.targets[sample];
            total_loss += error * error;
            
            // Gradient
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                total_gradient_weights[feature] += error * m_dataset.features[sample * m_dataset.features_count + feature];
            }
            total_gradient_bias += error;
        }
        
        // Dodaj regularyzację L2
        for(int feature = 0; feature < m_dataset.features_count; feature++) {
            total_loss += alpha * m_weights[feature] * m_weights[feature];
            total_gradient_weights[feature] += 2 * alpha * m_weights[feature];
        }
        
        // Aktualizacja wag
        for(int feature = 0; feature < m_dataset.features_count; feature++) {
            m_weights[feature] -= learning_rate * total_gradient_weights[feature] / m_dataset.samples;
        }
        m_bias -= learning_rate * total_gradient_bias / m_dataset.samples;
        
        // Zapisz stratę
        losses[iteration] = total_loss / m_dataset.samples;
        
        // Sprawdź zbieżność
        if(iteration > 0 && CheckConvergence(losses, tolerance)) {
            break;
        }
    }
    
    m_params.training_end_time = TimeCurrent();
    m_total_training_time = (double)(m_params.training_end_time - m_params.training_start_time);
    
    m_model_trained = true;
    m_training_result.success = true;
    m_training_result.iterations = max_iterations;
    m_training_result.final_loss = losses[ArraySize(losses) - 1];
    m_training_result.convergence_time = m_total_training_time;
    m_training_result.params = m_params;
    m_training_result.training_time = m_total_training_time;
    
    return true;
}

// Trening K-Means
bool CMachineLearning::TrainKMeans() {
    if(!IsDataLoaded()) return false;
    
    m_params.training_start_time = TimeCurrent();
    
    int k = (int)m_params.regularization_strength; // Użyj jako liczba klastrów
    if(k <= 0) k = 3; // Domyślna wartość
    
    // Inicjalizacja centroidów
    double centroids[];
    ArrayResize(centroids, k * m_dataset.features_count);
    for(int i = 0; i < k; i++) {
        // Losowa inicjalizacja
        for(int j = 0; j < m_dataset.features_count; j++) {
            int idx0 = 0 * m_dataset.features_count + j;
            double min_val = m_dataset.features[idx0];
            double max_val = m_dataset.features[idx0];
            for(int sample = 1; sample < m_dataset.samples; sample++) {
                int idx = sample * m_dataset.features_count + j;
                if(m_dataset.features[idx] < min_val) min_val = m_dataset.features[idx];
                if(m_dataset.features[idx] > max_val) max_val = m_dataset.features[idx];
            }
            centroids[i * m_dataset.features_count + j] = min_val + (max_val - min_val) * GenerateRandomDouble(0, 1);
        }
    }
    
    int max_iterations = m_params.max_iterations;
    double tolerance = m_params.tolerance;
    
    for(int iteration = 0; iteration < max_iterations; iteration++) {
        // Przypisanie próbek do klastrów
        int assignments[];
        ArrayResize(assignments, m_dataset.samples);
        
        for(int sample = 0; sample < m_dataset.samples; sample++) {
            // Extract sample features for distance calculation
            double sample_features[];
            ArrayResize(sample_features, m_dataset.features_count);
            for(int f = 0; f < m_dataset.features_count; f++) {
                sample_features[f] = m_dataset.features[sample * m_dataset.features_count + f];
            }
            
            double first_centroid[];
            ArrayResize(first_centroid, m_dataset.features_count);
            for(int f = 0; f < m_dataset.features_count; f++) {
                first_centroid[f] = centroids[0 * m_dataset.features_count + f];
            }
            double min_distance = CalculateDistance(sample_features, first_centroid);
            int best_cluster = 0;
            
            for(int cluster = 1; cluster < k; cluster++) {
                double centroid_features[];
                ArrayResize(centroid_features, m_dataset.features_count);
                for(int f = 0; f < m_dataset.features_count; f++) {
                    centroid_features[f] = centroids[cluster * m_dataset.features_count + f];
                }
                double distance = CalculateDistance(sample_features, centroid_features);
                if(distance < min_distance) {
                    min_distance = distance;
                    best_cluster = cluster;
                }
            }
            assignments[sample] = best_cluster;
        }
        
        // Aktualizacja centroidów
        double new_centroids[];
        ArrayResize(new_centroids, k * m_dataset.features_count);
        int cluster_sizes[];
        ArrayResize(cluster_sizes, k);
        ArrayInitialize(cluster_sizes, 0);
        
        ArrayInitialize(new_centroids, 0.0);
        
        for(int sample = 0; sample < m_dataset.samples; sample++) {
            int cluster = assignments[sample];
            cluster_sizes[cluster]++;
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                new_centroids[cluster * m_dataset.features_count + feature] += m_dataset.features[sample * m_dataset.features_count + feature];
            }
        }
        
        // Sprawdź zbieżność
        bool converged = true;
        for(int cluster = 0; cluster < k; cluster++) {
            if(cluster_sizes[cluster] > 0) {
                for(int feature = 0; feature < m_dataset.features_count; feature++) {
                    new_centroids[cluster * m_dataset.features_count + feature] /= cluster_sizes[cluster];
                    if(MathAbs(new_centroids[cluster * m_dataset.features_count + feature] - centroids[cluster * m_dataset.features_count + feature]) > tolerance) {
                        converged = false;
                    }
                }
            }
        }
        
        // Aktualizuj centroidy
        for(int cluster = 0; cluster < k; cluster++) {
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                centroids[cluster * m_dataset.features_count + feature] = new_centroids[cluster * m_dataset.features_count + feature];
            }
        }
        
        if(converged) break;
    }
    
    // Zapisz centroidy jako wagi
    ArrayResize(m_weights, k * m_dataset.features_count);
    for(int cluster = 0; cluster < k; cluster++) {
        for(int feature = 0; feature < m_dataset.features_count; feature++) {
            m_weights[cluster * m_dataset.features_count + feature] = centroids[cluster * m_dataset.features_count + feature];
        }
    }
    
    m_params.training_end_time = TimeCurrent();
    m_total_training_time = (double)(m_params.training_end_time - m_params.training_start_time);
    
    m_model_trained = true;
    m_training_result.success = true;
    m_training_result.iterations = max_iterations;
    m_training_result.final_loss = 0.0; // Dla klastrowania nie ma funkcji straty
    m_training_result.convergence_time = m_total_training_time;
    m_training_result.params = m_params;
    m_training_result.training_time = m_total_training_time;
    
    return true;
}

// Predykcja
SMLPrediction CMachineLearning::Predict(double &features[]) {
    SMLPrediction prediction;
    prediction.prediction_time = 0.0;
    prediction.confidence = 0.0;
    prediction.is_anomaly = false;
    prediction.anomaly_score = 0.0;
    
    if(!IsModelTrained() || !ValidateInput(features)) {
        return prediction;
    }
    
    datetime start_time = TimeCurrent();
    
    switch(m_params.algorithm) {
        case ML_ALGORITHM_LINEAR_REGRESSION:
        case ML_ALGORITHM_RIDGE_REGRESSION:
            prediction.predicted_value = PredictRegression(features);
            prediction.confidence = 0.8; // Domyślna pewność
            break;
            
        case ML_ALGORITHM_LOGISTIC_REGRESSION:
            prediction.predicted_class = PredictClassification(features);
            prediction.confidence = PredictProbability(features, prediction.predicted_class);
            break;
            
        case ML_ALGORITHM_KMEANS:
            prediction.predicted_class = PredictClassification(features);
            prediction.confidence = 0.7; // Domyślna pewność dla klastrowania
            break;
            
        default:
            prediction.predicted_value = PredictRegression(features);
            prediction.confidence = 0.5;
            break;
    }
    
    prediction.prediction_time = (double)(TimeCurrent() - start_time);
    UpdateStatistics(prediction.prediction_time);
    
    return prediction;
}

// Predykcja regresji
double CMachineLearning::PredictRegression(double &features[]) {
    if(!IsModelTrained()) return 0.0;
    
    double prediction = m_bias;
    
    for(int feature = 0; feature < m_dataset.features_count; feature++) {
        if(feature < ArraySize(features)) {
            double feature_value = features[feature];
            
            // Zastosuj normalizację jeśli była używana
            if(m_features_normalized) {
                feature_value = (feature_value - m_feature_means[feature]) / m_feature_stds[feature];
            }
            
            prediction += m_weights[feature] * feature_value;
        }
    }
    
    return prediction;
}

// Predykcja klasyfikacji
int CMachineLearning::PredictClassification(double &features[]) {
    if(!IsModelTrained()) return -1;
    
    switch(m_params.algorithm) {
        case ML_ALGORITHM_LOGISTIC_REGRESSION: {
            double probability = PredictProbability(features, 1);
            return probability > 0.5 ? 1 : 0;
        }
            
        case ML_ALGORITHM_KMEANS: {
            // Znajdź najbliższy centroid
            int k = (int)m_params.regularization_strength;
            if(k <= 0) k = 3;
            
            double min_distance = CalculateDistance(features, m_weights);
            int best_cluster = 0;
            
            for(int cluster = 1; cluster < k; cluster++) {
                double cluster_weights[];
                ArrayResize(cluster_weights, m_dataset.features_count);
                for(int feature = 0; feature < m_dataset.features_count; feature++) {
                    cluster_weights[feature] = m_weights[cluster * m_dataset.features_count + feature];
                }
                
                double distance = CalculateDistance(features, cluster_weights);
                if(distance < min_distance) {
                    min_distance = distance;
                    best_cluster = cluster;
                }
            }
            return best_cluster;
        }
            
        default:
            return 0;
    }
}

// Predykcja prawdopodobieństwa
double CMachineLearning::PredictProbability(double &features[], int class_index) {
    if(!IsModelTrained()) return 0.0;
    
    switch(m_params.algorithm) {
        case ML_ALGORITHM_LOGISTIC_REGRESSION: {
            double z = m_bias;
            for(int feature = 0; feature < m_dataset.features_count; feature++) {
                if(feature < ArraySize(features)) {
                    double feature_value = features[feature];
                    if(m_features_normalized) {
                        feature_value = (feature_value - m_feature_means[feature]) / m_feature_stds[feature];
                    }
                    z += m_weights[feature] * feature_value;
                }
            }
            double probability = 1.0 / (1.0 + MathExp(-z));
            return class_index == 1 ? probability : (1.0 - probability);
        }
            
        default:
            return 0.5;
    }
}

// Funkcje pomocnicze
bool CMachineLearning::IsModelTrained() {
    return m_model_trained;
}

bool CMachineLearning::IsDataLoaded() {
    return m_dataset.samples > 0;
}

bool CMachineLearning::ValidateInput(double &features[]) {
    return ArraySize(features) >= m_dataset.features_count;
}

double CMachineLearning::CalculateDistance(double &point1[], double &point2[]) {
    double distance = 0.0;
    int size = MathMin(ArraySize(point1), ArraySize(point2));
    
    for(int i = 0; i < size; i++) {
        double diff = point1[i] - point2[i];
        distance += diff * diff;
    }
    
    return MathSqrt(distance);
}

bool CMachineLearning::CheckConvergence(double &losses[], double tolerance) {
    int size = ArraySize(losses);
    if(size < 2) return false;
    
    return MathAbs(losses[size-1] - losses[size-2]) < tolerance;
}

void CMachineLearning::UpdateStatistics(double prediction_time) {
    m_total_predictions++;
    m_avg_prediction_time = (m_avg_prediction_time * (m_total_predictions - 1) + prediction_time) / m_total_predictions;
}

double CMachineLearning::GenerateRandomDouble(double min, double max) {
    return min + (max - min) * ((double)MathRand() / 32767.0);
}

void CMachineLearning::Cleanup() {
    ArrayFree(m_weights);
    ArrayFree(m_feature_scaler);
    ArrayFree(m_feature_means);
    ArrayFree(m_feature_stds);
    ArrayFree(m_prediction_cache);
    
    m_model_trained = false;
    m_features_normalized = false;
    m_total_predictions = 0;
    m_avg_prediction_time = 0.0;
    m_total_training_time = 0.0;
}

// === FUNKCJE GLOBALNE ===

// Funkcje pomocnicze dla ML
double CalculateCorrelation(double &x[], double &y[]);
double CalculateCovariance(double &x[], double &y[]);
double CalculateVariance(double &data[]);
double CalculateStandardDeviation(double &data[]);
double CalculateMean(double &data[]);
double CalculateMedian(double &data[]);
double CalculateMode(double &data[]);
double CalculateSkewness(double &data[]);
double CalculateKurtosis(double &data[]);
double CalculateQuantile(double &data[], double q);
double CalculateIQR(double &data[]);
double CalculateZScore(double value, double mean, double std);
double CalculateMinMaxScaler(double value, double min, double max);
double CalculateStandardScaler(double value, double mean, double std);
double CalculateRobustScaler(double value, double median, double iqr);

// Funkcje dla macierzy
bool MatrixMultiply(double &A[][], double &B[][], double &result[][]);
bool MatrixTranspose(double &in_matrix[][], double &result[][]);
bool MatrixInverse(double &in_matrix[][], double &result[][]);
double MatrixDeterminant(double &in_matrix[][]);
bool MatrixEigenvalues(double &in_matrix[][], double &eigenvalues[]);
bool MatrixEigenvectors(double &in_matrix[][], double &eigenvectors[][]);
bool MatrixSVD(double &in_matrix[][], double &U[][], double &S[], double &V[][]);
bool MatrixPCA(double &data[][], double &components[][], int n_components);

// Funkcje dla optymalizacji - uproszczone (MQL5 nie obsługuje wskaźników na funkcje)
double OptimizeFunction(double &initial_params[]);
double GradientDescent(double &initial_params[], double learning_rate, int max_iterations);
double NewtonMethod(double &initial_params[], int max_iterations);
double BFGS(double &initial_params[], int max_iterations);
double LBFGS(double &initial_params[], int max_iterations);

// Funkcje dla walidacji
bool ValidateDataset(SMLDataset &dataset);
bool ValidateModelParams(SMLModelParams &params);
bool ValidatePrediction(SMLPrediction &prediction);
bool ValidateEvaluation(SMLModelEvaluation &evaluation);
string GenerateValidationReport(SMLModelEvaluation &evaluation);

// Funkcje dla eksportu/importu
bool ExportDatasetToCSV(SMLDataset &dataset, string filename);
bool ImportDatasetFromCSV(string filename, SMLDataset &dataset);
bool ExportModelToJSON(CMachineLearning &model, string filename);
bool ImportModelFromJSON(string filename, CMachineLearning &model);
bool ExportResultsToCSV(SMLTrainingResult &result, string filename);
bool ExportEvaluationToCSV(SMLModelEvaluation &evaluation, string filename);

// Funkcje dla wizualizacji
string GenerateConfusionMatrixPlot(double &confusion_matrix[][]);
string GenerateROCPlot(double &fpr[], double &tpr[]);
string GeneratePrecisionRecallPlot(double &precision[], double &recall[]);
string GenerateFeatureImportancePlot(double &importances[], string &feature_names[]);
string GenerateLearningCurvePlot(double &train_scores[], double &val_scores[]);
string GenerateResidualPlot(double &predictions[], double &actuals[]);

// Funkcje dla diagnostyki
bool CheckDataQuality(SMLDataset &dataset);
bool DetectDataLeakage(SMLDataset &dataset);
bool DetectOverfitting(SMLTrainingResult &result);
bool DetectUnderfitting(SMLTrainingResult &result);
bool DetectClassImbalance(SMLDataset &dataset);
bool DetectFeatureCorrelation(double &features[][]);
string GenerateDataQualityReport(SMLDataset &dataset);

// Funkcje dla automatyzacji
SMLModelParams AutoTuneParameters(SMLDataset &dataset, ENUM_ML_ALGORITHM algorithm);
ENUM_ML_ALGORITHM AutoSelectAlgorithm(SMLDataset &dataset);
bool AutoFeatureEngineering(SMLDataset &dataset);
bool AutoHyperparameterTuning(CMachineLearning &model);
string GenerateAutoMLReport(CMachineLearning &model);

// Stałe dla Machine Learning
#define ML_VERSION "1.0.0"
#define ML_AUTHOR "System Böhmego"
#define ML_DESCRIPTION "Zaawansowane algorytmy uczenia maszynowego"

#endif // MACHINE_LEARNING_H
