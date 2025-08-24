{ config, lib, pkgs, ... }:
{
  xdg.configFile.sketchybar = {
    target = "sketchybar"; 
    source = ./sketchybar;
  };

  home.file."Library/Fonts/sketchybar-app-font.ttf" = {
    source = ./sketchybar-app-font.ttf;
  };
}
