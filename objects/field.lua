love.graphics.setDefaultFilter("nearest")
local client = require "client"
local cfg = require "config"
local scripts = require "scripts"
local standard = require "objects.standard"
local loser = require "scenes.loser"
local winner = require "scenes.winner"

local tile_move = scripts.new_animation(love.graphics.newImage("sprites/utility/spr_tile_move.png"), 32, 32, 0.5)
local tile_kill = love.graphics.newImage("sprites/utility/spr_tile_kill.png")
local tile_selected = love.graphics.newImage("sprites/utility/spr_tile_selected.png")

local pass_turn_se = love.audio.newSource("songs/pass_turn.wav", "static")

local match = {}

local player = 0

local singleplayer = false

local turn = 0

local up = 0 - 43
local up_left = 0 - 22
local up_right = 0 - 21
local left = 0 - 1
local right = 0 + 1
local down_left = 0 + 21
local down_right = 0 + 22
local down = 0 + 43

local cursor, cursor_hover

local lost = false
local win = false

local inicio_turno = love.timer.getTime()

local tempo = 0

function update(dt)
	tile_move:update(dt)
	if (turn == player and not win) then
		tempo = love.timer.getTime() - inicio_turno
		if tempo > 60 then
			pass_turn()
		end
	end
end

function set_units(change_screen)
	loser.load(change_screen)
	winner.load(change_screen)

	cursor = love.mouse.newCursor("sprites/UI/cursor.png", 6, 6)
	cursor_hover = love.mouse.newCursor("sprites/UI/cursor_hover.png", 10, 6)

	local base, tower1, tower2

	-- Blue
	base = 131

	tower1 = base + right + down_right
	tower2 = base + down * 2 + down_left

	match[0].units[0] = { pos = base, tipo = "emperor" }
	match[0].units[1] = { pos = base + up, tipo = "wizard" }
	match[0].units[2] = { pos = base + up_left, tipo = "wizard" }
	match[0].units[3] = { pos = base + down_left, tipo = "halberd" }
	match[0].units[4] = { pos = base + down, tipo = "mage" }
	match[0].units[5] = { pos = base + down_right, tipo = "mage" }
	match[0].units[6] = { pos = base + up_right, tipo = "halberd" }
	match[0].units[7] = { pos = base + up + up_right, tipo = "dragon" }
	match[0].units[8] = { pos = base + left, tipo = "dragon" }

	match[0].units[9] = { pos = tower1, tipo = "tower" }
	match[0].units[10] = { pos = tower1 + up, tipo = "pawn" }
	match[0].units[11] = { pos = tower1 + up_left, tipo = "pawn" }
	match[0].units[12] = { pos = tower1 + down_left, tipo = "archer" }
	match[0].units[13] = { pos = tower1 + down, tipo = "pawn" }
	match[0].units[14] = { pos = tower1 + down_right, tipo = "pawn" }
	match[0].units[15] = { pos = tower1 + up_right, tipo = "archer" }

	match[0].units[16] = { pos = tower2, tipo = "tower" }
	match[0].units[17] = { pos = tower2 + up, tipo = "pawn" }
	match[0].units[18] = { pos = tower2 + up_left, tipo = "pawn" }
	match[0].units[19] = { pos = tower2 + down_left, tipo = "archer" }
	match[0].units[20] = { pos = tower2 + down, tipo = "pawn" }
	match[0].units[21] = { pos = tower2 + down_right, tipo = "pawn" }
	match[0].units[22] = { pos = tower2 + up_right, tipo = "archer" }

	-- Green
	base = 148

	tower1 = base + left + down_left
	tower2 = base + down * 2 + down_right

	match[1].units[0] = { pos = base, tipo = "emperor" }
	match[1].units[1] = { pos = base + up, tipo = "wizard" }
	match[1].units[2] = { pos = base + up_left, tipo = "halberd" }
	match[1].units[3] = { pos = base + down_left, tipo = "mage" }
	match[1].units[4] = { pos = base + down, tipo = "mage" }
	match[1].units[5] = { pos = base + down_right, tipo = "halberd" }
	match[1].units[6] = { pos = base + up_right, tipo = "wizard" }
	match[1].units[7] = { pos = base + up + up_left, tipo = "dragon" }
	match[1].units[8] = { pos = base + right, tipo = "dragon" }

	match[1].units[9] = { pos = tower1, tipo = "tower" }
	match[1].units[10] = { pos = tower1 + up, tipo = "pawn" }
	match[1].units[11] = { pos = tower1 + up_left, tipo = "archer" }
	match[1].units[12] = { pos = tower1 + down_left, tipo = "pawn" }
	match[1].units[13] = { pos = tower1 + down, tipo = "pawn" }
	match[1].units[14] = { pos = tower1 + down_right, tipo = "archer" }
	match[1].units[15] = { pos = tower1 + up_right, tipo = "pawn" }

	match[1].units[16] = { pos = tower2, tipo = "tower" }
	match[1].units[17] = { pos = tower2 + up, tipo = "pawn" }
	match[1].units[18] = { pos = tower2 + up_left, tipo = "archer" }
	match[1].units[19] = { pos = tower2 + down_left, tipo = "pawn" }
	match[1].units[20] = { pos = tower2 + down, tipo = "pawn" }
	match[1].units[21] = { pos = tower2 + down_right, tipo = "archer" }
	match[1].units[22] = { pos = tower2 + up_right, tipo = "pawn" }

	-- Orange
	base = 690

	tower1 = base + right + up_right
	tower2 = base + up * 2 + up_left

	match[2].units[0] = { pos = base, tipo = "emperor" }
	match[2].units[1] = { pos = base + up, tipo = "mage" }
	match[2].units[2] = { pos = base + up_left, tipo = "halberd" }
	match[2].units[3] = { pos = base + down_left, tipo = "wizard" }
	match[2].units[4] = { pos = base + down, tipo = "wizard" }
	match[2].units[5] = { pos = base + down_right, tipo = "halberd" }
	match[2].units[6] = { pos = base + up_right, tipo = "mage" }
	match[2].units[7] = { pos = base + down + down_right, tipo = "dragon" }
	match[2].units[8] = { pos = base + left, tipo = "dragon" }

	match[2].units[9] = { pos = tower1, tipo = "tower" }
	match[2].units[10] = { pos = tower1 + up, tipo = "pawn" }
	match[2].units[11] = { pos = tower1 + up_left, tipo = "archer" }
	match[2].units[12] = { pos = tower1 + down_left, tipo = "pawn" }
	match[2].units[13] = { pos = tower1 + down, tipo = "pawn" }
	match[2].units[14] = { pos = tower1 + down_right, tipo = "archer" }
	match[2].units[15] = { pos = tower1 + up_right, tipo = "pawn" }

	match[2].units[16] = { pos = tower2, tipo = "tower" }
	match[2].units[17] = { pos = tower2 + up, tipo = "pawn" }
	match[2].units[18] = { pos = tower2 + up_left, tipo = "archer" }
	match[2].units[19] = { pos = tower2 + down_left, tipo = "pawn" }
	match[2].units[20] = { pos = tower2 + down, tipo = "pawn" }
	match[2].units[21] = { pos = tower2 + down_right, tipo = "archer" }
	match[2].units[22] = { pos = tower2 + up_right, tipo = "pawn" }

	-- Pink
	base = 707

	tower1 = base + left + up_left
	tower2 = base + up * 2 + up_right

	match[3].units[0] = { pos = base, tipo = "emperor" }
	match[3].units[1] = { pos = base + up, tipo = "mage" }
	match[3].units[2] = { pos = base + up_left, tipo = "mage" }
	match[3].units[3] = { pos = base + down_left, tipo = "halberd" }
	match[3].units[4] = { pos = base + down, tipo = "wizard" }
	match[3].units[5] = { pos = base + down_right, tipo = "wizard" }
	match[3].units[6] = { pos = base + up_right, tipo = "halberd" }
	match[3].units[7] = { pos = base + down + down_left, tipo = "dragon" }
	match[3].units[8] = { pos = base + right, tipo = "dragon" }

	match[3].units[9] = { pos = tower1, tipo = "tower" }
	match[3].units[10] = { pos = tower1 + up, tipo = "pawn" }
	match[3].units[11] = { pos = tower1 + up_left, tipo = "pawn" }
	match[3].units[12] = { pos = tower1 + down_left, tipo = "archer" }
	match[3].units[13] = { pos = tower1 + down, tipo = "pawn" }
	match[3].units[14] = { pos = tower1 + down_right, tipo = "pawn" }
	match[3].units[15] = { pos = tower1 + up_right, tipo = "archer" }

	match[3].units[16] = { pos = tower2, tipo = "tower" }
	match[3].units[17] = { pos = tower2 + up, tipo = "pawn" }
	match[3].units[18] = { pos = tower2 + up_left, tipo = "pawn" }
	match[3].units[19] = { pos = tower2 + down_left, tipo = "archer" }
	match[3].units[20] = { pos = tower2 + down, tipo = "pawn" }
	match[3].units[21] = { pos = tower2 + down_right, tipo = "pawn" }
	match[3].units[22] = { pos = tower2 + up_right, tipo = "archer" }

	for key, unit in pairs(match[0].units) do
		unit.sprite = standard[unit.tipo].sprite()[0]
	end
	for key, unit in pairs(match[1].units) do
		unit.sprite = standard[unit.tipo].sprite()[1]
	end
	for key, unit in pairs(match[2].units) do
		unit.sprite = standard[unit.tipo].sprite()[2]
	end
	for key, unit in pairs(match[3].units) do
		unit.sprite = standard[unit.tipo].sprite()[3]
	end
