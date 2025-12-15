{ config, pkgs, ... }:

let
  vars = import ../vars.nix;
in {
  imports = [
    #./dock
    ./services.nix
    ./preferences.nix
    ./brew.nix
  ];

  users.users.${vars.user} = {
    name = "${vars.user}";
    home = "/Users/${vars.user}";
    shell = pkgs.zsh;
  };

  system.primaryUser = "${vars.user}";

  ids.gids.nixbld = 350;



  nix = {
    # Use the stable Nix build with flakes support
    package = pkgs.nixVersions.latest;  # stable Nix with flakes support
    settings = {
      trusted-users = ["${vars.user}"];
      experimental-features = "nix-command flakes";
    };
  };

  security.pam.services.sudo_local.touchIdAuth = true;

  nixpkgs.config.allowUnfree = true;

  # Turn off NIX_PATH warnings now that we're using flakes
  system.checks.verifyNixPath = false;
  # nixpkgs.overlays = [
  #   (self: super: {
  #     yabai = super.yabai.overrideAttrs (old: {
  #       src = super.fetchFromGitHub {
  #         owner = "koekeishiya";
  #         repo = "yabai";
  #         rev = "v5.0.8";
  #         sha256 = "sha256-uy1KOBJa9BNK5bd+5q5okMouAV0H3DUXrG3Mvr5U6oc="; #will be given on build
  #       };
  #     });
  #   })
  # ];
 }
