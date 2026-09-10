-- vim-fugitive: interface git completa dentro do vim (status, diff, blame,
-- log, commit, rebase) usando comandos G*.
-- Mapeia <space>gs/gd/gb/gl/gca/grb.

return {
  "tpope/vim-fugitive",
  cmd = { "G", "Git", "Gvdiff", "Gstatus", "Gblame", "Gcommit", "Gdiffsplit", "Gread" },
  keys = {
    { "<leader>gs", "<cmd>Git<cr>", desc = "Git Status" },
    { "<leader>gd", "<cmd>Gvdiffsplit<cr>", desc = "Git Diff (Vertical)" },
    { "<leader>gb", "<cmd>Git blame<cr>", desc = "Git Blame" },
    { "<leader>gl", "<cmd>Git log<cr>", desc = "Git Log" },
    { "<leader>gca", "<cmd>Git commit --all<cr>", desc = "Git Commit All" },
    { "<leader>grb", "<cmd>Git rebase -i<cr>", desc = "Git Rebase Interactive" },
  },
}
