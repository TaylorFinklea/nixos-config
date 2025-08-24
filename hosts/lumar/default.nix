{ config, pkgs, ... }:

let
  hostname = "lumar";
  vars = import ../../vars.nix;

in {
  imports = [
    ../../nixos
    ../../nixos/server
    ../../nixos/services
# TODO move this to use home manager to manage the packages
    ../../nixos/workstation.nix
    ./hardware.nix
  ];
  networking.hostName = "${hostname}";

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.supportedFilesystems = [ "vfat" "ext4" ];

  # Enable networking
  networking.networkmanager.enable = true;
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Bootloader GRUB
  #boot.loader.grub.enable = true;
  #boot.loader.grub.device = "/dev/sda";
  #boot.loader.grub.useOSProber = true;

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Set your time zone.
  time.timeZone = "America/Chicago";
  boot.kernelParams = [
    "i915.enable_psr=0"  # Disable Panel Self Refresh
    "i915.modeset=1"     # Enable kernel mode setting
    "acpi_osi=Linux"     # Better ACPI support
  ];
  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  services.logind = {
    lidSwitch = "ignore";
    lidSwitchExternalPower = "ignore";
    extraConfig = ''
      HandleSuspendKey=ignore
      HandleLidSwitch=ignore
      HandleLidSwitchExternalPower=ignore
      IdleAction=ignore
      HandlePowerKey=ignore
    '';
  };
  powerManagement = {
    enable = false;
    powertop.enable = false;
  };
  systemd = {
    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  # services.xserver.enable = true;
  services.xserver = {
   enable = true;
  };
  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # # Configure keymap in X11
  # services.xserver.xkb = {
  #   layout = "us";
  #   variant = "";
  # };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.syncthing = {
    enable = true;
    user = "${vars.user}";
    dataDir = "/home/${vars.user}/syncthing";
    configDir = "/home/${vars.user}/.config/syncthing";
    overrideDevices = true;
    overrideFolders = true;
    # open default firewall ports (22000 TCP/UDP, 21027 UDP)
    openDefaultPorts = true;
    settings = {
      folders = {
        "erapg-gmqxv" = {
          label = "core";
          path = "/home/${vars.user}/syncthing/core";
          devices = [
            "roshar"
            "scadrial"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "5";
            };
          };
        };
        "exlhj-urx4" = {
          label = "wallz";
          path = "/home/${vars.user}/syncthing/wallz";
          devices = [
            "roshar"
            "scadrial"
          ];
          versioning = {
            type = "simple";
            params = {
              keep = "5";
            };
          };
        };
       "jgnxq-zs3oe" = {
         label = "orgfiles";
         path = "/home/${vars.user}/syncthing/orgfiles";
         devices = [
           "roshar"
           "scadrial"
         ];
         versioning = {
           type = "simple";
           params = {
             keep = "5";
           };
         };
       };
      };
      devices = {
       "roshar" = {
         id = "GYPGYY6-ABEU6JE-X37WTO7-DYS6D3W-WIMGDJC-DGJJORX-6OJC5EO-I7P7TQD";
         name = "Roshar";
       };
       "scadrial" = {
         id = "M5DJNTB-XWWGTDN-TYMSKZT-6QT4BM5-NC3F62N-U2C5ZU7-M6DW4I5-K2Q3GQY";
         name = "Scadrial";
       };
      };
    };
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  #system.stateVersion = "24.05"; # Did you read the comment?
 }
