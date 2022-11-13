local scenes = {}
scenes["home"] = require "scenes.home"
scenes["game"] = require "scenes.game"

local current_scene = "home"

function set_current_scene(scene_name)
	current_scene = scene_name
	scenes[current_scene].load(set_current_scene)
end

function load()
	scenes[current_scene].load(set_current_scene)
end

function update(dt)
	scenes[current_scene].update(dt)
end

function draw()
	scenes[current_scene].draw()
end

function keypressed(key)
	scenes[current_scene].keypressed(key)
end

function mousepressed(x, y, button, istouch)
   scenes[current_scene].mousepressed(x, y, button, istouch)
end

return {
	load = load,
	update = update,
	draw = draw,
	keypressed = keypressed,
	mousepressed = mousepressed,
	set_current_scene = set_current_scene
}