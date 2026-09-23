-- obsidian.nvim: gerencia vaults do Obsidian dentro do Neovim: daily notes,
-- links [[wiki]], busca de notas, templates, workspace sync.
-- Lê a chave obsidian_work_path de lua/config/local.lua (não versionado)
-- ou usa ~/Documents/obsidian/personal/ como fallback.

-- Carrega configuração local (por máquina) se existir
local function local_config()
  local ok, cfg = pcall(require, "config.local")
  if ok then
    return cfg
  end
  return {}
end

return {
  {
    -- https://deepwiki.com/obsidian-nvim/obsidian.nvim/2.3-basic-usage
    "obsidian-nvim/obsidian.nvim",
    version = "*",
    lazy = true,
    ft = "markdown",
    event = { "VimEnter" },
    dependencies = { "nvim-lua/plenary.nvim" },
    ---@module "obsidian"
    ---@type obsidian.config
    opts = function()
      local cfg = local_config()
      local obsidian_path = cfg.obsidian_work_path or (vim.fn.expand("~") .. "/Documents/obsidian/personal/")

      return {
        workspaces = {
          {
            name = "main",
            path = obsidian_path,
          },
        },
        legacy_commands = false,
        ui = {
          ignore_conceal_warn = true,
          enable = true,
        },

        -- Nomes legíveis a partir do título (sem timestamp)
        note_id_func = require("obsidian.builtin").title_id,

        -- Essas duas linhas devem andar juntas
        new_notes_location = "notes_subdir",
        notes_subdir = "References",

        daily_notes = {
          folder = "Journal/Daily",
          date_format = "YYYY/MM/YYYY-MM-DD-ddd",
          alias_format = nil,
          default_tags = {},
          template = "System/Daily-Note-Template.md",
        },

        templates = {
          enabled = true,
          folder = "System/Templates",
          date_format = "YYYY-MM-DD-ddd",
          time_format = "HH:mm:ss",
        },

        -- Evita :Obsidian unique_note riar arquivos com timestamp
        unique_note = {
          enabled = false,
        }
      }
    end,
  },
}
