local CrabList = {}
local direction = 1
local speed = 100
-- local CraBDraw = false
local GoingRight = true
crabsLeft = 0

function CreateCrab()
    local Crab = {}
    -- changer sprite du crab --
    Crab.image = love.graphics.newImage("assets/Crab.png")
    Crab.height = Crab.image:getHeight()
    Crab.width = Crab.image:getWidth()
    Crab.Tile_w = Crab.width / 4
    Crab.Tile_h = Crab.height / 4
    Crab.y = screen_height - Crab.Tile_h - 5
    Crab.x = GameScreen.x
    Crab.row = Crab.width / Crab.Tile_w
    Crab.col = Crab.height / Crab.Tile_h
    Crab.total = Crab.row * Crab.col
    Crab.indexX = 0
    Crab.indexY = 0
    Crab.Tile_quad = love.graphics.newQuad(Crab.indexX, Crab.indexY, Crab.Tile_w, Crab.Tile_h, Crab.width, Crab.height)
    Crab.left = Crab.x
    Crab.right = Crab.x + Crab.Tile_w
    Crab.top = Crab.y
    Crab.bottom = Crab.y + Crab.Tile_h
    Crab.draw = function()
        love.graphics.draw(Crab.image, Crab.Tile_quad, Crab.x, Crab.y)
    end
    table.insert(CrabList, Crab)
end

function ChangeIndexCrab(crabindex, index)
    CrabList[crabindex].indexX = (index % CrabList[crabindex].row) * CrabList[crabindex].Tile_w
    CrabList[crabindex].indexY = (math.floor(index / CrabList[crabindex].row)) * CrabList[crabindex].Tile_h
    CrabList[crabindex].Tile_quad = love.graphics.newQuad(CrabList[crabindex].indexX, CrabList[crabindex].indexY, CrabList[crabindex].Tile_w, CrabList[crabindex].Tile_h, CrabList[crabindex].width, CrabList[crabindex].height)
end

function LoadCrab(NbCrab)
    crabsLeft = NbCrab
    for i = 1, NbCrab, 1 do
        CreateCrab()
        CrabList[i].x = GameScreen.x + i * CrabList[i].Tile_w
    end
end

local Elapsed = 0
local index = 0

function AnimateCrab(dt)
    Elapsed = Elapsed + dt
    if Elapsed >= 0.2 then
        Elapsed = 0
        if direction >= 0 then
            index = index + 1
        end
        if direction < 0 then
            index = index - 1
        end
        if direction == 0 then
            if index > 3 then
                index = 0
            end
        end
        if direction == 1 then
            if index < 4 then
                index = 4
            end
            if index > 7 then
                index = 4
            end
        end
        if direction < 0 then
            if index < 4 then
                index = 7
            end
            if index > 7 then
                index = 7
            end
        end
    end

    for i = 1, #CrabList, 1 do
        ChangeIndexCrab(i, index)
    end
end

function UpdateCrab(dt)
    for i = #CrabList, 1, -1 do
        CrabList[i].x = CrabList[i].x + direction * speed * dt
        CrabList[i].left = CrabList[i].x
        CrabList[i].right = CrabList[i].x + CrabList[i].Tile_w
        CrabList[i].top = CrabList[i].y
        CrabList[i].bottom = CrabList[i].y + CrabList[i].Tile_h
        if CrabList[i].x >= GameScreen.x + screen_width / 2 - CrabList[i].Tile_w and GoingRight == true then
            direction = direction * -1
            GoingRight = false
        end
        if CrabList[i].x <= GameScreen.x and GoingRight == false then
            GoingRight = true
            direction = direction * -1
        end
    end

    if next(CrabList) == nil then
        StartTransition(dt)
    end

end

function DrawCrab()
    for i = 1, #CrabList, 1 do
        CrabList[i].draw()
    end
end

function ReturnCrabList()
    return CrabList
end

function DestroyCrab(index)
    -- ajouter le code a jouer lorsque qu'un crab est hit --
    table.remove(CrabList, index)
    PlayCrabSound()
    canDrawRed = true
    crabsLeft = crabsLeft - 1
end

function DestroyAllCrabs()
    for i = #CrabList, 1, -1 do
        table.remove(CrabList, i)        
    end
    crabsLeft = 0
end