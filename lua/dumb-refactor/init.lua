local function buffer_to_string()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return table.concat(content, "\n")
end

local function countLeadingWhitespacePerLine(content)
	local counts = {}
	for i, line in ipairs(content) do
		local leadingWhitespace = string.match(line, "^%s*")
		local count = #leadingWhitespace
		counts[i] = count
	end
	return counts
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
