

love.graphics.setDefaultFilter("nearest")
math.randomseed(os.time())

-- local game = require("game")
local hero = require("hero")
local game = require("game")

local lstSprite = {}


function love.load()
    love.window.setMode(1024, 768)
    game.load()
end

function love.update(dt)
    game.update(dt)
end

function love. draw()
    game.draw()
end

function love.keypressed()
end
