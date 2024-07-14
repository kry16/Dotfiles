local clock = Wibox.widget({
  widget = Wibox.widget.textclock,
  format = "%a %d, %H:%M",
  font = Beautiful.font_med_s,
})
local wbutton = Utils.widgets.button.elevated.normal
clock:set_text(clock:get_text():gsub("^%l", string.upper))
clock._timer:connect_signal("timeout", function()
  clock:set_text(clock:get_text():gsub("^%l", string.upper))
end)
local calendar_button = wbutton({
  child = clock,
  paddings = {
    right = Beautiful.widget_padding.inner,
    left = Beautiful.widget_padding.inner,
    top = Beautiful.widget_padding.inner * 0.45,
    bottom = Beautiful.widget_padding.inner * 0.45,
  },
  normal_border_color = Beautiful.widget_border.color,
  normal_border_width = Beautiful.widget_border.width,
  bg_normal = Beautiful.neutral[850],
  -- bg_normal = Beautiful.neutral[900],
  shape = Helpers.shape.rrect(Beautiful.radius),
  on_press = function()
    awesome.emit_signal("widgets::info_panel", "toggle")
  end,
})

return calendar_button