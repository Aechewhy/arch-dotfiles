local wezterm = require("wezterm")
local module = {}
-- Notify only when the GUI window successfully reloads the config
-- Custom event that handles BOTH the reload and the notification
wezterm.on("manual-reload", function(window, pane)
	window:toast_notification("WezTerm", "Configuration Reloaded!", nil, 4000)
	window:perform_action(wezterm.action.ReloadConfiguration, pane)
end)
wezterm.on("copy-last-command", function(window, pane)
	-- 1. Grab the zones
	local zones = pane:get_semantic_zones("Input")

	-- 2. Check if the shell integration is actually providing zones
	if not zones or #zones == 0 then
		window:toast_notification("WezTerm", "Error: No Input zones found!", nil, 2000)
		return
	end

	-- 3. Grab the last zone and extract the text
	local zone = zones[#zones]
	local text = pane:get_text_from_region(zone.start_x, zone.start_y, zone.end_x, zone.end_y)

	-- 4. Bug workaround: If text is empty, extend the Y-coordinate by 1
	if not text or text == "" then
		text = pane:get_text_from_region(zone.start_x, zone.start_y, 0, zone.end_y + 1)
	end

	-- 5. Copy and notify
	if text and text ~= "" then
		window:copy_to_clipboard(text, "Clipboard")
		window:toast_notification("WezTerm", "Copied: " .. text, nil, 2000)
	else
		window:toast_notification("WezTerm", "Zone found, but text was empty!", nil, 2000)
	end
end)

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
