local client = require "client"

local background = nil
local logo = nil

local screen_width = 256
local screen_height = 144

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

play = nil

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/spr_home_background.png")
	logo = love.graphics.newImage("sprites/logos/spr_home_logo.png")
	font = love.graphics.newFont("fonts/minecraft.ttf", 32)
	play = function() change_screen("game") end
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height
end

function draw()
	love.graphics.draw(
		background,
		0,
		0,
		0,
		ww/background:getWidth(),
		wh/background:getHeight()
	)

	love.graphics.draw(
		logo,
		(ww/2) - ((logo:getWidth() * sx)/2),
		(wh * 0.15),
		0,
		sx,
		sy
	)

	love.graphics.setColor(0, 0, 0)

	love.graphics.rectangle(
		"fill",
		ww/2-80,
		wh/2+10,
		160,
		80
	)

	love.graphics.setColor(1, 1, 1)

	love.graphics.rectangle(
		"fill",
		ww/2-80,
		wh/2-90,
		160,
		80
	)
end

function keypressed(key)

end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		if x > ww/2 - 80 and x < ww/2 + 80 then
			if y < wh/2 - 10 and y > wh/2 - 90 then
				client.send("branco")
				client.setPlayer("branco")
				play()
			end
			if y > wh/2 + 10 and y < wh/2 + 90 then
				client.send("preto")
				client.setPlayer("preto")
				play()
			end
		end
	end
end

return {
	load = load,
	update = update,
	draw = draw,
	keypressed = keypressed,
	mousepressed = mousepressed
}