{ config, lib, pkgs, ... }:
{
  xdg.configFile.skhd = {
    target = "skhd/skhdrc"; 
    source = ./skhdrc;
  };
}
