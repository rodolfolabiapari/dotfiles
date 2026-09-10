# Plano de Estudos: Neovim + LazyVim para SRE

## Como usar este plano

Cada checkbox `- [ ]` vira `- [x]` quando concluído.
Os exercícios práticos são opcionais mas recomendados.

---

## Fase 0 — Fundação: Conheça Seu Ambiente

**Objetivo:** Entender a estrutura do seu Neovim e navegar com which-key.

### Tarefas

- [ ] **Entender a estrutura do projeto**
  - `init.lua` → ponto de entrada (só 2 linhas)
  - `lua/config/lazy.lua` → carrega LazyVim + plugins
  - `lua/config/options.lua` → suas opções customizadas
  - `lua/plugins/` → cada arquivo `.lua` é um plugin
- [ ] **Which-key — seu melhor amigo**
  - Pressione `<space>` e espere 1s → aparece a paleta de comandos
  - Navegue pelos grupos com o teclado
  - Memorize os grupos principais: `f` (find), `g` (git), `s` (search), `l` (LSP)
- [ ] **Janelas e navegação**
  - `<space>-` ou `<space>|` — dividir tela horizontal/vertical
  - `Ctrl+h/j/k/l` — navegar entre janelas (e tmux!)
  - `<space>wd` — fechar janela atual
  - `<space>e` — abrir neo-tree (explorador de arquivos)
- [ ] **Buffers (arquivos abertos)**
  - `<space>bb` — listar buffers abertos
  - `<space>bd` — fechar buffer atual
  - `<C-^>` — alternar entre os 2 últimos buffers
  - `:E` — editar arquivo (ou `:e`)

### Exercício prático

```text
1. Abra o nvim:                 nvim
2. Pressione <space> → veja o which-key
3. Pressione <space>e → abra o neo-tree
4. Navegue pelos arquivos com j/k e Enter
5. Pressione <space>- → divida a tela
6. Pressione Ctrl+l → vá para janela da direita
7. Pressione Ctrl+h → volte para esquerda
8. Pressione <space>fp → busque um plugin
```

---

## Fase 1 — Locomoção e Edição de Texto

**Objetivo:** Navegar e editar arquivos YAML/ Markdown sem usar mouse.

### Aulas

#### 1A — Movimento básico

| Tecla | Ação | Prática no YAML |
|-------|------|-----------------|
| `h` `j` `k` `l` | esquerda, baixo, cima, direita | Navegue `kind: Deployment` |
| `w` `W` | próxima palavra (espaço/palavra) | Pule entre campos |
| `b` `B` | palavra anterior | Volte para `metadata:` |
| `e` `E` | final da palavra | Pare no final de `containers` |
| `0` | início da linha | Volte para coluna 1 |
| `^` | primeiro caractere não espaço | |
| `$` | final da linha | |
| `gg` | início do arquivo | |
| `G` | final do arquivo | |
| `{` `}` | parágrafo anterior/próximo | Pule entre blocos YAML |
| `%` | parêntese/chave correspondente | De `{` ao `}` |
| `Ctrl+d` / `Ctrl+u` | meia página para baixo/cima | Role arquivos K8s grandes |

#### 1B — Text objects (CRÍTICO para YAML)

Text objects permitem operar sobre **palavras, aspas, parênteses, colchetes, chaves, tags**.

| Objeto | O que seleciona | Exemplo YAML |
|--------|----------------|--------------|
| `iw` | palavra interna | `ciw` troca `name:` |
| `iW` | palavra com espaço | `ciW` troca `"meu deployment"` |
| `i"` | dentro de aspas duplas | `ci"` troca `name: "nginx"` → `ci"` + `"apache"` |
| `i'` | dentro de aspas simples | `ci'` troca valor |
| `i(` / `ib` | dentro de parênteses | `di(` apaga conteúdo de `()` |
| `i[` | dentro de colchetes | `ci[` troca conteúdo de `[]` |
| `i{` / `iB` | dentro de chaves | `di{` apaga bloco |
| `it` | dentro de tag (XML/HTML) | |
| `ip` | parágrafo atual | `dip` deleta bloco YAML |

