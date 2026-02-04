# Quick Start Guide

## For New Machine Setup

### 1. Install Homebrew (if not already installed)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone the repository
```bash
mkdir -p ~/git
cd ~/git
git clone <your-repo-url> nixos-config
# or if already cloned:
cd ~/git/nixos-config
```

### 3. Run bootstrap script
```bash
cd ~/git/nixos-config/chezmoi
./scripts/bootstrap.sh
```

The bootstrap script will:
- Install chezmoi
- Initialize your dotfiles
- Optionally install essential CLI tools
- Optionally run the full Homebrew sync

### 4. Restart your shell
```bash
exec zsh
```

## Quick Commands

### Chezmoi Basics
```bash
# See what would change
chezmoi diff

# Apply all changes
chezmoi apply -v

# Edit a file (opens in $EDITOR)
chezmoi edit ~/.zshrc

# Add a new file to chezmoi
chezmoi add ~/.config/newapp/config.toml

# Check status
chezmoi status
```

### Installing Packages

#### Essential CLI tools only
```bash
./scripts/install-essentials.sh
```

#### Full development environment
```bash
cd ~/git/nixos-config/home/work
./homebrew.sh
```

## Customization

### Edit configurations
All configs are in `~/git/nixos-config/chezmoi/`
- Shell: `dot_zshrc`, `dot_zshenv`
- Starship: `dot_config/starship.toml`
- Atuin: `dot_config/atuin/config.toml`
- Other apps: `dot_config/<app>/`

### Apply changes
After editing:
```bash
cd ~/git/nixos-config/chezmoi
chezmoi apply -v
```

### Sync to other machines
```bash
cd ~/git/nixos-config/chezmoi
git add .
git commit -m "Update configs"
git push

# On other machine:
cd ~/git/nixos-config/chezmoi
git pull
chezmoi apply -v
```

## Troubleshooting

### Shell not using new config
```bash
exec zsh  # Restart the shell
```

### Chezmoi not finding source
```bash
chezmoi init --source=$HOME/git/nixos-config/chezmoi
```

### Reset a specific file
```bash
chezmoi apply --force ~/.zshrc
```

### See what chezmoi manages
```bash
chezmoi managed
```

## File Location Reference

| Description | Chezmoi Path | Actual Path |
|-------------|--------------|-------------|
| Zsh RC | `dot_zshrc` | `~/.zshrc` |
| Zsh Env | `dot_zshenv` | `~/.zshenv` |
| Fish Config | `dot_config/fish/config.fish` | `~/.config/fish/config.fish` |
| Starship | `dot_config/starship.toml` | `~/.config/starship.toml` |
| Atuin | `dot_config/atuin/` | `~/.config/atuin/` |
| Ghostty | `dot_config/ghostty/` | `~/.config/ghostty/` |
| Zellij | `dot_config/zellij/` | `~/.config/zellij/` |
| Neovim | `dot_config/nvim/` | `~/.config/nvim/` |

## Migration from home-manager

The main differences:
1. **No Nix required** - Everything is managed by chezmoi + Homebrew
2. **Manual package installation** - Use `homebrew.sh` instead of nix packages
3. **Config files are raw** - No `.nix` wrappers, just the actual config files
4. **Explicit application** - Run `chezmoi apply` to sync changes

## Additional Resources

- [Chezmoi Documentation](https://www.chezmoi.io/)
- [Main README](README.md) - Comprehensive guide
- [Homebrew Script](../home/work/homebrew.sh) - Full package list
