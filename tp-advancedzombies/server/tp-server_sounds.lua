
RegisterServerEvent('tp-advancedzombies:SyncSpeakingSoundsOnServer')
AddEventHandler('tp-advancedzombies:SyncSpeakingSoundsOnServer', function(entiyCoords)

    TriggerClientEvent('tp-advancedzombies:SyncSpeakingSoundsOnClient', -1, source, entiyCoords)

end)
