{ config, pkgs, ... }:
let
  vars = import ../../../vars.nix;
in {
  programs.hyprland = {
    enable = true;
    withUWSM = true;
  };
  programs.uwsm.enable = true;

  home-manager = {
    users.${vars.user} = {
      xdg.configFile.hyprland = {
        target = "hypr/hyprland.conf";
        source = ./hyprland.conf;
      };

      xdg.configFile.hypridle = {
        target = "hypr/hypridle.conf";
        text = ''
          general {
              lock_cmd = pidof hyprlock || hyprlock       # avoid starting multiple hyprlock instances.
              before_sleep_cmd = loginctl lock-session    # lock before suspend.
              after_sleep_cmd = hyprctl dispatch dpms on; ~/.config/scripts/wallpaper.sh  # turn on display and change wallpaper
          }

          listener {
              timeout = 150                                # 2.5min.
              on-timeout = brightnessctl -s set 10         # set monitor backlight to minimum, avoid 0 on OLED monitor.
              on-resume = brightnessctl -r                 # monitor backlight restore.
          }

          listener {
              timeout = 300                                 # 5min
              on-timeout = loginctl lock-session            # lock screen when timeout has passed
          }

          listener {
              timeout = 330                                 # 5.5min
              on-timeout = hyprctl dispatch dpms off        # screen off when timeout has passed
              on-resume = hyprctl dispatch dpms on          # screen on when activity is detected after timeout has fired.
          }

          listener {
              timeout = 1800                                # 30min
              on-timeout = systemctl suspend                # suspend pc
          }
        '';
      };

      xdg.configFile.hyprlock = {
        target = "hypr/hyprlock.conf";
        text = ''
          background {
              monitor =
              path = ~/.local/share/wallpapers/lock.jpg    # Using the blurred version
              color = rgba(25, 20, 20, 1.0)

              blur_passes = 2
              blur_size = 7
              noise = 0.0117
              contrast = 0.8916
              brightness = 0.8172
              vibrancy = 0.1696
              vibrancy_darkness = 0.0
          }
          input-field {
              monitor =
              size = 200, 50
              outline_thickness = 3
              dots_size = 0.33
              dots_spacing = 0.15
              dots_center = false
              dots_rounding = -1
              outer_color = rgb(24, 202, 230)  # #18cae6
              inner_color = rgb(200, 200, 200)
              font_color = rgb(10, 10, 10)
              fade_on_empty = true
              fade_timeout = 1000
              placeholder_text = <i>Input Password...</i>
              hide_input = false
              rounding = -1
              check_color = rgb(24, 202, 230)  # #18cae6
              fail_color = rgb(204, 34, 34)
              fail_text = <i>$FAIL <b>($ATTEMPTS)</b></i>
              fail_transition = 300
              capslock_color = rgb(24, 202, 230)  # #18cae6
              numlock_color = rgb(24, 202, 230)  # #18cae6
              bothlock_color = rgb(24, 202, 230)  # #18cae6
              invert_numlock = false

              position = 0, -20
              halign = center
              valign = center
          }

          label {
              monitor =
              text = cmd[update:1000] date "+%H:%M:%S"
              color = rgba(200, 200, 200, 1.0)
              font_size = 25

              position = 0, 80
              halign = center
              valign = center
          }

          label {
              monitor =
              text = Hi there, $USER
              color = rgba(200, 200, 200, 1.0)
              font_size = 20

              position = 0, 40
              halign = center
              valign = center
          }

          label {
              monitor =
              text = Type to unlock!
              color = rgba(200, 200, 200, 1.0)
              font_size = 15

              position = 0, 0
              halign = center
              valign = center
          }
        '';
      };
      xdg.configFile.scripts = {
        target = "scripts";
        source = ./scripts;
        recursive = true;
      };
    };
  };

}
