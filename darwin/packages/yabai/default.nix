{ config, lib, pkgs, ... }:

{
  xdg.configFile.yabai = {
    target = "yabai/yabairc"; 
    source = ./yabairc;
  };
  xdg.configFile.yabai-scripts = {
    target = "yabai/scripts"; 
    source = ./scripts;
    recursive = true;
  };
}
