-- treesj: expandir um objeto JSON/YAML que está numa linha só em várias linhas
-- (e vice-versa). Comandos: TSJSplit (<space>js) e TSJJoin (<space>jj).

return {
  {
    "Wansmer/treesj",
    cmd = { "TSJToggle", "TSJSplit", "TSJJoin" },
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      use_default_keymaps = false,
    },
  },
}
