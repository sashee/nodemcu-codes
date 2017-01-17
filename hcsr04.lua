return function(callback)
    local trigPin = 2;
    local echoPin = 5;
    gpio.mode(trigPin, gpio.OUTPUT);
    gpio.mode(echoPin, gpio.INT);

    local measure = function(callback)
        gpio.write(trigPin, gpio.LOW);
        gpio.write(trigPin, gpio.HIGH);
        tmr.create():alarm(10, tmr.ALARM_SINGLE, function()
            gpio.write(trigPin, gpio.LOW);
        end);
        
        local upTime = tmr.now();
        gpio.trig(echoPin, "both", function(level)
            if (level == gpio.HIGH) then
                upTime = tmr.now();
            else
                gpio.trig(echoPin);
                local downTime = tmr.now();
                node.task.post(function()
                    callback(downTime - upTime);
                end);
            end
        end);
    end;

    local withRetry;
    withRetry = function(func, callback)
        local settled = false;
        local timer = tmr.create();
        func(function(res)
            if (settled == false) then
                settled = true;
                timer:unregister();
                callback(res);
            end;
        end)
        timer:alarm(1000, tmr.ALARM_SINGLE, function()
            if (settled == false) then
                print("timeout called");
                settled = true;
                withRetry(func, callback);
            end;
        end);
    end;

    local results = {};
    local func;
    func = function(time)
        table.insert(results, time / 58);
        local length = table.getn(results);
        if (length < 10) then
            withRetry(measure, func);
        else
            table.sort(results);
            callback(results[length / 2]);
        end
    end
    withRetry(measure, func);
end;
