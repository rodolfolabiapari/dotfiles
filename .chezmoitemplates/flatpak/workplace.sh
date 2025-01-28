#!/bin/bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

# FLATPCK packs for workplace system

echo -e "\nUpdating FLATPAK already installed packages"
sudo flatpak update

echo "Installing new FLATPAK packages"
sudo flatpak install --system --noninteractive flathub \
  org.videolan.VLC \
  com.stremio.Stremio

