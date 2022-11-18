local config = require "config"

local background = nil
local font = nil

local screen_width = 256
local screen_height = 144

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

local cursor, cursor_hover

local settings_button

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_config.png")
	settings_button = love.graphics.newImage("sprites/UI/settings.png")

	font = love.graphics.newImageFont("fonts/pixel.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"_", 1)

	cursor = love.mouse.newCursor("sprites/UI/cursor.png", 6, 6)
	cursor_hover = love.mouse.newCursor("sprites/UI/cursor_hover.png", 10, 6)
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height

	mouse_x, mouse_y = love.mouse.getPosition()

	love.mouse.setCursor(cursor)
	if mouse_x >= 69 * sx and mouse_x <= 167 * sx then
		if mouse_y >= 72 * sy and mouse_y <= 80 * sy then
			love.mouse.setCursor(cursor_hover)
		end
		if mouse_y >= 90 * sy and mouse_y <= 98 * sy then
			love.mouse.setCursor(cursor_hover)
		end
	end
end

function draw(sx, sy)
	love.graphics.draw(
		background,
		0,
		0,
		0,
		ww/background:getWidth(),
		wh/background:getHeight()
	)

	local sound_effect, music = config.get_volume()
	love.graphics.draw(settings_button, (65 + sound_effect) * sx, 72 * sy, 0, sx, sy)
	love.graphics.draw(settings_button, (65 + music) * sx, 90 * sy, 0, sx, sy)
end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		local sound_effect, music = config.get_volume()
		mouse_x, mouse_y = love.mouse.getPosition()
		if mouse_x >= 70 * sx and mouse_x <= 170 * sx then
			if mouse_y >= 72 * sy and mouse_y <= 80 * sy then
				sound_effect = math.floor((mouse_x/sx + 0.5)) - 70
			end
			if mouse_y >= 90 * sy and mouse_y <= 98 * sy then
				music = math.floor((mouse_x/sx + 0.5)) - 70
			end
		end
		config.set_volume(sound_effect, music)
	end
end

return {
	load = load,
	update = update,
	draw = draw,
	mousepressed = mousepressed
}