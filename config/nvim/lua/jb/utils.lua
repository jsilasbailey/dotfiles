local M = {}

---Require a plugin config
---@param name string
---@return any
function M.config(name)
	local filePath = string.format("jb.plugins.config.%s", name)
	return require(filePath).config
end

return M
