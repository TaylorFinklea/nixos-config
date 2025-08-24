{ config, lib, pkgs, ... }:
{
  xdg.configFile.sketchybar = {
    target = "sketchybar"; 
    source = ./work;
    recursive = true;
  };

  home.file."Library/Fonts/sketchybar-app-font.ttf" = {
    source = ./sketchybar-app-font.ttf;
  };
}
