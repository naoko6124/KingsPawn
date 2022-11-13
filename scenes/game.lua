local map = require "maps.mapa4"

local offset_for_placement_x = 0 -- 62
local offset_for_placement_y = 0 -- 24

local spr_tile, spr_tile_hover, spr_tile_selected
local spr_piece_black, spr_piece_white, spr_piece_blue, spr_piece_red

local background = nil

local zoom = 1
local screen_width = 256 * zoom -- 256
local screen_height = 144 * zoom -- 144

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

-- x and y of each hexagon
-- local map = {
-- 	{x = 0, y = 0},
-- 	{x = 50, y = 0},
-- 	{x = 100, y = 0},

-- 	{x = 25, y = 16},
-- 	{x = 75, y = 16},

-- 	{x = 0, y = 32},
-- 	{x = 100, y = 32},
-- 	{x = 150, y = 32},

-- 	{x = 25, y = 48},
-- 	{x = 75, y = 48},

-- 	{x = 0, y = 64},
-- 	{x = 50, y = 64},
-- 	{x = 100, y = 64},

-- 	{x = 25, y = 80},
-- 	{x = 75, y = 80}
-- }

local player = {
	{x = 0, y = 0},
	{x = 0, y = 32},
	{x = 0, y = 64}
}

local enemy = {
	{x = 100, y = 0},
	{x = 100, y = 32},
	{x = 100, y = 64}
}

local mouse_x, mouse_y

local selected_piece = nil
local possible_sides = {}
local possible_eat = {}

local my_turn = false

function load(change_screen)
	my_turn = true
	background = love.graphics.newImage("sprites/backgrounds/spr_game_background.png")
	spr_tile = love.graphics.newImage("sprites/scenario/spr_tile.png")
	spr_tile_hover = love.graphics.newImage("sprites/scenario/spr_tile_hover.png")
	spr_tile_selected = love.graphics.newImage("sprites/scenario/spr_tile_selected.png")
	spr_piece_black = love.graphics.newImage("sprites/pieces/spr_piece_black.png")
	spr_piece_white = love.graphics.newImage("sprites/pieces/spr_piece_white.png")
	spr_piece_blue = love.graphics.newImage("sprites/pieces/spr_piece_blue.png")
	spr_piece_red = love.graphics.newImage("sprites/pieces/spr_piece_red.png")
end

function update(dt)
    mouse_x, mouse_y = love.mouse.getPosition()
end

function draw()
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height

	love.graphics.draw(
		background,
		0,
		0,
		0,
		ww/background:getWidth(),
		wh/background:getHeight()
	)

	for key, tile in pairs(map) do
		local x = tile.x + offset_for_placement_x
		local y = tile.y + offset_for_placement_y

		love.graphics.draw(spr_tile, x * sx, y * sy, 0, sx, sy)

    	distance = (((x + 16) * sx - mouse_x)^2 + ((y + 16) * sy - mouse_y)^2)^(1/2)

		if (distance < 14 * sx) then
			love.graphics.draw(spr_tile_hover, x * sx, y * sy, 0, sx, sy)
		end
	end

   if selected_piece ~= nil then
		local x = selected_piece.x + offset_for_placement_x
		local y = selected_piece.y + offset_for_placement_y

		love.graphics.draw(spr_tile_selected, x * sx, y * sy, 0, sx, sy)
	end

	for key, piece in pairs(player) do
		local x = piece.x + offset_for_placement_x
		local y = piece.y + offset_for_placement_y
		love.graphics.draw(spr_piece_black, x * sx, y * sy, 0, sx, sy)
	end

	for key, piece in pairs(enemy) do
		local x = piece.x + offset_for_placement_x
		local y = piece.y + offset_for_placement_y
		love.graphics.draw(spr_piece_white, x * sx, y * sy, 0, sx, sy)
	end

	if selected_piece ~= nil then
		possible_sides = {}
		possible_eat = {}

		local to_test = {
			{x = selected_piece.x + 25, y = selected_piece.y + 16},
			{x = selected_piece.x, y = selected_piece.y + 32},
			{x = selected_piece.x - 25, y = selected_piece.y + 16},
			{x = selected_piece.x + 25, y = selected_piece.y - 16},
			{x = selected_piece.x, y = selected_piece.y - 32},
			{x = selected_piece.x - 25, y = selected_piece.y - 16}
		}

		on_map = {}

		for key, tile in pairs(map) do
			for keyA, side in pairs(to_test) do
				if tile.x == side.x and tile.y == side.y then
					table.insert(on_map, side)
				end
			end
		end

		for key, piece in pairs(player) do
			for keyA, side in pairs(on_map) do
				if piece.x == side.x and piece.y == side.y then
					table.remove(on_map, keyA)
				end
			end
		end

		for key, piece in pairs(enemy) do
			for key, side in pairs(on_map) do
				if piece.x ~= side.x or piece.y ~= side.y then
					table.insert(possible_sides, side)
				else
					table.insert(possible_eat, side)
				end
			end
		end

		for key, possible in pairs(possible_sides) do
			local x = possible.x + offset_for_placement_x
			local y = possible.y + offset_for_placement_y
			love.graphics.draw(spr_piece_blue, x * sx, y * sy, 0, sx, sy)
		end

		for key, possible in pairs(possible_eat) do
			local x = possible.x + offset_for_placement_x
			local y = possible.y + offset_for_placement_y
			love.graphics.draw(spr_piece_red, x * sx, y * sy, 0, sx, sy)
		end
	end
