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
	local selection = vim.api.nvim_buf_get_selection(buf, 0)
	if selection[1] and selection[2] then
		local selected_lines = {}
		for i = selection[1], selection[2] do
			table.insert(selected_lines, bufferContent[i])
		end
		local selected_text = table.concat(selected_lines, "\n")
		return selected_text
	else
		return nil
	end
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
