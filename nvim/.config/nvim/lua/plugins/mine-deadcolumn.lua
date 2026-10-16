-- deadcolumn.nvim
-- requer vim.opt.colorcolumn > 0 (options.lua)

return {
  {
    "Bekaboo/deadcolumn.nvim",
    event = { "InsertEnter", "WinEnter" },
    opts = {
      extra = {
        -- mantem colorcolumn sincronizado com o textwidth
        follow_tw = "+0"
      },
    },
  },
}
