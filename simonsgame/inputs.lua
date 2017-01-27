local inputs = {7,4,12,6}
for i,inputio in ipairs(inputs)
do
    gpio.mode(inputio, gpio.INT)
end

return function(callback)
    local clear = function()
        for i,inputio in ipairs(inputs)
        do
            gpio.trig(inputio)
        end
    end
    for i,inputio in ipairs(inputs)
    do
        gpio.trig(inputio, "both", function()
            clear()
            callback(i-1)
        end)
    end
end
