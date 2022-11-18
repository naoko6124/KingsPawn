local socket = require("socket")
local host, port = "localhost", 8080
tcp = assert(socket.tcp())

my_id = 0

name = ""

function connect()
	tcp:settimeout(0.1)
	local err = tcp:connect(host, port)
	if err == nil then
		return false
	else
		tcp:send(name .. "\n")
		tcp:settimeout(2)
		local msg, err2 = tcp:receive()
		if err2 == nil and msg ~= nil and msg ~= "error" then
			my_id = tonumber(msg)
			return true
		else
			return false
		end
	end
end

function receive_anytime()
	tcp:settimeout(0.01)
	return tcp:receive()
end

function receive()
	tcp:settimeout(2)
	return tcp:receive()
end

function send(mensagem)
	tcp:settimeout(0.01)
	local err = tcp:send(mensagem.."\n")
	if err == nil then
		return false
	else
		return true
	end
end

return {
	connect = connect,
	receive_anytime = receive_anytime,
	receive = receive,
	send = send,
	id = my_id,
	name = name
}