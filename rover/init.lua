local WIFI_SSID = "..."
local WIFI_PASSWORD = "..."

wifi.setmode(wifi.STATION)
wifi.sta.config(WIFI_SSID, WIFI_PASSWORD)

tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
    require("main")()
end)
