local sdaPin = 5;
local sclPin = 2;

sla = 0x3C;
i2c.setup(0, sdaPin, sclPin, i2c.SLOW);
disp = u8g.ssd1306_128x64_i2c(sla);
disp:setFont(u8g.font_fub30n);
disp:setFontRefHeightExtendedText();
disp:setDefaultForegroundColor();
disp:setFontPosTop()

return function(str)
    disp:firstPage()
    repeat
        disp:drawFrame(2,2,126,62);
        disp:drawStr(5, 20, str);
    until disp:nextPage() == false
end;
