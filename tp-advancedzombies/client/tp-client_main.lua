-- tp-advancedzombies:onPlayerZombieKill client event in order to send in server side.


ESX, QBCore            = nil, nil

zombiesList            = {}
players, entitys       = {}, {}

local loadedPlayerData = true
local isDead           = false

local playerIsInSafezone = false

TriggerServerEvent("tp-advancedzombies:onZombieSpawningStart")
TriggerServerEvent("tp-advancedzombies:onNewPlayerId", PlayerId())

AddEventHandler('esx:onPlayerDeath', function(data)
    isDead = true
end)

AddEventHandler('hospital:server:SetDeathStatus', function(data)
    isDead = true
end)

AddEventHandler('playerSpawned', function()
	isDead = false
end)

AddEventHandler('disc-death:onPlayerRevive', function(data)
    isDead = false
end)


if Config.NotHealthRecharge then
	SetPlayerHealthRechargeMultiplier(PlayerId(), 0.0)
end

if Config.MuteAmbience then
	StartAudioScene('CHARACTER_CHANGE_IN_SKY_SCENE')
end

RegisterNetEvent("tp-advancedzombies:onPlayerUpdate")
AddEventHandler("tp-advancedzombies:onPlayerUpdate", function(mPlayers)
	players = mPlayers
end)

if Config.Zombies.PlayCustomSpeakingSounds then
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(3000)

            StartPlayingZombieSpeakingSounds()
        end
    end)

    StartPlayingZombieSpeakingSounds = function()

        for i, v in pairs(entitys) do
            for j, player in pairs(players) do
                local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
                local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(v.entity), true)
  
                -- Playing zombie sounds when close to the player.
                if distance <= 30.1 then
                    TriggerServerEvent('tp-advancedzombies:SyncSpeakingSoundsOnServer', GetEntityCoords(v.entity))
                end

            end

        end
    end

    RegisterNetEvent('tp-advancedzombies:SyncSpeakingSoundsOnClient')
    AddEventHandler('tp-advancedzombies:SyncSpeakingSoundsOnClient', function(playerNetId, entityCoords)

        local lCoords = entityCoords
        local eCoords = GetEntityCoords(PlayerPedId())
        local distIs  = Vdist(lCoords.x, lCoords.y, lCoords.z, eCoords.x, eCoords.y, eCoords.z)
    
        local number = distIs / 0.0
        local volume = Config.Zombies.SpeakingSounds.Volume 
        local sounds = {}

        if (distIs >= 10.1 and distIs <= 30.01) then
            number = distIs / 30.0
            sounds = Config.Zombies.SpeakingSounds.DistanceSounds.far

        elseif (distIs <= 10.0) then
            number = distIs / 10.0 
            sounds = Config.Zombies.SpeakingSounds.DistanceSounds.close
        end

        Wait(500)
        volume = round(1-number, 2)

        if volume >= Config.Zombies.SpeakingSounds.Volume then
            volume = Config.Zombies.SpeakingSounds.Volume 
        end

        print(volume)

        if sounds ~= nil then
            SendNUIMessage({ 
                Sound = sounds[ math.random( #sounds ) ], 
                Volume = volume
            })
        end
        
    end)

end

if Config.Zombies.HumanEatingAndAttackingAnimation then
    local animationSleepTime = 2000

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(animationSleepTime)

            StartHumanEatingAndAttackingAnimation()
        end
    end)

    StartHumanEatingAndAttackingAnimation = function()

        for i, v in pairs(entitys) do
            for j, player in pairs(players) do
                local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
                local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(player)), GetEntityCoords(v.entity), true)

                -- Playing zombies & players animation on attack.
                if distance <= 1.2 and not isDead and not isHavingEmote then
                    RequestAnimDict("misscarsteal4@actor")
                    TaskPlayAnim(v.entity,"misscarsteal4@actor","stumble",1.0, 1.0, 500, 9, 1.0, 0, 0, 0)

                    RequestAnimDict("misscarsteal4@actor")
                    TaskPlayAnim(PlayerPedId(),"misscarsteal4@actor","stumble",1.0, 1.0, 500, 9, 1.0, 0, 0, 0)

                    TaskGoToEntity(v.entity, PlayerPedId(), -1, 0.0, 500.0, 1073741824, 0)
                end

                -- Playing zombies animation when a player is dead.
                if distance <= 1.0 and isDead and not isHavingEmote then

                    animsAction(v.entity, { lib = "amb@world_human_gardener_plant@female@idle_a", anim = "idle_a_female"}) 
                end
            

            end

        end
    end

end

