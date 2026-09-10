-- snacks.nvim: coleção de funcionalidades modulares do LazyVim:
-- - dashboard (tela inicial), indent (guias), picker (busca tipo Telescope),
-- - lazygit (<space>gg), notifier (notificações estilo VSCode),
-- - zen/zoom (<space>zz / <space>zm), scratchpad (<space>zs),
-- - statuscolumn (número+git na margem), rename (<space>cR),
-- - words (]] / [[ para pular referências), terminal, toggle, etc.
-- Scroll animations desligado (snacks-animated-scrolling-off.lua).

return {
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      dashboard = { enabled = true },
      explorer = { enabled = false },
      indent = { enabled = true },
      input = { enabled = true },
      notifier = {
        enabled = true,
        timeout = 4000,
        margin = { top = 0, right = 0, bottom = 1 },
        padding = true,
      },
      picker = { enabled = true },
      quickfile = { enabled = true },
      scratch = { enabled = true },
      lazygit = { enabled = true },
      scope = { enabled = true },
      rename = { enabled = true },
      scroll = { enabled = false },
      statuscolumn = { enabled = true },
      styles = {
        notification = { wo = { wrap = true } },
      },
      terminal = { enabled = true },
      toggle = { enabled = true },
      words = { enabled = true },
      zen = { enabled = true },
    },
    keys = {
      {
        "<leader>zz",
        function()
          Snacks.zen()
        end,
        desc = "Toggle Zen Mode",
      },
      {
        "<leader>zm",
        function()
          Snacks.zen.zoom()
        end,
        desc = "Zoom/Maximize Window",
      },
      {
        "<leader>zs",
        function()
          Snacks.scratch()
        end,
        desc = "Open Scratchpad",
      },
      {
        "<leader>gg",
        function()
          Snacks.lazygit()
        end,
        desc = "Lazygit UI",
      },
      {
        "<leader>gc",
        function()
          Snacks.picker.git_log()
        end,
        desc = "Git Commits (picker)",
      },
      {
        "<leader>gt",
        function()
          Snacks.picker.git_status()
        end,
        desc = "Git Status (picker)",
      },
      {
        "<leader>cR",
        function()
          Snacks.rename.rename_file()
        end,
        desc = "Rename File (LSP)",
      },
      {
        "]]",
        function()
          Snacks.words.jump(1, true)
        end,
        desc = "Next Reference",
      },
      {
        "[[",
        function()
          Snacks.words.jump(-1, true)
        end,
        desc = "Prev Reference",
      },
    },
  },
}
