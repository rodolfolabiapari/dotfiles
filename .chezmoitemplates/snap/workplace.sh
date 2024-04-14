# -*-mode:sh-*-
# SNAP packs for workplace system

# List of packages to install
# This list accecpt comments
packages=(
  brave
  canonical-livepatch
  code
  go # TODO: there is go to armv6l armhf?
  google-cloud-sdk
  helm
  postman
  rpi-imager
  spotify
  sublime-text
  telegram-desktop
  zoom-client
)

# Installing the packages
for package in "${packages[@]}"; do
  sudo snap install "$package"
done