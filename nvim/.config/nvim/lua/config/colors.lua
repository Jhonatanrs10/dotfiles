local colors = {
          -- Base colors (VS Code Dark+)
          main_bg = "#1E1E1E",     -- Main editor background
          selection_bg = "#7d7d7d", -- Selection background
          line_bg = "#2A2D2E",     -- Cursor line background
          ui_fg = "#ffffff",       -- Main text/UI foreground
          comment_fg = "#6A9955",  -- Comments

          -- Syntax/Semantic colors
          string = "#CE9178",      -- Strings
          number = "#B5CEA8",      -- Numbers, Booleans, Constants
          type = "#4EC9B0",        -- Types, Classes, Structs
          function_name = "#DCDCAA", -- Function names
          keyword = "#C586C0",     -- Keywords (if, else, return)
          variable = "#9CDCFE",    -- Variables
          operator = "#D4D4D4",    -- Operators
          error = "#F44747",       -- Errors/Diagnostics
          info = "#3b82f6",        -- Info/Hint (blue-ish)
          warning = "#F9A825",     -- Warnings (orange-ish)
          cursor_fg = "#1E1E1E",   -- Cursor foreground (to contrast with cursor bg)
          cursor_bg = "#AEAFAD",   -- Cursor background
          linenr_fg = "#858585",   -- Line number foreground
        }
        
return colors
