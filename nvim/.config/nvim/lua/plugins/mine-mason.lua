-- mason.nvim: gerenciador de instaladores externos (LSPs, linters,
-- formatadores). A lista abaixo é instalada automaticamente na primeira vez
-- que o Neovim inicia. Ferramentas SRE: ansible, helm, terraform, kube-linter,
-- yamllint, shellcheck, shfmt, markdownlint.

return {
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-language-server",
        "ansible-lint",
        "bash-language-server",
        "editorconfig-checker",
        "gofumpt",
        "golines",
        "gomodifytags",
        "gotests",
        "hadolint",
        "helm-ls",
        "impl",
        "jsonlint",
        "json-to-struct",
        "kube-linter",
        "lua-language-server", -- Lua Language server
        "markdownlint-cli2",
        "markdown-toc",
        "misspell",
        "prettier",
        "revive",
        "ruff",
        "shellcheck",
        "shfmt",
        "staticcheck",
        "stylua", -- Used to format Lua code
        "terraform",
        "terraform-ls",
        "tflint",
        "vim-language-server",
        "vint",
        "yamlfmt",
        "yaml-language-server",
        "yamllint",
      },
    },
  },
}
