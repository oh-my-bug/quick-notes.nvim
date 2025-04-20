local Path = require("plenary.path")

local M = {}

M.ensure_notes_dir_exists = function(dir)
	local path = Path:new(dir)
	if not path:exists() then
		path:mkdir({ parents = true })
	end
end

M.get_project_file_name = function()
	local project_path = vim.loop.cwd()
	return project_path:gsub(Path.path.sep, "_") .. ".md"
end

M.load_lines = function(file_path)
	local path = Path:new(file_path)
	if path:exists() and path:is_file() then
		local lines = {}
		for line in io.lines(file_path) do
			table.insert(lines, line)
		end
		return lines
	end
end

M.save_lines = function(file_path, lines)
	local file = io.open(file_path, "w")
	if file then
		for _, line in ipairs(lines) do
			file:write(line .. "\n")
		end
		file:close()
	else
		print("[Quick Notes]: Unable to save notes into file")
	end
end

return M
