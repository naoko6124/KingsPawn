local scenes = {}
scenes["name"] = require "scenes.name"
scenes["connect"] = require "scenes.connect"
scenes["error"] = require "scenes.error"
scenes["home"] = require "scenes.home"
scenes["queue"] = require "scenes.queue"
scenes["game"] = require "scenes.game"
scenes["winner"] = require "scenes.winner"
scenes["loser"] = require "scenes.loser"

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

function afterdraw()
	scenes[current_scene].afterdraw()
end

function keypressed(key)
	scenes[current_scene].keypressed(key)
end

function mousepressed(x, y, button, istouch)
   scenes[current_scene].mousepressed(x, y, button, istouch)
end

function wheelmoved(dx, dy)
	scenes[current_scene].wheelmoved(dx, dy)
end

function textinput(t)
	scenes[current_scene].textinput(t)
end

return {
	load = load,
	update = update,
	draw = draw,
	afterdraw = afterdraw,
	keypressed = keypressed,
	mousepressed = mousepressed,
	wheelmoved = wheelmoved,
	textinput = textinput,
	set_current_scene = set_current_scene
}