# If not running interactively, do nt do anything. keep it on top
[[ $- != *i* ]] && return

. "$HOME/.local/share/../bin/env"

# Modular zsh config
for i in "${HOME}/.zshrc.d"/[0-9][0-9]-*.zsh; do
  [[ -r "$i" ]] || continue
  case "${i:t}" in
    90-load-p10k.zsh|90-post-sources.zsh)
      continue
      ;;
    *linux*)
      [[ "$(uname -s)"  == Darwin ]] && continue
      ;;
  esac
  source "$i"
done
unset i

[[ -t "${HOME}/.zshrc.d/99-local.zsh" ]] && source "${HOME}/.zshrc.d/99-local.zsh"

cmd="zoxide"
if command -v ${cmd} >/dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# se existe zsh syntax highlight, carrega
#p=path to zsh sytax highlight
#if [[ -r $p ]]; then
#  source it
#fi
# se existe zsh catppuccin
#p=path to zsh sytax highlight
#if [[ -r $p ]]; then
#  source it
#fi

cmd="starship"
if command -v ${cmd} >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

cmd="mise"
if command -v ${cmd} >/dev/null 2>&1; then
  eval "$(mise activate zsh)"
fi
