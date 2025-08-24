{
  description = "Taylor's Home Manager configuration";
  inputs = {
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-25.05-darwin";
    #nixpkgs.url = "github:NixOS/nixpkgs/8809585e6937d0b07fc066792c8c9abf9c3fe5c4";
    flake-utils.url = "github:numtide/flake-utils";

    # DARWIN
    darwin.url = "github:LnL7/nix-darwin/nix-darwin-25.05";
    #darwin.url = "github:LnL7/nix-darwin/master";
    darwin.inputs.nixpkgs.follows = "nixpkgs";

    # HOME MANAGER
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # FENIX
    fenix.url = "github:nix-community/fenix";
    fenix.inputs.nixpkgs.follows = "nixpkgs";

    # GHOSTTY
    ghostty = { url = "github:ghostty-org/ghostty"; };

    # NIXOS HARDWARE
    nixos-hardware.url = "github:NixOS/nixos-hardware/master";

  };

  outputs = inputs@{ darwin, home-manager, nixpkgs, flake-utils, ghostty, fenix, nixos-hardware, ... }: {
    packages.aarch64-darwin.default = fenix.packages.aarch64-darwin.default.toolchain;

    homeConfigurations = {
      work = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.aarch64-darwin;
        modules = [
          ./home/work.nix
        ];
        extraSpecialArgs = { inherit inputs; };
      };
    };
    darwinConfigurations = let user = "tfinklea"; in {
      roshar = darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./hosts/roshar
          # inputs.nix-doom-emacs-unstraightened.hmModule

          home-manager.darwinModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              backupFileExtension = "backup";
              users.${user} = import ./darwin/home.nix;
            };
          }
        ];
      };
    };
    nixosConfigurations = let user = "tfinklea"; in {
      awing = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/awing
          {
              environment.systemPackages = [
                  ghostty.packages.x86_64-linux.default
              ];
          }
          # HOME MANAGER
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              backupFileExtension = "backup";
              users.${user} = import ./nixos/server/home.nix;
            };
          }
        ];
      };
      lumar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/lumar

          # HOME MANAGER
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              backupFileExtension = "backup";
              users.${user} = import ./nixos/home.nix;
              extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
            };
          }
        ];
      };
      mustafar = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        specialArgs = { inherit inputs; };
        modules = [
          ./hosts/mustafar
          # HOME MANAGER
          home-manager.nixosModules.home-manager {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = false;
              backupFileExtension = "backup";

              users.${user} = import ./nixos/home.nix;
              extraSpecialArgs = { inherit inputs; system = "x86_64-linux";};
            };
          }
        ];
      };
    };
  };
}
