# -*-mode:sh-*-
# Brew file for all macock machines

brew bundle --no-lock --file=/dev/stdin <<EOF
brew 'mas'                       # Mac Apple Store cli from Brew
#mas 'xcode', id: 497799835      # Xcode from MAS cli
brew 'bat'                       # Beautiful cat
brew 'btop'                      # Beaultiful top
brew 'chezmoi'
brew 'gnupg'
brew 'gnu-sed'
brew 'htop'
brew 'ipcalc'
brew 'jq'
brew 'kubent'
brew 'neovim'
brew 'pwgen'                     # Password generator
brew 'ripgrep'                   # Used in nvim telescope
brew 'telnet'
brew 'tmux'
brew 'tree'
brew 'task'                      # I want to try it some day
brew 'watch'
brew 'zoxide'                    # Smart cd
cask 'caffeine'
cask 'flameshot'
cask 'font-hack-nerd-font'       # Best font ever for everything
cask 'iterm2'
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