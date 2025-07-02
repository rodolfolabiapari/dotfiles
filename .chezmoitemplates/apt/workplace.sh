#!/bin/bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

# APT packs for workplace system

# List of packages to install
# This list accecpt comments
packages=(
  anki                                     # Flashcard program
  #awscli                                  # nao esta sendo isntalado via apt
  build-essential
  flameshot                                # Screen shot
  gh                                       # Github cli
  google-cloud-cli
  google-cloud-sdk-gke-gcloud-auth-plugin
  google-cloud-sdk-terraform-tools
  gparted                                  # Disk manager
  ruby-full                                # ruby para jekyll
  taskwarrior
  terminator                               # Terminal emulator
  zlib1g-dev                               # para jekyll
)

# Installing the packages
echo "apt/workplace.sh"
sudo apt install -y "${packages[@]}"
