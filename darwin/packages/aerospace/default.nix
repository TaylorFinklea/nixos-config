{ config, lib, pkgs, ... }:

{
  home.file.aerospace = {
    target = ".aerospace.toml";
    source = ./.aerospace.toml;
  };
}
