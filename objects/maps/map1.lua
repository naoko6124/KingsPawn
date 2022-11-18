local up = 0 - 43
local up_left = 0 - 22
local up_right = 0 - 21
local left = 0 - 1
local right = 0 + 1
local down_left = 0 + 21
local down_right = 0 + 22
local down = 0 + 43

function create_tileset()
	love.graphics.setDefaultFilter("nearest")

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
	local map = {}


	for i = 0, 838 do
		map[i] = "ocean"
	end

	local base = 0

	-- Blue
	base = 131
	map[base] = "plains_castle"
	map[base+up] = "plains_village"
	map[base+up_left] = "plains_village"
	map[base+up_right] = "plains_village"
	map[base+down_left] = "plains_village"
	map[base+down_right] = "plains_village"
	map[base+down] = "plains_village"

	map[base+up*2] = "mountain"
	map[base+up+up_left] = "mountain"
	map[base+up+up_right] = "mountain"
	map[base+up_left*2] = "mountain"
	map[base+up_right*2] = "mountain"
	map[base+up_left] = "plains_village"
	map[base+up_right] = "plains_village"
	map[base+down_left] = "plains_village"
	map[base+down_right] = "plains_village"
	map[base+down] = "plains_village"

	-- Green
	base = 148
	map[base] = "plains_castle"
	map[base+up] = "plains_village"
	map[base+up_left] = "plains_village"
	map[base+up_right] = "plains_village"
	map[base+down_left] = "plains_village"
	map[base+down_right] = "plains_village"
	map[base+down] = "plains_village"

	-- Orange
	base = 690
	map[base] = "plains_castle"
	map[base+up] = "plains_village"
	map[base+up_left] = "plains_village"
	map[base+up_right] = "plains_village"
	map[base+down_left] = "plains_village"
	map[base+down_right] = "plains_village"
	map[base+down] = "plains_village"

	-- Pink
	base = 707
	map[base] = "plains_castle"
	map[base+up] = "plains_village"
	map[base+up_left] = "plains_village"
	map[base+up_right] = "plains_village"
	map[base+down_left] = "plains_village"
	map[base+down_right] = "plains_village"
	map[base+down] = "plains_village"

	return map
end

return {
	create_tileset = create_tileset,
	create_tiles = create_tiles
}