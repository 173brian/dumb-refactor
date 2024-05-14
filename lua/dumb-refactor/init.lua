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
	print(start_pos)
	print(end_pos)
end

local function runner(input)
	local buf = vim.api.nvim_get_current_buf()
	local bufLineCount = vim.api.nvim_buf_line_count(buf)
	local bufferContent = vim.api.nvim_buf_get_lines(buf, 0, bufLineCount, false)
	local whitespaceCounts = getLeadingWhitespacePerLine(bufferContent)
	local selection = getSelection(buf, bufferContent)
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
