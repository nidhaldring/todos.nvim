local function parse_grep_output(str)
  -- TODO: i think this can be improved
  local res = {}
  local lines = string.gmatch(str, "[^\n\r]+")
  local i = 0
  for line in lines do
    local beg, fin = string.find(line, ":%d+:")
    if beg and fin then
      res[i] = {
        path = string.sub(line, 1, beg - 1),
        line_nb = string.sub(line, beg + 1, fin - 1),
        todo = string.sub(line, fin + 1, #line),
      }
      i = i + 1
    end
  end
  return res
end


local function get_todos_from_cwd()
  local cwd = vim.loop.cwd()
  if not cwd then
    -- @TODO: better handle errors
    print("error while getting cwd")
    return
  end

  local cmd = string.format("grep -ri TODO %s", cwd)
  local output = (vim.api.nvim_exec2(cmd, { output = true }))["output"]
  return parse_grep_output(output)
end


local function show_todos()
  local todos = get_todos_from_cwd()
end

local M = {}
M.steup = function()
  vim.api.nvim_create_user_command("ShowTodos", show_todos, {})
end

show_todos()

return M
