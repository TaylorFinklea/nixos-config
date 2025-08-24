let 
  vars = import ../../../vars.nix ;
in {
      xdg.configFile.xonsh = {
        target = "xonsh"; 
        source = ./xonsh;
        recursive = true;
      };
}