end

function keypressed(key)

end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		if my_turn then
			local moved = false

			if selected_piece ~= nil then
				for key, possible in pairs(possible_sides) do
					local px = possible.x + offset_for_placement_x
					local py = possible.y + offset_for_placement_y

		    		local distance = (((px + 16) * sx - x)^2 + ((py + 16) * sy - y)^2)^(1/2)

					if (distance < 14 * sx) then
							for key, piece in pairs(player) do
								if piece.x == selected_piece.x and piece.y == selected_piece.y then
									piece.x = possible.x
									piece.y = possible.y
									moved = true
									pass_turn()
									break
								end
							end
						break
					end
				end
				for key, possible in pairs(possible_eat) do
					local px = possible.x + offset_for_placement_x
					local py = possible.y + offset_for_placement_y

		    		local distance = (((px + 16) * sx - x)^2 + ((py + 16) * sy - y)^2)^(1/2)

					if (distance < 14 * sx) then
							for key, piece in pairs(player) do
								if piece.x == selected_piece.x and piece.y == selected_piece.y then
									piece.x = possible.x
									piece.y = possible.y
									moved = true
									for keyD, dead in pairs(enemy) do
										if dead.x == possible.x and dead.y == possible.y then
											table.remove(enemy, keyD)
										end
									end
									if (table.getn(enemy)) == 0 then
										win_game()
									else
										pass_turn()
									end
									break
								end
							end
						break
					end
				end
			end

			if not moved then
				local exists = false

				for key, piece in pairs(player) do
					local px = piece.x + offset_for_placement_x
					local py = piece.y + offset_for_placement_y

			    	local distance = (((px + 16) * sx - x)^2 + ((py + 16) * sy - y)^2)^(1/2)

					if (distance < 14 * sx) then
						exists = true
						selected_piece = piece
						break
					end
				end
				if not exists then
					selected_piece = nil
				end
			else
				selected_piece = nil

			end
		end
	end
	if (button == 2) then
		zoom = zoom - 0.1;

		screen_width = 256 * zoom -- 256
		screen_height = 144 * zoom -- 144

		ww = love.graphics.getWidth()
		wh = love.graphics.getHeight()

		sx = ww/screen_width
		sy = wh/screen_height
	end
	if (button == 3) then
		zoom = zoom + 0.1;

		screen_width = 256 * zoom -- 256
		screen_height = 144 * zoom -- 144

		ww = love.graphics.getWidth()
		wh = love.graphics.getHeight()

		sx = ww/screen_width
		sy = wh/screen_height
	end
end

function pass_turn()
	-- my_turn = false
end


function win_game()

end

return {
	load = load,
	update = update,
	draw = draw,
	keypressed = keypressed,
	mousepressed = mousepressed
}