-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local TILE_WIDTH = 70
local TILE_HEIGHT = 70

local Game = {

    tileTextures = {},
    map =   {
                --10 * 10
                {0, 2, 2, 2, 5, 5, 2, 2, 2, 2},
                {2, 1, 2, 2, 2, 2, 2, 2, 1, 2},
                {2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
                {2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
                {2, 2, 2, 2, 3, 3, 2, 2, 2, 2},
                {2, 2, 2, 2, 3, 3, 2, 2, 2, 2},
                {2, 2, 2, 2, 2, 2, 2, 4, 1, 2},
                {2, 2, 2, 2, 2, 2, 2, 2, 2, 2},
                {2, 1, 2, 2, 2, 2, 2, 2, 1, 2},
                {2, 2, 2, 2, 4, 4, 2, 2, 2, 2}
                
            }
}

function Game.load()
    -- on valorise nos textures directement dans le load
    print("chargement des textures")
    Game.tileTextures[0] = nil
    Game.tileTextures[1] = love.graphics.newImage("/images/grassCenter.png") 
    Game.tileTextures[2] = love.graphics.newImage("/images/liquidLava.png")
    Game.tileTextures[3] = love.graphics.newImage("/images/liquidWater.png")
    Game.tileTextures[4] = love.graphics.newImage("/images/snowCenter.png")
    Game.tileTextures[5] = love.graphics.newImage("/images/stoneCenter.png")
    print("chargement des textures terminées!!")
end

function Game.update(dt)
end

function Game.draw()

    -- on parcours la structure de notre map
    for li = 1, #Game.map do
        --On recupere la valeur de chaque ligne a chaque colonne
        for col = 1, #Game.map[li] do 
             local id = Game.map[li][col]
             local tex = Game.tileTextures[id]

             if tex ~= nil then
                love.graphics.draw(tex, (col - 1) * TILE_WIDTH, (li - 1) * TILE_HEIGHT )
             end
        end
    end

    --On recupere la position x et y de la souris 
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    -- On divise la position x et y par la largeur pour x  et la hauteur pour y afin d'obtenir la position de la tuile survolé par la souris dans notre tableau Game.map{}
    local col = math.floor(mouseX / TILE_WIDTH + 1)
    local li = math.floor(mouseY / TILE_WIDTH + 1)
    --On passe les index souhaités sur notre Game.map{} afin d'obtenir sa valeur donc la tuile qui est sous notre souris
    local id = Game.map[li][col]


    love.graphics.print("id tuile: "..tostring(id), 10, 1)
    love.graphics.print("mouse x: "..tostring(mouseX), 100, 1)
    love.graphics.print("mouse y: "..tostring(mouseY), 200, 1)

end

function Game.keypressed()
end

return Game
