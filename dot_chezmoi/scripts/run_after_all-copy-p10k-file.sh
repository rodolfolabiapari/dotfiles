#!/usr/bin/env bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

set -eufo pipefail

# p10k.zsh hash: {{ include "./dot_chezmoi/parameters/p10k.zsh" | sha256sum }}

echo -e "\nCopying the p10k internal file for vault"
cp "${HOME}/.local/share/chezmoi/dot_chezmoi/parameters/p10k.zsh" "$HOME/.local/share/powerlevel10k/internal/p10k.zsh"
