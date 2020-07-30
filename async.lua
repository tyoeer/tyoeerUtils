
local sys = {}

--config
local minFPS = 100

--other
local maxDt = 1/minFPS
local lastTime = -700
local queue = require(select(1,...) .. ".entitypool"):new()
local messages = {}

sys.first = function()
	lastTime = love.timer.getTime()
end

sys.update = function()
	while (love.timer.getTime() - lastTime <= maxDt) do
		local process = queue:getBottom()
		if process then
			local success, errorOrMessage = coroutine.resume(process,unpack(messages[process]))
			if not success then
				error("Error during async process: "..errorOrMessage)
			end
			if errorOrMessage then
				messages[process] = errorOrMessage
			end
			if coroutine.status(process)=="dead" then
				queue:remove(process)
			end
		else
			break
		end
	end
end

sys.interrupt = function(...)
	return coroutine.yield({...})
end

sys.newProcess = function(func,...)
	local co = coroutine.create(func)
	queue:add(co)
	messages[co] = {...}
	messages[co].init = true
	return co
end

sys.suspend = function(co)
	co = co or queue:getBottom()
	queue:remove(co)
	queue:addAtTop(co)
end

sys.dispose = function(co)
	messages[co] = nil
	--remove() already checks wether or not the queue has this one
end

sys.getStatus = function(co)
	if queue:has(co) then
		if queue:getBottom()==co then
			return "active"
		else
			return "queued"
		end
	else
		if messages[co] then
			return "finished"
		else
			return "unavailable"
		end
	end
end

sys.getCurrentProcess = function()
	return queue:getBottom()
end

sys.getMessage = function(co)
	if messages[co] then
		return unpack(messages[co])
	else
		return nil
	end
end

sys.getMessageTable = function(co)
	return messages[co]
end

sys.setMessage = function(co, ...)
	messages[co] = {...}
end

return sys
