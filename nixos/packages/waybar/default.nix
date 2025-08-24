{ config, pkgs, ... }:
let
  vars = import ../../../vars.nix;
in {
  home-manager = {
    users.${vars.user} = {
      xdg.configFile.waybar = {
        target = "waybar";
        source = ./waybar;
        recursive = true;
      };
      xdg.configFile."swaync/config.json".text = ''
        {
          "$schema": "/etc/xdg/swaync/configSchema.json",
          "positionX": "right",
          "positionY": "top",
          "control-center-margin-top": 10,
          "control-center-margin-bottom": 10,
          "control-center-margin-right": 10,
          "control-center-margin-left": 10,
          "notification-icon-size": 64,
          "notification-body-image-height": 100,
          "notification-body-image-width": 200,
          "timeout": 10,
          "timeout-low": 5,
          "timeout-critical": 0,
          "fit-to-screen": true,
          "control-center-width": 500,
          "notification-window-width": 500
        }
      '';

      # Optional: Add custom style
      xdg.configFile."swaync/style.css".text = ''
        .notification-row {
          outline: none;
        }

        .notification {
          background: #1e1e2e;
          margin: 6px;
          padding: 0;
          border-radius: 5px;
        }

        .notification-content {
          background: transparent;
          padding: 6px;
          border-radius: 5px;
        }
      '';
    };
  };

}
