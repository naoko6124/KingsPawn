local client = require "client"

local cfg = require "config"

local map = require "objects.map"

local field = require "objects.field"

local screen_width = 1024
local screen_height = 576

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

local offset_x, offset_y = 50, 50

local music

function load(change_screen)
	music = love.audio.newSource("songs/game_music.mp3", "static")
	map.load(change_screen)
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height

	local se_volume, m_volume = cfg.get_volume()
	music:setVolume(m_volume/100)

	map.update(dt)

	if not music:isPlaying() then
		love.audio.play(music)
	end
end

function draw()
	map.draw(sx, sy)
end

function afterdraw()

end

function keypressed(key)

end

function mousepressed(x, y, button, istouch)
	map.mousepressed(x, y, button, istouch)
end

function wheelmoved(dx, dy)
	map.wheelmoved(dx, dy)
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