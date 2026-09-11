local lint_config = vim.fn.stdpath("config") .. "/markdownlint-cli2.yaml"

local markdownlint_cli2 = vim.deepcopy(require("lint.linters.markdownlint-cli2"))
markdownlint_cli2.args = { "--config", lint_config, "-" }

return {
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        dockerfile = { "hadolint" },
        markdown = { "markdownlint-cli2" },
        terraform = { "tflint" },
        tf = { "tflint" },
        yaml = { "yamllint" },
      },
      linters = {
        ["markdownlint-cli2"] = markdownlint_cli2,
      }
    }
  }
}
