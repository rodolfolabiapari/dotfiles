# -*-mode:sh-*-
# Brew file for amd64

# List of packages to install
# This list accecpt comments
packages=(
  brew 'docker'
  brew 'go'
  cask 'brave-browser'
  cask 'disk-inventory-x'
  cask 'google-cloud-sdk'
  cask 'smcfancontrol'             # Control fan of machine
  cask 'telegram-desktop'
  cask 'zoom'
)

# Installing the packages
for package in "${packages[@]}"; do
  echo "$package" | brew bundle --no-lock --file -
done