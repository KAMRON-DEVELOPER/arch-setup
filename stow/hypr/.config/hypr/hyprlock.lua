hl.config({
  hyprlock = {
    input_fields = {
      {
        monitor = "",
        size = { 60, 30 },
        outline_thickness = 0,
        dots_size = 0.25,
        dots_spacing = 0.15,
        inner_color = "rgb(50,50,66)",
        font_color = "rgb(184, 181, 239)",
        -- # font_family = "JetbrainsMono NF",
        fade_on_empty = false,
        placeholder_text = "",
        position = { "0", "15%" },
        valign = "bottom",
        halign = "center",
      },
    },

    backgrounds = {
      {
        monitor = "",
        path = "~/.wallpapers/arch.png",
        color = "rgb(30,30,46)",
        blur_passes = 2,
        blur_size = 4,
      },
    },
  },
})
