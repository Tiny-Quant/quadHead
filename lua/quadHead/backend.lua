local M = {}

local config = require("quadHead.config")

function M.get_backend()
  local cfg = config.get()

  if cfg.backend == "wezterm" then
    return require("quadHead.backend.wezterm")
  end

  error("unknown backend: " .. tostring(cfg.backend))
end

return M
