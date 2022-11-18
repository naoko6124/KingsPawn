local client = require "client"
local field = require "objects.field"

local background = nil

queue = nil
error = nil

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_loading.png")

	queue = function() change_screen("queue") end
	error = function() change_screen("error") end
end

function update(dt)
	if (client.connect()) then
		client.send("play")
		field.set_player(tonumber(client.receive()))
		queue()
	else
		error()
	end
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
end

function afterdraw()
	
end

function keypressed(key)

end

function mousepressed(x, y, button, istouch)

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