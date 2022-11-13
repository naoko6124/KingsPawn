local client = require "client"

local background = nil

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/spr_home_background.png")
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

	love.graphics.print("Error!", ww/2, wh/2)
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