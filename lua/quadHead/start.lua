local M = {}

local backend = require("quadHead.backend").get()
local targets = require("quadHead.targets")

function M.attach_r()

    local pane = backend.split("radian")

    backend.set_title(pane, "radian")

    targets.set("r", pane)

    return pane
end

function M.attach_python()

  local pane = backend.split("ipython")

  backend.set_title(pane, "ipython")

  targets.set("python", pane)

  return pane
end


function M.attach(name)

  if name == "r" then
    return M.attach_r()
  end

  if name == "python" then
    return M.attach_python()
  end

  error("quadHead: no attach for " .. name)
end

return M
