function LoadExplosion()

    explosions = {}

    exploSheet = love.graphics.newImage("assets/explosion.png")
    exploSheetWidth = 160
    exploSheetHeight = 32
    exploScale = 3
    exploWidth = 32
    exploHeight = 32
    exploColomn = 4
    exploDelay = 0.1

end

function AnimateExplosion(index)
    if explosions[index].frames == 6 then
        planes[index].isExploding = false
        DeletePlane(index)
    else
        explosions[index].frames = explosions[index].frames + 1
        exploTileX = (explosions[index].frames % exploColomn) * exploWidth
        explosions[index].quad = love.graphics.newQuad(exploTileX, 0, exploWidth, exploHeight, exploSheetWidth, exploSheetHeight)
    end
end

function AnimateRocketExplosion(index)
    if rocketsExplosionsList[index].frames == 6 then
        rockets[index].isExploding = false
        DeleteRocket(index)
    else
        rocketsExplosionsList[index].frames = rocketsExplosionsList[index].frames + 1
        exploTileX = (rocketsExplosionsList[index].frames % exploColomn) * exploWidth
        rocketsExplosionsList[index].quad = love.graphics.newQuad(exploTileX, 0, exploWidth, exploHeight, exploSheetWidth, exploSheetHeight)
    end
end

function UpdateExplosion(dt, index)

    explosions[index].timer = explosions[index].timer + dt

    if explosions[index].timer >= exploDelay then
        explosions[index].timer = 0
        AnimateExplosion(index)
    end
end

function UpdateRocketExplosion(dt, index)

    rocketsExplosionsList[index].timer = rocketsExplosionsList[index].timer + dt

    if rocketsExplosionsList[index].timer >= exploDelay then
        rocketsExplosionsList[index].timer = 0
        AnimateRocketExplosion(index)
    end
end

function DrawExplosion()

    for i = #explosions, 1, -1 do
        if planes[i] ~= null then
            if planes[i].isExploding then
                love.graphics.draw(exploSheet, explosions[i].quad, planes[i].x, planes[i].y, 0, exploScale)
            end
        end
    end

    for i = #rocketsExplosionsList, 1, -1 do
        if planes[i] ~= null then
            if rockets[i].isExploding then
                love.graphics.draw(exploSheet, rocketsExplosionsList[i].quad, rockets[i].x - exploWidth, rockets[i].y, 0, exploScale)
            end
        end
    end
end