return function(melody, callback)
    local buzz = require("buzz");
    local leds = require("leds");
    local play
    play = function(idx)
        leds(melody[idx + 1])
        buzz(melody[idx + 1], function(dispose)
            if idx < table.getn(melody) -1 then
                play(idx + 1)
            else
                leds(-1)
                dispose()
                if callback then callback() end
            end
        end)
    end
    play(0)
end
