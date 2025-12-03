-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- Cria um Autocommand para aplicar o tema após a inicialização
vim.api.nvim_create_autocmd("VimEnter", {
  desc = "Aplica o colorscheme 'lazy_colors' na inicialização",
  callback = function()
    -- Garante que o comando seja executado quando o Neovim estiver pronto
    vim.cmd.colorscheme("lazy_colors")
  end,
  -- Garante que ele só rode uma vez, na entrada do Vim
  once = true,
})