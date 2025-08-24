{ config, pkgs, ... }:
let
  vars = import ../../../vars.nix;
in {
  services.keyd = {
    enable = true;
    keyboards = {
      mustafar = {
        ids = [
          "0001:0001:a38e6885"
        ]; # what goes into the [id] section, here we select all keyboards
        extraConfig = ''
          [global]
          chord_timeout = 50  # for multi-key chords
          overload_tap_timeout = 150  # helps with homerow mods, 150ms is pretty fast
          macro_sequence_timeout = 1000  # helps with macro reliability

          [main]
          tab = noop
          q = q
          w = overload(meta, w)
          e = overload(alt, f)
          r = p
          t = b
          u = j
          i = l
          o = overload(alt, u)
          p = overload(meta, y)
          [ = apostrophe
          ] = noop
          \ = noop

          capslock = noop
          a = overload(shift, a)
          s = overload(l4, r)
          d = overload(l3, s)
          f = overload(l2, t)
          g = g
          j = m
          k = overload(l5, n)
          l = overload(l6, e)
          ; = i
          ' = overload(shift, o)
          enter = enter

          leftshift = overload(hyper, z)
          z = x
          x = c
          c = d
          v = v
          m = k
          , = h
          . = comma
          / = dot
          rightshift = semicolon

          leftcontrol = noop
          leftmeta = noop
          leftalt = overload(control, tab)
          space = space
          rightalt = backspace
          sysrq = overload(control, enter)
          rightcontrol = noop

          [hyper:C-A-S]

          # Layer 2 (Navigation) - triggered by 'f'
          [l2]
          i = pageup
          o = up
          p = home
          k = left
          l = down
          ; = right
          , = pagedown
          . = C-A-x
          / = end
          leftmeta = esc
          space = esc
          rightmeta = delete

          # Layer 3 (Numpad) - triggered by 'd'
          [l3]
          u = kp/
          i = kp7
          o = kp8
          p = kp9
          [ = kp-
          s = comma
          f = dot
          j = kp*
          k = kp4
          l = kp5
          ; = kp6
          ' = kp+
          , = kp1
          . = kp2
          / = kp3
          rightshift = kp=
          space = enter
          sysrq = kp0

          [l4]
          e = C-f
          a = C-k
          d = C-v
          f = C-c
          g = C-x
          ' = A-space
          c = C-z

          # Layer 5 (Symbols) - triggered by 'k'
          [l5]
          q = `
          w = S-\
          e = [
          r = ]
          t = S-4
          o = S-8
          p = S-minus
          [ = S-equal
          a = S-3
          s = /
          d = S-9
          f = S-0
          g = S-5
          l = S-2
          ; = minus
          ' = S-;
          leftshift = S-6
          z = \
          x = S-[
          c = S-]
          v = S-7
          . = S-1
          / = S-/
          space = S-`
          sysrq = equal

          [l6]
          q = numlock
          w = F17
          e = F18
          r = F19
          t = F20
          a = capslock
          s = F9
          d = F10
          f = F11
          g = F12
          j = F13
          k = F14
          ; = F15
          ' = F16
          leftshift = scrolllock
          z = F1
          x = F2
          c = F3
          v = F4
          m = F5
          , = F6
          / = F7
          rightshift = F8

          # Layer 8 (Mouse Mode) - triggered by spacebar
          # Note: Mouse control might require additional setup or external tools in Linux
          [space:M]
          # Mouse controls would go here, but keyd doesn't directly support mouse control
          # Base Colemak-CAWS layout
          # Layer 4 (Media) - triggered by 's'
          # Layer 6 (Function) - triggered by 'l'
          # You might need to use additional tools like xdotool for mouse control
          #
          };
        '';
      };
      qmk-keebs = {
        ids = [
          "c3ab:3139:77f6650e"
        ]; # what goes into the [id] section, here we select all keyboards
        extraConfig = ''
          [main]
          leftcontrol = leftmeta
          leftmeta = leftcontrol
          rightcontrol = rightmeta
          rightmeta = rightcontrol
          };
        '';
      };
    };
  };
  # Optional, but makes sure that when you type the make palm rejection work with keyd
  # https://github.com/rvaiya/keyd/issues/723
  environment.etc."libinput/local-overrides.quirks".text = ''
    [Serial Keyboards]
    MatchUdevType=keyboard
    MatchName=keyd virtual keyboard
    AttrKeyboardIntegration=internal
  '';
}
