/*
 * Layer 0: Alphas
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │ { │ Q │ W │ E │ R │ T │       │ Y │ U │ I │ O │ P │ } │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │ ( │ A │ S │ D │ F │ G │       │ H │ J │ K │ L │ ; │ ) │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │=,+│ Z │ X │ C │ V │ B │       │ N │ M │ , │ . │ / │-,_│
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │ESC├───┐           ┌───┤DEL│
 *               └───┤SPC├───┐   ┌───┤BSP├───┘
 *                 4 └───┤TAB│   │ENT├───┘
 *                       └───┘   └───┘ 3
 *                         1       2
 *
 * Layer 1: Numbers
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │   │   │   │   │   │   │       │   │ 7 │ 8 │ 9 │   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │   │   │   │   │   │       │   │ 4 │ 5 │ 6 │   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │ + │   │   │   │   │   │       │   │ 1 │ 2 │ 3 │ , │ - │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │   ├───┐           ┌───┤ . │
 *               └───┤   ├───┐   ┌───┤   ├───┘
 *                   └───┤ ⊗ │   │ 0 ├───┘
 *                       └───┘   └───┘
 * Layer 2: Symbols
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │ [ │   │   │ ^ │ & │   │       │   │ ` │ * │   │ \ │ ] │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │ < │   │   │ # │ @ │   │       │   │ " │ ~ │   │ : │ > │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │ + │   │   │ $ │ | │   │       │   │ ' │ % │   │ ? │ _ │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │   ├───┐           ┌───┤   │
 *               └───┤   ├───┐   ┌───┤   ├───┘
 *                   └───┤ ! │   │ ⊗ ├───┘
 *                       └───┘   └───┘
 * Layer 3: Navigation
 * ┌───┬───┬───┬───┬───┬───┐       ┌───┬───┬───┬───┬───┬───┐
 * │   │   │   │   │   │   │       │   │PGU│   │   │   │   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │HOM│   │   │   │   │       │ ◀ │ ▼ │ ▲ │ ▶ │END│   │
 * ├───┼───┼───┼───┼───┼───┤       ├───┼───┼───┼───┼───┼───┤
 * │   │C-Z│C-X│C-C│C-V│   │       │   │PGD│   │   │   │   │
 * └───┴───┴───┴───┴───┴───┘       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │   ├───┐           ┌───┤   │
 *               └───┤WIN├───┐   ┌───┤ ⊗ ├───┘
 *                   └───┤   │   │   ├───┘
 *                       └───┘   └───┘
 * Layer 4: Media
 * ┌───┬───┬───┬───┬───┬───┬       ┌───┬───┬───┬───┬───┬───┐
 * │   │   │   │   │   │   │       │F12│F7 │F8 │F9 │   │   │
 * ├───┼───┼───┼───┼───┼───┼       ├───┼───┼───┼───┼───┼───┤
 * │   │   │⏮ │🔉 │🔊 │⏭ │       │F11│F4 │F5 │F6 │   │   │
 * ├───┼───┼───┼───┼───┼───┼       ├───┼───┼───┼───┼───┼───┤
 * │   │   │   │   │   │   │       │F10│F1 │F2 │F3 │   │   │
 * └───┴───┴───┴───┴───┴───┴       └───┴───┴───┴───┴───┴───┘
 *               ┌───┐                   ┌───┐
 *               │ ⊗ ├───┐           ┌───┤🔇 │
 *               └───┤   ├───┐   ┌───┤⏯ ├───┘
 *                   └───┤   │   │   ├───┘
 *                       └───┘   └───┘
 */
#include QMK_KEYBOARD_H

// Home Row Mods (Shift, Ctrl, Alt)
#define HRM_F       LCTL_T(KC_F)
#define HRM_J       RCTL_T(KC_J)
#define HRM_D       LSFT_T(KC_D)
#define HRM_K       RSFT_T(KC_K)
#define HRM_S       LALT_T(KC_S)
#define HRM_L       RALT_T(KC_L)
#define HRM_A       LGUI_T(KC_A)
#define HRM_SEMI    RGUI_T(KC_SCLN)


