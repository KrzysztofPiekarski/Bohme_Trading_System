#ifndef REINFORCEMENT_LEARNING_H
#define REINFORCEMENT_LEARNING_H

// ========================================
// REINFORCEMENT LEARNING - UCZENIE PRZEZ WZMACNIANIE
// ========================================
// Zaawansowane algorytmy uczenia przez wzmacnianie dla Systemu Böhmego
// Q-Learning, Deep Q-Network, Policy Gradient, Actor-Critic, A3C, PPO

// === PODSTAWOWE ENUMERACJE ===

// Typy algorytmów RL
enum ENUM_RL_ALGORITHM {
    RL_ALGORITHM_Q_LEARNING,        // Q-Learning
    RL_ALGORITHM_DEEP_Q_NETWORK,    // Deep Q-Network (DQN)
    RL_ALGORITHM_DOUBLE_DQN,        // Double DQN
    RL_ALGORITHM_DUELING_DQN,       // Dueling DQN
    RL_ALGORITHM_PRIORITIZED_DQN,   // Prioritized DQN
    RL_ALGORITHM_POLICY_GRADIENT,   // Policy Gradient
    RL_ALGORITHM_ACTOR_CRITIC,      // Actor-Critic
    RL_ALGORITHM_A3C,               // Asynchronous Advantage Actor-Critic
    RL_ALGORITHM_A2C,               // Advantage Actor-Critic
    RL_ALGORITHM_PPO,               // Proximal Policy Optimization
    RL_ALGORITHM_TRPO,              // Trust Region Policy Optimization
    RL_ALGORITHM_SAC,               // Soft Actor-Critic
    RL_ALGORITHM_TD3,               // Twin Delayed DDPG
    RL_ALGORITHM_DDPG,              // Deep Deterministic Policy Gradient
    RL_ALGORITHM_MONTE_CARLO,       // Monte Carlo
    RL_ALGORITHM_SARSA,             // SARSA
    RL_ALGORITHM_EXPECTED_SARSA,    // Expected SARSA
    RL_ALGORITHM_N_STEP_LEARNING,   // N-Step Learning
    RL_ALGORITHM_ELIGIBILITY_TRACES, // Eligibility Traces
    RL_ALGORITHM_NEURAL_FIT_Q       // Neural Fitted Q
};

// Typy środowisk
enum ENUM_RL_ENVIRONMENT {
    RL_ENV_TRADING,                 // Środowisko tradingowe
    RL_ENV_PORTFOLIO,               // Środowisko portfelowe
    RL_ENV_RISK_MANAGEMENT,         // Środowisko zarządzania ryzykiem
    RL_ENV_ORDER_EXECUTION,         // Środowisko wykonania zleceń
    RL_ENV_MARKET_MAKING,           // Środowisko market making
    RL_ENV_ARBITRAGE,               // Środowisko arbitrażu
    RL_ENV_PAIRS_TRADING,           // Środowisko pairs trading
    RL_ENV_MOMENTUM_TRADING,        // Środowisko momentum trading
    RL_ENV_MEAN_REVERSION,          // Środowisko mean reversion
    RL_ENV_BREAKOUT_TRADING,        // Środowisko breakout trading
    RL_ENV_SCALPING,                // Środowisko scalping
    RL_ENV_SWING_TRADING,           // Środowisko swing trading
    RL_ENV_POSITION_SIZING,         // Środowisko sizing pozycji
    RL_ENV_ENTRY_EXIT,              // Środowisko entry/exit
    RL_ENV_STOP_LOSS,               // Środowisko stop loss
    RL_ENV_TAKE_PROFIT,             // Środowisko take profit
    RL_ENV_CUSTOM                   // Środowisko niestandardowe
};

