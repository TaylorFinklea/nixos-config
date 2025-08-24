# NixOS Configuration

My personal Nix/NixOS configuration for managing multiple machines with a declarative, reproducible setup.

## Structure

- **`./home`** - Pure home-manager configuration (used for work machines without admin privileges)
- **`./hosts`** - Host-specific configurations for all machines
- **`./common`** - Shared configuration across all operating systems
- **`./darwin`** - macOS-specific configuration (using nix-darwin)
- **`./nixos`** - NixOS-specific configuration
- **`./docker`** - Docker deployment configurations (may be split into separate repo)

## Hosts

All host configurations are defined in `./hosts/`:

### Darwin (macOS)
- `roshar` - aarch64-darwin (Apple Silicon)
- `bespin` 
- `coruscant`
- `xwing`

### NixOS (Linux)
- `awing` - x86_64-linux (server configuration)
- `lumar` - x86_64-linux (workstation)
- `mustafar` - x86_64-linux (workstation)

## Features

### Security
- **git-crypt** encryption for sensitive files (API keys, tokens, certificates)
  - Automatically encrypts `.env` files, secrets, and configuration files with sensitive data
  - See `.gitattributes` for full encryption rules

### Key Components
- **Ghostty** terminal emulator integration
- **Fenix** for Rust toolchain management
- **nixos-hardware** for hardware-specific optimizations
- Flake-based configuration using nixpkgs-25.05

### Docker Services
The `./docker` directory contains deployments for:
- **Portainer** - Docker management UI
- **Nginx Proxy Manager** - Reverse proxy with GUI
- **LibreChat** - AI chat interface with multi-provider support

### Home Manager
- Pure home-manager configuration in `./home/work.nix` for non-admin environments
- Full integration with NixOS and Darwin systems for personal machines
- User configuration centralized in `vars.nix`

## Notes

- The `packages` directories contain both active and inactive package configurations. Some are retained for potential future use rather than being actively deployed.
- Server configurations use a specialized setup at `./nixos/server/home.nix`
- The configuration supports both Intel and Apple Silicon architectures

## Usage

This configuration uses Nix flakes for reproducible builds across all systems. Each host can be built and deployed using standard Nix commands through the flake interface.

### Building a specific host
```bash
# For NixOS systems
sudo nixos-rebuild switch --flake .#hostname

# For Darwin systems  
darwin-rebuild switch --flake .#hostname

# For pure home-manager
home-manager switch --flake .#work
```

### Updating dependencies
```bash
nix flake update
```
