return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = function()
        -- VS Code Dark+ Color Palette
        local colors = require("config.colors")
        ---@diagnostic disable: undefined-global
        -- Reset highlighting
        vim.cmd("highlight clear")
        if vim.fn.exists("syntax_on") then
          vim.cmd("syntax reset")
        end

        vim.o.termguicolors = true
        vim.o.background = "dark"
        vim.g.colors_name = "jrs"

        local hl = vim.api.nvim_set_hl

        -- Editor highlights
        hl(0, "Normal", { fg = colors.ui_fg, bg = colors.main_bg })
        hl(0, "NormalFloat", { fg = colors.ui_fg, bg = colors.main_bg })
        hl(0, "FloatBorder", { fg = colors.linenr_fg, bg = colors.main_bg })
        hl(0, "FloatTitle", { fg = colors.type, bg = colors.main_bg, bold = true })
        hl(0, "Cursor", { fg = colors.cursor_fg, bg = colors.cursor_bg }) -- Fg and Bg swapped for contrast
        hl(0, "CursorLine", { bg = colors.line_bg })
        hl(0, "CursorLineNr", { fg = colors.ui_fg, bold = true })
        hl(0, "LineNr", { fg = colors.linenr_fg })
        hl(0, "Visual", { bg = colors.selection_bg })
        hl(0, "VisualNOS", { bg = colors.selection_bg })
        hl(0, "Search", { fg = colors.main_bg, bg = colors.warning }) -- Yellow background for search
        hl(0, "IncSearch", { fg = colors.main_bg, bg = colors.type }) -- Cyan background for incsearch
        hl(0, "MatchParen", { fg = colors.error, bold = true })

        -- Syntax highlighting (Simplified to match VS Code feel)
        hl(0, "Comment", { fg = colors.comment_fg, italic = true })
        hl(0, "Constant", { fg = colors.number })
        hl(0, "String", { fg = colors.string })
        hl(0, "Character", { fg = colors.string })
        hl(0, "Number", { fg = colors.number })
        hl(0, "Boolean", { fg = colors.number })
        hl(0, "Float", { fg = colors.number })
        hl(0, "Identifier", { fg = colors.variable })
        hl(0, "Function", { fg = colors.function_name })
        hl(0, "Statement", { fg = colors.keyword })
        hl(0, "Conditional", { fg = colors.keyword })
        hl(0, "Repeat", { fg = colors.keyword })
        hl(0, "Label", { fg = colors.error })
        hl(0, "Operator", { fg = colors.operator })
        hl(0, "Keyword", { fg = colors.keyword })
        hl(0, "Exception", { fg = colors.error })
        hl(0, "PreProc", { fg = colors.type })
        hl(0, "Include", { fg = colors.type })
        hl(0, "Define", { fg = colors.type })
        hl(0, "Macro", { fg = colors.type })
        hl(0, "PreCondit", { fg = colors.type })
        hl(0, "Type", { fg = colors.type })
        hl(0, "StorageClass", { fg = colors.type })
        hl(0, "Structure", { fg = colors.type })
        hl(0, "Typedef", { fg = colors.type })
        hl(0, "Special", { fg = colors.type })
        hl(0, "SpecialChar", { fg = colors.type })
        hl(0, "Tag", { fg = colors.keyword })
        hl(0, "Delimiter", { fg = colors.operator })
        hl(0, "SpecialComment", { fg = colors.comment_fg, italic = true, bold = true })
        hl(0, "Debug", { fg = colors.error })
        hl(0, "Underlined", { underline = true })
        hl(0, "Error", { fg = colors.error, bold = true })
        hl(0, "Todo", { fg = colors.info, bold = true })

        -- UI elements
        hl(0, "StatusLine", { fg = colors.ui_fg, bg = colors.line_bg })
        hl(0, "StatusLineNC", { fg = colors.linenr_fg, bg = colors.main_bg })
        hl(0, "TabLine", { fg = colors.linenr_fg, bg = colors.line_bg })
        hl(0, "TabLineFill", { bg = colors.main_bg })
        hl(0, "TabLineSel", { fg = colors.keyword, bg = colors.main_bg, bold = true })
        hl(0, "Pmenu", { fg = colors.ui_fg, bg = colors.line_bg })
        hl(0, "PmenuSel", { fg = colors.ui_fg, bg = colors.selection_bg, bold = true })
        hl(0, "PmenuSbar", { bg = colors.selection_bg })
        hl(0, "PmenuThumb", { bg = colors.keyword })
        hl(0, "WildMenu", { fg = colors.main_bg, bg = colors.keyword })
        hl(0, "VertSplit", { fg = colors.line_bg })
        hl(0, "WinSeparator", { fg = colors.line_bg })
        hl(0, "Folded", { fg = colors.comment_fg, bg = colors.line_bg })
        hl(0, "FoldColumn", { fg = colors.comment_fg, bg = colors.main_bg })
        hl(0, "SignColumn", { fg = colors.comment_fg, bg = colors.main_bg })
        hl(0, "ColorColumn", { bg = colors.line_bg })

        -- Diff highlighting
        hl(0, "DiffAdd", { fg = colors.string, bg = colors.line_bg })
        hl(0, "DiffChange", { fg = colors.info, bg = colors.line_bg })
        hl(0, "DiffDelete", { fg = colors.error, bg = colors.line_bg })
        hl(0, "DiffText", { fg = colors.type, bg = colors.selection_bg, bold = true })

        -- Git signs
        hl(0, "GitSignsAdd", { fg = colors.string })
        hl(0, "GitSignsChange", { fg = colors.info })
        hl(0, "GitSignsDelete", { fg = colors.error })

        -- Diagnostic highlights
        hl(0, "DiagnosticError", { fg = colors.error })
        hl(0, "DiagnosticWarn", { fg = colors.warning })
        hl(0, "DiagnosticInfo", { fg = colors.info })
        hl(0, "DiagnosticHint", { fg = colors.type })
        hl(0, "DiagnosticUnderlineError", { undercurl = true, sp = colors.error })
        hl(0, "DiagnosticUnderlineWarn", { undercurl = true, sp = colors.warning })
        hl(0, "DiagnosticUnderlineInfo", { undercurl = true, sp = colors.info })
        hl(0, "DiagnosticUnderlineHint", { undercurl = true, sp = colors.type })

        -- LSP highlights (Using selection background for consistent look)
        hl(0, "LspReferenceText", { bg = colors.selection_bg })
        hl(0, "LspReferenceRead", { bg = colors.selection_bg })
        hl(0, "LspReferenceWrite", { bg = colors.selection_bg, underline = true })

        -- Treesitter highlights (Mapped to closest VS Code colors)
        hl(0, "@variable", { fg = colors.variable })
        hl(0, "@variable.builtin", { fg = colors.variable })
        hl(0, "@variable.parameter", { fg = colors.variable })
        hl(0, "@variable.member", { fg = colors.variable })
        hl(0, "@constant", { fg = colors.number })
        hl(0, "@constant.builtin", { fg = colors.number })
        hl(0, "@constant.macro", { fg = colors.type })
        hl(0, "@module", { fg = colors.type })
        hl(0, "@module.builtin", { fg = colors.type })
        hl(0, "@label", { fg = colors.error })
        hl(0, "@string", { fg = colors.string })
        hl(0, "@string.escape", { fg = colors.type })
        hl(0, "@string.special", { fg = colors.type })
        hl(0, "@string.regexp", { fg = colors.type })
        hl(0, "@character", { fg = colors.string })
        hl(0, "@character.special", { fg = colors.type })
        hl(0, "@boolean", { fg = colors.number })
        hl(0, "@number", { fg = colors.number })
        hl(0, "@number.float", { fg = colors.number })
        hl(0, "@type", { fg = colors.type })
        hl(0, "@type.builtin", { fg = colors.type })
        hl(0, "@type.definition", { fg = colors.type })
        hl(0, "@attribute", { fg = colors.type })
        hl(0, "@property", { fg = colors.function_name })
        hl(0, "@function", { fg = colors.function_name })
        hl(0, "@function.builtin", { fg = colors.function_name })
        hl(0, "@function.call", { fg = colors.function_name })
        hl(0, "@function.macro", { fg = colors.type })
        hl(0, "@function.method", { fg = colors.function_name })
        hl(0, "@function.method.call", { fg = colors.function_name })
        hl(0, "@constructor", { fg = colors.type })
        hl(0, "@operator", { fg = colors.operator })
        hl(0, "@keyword", { fg = colors.keyword })
        hl(0, "@keyword.coroutine", { fg = colors.keyword })
        hl(0, "@keyword.function", { fg = colors.keyword })
        hl(0, "@keyword.operator", { fg = colors.keyword })
        hl(0, "@keyword.import", { fg = colors.type })
        hl(0, "@keyword.conditional", { fg = colors.keyword })
        hl(0, "@keyword.repeat", { fg = colors.keyword })
        hl(0, "@keyword.return", { fg = colors.keyword })
        hl(0, "@keyword.exception", { fg = colors.error })
        hl(0, "@comment", { fg = colors.comment_fg, italic = true })
        hl(0, "@comment.documentation", { fg = colors.comment_fg, italic = true })
        hl(0, "@punctuation", { fg = colors.operator })
        hl(0, "@punctuation.bracket", { fg = colors.operator })
        hl(0, "@punctuation.delimiter", { fg = colors.operator })
        hl(0, "@punctuation.special", { fg = colors.type })
        hl(0, "@tag", { fg = colors.keyword })
        hl(0, "@tag.attribute", { fg = colors.type })
        hl(0, "@tag.delimiter", { fg = colors.operator })

        -- Terminal colors (VS Code default mapping)
        vim.g.terminal_color_0 = "#000000" -- Black
        vim.g.terminal_color_1 = "#CD3131" -- Red
        vim.g.terminal_color_2 = "#0DBC79" -- Green
        vim.g.terminal_color_3 = "#E5E510" -- Yellow
        vim.g.terminal_color_4 = "#2472C8" -- Blue
        vim.g.terminal_color_5 = "#BC3FBC" -- Magenta
        vim.g.terminal_color_6 = "#11A8CD" -- Cyan
        vim.g.terminal_color_7 = "#E5E5E5" -- White (light gray)
        vim.g.terminal_color_8 = "#666666" -- Bright Black (dark gray)
        vim.g.terminal_color_9 = "#F14C4C" -- Bright Red
        vim.g.terminal_color_10 = "#23D18B" -- Bright Green
        vim.g.terminal_color_11 = "#F5F543" -- Bright Yellow
        vim.g.terminal_color_12 = "#3B8EEA" -- Bright Blue
        vim.g.terminal_color_13 = "#D670D6" -- Bright Magenta
        vim.g.terminal_color_14 = "#29B8DB" -- Bright Cyan
        vim.g.terminal_color_15 = "#E7E7E7" -- Bright White (very light gray)

        -- Telescope and Neo-tree (Keeping a clean, VS Code-like look)
        hl(0, "TelescopeBorder", { fg = colors.linenr_fg })
        hl(0, "TelescopePromptBorder", { fg = colors.type })
        hl(0, "TelescopeResultsBorder", { fg = colors.linenr_fg })
        hl(0, "TelescopePreviewBorder", { fg = colors.function_name })
        hl(0, "TelescopeSelection", { fg = colors.ui_fg, bg = colors.selection_bg, bold = true })
        hl(0, "TelescopeMatching", { fg = colors.keyword, bold = true })

        hl(0, "NeoTreeNormal", { fg = colors.ui_fg, bg = colors.main_bg })
        hl(0, "NeoTreeDirectoryName", { fg = colors.type })
        hl(0, "NeoTreeDirectoryIcon", { fg = colors.type })
        hl(0, "NeoTreeFileName", { fg = colors.ui_fg })
        hl(0, "NeoTreeFileIcon", { fg = colors.linenr_fg })
        hl(0, "NeoTreeIndentMarker", { fg = colors.line_bg })
        hl(0, "NeoTreeRootName", { fg = colors.keyword, bold = true })
        hl(0, "NeoTreeGitModified", { fg = colors.info })
        hl(0, "NeoTreeGitAdded", { fg = colors.string })
        hl(0, "NeoTreeGitDeleted", { fg = colors.error })

      end,
    },
  },
 
}


