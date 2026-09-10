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
        daily_notes = {
          folder = os.date("9dailies/%Y/%m"),
          -- date_format = "%d-%m-%yyyy",
          date_format = "%Y-%m-%d",
          alias_format = "%B %-d %a, %Y",
          default_tags = { "daily" },
          templates = {
            folder = "templates",
            date_format = "%Y-%m-%d",
            time_format = "%H:%M",
            substitutions = {},
          },
        },
        -- Essas duas linhas devem andar juntas
        new_notes_location = "notes_subdir",
        notes_subdir = "0inbox",
        templates = {
          folder = "templates",
          date_format = "%Y%m%d%H%M%S",
          time_format = "%H:%M",
        },
        -- GERADOR DE ID
        note_id_func = function(title)
          local suffix = ""
          if title ~= nil then
            suffix = title:gsub(" ", "-"):lower()
          end
          return os.date("%Y%m%d%H%M%S") .. "-" .. suffix
        end,
      }
    end,
  },
}
