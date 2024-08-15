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

print(type("Hello World")); -- String --
print(type(10.4)); -- Number --
print(type(print)); -- function --
print(type(true)); -- Boolean --
print(type(nil)); -- Nil -- 

thing1 = function()
    print("Hello World")
end

thing1()
thing1()

function example()
    print("Hello World Again!")
end

example()
example()

function love.draw()
    love.graphics.rectangle("line", 100, 200, 50, 80)
end
