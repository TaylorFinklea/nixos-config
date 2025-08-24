{ config, lib, pkgs, ... }:
{
  xdg.configFile.ghostty = {
    target = "ghostty";
    source = ./ghostty;
    recursive = true;
  };
}
