----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        -- If true disables the random hyprland logo / anime girl background. :(
        disable_hyprland_logo   = false,
        -- Enforce any of the 3 default wallpapers.
        -- Setting this to 0 or 1 disables the anime background. -1 means “random”. [-1/0/1/2]
        force_default_wallpaper = 1,
        middle_click_paste      = false
    },
})

--------------------------
----  COLORS  ------------
--------------------------
require("colors")

---------------------
----  SECTIONS  ----
---------------------
require("sections.environment_variables")
require("sections.monitors")
require("sections.input")
require("sections.look_and_feel")
require("sections.programs")
require("sections.permissions")

require("sections.keybindings")
require("sections.workspaces")
require("sections.windows_and_workspaces")

require("hypridle")
require("hyprlock")
require("hyprlauncher")
require("hyprpaper")