-- On Zombie Peds Looting
if Config.Zombies.DropLoot then

    local markerType      = Config.Zombies.Loot.LootMarker.Type
    local scales          = {x = Config.Zombies.Loot.LootMarker.ScaleX, y = Config.Zombies.Loot.LootMarker.ScaleY, z = Config.Zombies.Loot.LootMarker.ScaleZ}
    local rgba            = {r = Config.Zombies.Loot.LootMarker.R, g = Config.Zombies.Loot.LootMarker.G, b = Config.Zombies.Loot.LootMarker.B, a = Config.Zombies.Loot.LootMarker.A}

    local markerDistance  = Config.Zombies.Loot.LootMarker.MarkerDistance
    local markerSleepTime = Config.Zombies.Loot.LootMarker.SleepTime

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            local coords = GetEntityCoords(PlayerPedId())
            local letSleep = true
    
            if zombiesList then
                for k, v in pairs(zombiesList) do
    
                    local distance = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
        
                    if distance < markerDistance then

                        letSleep = false
                        DrawMarker(markerType, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, scales.x, scales.y, scales.z, rgba.r, rgba.g, rgba.b, rgba.a, false, false, 2, true, nil, nil, false)
                    end
                    
                end
    
            end
    
            if letSleep then
                Citizen.Wait(markerSleepTime)
            end
        end
    end)

    local droppedLootSleepTime = Config.Zombies.Loot.DropData.SleepTime
    local droppedLootDistanceToPickup = Config.Zombies.Loot.DropData.DistanceToPickup
    local droppedLootPickupKey = Config.Zombies.Loot.PickupKey

    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)
    
            local sleep = true
    
            local playerCoords = GetEntityCoords(PlayerPedId(), true)
            playerX, playerY, playerZ = table.unpack(playerCoords)
    
            if not IsPedInAnyVehicle(PlayerPedId(), false) then
                if zombiesList then
                    for k, v in pairs(zombiesList) do
    
                        local distance = GetDistanceBetweenCoords(playerCoords, v.x, v.y, v.z, true)
        
                        if distance <= droppedLootDistanceToPickup then
    
                            sleep = false
    
                            if Config.Zombies.Loot.LootMarker.DrawText3Ds then
                                DrawText3Ds( v.x, v.y, v.z + 0.5, Locales['press_to_search'])
                            end
            
                            if IsControlJustReleased(1, droppedLootPickupKey) then
                                if DoesEntityExist(GetPlayerPed(-1)) then

                                    RequestAnimDict("random@domestic")
                                    while not HasAnimDictLoaded("random@domestic") do
                                        Citizen.Wait(1)
                                    end
                                    TaskPlayAnim(PlayerPedId(), "random@domestic", "pickup_low", 8.0, -8, 2000, 2, 0, 0, 0, 0)

                                    TriggerServerEvent("tp-advancedzombies:onZombiesLootReward", v.entityName)

                                    Wait(100)
                                    table.remove(zombiesList, k)

                                end
                            end
                        end
        
                    end
                end
            end
    
            if sleep then
                Citizen.Wait(droppedLootSleepTime)
            end
        end
    end)

    -- On Zombie Killing in order to get the dropped loot.
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(0)

            StartCheckingZombiePedKills()
        end
    end)

    StartCheckingZombiePedKills = function()
        local dropLootChance = Config.Zombies.Loot.DropLootChance

        for i, v in pairs(entitys) do
            playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
    
            pedX, pedY, pedZ = table.unpack(GetEntityCoords(v.entity, true))
    
            if not DoesEntityExist(v.entity) then
                table.remove(entitys, i)
            end
    
            if IsPedDeadOrDying(v.entity, 1) == 1 then
                if GetPedSourceOfDeath(v.entity) == PlayerPedId() then
    
                    local deadZombieLocation = GetEntityCoords(v.entity, true)
    
                    TriggerEvent("tp-advancedzombies:onPlayerZombieKill")

                    local randomChance = math.random(0, 100)
                                    
                    if Config.Debug then
                        print("Killed a {".. v.name .."} zombie ped model with a random chance of dropping loot {" .. randomChance .. " <= " .. dropLootChance .. "}.")
                    end

                    if randomChance <= dropLootChance then

                        table.insert(zombiesList,{
                            entityName = v.name,

                            x = deadZombieLocation.x,
                            y = deadZombieLocation.y,
                            z = deadZombieLocation.z,
                        })
        
                    end
    
                    local model = GetEntityModel(v.entity)
                    SetEntityAsNoLongerNeeded(v.entity)
                    SetModelAsNoLongerNeeded(model)
                    table.remove(entitys, i)
    
                    Wait(2000)
                
                    DeleteEntity(v.entity)
                end
            end
        end
    end
