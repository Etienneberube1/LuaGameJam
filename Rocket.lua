function LoadRocket()

    rocketImage = love.graphics.newImage("assets/Rocket.png")

    rockets = {}
    rocketsExplosionsList = {}

    rocketSpeed = 500;
    rocketScale = 2
    rocketWidth = rocketImage:getWidth() * rocketScale
    rocketHeight = rocketImage:getHeight() * rocketScale

end

function SpawnRocket(posX, posY)

    local rocket = {}

    rocket.x = posX
    rocket.y = posY

    rocket.left = rocket.x
    rocket.right = rocket.x + rocketWidth
    rocket.top = rocket.y
    rocket.bottom = rocket.y + rocketHeight

    rocket.isExploding = false

    table.insert(rockets, rocket)

    local rocketExplosion = {}

    rocketExplosion.frames = 0
    rocketExplosion.timer = 0
    rocketExplosion.quad = nil

    table.insert(rocketsExplosionsList, rocketExplosion)

    AnimateRocketExplosion(#rockets)

end

function UpdateRocket(dt)
    for i = #rockets, 1, -1 do
        
        if rockets[i].isExploding then
            UpdateRocketExplosion(dt, i)
        elseif rockets[i].y > screen_height then
            rockets[i].isExploding = true        
        else
            rockets[i].y = rockets[i].y + rocketSpeed * dt
            rockets[i].top = rockets[i].y
            rockets[i].bottom = rockets[i].y + rocketHeight
        end
    end
end

function DrawRocket()
    for i = #rockets, 1, -1 do
        love.graphics.draw(rocketImage, rockets[i].x, rockets[i].y, 0, rocketScale)
    end
end

function DeleteRocket(index)
    table.remove(rockets, index)
    table.remove(rocketsExplosionsList, index)
end

function DeleteAllRockets()
    for i = #rockets, -1 do
        DeleteRocket(i)
    end
end

function ReturnRockets()
    return rockets
end
