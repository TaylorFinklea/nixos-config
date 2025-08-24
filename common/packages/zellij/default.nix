let 
  vars = import ../../../vars.nix ;
in {
      xdg.configFile.zellij = {
        target = "zellij/config.kdl"; 
        source = ./config.kdl;
      };

      xdg.configFile.zellij-themes = {
        target = "zellij/themes"; 
        source = ./themes;
        recursive = true;
      };
      xdg.configFile.zellij-layouts = {
        target = "zellij/layouts"; 
        source = ./layouts;
        recursive = true;
      };
}

