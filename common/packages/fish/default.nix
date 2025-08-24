{ config, pkgs, ... }:
{
  programs.fish = {
    enable = true;
    plugins = [
          {
            name = "z";
            src = pkgs.fetchFromGitHub {
              owner = "jethrokuan";
              repo = "z";
              rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
              sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
            };
          }
        ];
    interactiveShellInit = ''
      set --universal pure_color_primary 18CAE6
      set --universal pure_color_success A220EA

      fish_add_path /opt/homebrew/bin
      fish_add_path /Users/tfinklea/.local/share/../bin

      fish_vi_key_bindings
      function fish_user_key_bindings
          for mode in insert default visual
            bind -M $mode \cf forward-char
            bind -M $mode \ef forward-word
          end
      end


      # Emulates vim's cursor shape behavior
      set fish_vi_force_cursor 1
      # Set the normal and visual mode cursors to a block
      set fish_cursor_default block
      # Set the insert mode cursor to a line
      set fish_cursor_insert line
      # Set the replace mode cursors to an underscore
      set fish_cursor_replace_one underscore
      set fish_cursor_replace underscore
      # Set the external cursor to a line. The external cursor appears when a command is started.
# The cursor shape takes the value of fish_cursor_default when fish_cursor_external is not specified.
      set fish_cursor_external line
      # The following variable can be used to configure cursor shape in
      # visual mode, but due to fish_cursor_default, is redundant here
      set fish_cursor_visual block

      set -g theme_date_format "+ %H:%M"

      alias zl="zellij --layout ~/.config/zellij/layouts/wide.kdl"
      alias zz="zi"
      alias gpu="git push"
      alias gpl="git pull"
      alias gc="git commit"
      alias ga="git add ."
      alias nixr="nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .#roshar --impure";
      alias nixw="nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .#work --impure";
      alias nixgarbage="nix-collect-garbage -d";
      alias mvall="find . -mindepth 2 -type f -exec mv -i '{}' . ';'";
      alias nvim-kickstart='NVIM_APPNAME="nvim-kickstart" nvim';

      starship init fish | source
      zoxide init fish | source
    '';
  };
  xdg.configFile.fish-ai = {
    target = "fish-ai.ini";
    source = ./fish-ai.ini;
  };
}
