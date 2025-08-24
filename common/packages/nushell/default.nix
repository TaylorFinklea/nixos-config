{ config, pkgs, ... }:
{
  programs = {
      nushell = { 
        enable = true;
        # The config.nu can be anywhere you want if you like to edit your Nushell with Nu
        # configFile.source = ./.../config.nu;
        # for editing directly to config.nu 
        extraConfig = ''
         let carapace_completer = {|spans|
           carapace $spans.0 nushell $spans | from json
         }
         $env.config = {
           show_banner: false,
           edit_mode: vi,
           cursor_shape: {
              vi_insert: line
              vi_normal: block
              emacs: line
           },
           keybindings: [
             {
               name: complete_hint
               modifier: control
               keycode: char_f
               mode: [emacs, vi_normal, vi_insert]
               event: {
                 until: [
                   {send: historyhintcomplete}
                   {send: menuright}
                 ]
               }
             }
           ],
           completions: {
             case_sensitive: false # case-sensitive completions
             quick: true    # set to false to prevent auto-selecting completions
             partial: true    # set to false to prevent partial filling of the prompt
             algorithm: "fuzzy"    # prefix or fuzzy
             external: {
               # set to false to prevent nushell looking into $env.PATH to find more suggestions
               enable: true 
               # set to lower can improve completion performance at the cost of omitting some options
               max_results: 100 
               completer: $carapace_completer # check 'carapace_completer' 
             }
           }
         } 
         $env.PATH = ($env.PATH | 
         split row (char esep) |
         prepend /home/myuser/.apps |
         append /usr/bin/env
         )
         $env.PATH | append ($env.HOME | path join ".cargo" "bin")


         $env.PROMPT_INDICATOR_VI_INSERT = ""
         $env.PROMPT_INDICATOR_VI_NORMAL = ""
         '';
         shellAliases = {
           vi = "nvim";
           vim = "nvim";
           nano = "hx";
           zl = "zellij --layout ~/.config/zellij/layouts/wide.kdl";
           zz = "zi";
           ga = "git add .";
           gc = "git commit";
           gpu = "git push";
           gpl = "git pull";
           nixm = "nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .#mandalore --impure";
           nixw = "nix --extra-experimental-features 'nix-command flakes' run nix-darwin -- switch --flake .#work --impure";
           nixgarbage = "nix-collect-garbage -d";
           # mvall = "find . -mindepth 2 -type f -exec mv -i '{}' . ';'";
         };
     };  
     carapace.enable = true;
     carapace.enableNushellIntegration = true;
     zoxide.enable = true;
     # atuin.enable = true;
  };
}


