local M = {}

local function system_with_input(cmd, input)
  return vim.fn.system(cmd, input)
end


function M.send(pane, text)
  local cmd = {
    "wezterm",
    "cli",
    "send-text",
    "--no-paste",
    "--pane_id",
    tostring(pane)
  }

  local result = system_with_input(cmd, text)

  if vim.v.shell_error ~= 0 then
    error(result)
  end
end

function M.split(cmd, cwd)
  error("wezterm.split not implemented")
end

function M.current_pane()
  error("wezterm.current_pane not implemented")
end

function M.list_panes()
  error("wezterm.list_panes not implemented")
end

return M
