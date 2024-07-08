local _module = {}
---@module 'utilities.helpers._markup'
_module = require((...):match("(.-)[^%.]+$") .. "_markup")

function _module.colorize_text(text, color)
  return "<span foreground='" .. color .. "'>" .. text .. "</span>"
end

--- Return time to text
---Return seconds as colloquial text
---@param seconds number
---@return string
function _module.to_time_ago(seconds)
  local days = seconds / 86400
  if days >= 1 then
    days = math.floor(days)
    return "hace" .. days .. (days == 1 and " dia" or " dias")
  end

  local hours = (seconds % 86400) / 3600
  if hours >= 1 then
    hours = math.floor(hours)
    return "hace" .. hours .. (hours == 1 and " hora" or " horas")
  end

  local minutes = ((seconds % 86400) % 3600) / 60
  if minutes >= 1 then
    minutes = math.floor(minutes)
    return "hace " .. minutes .. (minutes == 1 and " minuto" or " minutos")
  end

  return "ahora"
end

function _module.parse_date(date_str)
  local pattern = "(%d+)%-(%d+)%-(%d+)T(%d+):(%d+):(%d+)%Z"
  local y, m, d, h, min, sec, _ = date_str:match(pattern)

  return os.time({ year = y, month = m, day = d, hour = h, min = min, sec = sec })
end

function _module.upper(text)
  local result = ""
  for _, char in utf8.codes(text) do
    if char >= 97 and char <= 122 then
      char = char - 32
    elseif char == 225 then -- á
      char = 193
    elseif char == 233 then -- é
      char = 201
    elseif char == 237 then -- í
      char = 205
    elseif char == 243 then -- ó
      char = 211
    elseif char == 250 then -- ú
      char = 218
    elseif char == 252 then -- ü
      char = 220
    end
    result = result .. utf8.char(char)
  end
  return result
end

-- [[
-- local time = os.date("%Y-%m-%dT%H:%M:%S")
-- to_time_ago(os.difftime(parse_date(os.date("%Y-%m-%dT%H:%M:%S")), parse_date(time)))
-- ]]

return _module