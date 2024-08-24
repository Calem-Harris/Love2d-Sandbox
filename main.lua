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
    image = love.graphics.newImage("images/tile.png")
    tileset = love.graphics.newImage("images/tileset.png")

    local tileset_width = tileset:getWidth()
    local tileset_height = tileset:getHeight()

    width = (tileset_width / 3) - 2
    height = (tileset_height / 2) - 2

    quads = {} -- The sprites after being cut out of our spritesheet

    for i=0, 1 do
        for j=0, 2 do
            table.insert(quads,
                love.graphics.newQuad(
                1 + j * (width + 2),
                1 + i * (height + 2),
                width, height,
                tileset_width, tileset_height))
        end
    end

    imageWidth = image:getWidth()
    imageHeight = image:getWidth()

    tilemap = {
        {1, 6, 6, 2, 1, 6, 6, 2},
        {3, 0, 0, 4, 5, 0, 0, 3},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {4, 2, 0, 0, 0, 0, 1, 5},
        {1, 5, 0, 0, 0, 0, 4, 2},
        {3, 0, 0, 0, 0, 0, 0, 3},
        {3, 0, 0, 1, 2, 0, 0, 3},
        {4, 6, 6, 5, 4, 6, 6, 5}
    }

    colors = {
        {1, 1, 1}, -- Variable of image 1
        {1, 0, 0}, -- varuable of image 2
        {1, 0, 1},
        {0, 0, 1},
        {0, 1, 1}
    }

    player = {
        image = love.graphics.newImage("images/player.png"),
        tile_x = 2,
        tile_y = 2
    }
end

function love.keypressed(key)
    local x = player.tile_x
    local y = player.tile_y

    if key == "left" then
        x = x - 1
    elseif key == "right" then
        x = x + 1
    elseif key == "up" then
        y = y - 1
    elseif key == "down" then
        y = y + 1
    end

    if isEmpty(x, y) then
        player.tile_x = x
        player.tile_y = y
    end
end

function isEmpty(x, y)
    return tilemap[y][x] == 0
end

function love.update()
    
end

    -- for i=1, #tilemap do
    --     for j=1, #tilemap[i] do
    --         if tilemap[i][j] == 1 then
    --             --Draw our tile
    --             love.graphics.rectangle("line", j * 25, i * 25, 25, 25)
    --         end
    --     end
    -- end

function love.draw()
    for i, row in ipairs(tilemap) do
        for j, tile in ipairs(row) do
            if tile ~= 0 then
                -- if tile == 1 then
                --     love.graphics.setColor(1, 1, 1)
                -- elseif tile == 2 then
                --     love.graphics.setColor(1, 0, 0)
                -- elseif tile == 3 then
                --     love.graphics.setColor(1, 0, 1)
                -- elseif tile == 4 then
                --     love.graphics.setColor(0, 0, 1)
                -- elseif tile == 5 then
                --     love.graphics.setColor(0, 1, 1)
                -- end

                --love.graphics.setColor(colors[tile])

                love.graphics.draw(tileset, quads[tile], j * imageWidth, i * imageHeight)
            end
        end
    end

    love.graphics.draw(player.image, player.tile_x * width, player.tile_y * height)

    -- for i,v in ipairs(tilemap) do
    --     if v == 1 then
    --         --We want to create a tile
    --         love.graphics.rectangle("line", i * 25, 100, 25, 25)
    --     end
    -- end
end
