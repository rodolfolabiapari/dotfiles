# -*-mode:sh-*-
# APT packs for workplace system

# List of packages to install
# This list accecpt comments
packages=(
  #awscli                                  # nao esta sendo isntalado via apt
  flameshot                                # Screen shot
  gh                                       # Github cli
  google-cloud-cli
  google-cloud-sdk-gke-gcloud-auth-plugin
  google-cloud-sdk-terraform-tools
  gparted                                  # Disk manager
  taskwarrior
  terminator                               # Terminal emulator
)

# Installing the packages
echo "apt/workplace.sh"
sudo apt install -y "${packages[@]}"
