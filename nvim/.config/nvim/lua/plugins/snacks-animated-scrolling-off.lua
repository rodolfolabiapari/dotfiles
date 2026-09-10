-- Desliga as animações de scroll do Snacks (scroll suave).
-- Prefiro scroll instantâneo, sem transição.

return {
  "folke/snacks.nvim",
  opts = {
    scroll = {
      enabled = false, -- Disable scrolling animations
    },
  },
}
