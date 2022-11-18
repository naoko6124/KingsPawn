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

local name = nil
local home = nil

local mouse_x, mouse_y = love.mouse.getPosition()

local cursor, cursor_hover, cursor_text

local server_host = "server host"
local server_port = "port"

local server_ip_show = ""
local server_port_show = ""

local selected_one = 1

local piscando = love.timer.getTime()

local error = 0

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/tela_host.png")
	font = love.graphics.newImageFont("fonts/pixel.png", " abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789.,!?-+/():;%&`'*#=[]\"_", 1)

	cursor = love.mouse.newCursor("sprites/UI/cursor.png", 6, 6)
	cursor_hover = love.mouse.newCursor("sprites/UI/cursor_hover.png", 10, 6)
	cursor_text = love.mouse.newCursor("sprites/UI/cursor_text.png", 6, 4)

	name = function() change_screen("name") end
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
		if mouse_x >= 112 * sx and mouse_x <= 143 * sx then
			love.mouse.setCursor(cursor_hover)
		end
	end
	if mouse_y >= 117 * sy and mouse_y <= 136 * sy then
		if mouse_x >= 7 * sx and mouse_x <= 26 * sx then
			love.mouse.setCursor(cursor_hover)
		end
	end
	if mouse_y >= 46 * sy and mouse_y <= 60 * sy then
		if mouse_x >= 151 * sx and mouse_x <= 204 * sx then
			love.mouse.setCursor(cursor_text)
		end
		if mouse_x >= 51 * sx and mouse_x <= 146 * sx then
			love.mouse.setCursor(cursor_text)
		end
	end

	if selected_one == 1 then
		server_host_show = server_host
		server_port_show = server_port
		local tempo = love.timer.getTime() - piscando
		if tempo > 1 then
			piscando = love.timer.getTime()
		elseif tempo > 0.5 and server_host:len() < 18 then
			server_host_show = server_host .. "_"
		end
	elseif selected_one == 2 then
		server_host_show = server_host
		server_port_show = server_port
		local tempo = love.timer.getTime() - piscando
		if tempo > 1 then
			piscando = love.timer.getTime()
		elseif tempo > 0.5 and server_port:len() < 5 then
			server_port_show = server_port .. "_"
		end
	else
		server_host_show = server_host
		server_port_show = server_port
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

	love.graphics.printf(server_host_show, font, 56 * sx, 51 * sy, 1000, "left", 0, sx, sy)
	love.graphics.printf(server_port_show, font, 158 * sx, 51 * sy, 1000, "left", 0, sx, sy)

	local tempo2 = love.timer.getTime() - error
	if (tempo2 < 5) then
		love.graphics.setColor(1, 1, 1)
		love.graphics.rectangle("fill", 53 * sx, 66 * sy, 162 * sx, 11 * sy)
		love.graphics.setColor(1, 0.4, 0.4)
		love.graphics.printf("Your host must have at least 7 characters!", font, 56 * sx, 69 * sy, 1000, "left", 0, sx, sy)
		love.graphics.setColor(1, 1, 1)
	end
end

function afterdraw()

end

function keypressed(key)
	if key == "backspace" then
		if (selected_one == 1) then
		    local byteoffset = utf8.offset(server_host, -1)

		    if byteoffset then
		        server_host = string.sub(server_host, 1, byteoffset - 1)
		    end
		elseif (selected_one == 2) then
		    local byteoffset = utf8.offset(server_port, -1)

		    if byteoffset then
		        server_port = string.sub(server_port, 1, byteoffset - 1)
		    end
		end
	end
	if key == "tab" then
		selected_one = selected_one + 1
		if selected_one == 3 then selected_one = 1 end
	end
	if key == "return" then
		if server_host:len() < 7 then
			error_port = love.timer.getTime()
		end
		if server_host:len() >= 7 and server_port:len() <= 18 and server_host ~= "server host" then
			client.set_host(server_host)

			if server_host:len() < 1 then
				error_port = love.timer.getTime()
			end
			if server_host:len() >= 1 and server_port:len() <= 5 and server_port ~= "port" then
				client.set_port(tonumber(server_port))
				name()
			end
		end
	end
end

function mousepressed(x, y, button, istouch)
	if button == 1 then
		if mouse_y >= 80 * sy and mouse_y <= 96 * sy then
			if mouse_x >= 112 * sx and mouse_x <= 143 * sx then
				if server_host:len() < 7 then
					error_port = love.timer.getTime()
				end
				if server_host:len() >= 7 and server_port:len() <= 18 and server_host ~= "server host" then
					client.set_host(server_host)

					if server_host:len() < 1 then
						error_port = love.timer.getTime()
					end
					if server_host:len() >= 1 and server_port:len() <= 5 and server_port ~= "port" then
						client.set_port(tonumber(server_port))
						name()
					end
				end
			end
		end

		if mouse_y >= 117 * sy and mouse_y <= 136 * sy then
			if mouse_x >= 7 * sx and mouse_x <= 26 * sx then
				home()
			end
		end

		if mouse_y >= 46 * sy and mouse_y <= 60 * sy then
			if mouse_x >= 51 * sx and mouse_x <= 146 * sx then
				selected_one = 1
			elseif mouse_x >= 151 * sx and mouse_x <= 204 * sx then
				selected_one = 2
			else
				selected_one = 0
			end
		else
			selected_one = 0
		end
	end
end

function wheelmoved(dx, dy)

end

function textinput(t)
	if (selected_one == 1) then
		if (server_host == "server host") then
			server_host = t
	    else
	    	if (server_host:len() < 18) then
	    		server_host = server_host .. t
	    	end
	    end
	elseif (selected_one == 2) then
		if t == tostring(tonumber(t)) then
			if (server_port == "port") then
				server_port = t
		    else
		    	if (server_port:len() < 5) then
		    		server_port = server_port .. t
		    	end
		    end
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