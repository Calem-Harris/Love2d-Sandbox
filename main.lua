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
    require "entity"
    require "player"
    require "wall"
    require "box"

    player = Player(100, 100)
    wall = Wall(200, 100)
    box = Box(400, 150)
    box2 = Box(500, 150)

    objects = {}
    table.insert(objects, player)
    table.insert(objects, wall)
    table.insert(objects, box)
    table.insert(objects, box2)
end

function love.update(dt)
    for i,v in ipairs(objects) do
        v:update(dt)
    end

    local loop = true
    local limit = 0

    while loop do
        loop = false
    
        limit = limit + 1
        if limit > 100 then
            --Break out of the while loop
            break
        end
        for i=1, #objects-1 do
            for j=i+1, #objects do
                local collision = objects[i]:resolveCollision(objects[j])
                    if collision then
                        loop = true
                    end
            end
        end
    end
end

function love.draw()
    for i,v in ipairs(objects) do
        v:draw()
    end
end
