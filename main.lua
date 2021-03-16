WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720
timeStamp = ""
toggleSeconds = false

function love.load()
    love.window.setMode(WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        resizable = false,
        vsync = true
    })
    largeFont = love.graphics.newFont('font.ttf', 200)
    smallFont = love.graphics.newFont('font.ttf', 150)
    love.window.setTitle('Clock')
    sounds = {
        ['SecondTick'] = love.audio.newSource('clockTick.mp3', 'static' ),
        ['MinuteTick'] = love.audio.newSource('minutesTick.mp3', 'static' ),
        ['HourTick'] = love.audio.newSource('HoursTick.mp3', 'static' )
    }
end

function love.update(dt)
    curSec = os.time()
    curDeciSec = curSec * 10
    curMin = curSec / 60
    curHour = math.floor(curMin / 60)
    realMinute = math.floor(curMin % 60)
    realSecond = math.floor(curSec % 60)
    realHour = math.floor((curHour + 17) % 24)  
    currentLocalDate = os.date("%x") 
    if (toggleSeconds == true) then
        if (curMin % 60 == 0) then
            sounds['HourTick']:play()
        elseif (curSec % 60 == 0) then
            sounds['MinuteTick']:play()
        elseif (curDeciSec % 10 == 0) then
            sounds['SecondTick']:play()
        end
    else 
        if (curMin % 60 == 0) then
            sounds['HourTick']:play()
        elseif (curSec % 60 == 0) then
            sounds['MinuteTick']:play()
        end
    end
    if (realHour > 11) then
        timeStamp = " P.M"
        realHour = realHour % 12
    else
        timeStamp = " A.M"
    end
end

function love.keypressed(key)
    if key == 'escape' then
        love.event.quit()
    elseif key == 'space' then
        if toggleSeconds == true then
            toggleSeconds = false
            sounds['SecondTick']:stop()
        else
            toggleSeconds = true
        end
    end
end

function love.draw()
    if toggleSeconds == true then
        love.graphics.setFont(smallFont)
        if (realSecond < 10) then
            if (realMinute < 10) then
                love.graphics.printf(tostring(realHour) .. " : " .. "0" .. tostring(realMinute) .. " : " .. "0" .. tostring(realSecond) .. timeStamp, 0, WINDOW_HEIGHT / 2 - 75, WINDOW_WIDTH, 'center')
            else
                love.graphics.printf(tostring(realHour) .. " : " .. tostring(realMinute) .. " : " .. "0" .. tostring(realSecond) .. timeStamp, 0, WINDOW_HEIGHT / 2 - 75, WINDOW_WIDTH, 'center')
            end
        else
            if (realMinute < 10) then
                love.graphics.printf(tostring(realHour) .. " : " .. "0" .. tostring(realMinute) .. " : " .. tostring(realSecond) .. timeStamp, 0, WINDOW_HEIGHT / 2 - 75, WINDOW_WIDTH, 'center')
            else
                love.graphics.printf(tostring(realHour) .. " : " .. tostring(realMinute) .. " : " .. tostring(realSecond) .. timeStamp, 0, WINDOW_HEIGHT / 2 - 75, WINDOW_WIDTH, 'center')
            end
        end
    else
        love.graphics.setFont(largeFont)
        if (realMinute < 10) then
            love.graphics.printf(tostring(realHour) .. " : " .. "0" .. tostring(realMinute) .. timeStamp, 0, WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH, 'center')
        else
            love.graphics.printf(tostring(realHour) .. " : " .. tostring(realMinute) .. timeStamp, 0, WINDOW_HEIGHT / 2 - 100, WINDOW_WIDTH, 'center')
        end
    end
    love.graphics.setFont(smallFont)
    love.graphics.printf(currentLocalDate, 0, WINDOW_HEIGHT / 2 + 100, WINDOW_WIDTH, 'center')
end
