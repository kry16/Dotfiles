-- pcall(require, "luarocks.loader")

-- Standard awesome library
Gears = require("gears")
Awful = require("awful")
Wibox = require("wibox")
Beautiful = require("beautiful")
Helpers = require("utils.helpers")
Naughty = require("naughty")
Dpi = Beautiful.xresources.apply_dpi

-- Naughty error notification
Naughty.connect_signal("request::display_error", function(message, startup)
	Naughty.notification({
		urgency = "critical",
		title = "ERROR, ocurrio un problema " .. (startup and " durante en arranque!" or "!"),
		message = message,
	})
end)

-- User configuration
User = {}

User.config = {
	dark_mode = false,
	dnd_state = false,
	modkey = "Mod4",
	theme = "yoru",
	theme_accent = "orange",
}

User.vars = {
	terminal = "kitty",
	editor = os.getenv("EDITOR") or "nano",
}

User.music_players = {
	{ player = "auto", name = "Auto" },
	{ player = "mpd", name = "Mpd" },
	{ player = "firefox", name = "Firefox" },
}
-- Desktop configuration
require("theme") -- Beautiful theme
require("config") -- AwesomeWM configuration files
require("signal") -- Awesome signal files
require("layout") -- UI configuration files
