{ config, pkgs, ... }:
let
  tapHoldDelay = 150;
  mainKeyboardDevice = "/dev/input/by-path/platform-i8042-serio-0-event-kbd";
in {
  services.kmonad = {
    enable = true;
    keyboards = {
      mustafar = {
        device = mainKeyboardDevice;
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = true;
        };

        config = ''
          (defsrc
            tab  q    w    e    r    t    y    u    i    o    p    [    ]    \    ;; 14 keys
            caps a    s    d    f    g    h    j    k    l    ;    '    ret  ;; 13 keys
            lsft z    x    c    v    b    n    m    ,    .    /    rsft      ;; 12 keys
            lctl lmet lalt      spc           ralt sys  rctl                   ;; 7 keys
          )

          (defalias
            nav (layer-toggle l2)
            num (layer-toggle l3)
            med (layer-toggle l4)
            sym (layer-toggle l5)
            fn  (layer-toggle l6)

            ;; Basic modified keys
            tab_c (tap-hold-next-release ${toString tapHoldDelay} tab lctl)
            hyp_z (tap-hold-next-release ${toString tapHoldDelay} z C-A-S)

            ;; Home row mods and special keys
            a_sft (tap-hold-next-release ${toString tapHoldDelay} a lsft)
            r_med (tap-hold-next-release ${toString tapHoldDelay} r @med)
            s_num (tap-hold-next-release ${toString tapHoldDelay} s @num)
            t_nav (tap-hold-next-release ${toString tapHoldDelay} t @nav)
            n_sym (tap-hold-next-release ${toString tapHoldDelay} n @sym)
            e_fn  (tap-hold-next-release ${toString tapHoldDelay} e @fn)
            o_sft (tap-hold-next-release ${toString tapHoldDelay} o lsft)

            ;; Other mods
            w_met (tap-hold-next-release ${toString tapHoldDelay} w lmet)
            f_alt (tap-hold-next-release ${toString tapHoldDelay} f lalt)
            u_alt (tap-hold-next-release ${toString tapHoldDelay} u lalt)
            y_met (tap-hold-next-release ${toString tapHoldDelay} y lmet)
          )

          (deflayer main
            XX    q     @w_met @f_alt p     b     XX    j     l     @u_alt @y_met '     XX    XX    ;; 14 keys
            X    @a_sft @r_med @s_num @t_nav g     XX    m     @n_sym @e_fn  i     @o_sft ret  ;; 13 keys
            @hyp_z x     c     d     v     XX     XX  k     h     ,     .     ;          ;; 12 keys
            XX    XX    @tab_c      spc           bspc  ret   XX                   ;; 7 keys
          )

          (deflayer l2
            XX    XX    XX    XX    XX    XX    XX    XX  pgup  up    home  XX    XX    XX  ;; 14 keys
            XX    XX    XX    XX    XX    XX    XX    XX  left  down  right XX    ret  ;; 13 keys
            XX    XX    XX    XX    XX    XX    XX    XX  pgdn  C-A-x end   XX ;; 12 keys
            XX    XX    XX         esc           del   XX    XX                   ;; 7 keys
          )

          (deflayer l3
            XX    XX    XX    XX    XX    XX    XX    XX    7     8     9     -    *   XX    ;; 14 keys
            XX    XX    ,     XX    .     XX    XX    XX    4     5     6     +     ret  ;; 13 keys
            XX    XX    XX    XX    XX    XX    XX    XX    1     2     3     =    ;; 12 keys
            XX    XX    XX         spc          ret   0     XX                   ;; 7 keys
          )

          (deflayer l4
            XX    XX    XX    XX    C-f   XX    XX    XX    XX    XX    XX    XX    XX    XX    ;; 14 keys
            XX    C-k   XX    C-v   C-c   C-x   XX    XX    XX    XX    A-spc XX    ret  ;; 13 keys
            XX    XX    XX    C-z   XX    XX    XX    XX    XX    XX    XX    XX          ;; 12 keys
            XX    XX    XX         XX            XX    XX    XX                   ;; 7 keys
          )

          (deflayer l5
            XX    `     S-\   [     ]     S-4   XX    S-8   S-minus S-equal XX  XX    XX    XX    ;; 14 keys
            XX    S-3   /     S-9   S-0   S-5   S-2   XX     XX     XX    minus    S-;    ret  ;; 13 keys
            S-6   \     S-[   S-]   S-7   XX    S-1   S-/   XX     S-1     S-/    XX          ;; 12 keys
            XX    XX    XX         S-`           =     XX    XX                   ;; 7 keys
          )

          (deflayer l6
            XX    nlck  F17   F18   F19   F20   XX    XX    XX    XX    XX    XX    XX    XX    ;; 14 keys
            XX    caps  F9    F10   F11   F12   XX    F13   F14   F15   F16   XX    ret  ;; 13 keys
            slck  F1    F2    F3    F4    F5    F6    F7    F8    XX    XX    XX          ;; 12 keys
            XX    XX    XX         XX            XX    XX    XX                   ;; 7 keys
          )
        '';
      };
      qmk-keebs = {
        device = "/dev/input/by-id/c3ab:3139:77f6650e";
        defcfg = {
          enable = true;
          fallthrough = true;
          allowCommands = true;
        };
        config = ''
          (defsrc
            lctl lmet rctl rmet
          )

          (deflayer main
            lmet lctl rmet rctl
          )
        '';
      };
    };
  };

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=kmonad
    AttrKeyboardIntegration=internal
  '';

  environment.systemPackages = [ pkgs.kmonad ];

  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="input", OPTIONS+="static_node=uinput"
  '';
}
