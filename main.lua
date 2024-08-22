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
    require "player"
    require "enemy"
    require "bullet"

    player = Player()
    enemy = Enemy()
    tableOfBullets = {}

    speed = 100
    r1 = {
        x = 10,
        y = 100,
        width = 100,
        height = 100
    }

    r2 = {
        x = 250,
        y = 120,
        width = 150,
        height = 120
    }
end

function love.update(dt)
    r1.x = r1.x + speed * dt
    player:update(dt)
    enemy:update(dt)

    for i,v in ipairs(tableOfBullets) do
        v:update(dt)

        v:checkCollision(enemy)

        if v.dead then
            table.remove(tableOfBullets, i)
        end
    end

    -- for i = 1, #tableOfBullets do
    --     tableOfBullets[i]:update(dt)
    -- end
end

function love.draw()
    player:draw()
    enemy:draw()

    for i, v in ipairs(tableOfBullets) do
        v:draw()
    end

    -- local mode
    -- if checkCollision(r1, r2) then
    --     -- If there is a collision, do something
    --     mode = "fill"
    -- else
    --     mode = "line"
    -- end



    -- love.graphics.rectangle(mode, r1.x, r1.y, r1.width, r1.height)
    -- love.graphics.rectangle(mode, r2.x, r2.y, r2.width, r2.height)
end

function love.keypressed(key)
    player:keyPressed(key)
end

--This entire function give us a boolean value
-- function checkCollision(a, b)
--     local a_left = a.x
--     local a_right = a.x + a.width
--     local a_top = a.y
--     local a_bottom = a.y + a.height

--     local b_left = b.x
--     local b_right = b.x + b.width
--     local b_top = b.y
--     local b_bottom = b.y + b.height

--     if a_right > b_left and a_left < b_right and
--         a_bottom > b_top and a_top < b_bottom then
--             --We are colliding
--             return true
--     else
--         -- One of the conditions in our if statement is false... We are NOT colliding
--         return false
--     end

--     -- Gives us the same return as the if statement above. Just condensed to a single line.
--     -- return a_right > b_left and 
--     --         a_left < b_right and
--     --         a_bottom > b_top and 
--     --         a_top < b_bottom
-- end
