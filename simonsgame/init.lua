tmr.create():alarm(5000, tmr.ALARM_SINGLE, function()
    require("main")()
end)
