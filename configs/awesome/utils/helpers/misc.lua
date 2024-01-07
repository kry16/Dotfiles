local _module = {}
-- local menubar = require("menubar")

function _module.checkFile(file_path)
	local f = io.open(file_path, "r")
	if f ~= nil then
		io.close(f)
		return file_path
	else
		return false
	end
end
local cairo = require("lgi").cairo
function _module.cropSurface(ratio, surf)
  local old_w, old_h = Gears.surface.get_size(surf)
  local old_ratio = old_w / old_h
  if old_ratio == ratio then return surf end

  local new_h = old_h
  local new_w = old_w
  local offset_h, offset_w = 0, 0
  -- quick mafs
  if (old_ratio < ratio) then
    new_h = math.ceil(old_w * (1 / ratio))
    offset_h = math.ceil((old_h - new_h) / 2)
  else
    new_w = math.ceil(old_h * ratio)
    offset_w = math.ceil((old_w - new_w) / 2)
  end

  local out_surf = cairo.ImageSurface(cairo.Format.ARGB32, new_w, new_h)
  local cr = cairo.Context(out_surf)
  cr:set_source_surface(surf, -offset_w, -offset_h)
  cr.operator = cairo.Operator.SOURCE
  cr:paint()

  return out_surf
end

function _module.getIcon(app, icon_fallback, fallback)
	app_path = _module.checkFile(Beautiful.icon_theme_path .. app .. ".svg")
	app_path_alt = _module.checkFile(Beautiful.icon_theme_path .. app:lower() .. ".svg")
	-- icon_fallback = icon_fallback or Beautiful.default_app_icon
	-- local menubar_icon = menubar.utils.lookup_icon(app) or menubar.utils.lookup_icon(app:lower())
	return app_path
		or app_path_alt
		or icon_fallback and _module.checkFile(icon_fallback)
		or icon_fallback and _module.checkFile(icon_fallback:lower())
		or fallback and fallback
end

function _module.recolor_image(image, color)
	return Gears.color.recolor_image(image, color)
end

function _module.getCmdOut(cmd)
	local handle = assert(io.popen(cmd, "r"))
	local output = assert(handle:read("*a"))
	handle:close()
	local out = string.gsub(string.gsub(string.gsub(output, "^%s+", ""), "%s+$", ""), "[\n\r]+", " ")
	return out
end

function _module.notify_dwim(args, notif)
	local n = notif
	if n and not n._private.is_destroyed and not n.is_expired then
		notif:set_title(args.title or notif.title)
		notif:set_message(args.message or notif.message)
		notif:set_image(args.image or notif.image)
		notif.actions = args.actions or notif.actions
		notif.app_name = args.app_name or notif.app_name
		notif:set_timeout(Naughty.config.defaults.timeout)
	else
		n = Naughty.notification(args)
	end
	return n
end

function _module.gc(widget, id)
	return widget:get_children_by_id(id)[1]
end

return _module
