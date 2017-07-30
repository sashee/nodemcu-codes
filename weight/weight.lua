hx711.init(6,7)

return function()
    local measure = hx711.read(0);
    local x =  measure / 395.8392;
    return x>=0 and math.floor(x+0.5) or math.ceil(x-0.5);
end
