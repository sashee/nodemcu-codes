return function()
    local melody = require("melody")
    local game = require("game")
    local nextLevel
    nextLevel = function(prevState)
        -- add next state
        local currentState = {}
        for i, j in ipairs(prevState) do currentState[i] = j end
        table.insert(currentState, tmr.now() % 4)

        -- play melody
        melody(currentState, function()
            --game
            game(currentState, function(res)
                if res == true then
                    tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
                        nextLevel(currentState)
                    end)
                else
                    tmr.create():alarm(1000, tmr.ALARM_SINGLE, function()
                        melody({2,3,2,1,0,0,0,0})
                    end)
                end
            end)
        end)
    end
    nextLevel({})
end