end

function draw(on_hud, mouse_pos, selected_pos, selected_old, zoom, offset_x, offset_y, tiles, sx, sy)
	for id, p in pairs(match) do
		for key, unit in pairs(p.units) do
			local line = math.floor(unit.pos / 43)
			local first = unit.pos - line * 43
			local second = unit.pos - line * 43 - 22
			local x, y
			if (first < 22) then
				x = ((first * 50) * zoom + offset_x) * sx
				y = ((line * 32) * zoom + offset_y) * sy
			else
				x = ((second * 50 + 25) * zoom + offset_x) * sx
				y = ((line * 32 + 16) * zoom + offset_y) * sy
			end

			love.graphics.draw(
				unit.sprite,
				x,
				y,
				0, zoom * sx, zoom * sy
				)
		end
	end

	if lost then
		loser.draw()
	end

	if win then
		winner.draw(match[0].name)
	end

	if not on_hud and not lost and not win then
		love.mouse.setCursor(cursor)
		for key, unit in pairs(match[player].units) do
			local line = math.floor(unit.pos / 43)
			local first = unit.pos - line * 43
			local second = unit.pos - line * 43 - 22
			local x, y
			if (first < 22) then
				x = ((first * 50) * zoom + offset_x) * sx
				y = ((line * 32) * zoom + offset_y) * sy
			else
				x = ((second * 50 + 25) * zoom + offset_x) * sx
				y = ((line * 32 + 16) * zoom + offset_y) * sy
			end
			if (turn == player) then
				if (mouse_pos == unit.pos) then
					love.mouse.setCursor(cursor_hover)
				end

				if (selected_pos == unit.pos) then
					love.graphics.draw(
						tile_selected,
						x,
						y,
						0, zoom * sx, zoom * sy
					)
					show_moves(unit, zoom, offset_x, offset_y, tiles, sx, sy)
					show_kills(unit, zoom, offset_x, offset_y, sx, sy)
				elseif (selected_old == unit.pos) then
					local try_kill = kill(unit, selected_pos)
					local try_move = move(key, unit, selected_pos, tiles[selected_pos], selected_old)

					if (try_kill or try_move) then
						pass_turn()
					end
				end
			end
		end
	end
