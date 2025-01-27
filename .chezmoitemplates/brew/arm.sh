# -*-mode:sh-*-
# Brew file for arm

# Temporary Brewfile
temp_brewfile=$(mktemp)
# trap command is configured to remove the temporary file $temp_brewfile when
# the script ends (when the shell is exited with EXIT).
trap 'rm -f "$temp_brewfile"' EXIT

# Write packages to temporary Brewfile using cat and redirection
cat <<EOF > "$temp_brewfile"
  brew 'aws-vault'        # Easy way to connect to AWS Environment via cli
  brew 'awscli'
  brew 'bat-extras'       # extras scripts for bat
  brew 'docker'
  brew 'eza'              # Beautiful ls. Does not work in amd64
  brew 'git-delta'        # Bealtiful diff
  brew 'go'
  brew 'helm'             # Package manager for kubernetes deployments
  brew 'stern'            # Regex logs for kubernetes pod
EOF

# Install packages using brew bundle
brew bundle --no-lock --file="$temp_brewfile"
