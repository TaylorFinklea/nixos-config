{ config, pkgs, ... }:
{
  # User-level services for work configuration
  # Note: The original darwin/work/services.nix was mostly empty with commented sketchybar
  # This maintains the same structure but converts any system services to user-level equivalents

  # services.sketchybar = {
  #   enable = true;
  #   package = pkgs.sketchybar;
  # };
}
