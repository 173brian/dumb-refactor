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

local function processBufferContent()
	local bufferContent = buffer_to_string() -- Get the buffer content as a string
	local lines = {} -- Table to hold the lines from the buffer content
	for line in string.gmatch(bufferContent, "([^\n]+)") do
		table.insert(lines, line) -- Add each line to the 'lines' table
	end

	local whitespaceCounts = countLeadingWhitespacePerLine(lines)
	for i, count in ipairs(whitespaceCounts) do
		print("Line " .. i .. ": " .. count .. " leading whitespace characters")
	end
end

local function runner()
	print("Function running")
	print(vim.fn.getcwd())
	processBufferContent()
end

return {
	runner = runner,
}
