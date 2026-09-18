-- Grupo which-key personalizados

-- Para modo diff
-- do/dp são mapeamentos nativos no Vim; aqui só adicionamos descrições no popoup

local diff_spec = {
  {
    cond = function()
      return vim.wo.diff
    end,
    mode = "n",
    { "d", group = "diff" },
    { "do", desc = "Diff Get (from other window)" },
    { "dp", desc = "Diff Put (to other window)" },
    { "d2o", desc = "Diff Get ours (Fugitive merge)" },
    { "d3o", desc = "Diff Get theirs (Fugitive merge)" },
    { "[c", desc = "Previous change" },
    { "]c", desc = "Next change" },
    { "[C", desc = "Previous change (no wrap)" },
    { "]C", desc = "Next change (no wrap)" },
    { "[h", desc = "Previous change (LazyVim / gitsigns)" },
    { "]h", desc = "Next change (LazyVim / gitsigns)" },
  },
}

local function register_diff_spec()
  require("which-key").add(diff_spec, { create = false })
end

return {
  {
    "folke/which-key.nvim",
    optional = true,
    opts_extend = { "spec" },
    opts = {
      spec = diff_spec,
    },
    init = function()
      vim.api.nvim_create_autocmd({ "OptionSet", "WinEnter" }, {
        group = vim.api.nvim_create_augroup("mine_which_key_diff", { clear = true }),
        callback = function()
          if not vim.wo.diff then
            return
          end
          register_diff_spec()
        end,
      })
    end,
  }
}
