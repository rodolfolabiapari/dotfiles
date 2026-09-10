-- lualine.nvim: barra de status (modo, arquivo, git, LSP, etc).
-- Adiciona um emoji à seção x da barra só por diversão.

return {

  -- the opts function can also be used to change the default opts:
  {
    "nvim-lualine/lualine.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, {
        function()
          return "😄"
        end,
      })
    end,
  },
}
