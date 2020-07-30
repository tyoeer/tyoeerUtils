local path = select(1,...) .. "."

local f = function(mc)
	if type(mc)=="function" or type(mc)=="table" then
		--setup OOP
		local oldMiddleclass = middleclass
		middleclass = mc
		require(path.."oop")
		middleclass = oldMiddleclass
		return f
	elseif type(mc)=="string" then
		return require(path)
	end
end

return f
