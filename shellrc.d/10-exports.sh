# Shared exports (bash + zsh)

export HISTSIZE=100000
export HISTFILESIZE=10000000
export HISTCONTROL=ignoredups

if [[ "$(uname -s)" == Linux && -n "${XDG_RUNTIME_DIR:-}" ]]; then
  export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

export BC_ENV_ARGS="${HOME}/.bc"
export COINTOP_CONFIG="${HOME}/.config/cointop/config.toml"
export EDITOR="nvim"
export GEM_HOME="${HOME}/.gems"
export GOPATH="${HOME}/go/work"
export GPG_TTY=$TTY
export KUBECOLOR_CONFIG="${HOME}/.config/kubecolor/kubecolor.yaml"

if [[ "$(uname -s)" == Darwin && -x /opt/homebrew/opt/ruby/bin/ruby ]]; then
  export PATH="/opt/homebrew/opt/ruby/bin/ruby/bin:$PATH"
fi

export PATH="/opt/homebrew/opt/util-linux/bin:$PATH
export PATH="/opt/homebrew/opt/util-linux/sbin:$PATH
export PATH=$PATH:$HOME/bin
export PATH=$PATH:$HOME/bin/jmeter/bin
export PATH=$PATH:$HOME/.gems/bin
export PATH=$PATH:$HOME/homebrew/bin
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.npm-global/bin
export PATH=$PATH:$HOME/.tfenv/bin
export PATH=$PATH:$HOME/.tmux/plugins/tmuxifier/bin
export PATH=$PATH:/bin
export PATH=$PATH:/home/linuxbrew/.linuxbrew/bin
export PATH=$PATH:/opt/homebrew/bin
export PATH=$PATH:/opt/homebrew/sbin
export PATH=$PATH:/sbin
export PATH=$PATH:/snap/bin
export PATH=$PATH:/usr/bin
export PATH=$PATH:/usr/local/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$PATH:/usr/local/sbin
export PATH=$PATH:/usr/sbin
export ZSH=$HOME/.oh-my-zsh
