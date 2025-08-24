{ config, pkgs, lib, ... }:
# let
#   writingtools = import ./packages/writingtools {
#     inherit (pkgs) stdenv lib fetchurl makeWrapper coreutils;
#   };
# in
{
  imports = [
    ../common
    ./packages/sketchybar
    ./packages/sketchyvim
    ./packages/xbar
    ./packages/ssh
    ./packages/wezterm
    ./packages/karabiner-elements
    ./packages/aerospace
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  home.packages = with pkgs; [
    coreutils-full
    xcbuild
    sketchybar
    traccar
    #writingtools
    # tailscale
    # go
    # tailscale.overrideAttrs (old:{<derivation tailscale-1.62.0>})
  ];
}
