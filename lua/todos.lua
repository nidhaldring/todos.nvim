local utils = require("utils")

local M = {}

M.setup = function()
	vim.api.nvim_create_user_command("ShowTodos", utils.show_todos, {})
end

return M
