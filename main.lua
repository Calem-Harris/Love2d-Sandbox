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
    circle = {}

    circle.x = 100
    circle.y = 100
    circle.radius = 25
    circle.speed = 200

    arrow = {}
    arrow.x = 200
    arrow.y = 200
    arrow.speed = 300
    arrow.angle = 0
    arrow.image = love.graphics.newImage("images/arrow_right.png")
    arrow.orgin_x = arrow.image:getWidth() / 2
    arrow.origin_y = arrow.image:getHeight() / 2

    frames = {}
    -- table.insert(frames, love.graphics.newImage("images/jump1.png"))
    -- table.insert(frames, love.graphics.newImage("images/jump2.png"))
    -- table.insert(frames, love.graphics.newImage("images/jump3.png"))
    -- table.insert(frames, love.graphics.newImage("images/jump4.png"))
    -- table.insert(frames, love.graphics.newImage("images/jump5.png"))
    for i=1,5 do
        table.insert(frames, love.graphics.newImage("images/jump" .. i .. ".png"))
    end

    currentFrame = 1

    image = love.graphics.newImage("images/jump_3.png")
    ssFrames = {}
    local frame_width = 117
    local frame_height = 233
    local width = image:getWidth()
    local height = image:getHeight()

    -- for i=0, 4 do
    --     table.insert(ssFrames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, width, height))
    -- end

    -- for i = 0, 2 do
    --     table.insert(ssFrames, love.graphics.newQuad(i * frame_width, 0, frame_width, frame_height, width, height))
    -- end

    -- for i = 0, 1 do
    --     table.insert(ssFrames, love.graphics.newQuad(i * frame_width, frame_height, frame_width, frame_height, width, height))
    -- end

    maxFrames = 5
    for i=0,1 do
        for j=0, 2 do
            table.insert(ssFrames, love.graphics.newQuad(1 + j * (frame_width + 2), 1 + i * (frame_height + 2), frame_width, frame_height, width, height))
            if #ssFrames == maxFrames then
                break
            end
        end
    end

    -- table.insert(ssFrames, love.graphics.newQuad(0, 0, frame_width, frame_height, image:getWidth(), image:getHeight()))
    -- table.insert(ssFrames, love.graphics.newQuad(frame_width, 0, frame_width, frame_height, image:getWidth(), image:getHeight()))

    ssCurrentFrame = 1
end

function love.update(dt)
    currentFrame = currentFrame + 10 * dt
    if currentFrame >= 6 then
        currentFrame = 1
    end

    ssCurrentFrame = ssCurrentFrame + 1 * dt
    if ssCurrentFrame >= 6 then
        ssCurrentFrame = 1
    end

    -- The stuff below is in relation to angles and distance
    mouse_x, mouse_y = love.mouse.getPosition()
    
    arrow.angle = math.atan2(mouse_y - arrow.y, mouse_x - arrow.x)
    angle = math.atan2(mouse_y - circle.y, mouse_x - circle.x)

    arrowCos = math.cos(arrow.angle)
    arrowSin = math.sin(arrow.angle)
    cos = math.cos(angle)
    sin = math.sin(angle)

    local distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)

    arrow.x = arrow.x + arrow.speed * arrowCos * dt
    arrow.y = arrow.y + arrow.speed * arrowSin * dt

    if distance < 400 then
        circle.x = circle.x + circle.speed * cos * (distance/100) * dt
        circle.y = circle.y + circle.speed * sin * (distance/100) * dt
    end
end

function love.draw()

    love.graphics.draw(image, ssFrames[math.floor(ssCurrentFrame)], 100, 100)
    --love.graphics.draw(frames[math.floor(currentFrame)])

    -- Below is in relation to angles and distance
    -- love.graphics.circle("line", circle.x, circle.y, circle.radius)

    -- love.graphics.print("angle " .. angle, 10, 10)

    -- love.graphics.line(circle.x, circle.y, mouse_x, mouse_y)
    -- love.graphics.line(circle.x, circle.y, mouse_x, circle.y)

    -- love.graphics.line(mouse_x, mouse_y, mouse_x, circle.y)

    -- local distance = getDistance(circle.x, circle.y, mouse_x, mouse_y)
    -- love.graphics.circle("line", circle.x, circle.y, distance)

    -- love.graphics.draw(arrow.image, 
    --                     arrow.x, arrow.y, arrow.angle, 1, 1,
    --                     arrow.orgin_x, arrow.origin_y)

    -- love.graphics.circle("fill", mouse_x, mouse_y, 5)
end

function getDistance(x1, y1, x2, y2)
    local horizontal_distance = x1 - x2
    local vertical_distance = y1 - y2

    local a = horizontal_distance * horizontal_distance
    local b = vertical_distance ^2

    local c = a + b
    local distance = math.sqrt(c)
    return distance
end
