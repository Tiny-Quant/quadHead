local M = {}

local config = require("quadHead.config")

function M.get()
  local cfg = config.get()

  if cfg.backend == "tmux" then
    return require("quadHead.backend.tmux")
  end

  if cfg.backend == "wezterm" then
    return require("quadHead.backend.wezterm")
  end

  error("unknown backend: " .. tostring(cfg.backend))
end

return M
