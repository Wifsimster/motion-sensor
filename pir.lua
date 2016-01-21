require('config')

ID = "557" -- Jeedom virtual device id
PIN = 3 -- GPIO0

-- Setup GPIO
gpio.mode(PIN, gpio.INPUT)

prev_value = 0;

-- Send motion value to Jeedom
function sendData(value)
    conn=net.createConnection(net.TCP, 0)
    conn:on("receive", function(conn, payload) print(payload) end )
    conn:connect(80,HOST)
    conn:send("GET /core/api/jeeApi.php?apikey="..API.."&type=virtual&id="..ID.."&value="..value.."HTTP/1.1\r\n")
    conn:send("Host: localhost\r\n") 
    conn:send("Accept: */*\r\n") 
    conn:send("User-Agent: Mozilla/4.0 (compatible; esp8266 Lua; Windows NT 5.1)\r\n")
    conn:send("\r\n")
end

function readMotion()
    value = gpio.read(PIN)
    if value ~= prev_value then
        prev_value = value
        sendData(value)
    end
end

-- Periodic reading of the sensor
tmr.alarm(1,1000,1, function()readMotion()end)