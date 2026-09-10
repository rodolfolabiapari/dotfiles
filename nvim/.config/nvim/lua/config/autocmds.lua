-- Eventos automáticos (autocmds) carregados no evento VeryLazy
-- Remove o grupo padrão do LazyVim que liga spell+wrap pra markdown/gitcommit
-- (substituímos abaixo só com spell, sem o wrap).

vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Liga corretor ortográfico pt+en só em markdown e gitcommit
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("mine_spell", { clear = true }),
  pattern = { "markdown", "gitcommit" },
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = { "pt", "en" }
  end,
})
