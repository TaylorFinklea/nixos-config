{ config, pkgs, ... }:
let
  my-python-packages = ps: with ps; [
    pandas
    requests
    websocket-client
    whois
    #openai
    #dotenv
  #   (ps.buildPythonPackage rec {
  #     pname = "metagpt";
  #     version = "0.8.1"; # Replace with the specific version if needed

  #     src = pkgs.fetchPypi {
  #       inherit pname version;
  #       sha256 = "sha256-RI9qZswnKVwA+yldriYZoPbIqgt/Wg6fi6tOtQn27SQ="; # You need to replace this with the actual sha256 hash
  #     };

  #     propagatedBuildInputs = [];
  #   })
  ];

in {
  imports = [
    ./packages/tmux
    ./packages/nvim
    ./packages/fish
    #./packages/nvim-kickstart
    ./packages/starship
    ./packages/xplr
    #./packages/nushell
    #./packages/xonsh
    ./packages/ghostty
    ./packages/doom
    ./packages/zellij
    #./packages/codex
  ];

  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  home.packages = with pkgs;
    [
      # Editor
      helix
      deno

      # Default
      ranger
      ripgrep # required for nvim telescope
      fd # alternative to find
      jq
      nodePackages.bash-language-server
      neofetch
      # bitwarden-cli
      ntp
      mtr
      # traceroute
      gdu
      ghostscript # PDF viewer and compressor

      # Terminal
      zellij
      xplr
      nnn
      zoxide
      yazi
      fzf
      atuin
      xonsh
      xxh
      clap
      bandwhich
      glances
      speedtest-cli
      # netscanner

      # DevOps
      #terraform
      #opentofu
      #ansible
      #packer
      powershell
      #kubectl
      #k9s
      # lens
      gh
      age
      gnupg
      git
      #mdbook

      #tailscale

      # Dev
      #python311
      (pkgs.python312.withPackages my-python-packages)
      nodejs_20
      # rustc
      rustup
      # cargo
      # clang
      # llvmPackages.bintools
      lua
      go
      swift
      tree-sitter
      zsh-autocomplete
      nixd

      # General
      # mosh
      #aichat
      poetry
      #openai

      zig
      gcc
    ];

  # Use a custom configuration.nix location.
  # $ darwin-rebuild switch -I darwin-config=$HOME/.config/nixpkgs/darwin/configuration.nix
  # environment.darwinConfig = "$HOME/.config/nixpkgs/darwin/configuration.nix";


  # Create /etc/zshrc that loads the nix-darwin environment.
  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting = {
      enable = true;
      styles = {
        command = "fg=cyan";
        # Customize other styles as needed
        builtin = "fg=blue";
        function = "fg=magenta";
        alias = "fg=orange";
     };
    };

    # Enable completion
    enableCompletion = true;

    shellAliases = {
      update = "nix-channel --update && nix-env -u";
      swork = "nix --extra-experimental-features \"nix-command flakes\" run nix-darwin -- switch --flake .#work --impure";
      sman = "nix --extra-experimental-features \"nix-command flakes\" run nix-darwin -- switch --flake .#mandalore --impure";
      ga = "git add .";
      gc = "git commit -m";
      gpu = "git push";
      gpl = "git pull";
      y = "yazi";
      c = "claude";
      co = "codex";
      ll = "ls -l";
      la = "ls -lah";
    };

    # Source zsh-autocomplete
    initExtra = ''
      ${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

      # Initialize zoxide
      eval "$(zoxide init zsh)"

      # Add Homebrew to PATH
      eval "$(/opt/homebrew/bin/brew shellenv)"
      # eval "$(/Users/tfinklea/.local/bin)"  # Commented out - this tries to execute a directory

      # Add local bin to PATH
      export PATH="/Users/tfinklea/.local/share/../bin:$PATH"
    '';
      # Configure history settings
    history = {
      size = 10000;
      path = "${config.xdg.dataHome}/zsh/history";
    };
  };
  #programs.fish.enable = true;

}
