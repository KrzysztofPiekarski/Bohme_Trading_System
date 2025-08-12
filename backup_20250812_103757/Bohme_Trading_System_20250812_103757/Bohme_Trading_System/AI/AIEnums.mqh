#ifndef AI_ENUMS_H
#define AI_ENUMS_H

// Wspólne enumeracje dla modułów AI

// Reżimy zmienności (używane m.in. przez Fire Spirit i AdvancedAI)
enum ENUM_VOLATILITY_REGIME {
    VOLATILITY_LOW,
    VOLATILITY_NORMAL,
    VOLATILITY_HIGH,
    VOLATILITY_EXTREME,
    VOLATILITY_TRANSITION
};

// Stany energii (używane przez Fire Spirit)
enum ENUM_ENERGY_STATE {
    ENERGY_DORMANT,
    ENERGY_BUILDING,
    ENERGY_ACTIVE,
    ENERGY_EXPLOSIVE,
    ENERGY_EXHAUSTED
};

// Jakość sygnału (używane przez Light Spirit w AdvancedAI)
enum ENUM_SIGNAL_QUALITY {
    SIGNAL_POOR,
    SIGNAL_FAIR,
    SIGNAL_GOOD,
    SIGNAL_EXCELLENT
};

// Stan harmonii (używane przez Sound Spirit w AdvancedAI)
enum ENUM_HARMONY_STATE {
    HARMONY_DISSONANT,
    HARMONY_NEUTRAL,
    HARMONY_HARMONIC
};

#endif // AI_ENUMS_H


