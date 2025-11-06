# Alias
# ------------------------------------------------------------
alias cat="bat --paging=never --style=-header,-grid"
alias CAT=cat
alias cdob="cd $(cat ~/.config/nvim/lua/config_local.lua | grep 'obsidian_work_path' | awk '{print $5}')"
alias cp='cp -v';
alias CP=cp
alias fvim='nvim $(fzf -m --preview="bat --color=always {}")'
alias G="git "
alias g="git "
alias gerp=grep
alias get="k get"
alias gre=grep
alias grp=grep
alias grpe=grep
alias gti="git "
alias K=kubecolor
alias k=kubecolor
alias kubectl=kubecolor
alias less="bat --paging=always --style=-header,-grid"
alias LS=ls
alias mkdir='mkdir -pv'
alias mv='mv -v';
alias MV=mv
alias mv=mv
alias now='date +"%Y-%m-%dT%H:%M:%S"'
alias nowdate='date +"%Y-%m-%d"'
alias nowtime='date +"%T"'
alias pwc="pwd | tr -d '\n' | pbcopy"
alias PWC=pwc
alias PWD=pwd
alias q=exit
alias quit=exit
alias SL=ls
alias sl=ls
alias sz="source ~/.zshrc && echo \"~/.zshrc reloaded.\"" # Reload zsh
alias t=task
alias tak=task
alias taks=task
alias tas=task
alias timestamp='date -u +%s'
alias tm=tmux
alias tmu=tmux
alias tmx=tmux
alias tsk=task
alias unow='date -u +"%Y-%m-%dT%H:%M:%S"'
alias unowdate='date -u +"%Y-%m-%d"'
alias unowtime='date -u +"%T"'
alias v=nvim
alias vi=nvim
alias vim=nvim
alias vimdiff="nvim -d "
alias vin=nvim
alias week='date +"%Y-W%V"'
alias weekday='date +"%u"'
alias dls='cd $HOME/Downloads'
alias docs='cd $HOME/Documents'
alias dt='cd $HOME/Desktop'
