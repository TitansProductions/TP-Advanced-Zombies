local currentZoneType = "UNKNOWN"

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.EnteringZoneDelay)

		local coords    = GetEntityCoords(PlayerPedId())
		local isInZone  = false
		local zone      = nil
        local zoneType  = nil
        local canBlockPlayerAggressiveActions = false
        local blockZombiePedSpawning = false

		for k,v in pairs(Config.Zones) do

			if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.ZoneDistance) then
				isInZone                        = true
				zone                            = k
                zoneType                        = v.ZoneType
                canBlockPlayerAggressiveActions = v.BlockPlayerAggressiveActions
                blockZombiePedSpawning          = v.BlockZombiePedSpawning
			end
		end

		if isInZone then
			HasAlreadyEnteredMarker = true
			LastSafezone                = zone
			TriggerEvent('tp-advancedzombies:hasEnteredZone', zone, zoneType, canBlockPlayerAggressiveActions, blockZombiePedSpawning)
		end

		if not isInZone then
			HasAlreadyEnteredMarker = false
			TriggerEvent('tp-advancedzombies:hasExitedZone', LastSafezone)
		end

	end
end)

Citizen.CreateThread(function()

    for _,v in pairs(Config.Zones) do

        if v.EnableZoneBlipData then

            v.blip = AddBlipForRadius(v.Pos.x, v.Pos.y, v.Pos.z, v.ZoneDistance)

            SetBlipHighDetail(v.blip, true)
            SetBlipDisplay(v.blip, v.BlipData.Display)
            SetBlipColour(v.blip, v.BlipData.CircleColor)
            SetBlipAlpha (v.blip, 128)
        
        
            v.blip = AddBlipForCoord(v.Pos.x, v.Pos.y, v.Pos.z)
            SetBlipSprite(v.blip, v.BlipData.Id)
            SetBlipDisplay(v.blip, 3)
            SetBlipScale(v.blip, v.BlipData.Scale)
            SetBlipColour(v.blip, v.BlipData.IdColour)
            SetBlipAsShortRange(v.blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.BlipData.Title)
            EndTextCommandSetBlipName(v.blip)

        end
    end
end)

AddEventHandler('tp-advancedzombies:hasEnteredZone', function(zone, type, blockPlayerAggressiveActions, blockZombiePedSpawning)
	currentZoneType = type

    if blockPlayerAggressiveActions then
        BlockPlayerAggressiveActions()
    end

    if Config.Debug then
        print("Entered " .. currentZoneType)
    end
end)

AddEventHandler('tp-advancedzombies:hasExitedZone', function(zone)
	currentZoneType = "UNKNOWN"
    
    if Config.Debug then
        print("Not inside any zone, current zone type is unknown.")
    end
end)

function getPlayerZoneType()
    return currentZoneType
end

function BlockPlayerAggressiveActions()

    local player = PlayerId()

    SetPlayerCanDoDriveBy(player, false)
    DisablePlayerFiring(player, true)
    SetPlayerInvincible(player, true)
    DisableControlAction(0,24) -- INPUT_ATTACK
    DisableControlAction(0,69) -- INPUT_VEH_ATTACK
    DisableControlAction(0,70) -- INPUT_VEH_ATTACK2
    DisableControlAction(0,92) -- INPUT_VEH_PASSENGER_ATTACK
    DisableControlAction(0,114) -- INPUT_VEH_FLY_ATTACK
    DisableControlAction(0,257) -- INPUT_ATTACK2
    DisableControlAction(0,331) -- INPUT_VEH_FLY_ATTACK2

end
