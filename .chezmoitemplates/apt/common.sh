# -*-mode:sh-*-
# APT packs for common system

# List of packages to install
# This list accecpt comments
packages=(
  ansible
  #bat                       # Beautiful cat. It is very old in apt
  curl
  flatpak                   # Install package manager
  fzf                        # Install fuzzy finder
  gcc                       # Mother loves y
  git
  git-remote-gcrypt          # usado com pass para encrypt do repo git
  gpg
  grep
  htop
  i3
  ipcalc
  jq
  kitty
  less
  pass
  picom
  pwgen                     # Password generator
  ripgrep                   # Used in nvim telescope
  rofi
  sed
  snapd
  tar
  telnet
  tmux
  traceroute
  tree
  ufw
  unzip
  vim
  xclip                     # Clip in cli
  zbar-tools                # Traduz qrcode para texto (usado com pass)
  zip
  zoxide                    # Smart cd
  zsh
)

# Installing the packages
sudo apt install -y "${packages[@]}"
