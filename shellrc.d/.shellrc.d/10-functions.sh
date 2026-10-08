# Shared functions (bash + zsh)

reloadrc() {
  if [[ -n "${ZSH_VERSION:-}" ]]; then
     source ~/.zshrc
  else
     source ~/.bashrc
  fi
  echo "shell rc reloaded."
}
