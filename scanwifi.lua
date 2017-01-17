local utils = require("utils")
local timer = require("timer")

local scanwifi = {}

local function connectToKnowNetwork(t)
    local networks = utils.keys(t)
    local net1 = utils.findInArray(networks, "__NETWORK1__")
    local net2 = utils.findInArray(networks, "__NETWORK2__")
    if net1 then
        print("Connecting to __NETWORK1__")
        wifi.sta.config("__NETWORK1__", "__PASS1__")
    elseif net2 then
        print("Connecting to __NETWORK2__")
        wifi.sta.config("__NETWORK2__", "__PASS2__")
    else
        print("Retrying")
        timer.setTimeout(scanwifi.setup, 5000)
    end
end

function scanwifi.setup()
    print("Connecting to WiFi")
    wifi.setmode(wifi.STATION)
    
    wifi.sta.getap(connectToKnowNetwork)
end

return scanwifi
