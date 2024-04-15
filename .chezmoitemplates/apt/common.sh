# -*-mode:sh-*-
# APT packs for common system

# List of packages to install
# This list accecpt comments
packages=(
  ansible
  bat                       # Beautiful cat
  curl
  flatpak                   # Install package manager
  gcc                       # Mother loves y
  git
  gpg
  grep
  htop
  ipcalc
  jq
  less
  pwgen                     # Password generator
  ripgrep                   # Used in nvim telescope
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
