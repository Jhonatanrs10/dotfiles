-- https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/


local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule

hl.window_rule({
    name  = "amberol",
    match = { class = "io.bassi.Amberol" },
    size = {360, 660},
    float = true,
    center = true,
})

hl.window_rule({
    name  = "galculator",
    match = { class = "galculator" },
    size = {314, 351},
    float = true,
    center = true,
})

hl.window_rule({
    name  = "rename",
    match = { title = "Rename.*" },
    size = {461, 129},
    float = true,
    center = true,
    stay_focused = true,
})

hl.window_rule({
    name  = "open-folder",
    match = { title = "Open Folder" },
    size = {750, 450},
    float = true,
    center = true,
    stay_focused = true,
})

hl.window_rule({
    name  = "idle-fullscreen",
    match = { class = ".*" },
    idle_inhibit = "fullscreen",
})