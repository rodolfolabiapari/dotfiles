-- gitsigns.nvim: mostra mudanças do git na gutter (margem esquerda)
-- e permite stage/blame/navegação entre hunks (]c / [c).
-- Personaliza os símbolos usados na gutter.
return {
  -- https://github.com/lewis6991/gitsigns.nvim
  { -- Adds git related signs to the gutter, as well as utilities for managing changes
    "lewis6991/gitsigns.nvim",
    ---@module 'gitsigns'
    ---@type Gitsigns.Config
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      signs = {
        add = { text = "+" }, ---@diagnostic disable-line: missing-fields
        change = { text = "~" }, ---@diagnostic disable-line: missing-fields
        delete = { text = "_" }, ---@diagnostic disable-line: missing-fields
        topdelete = { text = "‾" }, ---@diagnostic disable-line: missing-fields
        changedelete = { text = "~" }, ---@diagnostic disable-line: missing-fields
      },
    },
  },
}