// Typy akcji
enum ENUM_RL_ACTION {
    RL_ACTION_BUY,                  // Kup
    RL_ACTION_SELL,                 // Sprzedaj
    RL_ACTION_HOLD,                 // Trzymaj
    RL_ACTION_CLOSE,                // Zamknij
    RL_ACTION_INCREASE_POSITION,    // Zwiększ pozycję
    RL_ACTION_DECREASE_POSITION,    // Zmniejsz pozycję
    RL_ACTION_ADD_TO_POSITION,      // Dodaj do pozycji
    RL_ACTION_REDUCE_POSITION,      // Zmniejsz pozycję
    RL_ACTION_SET_STOP_LOSS,        // Ustaw stop loss
    RL_ACTION_SET_TAKE_PROFIT,      // Ustaw take profit
    RL_ACTION_MODIFY_STOP_LOSS,     // Zmodyfikuj stop loss
    RL_ACTION_MODIFY_TAKE_PROFIT,   // Zmodyfikuj take profit
    RL_ACTION_CANCEL_ORDER,         // Anuluj zlecenie
    RL_ACTION_PLACE_LIMIT_ORDER,    // Złóż zlecenie limit
    RL_ACTION_PLACE_MARKET_ORDER,   // Złóż zlecenie rynkowe
    RL_ACTION_PLACE_STOP_ORDER,     // Złóż zlecenie stop
    RL_ACTION_HEDGE,                // Zabezpiecz
    RL_ACTION_DIVERSIFY,            // Dywersyfikuj
    RL_ACTION_REBALANCE,            // Rebalansuj
    RL_ACTION_WAIT,                 // Czekaj
    RL_ACTION_EXIT_MARKET,          // Wyjdź z rynku
    RL_ACTION_ENTER_MARKET,         // Wejdź na rynek
    RL_ACTION_SWITCH_STRATEGY,      // Zmień strategię
    RL_ACTION_ADJUST_RISK,          // Dostosuj ryzyko
    RL_ACTION_OPTIMIZE_PARAMS,      // Optymalizuj parametry
    RL_ACTION_NO_ACTION             // Brak akcji
};

// Typy stanów
enum ENUM_RL_STATE {
    RL_STATE_MARKET_DATA,           // Dane rynkowe
    RL_STATE_PRICE_DATA,            // Dane cenowe
    RL_STATE_VOLUME_DATA,           // Dane wolumenowe
    RL_STATE_TECHNICAL_INDICATORS,  // Wskaźniki techniczne
    RL_STATE_POSITION_DATA,         // Dane pozycji
    RL_STATE_PORTFOLIO_DATA,        // Dane portfela
    RL_STATE_RISK_DATA,             // Dane ryzyka
    RL_STATE_ORDER_DATA,            // Dane zleceń
    RL_STATE_ACCOUNT_DATA,          // Dane konta
    RL_STATE_MARKET_SENTIMENT,      // Sentyment rynkowy
    RL_STATE_NEWS_DATA,             // Dane newsowe
    RL_STATE_CORRELATION_DATA,      // Dane korelacji
    RL_STATE_VOLATILITY_DATA,       // Dane zmienności
    RL_STATE_TREND_DATA,            // Dane trendu
    RL_STATE_MOMENTUM_DATA,         // Dane momentum
    RL_STATE_MEAN_REVERSION_DATA,   // Dane mean reversion
    RL_STATE_BREAKOUT_DATA,         // Dane breakout
    RL_STATE_SUPPORT_RESISTANCE,    // Dane wsparcia/oporu
    RL_STATE_FIBONACCI_LEVELS,      // Poziomy Fibonacciego
    RL_STATE_EWAVE_DATA,            // Dane fal Elliotta
    RL_STATE_PATTERN_DATA,          // Dane wzorców
    RL_STATE_TIME_DATA,             // Dane czasowe
    RL_STATE_SEASONAL_DATA,         // Dane sezonowe
    RL_STATE_CYCLIC_DATA,           // Dane cykliczne
    RL_STATE_BEHAVIORAL_DATA,       // Dane behawioralne
    RL_STATE_COMPOSITE              // Stan złożony
};

// Typy nagród
enum ENUM_RL_REWARD {
    RL_REWARD_PROFIT,               // Zysk
    RL_REWARD_LOSS,                 // Strata
    RL_REWARD_SHARPE_RATIO,         // Sharpe Ratio
    RL_REWARD_SORTINO_RATIO,        // Sortino Ratio
    RL_REWARD_CALMAR_RATIO,         // Calmar Ratio
    RL_REWARD_MAX_DRAWDOWN,         // Maksymalny drawdown
    RL_REWARD_WIN_RATE,             // Win rate
    RL_REWARD_PROFIT_FACTOR,        // Profit factor
    RL_REWARD_EXPECTED_VALUE,       // Wartość oczekiwana
    RL_REWARD_RISK_ADJUSTED_RETURN, // Skorygowany o ryzyko zwrot
    RL_REWARD_VOLATILITY,           // Zmienność
    RL_REWARD_BETA,                 // Beta
    RL_REWARD_ALPHA,                // Alpha
    RL_REWARD_INFORMATION_RATIO,    // Information ratio
    RL_REWARD_TREYNOR_RATIO,        // Treynor ratio
    RL_REWARD_JENSEN_ALPHA,         // Jensen alpha
    RL_REWARD_ULCER_INDEX,          // Ulcer index
    RL_REWARD_GAIN_TO_PAIN_RATIO,   // Gain to pain ratio
    RL_REWARD_MARTIN_RATIO,         // Martin ratio
    RL_REWARD_BURKE_RATIO,          // Burke ratio
    RL_REWARD_STERLING_RATIO,       // Sterling ratio
    RL_REWARD_OMEGA_RATIO,          // Omega ratio
    RL_REWARD_KAPPA_RATIO,          // Kappa ratio
    RL_REWARD_CUSTOM                // Nagroda niestandardowa
};

