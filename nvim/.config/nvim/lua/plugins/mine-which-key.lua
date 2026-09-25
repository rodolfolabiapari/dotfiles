-- Grupo which-key personalizados

-- mini.surround - prefixo gs (sem <space>)
local surround_spec = {
  {
    mode = { "n", "x" },
    { "gs", group = "Surround" },
    { "gsa", desc = "Adicionar par (` \" ( [ {)" },
    { "gsd", desc = "Remove par ao redor do cursor" },
    { "gsr", desc = "Troca par (gsr + antigo + novo, ex.: gsr\"')" },
    { "gsf", desc = "Ir para o próximo par" },
    { "gsF", desc = "Ir para o par anterior" },
    { "gsh", desc = "Destacar par ao redor do cursor" },
    { "gsn", desc = "Ajustar quantas linhas o Surround busca" },
  },
}

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
      spec = vim.list_extend(vim.deepcopy(surround_spec), diff_spec),
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
  },
}
