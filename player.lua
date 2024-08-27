Player = Entity:extend()

function Player:new(x, y)
    Player.super.new(self, x, y, "images/player.png")
    self.moveSpeed = 200
    self.strength = 10
end

function Player:update(dt)
    Player.super.update(self, dt)

    if love.keyboard.isDown("a") then
        --We want to move to the left
        self.x = self.x - self.moveSpeed * dt
    elseif love.keyboard.isDown("d") then
        --We want to move to the right
        self.x = self.x + self.moveSpeed * dt
    end

    if love.keyboard.isDown("w") then
        self.y = self.y - self.moveSpeed * dt
    elseif love.keyboard.isDown("s") then
        self.y = self.y + self.moveSpeed * dt
    end
end