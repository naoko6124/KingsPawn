local socket = require("socket")
local host, port = "localhost", 8080
tcp = assert(socket.tcp())

player = nil

function connect()
	local err = tcp:connect(host, port)
	if err == nil then
		return false
	else
		return true
	end
end

function receive()
	tcp:settimeout(0.01)
	return tcp:receive()
end

function send(mensagem)
	local err = tcp:send(mensagem.."\n")
	if err == nil then
		return false
	else
		return true
	end
end

function getPlayer()
	return player
end

function setPlayer(newPlayer)
	player = newPlayer
end

return {
	connect = connect,
	receive = receive,
	send = send,
	getPlayer = getPlayer,
	setPlayer = setPlayer
}