#### 1C — Combinando text objects com ações

| Comando | Ação | Uso no YAML |
|---------|------|-------------|
| `ci"` | Change Inside Quotes | Trocar `image: "nginx:1.25"` → `ci"` → `"nginx:1.26"` |
| `da"` | Delete Around Quotes | Remover as aspas e o conteúdo |
| `ci{` | Change Inside Braces | Trocar todo o bloco `{}` |
| `di[` | Delete Inside Brackets | Apagar conteúdo de `[]` |
| `yiw` | Yank Inside Word | Copiar palavra para colar depois |
| `viw` | Visual Inside Word | Selecionar palavra visualmente |
| `ca(` | Change Around Paren | Trocar `(...)` incluindo os parênteses |

#### 1D — Busca e replace

| Comando | Ação |
|---------|------|
| `/texto` | Buscar para frente |
| `?texto` | Buscar para trás |
| `n` | Próximo resultado |
| `N` | Resultado anterior |
| `*` | Buscar palavra sob cursor (para frente) |
| `#` | Buscar palavra sob cursor (para trás) |
| `:%s/velho/novo/g` | Replace em todo arquivo |
| `:%s/velho/novo/gc` | Replace com confirmação |

#### 1E — Repetição e macros

| Comando | Ação |
|---------|------|
| `.` | **Repetir última alteração** (mais útil do que parece!) |
| `q{letra}` | Iniciar gravação de macro na letra |
| `q` | Parar gravação |
| `@{letra}` | Executar macro |
| `@@` | Repetir última macro |

### Exercício prático YAML

Abra um arquivo YAML qualquer (deployment, service, configmap):

```
1. Navegue:   gg → /kind → n → n → { → }
2. Busque:    /image → ci" → "nginx:1.26" → Esc
3. Repita:    n → . (repete ci" em outra imagem)
4. Deletar:   /name → di( → apaga o nome
5. Trocar:    /replicas → ciW → 5
6. Yank:      /namespace → yiw → vá para outro arquivo → p
7. Macro:     qa → ci" → "novo-valor" → Esc → n → q → @a → @@
```

---

## Fase 2 — Git Dentro do Neovim

**Objetivo:** Fazer todo fluxo git sem sair do Neovim.

### Ferramentas disponíveis

| Plugin | Para que serve |
|--------|---------------|
| **Gitsigns** (já instalado) | Sinais na gutter, blame inline, stage hunk |
| **Fugitive** (instalado agora) | Status, diff, blame, rebase, commit — interface git completa |
| **Telescope git** (já instalado) | Buscar commits, arquivos modificados |

### 2A — Gitsigns (gutter e hunks)

| Comando | Ação |
|---------|------|
| `]c` | Próximo hunk (alteração) |
| `[c` | Hunk anterior |
| `<leader>hs` | Stage hunk (preparar para commit) |
| `<leader>hu` | Undo hunk (reverter alteração) |
| `<leader>hr` | Reset hunk |
| `:Gitsigns blame` | Blame inline (quem modificou cada linha) |
| `:Gitsigns toggle_signs` | Mostrar/esconder sinais |

### 2B — Fugitive (git completo)

| Atalho / Comando | Ação |
|-----------------|------|
| `<leader>gs` | Git Status (tela tipo `git status`) |
| `<leader>gd` | Git Diff vertical (vs staged/HEAD) |
| `<leader>gb` | Git Blame |
| `<leader>gl` | Git Log |
| `<leader>gca` | Git Commit All (commit com todos os arquivos) |
| `<leader>grb` | Git Rebase Interactive |

**Na tela de Status do Fugitive (`<leader>gs`):**

| Tecla | Ação |
|-------|------|
| `s` | Stage arquivo/hunk |
| `u` | Unstage |
| `-` | Stage/reverse toggle |
| `=` | Mostrar diff |
| `cc` | Criar commit |
| `ca` | Amend commit |
| `cA` | Amend + edit message |
| `D` | Diff contra HEAD |
| `dv` | Diffsplit |
| `q` | Sair |

**No blame:**

- `Enter` no blame → abre commit desse hash
- `o` no blame → abre em split

**No rebase interativo:**

