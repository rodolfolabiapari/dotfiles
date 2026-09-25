-- Atalhos (keymaps) personalizados, sobrepostos/complementares aos do LazyVim.
-- Grupo do leader: <space> + letra. Ex: <space>od abre a nota de hoje.
local map = vim.keymap.set

-- ===== Obsidian - navegacao e comandos do vault
-- Plugin: obisidian.nvim. Vault em config/local.lua -> obsidian_work_path.
map("n", "<leader>o<CR>", "<cmd>Obsidian<CR>", { desc = "Menu" })
map("n", "<leader>oa", "<cmd>Obsidian dailies -30<CR>", { desc = "Dailies" }) -- picker: últimos 30 dias
map("n", "<leader>ob", "<cmd>Obsidian backlinks<CR>", { desc = "Backlinks" })
map("n", "<leader>oc", "<cmd>Obsidian toc<CR>", { desc = "Table of Contents" })
map("n", "<leader>od", "<cmd>Obsidian today<CR>", { desc = "Today's Note" })
map("n", "<leader>og", "<cmd>Obsidian tags<CR>", { desc = "Tags" })
map("n", "<leader>on", "<cmd>Obsidian new_from_template<CR>", { desc = "New Note (From Template)" })
map("n", "<leader>oq", "<cmd>Obsidian quick_switch<CR>", { desc = "Quick Switch" })
map("n", "<leader>or", "<cmd>Obsidian rename<CR>", { desc = "Rename Note" })
map("n", "<leader>os", "<cmd>Obsidian search<CR>", { desc = "Search Notes" })
map("n", "<leader>ot", "<cmd>Obsidian template<CR>", { desc = "Template" })
map("n", "<leader>ow", "<cmd>Obsidian workspace<CR>", { desc = "Workspace" })
map("n", "<leader>ox", "<cmd>Obsidian template<CR>", { desc = "Insert Template" })
map("n", "<leader>oy", "<cmd>Obsidian yesterday<CR>", { desc = "Yesterday" })
map("n", "<leader>om", "<cmd>Obsidian tomorrow<CR>", { desc = "Tomorrow" })

-- ==== Obsidian - inserir data/hora no cursor
-- Só atua em buffers markdown. Formato YYYY-MM-DD-dia
-- alinhado ao date_format das dailyes notes no mine-obsidian.lua
local function insert_at_cursor(text)
  local row, col = unpack(vim.api.nvim_win_get_cursor(0))
  vim.api.nvim_buf_set_text(0, row - 1, col, row - 1, col, { text })
end

local markdown_fts = { markdown = true, ["markdown.mdx"] = true }

local function is_markdown()
  return markdown_fts[vim.bo.filetype] == true
end

-- <space>oi - insere data YYYY-MM-DD-dia
map({ "n", "i" }, "<leader>oi", function()
  if not is_markdown() then
    return
  end
  insert_at_cursor(os.date("%Y-%m-%d-%a"))
end, { desc = "Insert Date" })

-- <space>ol - insere wiki-link da data [[YYYY-MM-DD-dia]]
map({ "n", "i" }, "<leader>ol", function()
  if not is_markdown() then
    return
  end
  insert_at_cursor("[[" .. os.date("%Y-%m-%d-%a") .. "]]")
end, { desc = "Insert Daily Link" })

-- <space>oh - insere hora
map({ "n", "i" }, "<leader>oh", function()
  if not is_markdown() then
    return
  end
  insert_at_cursor(os.date("%H:%M"))
end, { desc = "Insert Time" })

-- Ctrl+d (insert mode) - atalho rápido para data
map("i", "<C-d>", function()
  if not is_markdown() then
    return
  end
  insert_at_cursor(os.date("%Y-%m-%d-%a"))
end, { desc = "Insert Date" })

-- ===== TreeSJ (juntar/separar objetos JSON/YAML em uma linha)
map("n", "<leader>jt", "<cmd>TSJToggle<CR>", { desc = "TreeSJ Toggle Join/Split" })
map("n", "<leader>js", "<cmd>TSJSplit<CR>", { desc = "TreeSJ Split" }) -- multilinha
map("n", "<leader>jj", "<cmd>TSJJoin<CR>", { desc = "TreeSJ Join" }) -- uma linha

-- ===== Formatação manual (conform) — o auto-format está desligado
-- Auto-format no save está desligado
map({ "n", "v" }, "<leader>cf", function()
  require("conform").format({ async = true, lsp_fallback = true })
end, { desc = "Format Buffer/Selection" })
