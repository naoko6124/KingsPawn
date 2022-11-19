local host, port = "localhost", 0
if (arg[1] ~= nil) then
	host = arg[1]
end
if (arg[2] ~= nil) then
	port = arg[2]
end

local socket = require("socket")
local server = assert(socket.bind(host, port))

local ip, pt = server:getsockname()

print("Server started at " .. ip .. " at port " .. pt .. "!")

totalclient = 0
clients = {}
clients_name = {}

partidas = {}

-- {
-- 	current = 0
-- 	players = {
-- 		0 = {
-- 			id = 0,
-- 			name = ""
-- 		}
-- 	}
-- }

while true do

	server:settimeout(0.01)
	local client, err = server:accept()

	if err == nil then
		server:settimeout(2)
		local clientname, err = client:receive()
		if (err == nil and clientname ~= nil and clientname ~= "") then
			totalclient = totalclient + 1
			clients[totalclient] = client
			clients_name[totalclient] = clientname
			print(">> " .. clientname .. " entrou!")
			client:send(totalclient .. "\n")
		else
			client:send("error\n")
		end
	end

	for i = 1, totalclient do
		local ta_livre = true
		for antes_pid, antes_partida in pairs(partidas) do
			for antes_uid, antes_player in pairs(antes_partida.players) do
				if (antes_player.id == i) then
					ta_livre = false
				end
			end
		end
		if (clients[i] ~= nil and ta_livre) then
			clients[i]:settimeout(0.01)
			local clientmessage, err = clients[i]:receive()

			if (err == nil and clientmessage == "play") then
				local hasPartida = false
				for key, partida in pairs(partidas) do
					if (partida.current < 4) then
						partida.players[partida.current] = {id = i, name = clients_name[i]}
						clients[i]:send(partida.current .. "\n")
						partida.current = partida.current + 1
						print(clients_name[i] .. " entrou na partida de " .. partida.players[0].name .. " (" .. partida.current .. "/4)")
						if (partida.current == 4) then
							for key, player in pairs(partida.players) do
								clients[player.id]:send("partida\n")
								clients[player.id]:send(partida.players[0].name .. "\n")
								clients[player.id]:send(partida.players[1].name .. "\n")
								clients[player.id]:send(partida.players[2].name .. "\n")
								clients[player.id]:send(partida.players[3].name .. "\n")
							end
							print("partida de " .. partida.players[0].name .. " iniciada")
						else
							for uid, player in pairs(partida.players) do
								clients[player.id]:send("entrou\n")
								clients[player.id]:send((partida.current - 1) .. "\n")
								for oid, other in pairs(partida.players) do
									clients[player.id]:send(other.name .. "\n")
								end
							end
						end
						hasPartida = true
						break
					end
				end
				if not hasPartida then
					local partida = {current = 1, players = {}, turno = 0}
					partida.players[0] = {id = i, name = clients_name[i]}
					table.insert(partidas, partida)
					clients[i]:send("0\n")
					print("partida criada por " .. clients_name[i] .. " (1/4)")
				end
			end
		end
	end

	for pid, partida in pairs(partidas) do
		if partida.current == 4 then
			for uid, player in pairs(partida.players) do
				clients[player.id]:settimeout(0.01)
				local clientmessage, err = clients[player.id]:receive()

				if (err == nil and clientmessage ~= nil and clientmessage ~= "") then
					if (clientmessage == "kill") then
						clients[player.id]:settimeout(4)
						local target_id = tonumber(clients[player.id]:receive())
						clients[player.id]:settimeout(4)
						local unit_id = tonumber(clients[player.id]:receive())

						print("target_id: " .. target_id)
						clients[partida.players[target_id].id]:send("perdeu\n")

						if unit_id == 0 then
							local new_match = {}
							local j = 0
							for k = 0, table.getn(partida.players) do
								if (k == target_id) then
								else
									new_match[j] = partida.players[k]
									print(j .. ": " .. partida.players[k].name)
									j = j + 1
								end
							end

							partidas[pid].players = new_match
							partida.players = new_match
						end

						local unit_id_2, new_pos

						clients[player.id]:settimeout(4)
						local msg, er = clients[player.id]:receive()
						if (er == nil and msg ~= nil and msg == "move") then
							clients[player.id]:settimeout(4)
							unit_id_2 = clients[player.id]:receive()
							clients[player.id]:settimeout(4)
							new_pos = clients[player.id]:receive()
						end

						for k, other in pairs(partida.players) do
							print(k)
							print(other.name)
							if (player.id ~= other.id) then
								clients[other.id]:send("killnmove\n")
								clients[other.id]:send(target_id .. "\n")
								clients[other.id]:send(unit_id .. "\n")
								if (err == nil and msg ~= nil and msg == "move") then
									print(uid .. " - " .. unit_id_2)
									clients[other.id]:send(uid .. "\n")
									clients[other.id]:send(unit_id_2 .. "\n")
									clients[other.id]:send(new_pos .. "\n")
								end
							end
						end
					elseif (clientmessage == "move") then
						clients[player.id]:settimeout(4)
						local unit_id = clients[player.id]:receive()
						clients[player.id]:settimeout(4)
						local new_pos = clients[player.id]:receive()

						print(unit_id .. ": " .. new_pos)

						for other_id, other in pairs(partida.players) do
							if (player.id ~= other.id) then
								clients[other.id]:send("move\n")
								clients[other.id]:send(uid .. "\n")
								clients[other.id]:send(unit_id .. "\n")
								clients[other.id]:send(new_pos .. "\n")
							end
						end
					elseif (clientmessage == "turn") then
						for other_id, other in pairs(partida.players) do
							if (player.id ~= other_id) then
								clients[other.id]:send("turn\n")
							end
						end
					elseif (clientmessage == "ganhei") then
						for other_id, other in pairs(partida.players) do
							if (player.id ~= other_id) then
								clients[other.id]:send("ganhou\n")
								clients[other.id]:send(uid .. "\n")
							end
						end
					end
				end
			end
		end
	end
end