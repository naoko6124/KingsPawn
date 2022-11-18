map = {}

function create_map()
	for i = 0, 838 do
		map[i] = 0
		if (i >= 66 and i <= 772) then
			j = i % 43
			if (j >= 1 and j <=20) or (j >=23 and j <= 41) then
				map[i] = 1
			end
		end
	end
	return map
end

return create_map()