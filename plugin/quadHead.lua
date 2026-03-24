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
  local target = require("quadHead.targets").get()

  backend.send(target, "x <- 1 \n x")
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

vim.api.nvim_create_user_command("QuadHeadAttachR", function(opts)
  local backend = require("quadHead.backend").get()
  local targets = require("quadHead.targets")

  local pane

  if opts.args ~= "" then
    pane = opts.args
  else
    pane = backend.split("radian")
  end

  backend.set_title(pane, "radian")

  targets.set("r", pane)

  print("quadHead R attached to pane", pane)
end, {nargs = "?",})

vim.api.nvim_create_user_command("QuadHeadAttachPy", function(opts)
  local backend = require("quadHead.backend").get()
  local targets = require("quadHead.targets")

  local pane

  if opts.args ~= "" then
    pane = opts.args
  else
    pane = backend.split("ipython")
  end

  backend.set_title(pane, "ipython")

  targets.set("python", pane)

  print("quadHead python attached to pane", pane)
end, {nargs = "?",})

vim.api.nvim_create_user_command("QuadHeadList", function()
  local targets = require("quadHead.targets").list()

  for name, pane in pairs(targets) do
    print(name, "-> pane", pane)
  end
end, {})

vim.api.nvim_create_user_command("QuadHeadSendLine", function()

  local backend = require("quadHead.backend").get()
  local targets = require("quadHead.targets")
  local utils = require("quadHead.utils")
  local attach = require("quadHead.start")

  local target_name = utils.get_lang()

  local pane 

  local ok, result = pcall(function()
    return target.get(target_name)
  end)

  if ok then 
    pane = result
  else
    pane = attach.attach(target_name)
  end

  local line = vim.api.nvim_get_current_line()

  backend.send(pane, line)

end, {})