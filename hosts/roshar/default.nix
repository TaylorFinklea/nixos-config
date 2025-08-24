{ config, pkgs, ... }:

let
  hostname = "roshar";

in {
  imports = [
    ../../darwin/default.nix
  ];
  networking.hostName = "${hostname}";
  networking.computerName = "${hostname}";
 }
