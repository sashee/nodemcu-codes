return function()
    local motor = require("motor")(1)
    local r
    r = function()
        motor(10 * 4096, function()
            motor(-10 * 4096, function() r() end)
        end)
    end
    r()

end
