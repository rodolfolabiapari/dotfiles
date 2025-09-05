#!/bin/bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

# SNAP packs for common system

# Verify if snap command is already installed
if ! command -v snap &> /dev/null; then
    echo -e "\nSnap commando not found. Installing"
    sudo sudo apt install -y snapd
fi

# Check if server is running
if [[ ! $(systemctl is-active snapd.service) == "active" ]]; then
    echo -e "\nError installing snap packages. The snapd service is not running."
    journalctl -u snapd.service --lines=10 --no-pager
    exit 1
fi

# List of packages to install
# This list accecpt comments
packages=(
  core                      # lastest snapd version
  cointop
  chezmoi
  nvim
  obsidian
)

# Installing the packages
for package in "${packages[@]}"; do
  sudo snap install "$package"
done

