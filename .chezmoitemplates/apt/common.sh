# -*-mode:sh-*-
# APT packs for common system

# List of packages to install
# This list accecpt comments
packages=(
  ansible
  #bat                       # Beautiful cat. It is very old in apt
  curl
  flatpak                   # Install package manager
  gcc                       # Mother loves y
  git
  gpg
  grep
  htop
  i3
  ipcalc
  jq
  kitty
  less
  picom
  pwgen                     # Password generator
  ripgrep                   # Used in nvim telescope
  rofi
  sed
  tar
  telnet
  tmux
  traceroute
  tree
  ufw
  unzip
  vim
  xclip                     # Clip in cli
  zip
  zoxide                    # Smart cd
  zsh
)

# Installing the packages
sudo apt install -y "${packages[@]}"
