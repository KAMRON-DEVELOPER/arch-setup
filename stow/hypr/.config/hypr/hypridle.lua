hl.hypridle({
  general = {
    lock_cmd = "hyprlock",
  },

  listeners = {
    {
      timeout = 600,
      on_timeout = "brightnessctl -s set 0",
      on_resume = "brightnessctl -r",
    },
    {
      timeout = 3600,
      on_timeout = "loginctl lock-session",
    },
  }
})
