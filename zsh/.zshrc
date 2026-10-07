# If not running interactively, don't do anything (leave this at the top)
[[ $- != *i* ]] && return

. "$HOME/.local/share/../bin/env"

# Source shared shellrc (cross-shell, cross-platform config)
for i in "${HOME}/.shellrc.d"/[0-9][0-9]-*.sh; do
  [[ -r "$i" ]] || continue
  case "${i:t}" in
    *linux*)
      [[ "$(uname -s)" == Darwin ]] && continue
      ;;
  esac
  source "$i"
done
unset i

# Source zsh-specific configs
for i in "${HOME}/.zshrc.d"/[0-9][0-9]-*.zsh; do
  [[ -r "$i" ]] || continue
  source "$i"
done
unset i

# Source local overrides if exist
[[ -f "${HOME}/.zshrc.d/99-local.zsh" ]] && source "${HOME}/.zshrc.d/99-local.zsh"

# Init tools (non-Omarchy fallback or double-check)
cmd="zoxide"
if command -v ${cmd} >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

cmd="starship"
if command -v ${cmd} >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

cmd="mise"
if command -v ${cmd} >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi