# Paste buffer
bind P paste-buffer

# Start selection in copy mode
bind-key -T copy-mode-vi v send-keys -X begin-selection

# Toggle between linear and rectangular selection
bind-key -T copy-mode-vi V send-keys -X rectangle-toggle

# Allow mouse selection to continue (uncomment to disable mouse)
#unbind -T copy-mode-vi Enter

# Copy selected text to clipboard
#  Atencao ao -and-cancel! ele faz sair automaticamente do modo de visualizacao/copia
#bind-key -T copy-mode-vi y send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard'
#  Estou substituindo para o modo copy-pipe para teste
bind-key -T copy-mode-vi y send-keys -X copy-pipe 'xclip -selection clipboard'

# Remove qualquer acao padrao preconfigurada a acao MouseDragEnd1Pane
unbind -T copy-mode-vi MouseDragEnd1Pane

# Copy selected text to clipboard when mouse drag ends
#  Atencao ao -and-cancel! ele faz sair automaticamente do modo de visualizacao/copia
#bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe-and-cancel 'xclip -selection clipboard'
#  Estou substituindo para o modo copy-pipe para teste
bind-key -T copy-mode-vi MouseDragEnd1Pane send-keys -X copy-pipe 'xclip -selection clipboard'

# Enable tmux clipboard integration (can be disabled if problematic)
set -s set-clipboard on

