
-- ESX & QBCore Support.
ESX, QBCore      = nil, nil
zombieEntites = {}

if Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end


function ShowHelpNotification(txt)

	if Config.Framework == "ESX" then
        ESX.ShowHelpNotification(txt, true)

	elseif Config.Framework == "QBCore" then

	end

end

function getIdentifier(_source)

	if Config.Framework == "ESX" then
        local xPlayer    = ESX.GetPlayerFromId(_source)

		if xPlayer then
			return xPlayer.identifier
		end

	elseif Config.Framework == "QBCore" then
        local xPlayer    = QBCore.Functions.GetPlayer(_source)

		if xPlayer then
			return xPlayer.PlayerData.citizenid
		end
	end

	return nil

end

function getOnlinePlayers()

	if Config.Framework == "ESX" then
		return ESX.GetPlayers()

	elseif Config.Framework == "QBCore" then
		return QBCore.Functions.GetPlayers()
	end
	
end

function addEntityToTable(entity,EntityModel)
    table.insert(zombieEntites, {entity = entity, name = EntityModel})
end

function getEntityTable()
    return zombieEntites
end

function removeEntityFromTable(entity)
    for i, v in ipairs (zombieEntites) do 
        if (v.entity == entity) then
        zombieEntites[i] = nil
        end
    end
end

RegisterServerEvent("tp-advancedzombies:addZombie")
AddEventHandler("tp-advancedzombies:addZombie", function(entity, EntityModel)
	if Config.Debug then
		print("entity added | server table")
	end
    addEntityToTable(entity,EntityModel)
end)

RegisterServerEvent("tp-advancedzombies:removeZombie")
AddEventHandler("tp-advancedzombies:removeZombie", function(entity, EntityModel)
	if Config.Debug then
		print("entity removed | server table")
	end
    removeEntityFromTable(entity)
end)

ESX.RegisterServerCallback('tp-advancedzombies:getZombies', function(source, cb)
	if Config.Debug then
		print("callback initiated")
	end
    zombies = getEntityTable()
	if Config.Debug then
		print(dump(zombies))
	end
    cb(zombies)
end)

function dump(o)
    if type(o) == 'table' then
       local s = '{ '
       for k,v in pairs(o) do
          if type(k) ~= 'number' then k = '"'..k..'"' end
          s = s .. '['..k..'] = ' .. dump(v) .. ','
       end
       return s .. '} '
    else
       return tostring(o)
    end
 end