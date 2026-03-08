local wezterm = require("wezterm")
local module = {}

function module.setup(config)
	-- config.front_end = "OpenGL"
	-- MISC
	config.disable_default_key_bindings = true
	config.automatically_reload_config = false
	config.max_fps = 200
	config.skip_close_confirmation_for_processes_named = {
		"bash",
		"sh",
		"zsh",
		"fish",
		"tmux",
		"nu",
		"cmd.exe",
		"pwsh.exe",
		"powershell.exe",
	}
	-- QUICK SELECT
	config.quick_select_alphabet = "asdfghjkl"
	config.quick_select_patterns = { "http?://\\S+" }
	-- Visuals
	config.enable_wayland = false
	config.color_scheme = "Tokyo Night"
	-- FONT
	config.font = wezterm.font("JetBrains Mono")
	config.font_size = 13.0

	config.animation_fps = 1
	config.audible_bell = "Disabled"
	-- Window Behavior
	config.window_background_opacity = 0.5
	config.adjust_window_size_when_changing_font_size = false
	config.window_decorations = "NONE"
	config.hide_tab_bar_if_only_one_tab = true
	config.initial_cols = 90
	config.initial_rows = 30
	config.quit_when_all_windows_are_closed = true
	config.window_padding = {
		left = "1%",
		right = "1%",
		top = 0,
		bottom = 0,
	}
	-- CURSOR
	config.default_cursor_style = "BlinkingBlock"
	config.cursor_blink_rate = 500
	config.cursor_blink_ease_in = "EaseIn"
	config.cursor_blink_ease_out = "EaseOut"
	-- MOUSE
	config.disable_default_mouse_bindings = false
	config.hide_mouse_cursor_when_typing = true
	-- Scroll bar
	config.enable_scroll_bar = false
	-- Tab
	config.enable_tab_bar = true
	config.use_fancy_tab_bar = true
	config.hide_tab_bar_if_only_one_tab = true
	config.show_new_tab_button_in_tab_bar = true

	-- Dim unfocused panes
	config.inactive_pane_hsb = {
		saturation = 0.1, -- 1.0 is normal. 0.9 slightly desaturates the colors
		brightness = 0.5, -- 1.0 is normal. 0.5 makes it 50% darker
	}
end
return module
