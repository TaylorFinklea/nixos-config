{ pkgs, ... }:
let 
  vars = import ../../../vars.nix ;
in {
      xdg.configFile.xplr = {
        target = "xplr"; 
        source = ./xplr;
        recursive = true;
      };
      programs.xplr = {
        enable = true;

        # Optional params:
        plugins = {
          # tree-view = pkgs.fetchFromGitHub {
          #   owner = "sayanarijit";
          #   repo = "tree-view.xplr";
          # };
          wl-clipboard = pkgs.fetchFromGitHub {
            owner = "sayanarijit";
            repo = "wl-clipboard.xplr";
            rev = "a3ffc87460c5c7f560bffea689487ae14b36d9c3";
            hash = "sha256-I4rh5Zks9hiXozBiPDuRdHwW5I7ppzEpQNtirY0Lcks=";
          };
          zoxide = pkgs.fetchFromGitHub {
            owner = "sayanarijit";
            repo = "zoxide.xplr";
            rev = "e50fd35db5c05e750a74c8f54761922464c1ad5f";
            hash = "sha256-ZiOupn9Vq/czXI3JHvXUlAvAFdXrwoO3NqjjiCZXRnY";
          };
        };
        extraConfig = ''
          require("zoxide").setup()
          require("wl-clipboard").setup()
        '';
      };
}

