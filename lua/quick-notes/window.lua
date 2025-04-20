local M = {}

local buf_nr = nil
local win_id = nil

local is_buf_valid = function()
  return buf_nr ~= nil and vim.api.nvim_buf_is_valid(buf_nr)
end

local is_win_valid = function()
  return win_id ~= nil and vim.api.nvim_win_is_valid(win_id)
end

M.create = function(config)
  config = config or {}
  local name = config.name or "no name"
  if buf_nr == nil and win_id == nil then
    buf_nr = vim.api.nvim_create_buf(false, true)
    vim.api.nvim_set_option_value("filetype", "markdown", { buf = buf_nr })
    vim.api.nvim_buf_set_name(buf_nr, "scratch://" .. name)
    win_id = vim.api.nvim_open_win(buf_nr, true, { split = "right" })
  end
end

M.destroy = function()
  if is_win_valid() then
    vim.api.nvim_win_close(win_id, true)
    win_id = nil
  end
  if is_buf_valid() then
    vim.api.nvim_buf_delete(buf_nr, { force = true })
    buf_nr = nil
  end
end

M.is_open = function()
  return is_buf_valid and is_win_valid()
end

M.get_lines = function()
  if is_buf_valid() then
    return vim.api.nvim_buf_get_lines(buf_nr, 0, -1, false)
  end
end

M.set_lines = function(lines)
  if is_buf_valid() then
    vim.api.nvim_buf_set_lines(buf_nr, 0, -1, false, lines)
  end
end

return M
