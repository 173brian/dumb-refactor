print("hello world")

local function runner()
	print("Function running")
	print(vim.fn.getcwd())
end

return {
	runner = runner,
}