end

function show_moves(unit, zoom, offset_x, offset_y, tiles, sx, sy)
	for key, pos in pairs(standard[unit.tipo].can_move(unit.pos)) do
		local verify = false
		for key, tile in pairs(standard[unit.tipo].can_move_tiles(unit.pos)) do
			if (tiles[pos] == tile) then
				verify = true
			end
		end
		if (verify) then
			local advance = true
			for key, other_unit in pairs(match[player].units) do
				if (other_unit.pos == pos) then
					advance = false
				end
			end
			if (unit.tipo == "emperor") then
				for other_id, other_player in pairs(match) do
					for key, other_unit in pairs(match[other_id].units) do
						if (other_unit.pos == pos) then
							advance = false
						end
					end
				end
			end
			if advance then
				local line = math.floor(pos / 43)
				local first = pos - line * 43
				local second = pos - line * 43 - 22
				local x, y
				if (first < 22) then
					x = ((first * 50) * zoom + offset_x) * sx
					y = ((line * 32) * zoom + offset_y) * sy
				else
					x = ((second * 50 + 25) * zoom + offset_x) * sx
					y = ((line * 32 + 16) * zoom + offset_y) * sy
				end
				tile_move:draw(x, y, zoom * sx, zoom * sy)
			end
		end
	end
end

function show_kills(unit, zoom, offset_x, offset_y, sx, sy)
	for num, pos in pairs(standard[unit.tipo].can_kill(unit.pos)) do
		for id, user in pairs(match) do
			if id ~= player then
				for key, other_unit in pairs(match[id].units) do
					if (pos == other_unit.pos) then
						local line = math.floor(pos / 43)
						local first = pos - line * 43
						local second = pos - line * 43 - 22
						local x, y
						if (first < 22) then
							x = ((first * 50) * zoom + offset_x) * sx
							y = ((line * 32) * zoom + offset_y) * sy
						else
							x = ((second * 50 + 25) * zoom + offset_x) * sx
							y = ((line * 32 + 16) * zoom + offset_y) * sy
						end
						love.graphics.draw(
							tile_kill,
							x,
							y,
							0, zoom * sx, zoom * sy
							)
					end
				end
			end
		end
	end
end

