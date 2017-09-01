return function(delay)
    motor = {}
    motor.pin1 = 1
    motor.pin2 = 2
    motor.pin3 = 5
    motor.pin4 = 6
    
    -- Setup motor pins as out
    gpio.mode(motor.pin1, gpio.OUTPUT)
    gpio.mode(motor.pin2, gpio.OUTPUT)
    gpio.mode(motor.pin3, gpio.OUTPUT)
    gpio.mode(motor.pin4, gpio.OUTPUT)
    gpio.write(motor.pin1, gpio.LOW)
    gpio.write(motor.pin2, gpio.LOW)
    gpio.write(motor.pin3, gpio.LOW)
    gpio.write(motor.pin4, gpio.LOW)
    
    loc = 1
    
    function apply(loc)
        gpio.write(motor.pin1, (loc <= 2 or loc == 8) and gpio.HIGH or gpio.LOW);
        gpio.write(motor.pin2, (loc >= 2 and loc <= 4) and gpio.HIGH or gpio.LOW);
        gpio.write(motor.pin3, (loc >= 4 and loc <= 6) and gpio.HIGH or gpio.LOW);
        gpio.write(motor.pin4, loc >= 6 and gpio.HIGH or gpio.LOW);
    end
    
    function fwd()
        loc = loc % 8 + 1
        apply(loc);
    end
    
    function rev()
        loc = (loc + 6) % 8 + 1
        apply(loc);
    end

    function moveto(position, callback)
        local nextFunc = function()
            local nextpos = position > 0 and position - 1 or position + 1
            moveto(nextpos, callback);
        end
        if position == 0 then
            callback();
        else
            if position > 0 then fwd() else rev() end;
            tmr.create():alarm(delay, tmr.ALARM_SINGLE, nextFunc);
        end
    end
    
    return moveto
end
