local dpi = Beautiful.xresources.apply_dpi

local button = Utils.widgets.button.elevated.normal({
  paddings = {
    left = Beautiful.widget_padding.inner * 0.8,
    right = Beautiful.widget_padding.inner * 0.8,
  },
  halign = "center",
  valign = "center",
  child = {
    widget = Wibox.widget.imagebox,
    halign = "center",
    valign = "center",
    -- image = Gears.color.recolor_image(Beautiful.icons .. "settings/home.svg", Beautiful.neutral[100]),
    image = Utils.apps_info:get_distro().icon or Beautiful.user_icon,
    clip_shape = Gears.shape.circle,
    forced_width = dpi(25),
    forced_height = dpi(25),
  },
  on_press = function()
    awesome.emit_signal("widgets::quicksettings", "toggle")
    -- if _G.qs_width then
    --   _G.qs_width = nil
    -- else
    --   _G.qs_width = dpi(400)
    -- end
  end,
})

return Wibox.widget({
  layout = Wibox.layout.fixed.horizontal,
  button,
})
