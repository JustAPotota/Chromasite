local M = {}

local active_sonars = {}

---@param factory_url url|string
---@param position vector3
---@param color vector4
---@param seconds_left vector4[]
function M.new_sonar(factory_url, position, color, seconds_left)
	assert(#seconds_left <= 256)

	local position = vmath.vector3(position.x, position.y, #active_sonars / 100)
	local object_id = factory.create(factory_url, position)
	local model_url = msg.url(nil, object_id, "model")

	go.set_scale(vmath.vector3(1000, 1000, 1), object_id)
	go.set(model_url, "params.x", color.x)
	go.set(model_url, "params.y", color.y)
	go.set(model_url, "params.z", color.z)
	go.animate(model_url, "params.w", go.PLAYBACK_ONCE_FORWARD, 4, go.EASING_LINEAR, 4)

	for i, v in ipairs(seconds_left) do
		go.set(model_url, "seconds_left", v, { index = i })
	end

	table.insert(active_sonars, {
		seconds_alive = 0,
		model_url = model_url
	})
end

---@param dt number
function M.update(dt)
	for i, sonar in ipairs(active_sonars) do
		sonar.seconds_alive = sonar.seconds_alive + dt
		if sonar.seconds_alive >= 4 then
			go.delete(sonar.model_url)
			table.remove(active_sonars, i)
		end
	end
end

return M
