local WIFI_SSID = "__SSID__"
local WIFI_PASSWORD = "__PASS__"

wifi.setmode(wifi.STATION)
wifi.sta.config(WIFI_SSID, WIFI_PASSWORD)
