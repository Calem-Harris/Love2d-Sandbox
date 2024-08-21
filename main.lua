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

function love.load()
    Object = require "classic"
    require "shape"
    require "rectangle"
    require "circle"

    r1 = Rectangle(100, 100, 200, 50) -- Creating a new INSTANCE of a Rectangle
    
    r2 = Circle(350, 80, 40)

    --print(r1.test, r2.test)

    myImage = love.graphics.newImage("images/sheep.png")

    width = myImage:getWidth()
    height = myImage:getHeight()

    love.graphics.setBackgroundColor(1, 1, 1)
end

function love.update(dt)
    r1.update(r1, dt)
    r2:update(dt)
end

function love.draw()
    -- r1:draw()
    -- r2.draw(r2)
    love.graphics.setColor(255/255, 200/255, 40/255, 127/255)

    love.graphics.draw(myImage, 100, 100, 0, 2, 2, width / 2, height / 2)
    
end