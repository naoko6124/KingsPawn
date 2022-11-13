function load()
	love.graphics.setDefaultFilter("nearest")
	love.window.setMode(1280, 720, {resizable = true})
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

return {
	load = load,
	keypressed = keypressed
}