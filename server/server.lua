local socket = require("socket")
local server = assert(socket.bind("*", 8080))

print("Server started!")

totalclient = 0
clients = {}

jogador_preto = nil
jogador_branco = nil

pecas_pretas = {}
pecas_brancas = {}

while true do

	server:settimeout(0.01)
	local client, err = server:accept()

	if not err then
		totalclient = totalclient + 1
		clients[totalclient] = client
		print(">> " .. tostring(client:getsockname()) .. " entrou!")
	end

	for i = 1, totalclient do
		if (clients[i] ~= nil) then
			clients[totalclient]:settimeout(0.01)
			clientmessage, err = clients[i]:receive()

			if (err == nil and clientmessage ~= nil and clientmessage ~= "") then
				if (clients[i] == jogador_preto) then
					print("a: " .. clientmessage)
					for j = 1, totalclient do
						if clients[j] == jogador_branco then
							clients[j]:send(clientmessage .. "\n")
						end
					end
				end
				if (clients[i] == jogador_branco) then
					print("b: " .. clientmessage)
					for j = 1, totalclient do
						if clients[j] == jogador_preto then
							clients[j]:send(clientmessage .. "\n")
						end
					end
				end
				if (jogador_preto == nil and clientmessage == "preto") then
					jogador_preto = clients[i]
					if (jogador_branco ~= nil) then
						clients[i]:send("turno\n")
						print("a")
					end
				end
				if (jogador_branco == nil and clientmessage == "branco") then
					jogador_branco = clients[i]
					if (jogador_preto ~= nil) then
						clients[i]:send("turno\n")
						print("b")
					end
				end
			end
		end
	end

end