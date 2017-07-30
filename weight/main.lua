return function()
    local weight = require("weight");
    local disp = require("disp")
    weight(function(err, tared)
        if err then
            print(err)
        else
            local update
            update = function()
                local res = weight(function(err, res)
                    if err then
                        print(err);
                    else
                        disp(res - tared);
                        tmr.create():alarm(100, tmr.ALARM_SINGLE, update)
                    end
                end)
            end
            
            update()
        end
    end)

end
