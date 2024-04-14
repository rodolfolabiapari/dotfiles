# -*-mode:sh-*-
# Brew file for arm

# List of packages to install
# This list accecpt comments
packages=(
  brew 'aws-vault'        # Easy way to connect to AWS Environment via cli
  brew 'awscli'
  brew 'docker'
  brew 'eza'              # Beautiful ls. Does not work in amd64
  brew 'go'
  brew 'helm'             # Package manager for kubernetes deployments
  brew 'stern'            # Regex logs for kubernetes pod
)

# Installing the packages
for package in "${packages[@]}"; do
  echo "$package" | brew bundle --no-lock --file -
done