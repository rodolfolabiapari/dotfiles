# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash
# DO NOT CHANGE THIS FILE BECAUSE IT IS MANAGED BY CHEZMOI READ MORE HERE
# https://github.com/rodolfolabipari/dotfiles

# Alias
alias bat=batcat
alias cat="bat --paging=never"
alias less="bat --paging=always"

# Clipboard
command -v xclip >/dev/null 2>&1 && alias pbcopy="xclip -selection c"
command -v xclip >/dev/null 2>&1 && alias pbpaste="xclip -selection clipboard -o"
# Vpn
command -v wg-quick >/dev/null 2>&1 && alias wireguard_down='sudo wg-quick down wg0'
command -v wg-quick >/dev/null 2>&1 && alias wireguard_up='sudo wg-quick up wg0'


# Bat batcat cat alias configurations
# colorize help pages
# está separado por causa que, no linux o comando chama batcat
alias -- -h='-h 2>&1 | batcat --language=help --style=plain'
alias -- --help='--help 2>&1 | batcat --language=help --style=plain'
# Configure bat to colorize man pager
# https://github.com/sharkdp/bat?tab=readme-ov-file#man
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | batcat --plain --paging=auto -lman'"


# loading fzf git installed configuration
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh


# DO NOT CHANGE THIS FILE BECAUSE IT IS MANAGED BY CHEZMOI READ MORE HERE
# https://github.com/rodolfolabipari/dotfiles
