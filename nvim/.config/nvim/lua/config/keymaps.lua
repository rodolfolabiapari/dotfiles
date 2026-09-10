-- Atalhos (keymaps) personalizados, sobrepostos/complementares aos do LazyVim.
-- Grupo do leader: <space> + letra. Ex: <space>od abre a nota de hoje.
local map = vim.keymap.set

-- ===== Obsidian (gerenciar notas/vault)
map("n", "<leader>o<CR>", "<cmd>Obsidian<CR>", { desc = "Obsidian Menu" })
map("n", "<leader>oa", "<cmd>Obsidian dailies -30<CR>", { desc = "Obsidian Dailies" })
map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Obsidian Backlinks" })
map("n", "<leader>oc", "<cmd>Obsidian toc<CR>", { desc = "Obsidian Table of Contents" })
map("n", "<leader>od", "<cmd>Obsidian today<CR>", { desc = "Obsidian Today's Note" })
map("n", "<leader>og", "<cmd>Obsidian tags<CR>", { desc = "Obsidian Tags" })
map("n", "<leader>on", "<cmd>Obsidian new<CR>", { desc = "Obsidian New Note" })
map("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Obsidian Quick Switch" })
map("n", "<leader>or", "<cmd>Obsidian rename<CR>", { desc = "Obsidian Rename Note" })
map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Obsidian Search Notes" })
map("n", "<leader>ot", "<cmd>Obsidian template<CR>", { desc = "Obsidian Template" })
map("n", "<leader>ow", "<cmd>Obsidian workspace<CR>", { desc = "Obsidian Workspace" })
map("n", "<leader>ox", "<cmd>Obsidian template<CR>", { desc = "Obsidian Insert Template" })
map("n", "<leader>oy", "<cmd>Obsidian yesterday<CR>", { desc = "Obsidian Yesterday" })

-- ===== TreeSJ (juntar/separar objetos JSON/YAML em uma linha)
map("n", "<leader>jt", "<cmd>TSJToggle<CR>", { desc = "TreeSJ Toogle Join/Split" })
map("n", "<leader>js", "<cmd>TSJSplit<CR>", { desc = "TreeSJ Split" })
map("n", "<leader>jj", "<cmd>TSJJoin<CR>", { desc = "TreeSJ Join" })

-- ===== Formatação manual (conform) — o auto-format está desligado
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Buffer/Selection" })
