local setup = function(callback)
    wifi.setmode(wifi.STATION);
    
    wifi.sta.config("__NETWORK__", "__PASS__");
    tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
        print(wifi.sta.getip())
    
        m = mqtt.Client("clientid", 120);
    
        local connected = function()
            print("connected");
            m:subscribe("/gettemp", 0)
            m:subscribe("/getdist", 0)
            callback(m);
        end;

        m:connect("192.168.0.4", 1883, 0, connected, function(client, reason) print(reason) end)
    end);
end;

return function()
    setup(function(m)
        m:on("message", function(c, topic, data)
            if topic == "/gettemp" then
                require("dht11")(function(temp, humi)
                    m:publish("/temp", temp, 0, 0);
                    m:publish("/humi", humi, 0, 0);
                end)
            end;
            if topic == "/getdist" then
                require("hcsr04")(function(dist)
                    m:publish("/dist", dist, 0, 0);
                end)
            end;
        end);
    end)
end;