const uint16_t PROGMEM keymaps[][MATRIX_ROWS][MATRIX_COLS] = {
  // Base Layer
  [0] = LAYOUT_split_3x6_3(
        KC_LCBR,  KC_Q,  KC_W,  KC_E,  KC_R, KC_T,                  KC_Y,  KC_U,    KC_I,   KC_O,     KC_P, KC_RCBR,
        KC_LPRN, HRM_A, HRM_S, HRM_D, HRM_F, KC_G,                  KC_H, HRM_J,   HRM_K,  HRM_L, HRM_SEMI, KC_RPRN,
        KC_EQUAL, KC_Z,  KC_X,  KC_C,  KC_V, KC_B,                  KC_N,  KC_M, KC_COMM, KC_DOT,  KC_SLSH, KC_MINUS,
                     LT(4,KC_ESC), KC_SPC, LT(1,KC_TAB),     LT(2,KC_ENT), LT(3,KC_BSPC), KC_DEL
  ),
  // Number Layer
  [1] = LAYOUT_split_3x6_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 XXXXXXX, KC_7, KC_8, KC_9, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, _______, _______, _______, XXXXXXX,                 XXXXXXX, KC_4, KC_5, KC_6, XXXXXXX,  XXXXXXX,
        KC_PLUS, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 XXXXXXX, KC_1, KC_2, KC_3, KC_COMM, KC_MINUS,
                                   XXXXXXX, XXXXXXX, XXXXXXX,      KC_0, _______, KC_DOT
  ),
  // Symbol Layer
  [2] = LAYOUT_split_3x6_3(
        KC_LBRC, XXXXXXX, XXXXXXX, KC_CIRC,  KC_AMPR, XXXXXXX,             XXXXXXX, KC_GRAVE, KC_ASTR,  XXXXXXX,   KC_BSLS,  KC_RBRC,
        KC_LABK, XXXXXXX, _______, KC_HASH,  KC_AT,   XXXXXXX,             XXXXXXX, KC_DQUO,  KC_TILDE, _______,   KC_COLN,  KC_RABK,
        KC_PLUS, XXXXXXX, XXXXXXX, KC_DLR,   KC_PIPE, XXXXXXX,             XXXXXXX, KC_QUOT,  KC_PERC,  XXXXXXX,   KC_QUES,  KC_UNDS,
                                     _______,  _______, KC_EXLM,      XXXXXXX, XXXXXXX, XXXXXXX
  ),
  // Navigation Layer
  [3] = LAYOUT_split_3x6_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,             XXXXXXX, KC_PGUP, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX,
        XXXXXXX, KC_HOME, KC_LALT, KC_LSFT, KC_LCTL, XXXXXXX,             KC_LEFT, KC_DOWN, KC_UP,   KC_RIGHT, KC_END,  XXXXXXX,
        XXXXXXX, KC_UNDO, KC_CUT,  KC_COPY, KC_PSTE, XXXXXXX,             XXXXXXX, KC_PGDN, XXXXXXX, XXXXXXX,  XXXXXXX, XXXXXXX,
                                       XXXXXXX, KC_LWIN, XXXXXXX,      XXXXXXX, XXXXXXX, XXXXXXX
  ),
  // Media Layer
  [4] = LAYOUT_split_3x6_3(
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 KC_F12, KC_F7, KC_F8,  KC_F9, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, KC_MPRV, KC_VOLD, KC_VOLU,  KC_MNXT,                KC_F11, KC_F4, KC_F5,  KC_F6, XXXXXXX, XXXXXXX,
        XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX, XXXXXXX,                 KC_F10, KC_F1, KC_F2,  KC_F3, XXXXXXX, XXXXXXX,
                                 XXXXXXX, XXXXXXX, XXXXXXX,      XXXXXXX, KC_MPLY, KC_MUTE
  )
};


#if defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
const uint16_t PROGMEM encoder_map[][NUM_ENCODERS][NUM_DIRECTIONS] = {

};
#endif // defined(ENCODER_ENABLE) && defined(ENCODER_MAP_ENABLE)
