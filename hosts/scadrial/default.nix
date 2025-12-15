{ config, pkgs, ... }:

let
  hostname = "Scadrial";

in {
  imports = [
    ../../darwin/default.nix
  ];
  networking.hostName = "${hostname}";
  networking.computerName = "${hostname}";
 }
