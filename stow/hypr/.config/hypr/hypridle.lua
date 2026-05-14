hl.config({
  hypridle = {
    general = {
      lock_cmd = "hyprlock",
    },

    listeners = {
      {
        timeout = 300,
        on_timeout = "brightnessctl set 25",
        on_resume = "brightnessctl set 100%",
      },
      {
        timeout = 600,
        on_timeout ="hyprlock",
        on_resume = "brightnessctl set 100%",
      },
      {
        timeout = 1800,
        on_timeout ="systemctl sleep",
        on_resume = "hyprlock",
      },
    },
  },
})
