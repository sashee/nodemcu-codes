gpio.mode(1, gpio.OUTPUT);
gpio.mode(2, gpio.OUTPUT);

return function()
    print(wifi.sta.getip())
    m = mqtt.Client("clientid", 120);
    local connected = function()
        print("connected");
        m:subscribe("/bal", 0)
        m:subscribe("/jobb", 0)

        m:on("message", function(c, topic, data)
            if topic == "/bal" then
                if data == "1" then
                    print("bal on");
                    gpio.write(2, gpio.HIGH);
                else
                    print("bal off");
                    gpio.write(2, gpio.LOW);
                end
            elseif topic == "/jobb" then
                if data == "1" then
                    print("jobb on");
                    gpio.write(1, gpio.HIGH);
                else
                    print("jobb off");
                    gpio.write(1, gpio.LOW);
                end
            end
        end);
    end;
    
    m:connect("192.168.0.4", 1883, 0, connected, function(client, reason) print(reason) end)
    print("init");
end
