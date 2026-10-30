# Shared aliases (bash + zsh). Platform clipboard: see 50-macos.sh / 60-linux-desktop.sh

alias cat='bat --paging=never --style=-grid,+snip,-header'
alias '...'="cd ../../"
alias '....'="cd ../../.."
alias '.....'="cd ../../../.."
alias '......'="cd ../../../../.."
alias '.......'="cd ../../../../../.."
alias cd='z'
alias cp='cp -v'
alias dls='cd "$HOME/Downloads"'
alias docs='cd "$HOME/Documents"'
alias dt='cd "$HOME/Desktop"'
alias fvim='nvim $(fzf -m --preview="bat --color=always {}")'
alias gco="git checkout"
alias g="git "
alias G="git "
alias grpe="grep"
alias grp="grep"
alias gst="git status"
#alias gst="git status -sb"
alias gti="git "
alias k=kubectl
alias less='bat --paging=always --style=-grid,+snip,-header'
alias ll='eza -l --group-directories-first --icons=auto'
alias ls='eza --group-directories-first --icons=auto'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias neovim=nvim
alias nowdate='date +"%Y-%m-%d"'
alias now='date +"%Y-%m-%dT%H:%M:%S"'
alias nowtime='date +"%T"'
alias nvim_unmerged='nvim $(git diff --name-only --diff-filter=U)'
alias oc="env KUBECTL_COMMAND=oc kubecolor"
alias pwc='pwd | pbcopy'
alias ':q'=exit
alias 'q'=exit
alias quit=exit
alias rg='rg -i '
alias sz=reloadrc
alias ta='task add'
alias timestamp='date -u +%s'
alias tm=tmux
alias t='task'
alias vimdiff="nvim -d "
alias vim=nvim
alias vi=nvim
alias vmi=nvim
alias vm='mv -v'
alias vm=nvim
alias watch='viddy --exec '

if command -v kubecolor >/dev/null 2>&1; then
  alias kubectl=kubecolor
fi
