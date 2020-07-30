local mc = middleclass -- pass it around with a global

return function(a, b)
	if a==nil then
		return mc("Unnamed")
	elseif type(a)=="table" then
		return mc("Unnamed",a)
	elseif type(a)=="string" then
		return mc(a,b)
	end
end
