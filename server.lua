local function roundToPlace(number, place)
	place = place or 1
	number = tonumber(number)
	number *= (10 ^ place)
	number = number >= 0 and math.floor(number + 0.5) or math.ceil(number - 0.5)
	return number / (10 ^ place)
end

local function saveToFile(file, data)
	if not data or data == '' then return end
	local path, newData = file .. '.lua'
	local oldData = LoadResourceFile(cache.resource, path)
	if oldData == nil or oldData == '' then
		newData = data
	else
		newData = oldData .. '\n' .. data
	end
	SaveResourceFile(cache.resource, path, newData, -1)
end

RegisterServerEvent('dd_tools:save', function(data, file)
	file = file or 'saved'
	local str

	if data.w then
		str = ('vec4(%s),'):format(string.strjoin(', ', roundToPlace(data.x), roundToPlace(data.y), roundToPlace(data.z), roundToPlace(data.w)))
	else
		str = ('vec3(%s),'):format(string.strjoin(', ', roundToPlace(data.x), roundToPlace(data.y), roundToPlace(data.z)))
	end

	print(str)
	saveToFile(file, str)
end)
