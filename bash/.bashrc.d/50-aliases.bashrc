alias less='bat --paging=always --style=-grid,+snip,-header'
alias cat='bat --paging=never --style=-grid,+snip,-header'
alias '...'="cd ../../"
alias '....'="cd ../../.."
alias '.....'="cd ../../../.."
alias '......'="cd ../../../../.."
alias '.......'="cd ../../../../../.."
alias fvim='$EDITOR "$(ff)"'
alias gco="git checkout"
alias gst="git status -sb"
alias k=kubectl
alias kubectl="kubecolor"
alias ll='eza -l --group-directories-first --icons=auto'
alias ls='eza --group-directories-first --icons=auto'
alias neovim=nvim
alias oc="env KUBECTL_COMMAND=oc kubecolor"
alias pbcopy='wl-copy -n'
alias pbpaste='wl-paste -n'
alias pwc='pwd | pbcopy'
alias ':q'=exit
alias 'q'=exit
alias rc='nvim ~/.bashrc'
alias rg='rg -i '
alias sb='source ~/.bashrc'
alias ta='task add'
alias t='task'
alias vim=nvim
alias vi=nvim
alias vm=nvim
alias watch='viddy --exec '
alias vm='mv'
alias quit=exit
