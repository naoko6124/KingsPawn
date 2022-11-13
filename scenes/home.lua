function new_button(sprite, action)
	return {
		sprite = sprite,
		action = action
	}
end

local background = nil
local logo = nil
local buttons = {}
local font = nil

local button_mark = nil
local current_button = 0

local screen_width = 256
local screen_height = 144

function load(change_screen)
	background = love.graphics.newImage("sprites/backgrounds/spr_home_background.png")
	logo = love.graphics.newImage("sprites/logos/spr_home_logo.png")
	font = love.graphics.newFont("fonts/minecraft.ttf", 32)
	button_mark = love.graphics.newImage("sprites/buttons/spr_btn_current.png")

	table.insert(buttons, new_button(
		love.graphics.newImage("sprites/buttons/spr_btn_new_game.png"),
		function ()
			change_screen("game")
		end))
	table.insert(buttons, new_button(
		love.graphics.newImage("sprites/buttons/spr_btn_load_game.png"),
		function ()
			print("Load Game")
		end))
	table.insert(buttons, new_button(
		love.graphics.newImage("sprites/buttons/spr_btn_settings.png"),
		function ()
			print("Settings")
		end))
	table.insert(buttons, new_button(
		love.graphics.newImage("sprites/buttons/spr_btn_quit_game.png"),
		function ()
			love.event.quit(0)
		end))
end

function update(dt)

end

function draw()
	local ww = love.graphics.getWidth()
	local wh = love.graphics.getHeight()

	local sx = ww/screen_width
	local sy = wh/screen_height

	local margin = sy * 2

	local button_height = button_mark:getHeight() * sy
	local total_height = (button_height + margin) * #buttons

	local cursor_y = 0

	love.graphics.draw(
		background,
		0,
		0,
		0,
		ww/background:getWidth(),
		wh/background:getHeight()
	)

	love.graphics.draw(
		logo,
		(ww/2) - ((logo:getWidth() * sx)/2),
		(wh * 0.15),
		0,
		sx,
		sy
	)


	love.graphics.draw(
		button_mark,
		(ww/2) - ((button_mark:getWidth() * sx)/2),
		(wh*2/3) - (total_height/2) + current_button * (button_height + margin),
		0,
		sx,--(button_width*4/3)/button_mark:getWidth(),
		sy--button_height/button_mark:getHeight()
	)

	for i, button in ipairs(buttons) do
		local button_width = button.sprite:getWidth() * sx

		local bx = (ww/2) - (button_width/2)
		local by = (wh*2/3) - (total_height/2) + cursor_y

		love.graphics.draw(
			button.sprite,
			bx,
			by,
			0,
			sx,--button_width/button.sprite:getWidth(),
			sy--button_height/button.sprite:getHeight()
		)
		cursor_y = cursor_y + (button_height + margin)
	end
end

function keypressed(key)
	if key == "down" and current_button < 3 then
		current_button = current_button + 1
	end
	if key == "up" and current_button > 0 then
		current_button = current_button - 1
	end
	if key == "z" then
		buttons[current_button + 1].action()
	end
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