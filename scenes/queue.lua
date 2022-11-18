local client = require "client"
local field = require "objects.field"

local background = nil

jogar = nil

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_loading.png")
	jogar = function() change_screen("game") end
end

function update(dt)
	local resposta, err = client.receive_anytime()
	if err == nil and resposta ~= nil then
		if resposta == "partida" then
			field.match[0] = {name = client.receive(), units = {}}
			field.match[1] = {name = client.receive(), units = {}}
			field.match[2] = {name = client.receive(), units = {}}
			field.match[3] = {name = client.receive(), units = {}}

			jogar()
		end
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