#!/bin/bash
# -*- mode:bash; tab-with=2; indent-tabs-mode=0; -*-
# vim:ft=bash

set -e

# Create temp dir to download files
mkdir -p /tmp/beans
cd /tmp/beans
mkdir -p ${HOME}/bin

# Installing git-delta
echo "Downloading git-delta"
DELTA="delta-0.17.0-x86_64-apple-darwin"
curl -OL "https://github.com/dandavison/delta/releases/download/0.17.0/delta-0.17.0-x86_64-apple-darwin.tar.gz"

# Extract a single file from tar.gz
tar -zxf ${DELTA}.tar.gz ${DELTA}/delta

chmod +x ${DELTA}/delta

rm -f ${HOME}/bin/delta
mv ${DELTA}/delta $HOME/bin/


rm -rf /tmp/beans

