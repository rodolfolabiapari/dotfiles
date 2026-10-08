if [[ -f /etc/omarchy.conf ]]; then
  source /etc/omarchy.conf
  export OMARCHY_PATH="${OMARCHY_PATH:-/usr/share/omarchy}"

  if [[ -n "$BASH_VERSION" && -f "$OMARCHY_PATH/default/bash/rc" ]]; then
    source "$OMARCHY_PATH/default/bash/rc"
  elif [[ -n "$ZSH_VERSION" && -f "$OMARCHY_PATH/default/zsh/rc" ]]; then
    source "$OMARCHY_PATH/default/zsh/rc"
  fi
fi