function move(unit_id, unit, new_pos, new_tile)
	local success = false
	for key, pos in pairs(standard[unit.tipo].can_move(unit.pos)) do
		if (pos == new_pos) then
			local verify = false
			for key, tile in pairs(standard[unit.tipo].can_move_tiles(unit.pos)) do
				if (new_tile == tile) then
					verify = true
				end
			end
			if (verify) then
				local advance = true
				if (table.getn(match) > 0) then
					for key, other_unit in pairs(match[player].units) do
						if (other_unit.pos == new_pos) then
							advance = false
						end
					end
					if (unit.tipo == "emperor") then
						for other_id, other_player in pairs(match) do
							for key, other_unit in pairs(match[other_id].units) do
								if (other_unit.pos == new_pos) then
									advance = false
								end
							end
						end
					end
					if advance then
						match[player].units[unit_id].pos = new_pos
						if not singleplayer then
							print("enviando movimento")
							print("unit_id: " .. unit_id)
							print("new_pos: " .. new_pos)
							client.send("move")
							client.send(unit_id)
							client.send(new_pos)
						end
						success = true
						break
					end
				end
			end
		end
	end
	return success
end

function kill(unit, new_pos)
	local success = false
	for num, pos in pairs(standard[unit.tipo].can_kill(unit.pos)) do
		if (new_pos == pos) then
			for id, user in pairs(match) do
				if id ~= player then
					for key, other_unit in pairs(user.units) do
						if (other_unit.pos == new_pos) then
							if not singleplayer then
								client.send("kill")
								client.send(id)
								client.send(key)
							end
							if match[id].units[key].tipo == "emperor" then
								perder(id)
							end
							match[id].units[key] = nil
							success = true
						end
					end
				end
			end
		end
	end
	return success
end

function pass_turn()
	local se_volume, m_volume = cfg.get_volume()
	pass_turn_se:setVolume(se_volume/100)
	love.audio.play(pass_turn_se)
	if turn < table.getn(match) then
		turn = turn + 1
	else
		turn = 0
	end
	if singleplayer then
		player = turn
		inicio_turno = love.timer.getTime()
	else
		client.send("turn")
	end
end

function receber()
	if not singleplayer then
		local msg, err = client.receive_anytime()

		if (err == nil and msg ~= nil) then
			if (msg == "kill") then
				local target_id_network = tonumber(client.receive())
				unit_id_network = tonumber(client.receive())

				match[target_id_network].units[unit_id_network] = nil
				if (unit_id_network == 0) then
					perder(id_network)
				end
			if (msg == "killnmove") then
				local target_id_network = tonumber(client.receive())
				local unit_id_network = tonumber(client.receive())
				local id_network = tonumber(client.receive())
				local unit_id_2_network = tonumber(client.receive())
				local new_pos_network = tonumber(client.receive())

				match[target_id_network].units[unit_id_network] = nil
				match[id_network].units[unit_id_network].pos = new_pos_network
				if (unit_id_network == 0) then
					perder(id_network)
				end
			elseif (msg == "move") then
				local id_network = tonumber(client.receive())
				local unit_id_network = tonumber(client.receive())
				local new_pos_network = tonumber(client.receive())

				print(unit_id)
				match[id_network].units[unit_id_network].pos = new_pos_network
			end
			local se_volume, m_volume = cfg.get_volume()
			pass_turn_se:setVolume(se_volume/100)
			love.audio.play(pass_turn_se)
			inicio_turno = love.timer.getTime()
			if turn < table.getn(match) then
				turn = turn + 1
			else
				turn = 0
			end
		end
	end
end

function perder(id)
	match[id] = nil
	local i = 0
	local new_match = {}
	for k, p in pairs(match) do
		new_match[i] = p

		if (k == player) then
			player = i
		end

		i = i + 1
	end
	match = new_match
	if (table.getn(match) > 0) then
		if turn ~= player then
			turn = turn - 1
		end
	else
		ganhar(player)
		if not singleplayer then
			client.send("ganhei")
		end
	end
	if singleplayer then
		player = turn
	end
end

function ganhar(id)
	win = true
end

function get_turn()
	return turn
end

function get_player()
	return player
end

function set_player(p)
	player = p
end

function set_singleplayer()
	singleplayer = true
end

function get_timer()
	return tempo
end

function get_match()
	return match
end

function is_my_turn()
	if (player == turn) then
		return true
	else
		return false
	end
end

function mousepressed(x, y, button, istouch)
	if win then
		winner.mousepressed(x, y, button, istouch)
	end
	if lost then
		loser.mousepressed(x, y, button, istouch)
	end
end

return {
	update = update,
	match = match,
	get_match = get_match,
	draw = draw,
	get_player = get_player,
	set_player = set_player,
	get_turn = get_turn,
	set_units = set_units,
	receber = receber,
	set_singleplayer = set_singleplayer,
	get_timer = get_timer,
	is_my_turn = is_my_turn,
	mousepressed = mousepressed
}