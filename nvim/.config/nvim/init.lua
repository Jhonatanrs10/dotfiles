-- theme & transparency
--vim.cmd.colorscheme("unokai")
vim.cmd.colorscheme("unokaibkp")
vim.cmd.colorscheme("colors")
--vim.api.nvim_set_hl(0, "Normal", { bg = "#333333" })
--vim.api.nvim_set_hl(0, "NormalNC", { bg = "#333333" })
--vim.api.nvim_set_hl(0, "EndOfBuffer", { bg = "#333333" })
--vim.api.nvim_set_hl(0, "TabLine", { fg = "#B6B6B6", bg = "#333333", ctermfg = 244, ctermbg = 236 })
--vim.api.nvim_set_hl(0, "TabLineSel", { fg = "#333333", bg = "#B6B6B6", ctermfg = 231, ctermbg = 240, bold = true })
--vim.api.nvim_set_hl(0, "TabLineFill", { fg = "NONE", bg = "#333333", ctermfg = "NONE", ctermbg = 235 })
--vim.api.nvim_set_hl(0, "CursorLine", { bg = "#222222" })
--vim.api.nvim_set_hl(0, "VertSplit", { fg = "#b6b6b6", bg = "#333333" })
--vim.api.nvim_set_hl(0, "StatusLine", { fg = "#333333", bg = "#b6b6b6", bold = true })
--vim.api.nvim_set_hl(0, "StatusLineNC", { fg = "#333333", bg = "#b6b6b6" })

-- Basic settings
vim.opt.number = true                              -- Line numbers
vim.opt.relativenumber = true                      -- Relative line numbers
vim.opt.cursorline = true                          -- Highlight current line
vim.opt.wrap = false                               -- Don't wrap lines
vim.opt.scrolloff = 10                             -- Keep 10 lines above/below cursor 
vim.opt.sidescrolloff = 8                          -- Keep 8 columns left/right of cursor

-- Search settings
vim.opt.ignorecase = true                          -- Case insensitive search
vim.opt.smartcase = true                           -- Case sensitive if uppercase in search
vim.opt.hlsearch = false                           -- Don't highlight search results 
vim.opt.incsearch = true                           -- Show matches as you type

-- vim.keymap.set('modo', 'atalho', 'comando', { opções })
vim.g.mapleader = ' '

-- Recarregar Configurações NeoVim
vim.keymap.set('n', '<leader>s', ':source %<CR>', { noremap = true, silent = true, desc = 'Recarregar arquivo de configuração' })

-- Atalhos Tabs
vim.keymap.set('n', '<leader><Up>', ':tabnew .<CR>', { noremap = true, silent = true, desc = 'Nova aba com explorador de arquivos' })
vim.keymap.set('n', '<leader><Down>', ':tabclose<CR>', { noremap = true, silent = true, desc = 'Fechar aba atual' })
vim.keymap.set('n', '<leader><Left>', ':tabprevious<CR>', { noremap = true, silent = true, desc = 'Aba anterior' })
vim.keymap.set('n', '<leader><Right>', ':tabnext<CR>', { noremap = true, silent = true, desc = 'Próxima aba' })
--vim.keymap.set('n', '<leader><Left><Left>', ':tabmove -1<CR>', { noremap = true, silent = true, desc = 'Mover aba para a esquerda' })
--vim.keymap.set('n', '<leader><Right><Right>', ':tabmove +1<CR>', { noremap = true, silent = true, desc = 'Mover aba para a direita' })

-- Atalhos Splits

vim.keymap.set('n', '<leader>hs', ':split<CR>', { noremap = true, silent = true, desc = 'Dividir janela horizontalmente' })
vim.keymap.set('n', '<leader>vs', ':vsplit<CR>', { noremap = true, silent = true, desc = 'Dividir janela verticalmente' })
vim.keymap.set('n', '<leader><C-Up>', '<C-w>k', { noremap = true, silent = true, desc = 'Mover para split acima' })
vim.keymap.set('n', '<leader><C-Down>', '<C-w>j', { noremap = true, silent = true, desc = 'Mover para split abaixo' })
vim.keymap.set('n', '<leader><C-Left>', '<C-w>h', { noremap = true, silent = true, desc = 'Mover para split à esquerda' })
vim.keymap.set('n', '<leader><C-Right>', '<C-w>l', { noremap = true, silent = true, desc = 'Mover para split à direita' })
vim.keymap.set('n', '<leader><S-Up>', '<C-w>K', { noremap = true, silent = true, desc = 'Mover split acima' })
vim.keymap.set('n', '<leader><S-Down>', '<C-w>J', { noremap = true, silent = true, desc = 'Mover split abaixo' })
vim.keymap.set('n', '<leader><S-Left>', '<C-w>H', { noremap = true, silent = true, desc = 'Mover split para a esquerda' })
vim.keymap.set('n', '<leader><S-Right>', '<C-w>L', { noremap = true, silent = true, desc = 'Mover split para a direita' })

-- Atalhos Close and Save
vim.keymap.set('n', '<leader><C-q>', ':q!<CR>', { noremap = true, silent = true, desc = 'Fechar buffer atual sem salvar' })
vim.keymap.set('n', '<leader>q', ':q<CR>', { noremap = true, silent = true, desc = 'Tenta fechar' })
vim.keymap.set('n', '<leader>w', ':w<CR>', { noremap = true, silent = true, desc = 'Salvar arquivo atual' })

-- Atalhos Ctrl c/v
vim.keymap.set('n', '<leader>z', 'u', { noremap = true, silent = true, desc = 'Desfazer (Undo)' })
vim.keymap.set('n', '<leader>x', '<C-r>', { noremap = true, silent = true, desc = 'Refazer (Redo)' })

-- Atalhos Terminal
vim.keymap.set('n', '<leader>t', ':tabnew term://bash<CR>', { noremap = true, silent = true, desc = 'Abrir nova aba de terminal' })
vim.keymap.set('t', '<leader><C-c>', '<C-\\><C-n>', { noremap = true, silent = true, desc = 'Sair do modo terminal (Leader+Ctrl+C)' })

-- Atalhos Find
vim.keymap.set('n', '<leader>f', '/', { noremap = true, silent = false, desc = 'Iniciar busca para frente' })

-- Atalhos Copy/Paste
vim.keymap.set({'n', 'v'}, '<leader>y', '"+y', { noremap = true, silent = true, desc = 'Copiar para o sistema (Leader+y)' })
vim.keymap.set('n', '<leader>p', '"+p', { noremap = true, silent = true, desc = 'Colar do sistema (Leader+p)' })
