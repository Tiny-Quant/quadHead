if vim.g.loaded_quadHead then
  return
end

vim.g.loaded_quadHead = true

-- optional command placeholder
vim.api.nvim_create_user_command("QuadHeadTest", function()
  print("quadHead loaded")
end, {})

vim.api.nvim_create_user_command("QuadHeadSendTest", function()
  local b = require("quadHead.backend").get()

  b.send(0, "x <- 1\nx\n")
end, {})