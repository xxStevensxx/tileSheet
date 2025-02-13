-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

love.graphics.setDefaultFilter("nearest")
math.randomseed(os.time())

myGame = require("game")


function love.load()
    love.window.setMode(1024, 768)
    myGame.load()
end

function love.udpate(dt)
end

function love. draw()
    myGame.draw()
end

function love.keypressed()
end
