local dpi = Beautiful.xresources.apply_dpi

local volume_btn = require("layout.qs-panel.mods.controls.muted-state")
local dnd_btn = require("layout.qs-panel.mods.controls.dnd-state")
local night_light_btn = require("layout.qs-panel.mods.controls.night-light")
local dark_mode_btn = require("layout.qs-panel.mods.controls.dark-mode")
local wifi_btn = require("layout.qs-panel.mods.controls.wifi-state")
local bluetooth_btn = require("layout.qs-panel.mods.controls.bluetooth-state")
local floating_btn = require("layout.qs-panel.mods.controls.floating-mode")
local screenshot_btn = require("layout.qs-panel.mods.controls.screenshots")
local music_notify_btn = require("layout.qs-panel.mods.controls.music-alert")
local monitors = require("layout.qs-panel.mods.monitors")

local controls = Wibox.widget({
  layout = Wibox.layout.fixed.vertical,
  spacing = dpi(10),
  {
    layout = Wibox.layout.flex.vertical,
    spacing = dpi(10),
    {
      layout = Wibox.layout.flex.horizontal,
      spacing = dpi(10),
      wifi_btn,
      volume_btn,
    },
    {
      layout = Wibox.layout.flex.horizontal,
      spacing = dpi(10),
      bluetooth_btn,
      music_notify_btn,
    },
  },
  {
    layout = Wibox.layout.flex.horizontal,
    spacing = dpi(10),
    {
      widget = Wibox.container.background,
      bg = Beautiful.quicksettings_widgets_bg,
      shape = Beautiful.quicksettings_widgets_shape,
      {
        widget = Wibox.container.margin,
        margins = dpi(10),
        {
          layout = Wibox.layout.flex.vertical,
          spacing = dpi(10),
          screenshot_btn.button,
          {
            layout = Wibox.layout.flex.horizontal,
            spacing = dpi(10),
            dark_mode_btn,
            floating_btn,
          },
          {
            layout = Wibox.layout.flex.horizontal,
            spacing = dpi(10),
            dnd_btn,
            night_light_btn,
          },
        },
      },
    },
    {
      layout = Wibox.layout.stack,
      monitors,
      screenshot_btn.settings,
    },
  },
  -- screenshot_btn,
})

screenshot_btn:connect_signal("visible::settings", function(self, vis)
  screenshot_btn.settings.visible = vis
end)

return controls
