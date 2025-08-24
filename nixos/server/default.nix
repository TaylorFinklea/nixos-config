{ config, pkgs, ... }:

let
  vars = import ../../vars.nix;
  # myPlex = pkgs.plex.overrideAttrs (_: rec {
  #   version = "1.40.0.7775-456fbaf97";
  #   # version = "1.25.2.5319-c43dc0277";
  #   src = pkgs.fetchurl {
  #     url = "https://downloads.plex.tv/plex-media-server-new/${version}/redhat/plexmediaserver-${version}.x86_64.rpm";
  #     sha256 = "sha256-5ov2J0UQJepDiJzInFCgD7ISoO9dl7r/xgNwIJX1TQE=";
  #   };
  # });
in {
  imports = [
    # ./docker-compose.nix
    # ./packages.nix
    # ../common
    # ./home.nix
  ];

  # };
  programs.fish.enable = true;

  programs.ssh.extraConfig = (builtins.readFile ../../darwin/packages/ssh/ssh_config);

  virtualisation.docker.enable = true;

  # Bonjour for discovery
  services.avahi = {
    nssmdns4 = true;
    enable = true;
    openFirewall = true;
    ipv4 = true;
    ipv6 = true;
    publish = {
      enable = true;
      addresses = true;
      workstation = true;
    };
  };

  # may be required for mounting an external disk
  services.devmon.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;

  # services.tailscale = {
  #   enable = true;
  #   useRoutingFeatures = "both";
  # };

  # nixpkgs.config.allowUnfree = true;

  # nix = {
  #   package = pkgs.nixVersions.latest;
  #   settings.trusted-users = ["${vars.user}"];
  #   extraOptions = ''
  #     experimental-features = nix-command flakes
  #   '';
  # };
  # fonts = {
  #   enableDefaultPackages = true;
  #   fontDir.enable = true;
  #   fontconfig = {
  #     antialias = true;
  #     cache32Bit = true;
  #     defaultFonts = {
  #       serif = ["DejaVuSansM Nerd Font"];
  #       sansSerif = ["DejaVuSansM Nerd Font"];
  #       monospace = ["DejaVuSansM Nerd Font Mono"];
  #     };
  #   };
  #   packages = with pkgs; [
  #     nerdfonts
  #     # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
  #   ];
  # };

  # # enable SSH so the system is available after install
  # services.openssh.enable = true;

  # For NFS
  services.nfs.server.enable = true;
  services.rpcbind.enable = true;
  environment.systemPackages = with pkgs; [ nfs-utils ];
  boot.initrd = {
    supportedFilesystems = [ "nfs" ];
    kernelModules = [ "nfs" ];
  };

  # users.users.${vars.user} = {
  #   name = "tfinklea";
  #   shell = pkgs.fish;
  #   isNormalUser = true;
  #   description = "tfinklea";
  #   extraGroups = [ "networkmanager" "wheel" "input" "audio" "docker"];
  #   openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINtOrpPLhHGrEKLboBkishy79+H6/F2GR/0pAL02iQxi tfinklea@mandalore" ];
  # };

  services.ollama = {
    enable = true;
    host = "0.0.0.0";
    port = 11434;
    acceleration = "cuda"; # Or "rocm" for AMD GPUs
  };

  # services.open-webui = {
  #   enable = true;
  #   port = 3000; # Or your preferred port
  #   host = "0.0.0.0"; # To allow external access, or "127.0.0.1" for local only
  #   openFirewall = true;
  #   environment = {
  #     OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
  #     OLLAMA_BASE_URL = "http://127.0.0.1:11434";
  #   };
  # };

  # services.searx = {
  #   enable = true;
  #   settings = {
  #     server = {
  #       bind_address = "127.0.0.1";
  #       port = 8888;
  #       secret_key = "9Bm#phzq7Ec65P&RDX^NtLaj5j#dcHzfErBK6$KwxlA^N2S#r@Ha66HC*3frJi#ZZ#&"; # Replace with a secure key
  #     };
  #   };
  # };

  networking = {
    firewall = {
      enable = true;
      allowedTCPPorts = [
      80 # nginx
      81 # nginx
      443 # nginx
      123 # ntp
      5353
      8000 # sillytavern
      9000 # portainer
      32400 # plex
      44509
      ];
    };
  };

  # Service account for NZB
  users.groups.media = {};
  users.groups.media.gid = 1001;

  users.users.media = {
    isSystemUser = true;
    # isNormalUser  = false;
    group = "media";
    home  = "/home/media";
    description  = "NZB Media Service Account";
    extraGroups  = [ "media" "docker" ];
    uid = 1001;
  };

  fileSystems."/mnt/bigpool" = {
    device = "10.0.0.12:/mnt/BigPool";
    fsType = "nfs";
    options = [ "nfsvers=4.2" ];
  };

 #  services.audiobookshelf = {
 #    enable = true;
 #    openFirewall = true;
 #    group = "media";
 #    # user = "media";
 #  };
 #
 #  services.plex = {
 #    enable = true;
 #    openFirewall = true;
 #    package = myPlex;
 #    group = "media";
 #    # user = "media";
 #  };
  # Turn off NIX_PATH warnings now that we're using flakes
  #system.checks.verifyNixPath = false;
  system.stateVersion = "23.05";
 }
