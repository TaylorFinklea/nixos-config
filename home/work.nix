{ config, pkgs, lib, inputs, ... }:

let
  vars = import ../vars.nix;
in {
  imports = [
    ./work/packages.nix
    ./work/services.nix
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

  # Ayu Dark theme for atuin
  xdg.configFile."atuin/themes/ayu.toml".text = ''
    [theme]
    name   = "ayu"
    parent = ""

    [colors]
    Base       = "#B3B1AD"
    Title      = "#53BDFA"
    Important  = "#F9AF4F"
    Guidance   = "#90E1C6"
    Annotation = "#686868"
    AlertInfo  = "#59C2FF"
    AlertWarn  = "#FFB454"
    AlertError = "#EA6C73"
  '';

  # Tokyo-night Dark theme for atuin
  xdg.configFile."atuin/themes/tokyo-night.toml".text = ''
    [theme]
    name   = "tokyo-night"
    parent = ""

    [colors]
    Base       = "#C0CAF5"  # normal text
    Title      = "#7AA2F7"  # headers / titles (blue)
    Important  = "#E0AF68"  # highlights (gold)
    Guidance   = "#9ECE6A"  # subtle help (green)
    Annotation = "#545C7E"  # muted grey
    AlertInfo  = "#7DCFFF"  # info messages (cyan)
    AlertWarn  = "#FF9E64"  # warnings (orange)
    AlertError = "#F7768E"  # errors (red)
  '';

  programs.atuin = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      style        = "compact";
      invert       = false;
      show_help    = false;
      auto_sync    = true;
      sync_frequency = "10m";
      theme = { name = "ayu"; };
    };
  };

  programs.home-manager = {
    enable = true;
  };

  xdg.enable = true;
}
