local function expand_path(path, cwd)
	path = path:gsub("^~/", os.getenv("HOME") .. "/")
	path = path:gsub("%$HOME", os.getenv("HOME"))
	if not path:match("^/") then
		path = cwd .. "/" .. path
	end
	return path
end

local function is_file_path(path)
	local basename = path:match("([^/]+)$") or path
	if basename:match("^%.%.?$") then return false end
	return basename:match("%.") ~= nil
end

local get_cwd = ya.sync(function(_)
	return tostring(cx.active.current.cwd)
end)

local function entry()
	local value, event = ya.input({
		title = "Navigate to:",
		pos = { "top-center", w = 60 },
	})

	if event ~= 1 or not value or value == "" then return end

	local cwd = get_cwd()
	local path = expand_path(value, cwd):gsub("/+$", "")

	local cha = fs.cha(Url(path))
	local is_file = cha and not cha.is_dir or not cha and is_file_path(path)

	if is_file then
		local dir = path:match("^(.+)/[^/]+$")

		local child = Command("mkdir"):arg({ "-p", dir }):spawn()
		if child then child:wait() end

		if not fs.cha(Url(path)) then
			local c = Command("touch"):arg({ path }):spawn()
			if c then c:wait() end
		end

		ya.emit("cd", { Url(dir) })
		ya.emit("reveal", { path })
	else
		if not fs.cha(Url(path)) then
			local child = Command("mkdir"):arg({ "-p", path }):spawn()
			if child then child:wait() end
		end
		ya.emit("cd", { Url(path) })
	end
end

return { entry = entry }
