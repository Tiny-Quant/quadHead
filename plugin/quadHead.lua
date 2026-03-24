if vim.g.loaded_quadHead then
  return
end

vim.g.loaded_quadHead = true

-- optional command placeholder
vim.api.nvim_create_user_command("QuadHeadTest", function()
  print("quadHead loaded")
end, {})

vim.api.nvim_create_user_command("QuadHeadSendTest", function()
  local backend = require("quadHead.backend").get()
  local target = require("quadHead.target").get()

  backend.send(target, "x <- 1\nx\n")
end, {})

vim.api.nvim_create_user_command("QuadHeadAttach", function(opts)
    local pane = tonumber(opts.args)

    if pane == nil then 
        print("quadHead: invalid pane")
        return
    end

    require("quadHead.targets").set(pane)
    print("quadHead attached to pane", pane)
end, {nargs = 1})