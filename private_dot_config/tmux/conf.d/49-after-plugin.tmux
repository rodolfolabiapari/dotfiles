# Window Title and Status
# qual eh a ideia do T e do W:
# quando eu tiver na janela, mostra o titulo completo (T)
# quando eu estiver fora, mostra somente o nome da aplicacao rodando (W)
# isso me incentiva a usar nomes nas sessoes e janelas, e me orientar melhor
set -g @catppuccin_window_current_background "#{@thm_mauve}"
set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
set -g @catppuccin_window_default_text " #T"
set -g @catppuccin_window_number_position "right"
set -g @catppuccin_window_status "icon"
set -g @catppuccin_window_status_style "rounded"
set -g @catppuccin_window_text " #W"

set -g status-right-length 100
set -g status-left-length 100
set -g status-left ""
set -g status-right "#{E:@catppuccin_status_session}"

set -g pane-border-status bottom
set -g pane-border-format '#[bold]#{?pane_active,#[fg=#f9e2af]^ ACTIVE,#[fg=#9399b2]#P} #[fg=#a6adc8]#{pane_current_command}'
