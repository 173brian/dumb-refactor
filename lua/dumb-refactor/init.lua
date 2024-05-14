local function getLeadingWhitespacePerLine(content)
	local counts = {}
	for i, line in ipairs(content) do
		local leadingWhitespace = string.match(line, "^%s*")
		local count = #leadingWhitespace
		counts[i] = count
	end
	return counts
end

local function getSelection(buf, bufferContent)
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local spans_multiple_lines = start_pos[1] ~= end_pos[1]
	if spans_multiple_lines then
		vim.api.nvim_err_writeln("Error: Selection spans multiple lines.")
		return nil
	end
	local start_line, start_col = table.unpack(start_pos)
	local _, end_col = table.unpack(end_pos)

	local selection = string.sub(bufferContent[start_line], start_col, end_col)
	print(selection)
end

local function getVisualSelection()
	local s_start = vim.fn.getpos("'<")
	local s_end = vim.fn.getpos("'>")
	local n_lines = math.abs(s_end[2] - s_start[2]) + 1
	local lines = vim.api.nvim_buf_get_lines(0, s_start[2] - 1, s_end[2], false)
	lines[1] = string.sub(lines[1], s_start[3], -1)
	if n_lines == 1 then
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3] - s_start[3] + 1)
	else
		lines[n_lines] = string.sub(lines[n_lines], 1, s_end[3])
	end
	return table.concat(lines, "\n")
end

local function runner(input)
	local buf = vim.fn.get
	local bufLineCount = vim.api.nvim_buf_line_count(buf)
	local bufferContent = vim.api.nvim_buf_get_lines(buf, 0, bufLineCount, false)
	local whitespaceCounts = getLeadingWhitespacePerLine(bufferContent)
	local selection = getVisualSelection()
	print("input: " .. input)
	print(whitespaceCounts)
	if selection ~= nil then
		print(selection)
	else
		return
	end
end

local function ui()
	local input = vim.fn.input("Refactor to: ") -- TODO: yellow: fancy ui
	return input
end

local M = {}

function M.promptAndCallFunction()
	-- Open a prompt for the user to enter text
	local input = ui()
	runner(input)
end

M.promptAndCallFunction()
return M