- `:G rebase -i HEAD~3` → abre lista de commits
- `r` = reword, `e` = edit, `s` = squash, `d` = drop, `p` = pick

### 2C — Telescope git

| Atalho | Ação |
|--------|------|
| `<leader>gc` | Git Commits (buscar mensagens de commit) |
| `<leader>gt` | Git Status (arquivos modificados) |
| `<leader>gf` | Git Files (arquivos trackeados) |

### Exercício prático

```
1. No repositório de manifests:
   <leader>gs → veja status
   Navegue com j/k, pressione s para stage
   Pressione cc → escreva mensagem → :wq

2. Diff:
   <leader>gd → veja diff vertical
   ]c/[c → navegue entre alterações

3. Blame:
   <leader>gb → veja quem fez cada linha
   Enter em uma linha → veja o commit completo

4. Log:
   <leader>gl → busque commit por mensagem

5. Rebase:
   :G rebase -i HEAD~5 → reword/squash commits
```

---

## Fase 3 — LSP, YAML e K8s Mastery

**Objetivo:** Autocomplete, diagnóstico, formatação — tudo para YAML K8s.

### 3A — LSP básico

| Comando | Ação |
|---------|------|
| `gd` | Go to Definition (vá para definição) |
| `K` | Hover (documentação do campo) |
| `<space>ca` | Code Actions (ações disponíveis) |
| `<space>rn` | Rename (renomear variável/campo) |
| `<space>l` | Grupo LSP no which-key |
| `[d` | Diagnóstico anterior |
| `]d` | Próximo diagnóstico |
| `<space>le` | Listar diagnósticos (trouble.nvim) |

### 3B — YAML + K8s

**Autocomplete de schemas K8s** já está configurado:
- `jsonls` + SchemaStore.org → autocomplete para `kind:`, `apiVersion:`, campos específicos
- Digite `Deployment` → autocomplete sugere `apps/v1`

### 3C — Telescope search

| Atalho | Ação | Uso |
|--------|------|-----|
| `<space>ff` | Find files (nome do arquivo) | Buscar `deployment-prod.yaml` |
| `<space>sg` | Grep (conteúdo) | Buscar `ClusterIssuer` no repo |
| `<space>sw` | Search word sob cursor | Palavra atual em todos arquivos |
| `<space>fp` | Find plugin file | Buscar arquivos de plugins |

### Exercício prático

```
1. Abra um deployment.yaml
   Digite kind: → veja autocomplete com apiVersion
   Pressione K em cima de replicas → veja doc
   Pressione gd em uma referência

2. Busque algo no projeto:
   <space>sg → digite "Ingress" → Enter → veja resultados

3. Diagnósticos:
   <space>le → veja erros do LSP
   ]d/[d → navegue entre problemas
```

---

## Fase 4 — Markdown + Obsidian

**Objetivo:** Escrever documentação técnica e runbooks dentro do Neovim.

### Obsidian.nvim

Já configurado — workspace em `~/Documents/obsidian/personal/`.

| Comando | Ação |
|---------|------|
| `:Obsidian today` | Criar/abrir daily note de hoje |
| `[[link` | Autocomplete de links entre notas |
| `:Obsidian search` | Buscar texto em todas as notas |
| `:Obsidian tags` | Listar/ buscar tags |
| `:Obsidian link` | Criar link para nota nova |
| `:Obsidian template` | Inserir template |

### Markdown editing

| Técnica | Como fazer |
|---------|------------|
| Cabeçalhos | `:# ` ou `:## ` (snippets) |
| Listas | `- item` + indent com `>>` |
| Código inline | `` `code` `` |
| Bloco de código | ```` ```yaml ```` |
| Bold/ Italic | `**bold**`, `*italic*` |
| Links | `[texto](url)` |
| Imagens | `![alt](path)` |
| Tabelas | `| col1 | col2 |` |

### Exercício prático

```
1. Crie um runbook:
   :Obsidian today → abre daily note
   Escreva título ## Runbook: Incidente X

2. Use links:
   [[k8s-commands]] → autocomplete
   :Obsidian search "deployment" → busque em notas

