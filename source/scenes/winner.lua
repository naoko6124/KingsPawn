local client = require "client"

local background = nil
local font = nil

local home = nil

local screen_width = 256
local screen_height = 144

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

local mouse_x, mouse_y = love.mouse.getPosition()

local cursor, cursor_hover

function load(change_screen)
	home = function() change_screen("home") end
	background = love.graphics.newImage("sprites/backgrounds/tela_winner.png")

	font = love.graphics.newImageFont("fonts/pixel.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"_", 1)

	cursor = love.mouse.newCursor("sprites/UI/cursor.png", 6, 6)
	cursor_hover = love.mouse.newCursor("sprites/UI/cursor_hover.png", 10, 6)
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height
end

function draw()
	local ww = love.graphics.getWidth()
	local wh = love.graphics.getHeight()

	love.graphics.draw(
		background,
		0,
		0,
		0,
		ww/background:getWidth(),
		wh/background:getHeight()
	)

	mouse_x, mouse_y = love.mouse.getPosition()
	love.mouse.setCursor(cursor)

	if mouse_y >= 80 * sy and mouse_y <= 96 * sy then
		if mouse_x >= 108 * sx and mouse_x <= 147 * sx then
			love.mouse.setCursor(cursor_hover)
		end
	end
end

function afterdraw()

end

function keypressed(key)

end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		if y >= 80 * sy and y <= 96 * sy then
			if x >= 108 * sx and x <= 147 * sx then
				home()
			end
		end
	end
end

function wheelmoved(dx, dy)

end

function textinput(t)

end

return {
	load = load,
	update = update,
	draw = draw,
	afterdraw = afterdraw,
	keypressed = keypressed,
	mousepressed = mousepressed,
	wheelmoved = wheelmoved,
	textinput = textinput
}