let
  vars = import ../../../vars.nix;
in {
      programs.starship = {
        enable = true;
        settings = {
          #blue = '#18cae6'
          #purple = '#a220ea'

          "$schema" = "https://starship.rs/config-schema.json";

          # format = "$all$character";
          format = "[](color_purple)$os$username[](bg:color_aqua fg:color_purple)$directory[](fg:color_aqua bg:color_green)$git_branch$git_status[](fg:color_green bg:color_blue)$rust$golang$nodejs$kotlin$lua$python[](fg:color_blue bg:color_indigo)$docker_context$conda[](fg:color_indigo bg:color_indigo)$time[ ](fg:color_indigo)$all$line_break$character";

          add_newline = true;

          palette = "tokyo-night";
          palettes = {
            tokyo-night = {
              color_fg0 = "#C8C5FF";
              color_fg1 = "#EEEEEE";
              color_bg1 = "#1F2335";
              color_bg3 = "#291454";
              color_blue = "#0068B7";
              color_indigo = "#4600BF";
              color_aqua = "#18cae6";
              color_green = "#4fd6be";
              color_orange = "#FF7600";
              color_purple = "#9d68e0";
              color_red = "#cc241d";
              color_yellow = "#FFFD16";
            };
          };

          directory = {
            style = "fg:color_bg3 bg:color_aqua";
            format = "[ $path ]($style)";
            truncation_length = 3;
            truncation_symbol = "…/";
            substitutions = {
              "Documents" = "󰈙 ";
              "Downloads" = " ";
              "Music" = "󰝚 ";
              "Pictures" = " ";
              "Developer" = "󰲋 ";
            };
          };

          time = {
            disabled = true;
            time_format = "%R";
            style = "bg:color_indigo";
            format = "[[ $time ](bold fg:color_fg0 bg:color_indigo)]($style)";
          };

          username = {
            disabled = false;
            style_user = "bg:color_purple";
            style_root = "bg:color_red";
            format = "[[ $username ](bold fg:color_fg0 bg:color_purple)]($style)";
          };

          line_break.disabled = false;

          character = {
            disabled = false;
            success_symbol = "[❱](bold fg:color_aqua)";
            error_symbol = "[❱](bold fg:color_red)";
            vimcmd_symbol = "[❱](bold fg:color_aqua)";
            vimcmd_replace_one_symbol = "[❱](bold fg:color_orange)";
            vimcmd_replace_symbol = "[❱](bold fg:color_orange)";
            vimcmd_visual_symbol = "[❱](bold fg:color_yellow)";
          };

          git_branch = {
            symbol = "";
            style = "bg:color_green";
            format = "[[ $symbol $branch ](fg:color_bg1 bg:color_green)]($style)";
          };

          git_status = {
            style = "bg:color_green";
            format = "[[($all_status$ahead_behind )](fg:color_bg1 bg:color_green)]($style)";
            modified = "[!$count](fg:color_bg1 bg:color_green)";
            staged = "[+$count](fg:color_bg1 bg:color_green)";
            untracked = "[?$count](fg:color_bg1 bg:color_green)";
            deleted = "[-$count](fg:color_bg1 bg:color_green)";
            renamed = "[»$count](fg:color_bg1 bg:color_green)";
            conflicted = "[=$count](fg:color_bg1 bg:color_green)";
          };

          nodejs = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          rust = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          golang = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          lua = {
            symbol = " ";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          kotlin = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          python = {
            symbol = "";
            style = "bg:color_blue";
            format = "[[ $symbol( $version) ](fg:color_bg1 bg:color_blue)]($style)";
          };

          docker_context = {
            symbol = "";
            style = "bg:color_bg3";
            format = "[[ $symbol( $context) ](fg:#83a598 bg:color_bg3)]($style)";
          };

          conda = {
            symbol = " ";
            style = "bg:color_bg3";
            format = "[[ $symbol( $environment) ](fg:#83a598 bg:color_bg3)]($style)";
          };


          aws.symbol = "  ";
          buf.symbol = " ";
          c.symbol = " ";
          dart.symbol = " ";
          directory.read_only = " 󰌾";
          # docker_context.symbol = " ";
          elixir.symbol = " ";
          elm.symbol = " ";
          fossil_branch.symbol = " ";
          # git_branch.symbol = " ";
          # golang.symbol = " ";
          guix_shell.symbol = " ";
          haskell.symbol = " ";
          haxe.symbol = "⌘ ";
          hg_branch.symbol = " ";
          hostname.ssh_symbol = " ";
          java.symbol = " ";
          julia.symbol = " ";
          # lua.symbol = " ";
          memory_usage.symbol = "󰍛 ";
          meson.symbol = "󰔷 ";
          nim.symbol = "󰆥 ";
          nix_shell.symbol = " ";
          # nodejs.symbol = " ";
          os = {
            disabled = false;
            style = "fg:color_bg1 bg:color_purple";
            symbols = {
              Alpaquita = " ";
              Alpine = " ";
              Amazon = " ";
              Android = " ";
              Arch = " ";
              Artix = " ";
              CentOS = " ";
              Debian = " ";
              DragonFly = " ";
              Emscripten = " ";
              EndeavourOS = " ";
              Fedora = " ";
              FreeBSD = " ";
              Garuda = "󰛓 ";
              Gentoo = " ";
              HardenedBSD = "󰞌 ";
              Illumos = "󰈸 ";
              Linux = " ";
              Mabox = " ";
              Macos = " ";
              Manjaro = " ";
              Mariner = " ";
              MidnightBSD = " ";
              Mint = " ";
              NetBSD = " ";
              NixOS = " ";
              OpenBSD = "󰈺 ";
              openSUSE = " ";
              OracleLinux = "󰌷 ";
              Pop = " ";
              Raspbian = " ";
              Redhat = " ";
              RedHatEnterprise = " ";
              Redox = "󰀘 ";
              Solus = "󰠳 ";
              SUSE = " ";
              Ubuntu = " ";
              Unknown = " ";
              Windows = "󰍲 ";
            };
          };
          package.symbol = "󰏗 ";
          pijul_channel.symbol = "🪺 ";
          # python.symbol = " ";
          rlang.symbol = "󰟔 ";
          ruby.symbol = " ";
          # rust.symbol = " ";
          scala.symbol = " ";
          spack.symbol = "🅢 ";


        };
      };
}
