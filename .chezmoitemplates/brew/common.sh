#!/bin/bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

# Brew file for all macock machines

# Installing the packages
for package in "${packages[@]}"; do
  echo "$package" | brew bundle --no-lock --file -
done

# Temporary Brewfile
temp_brewfile=$(mktemp)
# trap command is configured to remove the temporary file $temp_brewfile when
# the script ends (when the shell is exited with EXIT).
trap 'rm -f "$temp_brewfile"' EXIT

# Write packages to temporary Brewfile using cat and redirection
cat <<EOF > "$temp_brewfile"
  brew 'mas'                       # Mac Apple Store cli from Brew
  #mas 'xcode', id: 497799835      # Xcode from MAS cli
  brew 'bat'                       # Beautiful cat
  brew 'btop'                      # Beaultiful top
  brew 'chezmoi'                   # Installing chezmoi via managed packager
  brew 'cointop'                   # top for coins
  brew 'coreutils'                 # Binarios basicos como o timeout
  brew 'figlet'                    # nice bit fancy fonts for terminal outputs
  brew 'fzf'                       # fuzzy finder
  brew 'gh'                        # Github cli
  brew 'glab'                      # Gitlab cli
  brew 'gnupg'
  brew 'gnu-sed'
  brew 'htop'
  brew 'ipcalc'                    # Calculate IP ranges from cli
  brew 'jq'
  brew 'kubecolor'                 # Kubectl colorized
  brew 'kubent'    # Kube not Truble https://github.com/doitintl/kube-no-trouble
  brew 'lazygit'
  brew "neofetch"               # System information tool http://www.figlet.org/
  brew 'neovim'
  brew 'pwgen'                     # Password generator
  brew 'ripgrep'                   # Used in nvim
  brew 'shfmt'                     # Formater for bash in nvim
  brew 'telnet'
  brew 'tmux'
  brew 'toilet'                # big fancy fonts http://caca.zoy.org/wiki/toilet
  brew 'tree'
  brew 'task'                      # I want to try it some day
  brew 'vit'                       # Visual Interactive Taskwarrior aka vi
  brew 'watch'                     # It is absurd this not come default. Shame
  brew 'zoxide'                    # Smart cd
  cask 'caffeine'                  # Forces do not sleep
  cask 'font-meslo-lg-nerd-font'   # Best font ever for everything
  cask 'iterm2'                    # Terminal emulator
  cask 'rectangle'                 # Window manager for macock
  cask 'spotify'
  cask 'sublime-text'
  cask 'the-unarchiver'
  cask 'visual-studio-code'
  vscode '4ops.terraform'          # Terraform syntax
  vscode 'aaron-bond.better-comments'
  vscode 'chrmarti.regex'
  vscode 'davidanson.vscode-markdownlint'
  vscode 'esbenp.prettier-vscode'
  vscode 'golang.go'
  vscode 'ms-azuretools.vscode-docker'
  vscode 'ms-ceintl.vscode-language-pack-pt-br'
  vscode 'ms-python.python'
  vscode 'ms-python.debugpy'
  vscode 'oderwat.indent-rainbow'
  vscode 'streetsidesoftware.code-spell-checker'
  vscode 'tamasfe.even-better-toml'
  vscode 'vscode-icons-team.vscode-icons'
  vscode 'wayou.vscode-todo-highlight'
  vscode 'yzhang.markdown-all-in-one'
EOF

# Install packages using brew bundle
brew bundle -v --all --file="$temp_brewfile"

