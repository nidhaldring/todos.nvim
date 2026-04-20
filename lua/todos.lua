local M = {}
M.steup = function()
	vim.api.nvim_create_user_command("ShowTodos", show_todos, {})
end

return M
