require("full-border"):setup {
	-- Available values: ui.Border.PLAIN, ui.Border.ROUNDED
	type = ui.Border.ROUNDED,
}
require("smart-enter"):setup {
	open_multi = true,
}

-- Show symlink in status bar
Status:children_add(function(self)
	local h = self._current.hovered
	if h and h.link_to then
		return " -> " .. tostring(h.link_to)
	else
		return ""
	end
end, 3300, Status.LEFT)
-- Show user/group of files in status bar
Status:children_add(function()
	local h = cx.active.current.hovered
	if not h or ya.target_family() ~= "unix" then
		return ""
	end

	return ui.Line {
		ui.Span(ya.user_name(h.cha.uid) or tostring(h.cha.uid)):fg("magenta"),
		":",
		ui.Span(ya.group_name(h.cha.gid) or tostring(h.cha.gid)):fg("magenta"),
		" ",
	}
end, 500, Status.RIGHT)
-- Show username and hostname in heade
Header:children_add(function()
	if ya.target_family() ~= "unix" then
		return ""
	end
	return ui.Span(ya.user_name() .. "@" .. ya.host_name() .. ":"):fg("blue")
end, 500, Header.LEFT)
--PROJECTS
require("projects"):setup({
    event = {
        save = {
            enable = true,
            name = "project-saved",
        },
        load = {
            enable = true,
            name = "project-loaded",
        },
        delete = {
            enable = true,
            name = "project-deleted",
        },
        delete_all = {
            enable = true,
            name = "project-deleted-all",
        },
        merge = {
            enable = true,
            name = "project-merged",
        },
    },
    save = {
        method = "yazi", -- yazi | lua
        yazi_load_event = "@projects-load", -- event name when loading projects in `yazi` method
        lua_save_path = "", -- path of saved file in `lua` method, comment out or assign explicitly
                            -- default value:
                            -- windows: "%APPDATA%/yazi/state/projects.json"
                            -- unix: "~/.local/state/yazi/projects.json"
    },
    last = {
        update_after_save = true,
        update_after_load = true,
        update_before_quit = false,
        load_after_start = false,
    },
    merge = {
        event = "projects-merge",
        quit_after_merge = false,
    },
    notify = {
        enable = true,
        title = "Projects",
        timeout = 3,
        level = "info",
    },
})
-- Restore deleted files
require("restore"):setup({
    -- Set the position for confirm and overwrite prompts.
    -- Don't forget to set height: `h = xx`
    -- https://yazi-rs.github.io/docs/plugins/utils/#ya.input
    position = { "center", w = 70, h = 40 }, -- Optional

    -- Show confirm prompt before restore.
    -- NOTE: even if set this to false, overwrite prompt still pop up
    show_confirm = true,  -- Optional

    -- Suppress success notification when all files or folder are restored.
    suppress_success_notification = true,  -- Optional

    -- colors for confirm and overwrite prompts
    theme = { -- Optional
      -- Default using style from your flavor or theme.lua -> [confirm] -> title.
      -- If you edit flavor or theme.lua you can add more style than just color.
      -- Example in theme.lua -> [confirm]: title = { fg = "blue", bg = "green"  }
      title = "blue", -- Optional. This value has higher priority than flavor/theme.lua

      -- Default using style from your flavor or theme.lua -> [confirm] -> content
      -- Sample logic as title above
      header = "green", -- Optional. This value has higher priority than flavor/theme.lua

      -- header color for overwrite prompt
      -- Default using color "yellow"
      header_warning = "yellow", -- Optional
      -- Default using style from your flavor or theme.lua -> [confirm] -> list
      -- Sample logic as title and header above
      list_item = { odd = "blue", even = "blue" }, -- Optional. This value has higher priority than flavor/theme.lua
    },
})
require("recycle-bin"):setup({
    -- Optional: Override automatic trash directory discovery
    -- trash_dir = "~/.local/share/Trash/",  -- Uncomment to use specific directory
})
-- KDE connect
-- Always show device selection
require("kdeconnect-send"):setup({
    auto_select_single = false,
})
-- Copy file content
require("copy-file-contents"):setup({
	append_char = "\n",
	notification = true,
})