#!/usr/bin/env bash

if ! ssh-add -l | grep -q rodolfo; then
  ssh-add ~/.ssh/rodolfo.mansur
fi

cd ~/Documents/obsidian/personal/ || exit 1

if ! git diff --cached --quiet; then
  git commit -m "sync(linux): $(date +'%Y-%m-%d %H:%M:%S')"
else
  echo "nothing to commit"
fi

git pull --no-rebase origin master

git push origin master