end


AddEventHandler('tp-advancedzombies:hasEnteredZone', function(zone, type, blockPlayerAggressiveActions, blockZombiePedSpawning)
    if blockZombiePedSpawning then
        playerIsInSafezone = true
    end
end)

AddEventHandler('tp-advancedzombies:hasExitedZone', function(zone)
    playerIsInSafezone = false
end)

RegisterNetEvent("tp-advancedzombies:onZombieSync")
AddEventHandler("tp-advancedzombies:onZombieSync", function()

	AddRelationshipGroup("zombie")
	SetRelationshipBetweenGroups(0, GetHashKey("zombie"), GetHashKey("PLAYER"))
	SetRelationshipBetweenGroups(2, GetHashKey("PLAYER"), GetHashKey("zombie"))


    local spawnZombies     = Config.Zombies.SpawnZombie
    local maxSpawnDistance = Config.Zombies.MaxSpawnDistance
    local minSpawnDistance = Config.Zombies.MinSpawnDistance
    local despawnDistance  = Config.Zombies.DespawnDistance
    local spawnZombieDelay = Config.Zombies.SpawnDelay

	while true do
		Citizen.Wait(spawnZombieDelay)
		local coords = GetEntityCoords(PlayerPedId())

		if loadedPlayerData and playerIsInSafezone then
			for i, v in pairs(entitys) do
				pedX, pedY, pedZ = table.unpack(GetEntityCoords(v.entity, true))
				if not DoesEntityExist(v.entity) then
					table.remove(entitys, i)
				end

				local model = GetEntityModel(v.entity)
				SetEntityAsNoLongerNeeded(v.entity)
				SetModelAsNoLongerNeeded(model)
				DeleteEntity(v.entity)
				table.remove(entitys,i)
			end
		end

		if loadedPlayerData and not playerIsInSafezone then

			if #entitys < spawnZombies then
				
				x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))

				EntityModel = Config.ZombiePedModels[math.random(1, #Config.ZombiePedModels)]
				EntityModel = string.upper(EntityModel)
				RequestModel(GetHashKey(EntityModel))
				while not HasModelLoaded(GetHashKey(EntityModel)) or not HasCollisionForModelLoaded(GetHashKey(EntityModel)) do
					Wait(1)
				end
				
				local posX = x
				local posY = y
				local posZ = z + 999.0
	
				repeat
					Wait(1)
	
					posX = x + math.random(-maxSpawnDistance, maxSpawnDistance)
					posY = y + math.random(-maxSpawnDistance, maxSpawnDistance)
	
					_,posZ = GetGroundZFor_3dCoord(posX+.0,posY+.0,z,1)
	
					for _, player in pairs(players) do
						Wait(1)
						playerX, playerY = table.unpack(GetEntityCoords(GetPlayerPed(player), true))
						if posX > playerX - minSpawnDistance and posX < playerX + minSpawnDistance or posY > playerY - minSpawnDistance and posY < playerY + minSpawnDistance then
							canSpawn = false
							break
						else
							canSpawn = true
						end
					end
				until canSpawn

				local entity = CreatePed(4, GetHashKey(EntityModel), posX, posY, posZ, 0.0, false, false)
                local entityMaxHealth = Config.ZombiePedModelsData[string.lower(EntityModel)].data.health

                SetEntityHealth(entity, entityMaxHealth)

				local walk = Config.ZombiePedModelWalks[math.random(1, #Config.ZombiePedModelWalks)]
							
				RequestAnimSet(walk)
				while not HasAnimSetLoaded(walk) do
					Citizen.Wait(1)
				end
	
	
				--TaskGoToEntity(entity, GetPlayerPed(-1), -1, 0.0, 1.0, 1073741824, 0)
				SetPedMovementClipset(entity, walk, 1.5)
				TaskWanderStandard(entity, 10.0, 10)
				SetCanAttackFriendly(entity, true, true)
				SetPedCanEvasiveDive(entity, false)
				SetPedRelationshipGroupHash(entity, GetHashKey("zombie"))
				SetPedCombatAbility(entity, 0)
				SetPedMoveRateOverride(entity,10.0)
				SetRunSprintMultiplierForPlayer(entity, 1.49)
				SetPedCombatRange(entity,0)

				SetPedCombatMovement(entity, 0)
				SetPedAlertness(entity,0)
				--SetPedIsDrunk(entity, true)
				SetPedConfigFlag(entity,100,1)

				ApplyPedDamagePack(entity,"BigHitByVehicle", 1.0, 9.0)
				ApplyPedDamagePack(entity,"SCR_Dumpster", 1.0, 9.0)
				ApplyPedDamagePack(entity,"SCR_Torture", 1.0, 9.0)
				ApplyPedDamagePack(entity,"Splashback_Face_0", 1.0, 9.0)
				ApplyPedDamagePack(entity,"SCR_Cougar", 1.0, 9.0)
				ApplyPedDamagePack(entity,"SCR_Shark", 1.0, 9.0)
	
				DisablePedPainAudio(entity, true)
				StopPedSpeaking(entity,true)
				SetEntityAsMissionEntity(entity, true, true)
	
				--if not NetworkGetEntityIsNetworked(entity) then
				--	NetworkRegisterEntityAsNetworked(entity)
				--end
	
				table.insert(entitys, {entity = entity, name = EntityModel})

				local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
				local distance = GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)), GetEntityCoords(entity), true)
					
				TaskGoToEntity(entity, GetPlayerPed(-1), -1, 0.0, 500.0, 1073741824, 0)

                if Config.Debug then
                    print("Spawned " .. EntityModel .. " zombie ped model with Max Health: {" .. entityMaxHealth .. "}.")
                end
		
			end	
		
			for i, v in pairs(entitys) do
				if not DoesEntityExist(v.entity) then
					SetEntityAsNoLongerNeeded(v.entity)
					table.remove(entitys, i)
				else
					local playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
					local pedX, pedY, pedZ = table.unpack(GetEntityCoords(v.entity, true))	
						
					if pedX < playerX - despawnDistance or pedX > playerX + despawnDistance or pedY < playerY -despawnDistance or pedY > playerY + despawnDistance then
						local model = GetEntityModel(v.entity)
						SetEntityAsNoLongerNeeded(v.entity)
						SetModelAsNoLongerNeeded(model)
						--Citizen.Trace("Zombie Eliminated\n")
						table.remove(entitys, i)
					end
				end
					
				if IsEntityInWater(v.entity) then
					local model = GetEntityModel(v.entity)
					SetEntityAsNoLongerNeeded(v.entity)
					SetModelAsNoLongerNeeded(model)
					DeleteEntity(v.entity)
					table.remove(entitys,i)
					--Citizen.Trace("Zombie Eliminated from Water\n")
				end
			end
		end
	end
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(0)
        for i, v in pairs(entitys) do
	       	playerX, playerY, playerZ = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			pedX, pedY, pedZ = table.unpack(GetEntityCoords(v.entity, true))
			if IsPedDeadOrDying(v.entity, 1) == 1 then
				--none :v
			else
				if(Vdist(playerX, playerY, playerZ, pedX, pedY, pedZ) < 0.6)then
					if IsPedRagdoll(v.entity, 1) ~= 1 then
						if not IsPedGettingUp(v.entity) then

							RequestAnimDict("misscarsteal4@actor")
							TaskPlayAnim(v.entity,"misscarsteal4@actor","stumble",1.0, 1.0, 500, 9, 1.0, 0, 0, 0)

							local playerPed = PlayerPedId()

                            local entityName = string.lower(v.name)

                            local withoutArmorDamage     = Config.ZombiePedModelsData[entityName].data.damage_without_armor
                            local armorDamage            = Config.ZombiePedModelsData[entityName].data.damage_with_armor

                            local armor = GetPedArmour(playerPed)

                            if armor > 0 then

                                if armorDamage == nil or armorDamage == 0 then
                                    armorDamage = 10
                                end

                                SetPedArmour(playerPed, armor - armorDamage)
    
                            else
                                local health = GetEntityHealth(playerPed)

                                if withoutArmorDamage == nil or withoutArmorDamage == 0 then
                                    withoutArmorDamage = 15
                                end

                                SetEntityHealth(playerPed, health - withoutArmorDamage)

                            end

                
							Wait(1000)	

							-- Allowing entities to go to the player after any attack in order to keep them in track and not get bugged (Staying Frozen).
							TaskGoToEntity(v.entity, playerPed, -1, 0.0, 500.0, 1073741824, 0)
						end
					end
				end
			end
		end
    end
end)

RegisterNetEvent('tp-advancedzombies:clearZombies')
AddEventHandler('tp-advancedzombies:clearZombies', function()

    for i, v in pairs(entitys) do

        if not DoesEntityExist(v.entity) then
            table.remove(entitys, i)
        end

        local model = GetEntityModel(v.entity)
        SetEntityAsNoLongerNeeded(v.entity)
        SetModelAsNoLongerNeeded(model)
        DeleteEntity(v.entity)
	end
end)


AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    TriggerEvent('tp-advancedzombies:clearZombies')
end)
