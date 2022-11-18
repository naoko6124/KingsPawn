local socket = require("socket")
local host = "localhost"
local port = 8080

local my_id = 0

local name = ""

function connect()
	tcp = assert(socket.tcp())
	print(host .. ":" .. port)
	tcp:settimeout(2)
	local err = tcp:connect(host, port)
	print(err)
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

function set_host(new_host)
	host = new_host
end

function set_port(new_port)
	port = new_port
end

function get_name()
	return name
end

function set_name(new_name)
	name = new_name
end

return {
	set_host = set_host,
	set_port = set_port,
	connect = connect,
	receive_anytime = receive_anytime,
	receive = receive,
	send = send,
	id = my_id,
	get_name = get_name,
	set_name = set_name
}