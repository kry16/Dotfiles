-------------------------------------------
-- @author https://github.com/Kasper24
-- @copyright 2021-2022 Kasper24
-------------------------------------------
local gtable = require("gears.table")
local imagebox = require("wibox.widget.imagebox")
local beautiful = require("beautiful")
local dpi = beautiful.xresources.apply_dpi
-- local uncached = Gears.surface.load_uncached_silently
local recolor = Gears.color.recolor_image
local setmetatable = setmetatable
local ipairs = ipairs

local capi = {
  awesome = awesome,
}

local icon = {
  mt = {},
}

local properties = {
  "color",
  "on_color",
  "size",
  "icon",
}

local function build_properties(prototype, prop_names)
  for _, prop in ipairs(prop_names) do
    if not prototype["set_" .. prop] then
      prototype["set_" .. prop] = function(self, value)
        if self._private[prop] ~= value then
          self._private[prop] = value
          self:emit_signal("widget::redraw_needed")
          self:emit_signal("property::" .. prop, value)
        end
        return self
      end
    end
    if not prototype["get_" .. prop] then
      prototype["get_" .. prop] = function(self)
        return self._private[prop]
      end
    end
  end
end

local function generate_style(color)
  -- local style = [[
  --       rect {
  --           fill-rule=evenodd !important;
  --           stroke-width=1 !important;
  --           stroke: %s !important;
  --           fill: %s !important;
  --       }
  --       circle {
  --           fill-rule=evenodd !important;
  --           stroke-width=1 !important;
  --           stroke: %s !important;
  --           fill: %s !important;
  --       }
  --       path {
  --           fill-rule=evenodd !important;
  --           stroke-width=1 !important;
  --           stroke: %s !important;
  --           fill: %s !important;
  --       }
  --       text {
  --           fill-rule=evenodd !important;
  --           stroke-width=1 !important;
  --           stroke: %s !important;
  --           fill: %s !important;
  --       }
  --   ]]
  local style = [[
        path {
            stroke-width=1 !important;
            fill-rule=evenodd !important;
            stroke: %s !important;
            fill: %s !important;
        }
        text {
            stroke-width=1 !important;
            fill-rule=evenodd !important;
            stroke: %s !important;
            fill: %s !important;
        }
    ]]
  return string.format(style, color, color, color, color)
end

function icon:get_type()
  return "icon"
end

function icon:set_icon(_icon)
  local wp = self._private
  if _icon then
    wp.icon = _icon
    wp.defaults.color = _icon.color or wp.color
    if _icon and _icon.uncached then
      self:set_image(recolor(_icon.path, wp.defaults.color))
    else
      self.image = _icon.path
      self:set_stylesheet(generate_style(wp.defaults.color))
    end
  end
end

function icon:set_size(size)
  local wp = self._private
  wp.size = size
  self.forced_width = dpi(size)
  self.forced_height = dpi(size)
end

function icon:set_color(color)
  local wp = self._private
  wp.color = color or wp.icon.color or wp.color
  if wp.icon and wp.icon.uncached then
    self:set_image(recolor(wp.icon.path, wp.color))
  else
    self:set_stylesheet(generate_style(wp.color))
  end
end


function icon:update_display_color(color)
  local wp = self._private
  if wp.icon and wp.icon.uncached then
    self:set_image(recolor(wp.icon.path, color))
  else
    self:set_stylesheet(generate_style(color))
  end
end

local function new(...)
  local widget = imagebox()
  gtable.crush(widget, icon, true)

  local wp = widget._private

  -- Setup default values
  wp.defaults = {}
  wp.defaults.color = Beautiful.fg_normal
  wp.defaults.on_color = Beautiful.fg_normal
  wp.defaults.size = 16

  if wp.color then
    widget:set_color(wp.color)
  elseif wp.defaults.color then
    widget:set_color(wp.defaults.color)
  end

  widget:set_size(wp.defaults.size)

  return widget
end

function icon.mt:__call(...)
  return new(...)
end

build_properties(icon, properties)

return setmetatable(icon, icon.mt)
