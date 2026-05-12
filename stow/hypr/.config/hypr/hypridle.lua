hl.config({
  hypridle = {
    general = {
      lock_cmd = "hyprlock",
    },

    listeners = {
      {
        timeout = 60,
        on_timeout = "brightnessctl set 25",
        on_resume = "brightnessctl set 100%",
      },
      {
        timeout = 300,
        on_timeout = "brightnessctl set 0",
        on_resume = "brightnessctl set 100%",
      },
      {
        timeout = 600,
        on_timeout = "loginctl lock-session",
        on_resume = "brightnessctl set 100%",
      },
    },
  },
})
