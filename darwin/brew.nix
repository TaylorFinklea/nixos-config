{ config, pkgs, ... }:

{
  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "zap";
      upgrade = true;
    };

    # Homebrew Taps (Third-party repositories)
    taps = [
      # Development & Build Tools
      "qmk/qmk"                    # QMK firmware tools for mechanical keyboards
      "supabase/tap"               # Supabase CLI tools
      "sst/tap"                    # SST development tools
      "knqyf263/pet"               #

      # Window Management & System Tools
      "FelixKratz/formulae"        # SketchyBar and other macOS customization tools
      "nikitabobko/tap"            # AeroSpace tiling window manager
      "ungive/media-control"       # Show currently playing media in terminal
      # Input & Keyboard Tools
      "koekeishiya/formulae"       # Yabai window manager and skhd hotkey daemon
      "yqrashawn/goku"             # Karabiner configuration tool
      #"pqrs-org/cask-drivers"     # Drivers for Karabiner-Elements

      # Development Environments
      "railwaycat/emacsmacport"    # Emacs Mac port with native UI

      # General Tools
      #"homebrew/services"          # Background service management
      "bakks/bakks"               # Various developer utilities
    ];

    brewPrefix = "/opt/homebrew/bin";

    # GUI Applications (Casks)
    casks = [
      # === Development & Programming ===
      "wezterm"                    # GPU-accelerated terminal emulator
      "ghostty"                    # Modern terminal emulator
      "zed"                        # High-performance code editor
      "visual-studio-code"         # Popular code editor by Microsoft
      "android-studio"             # Android app development IDE
      "insomnia"                   # API testing and development tool
      "docker-desktop"                     # Container platform for development

      # === AI & Machine Learning ===
      "chatgpt"                    # AI chat client
      "claude"                     # Anthropic's Claude AI assistant
      "ollama-app"                 # Local LLM runner
      #"lm-studio"                  # GUI for running local language models
      "macwhisper"                 # Speech-to-text using OpenAI Whisper
      "jan"                        # AI chat interface
      "witsy"                      # AI writing assistant
      #"msty"                      # AI chat client
      #"diffusionbee"              # Stable Diffusion image generation
      #"anythingllm"               # All-in-one AI application

      # === Productivity & Organization ===
      "raycast"                    # Productivity launcher and command palette
      "anytype"                    # Private knowledge management
      "logseq"                     # Privacy-first knowledge base
      #"keyboard-maestro"          # Macro automation tool
      #"bettertouchtool"           # Advanced input customization
      "sol"                        # Spotlight alternative

      # === System Utilities ===
      "karabiner-elements"         # Keyboard customization tool
      "aerospace"                  # Tiling window manager
      "lunar"                      # External display brightness control
      "scroll-reverser"            # Reverse scrolling direction per device
      "syncthing"                  # File synchronization
      "google-drive"               # Cloud storage client
      #"keyclu"                    # Keyboard shortcut viewer

      # === Browsers ===
      "google-chrome"              # Web browser by Google
      "zen"                        # Privacy-focused browser
      "floorp"                     # Privacy-focused browser
      "firefox"                    # Privacy-focused browser

      # === Media & Graphics ===
      "obs"                        # Open source streaming/recording software
      "shottr"                     # Screenshot and annotation tool
      "brainfm"
      "excalidrawz"
      #"vlc"                       # Media player for various formats
      #"audacity"                  # Audio editing software
      #"inkscape"                  # Vector graphics editor
      #"plex"                      # Media server and player

      # === 3D & CAD ===
      "prusaslicer"                # 3D printing slicer software
      #"autodesk-fusion"           # CAD/CAM software
      #"sweet-home3d"              # Interior design software

      # === Hardware & Electronics ===
      "via"                        # Keyboard configuration tool
      "vial"                       # Open-source keyboard configurator
      "qmk-toolbox"                # Firmware flashing for QMK keyboards
      "balenaetcher"               # OS image writer for SD cards/USB drives
      #"zmk-studio"                # ZMK keyboard firmware configurator

      # === Utilities ===
      "speedcrunch"                # Scientific calculator
      "xbar"                       # Menu bar item manager
      "kindavim"                   # Vim motions everywhere in macOS
      "wooshy"                     # Window switcher
      "scrolla"                    # Smooth scrolling enhancement
      #"shortcat"                  # Keyboard-driven UI navigation
      #"monarch"                   # Log file viewer

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

     # === Business Tools ===
     "slack"
     "linear-linear"
     "discord"
     "ferdium"
     #"loom"
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
      #"aider"                     # AI pair programming tool
      "promptfoo"                  # LLM testing and evaluation framework
      "codex"
      "llm"
      "tmuxai"                     # AI integration for tmux
      "opencode"                   # SST OpenCode development tool
      "navi"                       # Interactive command selector
      "pet"                        # Interactive command selector

      # === System Utilities ===
      "mas"                        # Mac App Store CLI
      "coreutils"                  # GNU core utilities
      "neofetch"                   # System information display
      "scrcpy"                     # Android screen mirroring
      #"android-platform-tools"    # ADB and fastboot tools
      "mosh"                       # Mobile shell for intermittent connections
      #"bitwarden-cli"             # Password manager CLI
      "aspell"                     # Spell checker
      "pngpaste"                   # Paste images from clipboard to files
      "media-control"             # Show currently playing media in terminal

      # === Window Management ===
      "borders"                    # Window border customization
      "sketchybar"                 # Customizable macOS status bar

      # === Network & Security Tools ===
      "nmap"                       # Network discovery and security auditing
      "aircrack-ng"                # WiFi security auditing
      "iodine"                     # DNS tunneling tool
      "irssi"                      # Terminal-based IRC client

      # === Hardware Tools ===
      "avrdude"                    # AVR microcontroller programming
      #"avr-gcc"                   # AVR C/C++ compiler
      #"qmk"                       # Quantum Mechanical Keyboard firmware tools

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

      # === Specific Tools ===
      "yqrashawn/goku/goku"        # Karabiner configuration in EDN format
      "supabase/tap/supabase"      # Supabase CLI for local development
      "postgresql"                 # PostgreSQL database
      {
        name = "emacs-mac";        # Emacs with Mac-specific features
        args = ["with-modules"];   # Include dynamic module support
      }
      #"kmonad"                    # Advanced keyboard remapping daemon
    ];

    # Mac App Store Applications
    masApps = {
      # === Productivity ===
      "Hidden Bar"         = 1452453066;   # Hide menu bar items
      #"Day One"           = 1055511498;   # Journaling app
      #"Keynote"           = 409183694;    # Apple's presentation software
      #"Pages"             = 409201541;    # Apple's word processor
      #"Numbers"           = 409203825;    # Apple's spreadsheet app

      # === Development ===
      "Xcode"              = 497799835;    # Apple's IDE for macOS/iOS development
      "Apple Developer"    = 640199958;    # Developer resources and documentation

      # === Media & Creative ===
      "Adobe Lightroom"    = 1451544217;   # Photo editing and organization
      "Draw Things: AI Generation" = 6444050820; # AI image generation
      #"iMovie"            = 408981434;    # Video editing software

      # === Utilities ===
      "Dark Noise"         = 1465439395;   # Ambient noise app
      "DaisyDisk"          = 411643860;    # Disk space analyzer
      #"Tailscale"         = 1475387142;   # Mesh VPN client
      #"Microsoft Remote Desktop" = 1295203466; # Remote desktop client

      # === Safari Extensions ===
      "Dark Reader for Safari" = 1438243180; # Dark mode for websites
      "AdGuard for Safari"     = 1440147259; # Ad blocker
      #"Vimlike"                = 1584519802; # Vim keybindings for safari
      "Bitwarden"             = 1352778147; # Password manager extension
      # "Perplexity"            = 1668000334; # AI-powered search engine

      # === AI Tools ===
      #"Enchanted LLM"     = 2115666285;   # LLM chat interface
    };
  };
}
