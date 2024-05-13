print("hello world")

local function buffer_to_string()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

local function runner()
	print("Function running")
	print(vim.fn.getcwd())
	print(buffer_to_string())
end

return {
	runner = runner,
}
