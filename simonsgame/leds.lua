local leds = {1,2,5,0}
for i,ledio in ipairs(leds)
do
    gpio.mode(ledio, gpio.OUTPUT)
end

return function(ledIdx)
    for i,ledio in ipairs(leds)
    do
        gpio.write(ledio, gpio.LOW)
    end
    if ledIdx >= 0 then
        gpio.write(leds[ledIdx + 1], gpio.HIGH)
    end
end
