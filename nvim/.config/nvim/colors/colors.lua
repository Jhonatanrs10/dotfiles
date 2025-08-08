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
hi("Normal", { bg = "#3B3F57" })
hi("NormalNC", { bg = "#3B3F57" })
hi("EndOfBuffer", { bg = "#3B3F57" })
hi("TabLine", { fg = "#F7F8FC", bg = "#3B3F57", ctermfg = 244, ctermbg = 236 })
hi("TabLineSel", { fg = "#3B3F57", bg = "#F7F8FC", ctermfg = 231, ctermbg = 240, bold = true })
hi("TabLineFill", { fg = "NONE", bg = "#3B3F57", ctermfg = "NONE", ctermbg = 235 })
hi("CursorLine", { bg = "#222222" })
hi("VertSplit", { fg = "#F7F8FC", bg = "#3B3F57" })
hi("StatusLine", { fg = "#3B3F57", bg = "#F7F8FC", bold = true })
hi("StatusLineNC", { fg = "#3B3F57", bg = "#F7F8FC" })
hi("Comment", { fg = "#57a64a", italic = true })
hi("String", { fg = "#CE9178" })
hi("Keyword", { fg = "#C586C0", bold = true })
