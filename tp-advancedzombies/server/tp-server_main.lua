ESX, QBCore      = nil, nil

players = {}


if Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

AddEventHandler("onResourceStop", function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    players = nil
end)

AddEventHandler("playerDropped", function(reason)
    players[source] = nil
    TriggerClientEvent('tp-advancedzombies:clearZombies', source)
    TriggerClientEvent("tp-advancedzombies:onPlayerUpdate", -1, players)
end)

RegisterServerEvent("tp-advancedzombies:onNewPlayerId")
AddEventHandler("tp-advancedzombies:onNewPlayerId", function(id)
    players[source] = id
    TriggerClientEvent("tp-advancedzombies:onPlayerUpdate", -1, players)
end)


RegisterServerEvent("tp-advancedzombies:onZombieSpawningStart")
AddEventHandler("tp-advancedzombies:onZombieSpawningStart", function()
	TriggerClientEvent("tp-advancedzombies:onZombieSync", source)
end)

