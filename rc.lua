-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")
Gears = require("gears")
Awful = require("awful")
---@module 'wibox'
Wibox = require("wibox")
Beautiful = require("beautiful")
Naughty = require("naughty")

--- Error handling.
-- Notification library.
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config).
Naughty.connect_signal("request::display_error", function(message, startup)
  Naughty.notification({
    urgency = "critical",
    title = "ERROR, ocurrio un problema " .. (startup and " durante en arranque!" or "!"),
    message = message,
  })
end)

-- Allow Awesome to automatically focus a client upon changing tags or loading.
require("awful.autofocus")
-- Enable hotkeys help widget for VIM and other apps when client with a matching
-- name is opened:
require("awful.hotkeys_popup.keys")

User = require("config.user")
Helpers = require("utilities.helpers")

-- Load the theme. In other words, defines the variables within the `beautiful`
-- table.
---@module 'theme'
require("theme")

-- Treat all signals. Bear in mind this implies creating all tags, attaching
-- their layouts, setting client behavior and loading UI.
Utils = require("utilities")
Lib = require("lib")

-- Set all keybinds.
require("binds")

-- Load all client rules.
require("config")
Gears.timer({
  timeout = 5,
  call_now = true,
  autostart = true,
  single_shot = false,
  callback = function()
    collectgarbage("collect")
  end,
})
