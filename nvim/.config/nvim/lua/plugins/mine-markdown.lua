-- render-markdown.nvim: renderiza markdown inline (negrito/itálico/cabeçalho/
-- código ficam visuais no buffer, em vez do texto cru).
-- Configuração: código fica em bloco sem assinatura; cabeçalhos sem ícones;
-- checkboxes visuais.

return {
  {
    "MeanderingProgrammer/render-markdown.nvim",
    ft = { "markdown" },
    opts = {
      code = {
        sign = false,
        width = "block",
        right_pad = 1,
      },
      heading = {
        sign = false,
        icons = {},
      },
      checkbox = {
        enabled = true,
      },
    },
  },
}
