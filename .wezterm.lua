local wezterm = require("wezterm")
local config = wezterm.config_builder()

-- Tell Lua to look in your ~/.config/wezterm directory for modules
package.path = package.path .. ";" .. wezterm.home_dir .. "/.config/wezterm/?.lua"

-- Call your modules and hand them the config object to modify
require("settings").setup(config)
require("keys").setup(config)
require("events").setup()

return config
