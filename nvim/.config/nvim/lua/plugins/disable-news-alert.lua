-- Desliga os pop-ups de "novidades" do LazyVim e do neovim que aparecem
-- na primeira inicialização após atualização.

return {
  "LazyVim/LazyVim",
  opts = {
    news = {
      lazyvim = false,
      neovim = false,
    },
  },
}
