#!/bin/bash
# exit on error
set -e
# TODO trocar para fork customizado usando chezmoi

echo -e "\nCheck \".oh-my-zsh\" installation"

if [ ! -d "$HOME/.oh-my-zsh" ]; then
	echo "Getting ohmyz.sh"
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc --skip-chsh
else
	echo "\".oh-my-zsh\" already found, skipping."
fi