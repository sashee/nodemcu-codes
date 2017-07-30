return function()
    local weight = require("weight");
    local disp = require("disp")
    weight(function(err, tared)
        local update
        update = function()
            local res = weight(function(err, res)
                disp(res - tared);
                tmr.create():alarm(100, tmr.ALARM_SINGLE, update)
            end)
        end
        
        update()
    end)

end
