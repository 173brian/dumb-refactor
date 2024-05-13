local function buffer_to_string()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

local function countLeadingWhitespacePerLine(table)
	local result = {}
	for str in table do
		local pattern = "^%s*"
		local whitespace = string.match(str, pattern)
		if whitespace then
			result[str] = #whitespace
		else
			result[str] = 0
		end
	end
	return result
end

local function runner()
	print("Function running")
	print(vim.fn.getcwd())
	print(countLeadingWhitespacePerLine(buffer_to_string()))
end

return {
	runner = runner,
}
