{ config, pkgs, ... }:

let
  vars = import ../vars.nix;
in {
  imports = [
    #./packages.nix
    # ../common
    #./home.nix
  ];


  # };

  services.tailscale = {
    enable = true;
    useRoutingFeatures = "both";
  };

  programs.ssh.extraConfig = (builtins.readFile ../darwin/packages/ssh/ssh_config);
  systemd.services.NetworkManager-wait-online.enable = false;
  nix = {
    package = pkgs.nixVersions.latest;
    settings = {
      trusted-users = ["${vars.user}"];
      download-buffer-size = 134217728; # 128 MiB
    };
    extraOptions = ''
      experimental-features = nix-command flakes
    '';
  };
  fonts = {
    enableDefaultPackages = true;
    fontDir.enable = true;
    fontconfig = {
      antialias = true;
      cache32Bit = true;
      defaultFonts = {
        serif = ["DejaVuSansM Nerd Font"];
        sansSerif = ["DejaVuSansM Nerd Font"];
        monospace = ["DejaVuSansM Nerd Font Mono"];
      };
    };
    packages = with pkgs; [
      nerd-fonts.dejavu-sans-mono
      nerd-fonts.fira-code
      nerd-fonts.droid-sans-mono
      # (nerdfonts.override { fonts = [ "FiraCode" "DroidSansMono" ]; })
    ];
  };
  nixpkgs.config.allowUnfree = true;
  # nixpkgs.config.nvidia.acceptLicense = true;
  # networking.firewall.allowedTCPPorts = [ 11434 ];
  networking.firewall.enable = true;
  nixpkgs.config.nvidia.acceptLicense = true;

  # services.open-webui = {
  #   enable = true;
  #   port = 3000; # Or your preferred port
  #   host = "0.0.0.0"; # To allow external access, or "127.0.0.1" for local only
  #   openFirewall = true;
  #   #    environment = {
  #   #      OLLAMA_API_BASE_URL = "http://127.0.0.1:11434/api";
  #   #      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
  #   #    };
  # };

  # enable SSH so the system is available after install
  services.openssh.enable = true;

  users.users.${vars.user} = {
    name = "tfinklea";
    shell = pkgs.zsh;
    isNormalUser = true;
    ignoreShellProgramCheck = true;
    description = "tfinklea";
    extraGroups = [ "networkmanager" "wheel" "input" "audio" "docker" "ollama" "plugdev"];
    #ulimit.nofile = 65536;   # Adjust this value as needed.
    #ulimit.nproc = 16384; #  Also consider adjusting this for process limits.
    openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINtOrpPLhHGrEKLboBkishy79+H6/F2GR/0pAL02iQxi tfinklea@mandalore" ];
  };

  # Turn off NIX_PATH warnings now that we're using flakes
  #system.checks.verifyNixPath = false;
  system.stateVersion = "23.05";
 }
