{ config, lib, pkgs, ... }:
{
  home.file."Library/Application Support/xbar/plugins" = {
    source = ./plugins;
    recursive = true;
  };
}
