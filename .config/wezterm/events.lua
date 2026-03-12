local wezterm = require("wezterm")
local module = {}
------------------------------------------------------------------------------------------------------------------
-- Maximize at launch
------------------------------------------------------------------------------------------------------------------
-- wezterm.on("gui-startup", function(cmd)
-- 	-- 1. Spawn the default window (or whatever command you passed to `wezterm start`)
-- 	local tab, pane, window = wezterm.mux.spawn_window(cmd or {})
--
-- 	-- 2. Instantly maximize it
-- 	window:gui_window():maximize()
-- end)
------------------------------------------------------------------------------------------------------------------
-- Configuration reload notification
------------------------------------------------------------------------------------------------------------------
wezterm.on("manual-reload", function(window, pane)
	window:toast_notification("WezTerm", "Configuration Reloaded!", nil, 4000)
	window:perform_action(wezterm.action.ReloadConfiguration, pane)
end)
wezterm.on("copy-last-command", function(window, pane)
	local zones = pane:get_semantic_zones("Input")
	if not zones or #zones == 0 then
		window:toast_notification("WezTerm", "Error: No Input zones found!", nil, 2000)
		return
	end
	local zone = zones[#zones]
	local text = pane:get_text_from_region(zone.start_x, zone.start_y, zone.end_x, zone.end_y)
	if not text or text == "" then
		text = pane:get_text_from_region(zone.start_x, zone.start_y, 0, zone.end_y + 1)
	end
	if text and text ~= "" then
		window:copy_to_clipboard(text, "Clipboard")
		window:toast_notification("WezTerm", "Copied: " .. text, nil, 2000)
	else
		window:toast_notification("WezTerm", "Zone found, but text was empty!", nil, 2000)
	end
end)

------------------------------------------------------------------------------------------------------------------
-- Changing opacity
------------------------------------------------------------------------------------------------------------------
function module.setup()
	-- Set a baseline opacity variable
	local current_opacity = 0.9

	-- Event to increase opacity
	wezterm.on("inc-opacity", function(window, pane)
		current_opacity = current_opacity + 0.1
		if current_opacity > 1.0 then
			current_opacity = 1.0
		end

		local overrides = window:get_config_overrides() or {}
		overrides.window_background_opacity = current_opacity
		window:set_config_overrides(overrides)
	end)

	-- Event to decrease opacity
	wezterm.on("dec-opacity", function(window, pane)
		current_opacity = current_opacity - 0.1
		if current_opacity < 0.1 then
			current_opacity = 0.1
		end

		local overrides = window:get_config_overrides() or {}
		overrides.window_background_opacity = current_opacity
		window:set_config_overrides(overrides)
	end)
end

return module
