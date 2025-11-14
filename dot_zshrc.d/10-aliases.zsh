# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash
# DO NOT CHANGE THIS FILE BECAUSE IT IS MANAGED BY CHEZMOI READ MORE HERE
# https://github.com/rodolfolabipari/dotfiles

alias CAT=cat
alias cd='z' #z zoxide alias
alias CP=cp
alias cp='cp -v';
alias dls='cd $HOME/Downloads'
alias docs='cd $HOME/Documents'
alias dt='cd $HOME/Desktop'
alias fvim='nvim $(fzf -m --preview="bat --color=always {}")'
alias gerp=grep
alias get="k get"
alias g="git "
alias G="git "
alias gre=grep
alias grpe=grep
alias grp=grep
alias gti="git "
alias k=kubecolor
alias K=kubecolor
alias kubectl=kubecolor
alias LS=ls
alias mkdir='mkdir -pv'
alias mv=mv
alias MV=mv
alias mv='mv -v';
alias nowdate='date +"%Y-%m-%d"'
alias now='date +"%Y-%m-%dT%H:%M:%S"'
alias nowtime='date +"%T"'
alias PWC=pwc
alias pwc="pwd | tr -d '\n' | pbcopy"
alias PWD=pwd
alias q=exit
alias quit=exit
alias awsSetProfile='source ~/bin/setProfile.sh' # precisa ser source para export funcionar
alias sl=ls
alias SL=ls
alias sz="source ~/.zshrc && echo \"~/.zshrc reloaded.\"" # Reload zsh
alias taks=task
alias tak=task
alias tas=task
alias timestamp='date -u +%s'
alias tm=tmux
alias tmu=tmux
alias tmx=tmux
alias tsk=task
alias t=task
alias unowdate='date -u +"%Y-%m-%d"'
alias unow='date -u +"%Y-%m-%dT%H:%M:%S"'
alias unowtime='date -u +"%T"'
alias vimdiff="nvim -d "
alias vim=nvim
alias vin=nvim
alias vi=nvim
alias v=nvim
alias week='date +"%Y-W%V"'
alias weekday='date +"%u"'
alias ':q'=exit

# DO NOT CHANGE THIS FILE BECAUSE IT IS MANAGED BY CHEZMOI READ MORE HERE
# https://github.com/rodolfolabipari/dotfiles
