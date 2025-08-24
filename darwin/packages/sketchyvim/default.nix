{ config, lib, pkgs, ... }:
{
  xdg.configFile.svim = {
    target = "svim"; 
    source = ./svim;
    recursive = true;
  };
}
