return function(state, callback)
    local inputs = require("inputs")
    local melody = require("melody")
    
    local next
    next = function(idx)
        inputs(function(guess)
            melody({guess},function()
                if state[idx] == guess then
                    if table.getn(state) > idx then
                        next(idx + 1)
                    else 
                        callback(true)
                    end
                else
                    callback(false)
                end
            end)
        end)
    end
    next(1)
end
