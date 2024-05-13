print("hello world")

local function runner()
	print("Function running")
end

return {
	runner = runner,
}
