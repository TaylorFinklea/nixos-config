{ config, pkgs, ... }:
let
  vars = import ../../../vars.nix;
in {
  home-manager = {
    users.${vars.user} = {
      xdg.configFile.warpd = {
        target = "warpd/config";
        text = ''
          hint_activation_key: <Super><Alt><Shift>space
          normal_activation_key: <Super><Alt>space
        '';
      };

    };
  };

}
