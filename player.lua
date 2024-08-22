Player = Object:extend()

function Player:new()
    self.image = love.graphics.newImage("images/panda.png")
    self.x = 300
    self.y = 20
    self.speed = 500
    self.width = self.image:getWidth()
end

function Player:update(dt)
    if love.keyboard.isDown("right") or love.keyboard.isDown("d") then
        self.x = self.x + self.speed * dt
    elseif love.keyboard.isDown("left") or love.keyboard.isDown("a") then
        self.x = self.x - self.speed * dt
    end

    local window_width = love.graphics.getWidth()

    if self.x < 0 then
        self.x = 0

    elseif self.x + self.width > window_width then
        self.x = window_width - self.width
    end

end

function Player:draw()
    love.graphics.draw(self.image, self.x, self.y)
end

function Player:keyPressed(key)
    if key == "space" then
        table.insert(tableOfBullets, Bullet(self.x, self.y))
    end
end