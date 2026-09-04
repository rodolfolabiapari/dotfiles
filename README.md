# dotfiles

Managed with [GNU Stow](https://www.gnu.org/software/stow/) — symlink farm approach. No templating, no magic. Files are where you edit them, symlinks point to the git repo.

## Requirements

- **git**
- **GNU stow** — `pacman -S stow` (Arch), `apt install stow` (Debian), `brew install stow` (macOS)

The `bootstrap.sh` script installs stow automatically if missing.

## Quick start (new machine)

```bash
git clone https://github.com/SEU-USER/dotfiles ~/.dotfiles
cd ~/.dotfiles
./bootstrap.sh
```

`bootstrap.sh` detects your OS (Arch, Debian-based, macOS) and:
1. Installs stow
2. Asks if you want to install core packages (git, zsh, tmux, nvim, starship, ripgrep, fd, eza, bat, fzf, zoxide)
3. Stows all packages, creating symlinks from `~` into `~/.dotfiles/`

## What's tracked

| Package | Path | Cross-platform |
|---------|------|:---:|
| `bash` | `~/.bashrc`, `~/.bash_profile`, `~/.profile`, `~/.bashrc.d/` | ✓ |
| `zsh` | `~/.zshrc` | ✓ |
| `scripts` | `~/.local/bin/` (personal scripts) | ✓ |
| `starship` | `~/.config/starship.toml` | ✓ |
| `tmux` | `~/.config/tmux/` | ✓ |
| `git` | `~/.config/git/config` | ✓ |
| `nvim` | `~/.config/nvim/` (lazy.nvim + lazy-lock.json) | ✓ |
| `alacritty` | `~/.config/alacritty/` | ✓ |
| `kitty` | `~/.config/kitty/` | ✓ |
| `foot` | `~/.config/foot/` | Linux only |
| `ghostty` | `~/.config/ghostty/` | ✓ |
| `omarchy` | `~/.config/omarchy/` | Arch only |
| `btop` | `~/.config/btop/` | Linux only |

## Daily workflow

```bash
# Edit configs normally — symlinks reflect changes in the repo
nvim ~/.config/tmux/tmux.conf

# Commit and push
cd ~/.dotfiles
git add -A
git commit -m "tmux: change prefix to C-a"
git push
```

## Makefile shortcuts

```bash
make stow      # Re-stow all packages (refresh symlinks)
make unstow    # Remove all symlinks
make rehome    # Unstow then stow (full refresh)
make list      # List all managed packages
```

## Adding a new package

```bash
# 1. Create the mirrored structure inside dotfiles
mkdir -p ~/.dotfiles/newpkg/.config/newpkg

# 2. Move the real config there
mv ~/.config/newpkg/config.yml ~/.dotfiles/newpkg/.config/newpkg/

# 3. Stow it
stow -d ~/.dotfiles newpkg

# 4. Commit
cd ~/.dotfiles && git add newpkg/ && git commit -m "add newpkg config"
```

## Pulling changes on another machine

```bash
cd ~/.dotfiles
git pull
make stow    # re-create or refresh symlinks
```