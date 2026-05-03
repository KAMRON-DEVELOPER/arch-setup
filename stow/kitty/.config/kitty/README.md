# Kitty

* [Kitty](https://sw.kovidgoyal.net/kitty/)
* [Quickstart](https://sw.kovidgoyal.net/kitty/quickstart/)
* [Overview](https://sw.kovidgoyal.net/kitty/overview/)
* [Configuring kitty](https://sw.kovidgoyal.net/kitty/conf/)

The easiest way to select fonts is to run the kitten `choose-fonts` command which
will present a nice UI
for you to select the fonts you want with previews and support for selecting
variable fonts and font features

```bash
kitten choose-fonts
kitten themes
```

some keymaps:

* map cmd+q quit - Quit kitty
  
* map ctrl+shift+f10 toggle_maximized - Toggle maximized
* map ctrl+shift+f11 toggle_fullscreen - Toggle fullscreen
  
* map ctrl+shift+f1 show_kitty_doc overview - Show documentation
  
* map ctrl+shift+f5 load_config_file - Reload kitty.conf

* map ctrl+shift+a>d set_background_opacity default - Reset background opacity
* map ctrl+shift+a>m set_background_opacity +0.1 - Increase background opacity
* map ctrl+shift+a>l set_background_opacity -0.1 - Decrease background opacity

* map ctrl+shift+f2 edit_config_file - Edit config file

* map ctrl+shift+backspace change_font_size all 0 - Reset font size
* map ctrl+shift+equal change_font_size all +2.0 - Increase font size
* map ctrl+shift+plus change_font_size all +2.0 - Increase font size
* map ctrl+shift+kp_add change_font_size all +2.0 - Increase font size
* map ctrl+shift+minus change_font_size all -2.0 - Decrease font size
* map ctrl+shift+kp_subtract change_font_size all -2.0 - Decrease font size

* map ctrl+shift+q close_tab - Close tab
* map ctrl+shift+t new_tab - New tab
* map ctrl+shift+right next_tab - Next tab
* map ctrl+shift+left previous_tab - Previous tab
* map ctrl+shift+. move_tab_forward - Move tab forward
* map ctrl+shift+, move_tab_backward - Move tab backward
* map ctrl+shift+alt+t set_tab_title - Set tab title

* map ctrl+shift+l next_layout - Next layout

* map ctrl+shift+w close_window - Close window
* map ctrl+shift+enter new_window - New window

* map ctrl+shift+up scroll_line_up - Scroll line up
* map ctrl+shift+k scroll_line_up - Scroll line up
* map ctrl+shift+down scroll_line_down - Scroll line down
* map ctrl+shift+j scroll_line_down - Scroll line down
