#!/usr/bin/env bash
set -euo pipefail

# bootstrap.sh — sets up a new machine with dotfiles and core dependencies.
# Run from the dotfiles repo root:  ./bootstrap.sh

DOTFILES="$(cd "$(dirname "$0")" && pwd)"
OS="$(uname -s)"

# ── helpers ───────────────────────────────────────────────────────────────────

info()  { echo "  → $*"; }
ok()    { echo "  ✓ $*"; }
err()   { echo "  ✗ $*" >&2; }

has()   { command -v "$1" >/dev/null 2>&1; }

# ── dependency checks ─────────────────────────────────────────────────────────

need_cmd() {
  if ! has "$1"; then
    err "Missing required command: $1 — install it first"
    return 1
  fi
}

# ── OS detection ──────────────────────────────────────────────────────────────

case "$OS" in
  Linux)
    if [ -f /etc/arch-release ]; then
      PKG_MGR="pacman -S --noconfirm"
      OS_FAMILY="arch"
    elif has apt-get; then
      PKG_MGR="sudo apt-get install -y"
      OS_FAMILY="debian"
    else
      PKG_MGR=""
      OS_FAMILY="linux-unknown"
    fi
    ;;
  Darwin)
    if ! has brew; then
      err "Homebrew not found. Install it: https://brew.sh"
      exit 1
    fi
    PKG_MGR="brew install"
    OS_FAMILY="macos"
    ;;
  *)
    err "Unsupported OS: $OS"
    exit 1
    ;;
esac

echo "→ Detected $OS ($OS_FAMILY)"
echo

# ── install stow (the only hard requirement) ──────────────────────────────────

if ! has stow; then
  info "Installing stow..."
  case "$OS_FAMILY" in
    arch)    sudo pacman -S --noconfirm stow ;;
    debian)  sudo apt-get install -y stow ;;
    macos)   brew install stow ;;
  esac
  ok "stow installed"
else
  ok "stow already installed"
fi

# ── install core packages (optional — skip if not wanted) ─────────────────────

PACKAGES=(
  git zsh bash starship tmux neovim ripgrep fd
  eza bat fzf zoxide
)

# Platform-specific additions
case "$OS_FAMILY" in
  macos) PACKAGES+=(gnu-stow coreutils gnu-sed gawk) ;;
esac

echo
echo "Base packages to install: ${PACKAGES[*]}"
read -r -p "→ Install them now? [Y/n] " reply
if [[ ! "$reply" =~ ^[Nn] ]]; then
  info "Installing packages..."
  if [ "$OS_FAMILY" = "macos" ]; then
    brew install "${PACKAGES[@]}"
  elif [ "$OS_FAMILY" = "arch" ]; then
    sudo pacman -S --noconfirm "${PACKAGES[@]}"
  elif [ "$OS_FAMILY" = "debian" ]; then
    sudo apt-get install -y "${PACKAGES[@]}"
  fi
  ok "packages installed"
else
  info "Skipping package install"
fi

# ── stow dotfiles ─────────────────────────────────────────────────────────────

echo
info "Stowing dotfiles..."

# Always-safe packages (no OS-specific configs)
SAFE_PACKAGES=(bash zsh scripts starship tmux git nvim)

case "$OS_FAMILY" in
  arch)
    # On Arch/Omarchy, also stow terminal configs and omarchy
    EXTRA_PACKAGES=(alacritty foot kitty ghostty omarchy btop)
    ;;
  macos)
    # On macOS, only alacritty + kitty (no foot/ghostty/omarchy)
    EXTRA_PACKAGES=(alacritty kitty)
    ;;
  *)
    EXTRA_PACKAGES=()
    ;;
esac

ALL_PACKAGES=("${SAFE_PACKAGES[@]}" "${EXTRA_PACKAGES[@]}")

for pkg in "${ALL_PACKAGES[@]}"; do
  if [ -d "$DOTFILES/$pkg" ]; then
    need_cmd stow || exit 1
    stow -d "$DOTFILES" -R "$pkg" 2>/dev/null && ok "stowed $pkg" || err "failed stowing $pkg"
  else
    info "skipping $pkg (not found in dotfiles)"
  fi
done

echo
echo "Done. All dotfiles stowed to ~"
echo "Start a new shell or source your rc file to pick up changes."