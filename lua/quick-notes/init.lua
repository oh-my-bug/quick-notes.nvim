local fs = require("quick-notes.fs")
local window = require("quick-notes.window")

local M = {}

M.config = {
  notes_dir = vim.fn.stdpath("data") .. "/quick-notes/",
  name = "Quick Notes.md",
}

M.toggle = function()
  if window.is_open() then
    local lines = window.get_lines()
    if lines ~= nil then
      fs.save_lines(M.config.notes_dir .. fs.get_project_file_name(), lines)
    end
    window.destroy()
  else
    window.create({ name = M.config.name })
    local lines = fs.load_lines(M.config.notes_dir .. fs.get_project_file_name())
    if lines ~= nil then
      window.set_lines(lines)
    end
  end
end

M.setup = function(config)
  M.config = vim.tbl_extend("force", M.config, config or {})
  fs.ensure_notes_dir_exists(M.config.notes_dir)
end

return M
