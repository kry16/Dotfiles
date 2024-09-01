local modules = require(... .. ".modules")

return Wibox.widget({
    layout = Wibox.layout.grid,
    spacing = Beautiful.widget_spacing,
    orientation = "vertical",
    column_count = modules.template == "with_label" and 2 or 3,
    homogeneous = true,
    expand = true,
    modules.wifi_state,
    modules.dark_mode_state,
    modules.mute_state,
    modules.dnd_state,
    modules.nlight_state,
    modules.symphony_state
})
