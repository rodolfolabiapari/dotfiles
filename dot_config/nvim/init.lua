-- Configuracoes usando padrao vim
vim.cmd("set expandtab")
vim.cmd("set tabstop=2")
vim.cmd("set softtabstop=2")
vim.cmd("set shiftwidth=2")

-- Configura a tecla leader globalmente para " "
-- antigamente era "\"
vim.g.mapleader = " "

-- Carregamento do gerenciador de pacotes folke lazy nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
  { "catppuccin/nvim", name = "catppuccin", priority = 1000 },
  {
  'nvim-telescope/telescope.nvim', tag = '0.1.6',
    dependencies = { 'nvim-lua/plenary.nvim' }
  },
  {"nvim-treesitter/nvim-treesitter", build = ":TSUpdate"}
}


-- Carrega o lazy previamente
-- nele existe duas variaveis plugins e opts, definidas anteriormente
require("lazy").setup(plugins, opts)


-- Configura o telescope Ctrl-p
local builtin = require("telescope.builtin")
-- Mapeia o Ctrl p para fazer a busca de arquivos
vim.keymap.set('n', '<C-p>', builtin.find_files, {})
-- Cofigura o Live Grep usando o " fg"
-- lembrando que o leader foi trocado de "\" para " "
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
-- precisa do https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation para funcionar


-- Treesitter
local configs = require("nvim-treesitter.configs")

configs.setup({
    ensure_installed = { "lua", "vim", "vimdoc", "javascript", "html", "arduino", "dockerfile", "git_config", "git_rebase", "gitcommit", "gitignore", "go", "gpg", "hcl", "helm", "java", "jq", "json", "passwd", "pem", "python", "r", "regex", "rego", "ssh_config", "terraform", "tmux", "toml", "yaml", "xml"},
    highlight = { enable = true },
    indent = { enable = true },  
  })


-- Carrega e configura a cor no nvim
require("catppuccin").setup()
vim.cmd.colorscheme "catppuccin"

