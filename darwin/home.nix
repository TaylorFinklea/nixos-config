{ config, pkgs, ... }:

let
  vars = import ../vars.nix;
in {
  imports = [
    ./packages.nix
  ];

  home = {
    stateVersion = "23.05";
    username = "${vars.user}";
    homeDirectory = "/Users/${vars.user}";
    enableNixpkgsReleaseCheck = false;
    sessionVariables = {
      PATH = "$HOME/.local/bin:$PATH";
      PYTHONPATH = "$HOME/.nix-profile/lib/python3.12/site-packages${PYTHONPATH:+:}$PYTHONPATH";
    };
  };

  programs.home-manager = {
    enable = true;
  };

  programs.atuin = {
    enable               = true;   # install & configure
    enableZshIntegration = true;   # defaults to true, set explicitly for clarity
    # Optional – tweak Atuin itself
    # settings = {
    #   auto_sync     = true;
    #   sync_frequency = "10m";
    # };
  };

  xdg.enable = true;

    # https://github.com/nix-community/home-manager/issues/3344
    # Marked broken Oct 20, 2022 check later to remove this
    # Confirmed still broken, Mar 5, 2023
    # manual.manpages.enable = false;
}
