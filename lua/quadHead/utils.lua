local M = {}

local map = {
    r = "r",
    python = "python",
}

function M.get_lang()
    local ft = vim.bo.filetype

    local name = map[ft]

    if not name then 
        error("quadHead: no target for filetype " .. ft)
    end

    return name
end

return M
