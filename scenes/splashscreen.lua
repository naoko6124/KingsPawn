local client = require "client"

local background = nil
local font = nil

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/spr_home_background.png")
	font = love.graphics.newFont("fonts/minecraft.ttf", 32)
	if (client.connect()) then
		change_screen("home")
	else
		change_screen("error")
	end
end

function update(dt)

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

	love.graphics.print("Loading...", ww/2, wh/2)
end

function keypressed(key)

end

function mousepressed(x, y, button, istouch)

end

return {
	load = load,
	update = update,
	draw = draw,
	keypressed = keypressed,
	mousepressed = mousepressed
}