# If not running interactively, don't do anything (leave this at the top)
[[ $- != *i* ]] && return

# Source shared shellrc (cross-shell, cross-platform config)
for i in "${HOME}/.shellrc.d"/[0-9][0-9]-*.sh; do
  [[ -r "$i" ]] || continue
  . "$i"
done
unset i

# Source bash-specific configs
for i in "${HOME}/.bashrc.d"/[0-9][0-9]-*.bashrc; do
  [[ -r "$i" ]] || continue
  . "$i"
done
unset i

# Source local overrides if exist
[[ -f "${HOME}/.bashrc.d/99-local.bashrc" ]] && . "${HOME}/.bashrc.d/99-local.bashrc"

. "$HOME/.local/share/../bin/env"

alias rc='nvim ~/.bashrc'
alias sb='source ~/.bashrc'

source /usr/share/git/completion/git-completion.bash
source /usr/share/bash-completion/bash_completion