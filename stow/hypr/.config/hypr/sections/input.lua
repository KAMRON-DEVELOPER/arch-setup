hl.config({
  input = {
    kb_layout = "us",
    kb_variant = "",
    kb_model = "",
    kb_options = "ctrl:nocaps",
    kb_rules = "",

    follow_mouse = 1,
    sensitivity = 0,

    touchpad = {
      natural_scroll = true,
    },
  },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.device({
  name = "epic-mouse-v1",
  sensitivity = -0.5,
})

hl.device({
  name = "yichip-2.4g-receiver-mouse",
  sensitivity = -0.5,
})

hl.window_rule({
  name = "chrome-touchpad-scroll-speed",
  match = { class = "google-chrome" },

  scroll_touchpad = 0.15,
})
