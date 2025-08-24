{ config, lib, pkgs, ... }:
{
  # Copy Doom configuration files to the user's config directory
  xdg.configFile.doom = {
    target = "doom";
    source = ./doom;
    recursive = true;
  };
}
