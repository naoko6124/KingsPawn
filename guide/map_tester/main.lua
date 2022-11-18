local tile_hover

local tileset = {}

local tiles = require "test_map"

local map_x, map_y = 1056, 623

local zoom = 1

local offset_x = zoom * -25

local offset_y = zoom * -16

ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

mouse_x, mouse_y = love.mouse.getPosition()

local font

function pan_screen(x,y)
	offset_x = offset_x + x
	offset_y = offset_y + y

	if (offset_x > (-25 * zoom)) then
		offset_x = (-25 * zoom)
	end
	if (offset_y > (-16 * zoom)) then
		offset_y = (-16 * zoom)
	end
	if (offset_x < (1024 - 1056 * zoom)) then
		offset_x = (1024 - 1056 * zoom)
	end
	if (offset_y < (576 - 623 * zoom)) then
		offset_y = (576 - 623 * zoom)
	end
end

function love.load()
	love.graphics.setDefaultFilter("nearest")
	love.graphics.setBackgroundColor(1, 1, 1, 1)
	love.window.setMode(1024, 576, {resizable = true})
	tileset[0] = love.graphics.newImage("tiles/spr_ocean.png")
	tileset[1] = love.graphics.newImage("tiles/spr_plains.png")
	tileset[2] = love.graphics.newImage("tiles/spr_mountain.png")
	tileset[3] = love.graphics.newImage("tiles/spr_desert.png")
	tile_hover = love.graphics.newImage("utility/spr_tile_hover.png")

	mouse_x, mouse_y = love.mouse.getPosition()

	font = love.graphics.newFont("pixel.ttf", 10)
end

function love.update(dt)
	local start_x, start_y = mouse_x, mouse_y
	mouse_x, mouse_y = love.mouse.getPosition()
	
	if (love.mouse.isDown(1)) then
		pan_screen(mouse_x - start_x, mouse_y - start_y)
	end
end

function love.draw()
	for i = 0, 838 do
		local line = math.floor(i / 43)
		local first = i - line * 43
		local second = i - line * 43 - 22
		local x, y

		if (first < 22) then
			x = (first * 50) * zoom + offset_x
			y = (line * 32) * zoom + offset_y
		else
			x = (second * 50 + 25) * zoom + offset_x
			y = (line * 32 + 16) * zoom + offset_y
		end

		love.graphics.draw(
			tileset[tiles[i]],
			x,
			y,
			0, zoom, zoom
			)

		love.graphics.printf(i, font, x + 10 * zoom, y + 4 * zoom, love.graphics.getWidth())

		distance = math.sqrt((mouse_x - (x + 16 * zoom))^2 + (mouse_y - (y + 16 * zoom))^2)

		if (distance < 14 * zoom) then
			love.graphics.draw(
				tile_hover,
				x,
				y,
				0, zoom, zoom
				)
		end
	end
end

function love.mousepressed(x, y, button, istouch)
	if button == 1 then
		mouse_x, mouse_y = love.mouse.getPosition()
	end
end

function love.wheelmoved( dx, dy )
    if (zoom + dy/10 > zoom) then
    	if (zoom + dy/10 > 4) then zoom = 4
    	else zoom = zoom + dy/10 end
    	pan_screen(0, 0)
    else
    	if (zoom + dy/10 < 1) then zoom = 1
    	else zoom = zoom + dy/10 end
    	pan_screen(0, 0)
    end
end