3. Formate markdown:
   ```yaml
   apiVersion: apps/v1
   kind: Deployment
   ```
```

---

## Fase 5 — Macros, Snippets e Automação

**Objetivo:** Automatizar tarefas repetitivas.

### Macros

```
1. qa — comece a gravar na tecla 'a'
2. Execute ações (edições, navegação)
3. q — pare de gravar
4. @a — execute macro
5. 5@a — execute 5 vezes
6. @@ — repita última macro
```

**Exemplo prático:** Adicionar `env:` em 10 containers de um YAML multi-deployment:

```
qa                          → começa gravar
/containers                 → busca containers
j                          → desce uma linha
oenv:                      → nova linha com env:
<Esc>                      → volta ao normal
q                          → para gravar
10@a                       → executa 10 vezes
```

### Snippets (friendly-snippets já incluso)

| Trigger (digitar + Tab) | Expande para |
|-------------------------|-------------|
| `deploy` + Tab | Esqueleto de Deployment YAML |
| `svc` + Tab | Esqueleto de Service |
| `ing` + Tab | Esqueleto de Ingress |
| `cm` + Tab | Esqueleto de ConfigMap |
| `code` + Tab | Bloco de código Markdown |
| `table` + Tab | Tabela Markdown |

> **Nota:** Snippets dependem do `LuaSnip` (já incluso no LazyVim).
> Sua experiencia com snippets pode variar — explore com `:Inspect` para ver quais estão disponíveis.

---

## Fase 6 — Plugins Futuros (opcional)

Quando estiver confortável com as fases anteriores, instale:

- [ ] **CodeCompanion.nvim** (`olimorris/codecompanion.nvim`) — prompts de IA no nvim
- [x] **render-markdown.nvim** (`MeanderingProgrammer/render-markdown.nvim`) — renderiza markdown inline
- [ ] **harpoon** (`ThePrimeagen/harpoon`) — marca arquivos para acesso rápido
- [ ] **undotree** (`mbbill/undotree`) — visualizar histórico de mudanças

---

## Referência Rápida

### Atalhos essenciais

| O quê | Atalho |
|-------|--------|
| Salvar | `<space>w` |
| Fechar | `<space>q` |
| Fechar tudo | `<space>Q` |
| Explorador | `<space>e` |
| Terminal | `<space>ft` |
| Buscar arquivo | `<space>ff` |
| Buscar texto | `<space>sg` |
| Git status | `<space>gs` |
| Git diff | `<space>gd` |
| Git blame | `<space>gb` |
| Render Markdown | `<space>um` |
| Toggle Spell | `<space>us` |
| Which-key | `<space>` (espere) |

### Comandos úteis

| Comando | Ação |
|---------|------|
| `:Lazy` | Gerenciador de plugins |
| `:Lazy sync` | Atualizar plugins |
| `:Mason` | Gerenciar LSPs (instalar/atualizar) |
| `:checkhealth` | Verificar saúde do Neovim |
| `:messages` | Ver mensagens de erro/log |
| `:help keymap` | Ajuda sobre keymaps |

### Modos do Vim

| Modo | Entrar | Sair | Para que |
|------|--------|------|----------|
| Normal | `Esc` | — | Navegar, comandos |
| Insert | `i` | `Esc` | Digitar texto |
| Visual | `v` / `V` / `Ctrl+v` | `Esc` | Selecionar |
| Command | `:` | `Enter` / `Esc` | Comandos |
| Replace | `R` | `Esc` | Sobrescrever |

---

## Progresso

- [ ] Fase 0 — Fundação
- [ ] Fase 1 — Locomoção e Edição
- [ ] Fase 2 — Git
- [ ] Fase 3 — LSP, YAML, K8s
- [ ] Fase 4 — Markdown + Obsidian
- [ ] Fase 5 — Macros e Snippets
- [ ] Fase 6 — Plugins Futuros

---

> 📖 **Links úteis:**
> - [LazyVim Reference](https://lazyvim.github.io/installation)
> - [Vim Cheatsheet](https://vim.rtorr.com/)
> - [Learn Vim Progressively](https://yannesposito.com/Scratch/en/blog/Learn-Vim-Progressively/)
