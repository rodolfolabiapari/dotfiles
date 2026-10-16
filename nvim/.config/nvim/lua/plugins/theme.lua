-- Omarchy theme when present; tokyonight fallback
local omarchy_path = vim.fn.expand("~/.local/state/omarchy/theme/neovim.lua")
local loader = vim.uv.fs_stat(omarchy_path) and loadfile(omarchy_path) or nil
if loader then
  return loader()
end

return {
  {
    "folke/tokyonight.nvim",
    priotity = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "tokyonight-night",
    },
  },
}
