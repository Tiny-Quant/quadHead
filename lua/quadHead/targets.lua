local M = {}

local targets = {}

function M.set(name, pane)
    targets[name] = {
        pane = pane
    }
end 

function M.get(name)
    local t = targets[name]

    if t == nil then 
        error("quadHead: no target " .. name)
    end 

    return t.pane
end

function M.list()
    return targets
end

return M
