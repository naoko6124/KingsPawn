local config = require "config"
local scene_manager = require "scene_manager"

function love.load()
	config.load()
	scene_manager.load()
end

function love.update(dt)
	scene_manager.update(dt)
end

function love.draw()
	scene_manager.draw()
	scene_manager.afterdraw()
end

function love.keypressed(key)
	config.keypressed(key)
	scene_manager.keypressed(key)
end

function love.mousepressed(x, y, button, istouch)
   scene_manager.mousepressed(x, y, button, istouch)
end

function love.wheelmoved(dx, dy)
	scene_manager.wheelmoved(dx, dy)
end

function love.textinput(t)
	scene_manager.textinput(t)
end