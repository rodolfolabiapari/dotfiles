-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.keymap.set

-- Obsidian
map("n", "<leader>o<CR>", "<cmd>Obsidian<CR>", { desc = "Obsidian Menu" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "" })
map("n", "<leader>oc", "<cmd>Obsidian toc<CR>", { desc = "" })
map("n", "<leader>od", "<cmd>Obsidian today<CR>", { desc = "" })
map("n", "<leader>og", "<cmd>Obsidian tags<CR>", { desc = "" })
map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "" })
map("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "" })
map("n", "<leader>or", "<cmd>Obsidian rename<CR>", { desc = "" })
map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "" })
map("n", "<leader>ow", "<cmd>Obsidian workspace<CR>", { desc = "" })
map("n", "<leader>ox", "<cmd>Obsidian template<CR>", { desc = "" })
map("n", "<leader>oy", "<cmd>Obsidian dailies -30<CR>", { desc = "" })

-- TreeSJ
map("n", "<leader>j", "<cmd>TSJToogle<CR>", { desc = "TreeSJ Toogle Join/Split" })
map("n", "<leader>j", "<cmd>TSJSplit<CR>", { desc = "TreeSJ Split" })
map("n", "<leader>j", "<cmd>TSJJoin<CR>", { desc = "TreeSJ Join" })

-- Format (comfort)
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Buffer/Selection" })
