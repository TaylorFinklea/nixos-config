{
  programs.doom-emacs = {
    enable = true;
    doomDir = "./doom.d";  # or e.g. `./doom.d` for a local configuration
    extraPackages = epkgs: [
      epkgs.org
      epkgs.org-roam
    ];
  };
}
