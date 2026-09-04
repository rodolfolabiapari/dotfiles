# Real-time history sharing across all bash instances (tmux panes, terminals)
export PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# Improve history quality
export HISTIGNORE="ls:cd:cd -:pwd:exit:history*"
export HISTTIMEFORMAT="%F %T "
