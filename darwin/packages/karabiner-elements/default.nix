{ config, lib, pkgs, ... }:
{
  home.file.".config/karabiner.edn" = {
    source = ./karabiner.edn;
  };
}
