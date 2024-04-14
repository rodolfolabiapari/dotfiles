# -*-mode:sh-*-
# APT packs for workplace system

# List of packages to install
# This list accecpt comments
packages=(
  awscli
  flameshot                                # Screen shot
  google-cloud-cli
  google-cloud-sdk-gke-gcloud-auth-plugin
  google-cloud-sdk-terraform-tools
  gparted                                  # Disk manager
  taskwarrior
  terminator                               # Terminal emulator
)

# Installing the packages
sudo apt install -y "${packages[@]}"