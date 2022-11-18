local client = require "client"
local field = require "objects.field"
local config = require "scenes.config"
local cfg = require "config"

local background = nil

local screen_width = 256
local screen_height = 144

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

local play_online = nil

local play_local = nil

local mouse_x, mouse_y = love.mouse.getPosition()

local cursor, cursor_hover

local on_config = false

local music

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_inicial.png")

	music = love.audio.newSource("songs/menu_music.wav", "static")

	cursor = love.mouse.newCursor("sprites/UI/cursor.png", 6, 6)
	cursor_hover = love.mouse.newCursor("sprites/UI/cursor_hover.png", 10, 6)

	play_online = function() change_screen("host") end
	play_local = function() change_screen("game") end

	config.load(change_screen)
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height

	mouse_x, mouse_y = love.mouse.getPosition()

	local se_volume, m_volume = cfg.get_volume()
	music:setVolume(m_volume/100)

	if on_config then
		config.update(dt)
	end

	if not music:isPlaying() then
		love.audio.play(music)
	end

	if not on_config then
		love.mouse.setCursor(cursor)
		if mouse_y >= 80 * sy and mouse_y <= 96 * sy then
			if mouse_x >= 63 * sx and mouse_x <= 111 * sx then
				love.mouse.setCursor(cursor_hover)
			end
			if mouse_x >= 144 * sx and mouse_x <= 192 * sx then
				love.mouse.setCursor(cursor_hover)
			end
		end
	end
	if mouse_y >= 117 * sy and mouse_y <= 136 * sy then
		if mouse_x >= 229 * sx and mouse_x <= 248 * sx then
			love.mouse.setCursor(cursor_hover)
		end
	end
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
	if on_config then
		config.draw(sx, sy)
	end
end

function afterdraw()

end

function keypressed(key)

end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		if not on_config then
			if mouse_y >= 80 * sy and mouse_y <= 96 * sy then
				if mouse_x >= 63 * sx and mouse_x <= 111 * sx then
					love.audio.stop(music)
					play_online()
				end
				if mouse_x >= 144 * sx and mouse_x <= 192 * sx then
					field.set_player(0)
					field.match[0] = {name = "Jogador 1", units = {}}
					field.match[1] = {name = "Jogador 2", units = {}}
					field.match[2] = {name = "Jogador 3", units = {}}
					field.match[3] = {name = "Jogador 4", units = {}}
					field.set_singleplayer()
					love.audio.stop(music)
					play_local()
				end
			end
		end
		if mouse_y >= 117 * sy and mouse_y <= 136 * sy then
			if mouse_x >= 229 * sx and mouse_x <= 248 * sx then
				on_config = not on_config
			end
		end
	end
	if on_config then
		config.mousepressed(x, y, button, istouch)
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