local M = {}

function M.get_current_cell()

  local bufnr = 0
  local cursor = vim.api.nvim_win_get_cursor(0)[1]

  local start_line = nil
  local end_line = nil

  -- search upward for ```
  for l = cursor, 1, -1 do
    local line = vim.api.nvim_buf_get_lines(bufnr, l - 1, l, false)[1]

    if line:match("^```") then
      start_line = l
      break
    end
  end

  if not start_line then
    return nil
  end

  -- search downward for closing ```
  local total_lines = vim.api.nvim_buf_line_count(bufnr)

  for l = start_line + 1, total_lines do
    local line = vim.api.nvim_buf_get_lines(bufnr, l - 1, l, false)[1]

    if line:match("^```") then
      end_line = l
      break
    end
  end

  if not end_line then
    return nil
  end

  -- extract inner lines (exclude fences)
  local lines = vim.api.nvim_buf_get_lines(
    bufnr,
    start_line,
    end_line - 1,
    false
  )

  return {
    start_line = start_line,
    end_line = end_line,
    lines = lines
  }
end

function M.get_cell_lang(start_line)

  local line = vim.api.nvim_buf_get_lines(0, start_line - 1, start_line, false)[1]

  local lang = line:match("^```%{?(%w+)")

  return lang
end

return M