{ config, lib, pkgs, ... }:

let
  vars = import ../../../vars.nix;
in {
  home.activation = {
    removeExistingSSH_CONFIG = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
      rm -rf "/Users/${vars.user}/.ssh/ssh_config"
    '';

    copySSH_CONFIG = let
      newSSH_CONFIG = pkgs.writeText "tmp_sshconfig" (builtins.readFile ./ssh_config);
    in lib.hm.dag.entryAfter [ "linkGeneration" ] ''
      rm -rf "/Users/${vars.user}/.ssh/ssh_config"
      cp "${newSSH_CONFIG}" "/Users/${vars.user}/.ssh/ssh_config"
      chmod 600 "/Users/${vars.user}/.ssh/ssh_config"
    '';
  };
}
