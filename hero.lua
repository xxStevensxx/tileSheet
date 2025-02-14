local Hero = {
    line = 2,
    column = 2,
    offsetX = 0,
    offsetY = 0,
    width = 0,
    height = 0,
    images = {},
    currentFrame = 0,
    nbFrame = 0
}

local lstSprite = {}

function CreateSprite(pLstSprite, pSpriteName, pNbFrame)
    for nb = 1, pNbFrame do 
        --preformatage nom de fichier
        local filename = "/images/"..pSpriteName..tostring(nb)..".png"
        Hero.images[nb] = love.graphics.newImage(filename)
    end

    Hero.width = Hero.images[1]:getWidth()
    Hero.height = Hero.images[1]:getHeight()
    Hero.offsetX = Hero.width / 2
    Hero.offsetY = Hero.height / 2
    Hero.nbFrame = pNbFrame
    Hero.currentFrame = 1

end

function Hero.load()
    CreateSprite(lstSprite, "player_", 4)
end

function Hero.update(dt, pMap)

    local old_column = Hero.column
    local old_line = Hero.line

    -- entrées clavier
    if love.keyboard.isDown("up") and Hero.line > 2 then
        --Animation Frame
        for nb = 1, #Hero.images do 
            Hero.currentFrame = Hero.currentFrame + 1 * dt
        end

        Hero.line = Hero.line - 5 * dt
    end

    if love.keyboard.isDown("down") and Hero.line < pMap.MAP_HEIGHT then
        --Animation Frame
        for nb = 1, #Hero.images do 
            Hero.currentFrame = Hero.currentFrame + 1 * dt
        end

        Hero.line = Hero.line + 5 * dt
    end

    if love.keyboard.isDown("left") and Hero.column > 1 then
        --Animation Frame
        for nb = 1, #Hero.images do 
            Hero.currentFrame = Hero.currentFrame + 1 * dt
        end

        Hero.column = Hero.column - 5 * dt
    end

    if love.keyboard.isDown("right") and Hero.column < pMap.MAP_WIDTH then
        --Animation Frame
        for nb = 1, #Hero.images do 
            Hero.currentFrame = Hero.currentFrame + 1 * dt
        end

        Hero.column = Hero.column + 5 * dt
     end

    -- Gestion des colisions
    -- On recupere uniquement le nombre entier avec math.floor car sinon il cherchera des flottant qui renverra nil
    local id = pMap.grid[math.floor(Hero.line)][math.floor(Hero.column)]

       if pMap.isSolid(id) then 
        print("colision !!!")
        Hero.line = old_line
        Hero.column = old_column

    end


    function love.keyreleased(key)
        if key == "up" then
            Hero.currentFrame = 1
        end

        if key == "down" then
            Hero.currentFrame = 1
        end

        if key == "left" then
            Hero.currentFrame = 1
        end

        if key == "right" then
            Hero.currentFrame = 1
        end
    end

    if Hero.currentFrame > #Hero.images + 1 then
        Hero.currentFrame = 1
    end
    
end

function Hero.draw(pMap)
    local x = (Hero.column - 1) * pMap.TILE_WIDTH
    local y = (Hero.line - 1) * pMap.TILE_HEIGHT
    love.graphics.draw(Hero.images[math.floor(Hero.currentFrame)], math.floor(x), math.floor(y), 0, 3, 3, Hero.offsetX, Hero.offsetY)
    love.graphics.print("current Frame: "..tostring(Hero.currentFrame), 150, 150)
end

return Hero