local M = {}

local current_target = nil

function M.set(pane)
  current_target = pane 
end 

function M.get()
  if current_target == nil then
    error("quadHead: no target attached")
  end 

  return current_target
end

return M
