local M = {}

local function run(cmd)
  local out = vim.fn.system(cmd)

  if vim.v.shell_error ~= 0 then
    error(out)
  end

  return out
end


local function send_line(pane, line)
  run({
    "tmux",
    "send-keys",
    "-t",
    tostring(pane),
    line,
    "Enter",
  })
end


function M.send(pane, text)
  local lines = vim.split(text, "\n", { plain = true })

  for _, line in ipairs(lines) do
    send_line(pane, line)
  end
end


function M.split(cmd)
  local out = vim.fn.system({
    "tmux",
    "split-window",
    "-P",
    "-F",
    "#{pane_id}",
    cmd,
  })

  if vim.v.shell_error ~= 0 then
    error(out)
  end

  return vim.trim(out)
end


function M.set_title(pane, title)
  local out = vim.fn.system({
    "tmux",
    "select-pane",
    "-t",
    tostring(pane),
    "-T",
    title,
  })

  if vim.v.shell_error ~= 0 then
    error(out)
  end
end


-- persistent storage in tmux

function M.set_var(name, value)
  local key = "quadHead_" .. name

  local out = vim.fn.system({
    "tmux",
    "set-environment",
    "-g",
    key,
    value,
  })

  if vim.v.shell_error ~= 0 then
    error(out)
  end
end


function M.get_var(name)
  local key = "quadHead_" .. name

  local out = vim.fn.system({
    "tmux",
    "show-environment",
    "-g",
    key,
  })

  if vim.v.shell_error ~= 0 then
    return nil
  end

  local v = out:match("=(.+)")
  return v
end


function M.list_vars()

  local out = vim.fn.system({
    "tmux",
    "show-environment",
    "-g",
  })

  local result = {}

  for line in out:gmatch("[^\n]+") do
    local k, v = line:match("^quadHead_(%w+)=(.+)")
    if k then
      result[k] = v
    end
  end

  return result
end


return M