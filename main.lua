if arg[2] == "debug" then
    require("lldebugger").start()
end

local love_errorhandler = love.errorhandler

function love.errorhandler(msg)
    if lldebugger then
        error(msg, 2)
    else
        return love_errorhandler(msg)
    end
end

-- print(type("Hello World")); -- String --
-- print(type(10.4)); -- Number --
-- print(type(print)); -- function --
-- print(type(true)); -- Boolean --
-- print(type(nil)); -- Nil -- 

-- thing1 = function()
--     print("Hello World")
-- end

-- thing1()
-- thing1()

-- function example()
--     print("Hello World Again!")
-- end

-- example()
-- example()

function love.load()
    rectangleXPos = 100
    rectangleYPos = 50
    circleXPos = 300
    circleYPos = 300
    rectangleMoveSpeed = 100
    circleMoveSpeed = 200
end

function love.update(deltaTime)
    --print(deltaTime)

    -- > Greater Than
    -- < Less Than
    -- == Is Equal To
    -- <= Less Than or Equal To
    -- >= Greater Than or Equal To
    -- ~= Is NOT Equal To
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        rectangleXPos = rectangleXPos + rectangleMoveSpeed * deltaTime
    elseif love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        rectangleXPos = rectangleXPos - rectangleMoveSpeed * deltaTime
    end

    if love.keyboard.isDown("up") or love.keyboard.isDown("w") then
        rectangleYPos = rectangleYPos - rectangleMoveSpeed * deltaTime
    elseif love.keyboard.isDown("down") or love.keyboard.isDown("s") then
        rectangleYPos = rectangleYPos + rectangleMoveSpeed * deltaTime
    end

    -- if love.keyboard.isDown("a") then
    --     circleXPos = circleXPos - circleMoveSpeed * deltaTime
    -- elseif love.keyboard.isDown("d") then
    --     circleXPos = circleXPos + circleMoveSpeed * deltaTime
    -- end

    -- if love.keyboard.isDown("w") then
    --     circleYPos = circleYPos - circleMoveSpeed * deltaTime
    -- elseif love.keyboard.isDown("s") then
    --     circleYPos = circleYPos + circleMoveSpeed * deltaTime
    -- end

end

function love.draw()
    love.graphics.rectangle("line", rectangleXPos, rectangleYPos, 200, 150)
    --love.graphics.circle("line", circleXPos, circleYPos, 50)
end
