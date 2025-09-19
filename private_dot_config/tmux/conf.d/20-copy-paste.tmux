# Paste buffer
bind P paste-buffer

# Start selection in copy mode
bind-key -T copy-mode-vi v send-keys -X begin-selection

# Toggle between linear and rectangular selection
bind-key -T copy-mode-vi V send-keys -X rectangle-toggle

# Allow mouse selection to continue (uncomment to disable mouse)
#unbind -T copy-mode-vi Enter

# Copy selected text to clipboard
bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard'

# Copy selected text to clipboard when mouse drag ends
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard'

# Enable tmux clipboard integration (can be disabled if problematic)
set -s set-clipboard on
