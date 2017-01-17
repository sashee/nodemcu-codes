return function()
    print("AAA");
    pwm.setup(1, 500, 0);
    pwm.start(1);

    local on = false;

    local switch = function()
        if on == true then
            pwm.setduty(1, 0);
            on = false;
        else
            on = true;
            local current = 0;
            
            tmr.create():alarm(1000, tmr.ALARM_AUTO, function(t)
                current = current + 64;
                if current > 1023 then
                    print("full")
                    pwm.setduty(1, 1023);
                    t:unregister();
                else
                    print(current);
                    pwm.setduty(1, current);
                end;
            end)
        end;
    end

    tmr.create():alarm(60000, tmr.ALARM_AUTO, switch);
    switch();
end
