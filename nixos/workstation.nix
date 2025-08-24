{ config, pkgs, lib, inputs, ... }:
let
  vars = import ../vars.nix;

in {
  imports = [
    ./packages/hyprland
    ./packages/waybar
    ./packages/warpd
    #./packages/keyd
    ./packages/kmonad
  ];

  services = {
    flatpak.enable = true;
    printing = {
      enable = true;
      drivers = [
        # pkgs.canon-cups-ufr2
        pkgs.gutenprint
      ];
    };
    ipp-usb.enable = true;
    fprintd = {
      enable = true;
    };
    gvfs.enable = true;
    tumbler.enable = true;
    udisks2.enable = true;
    traccar.enable = true;
    gnome = {
      gnome-keyring.enable = true;
    };
    avahi = {
      enable = true;
      nssmdns4 = true;
      publish = {
        enable = true;
        addresses = true;
        domain = true;
        hinfo = true;
        userServices = true;
        workstation = true;
      };
    };
  };
  security = {
    polkit = {
      enable = true;
      extraConfig = ''
        polkit.addRule(function (action, subject) {
          if (action.id == "net.reactivated.fprint.device.enroll" ||
              action.id == "net.reactivated.fprint.device.verify") {
            return polkit.Result.YES;
          }
        });
      '';
    };
    pam.services = {
      sudo = {
        fprintAuth = true;
        unixAuth = true; # tries fingerprint before password
      };
      hyprlock = {};
      login = {
        fprintAuth = true;
        unixAuth = true; # tries fingerprint before password
        kwallet.enable = true;
        kwallet.forceRun = false;
      };
      sddm = {
        fprintAuth = true;
        unixAuth = true; # tries fingerprint before password
        kwallet.enable = true;
        kwallet.forceRun = true;
      };
      hyprland = {
        fprintAuth = true;
        unixAuth = true; # tries fingerprint before password
        kwallet.enable = true;
        kwallet.forceRun = true;
      };
      dolphin = {
        kwallet.enable = true;
        kwallet.forceRun = true;
      };
    };
  };
  programs = {
    firefox.enable = true;
    #seahorse.enable = true;
    thunar = {
      enable = true;
      plugins = with pkgs.xfce; [
        thunar-archive-plugin
        thunar-volman
        thunar-media-tags-plugin
      ];
    };
    kdeconnect.enable = true;
    mosh.enable = true;
    thunderbird = {
      enable = true;
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [
      80 # nginx
      81 # nginx
      443 # nginx
    ];
    allowedTCPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
    allowedUDPPortRanges = [
      { from = 1714; to = 1764; } # KDE Connect
    ];
  };

  # Enable KDE Connect related services

  # Enable Qt5 and Qt6 Wayland support
  qt = {
    enable = true;
    platformTheme = "kde";
    style = "breeze";
  };

  # Ensure XDG Desktop Portal is properly configured for Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-hyprland
    ];
    configPackages = [
      pkgs.xdg-desktop-portal-hyprland
    ];
  };

  # Add a system activation script to declaratively install Flatpak packages
  system.activationScripts.flatpak-install = ''
    # Add Flathub remote if it doesn't exist
    ${pkgs.flatpak}/bin/flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

    # Install dsnote (SpeechNote) if not already installed
    if ! ${pkgs.flatpak}/bin/flatpak list | grep -q "net.mkiol.SpeechNote"; then
      ${pkgs.flatpak}/bin/flatpak install -y flathub net.mkiol.SpeechNote
    fi

    # Install Buzz if not already installed
    if ! ${pkgs.flatpak}/bin/flatpak list | grep -q "io.github.chidiwilliams.Buzz"; then
      ${pkgs.flatpak}/bin/flatpak install -y flathub io.github.chidiwilliams.Buzz
    fi
  '';

  # Ensure the environment has access to Flatpak applications
  environment.sessionVariables = {
    # Ensure XDG_DATA_DIRS includes Flatpak applications
    XDG_DATA_DIRS = [
      "/run/current-system/sw/share"
      "/var/lib/flatpak/exports/share"
      "$HOME/.local/share/flatpak/exports/share"
      "$XDG_DATA_DIRS"
    ];
  };

  systemd.tmpfiles.rules = [
    "d ${vars.user}/.local/share/wallpapers 0755 ${vars.user} users"
    "L+ /usr/lib/libEGL.so.1 - - - - ${pkgs.mesa}/lib/libEGL.so.1"
  ];

  services.displayManager.sddm.wayland.enable = true;
  environment.systemPackages = with pkgs; [
    # Hyprland Ecosystem
    hypridle      # Idle management daemon
    hyprpicker    # Color picker
    hyprlock      # Screen locker
    hyprcursor    # Cursor theme manager
    hyprsunset    # Blue light filter
    hyprdim       # Screen dimming
    hyprshot      # Screen capture tool
    swww          # Wallpaper daemon with animations
    waybar        # Status bar
    eww           # Widget system

    # System Integration
    xdg-desktop-portal
    xdg-desktop-portal-hyprland  # XDG desktop integration
    polkit                       # Authorization manager
    pipewire                     # Audio/video server
    wireplumber                  # Media session manager
    brightnessctl                # Brightness control
    desktop-file-utils  # Provides update-desktop-database

    # KDE/Qt Integration
    libsForQt5.polkit-kde-agent    # KDE authentication agent
    libsForQt5.kwallet             # Password manager
    libsForQt5.kwalletmanager      # Wallet manager GUI
    kdePackages.kwallet            # Password manager (Qt6)
    kdePackages.kwalletmanager     # Wallet manager GUI (Qt6)
    kdePackages.filelight          # File managers
    qt5.qtwayland                  # Qt5 Wayland support
    qt6.qtwayland                  # Qt6 Wayland support
    libsForQt5.qt5ct               # Qt5 configuration tool
    qt6ct                          # Qt6 configuration tool
    libsForQt5.qtstyleplugin-kvantum  # Additional Qt styles

    # Krusader Dependencies
    kdiff3
    krename
    kdePackages.kompare
    zip
    p7zip
    rar
    unrar
    arj
    rpm
    dpkg

    # Terminal Emulators
    ghostty                      # GPU-accelerated terminal
    wezterm                      # Feature-rich terminal

    # OpenGL Support
    libGL
    libGLU
    mesa
    vulkan-loader
    vulkan-validation-layers
    libxkbcommon
    wayland
    egl-wayland
    xorg.libX11
    xorg.libXcomposite
    xorg.libXdamage
    xorg.libXext
    xorg.libXfixes
    xorg.libXrandr
    xorg.libXrender
    xorg.libXtst
    libdrm

    # File Management
    libsForQt5.dolphin          # KDE file manager
    krusader                    # Twin-panel file manager
    kdePackages.konqueror       # Web/file browser
    nemo                        # Cinnamon file manager
    libsForQt5.kio-gdrive         # More Google Drive integration
    rclone    # Command-line file management
    #insync    # File synchronization

    # Productivity and Notes
    anytype             # Markdown editor
    speedcrunch                 # Scientific calculator
    actiona                     # Task automation
    #lmstudio
    prusa-slicer

    # Security and Authentication
    bitwarden-desktop          # Password manager
    bitwarden-cli              # Command-line password manager
    bitwarden-menu             # Menu integration
    fprintd                   # Fingerprint reader daemon

    # Development Tools
    insomnia                  # API client
    zed-editor               # Collaborative editor
    #windsurf                   # Code editor
    cudaPackages.cudatoolkit # CUDA development
    cudaPackages.cudnn       # Deep learning library
    vulkan-tools            # Graphics debugging

    # Media and Graphics
    vlc                      # Media player
    mpd                      # Music player daemon
    pavucontrol             # Audio control
    playerctl               # Media player control
    gimp                    # Image editor
    inkscape                # Vector graphics
    krita                   # Digital painting
    imagemagick             # Image manipulation

    # Browsers
    #google-chrome
    qutebrowser             # Keyboard-driven browser

    # System Utilities
    rofi-wayland            # Application launcher
    wl-clipboard            # Clipboard utilities
    cliphist                # Clipboard history
    blueman                 # Bluetooth manager
    angryipscanner         # Network scanner
    clipse                 # Clipboard manager
    clipit                 # Clipboard manager
    emote                  # Emoji picker
    simplescreenrecorder   # Screen recorder
    gnome-font-viewer      # Font preview
    albert                 # Application launcher
    ulauncher              # Application launcher
    vmpk                   # Virtual MIDI keyboard
    keyd                   # Key remapping
    via                    # Keyboard configuration
    vial                   # Keyboard firmware
    qmk                    # Keyboard firmware
    kmonad                 # Keyboard configuration
    autokey                # Text expansion
    libsecret              # Needed by Gnome Keyring
    p11-kit                # Needed by Evoltion Mail
    warpd                  # Vimium for the OS
    cairo
    gh                     # GitHub CLI
    grim
    slurp
    wl-clipboard
    # Cryptocurrency
    electrum               # Bitcoin wallet
    ledger-live-desktop    # Hardware wallet interface

    # AI/LLM Tools
    #aider-chat            # AI coding assistant
    #jan                   # Terminal AI assistant
    #writing-tools          # AI writing assistant

    # Graphics Support
    egl-wayland           # EGL support for Wayland
  ];
  environment.pathsToLink = [ "/share/icons" ];
}
