{ config, pkgs, lib, inputs, ... }:

let
  vars = import ../vars.nix;
in {
  imports = [
    ./packages.nix
  ];

  home = {
    enableNixpkgsReleaseCheck = false;
    username = "${vars.user}";
    homeDirectory = lib.mkDefault "/home/${vars.user}";
    stateVersion = "23.05";
  };

  programs.home-manager.enable = true;
  xdg.enable = true;

  programs.git.enable = true;
  programs.fish.enable = true;
  programs.rofi = {
    enable = true;
  };
  # Use a dark theme
  # gtk = {
  #   enable = true;
  #   iconTheme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome.adwaita-icon-theme;
  #   };
  #   theme = {
  #     name = "Adwaita-dark";
  #     package = pkgs.gnome.adwaita-icon-theme;
  #   };
  # };

  # Screen lock
  # services.screen-locker = {
  #   enable = true;
  #   inactiveInterval = 30;
  #   lockCmd = "${pkgs.betterlockscreen}/bin/betterlockscreen -l dim";
  #   xautolock.extraOptions = [
  #     "Xautolock.killer: systemctl suspend"
  #   ];
  # };

  # Auto mount devices
  #services.udiskie.enable = true;

}
