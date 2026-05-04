-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/


hl.on("hyprland.start", function()
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("hyprlock")
    -- hl.exec_cmd("hyprpaper")
    hl.exec_cmd("waypaper --restore")
    -- hl.exec_cmd("waybar")
    hl.exec_cmd("ashell")
    -- hl.exec_cmd("walker --gapplication-service")
end)

