function isHit()

    hit, indexshot, indexenemy, indexRocket = Collision(ReturnShotList(), ReturnPlanesList(), ReturnRockets())
    if hit == true then
        if indexenemy ~= nil then
            planes[indexenemy].isExploding = true
        end
        if indexRocket ~= nil then
            rockets[indexRocket].isExploding = true
        end
        destoyShot(indexshot)
        score = score + scoringValue
        canDrawHit = true
    end

    hit, indexshot, indexenemy, indexRocket = Collision(ReturnPlayerList(), ReturnPlanesList(), ReturnRockets())
    if hit == true then
        if indexenemy ~= nil then
            planes[indexenemy].isExploding = true
        end
        if indexRocket ~= nil then
            rockets[indexRocket].isExploding = true
        end
        PlayerHit()
    end

    hit, indexshot, indexenemy, indexRocket = Collision(ReturnCrabList(), ReturnPlanesList(), ReturnRockets())
    if hit == true then
        if indexRocket ~= nil then
            rockets[indexRocket].isExploding = true
        end
        if indexenemy ~= nil then
            planes[indexenemy].isExploding = true
        end
        DestroyCrab(indexshot)
    end
    
end

function Collision(colliderList, planesList, rocketsList)
    -- set default values
    local hit = false
    local indexshot = nil
    local indexenemy = nil
    local indexRocket = nil

    -- loop over colliders
    for i = #colliderList, 1, -1 do
        -- check collisions with planes
        for j = #planesList, 1, -1 do
            if colliderList[i].right > planesList[j].left 
            and colliderList[i].left < planesList[j].right 
            and colliderList[i].bottom > planesList[j].top 
            and colliderList[i].top < planesList[j].bottom 
            and planesList[j].isExploding == false then
                hit = true
                indexshot = i
                indexenemy = j
                PlayExplosionSound()
            end
        end
        -- check collisions with projectiles
        for k = #rocketsList, 1, -1 do
            if colliderList[i].right > rocketsList[k].left 
            and colliderList[i].left < rocketsList[k].right 
            and colliderList[i].bottom > rocketsList[k].top 
            and colliderList[i].top < rocketsList[k].bottom 
            and rocketsList[k].isExploding == false then
                hit = true
                indexshot = i
                indexRocket = k
                PlayExplosionSound()
            end
        end
    end
    return hit, indexshot, indexenemy, indexRocket
end