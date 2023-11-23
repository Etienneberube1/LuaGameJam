require "Audio"
local shotlist = {}
local playerlist = {}
local shotDelay = 0

--------------------------- Player function -------------------------------
function createPlayer()
    local player = {}
    -- changer le sprite du player -- 
    player.image = love.graphics.newImage("assets/Octopus.png")
    player.width = player.image:getWidth()
    player.height = player.image:getHeight()
    player.Tile_w = player.width / 4
    player.Tile_h = player.height / 3
    player.row = player.width / player.Tile_w
    player.col = player.height / player.Tile_h
    player.total = player.row * player.col
    player.indexX = 0
    player.indexY = 0
    player.x = 20
    player.y = 400
    player.speed = 600
    player.Hp = 3
    player.left = player.x
    player.right = player.x + player.Tile_w
    player.top = player.y
    player.bottom = player.y + player.Tile_h
    player.Tile_quad = love.graphics.newQuad(player.indexX, player.indexY, player.Tile_w, player.Tile_h, player.width, player.height)
    player.draw = function()
        love.graphics.draw(player.image, player.Tile_quad, player.x, player.y)
    end
    table.insert(playerlist, player)

end

function ChangeIndexPlayer(index)
    for i = #playerlist, 1, -1 do
        playerlist[i].indexX = (index % playerlist[i].row) * playerlist[i].Tile_w
        playerlist[i].indexY = (math.floor(index / playerlist[i].row)) * playerlist[i].Tile_h
        playerlist[i].Tile_quad = love.graphics.newQuad(playerlist[i].indexX, playerlist[i].indexY, playerlist[i].Tile_w, playerlist[i].Tile_h, playerlist[i].width, playerlist[i].height)
    end
end

function drawPlayer()
    if health > 0 then
        for i = #playerlist, 1, -1 do
            playerlist[i].draw()
        end
    end
end
local Elapsed = 0
local index = 0

function AnimateOctopus(dt)
    Elapsed = Elapsed + dt
    if Elapsed >= 0.1 then
        Elapsed = 0
        index = index + 1
        if not love.keyboard.isDown('d') and not love.keyboard.isDown('a') then
            if index > 3 then
                index = 0
            end
        end
        if love.keyboard.isDown('d') then
            if index < 3 then
                index = 4
            end
            if index > 7 then
                index = 4
            end
        end
        if love.keyboard.isDown('a') then
            if index < 7 then
                index = 8
            end
            if index > 11 then
                index = 8
            end
        end
        ChangeIndexPlayer(index)
    end

end

function playermovement(dt)
    if love.keyboard.isDown('w') then
        for i = #playerlist, 1, -1 do
            playerlist[i].y = playerlist[i].y - playerlist[i].speed * dt
        end
    end
    if love.keyboard.isDown('s') then
        for i = #playerlist, 1, -1 do
            playerlist[i].y = playerlist[i].y + playerlist[i].speed * dt
        end
    end
    if love.keyboard.isDown('a') then
        for i = #playerlist, 1, -1 do
            playerlist[i].x = playerlist[i].x - playerlist[i].speed * dt
        end
    end
    if love.keyboard.isDown('d') then
        for i = #playerlist, 1, -1 do
            playerlist[i].x = playerlist[i].x + playerlist[i].speed * dt
        end
    end
    for i = #playerlist, 1, -1 do
        if playerlist[i].x < GameScreen.x then
            playerlist[i].x = GameScreen.x
        end
        if playerlist[i].x >= GameScreen.maxX - playerlist[i].Tile_w then
            playerlist[i].x = GameScreen.maxX - playerlist[i].Tile_w
        end
        if playerlist[i].y < 0 then
            playerlist[i].y = 0
        end
        if playerlist[i].y > screen_height - playerlist[i].Tile_h then
            playerlist[i].y = screen_height - playerlist[i].Tile_h
        end
        if playerlist[i].y < screen_height / 2 then
            playerlist[i].y = screen_height / 2
        end
        playerlist[i].left = playerlist[i].x
        playerlist[i].right = playerlist[i].x + playerlist[i].Tile_w
        playerlist[i].top = playerlist[i].y
        playerlist[i].bottom = playerlist[i].y + playerlist[i].Tile_h
        scorePositionX = playerlist[i].x - 50
        scorePositionY = playerlist[i].y - 50
    end
end

function ReturnPlayerList()
    return playerlist
end

function PlayerHit(index)
    -- playerlist[index].Hp = playerlist[index].Hp - 1
    -- ajouter le code a jouer lorsque le joueur est hit --
    -- if playerlist[index].Hp <= 0 then
    -- table.remove(playerlist, index)
    -- ajouter le code a jouer lorsque le joueur meurt -- 

    health = health - 1
    canDrawRed = true
    PlayOctopusSound()

end

--------------------------------- shot function ---------------------------------------------------
function createShot()
    local shot = {}
    -- changer le spite du shot --
    shot.image = love.graphics.newImage("assets/IncBullet.png")
    shot.height = shot.image:getHeight()
    shot.width = shot.image:getWidth()
    for i = #playerlist, 1, -1 do
        shot.x = playerlist[i].x + playerlist[i].Tile_w / 2
        shot.y = playerlist[i].y
    end
    shot.speed = 600
    shot.left = shot.x
    shot.right = shot.x + shot.width
    shot.top = shot.y
    shot.bottom = shot.y + shot.height
    shot.draw = function()
        love.graphics.draw(shot.image, shot.x, shot.y)
    end
    table.insert(shotlist, shot)
end

function Shot(dt)
    shotDelay = shotDelay - dt
    if love.keyboard.isDown('space') then
        if shotDelay <= 0 then
            createShot()
            PlayShootingSound()
            shotDelay = 0.2
        end
    end
end

function UpdateShot(dt)
    for i = #shotlist, 1, -1 do
        shotlist[i].y = shotlist[i].y - shotlist[i].speed * dt
        shotlist[i].left = shotlist[i].x
        shotlist[i].right = shotlist[i].x + shotlist[i].width
        shotlist[i].top = shotlist[i].y
        shotlist[i].bottom = shotlist[i].y + shotlist[i].height
        if shotlist[i].y < 0 - shotlist[i].height then
            table.remove(shotlist, i)
        end
    end
end
function ReturnShotList()
    return shotlist
end

function destoyShot(index)
    -- rajouter le code a jouer lorsque la bullet entre en colision --
    table.remove(shotlist, index)
end

function DrawShots()
    if gameState == 3 then
        for i = 1, #shotlist, 1 do
            shotlist[i].draw()
        end
    end
end
