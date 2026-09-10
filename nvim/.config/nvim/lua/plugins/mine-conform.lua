-- Formata texto

return {
  {
    "stevearc/conform.nvim",
    opts = {
      format_on_save = false,
      formatters_by_ft = {
        bash = { "shfmt" },
        sh = { "shfmt" },
        zsh = { "shfmt" },
        hcl = { "terraform_fmt" },
        lua = { "stylua" },
        terraform = { "terraform_fmt" },
        ["terraform-vars"] = { "terraform_fmt" },
        python = { "ruff_format", "ruff_organize_imports", "black" },
      },
      formatters = {
        injected = { options = { ignore_erros = true } },
        shfmt = {
          prepend_args = { "-i", "2", "-ci", "-bn" },
        },
      },
    },
  },
}
