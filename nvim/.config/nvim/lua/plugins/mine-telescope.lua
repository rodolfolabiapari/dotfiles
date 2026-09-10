-- telescope.nvim: fuzzy finder (arquivos, grep, buffers, git...).
-- ATENÇÃO: telescope está desabilitado aqui (enabled = false) porque o LazyVim
-- usa Snacks.picker no lugar. O bloco abaixo serve apenas como referência de
-- configuração caso reative o Telescope no futuro.

return {
  -- change some telescope options and a keymap to browse plugin files
  {
    "nvim-telescope/telescope.nvim",
    enabled = false,
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "top" },
        sorting_strategy = "ascending",
        winblend = 0,
      },
    },
  },
  {
    "nvim-telescope/telescope-fzf-native.nvim",
    enabled = false,
  },
  {
    "nvim-telescope/telescope-ui-select.nvim",
    enabled = false,
  },
}
