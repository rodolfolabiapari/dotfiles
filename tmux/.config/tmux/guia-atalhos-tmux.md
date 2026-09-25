# 🚀 Guia Prático de Atalhos do Tmux

Este guia resume os atalhos configurados no seu `tmux.conf` personalizado, além de incluir os comandos para
gerenciamento e movimentação de painéis (_panes_).

---

## 🔑 Prefixo Principal

O prefixo é a combinação de teclas necessária para ativar a maioria dos comandos do Tmux.

- **Prefixo principal:** `Ctrl + Space`
- **Prefixo secundário:** `Ctrl + b`
- **Recarregar configurações:** `Prefixo` + `q`

---

## 🖼️ Janelas (Tabs)

| Ação                           | Atalho / Comando                               |
| :----------------------------- | :--------------------------------------------- |
| **Nova Janela**                | `Prefixo` + `c`                                |
| **Renomear Janela**            | `Prefixo` + `r`                                |
| **Ir para janela N**           | `Alt + 1` até `Alt + 9`                        |
| **Navegar (Próxima/Anterior)** | `Alt + ←` / `Alt + →` ou `Alt + h` / `Alt + l` |
| **Mover posição da janela**    | `Alt + Shift + ←` / `Alt + Shift + →`          |

---

## 📐 Painéis (Splits)

### Criar e Dividir Tela

| Ação                                         | Atalho (Com Prefixo) | Atalho Direct (Sem Prefixo) |
| :------------------------------------------- | :------------------- | :-------------------------- |
| **Dividir na Horizontal** (em cima/em baixo) | `Prefixo` + `"`      | `Alt + Enter`               |
| **Dividir na Vertical** (lado a lado)        | `Prefixo` + `%`      | `Alt + Shift + Enter`       |

### Navegação e Mover Foco

Navegue livremente com as teclas de movimento estilo Vim ou Setas:

- `Ctrl + Alt` + `h` / `j` / `k` / `l` _(ou Setas)_

> 💡 **Integração com Neovim (`vim-tmux-navigator`):**  
> Use `Ctrl` + `h`/`j`/`k`/`l` para navegar de forma transparente entre splits do Neovim e painéis do Tmux.

### Redimensionar Painéis

Mantenha pressionado para ajustar o tamanho do painel atual (passo de 5 linhas/colunas):

- `Ctrl + Alt + Shift` + `Setas (← ↓ ↑ →)`

---

## 🔀 Juntar, Mover e Destacar Painéis (Avançado)

Comandos para reorganizar painéis entre janelas diferentes:

### 1. Via Linha de Comando do Tmux (`Prefixo` + `:`)

- **Puxar painel de outra janela:**
  - Lado a lado: `:join-pane -h -s <Nº_JANELA>.<Nº_PAINEL>` _(ex: `:join-pane -h -s 2.1`)_
  - Em cima/Em baixo: `:join-pane -v -s <Nº_JANELA>.<Nº_PAINEL>`
- **Mover painel atual para outra janela:**
  - `:join-pane -t <Nº_JANELA>` _(ex: `:join-pane -t 3`)_

### 2. Separar Painel (Promover a Janela)

- **Destacar painel ativo para uma nova janela:**  
  `Prefixo` + `!` _(Executa o comando `break-pane`)_

---

## 🪟 Popups Flutuantes

Janelas temporárias que abrem em overlay na tela:

- `Prefixo` + `Ctrl + b` ➔ Edita o arquivo `~/.bashrc` via Neovim.
- `Prefixo` + `Ctrl + t` ➔ Abre um terminal Bash temporário em popup.
- `Prefixo` + `Ctrl + o` ➔ Abre suas notas do Obsidian (`README.md`).

---

## 📋 Modo de Cópia (Estilo Vim)

Pressione `Prefixo` + `[` para entrar no modo de cópia/scroll.

- **Iniciar seleção:** `v`
- **Copiar seleção e sair:** `y`
- **Navegação:** Teclas padrão Vim (`h`, `j`, `k`, `l`, `g`, `G`, `w`, `b`)

---

## ⚙️ Novos Atalhos Sugeridos para o `tmux.conf`

Caso deseje mapear a movimentação interativa de painéis via prompt sem precisar digitar todo o comando `:join-pane`:

```tmux
# Mapeamento interativo para juntar e mover painéis
bind j command-prompt -p "Puxar painel da janela (ex: 2 ou 2.1):" "join-pane -h -s '%%'"
bind J command-prompt -p "Enviar painel atual para a janela (ex: 2):" "join-pane -t '%%'"
```
