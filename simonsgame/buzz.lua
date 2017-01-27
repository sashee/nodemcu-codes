local setup = false
local pin = 3

return function(toneId, callback)
    local tone;
    if toneId == 0 then tone = 440
    elseif toneId == 1 then tone = 493
    elseif toneId == 2 then tone = 589
    else tone = 659 end
    if setup then
        pwm.setclock(pin, tone)
    else
        pwm.setup(pin, tone, 1015)
        pwm.start(pin)
        setup = true
    end

    tmr.create():alarm(500, tmr.ALARM_SINGLE, function()
        local dispose = function()
            pwm.setduty(pin, 1023)
            setup = false
        end
        if callback then callback(dispose) end
    end)
end
