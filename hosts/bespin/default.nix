{ config, pkgs, ... }:

let 
  user = "tfinklea"; 
  hostname = "mandalore";

in {
  imports = [
    ../../darwin/default.nix
  ];
  networking.hostName = "${hostname}";
 }
