{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    brewPrefix = "/opt/homebrew/bin";

    # GUI Applications (Casks)
    casks = [
      # === Development & Programming ===
      "ghostty"                    # Modern terminal emulator
      "zed"                        # High-performance code editor
      "insomnia"                   # API testing and development tool
      "docker-desktop"                     # Container platform for development

      # === AI & Machine Learning ===
      "chatgpt"                    # AI chat client
      "ollama-app"                 # Local LLM runner

      # === System Utilities ===
      "lunar"                      # External display brightness control
      "google-drive"               # Cloud storage client

      # === Browsers ===
      "google-chrome"              # Web browser by Google

      # === Media & Graphics ===
      "obs"                        # Open source streaming/recording software
      "shottr"                     # Screenshot and annotation tool

      # === 3D & CAD ===
      "prusaslicer"                # 3D printing slicer software

      # === Hardware & Electronics ===
      "balenaetcher"               # OS image writer for SD cards/USB drives

      # === Fonts (Nerd Fonts with icons) ===
      "font-fira-mono-nerd-font"          # Fira Mono with icons
      "font-dejavu-sans-mono-nerd-font"   # DejaVu Sans Mono with icons
      "font-droid-sans-mono-nerd-font"    # Droid Sans Mono with icons
      "font-fira-code-nerd-font"          # Fira Code with ligatures and icons
      "font-hack-nerd-font"               # Hack font with icons
      "font-roboto-mono-nerd-font"        # Roboto Mono with icons
      "font-terminess-ttf-nerd-font"      # Terminus-inspired font with icons
      "font-caskaydia-cove-nerd-font"     # Cascadia Code with icons
      "sf-symbols"                        # Apple's SF Symbols

    ];

    # Command Line Tools (Brews)
    brews = [
      # === Development Tools ===
      "bash-language-server"       # LSP for Bash scripting
      "lua-language-server"        # LSP for Lua programming
      "dotnet"                     # .NET SDK and runtime
      "pyenv"                      # Python version management
      "nvm"                        # Node.js version management
      "pipx"                       # Install Python apps in isolated environments
      "uv"                         # Fast Python package installer
      "jupyterlab"                 # Web-based IDE for Jupyter notebooks
      #"exercism"                  # Programming exercise platform CLI

      # === AI & Machine Learning ===
      "codex"
      "opencode"                   # SST OpenCode development tool

      # === System Utilities ===
      "mas"                        # Mac App Store CLI
      "coreutils"                  # GNU core utilities
      "neofetch"                   # System information display
      #"scrcpy"                     # Android screen mirroring
      #"android-platform-tools"    # ADB and fastboot tools
      "mosh"                       # Mobile shell for intermittent connections
      #"bitwarden-cli"             # Password manager CLI
      "aspell"                     # Spell checker
      "pngpaste"                   # Paste images from clipboard to files
      "media-control"             # Show currently playing media in terminal

      # === Network & Security Tools ===
      "nmap"                       # Network discovery and security auditing
      "aircrack-ng"                # WiFi security auditing
      "iodine"                     # DNS tunneling tool
      "irssi"                      # Terminal-based IRC client

      # === Hardware Tools ===
      "avrdude"                    # AVR microcontroller programming
      #"avr-gcc"                   # AVR C/C++ compiler

      # === File & Git Tools ===
      #"xplr"                      # Terminal file explorer
      "bfg"                        # Git history cleaner
      "git-lfs"                    # Git Large File Storage
      "git-crypt"

      # === Media Tools ===
      "webp"                       # WebP image format tools

      # === LSPs ===
      "rust-analyzer"
      "pyright"
      "typescript-language-server"

    ];

    # Mac App Store Applications
    masApps = {
      # === Productivity ===
      "Keynote"           = 409183694;    # Apple's presentation software
      "Pages"             = 409201541;    # Apple's word processor
      "Numbers"           = 409203825;    # Apple's spreadsheet app

      # === Development ===
      "Xcode"              = 497799835;    # Apple's IDE for macOS/iOS development
      "Apple Developer"    = 640199958;    # Developer resources and documentation

      # === Media & Creative ===
      "Adobe Lightroom"    = 1451544217;   # Photo editing and organization
      "Draw Things: AI Generation" = 6444050820; # AI image generation
      "iMovie"            = 408981434;    # Video editing software

      # === Utilities ===
      "Dark Noise"         = 1465439395;   # Ambient noise app
      "DaisyDisk"          = 411643860;    # Disk space analyzer
      "Tailscale"         = 1475387142;   # Mesh VPN client

      # === Safari Extensions ===
      "AdGuard for Safari"     = 1440147259; # Ad blocker
      "Bitwarden"             = 1352778147; # Password manager extension

    };
  };
}
