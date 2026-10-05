#!/usr/bin/env bash
# atalhos.sh — popup de ajuda do tmux com busca interativa.
# Abre uma lista pesquisável (fuzzy) dos atalhos configurados no tmux.conf
# e comandos úteis de painel/resize/mover. Usa `gum` se houver; senão, `less`.
#
# Aberto por: Prefixo + Ctrl+g  (bind C-g no tmux.conf)

set -euo pipefail

HELP_FILE="${TMPDIR:-/tmp}/tmux-atalhos-$$.txt"
trap 'rm -f "$HELP_FILE"' EXIT

# Colunas alinhadas: categoria + atalho (largura fixa) + descrição.
# A busca filtra qualquer parte da linha.
cat > "$HELP_FILE" <<'EOF'
[geral]      Ctrl+Space             prefixo principal (p/ acionar atalhos com prefixo)
[geral]      Ctrl+b                 prefixo alternativo
[geral]      Prefixo + q            recarregar o tmux.conf
[geral]      Prefixo + :            abrir prompt de comando do tmux
[geral]      Prefixo + Ctrl+g       este popup de ajuda
[geral]      Prefixo + z            zoom no painel (liga/desliga)

[janela]     Prefixo + c            nova janela no diretório atual
[janela]     Prefixo + r            renomear janela
[janela]     Alt + 1..9             pular para a janela N
[janela]     Alt + h / l            janela anterior / próxima
[janela]     Alt + ← / →            janela anterior / próxima
[janela]     Alt + Shift + ←/→      trocar a janela de posição (reordenar)
[janela]     Prefixo + !            destacar painel p/ nova janela (break-pane)
[janela]     Prefixo + ,            renomear janela (padrão tmux)

[painel]     Prefixo + "            dividir horizontal (cima/baixo)
[painel]     Prefixo + %            dividir vertical (lado a lado)
[painel]     Alt + Enter            dividir horizontal (sem prefixo)
[painel]     Alt + Shift + Enter    dividir vertical (sem prefixo)
[painel]     Prefixo + x            fechar o painel atual
[painel]     Ctrl+Alt + hjkl        focar painel (sem prefixo)
[painel]     Ctrl+Alt + setas       focar painel (sem prefixo)
[painel]     Ctrl + hjkl            navegar entre nvim e tmux (vim-tmux-navigator)
[painel]     Ctrl + \               focar painel anterior
[painel]     Prefixo + ←/→/↑/↓      focar painel (padrão tmux)
[painel]     Prefixo + o            alternar entre painéis
[painel]     Prefixo + { / }        trocar painel de lugar (esquerda/direita)
[painel]     Prefixo + Space        alterna o layout dos painéis

[resize]     Ctrl+Alt+Shift + ←/→   alarga/aperta 5 colunas
[resize]     Ctrl+Alt+Shift + ↑/↓   aumenta/encolhe 5 linhas
[resize]     Ctrl+Alt+Shift + hjkl  mesmo redimensionamento via vim
[resize]     Prefixo + Ctrl+setas   redimensiona 1 linha/coluna (padrão tmux)
[resize]     Prefixo + Alt+setas    redimensiona 5 linhas/colunas (padrão tmux)

[mover]      Prefixo + Ctrl+J       enviar painel atual p/ outra janela (prompt)
[mover]      Prefixo + !            mover painel p/ janela própria (break-pane)
[mover]      :join-pane -h -s 2.1   puxar painel 2.1 p/ cá, lado a lado
[mover]      :join-pane -v -s 2.1   puxar painel 2.1 p/ cá, cima/baixo
[mover]      :join-pane -t 3        enviar painel atual p/ janela 3
[mover]      :swap-pane -U / -D     trocar painel com o de cima/baixo
[mover]      :break-pane            destacar painel (mesmo que Prefixo + !)
[mover]      :resize-pane -Z        zoom no painel (mesmo que Prefixo + z)

[sessao]     Prefixo + C            nova sessão no diretório atual
[sessao]     Prefixo + R            renomear sessão
[sessao]     Prefixo + P / N        sessão anterior / próxima
[sessao]     Alt + ↑ / ↓            sessão anterior / próxima (sem prefixo)
[sessao]     Prefixo + d            desconectar (detach) da sessão
[sessao]     Prefixo + s            escolher sessão (choose-tree)
[sessao]     Prefixo + $            renomear sessão (padrão tmux)
[sessao]     tmux new -s nome       criar sessão nova por nome (shell)
[sessao]     tmux ls                listar sessões (shell)

[popup]      Prefixo + Ctrl+b       editar ~/.bashrc (nvim) em popup
[popup]      Prefixo + Ctrl+t       terminal bash temporário em popup
[popup]      Prefixo + Ctrl+o       abrir Obsidian (README.md) em popup
[popup]      Prefixo + Ctrl+g       este popup de atalhos

[copia]      Prefixo + [            entrar no modo de cópia (scroll)
[copia]      v                      iniciar seleção
[copia]      y                      copiar seleção e sair
[copia]      h j k l                navegar na cópia (vim)
[copia]      g / G                  início / fim do histórico
[copia]      w / b                  palavra adiante / atrás
[copia]      Ctrl+u / Ctrl+d        meia página acima / abaixo
[copia]      q / Escape             sair do modo de cópia
EOF

if command -v gum >/dev/null 2>&1; then
  gum filter \
    --header "Atalhos do tmux   |   Prefixo: Ctrl+Space   |   digite p/ filtrar" \
    --placeholder "ex: resize, janela, split, sessão" \
    --prompt "> " \
    --indicator "›" \
    --fuzzy < "$HELP_FILE"
else
  less -R "$HELP_FILE"
fi