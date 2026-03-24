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
    if line ~= "" then
      send_line(pane, line)
    else
      send_line(pane, "")
    end
  end
end


function M.split(cmd)
    local out = vim.fn.system({
        "tmux",
        "split-window",
        "-P",
        "-F",
        "#{pane_index}",
        cmd
    })

    if vim.v.shell_error ~= 0 then 
        error(out)
    end

    return tonumber(out)
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

return M