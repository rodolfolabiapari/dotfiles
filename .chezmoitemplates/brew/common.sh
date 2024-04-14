# -*-mode:sh-*-
# Brew file for all macock machines

brew bundle --no-lock --file=/dev/stdin <<EOF
EOF



# -*-mode:sh-*-
# Brew file for arm

# List of packages to install
# This list accecpt comments
packages=(
  brew 'mas'                       # Mac Apple Store cli from Brew
  #mas 'xcode', id: 497799835      # Xcode from MAS cli
  brew 'bat'                       # Beautiful cat
  brew 'btop'                      # Beaultiful top
  brew 'chezmoi'                   # Installing chezmoi via managed packager
  brew 'gnupg'
  brew 'gnu-sed'
  brew 'htop'
  brew 'ipcalc'                    # Calculate IP ranges from cli
  brew 'jq'
  brew 'kubent'    # Kube not Truble https://github.com/doitintl/kube-no-trouble
  brew 'neovim'
  brew 'pwgen'                     # Password generator
  brew 'ripgrep'                   # Used in nvim 
  brew 'telnet'
  brew 'tmux'
  brew 'tree'
  brew 'task'                      # I want to try it some day
  brew 'watch'                     # It is absurd this not come default. Shame
  brew 'zoxide'                    # Smart cd
  cask 'caffeine'                  # Forces do not sleep
  cask 'flameshot'                 # Screen shot app
  cask 'font-hack-nerd-font'       # Best font ever for everything
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
)

# Installing the packages
for package in "${packages[@]}"; do
  echo "$package" | brew bundle --no-lock --file -
done