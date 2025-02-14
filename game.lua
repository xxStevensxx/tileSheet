-- Débogueur Visual Studio Code tomblind.local-lua-debugger-vscode
if pcall(require, "lldebugger") then
    require("lldebugger").start()
end

-- Cette ligne permet d'afficher des traces dans la console pendant l'éxécution
io.stdout:setvbuf("no")

local TILE_WIDTH = 32
local TILE_HEIGHT = 32
local MAP_WIDTH = 32
local MAP_HEIGHT = 23

local Game = {

    tileSheet = nil,
    tileTextures = {},
    tileType = {},
    texQuad = {},
    
    map =   {
                { 10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
                { 10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 15, 15, 15, 68, 15, 15},
                { 10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 169, 10, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
                { 10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 15, 15, 15, 68, 15, 15, 15, 15, 15, 15},
                { 10, 10, 10, 11, 19, 19, 19, 19, 19, 11, 10, 13, 10, 10, 10, 10, 10, 10, 61, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
                { 10, 10, 61, 10, 11, 19, 19, 19, 11, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 129, 15, 15, 15, 68, 15, 129, 15},
                { 10, 10, 10, 10, 10, 11, 11, 11, 10, 10, 61, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15, 15},
                { 10, 10, 10, 10, 10, 13, 13, 13, 13, 13, 13, 13, 10, 10, 10, 10, 10, 169, 10, 10, 10, 13, 14, 15, 15, 15, 15, 15, 15, 15, 15, 15},
                { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 13, 14, 14, 14, 14, 14, 14, 14, 15, 129},
                { 10, 10, 10, 10, 10, 10, 10, 10, 13, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 13, 14, 14},
                { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 55, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10},
                { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 58, 10, 10, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 1, 1},
                { 10, 10, 10, 10, 10, 10, 10, 10, 13, 10, 10, 10, 58, 10, 10, 10, 10, 10, 10, 10, 10, 61, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37},
                { 13, 13, 13, 13, 13, 13, 13, 13, 13, 10, 55, 10, 10, 10, 55, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 1, 37, 37, 37},
                { 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 55, 10, 10, 10, 10, 169, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37},
                { 10, 10, 10, 10, 13, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 10, 1, 37, 37, 37, 37, 37, 37},
                { 10, 10, 10, 10, 13, 10, 10, 10, 10, 10, 10, 10, 10, 142, 10, 10, 10, 10, 10, 10, 10, 169, 10, 10, 1, 37, 37, 37, 37, 37, 37, 37},
                { 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
                { 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 14, 1, 37, 37, 37, 37, 37, 37, 37},
                { 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 19, 1, 37, 37, 37, 37, 37, 37, 37},
                { 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 20, 1, 37, 37, 37, 37, 37, 37},
                { 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37, 37},
                { 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 21, 1, 37, 37, 37}
            }
                
        }


function Game.load()
    -- on valorise nos textures directement dans le load
    print("chargement des textures")
    -- on charge le TileSheet
    Game.tileSheet = love.graphics.newImage("/images/tilesheet.png")

    --On recupere le nb de ligne et de colonne et donc le nombre de tiles sur notre tileSheet
    local nbCol = Game.tileSheet:getWidth() / TILE_WIDTH
    local nbLig = Game.tileSheet:getHeight() / TILE_HEIGHT

        -- Parfois  sur les tileSheet le premier éléments peut etre vide vu que notre sheet sera transmit a notre tileTexture on prevoit
        Game.tileTextures[0] = nil
        -- on parcours la structure de notre tileSheet
        local id = 1
        for li = 1, nbLig do
            for col = 1, nbCol do 
                Game.tileTextures[id] = love.graphics.newQuad((col - 1) * TILE_WIDTH, (li - 1) * TILE_HEIGHT, TILE_WIDTH, TILE_HEIGHT, Game.tileSheet:getWidth(), Game.tileSheet:getHeight())
                --On incremente une variable id qui correspondra a la tile n sur notre tileSheet
                id = id + 1
            end
        end

        Game.tileType[1] = "smooth stone"
        Game.tileType[10] = "grass"
        Game.tileType[11] = "grass"
        Game.tileType[13] = "sand"
        Game.tileType[14] = "sand"
        Game.tileType[15] = "erth"
        Game.tileType[20] = "shallow water"
        Game.tileType[21] = "deep water"
        Game.tileType[19] = "water"
        Game.tileType[37] = "lava"
        Game.tileType[169] = "grey stone"
        Game.tileType[129] = "black stone"
        Game.tileType[142] = "dead tree"
        Game.tileType[55] = "tree"
        Game.tileType[58] = "tree"
        Game.tileType[61] = "tree"
        Game.tileType[77] = "lava"
        Game.tileType[68] = "cactus"
        

    print("chargement des textures terminées!!")
end

function Game.update(dt)
end

function Game.draw()

    -- on parcours la structure de notre map
    for li = 1, MAP_HEIGHT do
        --On recupere la valeur de chaque ligne a chaque colonne
        for col = 1, MAP_WIDTH do 
             local id = Game.map[li][col]
             local texQuad = Game.tileTextures[id]

             if texQuad ~= nil then
                love.graphics.draw(Game.tileSheet, texQuad, (col - 1) * TILE_WIDTH, (li - 1) * TILE_HEIGHT)
             end
        end
    end

    --On recupere la position x et y de la souris 
    local mouseX = love.mouse.getX()
    local mouseY = love.mouse.getY()
    -- On divise la position x et y par la largeur pour x  et la hauteur pour y afin d'obtenir la position de la tuile survolé par la souris dans notre tableau Game.map{}
    local col = math.floor(mouseX / TILE_WIDTH + 1)
    local li = math.floor(mouseY / TILE_WIDTH + 1)
    --On gere les nil pointer exception

    if col > 0 and col <= MAP_WIDTH and li > 0 and li <= MAP_HEIGHT then
        --On passe les index souhaités sur notre Game.map{} afin d'obtenir sa valeur donc la tuile qui est sous notre souris
        local id = Game.map[li][col]
        love.graphics.print("id tuile: "..tostring(id), 10, 1)
        love.graphics.print("type tuile: "..Game.tileType[id], 1, 50)
    else
        love.graphics.print("id tuile: ".."hors de l'ecran", 10, 1)
    end

    love.graphics.print("mouse x: "..tostring(mouseX), 100, 25)
    love.graphics.print("mouse y: "..tostring(mouseY), 200, 50)

end

function Game.keypressed()
end

return Game
