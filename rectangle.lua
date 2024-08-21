Rectangle = Shape:extend()

function Rectangle:new(x, y, width, height)
    --self.test = math.random(1, 1000)

    -- When we want to inherit from a base class
    -- If we want to call a function on that base class from our inherited class
    -- We do so by replicating the below line of code
    Rectangle.super.new(self, x, y)
    
    self.width = width
    self.height = height
    self.speed = 100
end

-- This format for making functions is the same as the formatting of the function above

function Rectangle.draw(self)
    love.graphics.rectangle("line", self.x, self.y, self.width, self.height)
end