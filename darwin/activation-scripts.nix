{ config, lib, pkgs, ... }:

{
  system.activationScripts.extraActivation.text = ''
    # Create symlink for Emacs.app
    if [ -d "/opt/homebrew/opt/emacs-mac/Emacs.app" ] && [ ! -L "/Applications/Emacs.app" ]; then
      echo "Creating symlink for Emacs.app"
      ln -sf /opt/homebrew/opt/emacs-mac/Emacs.app /Applications/Emacs.app
    fi

    # Copy doom config to syncthing directory
    SOURCE_DOOM="/Users/tfinklea/git/nixos-config/common/packages/doom/doom"
    DEST_DOOM="/Users/tfinklea/syncthing/doom"

    if [ -d "$SOURCE_DOOM" ]; then
      echo "Syncing doom config to syncthing directory..."
      mkdir -p "$DEST_DOOM"
      ${pkgs.rsync}/bin/rsync -av --delete --exclude='.stfolder' "$SOURCE_DOOM/" "$DEST_DOOM/"
      echo "Doom config synced successfully"
    else
      echo "Warning: Doom source directory not found at $SOURCE_DOOM"
    fi
  '';
}
