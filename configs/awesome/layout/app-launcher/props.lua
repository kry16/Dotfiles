local dpi = Beautiful.xresources.apply_dpi
local color_lib = Helpers.color
local hover_color = color_lib.lightness(
  color_lib.isDark(Beautiful.accent_color) and "lighten" or "darken",
  Beautiful.color_method_factor,
  Beautiful.accent_color
)
return {
  save_history = false,
  favorites = { "kitty", "firefox" },
  skip_empty_icons = false,
  shape = Helpers.shape.rrect(Beautiful.small_radius),
  placement = function(c)
    Helpers.placement(c, "top_left", nil, Beautiful.useless_gap * 2)
  end,
  border_color = color_lib.lightness(Beautiful.color_method, Beautiful.color_method_factor / 2, Beautiful.widget_bg),
  border_width = 0,
  background = Beautiful.widget_bg,
  icon_size = 48,
  apps_spacing = dpi(6),
  default_app_icon_name = "default-application",
  app_show_icon = true,
  app_name_halign = "left",
  apps_per_row = 7,
  apps_per_column = 1,
  apps_margin = 0,
  -- app_height = Dpi(24),
  app_icon_width = dpi(28),
  app_icon_height = dpi(28),
  app_width = dpi(260),
  app_shape = Helpers.shape.rrect(Beautiful.small_radius),
  app_content_spacing = dpi(7),
  app_content_padding = {
    left = dpi(6),
    right = dpi(6),
    bottom = dpi(4),
    top = dpi(4),
  },
  app_normal_color = Beautiful.widget_bg_color,
  app_normal_hover_color = Beautiful.widget_bg_alt,
  app_selected_color = Beautiful.accent_color,
  app_selected_hover_color = hover_color,
  app_name_selected_color = Beautiful.foreground_alt,
  app_name_normal_color = Beautiful.foreground .. "6F",
  app_name_font = Beautiful.font_text .. "Medium 11",
  prompt_image_bg_ratio = 3,
  prompt_image_bg_height = dpi(130),
  prompt_image_bg_shape = Helpers.shape.rrect(Beautiful.small_radius),
  prompt_height = dpi(40),
  prompt_margins = 0,
  prompt_paddings = {
    left = dpi(12),
    right = dpi(10),
  },
  prompt_text = "",
  prompt_icon = "󰕰", -- 󰍉
  prompt_shape = Helpers.shape.rrect(Beautiful.small_radius),
  prompt_icon_font = Beautiful.font_icon .. "8",
  prompt_font = Beautiful.font_text .. "Medium 12",
  prompt_color = Beautiful.widget_bg_alt,
  prompt_text_color = Beautiful.foreground .. "EE",
  prompt_icon_color = Beautiful.accent_color .. "DF",
  prompt_cursor_color = Beautiful.foreground .. "bb",
  prompt_separator_size = dpi(2),
  prompt_separator_color = Beautiful.accent_color,
  grid_margins = dpi(6),
  grid_spacing = dpi(6),
}
