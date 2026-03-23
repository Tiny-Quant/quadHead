local M = {}

local config = require("quadHead.config")

function M.setup(opts)
  config.setup(opts)
  print("quadHead setup called!")
end

return M
