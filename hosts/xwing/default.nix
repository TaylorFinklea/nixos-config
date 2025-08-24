{ config, pkgs, ... }:

let 
  user = "tfinklea"; 
  hostname = "xwing";

in {
  imports = [
    ../../nixos/server.nix
  ];
  networking.hostName = "${hostname}";
 }
