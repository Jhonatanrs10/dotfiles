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
hi("Normal", { bg = "#1E1E1E" })
hi("NormalNC", { bg = "#1E1E1E" })
hi("EndOfBuffer", { bg = "#1E1E1E" })
hi("TabLine", { fg = "#ffffff", bg = "#1E1E1E", ctermfg = 244, ctermbg = 236 })
hi("TabLineSel", { fg = "#1E1E1E", bg = "#ffffff", ctermfg = 231, ctermbg = 240, bold = true })
hi("TabLineFill", { fg = "NONE", bg = "#1E1E1E", ctermfg = "NONE", ctermbg = 235 })
hi("CursorLine", { bg = "#222222" })
hi("VertSplit", { fg = "#ffffff", bg = "#1E1E1E" })
hi("StatusLine", { fg = "#1E1E1E", bg = "#ffffff", bold = true })
hi("StatusLineNC", { fg = "#1E1E1E", bg = "#ffffff" })
hi("Comment", { fg = "#57a64a", italic = true })
hi("String", { fg = "#CE9178" })
hi("Keyword", { fg = "#C586C0", bold = true })
