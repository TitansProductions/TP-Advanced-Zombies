
AddEventHandler("playerDropped", function(reason)
    TriggerClientEvent('tp-advancedzombies:clearZombies', source)
end)

RegisterServerEvent("tp-advancedzombies:getZombieEntityOnServer")
AddEventHandler("tp-advancedzombies:getZombieEntityOnServer", function(data)
	TriggerClientEvent("tp-advancedzombies:getZombieEntityOnClient", source, data)
end)


RegisterServerEvent("tp-advancedzombies:onZombieSpawningStart")
AddEventHandler("tp-advancedzombies:onZombieSpawningStart", function()
	TriggerClientEvent("tp-advancedzombies:onZombieSync", source)
end)

RegisterServerEvent('tp-advancedzombies:SyncSpeakingSoundsOnServer')
AddEventHandler('tp-advancedzombies:SyncSpeakingSoundsOnServer', function(entiyCoords)

    TriggerClientEvent('tp-advancedzombies:SyncSpeakingSoundsOnClient', source, entiyCoords)

end)

