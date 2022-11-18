local client = require "client"
local field = require "objects.field"

local background = nil
local font = nil

local screen_width = 256
local screen_height = 144

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

local jogar = nil

local partida = {}

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_match.png")
	font = love.graphics.newImageFont("fonts/pixel.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"_", 1)

	jogar = function() change_screen("game") end
	partida[field.get_player()] = {name = client.get_name(), units = {}}
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height

	local resposta, err = client.receive_anytime()
	if err == nil and resposta ~= nil then
		if resposta == "entrou" then
			local tamanho = tonumber(client.receive())
			for i = tamanho, 0, -1 do
				partida[i] = {name = client.receive(), units = {}}
			end
		elseif resposta == "partida" then
			partida[0] = {name = client.receive(), units = {}}
			partida[1] = {name = client.receive(), units = {}}
			partida[2] = {name = client.receive(), units = {}}
			partida[3] = {name = client.receive(), units = {}}
			field.set_match(partida)
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

	for uid, player in pairs(partida) do
		love.graphics.printf(player.name, font, 96 * sx, (50 + 15 * uid) * sy, 1000, "left", 0, sx, sy)
	end
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