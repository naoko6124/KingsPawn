local sound_effect
local music

function load()
	love.graphics.setBackgroundColor(1, 1, 1, 1)
	love.graphics.setDefaultFilter("nearest")
	love.window.setMode(1024, 576, {resizable = true})
	sound_effect = 50
	music = 50
end

function keypressed(key)
	if key == "f11" then
		local fullscreen, fstype = love.window.getFullscreen()
		if (fullscreen == true) then
			love.window.setFullscreen(false)
		else
			love.window.setFullscreen(true)
		end
	end
end

function set_volume(new_se, new_m)
	sound_effect = new_se
	music = new_m
end

function get_volume()
	return sound_effect, music
end

return {
	load = load,
	keypressed = keypressed,
	set_volume = set_volume,
	get_volume = get_volume
}