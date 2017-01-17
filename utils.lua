local utils = {}

function utils.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end

function utils.find(list, predicate)
    for _, e in pairs(list) do
        if(predicate(e)) then
            return e
        end
    end
    return nil
end

function utils.any(list, predicate)
    for _, e in pairs(list) do
        if(predicate(e)) then
            return true
        end
    end
    return false
end

function utils.findInArray(array, element)
    return utils.any(array, function(e)
        return e == element
       end)
end

function utils.keys(list)
    local res = {}
    for k,_ in pairs(list) do
        table.insert(res, k)
    end
    return res
end

return utils
