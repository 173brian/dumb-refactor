local function bufferToString()
	local content = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_buf_line_count(0), false)
	return content
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

local function getLeadingWhitespaceInBuffer(lines)
	local whitespaceCounts = countLeadingWhitespacePerLine(lines)
	for i, count in ipairs(whitespaceCounts) do
		print("Line " .. i .. ": " .. count .. " leading whitespace characters")
	end
end

local function runner()
	print(vim.fn.getcwd())
	local bufferContent = bufferToString()
	getLeadingWhitespaceInBuffer(bufferContent)
end

return {
	runner = runner,
}
