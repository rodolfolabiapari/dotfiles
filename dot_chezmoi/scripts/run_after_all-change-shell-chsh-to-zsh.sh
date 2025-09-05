#!/usr/bin/env bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

set -eufo pipefail

echo -e "\nChanging chsh to zsh"
# Check if zsh is default
if [ "$SHELL" != "/bin/zsh" ] && [ "$SHELL" != "/usr/bin/zsh" ]; then
  # validate if zsh is installed
  if which zsh > /dev/null 2>&1; then
    # change for zsh
    chsh -s $(which zsh)
    echo "Shell changed to ZSH"
  else
    echo "ZSH NOT INSTALLED!"
  fi
else
  echo "ZSH is already default"
fi

echo "ZSH alterado para padrao com sucesso"
