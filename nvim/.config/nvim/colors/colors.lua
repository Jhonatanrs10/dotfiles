-- Função auxiliar para definir destaques
local hi = function(group, opts)
    vim.api.nvim_set_hl(0, group, opts)
end

-- Limpa os destaques padrão
vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
    vim.cmd("syntax reset")
end

vim.o.background = "dark"

-- Implementação dos destaques
hi("Normal", { bg = "#151A21" })
hi("NormalNC", { bg = "#151A21" })
hi("EndOfBuffer", { bg = "#151A21" })
hi("TabLine", { fg = "#DFDFDF", bg = "#151A21", ctermfg = 244, ctermbg = 236 })
hi("TabLineSel", { fg = "#151A21", bg = "#DFDFDF", ctermfg = 231, ctermbg = 240, bold = true })
hi("TabLineFill", { fg = "NONE", bg = "#151A21", ctermfg = "NONE", ctermbg = 235 })
hi("CursorLine", { bg = "#222222" })
hi("VertSplit", { fg = "#DFDFDF", bg = "#151A21" })
hi("StatusLine", { fg = "#151A21", bg = "#DFDFDF", bold = true })
hi("StatusLineNC", { fg = "#151A21", bg = "#DFDFDF" })
hi("Comment", { fg = "#57a64a", italic = true })
hi("String", { fg = "#CE9178" })
hi("Keyword", { fg = "#C586C0", bold = true })
