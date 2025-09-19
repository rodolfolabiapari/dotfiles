set -g default-terminal "tmux-256color"
set -ga terminal-overrides ",alacritty*:RGB,xterm-256color:RGB"

set -g prefix C-s

set -g focus-events on

set -g allow-rename off


set -g base-index 1
setw -g pane-base-index 1
set -g renumber-windows on


set -g mouse on
set -g history-limit 1000000
set -s escape-time 10
set -g assume-paste-time 100

set -g detach-on-destroy off

set -g status-interval 2
set -g status-keys vi
setw -g mode-keys vi
