/*
 * Layer 0: Alphas
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │   │ Q │ W │ E │ R │ T │       │ Y │ U │ I │ O │ P │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │ A │ S │ D │ F │ G │       │ H │ J │ K │ L │ ; │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │ Z │ X │ C │ V │ B │       │ N │ M │ , │ . │ / │   │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │ESC├───┐           ┌───┤DEL│
 *               └───┤SPC├───┐   ┌───┤BSP├───┘
 *                 4 └───┤TAB│   │ENT├───┘
 *                     1 └───┘   └───┘ 3
 *                                 2
 *
 * Layer 1: Numbers
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │   │   │   │   │   │   │       │   │ 7 │ 8 │ 9 │   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │   │   │   │   │   │       │   │ 4 │ 5 │ 6 │   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │   │   │   │   │   │       │   │ 1 │ 2 │ 3 │   │   │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │   ├───┐           ┌───┤   │
 *               └───┤ ⊗ ├───┐   ┌───┤ 0 ├───┘
 *                   └───┤   │   │   ├───┘
 *                       └───┘   └───┘
 * Layer 2: Symbols
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │   │ ` │ & │ ' │ [ │   │       │   │ ] │ + │ * │ ^ │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │ ~ │ ! │ " │ { │   │       │   │ } │ = │ ? │ @ │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │ $ │ | │ # │ < │   │       │   │ > │ - │ % │ \ │   │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │ ( ├───┐           ┌───┤   │
 *               └───┤ _ ├───┐   ┌───┤   ├───┘
 *                   └───┤ ) │   │ ⊗ ├───┘
 *                       └───┘   └───┘
 * Layer 3: Navigation
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │   │   │   │   │   │   │       │   │   │   │   │   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │HOM│   │PGU│PDN│   │       │ ◀ │ ▼ │ ▲ │ ▶ │END│   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │C-Z│C-X│C-C│C-V│   │       │   │   │   │   │   │   │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │   ├───┐           ┌───┤   │
 *               └───┤WIN├───┐   ┌───┤ ⊗ ├───┘
 *                   └───┤   │   │   ├───┘
 *                       └───┘   └───┘
 * Layer 4: Media
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │   │   │   │   │   │   │       │   │   │   │   │   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │   │   │   │   │   │       │⏮ │🔉 │🔊 │ ⏭│   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │   │   │   │   │   │       │   │   │   │   │   │   │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │ ⊗ ├───┐           ┌───┤🔇 │
 *               └───┤   ├───┐   ┌───┤⏯ ├───┘
 *                   └───┤   │   │   ├───┘
 *                       └───┘   └───┘
 */
#include QMK_KEYBOARD_H

// Home Row Mods (Shift, Ctrl, Alt)
#define HRM_F       LSFT_T(KC_F)
#define HRM_J       RSFT_T(KC_J)
#define HRM_D       LCTL_T(KC_D)
#define HRM_K       RCTL_T(KC_K)
#define HRM_S       LALT_T(KC_S)
#define HRM_L       RALT_T(KC_L)

const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  // Base Layer
  [0] = LAYOUT_split_3x6_3(
        XXXXXXX, KC_Q,  KC_W,  KC_E,  KC_R, KC_T,                  KC_Y,  KC_U,    KC_I,   KC_O,     KC_P, XXXXXXX,
        XXXXXXX, KC_A, HRM_S, HRM_D, HRM_F, KC_G,                  KC_H, HRM_J,   HRM_K,  HRM_L,  KC_SCLN, XXXXXXX,
        XXXXXXX, KC_Z,  KC_X,  KC_C,  KC_V, KC_B,                  KC_N,  KC_M, KC_COMM, KC_DOT,  KC_SLSH, XXXXXXX,
                     LT(4,KC_ESC), LT(1,KC_SPC), KC_TAB,     LT(2,KC_ENT), LT(3,KC_BSPC), KC_DEL
  ),
  // Number Layer
  [1] = LAYOUT_split_3x6_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 XXXXXXX, KC_7, KC_8, KC_9, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, _______, _______, _______, XXXXXXX,                 XXXXXXX, KC_4, KC_5, KC_6, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 XXXXXXX, KC_1, KC_2, KC_3, XXXXXXX, XXXXXXX,
                                   XXXXXXX, XXXXXXX, XXXXXXX,      XXXXXXX, _______, KC_0
  ),
  // Symbol Layer
  [2] = LAYOUT_split_3x6_3(
        XXXXXXX, KC_GRAVE, KC_AMPR, KC_QUOT, KC_LBRC, XXXXXXX,             XXXXXXX, KC_RBRC, KC_PLUS,  KC_ASTR, KC_CIRC, XXXXXXX,
        XXXXXXX, KC_TILD,  KC_EXLM, KC_DQUO, KC_LCBR, XXXXXXX,             XXXXXXX, KC_RCBR, KC_EQUAL, KC_QUES, KC_AT,   XXXXXXX,
        XXXXXXX, KC_DLR,   KC_PIPE, KC_HASH, KC_LABK, XXXXXXX,             XXXXXXX, KC_RABK, KC_MINUS, KC_PERC, KC_BSLS, XXXXXXX,
                                     KC_LPRN,  KC_UNDS, KC_RPRN,      XXXXXXX, XXXXXXX, XXXXXXX
  ),
  // Navigation Layer
  [3] = LAYOUT_split_3x6_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,         XXXXXXX,         XXXXXXX,             XXXXXXX,         XXXXXXX,         XXXXXXX,       XXXXXXX,  XXXXXXX, XXXXXXX,
        XXXXXXX, KC_HOME, KC_LALT, LCTL_T(KC_PGUP), LSFT_T(KC_PGDN), XXXXXXX,             RSFT_T(KC_LEFT), RCTL_T(KC_DOWN), RALT_T(KC_UP), KC_RIGHT, KC_END,  XXXXXXX,
        XXXXXXX, KC_UNDO, KC_CUT,  KC_COPY,         KC_PSTE,         XXXXXXX,             XXXXXXX,         XXXXXXX,         XXXXXXX,       XXXXXXX,  XXXXXXX, XXXXXXX,
                                                       XXXXXXX, KC_LWIN, XXXXXXX,      XXXXXXX, XXXXXXX, XXXXXXX
  ),
  // Media Layer
  [4] = LAYOUT_split_3x6_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 KC_MPRV, KC_VOLD, KC_VOLU,  KC_MNXT, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 XXXXXXX, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX, XXXXXXX,
                                 XXXXXXX, XXXXXXX, XXXXXXX,      XXXXXXX, KC_MPLY, KC_MUTE
  )
};

#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {

};
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)