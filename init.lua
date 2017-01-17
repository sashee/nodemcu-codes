tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
    tmr.create():alarm(1000, tmr.ALARM_AUTO, function()
        ...
    end)
end)
