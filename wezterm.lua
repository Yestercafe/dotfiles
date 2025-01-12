local wezterm = require 'wezterm'

local config = {}

-- wezterm.gui is not available to the mux server, so take care to
-- do something reasonable when this config is evaluated by the mux
local function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

local function scheme_for_appearance(appearance)
  if appearance:find 'Dark' then
    return 'Belafonte Night'
  else
    return 'Belafonte Day'
  end
end

config.font = wezterm.font('Maple Mono SC NF', { weight = 'Regular' })
config.font_size = 12.0
config.color_scheme = scheme_for_appearance(get_appearance())
config.scrollback_lines = 50000
config.audible_bell = "Disabled"

return config

