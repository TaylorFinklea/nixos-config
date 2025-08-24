{ config, pkgs, ... }:
let 
  vars = import ../../../vars.nix;
in {
      programs.neovim = {
        enable = true;
        viAlias = true;
        vimAlias = true;
        defaultEditor = true;
      };

      xdg.configFile.nvim = {
        source = ./nvim;
        recursive = true;
      };
}

