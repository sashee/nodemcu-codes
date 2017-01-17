local sdaPin = 1;
local sclPin = 6;

sla = 0x3C;
i2c.setup(0, sdaPin, sclPin, i2c.SLOW);
disp = u8g.ssd1306_128x64_i2c(sla);
disp:setDefaultForegroundColor();

function rajz(kep)
    file.open(kep, "r")
    file.seek("set")
    d1 = file.read(256)
    d2 = file.read(256)
    d3 = file.read(256)
    d4 = file.read(256)
    file.close()
    disp:firstPage()
    repeat
        disp:drawBitmap(0, 0, 16, 16,d1);
        disp:drawBitmap(0, 16, 16, 16,d2);
        disp:drawBitmap(0, 32, 16, 16,d3);
        disp:drawBitmap(0, 48, 16, 16,d4);
        
    until disp:nextPage() == false
end;

function pislant(kepsuffix)
    rajz(kepsuffix.."_p.bm")
    tmr.create():alarm(1, tmr.ALARM_SINGLE, function()
        rajz(kepsuffix..".bm")
    end)
end

rajz("kep1.bm")
tmr.create():alarm(3000, tmr.ALARM_SINGLE, function()
    pislant("kep1")
    tmr.create():alarm(500, tmr.ALARM_SINGLE, function()
        pislant("kep1")
    end)
    tmr.create():alarm(3000, tmr.ALARM_SINGLE, function()
        rajz("kep2.bm")
        tmr.create():alarm(3000, tmr.ALARM_SINGLE, function()
            rajz("kep3.bm")
            tmr.create():alarm(math.random(2000, 10000), tmr.ALARM_AUTO, function()
                pislant("kep3")
                if (math.random(10) < 3) then
                    tmr.create():alarm(500, tmr.ALARM_SINGLE, function()
                        pislant("kep3")
                    end)
                end
            end)
        end)
    end)
end)


