{ config, lib, pkgs, ... }:

let
  vars = import ../../../vars.nix;
in {
      programs.tmux = {
        enable = true; 
      };

      home.file = {
        ".tmux" = {
          source = ./.tmux;
          recursive = true;
        };
        ".tmux.conf".source = ./.tmux.conf;
        ".tmux.conf.local".source = ./.tmux.conf.local;
      };
    # launchd.user.agents.skhd.serviceConfig.EnvironmentVariables.PATH = lib.mkForce "${config.services.yabai.package}/bin:${config.services.skhd.package}/bin:${config.my-meta.systemPath}:${config.services.emacs.package}/bin";
}
