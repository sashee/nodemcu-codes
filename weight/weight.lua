hx711.init(6,7)

return function(callback)
    xpcall(function()
        local measure = hx711.read(0);
        local x =  measure / 395.8392;
        local result = x>=0 and math.floor(x+0.5) or math.ceil(x-0.5);
        
        node.task.post(function() callback(nil, result) end);
    end, callback)
end
