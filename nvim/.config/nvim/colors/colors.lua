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
hi("Normal", { bg = "#0A0F2D" })
hi("NormalNC", { bg = "#0A0F2D" })
hi("EndOfBuffer", { bg = "#0A0F2D" })
hi("TabLine", { fg = "#FEEBEE", bg = "#0A0F2D", ctermfg = 244, ctermbg = 236 })
hi("TabLineSel", { fg = "#333333", bg = "#B6B6B6", ctermfg = 231, ctermbg = 240, bold = true })
hi("TabLineFill", { fg = "NONE", bg = "#0A0F2D", ctermfg = "NONE", ctermbg = 235 })
hi("CursorLine", { bg = "#222222" })
hi("VertSplit", { fg = "#FEEBEE", bg = "#0A0F2D" })
hi("StatusLine", { fg = "#333333", bg = "#b6b6b6", bold = true })
hi("StatusLineNC", { fg = "#333333", bg = "#b6b6b6" })

-- Você pode adicionar mais grupos de destaque aqui, como:
-- hi("Comment", { fg = "#57a64a", italic = true })
-- hi("String", { fg = "#569cd6" })
-- hi("Keyword", { fg = "#C586C0", bold = true })