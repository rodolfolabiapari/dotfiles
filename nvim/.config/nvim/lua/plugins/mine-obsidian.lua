return {
  -- https://deepwiki.com/obsidian-nvim/obsidian.nvim/2.3-basic-usage
  "obsidian-nvim/obsidian.nvim",
  version = "*",
  lazy = true,
  ft = "markdown",
  event = {
    "VimEnter",
  },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ---@module 'obsidian'
  ---@type obsidian.config
  opts = {
    workspaces = {
      {
        name = "main",
        path = "~/Documents/obsidian/personal/",
      },
    },
    legacy_commands = false,
    ui = {
      ignore_conceal_warn = true,
      enable = true,
    },
    completion = {
      blink = true,
      min_chars = 0,
    },
    daily_notes = {
      folder = os.date("9dailies/%Y-%m"),
      date_format = "%d-%m-%yyyy",
      alias_format = "%B %-d %a, %Y",
      default_tags = { "daily" },
      templates = {
        folder = "7templates",
        date_format = "%Y-%m-%d",
        time_format = "%H:%M",
        substitutions = {},
      },
    },

    -- Essas duas linhas devem andar juntas
    new_notes_location = "notes_subdir",
    notes_subdir = "0inbox",

    templates = {
      folder = "7templates",
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
  },
}
