# -*-mode:sh-*-
# SNAP packs for common system

# List of packages to install
# This list accecpt comments
packages=(
  chezmoi
  nvim --classic --beta
)

# Installing the packages
for package in "${packages[@]}"; do
  sudo snap install "$package"
done