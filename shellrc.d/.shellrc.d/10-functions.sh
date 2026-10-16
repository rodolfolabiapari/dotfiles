# Shared functions (bash + zsh)

reloadrc() {
  if [[ -n "${ZSH_VERSION:-}" ]]; then
    source "${HOME}/.zshrc"
  else
    source "${HOME}/.bashrc"
  fi
  echo "shell rc reloaded."
}
