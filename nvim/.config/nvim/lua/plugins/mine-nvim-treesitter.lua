-- nvim-treesitter: parsing sintático avançado (coloração, folding, navegação
-- estrutural, seleção de objetos). Cada parser instalado abaixo permite que o
-- Treesitter entenda a linguagem e melhore destaque/smart seleção/textobjects.

return {
  -- add more treesitter parsers
  {
    "nvim-treesitter/nvim-treesitter",
    opts = {
      ensure_installed = {
        "bash",
        -- "beancount-language-server",
        -- "beanhub-cli",
        "diff",
        "dockerfile",
        "gitcommit",
        "git_config",
        "gitignore",
        "git_rebase",
        "go",
        "hcl",
        "helm",
        "html",
        "java",
        "javascript",
        "jq",
        "json",
        "lua",
        "luadoc",
        "markdown",
        "markdown_inline",
        "passwd",
        "pem",
        "python",
        "query",
        "regex",
        "ssh_config",
        "terraform",
        "tmux",
        "toml",
        "tsx",
        "typescript",
        "vim",
        "vimdoc",
        "xml",
        "yaml",
      },
    },
  },
}
