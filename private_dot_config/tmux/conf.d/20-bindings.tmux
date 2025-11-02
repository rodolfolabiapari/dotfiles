# Move to the pane
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Pane resizing with Alt + hjkl
# M- significa tecla Alt
bind -n M-H resize-pane -L 2
bind -n M-J resize-pane -D 2
bind -n M-K resize-pane -U 2
bind -n M-L resize-pane -R 2

# Configura novos panes com o diretorio atual
bind c new-window -c "#{pane_current_path}"
bind '"' split-window -c "#{pane_current_path}"
bind % split-window -h -c "#{pane_current_path}"

##### Display Popups #####
# fonte: https://github.com/ericmckevitt/Dotfiles/blob/main/tmux.conf
bind C-y display-popup \
  -d "#{pane_current_path}" \
  -w 80% \
  -h 80% \
  -E "lazygit"

bind C-n display-popup -E 'bash -i -c "read -p \"Session name: \" name; tmux new-session -d -s \$name && tmux switch-client -t \$name"'

bind C-j display-popup -E "tmux list-sessions | sed -E 's/:.*$//' | grep -v \"^$(tmux display-message -p '#S')\$\" | fzf --reverse | xargs tmux switch-client -t"

bind C-p display-popup -E "ipython"

bind C-f display-popup \
  -w 80% \
  -h 80% \
  -E 'rmpc'

bind C-r display-popup \
  -d "#{pane_current_path}" \
  -w 90% \
  -h 90% \
  -E "ranger"

bind C-z display-popup \
  -w 80% \
  -h 80% \
  -E 'nvim ~/.zshrc'

bind C-g display-popup -E "bash -i ~/.tmux/scripts/chat-popup.sh"

bind C-t display-popup \
  -d "#{pane_current_path}" \
  -w 75% \
  -h 75% \
  -E "zsh"

##### Display Menu #####
bind d display-menu -T "#[align=centre]Dotfiles" -x C -y C \
  ".zshrc"            z  "display-popup -E 'nvim ~/.zshrc'" \
  ".tmux.conf"        t  "display-popup -E 'nvim ~/.tmux.conf'" \
  "Exit"              q  ""

bind r source-file ~/.tmux.conf \; display "Configurações do TMUX Recarregadas!"

# Ressurect sessoes
bind R run-shell ~/.config/tmux/plugins/tmux-resurrect/scripts/restore.sh
bind S run-shell ~/.config/tmux/plugins/tmux-resurrect/scripts/save.sh

