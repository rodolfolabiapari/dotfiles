require("config.remote_clipboard").setup()
-- Opções globais do vim (carregadas antes do lazy.nvim iniciar).
-- As opções padrão do LazyVim estão em: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Depois do booleano imediato, o comentário à direita explica o efeito.

vim.opt.relativenumber = true -- números de linha relativos à posição do cursor
vim.opt.wrap = true -- quebra visual de linhas longas
vim.opt.expandtab = true -- Tab vira espaços (sem caracteres de tab)
vim.opt.softtabstop = 2 -- espaços que um Tab insere em modo insert
vim.opt.tabstop = 2 -- largura visual de um Tab
vim.opt.shiftwidth = 2 -- largura de indentação (>> e <)
vim.opt.linebreak = true -- quebra a linha no fim de palavra (com wrap), não no meio
vim.opt.textwidth = 120 -- coluna máxima ao formatar texto (gqq / gqap)
vim.opt.colorcolumn = "80,120" -- linhas verticais de referência nas colunas 80 e 120
vim.opt.list = true -- mostra caracteres invisíveis (· para espaço, $ para fim de linha)
vim.opt.scrolloff = 10 -- mantém 10 linhas visíveis acima/abaixo do cursor ao rolar
vim.opt.updatetime = 250 -- ms antes de disparar eventos (usado p/ gitsigns, etc.)
vim.opt.timeoutlen = 300 -- ms para combinações de teclas (ex: <leader>x)
vim.opt.spelllang = { "pt", "en" } -- idiomas do corretor ortográfico

-- LazyVim formata no save via BufWritePre (grupo LazyFormat).
-- Desliga o auto-format: formate manualmente com <leader>cf ou :LazyFormat.
vim.g.autoformat = false

-- Aparência dos diagnósticos do LSP (erros/avisos de linguagem server).
vim.diagnostic.config({
  update_in_insert = false, -- não rodar diagnóstico enquanto digita (só ao parar)
  severity_sort = true, -- ordena por severidade (erro antes de aviso)
  float = { border = "rounded", source = "if_many" }, -- janela flutuante com borda arredondada
  underline = { severity = { min = vim.diagnostic.severity.WARN } }, -- só sublinha a partir de WARN
  virtual_text = true, -- mostra o texto do erro inline após a linha
  virtual_lines = false, -- não expande uma linha extra por diagnóstico
  jump = { float = true }, -- [d / ]d abrem em janela flutuante
})
