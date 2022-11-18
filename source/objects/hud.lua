local field = require "objects.field"
local config = require "scenes.config"

local background = nil
local font = nil

local screen_width = 512
local screen_height = 288

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

local apagada, acesa
local your_turn

local on_hud

local on_config = false

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_game.png")
	your_turn = love.graphics.newImage("sprites/UI/your_turn.png")

	apagada = love.graphics.newImage("sprites/UI/bolinha_apagada.png")
	acesa = love.graphics.newImage("sprites/UI/bolinha_acesa.png")

	font = love.graphics.newImageFont("fonts/pixel.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"_", 1)

	config.load(change_screen)
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height

	mouse_x, mouse_y = love.mouse.getPosition()

	if on_config then
		config.update(dt)
		ond_hud = true
	end

	if not on_config then
		on_hud = false
		love.mouse.setCursor(cursor)
		if mouse_y >= 0 * sy and mouse_y <= 31 * sy then
			if mouse_x >= 0 * sx and mouse_x <= 48 * sx then
				love.mouse.setCursor(cursor_hover)
				on_hud = true
			end
		end
		if mouse_y >= 268 * sy and mouse_y <= 287 * sy then
			if mouse_x >= 492 * sx and mouse_x <= 511 * sx then
				love.mouse.setCursor(cursor_hover)
				on_hud = true
			end
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

	for id, player in pairs(field.get_match()) do
		love.graphics.draw(apagada, 6 * sx, (6 + 14 * id) * sy, 0, sx, sy)
		if (id == field.get_turn()) then
			love.graphics.draw(acesa, 6 * sx, (6 + 14 * id) * sy, 0, sx, sy)
		end
		love.graphics.printf(player.name, font, 18 * sx, (6 + 14 * id) * sy, 1000, "left", 0, sx*2, sy*2)
	end

	if (field.is_my_turn()) then
		love.graphics.draw(
			your_turn,
			0,
			0,
			0,
			ww/background:getWidth(),
			wh/background:getHeight()
		)
		local minutos = math.floor((60 - math.floor(field.get_timer())) / 60)
		local segundos = (60 - math.floor(field.get_timer())) - minutos * 60
		if minutos < 10 then
			minutos = "0" .. minutos
		end
		if segundos < 10 then
			segundos = "0" .. segundos
		end
		love.graphics.printf(minutos, font, 978 * sx, 6 * sy, 1000, "left", 0, sx*2, sy*2)
		love.graphics.printf(" : " .. segundos, font, 992 * sx, 6 * sy, 1000, "left", 0, sx*2, sy*2)
	end

	if on_config then
		config.draw(sx * 4, sy * 4)
	end
end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		if mouse_y >= 268 * sy and mouse_y <= 287 * sy then
			if mouse_x >= 492 * sx and mouse_x <= 511 * sx then
				on_config = not on_config
			end
		end
	end
	if on_config then
		config.mousepressed(x, y, button, istouch)
	end
end

function get_on_hud()
	return on_hud
end

return {
	load = load,
	update = update,
	draw = draw,
	mousepressed = mousepressed,
	get_on_hud = get_on_hud
}
