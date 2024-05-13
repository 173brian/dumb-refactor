local function buffer_to_string()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

local function countLeadingWhitespacePerLine(content)
	local lines = {}
	for i, str in ipairs(content:gmatch("[^\r\n]+")) do
		local pattern = "^%s*"
		local whitespace = string.match(str, pattern)
		if whitespace then
			lines[i] = #whitespace
		else
			lines[i] = 0
		end
	end
	return lines
end

local function runner()
	print("Function running")
	print(vim.fn.getcwd())
	local file_buffer = buffer_to_string()
	local whitespace = countLeadingWhitespacePerLine(file_buffer)
	print(whitespace)
end

return {
	runner = runner,
}
