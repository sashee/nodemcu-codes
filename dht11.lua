local DHT_PIN = 1

local status, temp, humi, temp_dec, humi_dec = dht.read(DHT_PIN)
if status == dht.OK then
    print("" .. temp, "" .. humi)
elseif status == dht.ERROR_CHECKSUM then
    print( "DHT Checksum error.")
elseif status == dht.ERROR_TIMEOUT then
    print( "DHT timed out.")
end
