{ config, lib, pkgs, ... }:
{
  xdg.configFile.wezterm = {
    target = "wezterm"; 
    source = ./wezterm;
    recursive = true;
  };
}
