{ config, pkgs, lib, ... }:
{
  imports = [
    ../../common
    ../../darwin/packages/sketchybar/work.nix
    ../../darwin/packages/sketchyvim
    ../../darwin/packages/xbar
    ../../darwin/packages/wezterm
    ../../darwin/packages/karabiner-elements
    ../../darwin/packages/aerospace
  ];
  programs.zsh.envExtra = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  home.packages = with pkgs;
  [
    # macOS
    coreutils-full
    sketchybar
    xcbuild
    viu
    #python3
    #python3Packages.websocket-client
  ];

}
