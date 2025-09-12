# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

# APT packs for common system

# List of packages to install
# This list accecpt comments
packages=(
  #fzf                        # old in apt
  #snapd                     # esta sendo instlando na pasta snap
  ansible
  bat                       # Beautiful cat
  brightnessctl             # Modifica brilho via teclado
  curl
  flatpak                   # Install package manager
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
  playerctl                 # controle de música pelo teclado
  pwgen                     # Password generator
  ripgrep                   # Used in nvim telescope
  rofi
  sed
  shfmt # Bash formater for nvim
  tar
  taskwarrior               # aka task no macocks
  telnet
  tmux
  traceroute
  tree
  ufw
  unzip
  vim
  vit                       # Visualize Interactive Taskwarrior
  xclip # Clip in cli
  zathura                   # Pdf reader like vi
  zbar-tools # Traduz qrcode para texto (usado com pass)
  zip
  zoxide                    # Smart cd
  zsh
)

# Installing the packages
echo "Running apt/common.sh"
sudo apt install -y "${packages[@]}"
