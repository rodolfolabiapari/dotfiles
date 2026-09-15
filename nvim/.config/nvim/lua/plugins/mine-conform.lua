-- conform.nvim: formatador de código
-- Associa extensões de arquivo a formatadores (stylua p/ lua, shfmt p/ bash,
-- terraform_fmt p/ HCL, ruff p/ Python, yamlfmt p/ YAML).
-- <leader>cf formata manualmente — auto-format no save está desligado.

return {
  {
    "stevearc/conform.nvim",
    opts = {
      formatters_by_ft = {
        ["terraform-vars"] = { "terraform_fmt" },
        bash = { "shfmt" },
        hcl = { "terraform_fmt" },
        json = { "prettier" },
        lua = { "stylua" },
        markdown = { "prettier", "markdownlint-cli2", "markdown-toc" },
        python = { "ruff_format", "ruff_organize_imports" },
        sh = { "shfmt" },
        terraform = { "terraform_fmt" },
        yaml = { "yamlfmt" },
        zsh = { "shfmt" },
      },
      formatters = {
        injected = { options = { ignore_errors = true } },
        prettier = {
          prepend_args = { "--prose-wrap", "always", "--print-width", "120" },
        },
        shfmt = {
          prepend_args = { "-i", "2", "-ci", "-bn" },
        },
      },
    },
  },
}
