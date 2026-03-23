local M = {}

local default_config = {
  backend = "wezterm",
  cells = {},
}

M.config = default_config

function M.setup(opts)
  M.config = vim.tbl_deep_extend(
    "force",
    default_config,
    opts or {}
  )
end

function M.get()
  return M.config
end

return M
