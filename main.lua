require("sample/example")


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

local listOfRectangles = {}
local fruits = {}

function love.load()
    
    fruits = {"apple", "banana"}
    table.insert(fruits, "pear")
    table.insert(fruits, "pineapple")
    table.remove(fruits, 1)
    fruits[2] = "tomato"
    yPos = 100

    for i,v in ipairs(fruits) do
        print(i, v)
    end

    -- for i=1, #fruits do
    --     print(fruits[i])
    -- end



    

    --print(test)

end

function createRect()
    local rect = {}
    --rect["width"] = 100
    rect.width = 70
    rect.height = 90
    rect.x = 100
    rect.y = 100
    rect.speed = 100

    table.insert(listOfRectangles, rect)

end

function love.keypressed(key)
    if key == "space" then
        createRect()
    end
end

function love.update(dt)
    for i,v in ipairs(listOfRectangles) do
        v.x = v.x + v.speed * dt
    end
end

function love.draw()
    -- love.graphics.print(fruits[1], 100, 100)
    -- love.graphics.print(fruits[2], 100, 200)
    -- love.graphics.print(fruits[3], 100, 300)

    -- for-loop
    -- for i=1, #fruits do
    --     v = fruits[i]
    -- end

    -- ipairs
        -- for i,frt in ipairs(fruits) do
        --     love.graphics.print(frt, 100, yPos * i)
        -- end
    for i=1, #listOfRectangles do
        love.graphics.rectangle("line", listOfRectangles[i].x, listOfRectangles[i].y, 
                                        listOfRectangles[i].width, listOfRectangles[i].height)
    end
end


