[[ "$(uname -s)" != Darwin ]] && return

alias cat="bat --paging=never --style=-header,-grid"
alias less="bat --paging=always --style=-header,-grid"
alias watch="viddy"

export PATH=$PATH:/Library/Apple/usr/bin
export PATH=$PATH:/Library/Frameworks/Python.framework/Versions/3.7/bin
export PATH=$PATH:/Library/TeX/texbin
export PATH=$PATH:/usr/local/opt/ncurses/bin
export PATH=$PATH:/usr/local/opt/python@3.7/bin
export PATH=$PATH:/usr/local/opt/python/libexec/bin
export PATH=$PATH:$HOME/Library/Python/2.7/bin
export PATH=$PATH:$HOME/Library/Python/3.7/bin
export PATH=$PATH:$HOME/Library/Python/3.9/bin
export PATH=$PATH:$HOME/.iac/bin
export HOMEBREW_BUILD_BOTTLE=1

alias quarentena="xattr -d com.apple.quarantine "
command -v kubecolor >/dev/null 2>&1 && alias kubectl="kubecolor"

alias -- -h='-h 2>&1 | bat --language=help --style=plain'
alias -- --help='--help 2>&1 | bat --language=help --style=plain'
export MANPAGER="sh -c 'sed -u -e \"s/\\x1B\[[0-9;]*m//g; s/.\\x08//g\" | bat --plain --paging=auto -lman'"

if command -v fzf >/dev/null 2>&1; then
  if [[ -n "${ZSH_VERSION:-}" ]]; then
    source <(fzf --zsh)
  else
    source <(fzf --bash)
  fi
fi

vault_remain() {
  command aws_remain 2>/dev/null || {
    local now aws_expire curr left_sec left_hour left_min
    now=$(TZ=UTC date -j +%Y-%m-%dT%H:%M:%SZ)
    aws_expire=$(TZ=UTC date -j -f "%Y-%m-%dT%H:%M:%SZ" -u "${AWS_CREDENTIAL_EXPIRATION:-$now}" "+%s")
    curr=$(TZ=UTC date -j +%s)
    left_sec=$((aws_expire - curr))
    left_hour=$((left_sec / 3600))
    left_sec=$((left_sec - left_hour * 3600))
    left_min=$((left_sec / 60))
    left_sec=$((left_sec - left_min * 60))
    echo "${left_hour}:${left_min}:${left_sec}"
  }
}

aws_remain() {
  command aws_remain
}
