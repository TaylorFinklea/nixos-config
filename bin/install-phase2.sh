#!/usr/bin/env bash
echo "Installing Nix..."
nix-channel --add https://nixos.org/channels/nixpkgs-unstable nixpkgs
nix-channel --update

echo "Installing Home Manager"
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update

echo "Enabling Xcode Dev Tools"
xcode-select --install

echo "Installing Nix Darwin"
cd ~/
nix-build https://github.com/LnL7/nix-darwin/archive/master.tar.gz -A installer
./result/bin/darwin-installer
