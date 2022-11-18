love.graphics.setDefaultFilter("nearest")

local up = 0 - 43
local up_left = 0 - 22
local up_right = 0 - 21
local left = 0 - 1
local right = 0 + 1
local down_left = 0 + 21
local down_right = 0 + 22
local down = 0 + 43

function create_tileset()
	local tileset = {}
	tileset["ocean"] = love.graphics.newImage("sprites/tiles/spr_ocean.png")
	tileset["plains"] = love.graphics.newImage("sprites/tiles/spr_plains.png")
	tileset["mountain"] = love.graphics.newImage("sprites/tiles/spr_mountain.png")
	tileset["desert"] = love.graphics.newImage("sprites/tiles/spr_desert.png")

	tileset["ocean_bridge"] = love.graphics.newImage("sprites/tiles/spr_ocean_bridge.png")

	tileset["plains_castle"] = love.graphics.newImage("sprites/tiles/spr_plains_castle.png")
	tileset["plains_florest"] = love.graphics.newImage("sprites/tiles/spr_plains_florest.png")
	tileset["plains_village"] = love.graphics.newImage("sprites/tiles/spr_plains_village.png")

	tileset["mountain_castle"] = love.graphics.newImage("sprites/tiles/spr_mountain_castle.png")
	tileset["mountain_cloud"] = love.graphics.newImage("sprites/tiles/spr_mountain_cloud.png")

	tileset["desert_esfinge"] = love.graphics.newImage("sprites/tiles/spr_desert_esfinge.png")
	tileset["desert_oasis"] = love.graphics.newImage("sprites/tiles/spr_desert_oasis.png")
	tileset["desert_piramid"] = love.graphics.newImage("sprites/tiles/spr_desert_piramid.png")

	return tileset
end
function create_tiles()
	local mapa = love.graphics.newImage("objects/maps/map2.png")
	local mapa_data = love.image.newImageData("objects/maps/map2.png")
	
	local map = {}

	local i = 0
	local j = 22

	for y = 0, mapa_data:getHeight() - 32, 16 do
		local x_limit = mapa_data:getWidth() - 32
		if (y % 32 == 16) then
			x_limit = mapa_data:getWidth() - 82
		end
        for x = 0, x_limit, 50 do
        	local r, g, b = mapa_data:getPixel(x + 28, y + 15)
        	if (r == (48/255) and g == (190/255) and b == (183/255)) then
        		map[i] = "ocean"
        	elseif (r == (72/255) and g == (190/255) and b == (48/255)) then
        		map[i] = "plains"
        	elseif (r == (107/255) and g == (107/255) and b == (107/255)) then
        		map[i] = "mountain"
        	elseif (r == (188/255) and g == (197/255) and b == (120/255)) then
        		map[i] = "desert"
        	elseif (r == (181/255) and g == (136/255) and b == (89/255)) then
        		map[i] = "ocean_bridge"
        	elseif (r == (48/255) and g == (103/255) and b == (37/255)) then
        		map[i] = "plains_castle"
        	elseif (r == (117/255) and g == (156/255) and b == (64/255)) then
        		map[i] = "plains_florest"
        	elseif (r == (67/255) and g == (132/255) and b == (54/255)) then
        		map[i] = "plains_village"
        	elseif (r == (130/255) and g == (130/255) and b == (130/255)) then
        		map[i] = "mountain_cloud"
        	elseif (r == (76/255) and g == (76/255) and b == (76/255)) then
        		map[i] = "mountain_castle"
        	elseif (r == (164/255) and g == (197/255) and b == (120/255)) then
        		map[i] = "desert_oasis"
        	elseif (r == (236/255) and g == (237/255) and b == (161/255)) then
        		map[i] = "desert_esfinge"
        	elseif (r == (161/255) and g == (154/255) and b == (82/255)) then
        		map[i] = "desert_piramid"
        	end
        	i = i + 1
        end
    end

	return map
end

return {
	create_tileset = create_tileset,
	create_tiles = create_tiles
}