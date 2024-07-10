local wbutton = Utils.widgets.button.elevated
local wtext = Utils.widgets.text
local dpi = Beautiful.xresources.apply_dpi
local recolor = Gears.color.recolor_image -- TODO: replace for `set_stylesheet` method
local settings_icon = Beautiful.icons .. "settings/arrow_right.svg"
local templates = {}

local style = {
   shape = Helpers.shape.rrect(Beautiful.radius),
   shape_circle = Gears.shape.circle,
   -- shape = Gears.shape.rounded_bar,
   border_color = Beautiful.widget_border.color,
   border_width = Beautiful.widget_border.width,
   bg_normal = Beautiful.neutral[850],
   -- bg_normal = Helpers.color.blend(Beautiful.neutral[850], Beautiful.neutral[800]),
   -- bg_hover = Beautiful.neutral[700],
   -- bg_press = Beautiful.neutral[800],
   bg_normal_on = Beautiful.primary[500],
   settings_bg = Beautiful.primary[500],
   icon_normal = Beautiful.neutral[100],
   icon_off = Beautiful.neutral[100],
}

if not Helpers.color.isDark(style.bg_normal_on) then
   -- if Beautiful.type == "light" then
   -- style.icon_on = Beautiful.neutral[200]
   -- else
   style.icon_on = Beautiful.neutral[900]
   -- end
else
   if Beautiful.type == "light" then
      style.icon_on = Beautiful.neutral[900]
   else
      style.icon_on = Beautiful.neutral[200]
   end
end

---Defaults values
---@param opts table
local function default(opts)
   ---@class opts
   ---@field icon_on? string|userdata icon on path
   ---@field icon_off? string|userdata icon off path (override opts.icon)
   ---@field icon? string|userdata icon (for normal type)
   ---@field icon_size? integer icon size
   ---@field padding? table|integer padding for icon image
   ---@field border_width? integer border width for button
   ---@field shape? function shape for button
   ---@field fn_on? function function to turn on button
   ---@field fn_off? function function to turn off button
   opts = opts or {}
   if not opts.icon and not opts.icon_off then
      Naughty.notification({
         title = "Error",
         text = "Icon required",
         urgency = "critical",
      })
      return Wibox.widget({})
   end
   opts.icon = recolor(opts.icon, style.icon_normal)
   opts.icon_size = opts.icon_size or dpi(18)
   opts.padding = opts.padding or Beautiful.widget_padding.inner * 0.75
   opts.border_width = opts.border_width or style.border_width
   if opts.shape == "none" then
      opts.shape = nil
   else
      opts.shape = opts.shape or style.shape
   end
   return opts
end

-- function templates:set_icon(wdg, icon, for_state, color)
--    if for_state then
--       if wdg:get_state() then
--          Helpers.gc(wdg, "icon_role"):set_image(recolor(icon, style.icon_on))
--       else
--          Helpers.gc(wdg, "icon_role"):set_image(recolor(icon, style.icon_off))
--       end
--    else
--       Helpers.gc(wdg, "icon_role"):set_image(recolor(icon, color))
--    end
-- end

---Return button with only icon for quicksettings panel
---@class QSButton
---@param opts opts_icons:opts
function templates.only_icon(opts)
   ---@class opts_icons:opts
   ---@field type? string type of button (state,normal)
   ---@field on_press? function button action when pressed
   opts = default(opts)
   local button_main

   local icon_off = opts.icon_off or opts.icon
   local icon_on = opts.icon_on or opts.icon
   local button_main_icon = Wibox.widget({
      widget = Wibox.widget.imagebox,
      image = icon_off,
      -- resize =false,
      forced_width = opts.icon_size,
      forced_height = opts.icon_size,
      halign = "center",
      valign = "center",
   })
   if opts.type == "state" then
      ---@class OnlyIcon:QSButton
      button_main = wbutton.state({
         -- paddings = Beautiful.widget_padding.outer,
         -- constraint_width = dpi(42),
         -- constraint_height = dpi(42),
         -- constraint_strategy = "exact",
         paddings = opts.padding,
         halign = "center",
         valign = "center",
         child = button_main_icon,
         bg_normal = style.bg_normal,
         bg_hover = style.bg_hover,
         bg_press = style.bg_press,
         bg_normal_on = style.bg_normal_on,
         shape = opts.shape,
         border_width = opts.border_width,
         normal_border_color = style.border_color,
         on_turn_on = opts.fn_on,
         on_turn_off = opts.fn_off,
      })
   else
      ---@class OnlyIcon:QSButton
      button_main = wbutton.normal({
         -- paddings = Beautiful.widget_padding.outer,
         paddings = opts.padding,
         constraint_width = opts.width,
         constraint_height = opts.height,
         constraint_strategy = opts.strategy,
         halign = "center",
         valign = "center",
         child = button_main_icon,
         bg_normal = style.bg_normal,
         bg_hover = style.bg_hover,
         bg_press = style.bg_press,
         shape = opts.shape,
         normal_border_width = style.border_width,
         normal_border_color = style.border_color,
         on_press = opts.on_press,
      })
   end
   button_main:connect_signal("state", function(_, new_state)
      if new_state then
         button_main_icon:set_image(recolor(icon_on, style.icon_on))
      else
         button_main_icon:set_image(recolor(icon_off, style.icon_off))
      end
   end)
   return button_main
