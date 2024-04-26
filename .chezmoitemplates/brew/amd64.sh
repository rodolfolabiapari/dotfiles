# -*-mode:sh-*-
# Brew file for amd64

# Temporary Brewfile
temp_brewfile=$(mktemp)
# trap command is configured to remove the temporary file $temp_brewfile when
# the script ends (when the shell is exited with EXIT).
trap 'rm -f "$temp_brewfile"' EXIT

# Write packages to temporary Brewfile using cat and redirection
cat <<EOF > "$temp_brewfile"
  brew 'c2048'                     # 2048 game
  brew 'docker'
  #brew 'imagemagick'              # Converts and resizes images, doesn work
  brew 'mailsy'                    # Creates tmp email
  brew 'wifi-password'             # Show wifi password
  cask 'brave-browser'
  cask 'disk-inventory-x'
  cask 'flameshot'                 # Screen shot app
  cask 'google-cloud-sdk'
  cask 'logseg'                    # An Obsidian Open-source
  cask 'smcfancontrol'             # Control fan of machine
  cask 'telegram-desktop'
  cask 'zoom'
EOF

# Install packages using brew bundle
brew bundle --no-lock --file="$temp_brewfile"
