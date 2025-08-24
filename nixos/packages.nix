{ config, pkgs, lib, ... }:
let
  vars = import ../vars.nix;
in {
  imports = [
    ../common
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
    gcc
    home-manager

    # inotifywait, inotifywatch
    # For file system events
    inotify-tools
    libnotify
    lshw
    #toybox
    wev
    brightnessctl
    netscanner
    coreutils            # Provides ls, cat, rm, mkdir, etc.
    gnugrep              # If you prefer GNU grep
    gawk                 # GNU awk
    gnused               # GNU sed
    findutils            # For the find command
    gnutar               # GNU tar
    gzip                 # For gzip compression
    bzip2                # For bzip2 compression
    xz                   # For xz compression
    which                # To locate commands
    moreutils            # Provides extra utilities like sponge and vidir
    openssh
    gnome-disk-utility
    udisks2
    usbutils

    pinentry-curses
    postgresql

    # Our file browser
    pcmanfm

    opencode

    emacs
    git-crypt
    qmk
    #rnix-lsp # lsp-mode for nix
    screenkey
    sqlite
    tree
    # unixtools.ifconfig
    # unixtools.netstat
    xdg-utils
    unzip
    nfs-utils
    docker-compose
    nmap
    gping
    tailscale
  ];
}
