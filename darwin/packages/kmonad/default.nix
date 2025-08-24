{ config, pkgs, lib, ... }:

let
  tapHoldDelay = 150;

  # IMPORTANT: Replace this placeholder with the actual device identifier found in Step 4
  # Example placeholder format, could be different: "product=Apple Internal Keyboard / Trackpad vendor=1452"
  # Or sometimes just the product name: "product=Apple Internal Keyboard / Trackpad"
  # Use `sudo kmonad --list-keyboards` on your Mac to find the correct identifier.
  mainKeyboardDeviceIdentifier = "PLEASE_REPLACE_ME_WITH_DEVICE_ID"; # <-- *** EDIT THIS ***

  # KMonad configuration content (adapted from your NixOS config)
  kmonadConfigContent = ''
    (defcfg
      input  (iokit_keyboard "${mainKeyboardDeviceIdentifier}")
      output (kmonad_keyoutput)
      fallthrough true
      allow-cmd true
    )

    (defsrc
      ;; This is a standard US ANSI layout for MacBooks.
      ;; If keys are wrong, you might need to run kmonad in debug mode
      ;; (`kmonad -l debug yourconfig.kbd`) and press keys to see their names.
      grv  1    2    3    4    5    6    7    8    9    0    -    =    bspc ;; 14 keys
      tab  q    w    e    r    t    y    u    i    o    p    [    ]    \    ;; 14 keys
      caps a    s    d    f    g    h    j    k    l    ;    '    ret       ;; 13 keys
      lsft z    x    c    v    b    n    m    ,    .    /    rsft           ;; 12 keys
      fn  lctl lalt lmet           spc            rmet ralt                 ;; 7 keys
    )

    (defalias
      nav (layer-toggle l2)
      num (layer-toggle l3)
      med (layer-toggle l4)
      sym (layer-toggle l5)
      fnl (layer-toggle l6) ;; Renamed from fn to avoid conflict with fn key

      ;; Basic modified keys
      tab_c (tap-hold-next-release ${toString tapHoldDelay} tab lctl)
      hyp_z (tap-hold-next-release ${toString tapHoldDelay} z C-A-S) ;; C-A-S might need testing on mac (Cmd-Opt-Shift)

      ;; Home row mods and special keys
      a_sft (tap-hold-next-release ${toString tapHoldDelay} a lsft)
      r_med (tap-hold-next-release ${toString tapHoldDelay} r @med)
      s_num (tap-hold-next-release ${toString tapHoldDelay} s @num)
      t_nav (tap-hold-next-release ${toString tapHoldDelay} t @nav)
      n_sym (tap-hold-next-release ${toString tapHoldDelay} n @sym)
      e_fnl (tap-hold-next-release ${toString tapHoldDelay} e @fnl) ;; Use renamed alias
      o_sft (tap-hold-next-release ${toString tapHoldDelay} o rsft) ;; Use rsft explicitly if needed

      ;; Other mods
      w_met (tap-hold-next-release ${toString tapHoldDelay} w lmet) ;; lmet is Cmd on Mac
      f_alt (tap-hold-next-release ${toString tapHoldDelay} f lalt) ;; lalt is Option on Mac
      u_alt (tap-hold-next-release ${toString tapHoldDelay} u ralt) ;; ralt is Right Option
      y_met (tap-hold-next-release ${toString tapHoldDelay} y rmet) ;; rmet is Right Cmd
    )

    # NOTE: The layout mapping assumes your defsrc matches the physical keys.
    #       The 'XX' placeholders might need adjustment based on the actual defsrc size.
    #       You have 16, 16, 14, 14, 10 keys in your mac defsrc example vs 14, 13, 12, 7 in linux
    #       --> I will ADJUST the layers below to match the *Linux* source layout size for now.
    #       --> You will likely need to RE-MAP this based on the ACTUAL keys reported by kmonad on your Mac.
    #       --> Use `XX` for keys you don't want to map from your `defsrc`.

    (deflayer main
      ;; Row 1 (14 keys like Linux config) - Map to first 14 keys of Mac `defsrc` row 1
      XX    q     @w_met @f_alt p     b     XX    j     l     @u_alt @y_met '     XX    XX   ;; Mapped to grv..bspc
      ;; Row 2 (13 keys) - Map to first 13 keys of Mac `defsrc` row 2
      XX   @a_sft @r_med @s_num @t_nav g     XX    m     @n_sym @e_fnl i     @o_sft ret ;; Mapped to tab..]
      ;; Row 3 (12 keys) - Map to first 12 keys of Mac `defsrc` row 3
      @hyp_z x     c     d     v     XX     XX  k     h     ,     .     ;         ;; Mapped to caps..ret
      ;; Row 4 (7 keys) - Map to first 7 keys of Mac `defsrc` row 5 (skipping row 4 shift)
      XX    XX    @tab_c      spc           bspc  ret   XX                  ;; Mapped to lctl..rmet
    )

    (deflayer l2 ;; NAV Layer
      ;; Row 1
      XX    XX    XX    XX    XX    XX    XX    XX  pgup  up    home  XX    XX    XX
      ;; Row 2
      XX    XX    XX    XX    XX    XX    XX    XX  left  down  right XX    ret
      ;; Row 3
      XX    XX    XX    XX    XX    XX    XX    XX  pgdn  C-A-x end   XX ;; C-A-x (Cmd-Opt-x?) needs testing
      ;; Row 4
      XX    XX    XX         esc           del   XX    XX
    )

    (deflayer l3 ;; NUM Layer
      ;; Row 1
      XX    XX    XX    XX    XX    XX    XX    XX    7     8     9     -    *    XX
      ;; Row 2
      XX    XX    ,     XX    .     XX    XX    XX    4     5     6     +    ret
      ;; Row 3
      XX    XX    XX    XX    XX    XX    XX    XX    1     2     3     =
      ;; Row 4
      XX    XX    XX         spc          ret   0     XX
    )

    (deflayer l4 ;; MED Layer
      ;; Row 1
      XX    XX    XX    XX    C-f   XX    XX    XX    XX    XX    XX    XX    XX    XX
      ;; Row 2
      XX    C-k   XX    C-v   C-c   C-x   XX    XX    XX    XX    A-spc XX    ret ;; A-spc (Opt-Space?)
      ;; Row 3
      XX    XX    XX    C-z   XX    XX    XX    XX    XX    XX    XX    XX
      ;; Row 4
      XX    XX    XX         XX            XX    XX    XX
    )

    (deflayer l5 ;; SYM Layer
      ;; Row 1
      XX    `     S-\   [     ]     S-4   XX    S-8   S-minus S-equal XX  XX    XX    XX
      ;; Row 2
      XX    S-3   /     S-9   S-0   S-5   S-2   XX     XX     XX    minus    S-;    ret
      ;; Row 3
      S-6   \     S-[   S-]   S-7   XX    S-1   S-/   XX     S-1     S-/    XX
      ;; Row 4
      XX    XX    XX         S-`           =     XX    XX
    )

    (deflayer l6 ;; FN Layer
      ;; Row 1
      XX    nlck  F17   F18   F19   F20   XX    XX    XX    XX    XX    XX    XX    XX
      ;; Row 2
      XX    caps  F9    F10   F11   F12   XX    F13   F14   F15   F16   XX    ret
      ;; Row 3
      slck  F1    F2    F3    F4    F5    F6    F7    F8    XX    XX    XX
      ;; Row 4
      XX    XX    XX         XX            XX    XX    XX
    )
  '';

  # Write the configuration to a file in the Nix store
  kmonadConfigFile = pkgs.writeText "kmonad.kbd" kmonadConfigContent;

  kmonadBin = "/opt/homebrew/bin/kmonad";
in {
  # Define the launchd system daemon (Correct location: top-level config)
  launchd.daemons.kmonad = {
    command = "${lib.getExe pkgs.kmonad} ${kmonadConfigFile}";
    serviceConfig = {
      UserName = "root";
      RunAtLoad = true;
      KeepAlive = true;
      StandardOutPath = "/var/log/kmonad.log";
      StandardErrorPath = "/var/log/kmonad.error.log";
      EnvironmentVariables = {
         KMONAD_LOG_LEVEL = "info";
      };
      ProcessType = "Interactive";
    };
  };

  system.activationScripts.preActivation.text = ''
    echo "Setting up kmonad log files..."
    touch /var/log/kmonad.log /var/log/kmonad.error.log
    chown root:wheel /var/log/kmonad.log /var/log/kmonad.error.log
    chmod 640 /var/log/kmonad.log /var/log/kmonad.error.log
  '';
}
