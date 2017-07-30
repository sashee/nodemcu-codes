return function()
    local weight = require("weight");
    local disp = require("disp")
    local tared = weight()
    
    local update;
    update = function()
        local res = weight();
        disp(res - tared);
        tmr.create():alarm(100, tmr.ALARM_SINGLE, update)
    end
    
    update();
end