end

---Return button with label for quicksettings panel
---@class QSButton
---@param opts opts_label:opts
function templates.with_label(opts)
   ---@class opts_label:opts
   ---@field label string label for button
   ---@field settings? function to open settings
   ---@field show_state? boolean show state of button (On,Off)
   opts = default(opts)
   local label_state, button_settings
   local icon_off = opts.icon_off or opts.icon
   local icon_on = opts.icon_on or opts.icon
   local button_main_icon = Wibox.widget({
      widget = Wibox.widget.imagebox,
      image = icon_off,
      forced_width = opts.icon_size,
      forced_height = opts.icon_size,
      halign = "center",
      valign = "center",
   })
   local label = wtext({
      text = opts.label,
      font = Beautiful.font_med_s,
      color = style.icon_normal,
      halign = "left",
      valign = "center",
      no_size = true,
   })
   local button_settings_icon = Wibox.widget({
      widget = Wibox.widget.imagebox,
      image = recolor(settings_icon, style.icon_normal),
      forced_width = dpi(16),
      forced_height = dpi(16),
      halign = "center",
      valign = "center",
   })
   if opts.show_state then
      label_state = wtext({
         text = "Apagado",
         font = Beautiful.font_med_xs,
         color = style.icon_normal .. "BB",
         no_size = true,
         halign = "left",
         valign = "center",
      })
   end

   if opts.settings then
      button_settings = wbutton.state({
         paddings = Beautiful.widget_padding.inner * 0.75,
         halign = "center",
         valign = "center",
         child = button_settings_icon,
         bg_normal = style.bg_normal,
         -- bg_normal = Beautiful.neutral[700],
         -- bg_hover = Beautiful.neutral[800],
         -- bg_press = Beautiful.transparent,
         bg_normal_on = style.settings_bg,
         on_press = opts.settings,
      })
   end

   local button_main = wbutton.state({
      paddings = opts.padding or Beautiful.widget_padding.inner * 0.75,
      halign = "left",
      valign = "center",
      child = {
         layout = Wibox.layout.fixed.horizontal,
         -- spacing = Beautiful.widget_spacing * 0.75,
         -- {
         -- widget = Wibox.container.background,
         -- bg = Beautiful.neutral[900] .. "24",
         -- shape = style.shape_circle,
         {
            widget = Wibox.container.place,
            forced_width = opts.icon_size * 2,
            forced_height = opts.icon_size * 1.25,
            -- TODO: create icon widget, and use new state signal
            button_main_icon,
         },
         -- },
         {
            widget = Wibox.container.place,
            valign = "center",
            {
               layout = Wibox.layout.fixed.vertical,
               label,
               opts.show_state and label_state,
            },
         },
      },
      bg_normal = style.bg_normal,
      bg_hover = style.bg_hover,
      bg_press = style.bg_press,
      bg_normal_on = style.bg_normal_on,
      on_turn_on = opts.fn_on,
      on_turn_off = opts.fn_off,
   })

   ---@class WithLabel:QSButton
   local button = Wibox.widget({
      widget = Wibox.container.background,
      shape = opts.shape,
      border_width = style.border_width,
      border_color = style.border_color,
      {
         layout = Wibox.layout.align.horizontal,
         nil,
         button_main,
         opts.settings and button_settings,
      },
   })

   button_main:connect_signal("state", function(_, new_state)
      if new_state then
         button_settings_icon:set_image(recolor(settings_icon, style.icon_on))
         label:set_color(style.icon_on)
         if button_settings then
            button_settings:turn_on()
         end
         button_main_icon:set_image(recolor(icon_on, style.icon_on))
      else
         button_main_icon:set_image(recolor(icon_off, style.icon_off))
         button_settings_icon:set_image(recolor(settings_icon, style.icon_off))
         label:set_color(style.icon_off)
         if button_settings then
            button_settings:turn_off()
         end
      end
      if label_state then
         label_state:set_color(new_state and style.icon_on .. "BB" or style.icon_off .. "BB")
         label_state:set_text(new_state and "Encendido" or "Apagado")
      end
      button._state = new_state
   end)

   ---Change state button to: **ON**
   function button:turn_on()
      button_main:turn_on()
   end

   ---Change state button to: **OFF**
   function button:turn_off()
      button_main:turn_off()
   end

   return button
end

return templates
