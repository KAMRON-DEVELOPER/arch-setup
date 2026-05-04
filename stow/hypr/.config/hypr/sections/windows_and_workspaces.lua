local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name           = "suppress-maximize-events",
    match          = { class = ".*" },

    suppress_event = "maximize",
})

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name     = "fix-xwayland-drags",
    match    = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },

    move  = "20 monitor_h-120",
    float = true,
})

-- opacity rules
-- Set opacity to 1.0 active, 1.0 inactive and 0.8 fullscreen
hl.window_rule({
    match = { class = "code" },
    opacity = "1.0 override 1.0 override 1.0 override",
})

hl.window_rule({
    match = { class = "code-insiders" },
    opacity = "1.0 override 1.0 override 1.0 override",
})

hl.window_rule({
    match = { class = "dev.zed.Zed" },
    opacity = "1.0 override 1.0 override 1.0 override",
})
