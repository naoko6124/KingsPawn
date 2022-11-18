local client = require "client"
local utf8 = require("utf8")

local background = nil
local logo = nil

local screen_width = 256
local screen_height = 144

local ww = love.graphics.getWidth()
local wh = love.graphics.getHeight()

local sx = ww/screen_width
local sy = wh/screen_height

connect = nil
home = nil

local mouse_x, mouse_y = love.mouse.getPosition()

local cursor, cursor_hover

local name = "insert your name here"

local name_show = ""

local piscando = love.timer.getTime()

local error = 0

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_nome.png")
	font = love.graphics.newImageFont("fonts/pixel.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"_", 1)

	cursor = love.mouse.newCursor("sprites/UI/cursor.png", 6, 6)
	cursor_hover = love.mouse.newCursor("sprites/UI/cursor_hover.png", 10, 6)

	connect = function() change_screen("connect") end
	home = function() change_screen("home") end
end

function update(dt)
	ww = love.graphics.getWidth()
	wh = love.graphics.getHeight()

	sx = ww/screen_width
	sy = wh/screen_height

	mouse_x, mouse_y = love.mouse.getPosition()

	love.mouse.setCursor(cursor)
	if mouse_y >= 80 * sy and mouse_y <= 96 * sy then
		if mouse_x >= 104 * sx and mouse_x <= 151 * sx then
			love.mouse.setCursor(cursor_hover)
		end
	end
	if mouse_y >= 117 * sy and mouse_y <= 136 * sy then
		if mouse_x >= 4 * sx and mouse_x <= 26 * sx then
			love.mouse.setCursor(cursor_hover)
		end
	end

	name_show = name
	local tempo = love.timer.getTime() - piscando
	if tempo > 1 then
		piscando = love.timer.getTime()
	elseif tempo > 0.5 and name:len() < 12 then
		name_show = name_show .. "_"
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

	love.graphics.printf(name_show, font, 88 * sx, 51 * sy, 1000, "left", 0, sx, sy)
	

	local tempo2 = love.timer.getTime() - error
	if (tempo2 < 5) then
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", 53 * sx, 66 * sy, 162 * sx, 11 * sy)
		love.graphics.setColor(1, 0.4, 0.4)
		love.graphics.printf("Your name must have at least 6 characters!", font, 56 * sx, 69 * sy, 1000, "left", 0, sx, sy)
		love.graphics.setColor(1, 1, 1)
	end
end

function afterdraw()

end

function keypressed(key)
	if key == "backspace" then
	    -- get the byte offset to the last UTF-8 character in the string.
	    local byteoffset = utf8.offset(name, -1)

	    if byteoffset then
	        -- remove the last UTF-8 character.
	        -- string.sub operates on bytes rather than UTF-8 characters, so we couldn't do string.sub(text, 1, -2).
	        name = string.sub(name, 1, byteoffset - 1)
	    end
	 end
	 if key == "return" then
		if name:len() <= 6 then
			error = love.timer.getTime()
		end
		if name:len() >= 6 and name:len() <= 12 then
			client.set_name(name)
			love.mouse.setCursor(cursor)
			connect()
		end
	 end
end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		if mouse_y >= 80 * sy and mouse_y <= 96 * sy then
			if mouse_x >= 104 * sx and mouse_x <= 151 * sx then
				if name:len() <= 6 then
					error = love.timer.getTime()
				end
				if name:len() >= 6 and name:len() <= 12 then
					client.set_name(name)
					love.mouse.setCursor(cursor)
					connect()
				end
			end
		end

		if mouse_y >= 117 * sy and mouse_y <= 136 * sy then
			if mouse_x >= 4 * sx and mouse_x <= 26 * sx then
				home()
			end
		end
	end
end

function wheelmoved(dx, dy)

end

function textinput(t)
	if (name == "insert your name here") then
		name = t
    else
    	if (name:len() < 12) then
    		name = name .. t
    	end
    end
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