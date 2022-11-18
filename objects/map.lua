local scripts = require "scripts"
local config = require "scenes.config"
local field = require "objects.field"
local standard = require "objects.standard"
local hud = require "objects.hud"
local map1 = require "objects.maps.map2"

local on_hud = false

local tiles, tileset

local tile_hover

local zoom = 4

local offset_x = zoom * -25

local offset_y = zoom * -16

ww = love.graphics.getWidth()
wh = love.graphics.getHeight()

mouse_x, mouse_y = love.mouse.getPosition()

local mouse_pos, selected_pos, selected_old = 0, 0, 0

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

function load(change_screen)
	field.set_units(change_screen)
	hud.load(change_screen)
	tiles = map1.create_tiles()
	tileset = map1.create_tileset()
	tile_hover = love.graphics.newImage("sprites/utility/spr_tile_hover.png")

	mouse_x, mouse_y = love.mouse.getPosition()

	if (field.get_player() == 0) then
		offset_x = zoom * -25
		offset_y = zoom * -16
	end
	if (field.get_player() == 1) then
		offset_x = 1024 - 1056 * zoom
		offset_y = zoom * -16
	end
	if (field.get_player() == 2) then
		offset_x = zoom * -25
		offset_y = 576 - 623 * zoom
	end
	if (field.get_player() == 3) then
		offset_x = 1024 - 1056 * zoom
		offset_y = 576 - 623 * zoom
	end
end

function update(dt)
	local start_x, start_y = mouse_x, mouse_y
	mouse_x, mouse_y = love.mouse.getPosition()
	
	if (love.mouse.isDown(2)) then
		pan_screen(mouse_x - start_x, mouse_y - start_y)
	end
	
	field.update(dt)
	
	hud.update(dt)

	on_hud = hud.get_on_hud()

	field.receber()
end

function draw(sx, sy)
	for i = 0, 838 do
		local line = math.floor(i / 43)
		local first = i - line * 43
		local second = i - line * 43 - 22
		local x, y

		if (first < 22) then
			x = ((first * 50) * zoom + offset_x) * sx
			y = ((line * 32) * zoom + offset_y) * sy
		else
			x = ((second * 50 + 25) * zoom + offset_x) * sx
			y = ((line * 32 + 16) * zoom + offset_y) * sy
		end

		love.graphics.draw(
			tileset[tiles[i]],
			x,
			y,
			0, zoom * sx, zoom * sy
			)

		if not on_hud then
			distance = math.sqrt((mouse_x - (x + 16 * zoom * sx))^2 + (mouse_y - (y + 16 * zoom * sy))^2)

			if (distance < 14 * zoom) then
				mouse_pos = i
				love.graphics.draw(
					tile_hover,
					x,
					y,
				0, zoom * sx, zoom * sy
					)
			end
		end
	end

	field.draw(on_hud, mouse_pos, selected_pos, selected_old, zoom, offset_x, offset_y, tiles, sx, sy)

	selected_old = selected_pos

	hud.draw(sx, sy)
end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		selected_pos = mouse_pos
	end
	if button == 2 then
		mouse_x, mouse_y = love.mouse.getPosition()
	end
	hud.mousepressed(x, y, button, istouch)
	field.mousepressed(x, y, button, istouch)
end

function wheelmoved(dx, dy)
	mouse_x, mouse_y = love.mouse.getPosition()

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

return {
	map = map,
	load = load,
	update = update,
	draw = draw,
	mousepressed = mousepressed,
	wheelmoved = wheelmoved,
	tiles = tiles
}