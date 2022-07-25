
RegisterServerEvent('tp-advancedzombies:SyncSpeakingSoundsOnServer')
AddEventHandler('tp-advancedzombies:SyncSpeakingSoundsOnServer', function(entiyCoords)

    TriggerClientEvent('tp-advancedzombies:SyncSpeakingSoundsOnClient', source, entiyCoords)

end)
