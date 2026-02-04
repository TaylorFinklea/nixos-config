{ config, pkgs, lib, ... }:
# let
#   writingtools = import ./packages/writingtools {
#     inherit (pkgs) stdenv lib fetchurl makeWrapper coreutils;
#   };
# in
{
  imports = [
    ../common
    ./packages/ssh
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  home.packages = with pkgs; [
    coreutils-full
    xcbuild
  ];
}