// Typy polityk
enum ENUM_RL_POLICY {
    RL_POLICY_EPSILON_GREEDY,       // Epsilon-greedy
    RL_POLICY_SOFTMAX,              // Softmax
    RL_POLICY_BOLTZMANN,            // Boltzmann
    RL_POLICY_UCB,                  // Upper Confidence Bound
    RL_POLICY_THOMPSON_SAMPLING,    // Thompson Sampling
    RL_POLICY_ENTROPY_REGULARIZATION, // Entropy Regularization
    RL_POLICY_GAUSSIAN,             // Gaussian Policy
    RL_POLICY_DETERMINISTIC,        // Deterministic Policy
    RL_POLICY_STOCHASTIC,           // Stochastic Policy
    RL_POLICY_MIXTURE,              // Mixture Policy
    RL_POLICY_HIERARCHICAL,         // Hierarchical Policy
    RL_POLICY_META_LEARNING,        // Meta-Learning Policy
    RL_POLICY_MULTI_OBJECTIVE,      // Multi-Objective Policy
    RL_POLICY_ADAPTIVE,             // Adaptive Policy
    RL_POLICY_CONTEXTUAL,           // Contextual Policy
    RL_POLICY_BANDIT,               // Bandit Policy
    RL_POLICY_BAYESIAN,             // Bayesian Policy
    RL_POLICY_ENSEMBLE,             // Ensemble Policy
    RL_POLICY_CUSTOM                // Polityka niestandardowa
};

// Typy eksploracji
enum ENUM_RL_EXPLORATION {
    RL_EXPLORATION_RANDOM,          // Losowa eksploracja
    RL_EXPLORATION_EPSILON_GREEDY,  // Epsilon-greedy
    RL_EXPLORATION_SOFTMAX,         // Softmax
    RL_EXPLORATION_BOLTZMANN,       // Boltzmann
    RL_EXPLORATION_UCB,             // Upper Confidence Bound
    RL_EXPLORATION_THOMPSON,        // Thompson Sampling
    RL_EXPLORATION_ENTROPY,         // Entropy-based
    RL_EXPLORATION_NOISE,           // Noise-based
    RL_EXPLORATION_CURIOSITY,       // Curiosity-driven
    RL_EXPLORATION_COUNT_BASED,     // Count-based
    RL_EXPLORATION_DENSITY_BASED,   // Density-based
    RL_EXPLORATION_PREDICTION_ERROR, // Prediction error
    RL_EXPLORATION_INFORMATION_GAIN, // Information gain
    RL_EXPLORATION_UNCERTAINTY,     // Uncertainty-based
    RL_EXPLORATION_DIVERSITY,       // Diversity-based
    RL_EXPLORATION_ADAPTIVE,        // Adaptive exploration
    RL_EXPLORATION_HIERARCHICAL,    // Hierarchical exploration
    RL_EXPLORATION_META_LEARNING,   // Meta-learning exploration
    RL_EXPLORATION_MULTI_OBJECTIVE, // Multi-objective exploration
    RL_EXPLORATION_CUSTOM           // Eksploracja niestandardowa
};

