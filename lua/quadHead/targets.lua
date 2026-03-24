local M = {}

local targets = {}

function M.set(name, pane)
    targets[name] = pane
end 

function M.get(name)
    local pane = targets[name]

    if pane == nil then 
        error("quadHead: no target " .. name)
    end 

    return pane
end

return M
