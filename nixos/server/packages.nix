{ config, pkgs, lib, ... }:
  # yabai = pkgs.yabai.overrideAttrs (oldAttrs: rec {
  #   version = "5.0.6";
  #   src = pkgs.fetchFromGitHub {
  #     owner = "koekeishiya";
  #     repo = "yabai";
  #     rev = "v${version}";
  #     sha256 = "sha256-uy1KOBJa9BNK5bd+5q5okMouAV0H3DUXrG3Mvr5U6oc=";
  #   };
  # });
{
  imports = [
    ../../common
    # ./packages/sketchybar
    # ./packages/yabai
    # ./packages/skhd
    # ./packages/xbar
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  home.packages = with pkgs; [ 
    cypress
    chromedriver

    fontconfig
    font-manager

    gnumake
    gnugrep
    home-manager

    # inotifywait, inotifywatch
    # For file system events
    inotify-tools
    libnotify
    lshw
    toybox
    wev
    brightnessctl

    wireguard-tools
    wayvnc

    openssh

    pinentry-curses
    postgresql

    # Our file browser
    pcmanfm

    qmk
    screenkey
    sqlite
    tree
    # unixtools.ifconfig
    # unixtools.netstat
    xdg-utils
    unzip
    # docker
    docker-compose

    # cifs-utils
    # nfs-utils
  ];
}