// Typy pamięci
enum ENUM_RL_MEMORY {
    RL_MEMORY_EXPERIENCE_REPLAY,    // Experience Replay
    RL_MEMORY_PRIORITIZED_REPLAY,   // Prioritized Replay
    RL_MEMORY_DUELING_REPLAY,       // Dueling Replay
    RL_MEMORY_HIERARCHICAL_REPLAY,  // Hierarchical Replay
    RL_MEMORY_EPISODIC_REPLAY,      // Episodic Replay
    RL_MEMORY_META_REPLAY,          // Meta Replay
    RL_MEMORY_CONTEXTUAL_REPLAY,    // Contextual Replay
    RL_MEMORY_ADAPTIVE_REPLAY,      // Adaptive Replay
    RL_MEMORY_MULTI_OBJECTIVE_REPLAY, // Multi-Objective Replay
    RL_MEMORY_ENSEMBLE_REPLAY,      // Ensemble Replay
    RL_MEMORY_BAYESIAN_REPLAY,      // Bayesian Replay
    RL_MEMORY_UNCERTAINTY_REPLAY,   // Uncertainty Replay
    RL_MEMORY_DIVERSITY_REPLAY,     // Diversity Replay
    RL_MEMORY_CURIOSITY_REPLAY,     // Curiosity Replay
    RL_MEMORY_COUNT_BASED_REPLAY,   // Count-based Replay
    RL_MEMORY_DENSITY_BASED_REPLAY, // Density-based Replay
    RL_MEMORY_PREDICTION_ERROR_REPLAY, // Prediction Error Replay
    RL_MEMORY_INFORMATION_GAIN_REPLAY, // Information Gain Replay
    RL_MEMORY_CUSTOM                // Pamięć niestandardowa
};

// Typy optymalizacji
enum ENUM_RL_OPTIMIZATION {
    RL_OPTIMIZATION_SGD,            // Stochastic Gradient Descent
    RL_OPTIMIZATION_ADAM,           // Adam
    RL_OPTIMIZATION_RMS_PROP,       // RMSprop
    RL_OPTIMIZATION_ADAGRAD,        // Adagrad
    RL_OPTIMIZATION_ADADELTA,       // Adadelta
    RL_OPTIMIZATION_NADAM,          // Nadam
    RL_OPTIMIZATION_AMSGRAD,        // AMSGrad
    RL_OPTIMIZATION_ADAMW,          // AdamW
    RL_OPTIMIZATION_LION,           // Lion
    RL_OPTIMIZATION_SOPHIA,         // Sophia
    RL_OPTIMIZATION_ADA_BELIEF,     // AdaBelief
    RL_OPTIMIZATION_RADAM,          // RAdam
    RL_OPTIMIZATION_LOOKAHEAD,      // Lookahead
    RL_OPTIMIZATION_RANGER,         // Ranger
    RL_OPTIMIZATION_NOVOGRAD,       // NovoGrad
    RL_OPTIMIZATION_LAMB,           // LAMB
    RL_OPTIMIZATION_LARS,           // LARS
    RL_OPTIMIZATION_CUSTOM          // Optymalizacja niestandardowa
};

// Typy funkcji wartości
enum ENUM_RL_VALUE_FUNCTION {
    RL_VALUE_Q_FUNCTION,            // Q-Function
    RL_VALUE_V_FUNCTION,            // V-Function
    RL_VALUE_A_FUNCTION,            // Advantage Function
    RL_VALUE_TD_FUNCTION,           // TD Function
    RL_VALUE_MC_FUNCTION,           // Monte Carlo Function
    RL_VALUE_BOOTSTRAP_FUNCTION,    // Bootstrap Function
    RL_VALUE_N_STEP_FUNCTION,       // N-Step Function
    RL_VALUE_LAMBDA_FUNCTION,       // Lambda Function
    RL_VALUE_ELIGIBILITY_FUNCTION,  // Eligibility Function
    RL_VALUE_NEURAL_FUNCTION,       // Neural Function
    RL_VALUE_DUELING_FUNCTION,      // Dueling Function
    RL_VALUE_DISTRIBUTIONAL_FUNCTION, // Distributional Function
    RL_VALUE_QUANTILE_FUNCTION,     // Quantile Function
    RL_VALUE_CATEGORICAL_FUNCTION,  // Categorical Function
    RL_VALUE_ENSEMBLE_FUNCTION,     // Ensemble Function
    RL_VALUE_BAYESIAN_FUNCTION,     // Bayesian Function
    RL_VALUE_UNCERTAINTY_FUNCTION,  // Uncertainty Function
    RL_VALUE_META_FUNCTION,         // Meta Function
    RL_VALUE_HIERARCHICAL_FUNCTION, // Hierarchical Function
    RL_VALUE_MULTI_OBJECTIVE_FUNCTION, // Multi-Objective Function
    RL_VALUE_CUSTOM                 // Funkcja wartości niestandardowa
};

#endif // REINFORCEMENT_LEARNING_H
