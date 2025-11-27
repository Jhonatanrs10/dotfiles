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
hi("Normal", { bg = "#333333" })
hi("NormalNC", { bg = "#333333" })
hi("EndOfBuffer", { bg = "#333333" })
hi("TabLine", { fg = "#ffffff", bg = "#333333", ctermfg = 244, ctermbg = 236 })
hi("TabLineSel", { fg = "#333333", bg = "#ffffff", ctermfg = 231, ctermbg = 240, bold = true })
hi("TabLineFill", { fg = "NONE", bg = "#333333", ctermfg = "NONE", ctermbg = 235 })
hi("CursorLine", { bg = "#222222" })
hi("VertSplit", { fg = "#ffffff", bg = "#333333" })
hi("StatusLine", { fg = "#333333", bg = "#ffffff", bold = true })
hi("StatusLineNC", { fg = "#333333", bg = "#ffffff" })
hi("Comment", { fg = "#57a64a", italic = true })
hi("String", { fg = "#CE9178" })
hi("Keyword", { fg = "#C586C0", bold = true })
