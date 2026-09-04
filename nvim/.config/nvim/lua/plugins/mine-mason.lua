return {

  -- add any tools you want to have installed below
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "ansible-language-server",
        "ansible-lint",
        "bash-language-server",
        "editorconfig-checker",
        "flake8",
        "gofumpt",
        "golines",
        "gomodifytags",
        "gotests",
        "helm-ls",
        "impl",
        "jsonlint",
        "json-to-struct",
        "kube-linter",
        "lua-language-server", -- Lua Language server
        "markdownlint",
        "misspell",
        "revive",
        "shellcheck",
        "shfmt",
        "staticcheck",
        "stylua", -- Used to format Lua code
        "terraform",
        "terraform-ls",
        "vim-language-server",
        "vint",
        "yamlfix",
        "yamlfmt",
        "yaml-language-server",
        "yamllint",
      },
    },
  },
}
