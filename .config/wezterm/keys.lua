local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

function module.setup(config)
	-- Set the Leader key to CTRL + A
	config.leader = { key = "Space", mods = "ALT", timeout_milliseconds = 2000 }

	-- Define your shortcuts
	config.keys = {
		-- CLIPBOARD

		{ key = "v", mods = "SHIFT|CTRL", action = act.PasteFrom("Clipboard") },
		{ key = "c", mods = "SHIFT|CTRL", action = act.CopyTo("Clipboard") },
		-- Enter Copy Mode (Leader + c)
		{ key = "c", mods = "LEADER", action = act.ActivateCopyMode },
		-- Navigation

		{ key = "PageUp", mods = "NONE", action = act.ScrollByPage(-1) },
		{ key = "PageDown", mods = "NONE", action = act.ScrollByPage(1) },
		-- Scroll to previous/next prompt
		{ key = "UpArrow", mods = "SHIFT", action = act.ScrollToPrompt(-1) },
		{ key = "DownArrow", mods = "SHIFT", action = act.ScrollToPrompt(1) },
		------------------------------------------------------------
		-- WINDOWS
		------------------------------------------------------------
		{ key = "n", mods = "SHIFT|CTRL", action = wezterm.action.SpawnWindow },
		------------------------------------------------------------
		--TABS
		------------------------------------------------------------
		-- Tab Management
		{ key = "t", mods = "LEADER", action = act.SpawnTab("CurrentPaneDomain") },
		{ key = "w", mods = "LEADER", action = act.CloseCurrentTab({ confirm = true }) },

		-- Tab Navigation
		{ key = "1", mods = "LEADER", action = act.ActivateTab(0) },
		{ key = "2", mods = "LEADER", action = act.ActivateTab(1) },
		{ key = "3", mods = "LEADER", action = act.ActivateTab(2) },
		{ key = "4", mods = "LEADER", action = act.ActivateTab(3) },
		{ key = "5", mods = "LEADER", action = act.ActivateTab(4) },
		{ key = "6", mods = "LEADER", action = act.ActivateTab(5) },
		{ key = "7", mods = "LEADER", action = act.ActivateTab(6) },
		{ key = "8", mods = "LEADER", action = act.ActivateTab(7) },
		{ key = "9", mods = "LEADER", action = act.ActivateTab(8) },

		{ key = ",", mods = "LEADER", action = act.ActivateTabRelative(-1) },
		{ key = ".", mods = "LEADER", action = act.ActivateTabRelative(1) },
		------------------------------------------------------------
		-- PANES
		------------------------------------------------------------
		{ key = "|", mods = "LEADER|SHIFT", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
		{ key = "-", mods = "LEADER", action = act.SplitVertical({ domain = "CurrentPaneDomain" }) },
		{ key = "W", mods = "LEADER", action = act.CloseCurrentPane({ confirm = true }) },
		-- Pane navigation (CTRL + h/j/k/l)
		{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },
		{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },
		{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
		{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },
		-- Font size
		{ key = "=", mods = "CTRL", action = act.IncreaseFontSize },
		{ key = "-", mods = "CTRL", action = act.DecreaseFontSize },
		{ key = "0", mods = "CTRL", action = act.ResetFontSize },

		-- Opacity control
		{ key = "+", mods = "LEADER|SHIFT", action = act.EmitEvent("inc-opacity") },
		{ key = "_", mods = "LEADER|SHIFT", action = act.EmitEvent("dec-opacity") },
		-- Open Command Palette
		{ key = "Space", mods = "CTRL", action = act.ActivateCommandPalette },
		-- Reload Configuration
		{ key = "F5", mods = "LEADER", action = act.EmitEvent("manual-reload") },
		-- Trigger Quick Select (Leader + q)
		{ key = "q", mods = "LEADER", action = act.QuickSelect },
		------------------------------------------------------------
		-- MISC
		------------------------------------------------------------
		-- { key = "/", mods = "LEADER", action = act.Search("CurrentSelectionOrEmptyString") },
		-- Open Case-Insensitive Search Mode (Leader + /)
		{ key = "/", mods = "LEADER", action = act.Search({ CaseInSensitiveString = "" }) },
		{ key = "U", mods = "SHIFT|CTRL", action = act.Search({ Regex = "https?://\\S+" }) },
		{ key = "r", mods = "LEADER", action = act.ActivateKeyTable({ name = "resize_pane", one_shot = false }) },
		{ key = "F11", mods = "NONE", action = act.ToggleFullScreen },
		{ key = "i", mods = "LEADER", action = act.EmitEvent("copy-last-command") },
	}

	config.key_tables = {
		resize_pane = {
			{ key = "h", action = act.AdjustPaneSize({ "Left", 1 }) },
			{ key = "l", action = act.AdjustPaneSize({ "Right", 1 }) },
			{ key = "k", action = act.AdjustPaneSize({ "Up", 1 }) },
			{ key = "j", action = act.AdjustPaneSize({ "Down", 1 }) },
			{ key = "Escape", action = "PopKeyTable" },
			{ key = "Enter", action = "PopKeyTable" },
		},
		search_mode = {
			{ key = "Enter", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "j", mods = "CTRL", action = act.CopyMode("NextMatch") },
			{ key = "k", mods = "CTRL", action = act.CopyMode("PriorMatch") },
			{ key = "r", mods = "CTRL", action = act.CopyMode("CycleMatchType") },
			{ key = "x", mods = "CTRL", action = act.CopyMode("ClearPattern") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PriorMatchPage") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("NextMatchPage") },
			{ key = "UpArrow", mods = "NONE", action = act.CopyMode("PriorMatch") },
			{ key = "DownArrow", mods = "NONE", action = act.CopyMode("NextMatch") },
		},

		copy_mode = {
			----------------------------------------------------------------------
			-- 1. EXIT & CANCEL
			----------------------------------------------------------------------
			{ key = "Escape", mods = "NONE", action = act.CopyMode("Close") },
			{ key = "q", mods = "NONE", action = act.CopyMode("Close") },

			----------------------------------------------------------------------
			-- 2. BASIC MOVEMENT (Vim h,j,k,l and Arrows)
			----------------------------------------------------------------------
			{ key = "h", mods = "NONE", action = act.CopyMode("MoveLeft") },
			{ key = "j", mods = "NONE", action = act.CopyMode("MoveDown") },
			{ key = "k", mods = "NONE", action = act.CopyMode("MoveUp") },
			{ key = "l", mods = "NONE", action = act.CopyMode("MoveRight") },
			----------------------------------------------------------------------
			-- 3. WORD MOVEMENT (Jumping word-by-word)
			----------------------------------------------------------------------
			-- 'w' jumps to the start of the next word
			{ key = "w", mods = "NONE", action = act.CopyMode("MoveForwardWord") },
			{ key = "RightArrow", mods = "CTRL", action = act.CopyMode("MoveForwardWord") },

			-- 'b' jumps back to the start of the previous word
			{ key = "b", mods = "NONE", action = act.CopyMode("MoveBackwardWord") },
			{ key = "LeftArrow", mods = "CTRL", action = act.CopyMode("MoveBackwardWord") },

			-- 'e' jumps to the END of the current word
			{ key = "e", mods = "NONE", action = act.CopyMode("MoveForwardWordEnd") },

			----------------------------------------------------------------------
			-- 4. LINE MOVEMENT (Jumping within a single line)
			----------------------------------------------------------------------
			-- '0' or Home goes to the absolute beginning of the line
			{ key = "0", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },
			{ key = "Home", mods = "NONE", action = act.CopyMode("MoveToStartOfLine") },

			-- '^' goes to the first non-whitespace character (ignores indents)
			{ key = "^", mods = "NONE", action = act.CopyMode("MoveToStartOfLineContent") },
			{ key = "^", mods = "SHIFT", action = act.CopyMode("MoveToStartOfLineContent") },

			-- '$' or End goes to the absolute end of the line
			{ key = "$", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "$", mods = "SHIFT", action = act.CopyMode("MoveToEndOfLineContent") },
			{ key = "End", mods = "NONE", action = act.CopyMode("MoveToEndOfLineContent") },

			-- Pressing Enter jumps straight down to the start of the next line
			{ key = "Enter", mods = "NONE", action = act.CopyMode("MoveToStartOfNextLine") },
			----------------------------------------------------------------------
			-- 5. PAGE & SCROLLING MOVEMENT
			----------------------------------------------------------------------
			-- Half page jumps (CTRL + u/d for Up/Down)
			{ key = "u", mods = "CTRL", action = act.CopyMode({ MoveByPage = -0.5 }) },
			{ key = "d", mods = "CTRL", action = act.CopyMode({ MoveByPage = 0.5 }) },

			-- Full page jumps (CTRL + b/f for Back/Forward)
			{ key = "b", mods = "CTRL", action = act.CopyMode("PageUp") },
			{ key = "f", mods = "CTRL", action = act.CopyMode("PageDown") },
			{ key = "PageUp", mods = "NONE", action = act.CopyMode("PageUp") },
			{ key = "PageDown", mods = "NONE", action = act.CopyMode("PageDown") },

			----------------------------------------------------------------------
			-- 6. VIEWPORT JUMPING (Vim H, M, L and g, G)
			----------------------------------------------------------------------
			-- Jump to the Top, Middle, or Bottom of the CURRENT screen
			-- { key = "H", mods = "NONE", action = act.CopyMode("MoveToViewportTop") },
			-- { key = "H", mods = "SHIFT", action = act.CopyMode("MoveToViewportTop") },
			-- { key = "M", mods = "NONE", action = act.CopyMode("MoveToViewportMiddle") },
			-- { key = "M", mods = "SHIFT", action = act.CopyMode("MoveToViewportMiddle") },
			-- { key = "L", mods = "NONE", action = act.CopyMode("MoveToViewportBottom") },
			-- { key = "L", mods = "SHIFT", action = act.CopyMode("MoveToViewportBottom") },

			-- Jump to the absolute top/bottom of the ENTIRE terminal history
			{ key = "g", mods = "NONE", action = act.CopyMode("MoveToScrollbackTop") },
			{ key = "G", mods = "NONE", action = act.CopyMode("MoveToScrollbackBottom") },
			{ key = "G", mods = "SHIFT", action = act.CopyMode("MoveToScrollbackBottom") },

			----------------------------------------------------------------------
			-- 7. CHARACTER SEARCHING (f, F, t, T)
			----------------------------------------------------------------------
			-- 'f' waits for you to type a letter, then jumps your cursor ONTO it
			{ key = "f", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = false } }) },
			{ key = "F", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },
			{ key = "F", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = false } }) },

			-- 't' waits for you to type a letter, then jumps your cursor RIGHT BEFORE it
			{ key = "t", mods = "NONE", action = act.CopyMode({ JumpForward = { prev_char = true } }) },
			{ key = "T", mods = "NONE", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },
			{ key = "T", mods = "SHIFT", action = act.CopyMode({ JumpBackward = { prev_char = true } }) },

			-- Repeat the last character search (Forward = ';', Backward = ',')
			{ key = ";", mods = "NONE", action = act.CopyMode("JumpAgain") },
			{ key = ",", mods = "NONE", action = act.CopyMode("JumpReverse") },

			----------------------------------------------------------------------
			-- 8. HIGHLIGHTING & SELECTION (v, V, CTRL+v)
			----------------------------------------------------------------------
			-- Start highlighting normally (Cell mode)
			{ key = "v", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Cell" }) },

			-- Start highlighting entire lines (Line mode)
			{ key = "V", mods = "NONE", action = act.CopyMode({ SetSelectionMode = "Line" }) },
			{ key = "V", mods = "SHIFT", action = act.CopyMode({ SetSelectionMode = "Line" }) },

			-- Start highlighting rectangular blocks (Block mode)
			{ key = "v", mods = "CTRL", action = act.CopyMode({ SetSelectionMode = "Block" }) },

			-- Swap your cursor to the other side of your active highlight
			{ key = "o", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEnd") },
			{ key = "O", mods = "NONE", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },
			{ key = "O", mods = "SHIFT", action = act.CopyMode("MoveToSelectionOtherEndHoriz") },

			----------------------------------------------------------------------
			-- 9. YANK (COPY) AND FINISH
			----------------------------------------------------------------------
			-- 'y' copies whatever you highlighted and instantly closes Copy Mode
			{
				key = "y",
				mods = "NONE",
				action = act.Multiple({ { CopyTo = "ClipboardAndPrimarySelection" }, { CopyMode = "Close" } }),
			},

			----------------------------------------------------------------------
			-- 10. CUSTOM: SEMANTIC ZONE JUMPING
			----------------------------------------------------------------------
			-- Our custom additions for flying through command history!
			{ key = "k", mods = "CTRL", action = act.CopyMode("MoveBackwardSemanticZone") },
			{ key = "j", mods = "CTRL", action = act.CopyMode("MoveForwardSemanticZone") },
			{ key = "k", mods = "LEADER", action = act.CopyMode({ MoveBackwardZoneOfType = "Input" }) },
			{ key = "j", mods = "LEADER", action = act.CopyMode({ MoveForwardZoneOfType = "Input" }) },
		},
	}
end

return module
