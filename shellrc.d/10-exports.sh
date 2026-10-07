export HISTSIZE=100000
export HISTFILESIZE=10000000
export HISTCONTROL=ignoredups

export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"