-- blink.cmp: quantos caracteres da palavra antes de abrir o menu de sugestões
return {
  {
    "saghen/blink.cmp",
    opts = {
      sources = {
        -- Global (teste futuro): descomantar e comentar o abaixo
        -- min_keyboard_length = 2,

        min_keyboard_length = function ()
          local ft = vim.bo.filetype
          if ft == "markdown" or ft == "markdown.mdx" then
            return 2
          end
          return 0
        end,
      },
    },
  },
}
