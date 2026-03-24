local M = {}

local backend = require("quadHead.backend").get()


function M.set(name, pane)
  backend.set_var(name, pane)
end


function M.get(name)
--   local pane = backend.get_var(name)

--   if not pane then
--     error("quadHead: no target " .. name)
--   end

--   return pane
    return backend.get_var(name)
end


function M.list()
  return backend.list_vars()
end


return M