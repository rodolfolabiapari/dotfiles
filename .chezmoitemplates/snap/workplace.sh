#!/bin/bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash
# SNAP packs for workplace system

# List of packages to install
# This list accecpt comments
packages=(
  brave
  canonical-livepatch
  code
  glab                             # Gitlab cli
  go                               # TODO: there is go to armv6l armhf?
  google-cloud-sdk
  helm
  postman
  rpi-imager
  spotify
  sublime-text
  telegram-desktop
  zoom-client
)

# Installing the packages
for package in "${packages[@]}"; do
  sudo snap install "$package"
done

echo "Granting glab access to SSH keys"
sudo snap connect glab:ssh-keys
