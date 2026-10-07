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
alias ll='eza -l --group-directories-first --icons=auto'
alias ls='eza --group-directories-first --icons=auto'
alias neovim=nvim
alias oc="env KUBECTL_COMMAND=oc kubecolor"
alias pwc='pwd | pbcopy'
alias ':q'=exit
alias 'q'=exit
alias rg='rg -i '
alias ta='task add'
alias t='task'
alias vim=nvim
alias vi=nvim
alias vm=nvim
alias watch='viddy --exec '
alias vm='mv -v'
alias quit=exit
alias nvim_unmerged='nvim $(git diff --name-only --diff-filter=U)'

# Extras alias
alias cd='z'
alias cp='cp -v'
alias mv='mv -v'
alias mkdir='mkdir -pv'
alias dls='cd "$HOME/Downloads'
alias docs='cd "$HOME/Documents/'
alias dt='cd "$HOME/Desktop'
alias g="git "
alias G="git "
alias nowdate='date +"%Y-%m-%d"'
alias now='date +"%Y-%m-%dT:%H:%M:%S"'
alias nowtime='date +"%T"'
alias sz='source ~/.zshrc && echo "~/.zshrc reloaded."'
alias tm=tmux
alias timestamp='date -u %s'
alias vimdiff="nvim -d "

if command -v kubecolor >/dev/null 2>&1; then
  alias kubectl=kubecolor
fi
