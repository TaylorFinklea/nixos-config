{ config, lib, pkgs, ... }:
{
      home.file = {
        ".codex/config.toml" = {
          source = ./config.toml;
        };
      };
}
