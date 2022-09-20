userStatistics = {}

-- Save user statistics when the player leaves or disconnects from the game.
AddEventHandler('playerDropped', function(reason)
    saveUserStatistics(source)
end)

-- Save all users data when the script stops.
ESX, QBCore = nil, nil

if Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

AddEventHandler('onResourceStop', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
      return
    end

    for k,v in pairs(getOnlinePlayers()) do
        saveUserStatistics(v)
    end

    print("Saving all the online player statistics..")

end)


RegisterServerEvent('tp-advancedzombies:onPlayerStatisticsLoad')
AddEventHandler('tp-advancedzombies:onPlayerStatisticsLoad', function()
    local _source          = source
    local loadedPlayerData = false

    Wait(1000)

    -- Waiting for identifier to be valid in order to run the code below. An identifier can be null when using multicharacters (not character selected).
    while getIdentifier(_source) == nil do Citizen.Wait(1000) end

    local identifier = getIdentifier(_source)

    -- Checking if identifier exists in the tp_user_statistics table, if not, we insert the new ID to the table.
    MySQL.Async.fetchAll('SELECT * from tp_user_statistics WHERE identifier = @identifier',{
        ["@identifier"] = identifier
    },function (info)
        if info[1] == nil then

            MySQL.Async.execute('INSERT INTO tp_user_statistics (identifier, name, deaths, zombie_kills) VALUES (@identifier, @name, @deaths, @zombie_kills)',
            {
                ['@identifier'] = identifier,
                ['@name'] = GetPlayerName(_source),
                ['@deaths'] = 0,
                ['@zombie_kills'] = 0,
            })

            loadedPlayerData = true

            print("Inserting new player with the ID: " .. identifier .. " (" .. GetPlayerName(_source) .. ") to tp_user_statistics table.")
        else
            loadedPlayerData = true
        end
    end)

    while not loadedPlayerData do
        Citizen.Wait(100)
    end

    -- If tp_user_statistics table has been loaded / checked with the player identifier, we start loading all the player statistics.
    if loadedPlayerData then
    
        Wait(5000)
    
        MySQL.Async.fetchAll('SELECT * FROM tp_user_statistics WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        }, function(result)
    
            if result[1] then
    
                local zombieKills = result[1].zombie_kills
                local playerDeaths = result[1].deaths

                local data = { id = identifier, name = GetPlayerName(_source), deaths = playerDeaths, zombie_kills = zombieKills}
                table.insert(userStatistics, data)

                TriggerClientEvent("tp-advancedzombies:updatePlayerStatisticsOnClient", _source, data)
                print("Loaded: " .. GetPlayerName(_source).. " with the following statistics: [Deaths: " .. data.deaths .. " | Zombie Kills: ".. data.zombie_kills .. "]")

            end
    
        end)

        Wait(1000)
        TriggerClientEvent("tp-advancedzombies:loadedPlayerData", _source, true)

    end

end)

RegisterServerEvent('tp-advancedzombies:updatePlayerStatistics')
AddEventHandler('tp-advancedzombies:updatePlayerStatistics', function(type, count)
    local _source = source

    local identifier = getIdentifier(_source)

    for k, v in pairs(userStatistics) do
        if v.id == identifier then

            if type == "zombie_kills" then
                v.zombie_kills = v.zombie_kills + count

            elseif type == "deaths" then
                v.deaths = v.deaths + count
            end

            TriggerClientEvent("tp-advancedzombies:updatePlayerStatisticsOnClient", _source, v)
        end
    end

end)


function saveUserStatistics(_source)
    local _identifier = getIdentifier(_source)

    for k, v in pairs(userStatistics) do

        if v.id == _identifier then
            local zombieKills = v.zombie_kills
            local playerDeaths = v.deaths

            MySQL.Sync.execute('UPDATE tp_user_statistics SET deaths = @deaths, zombie_kills = @zombie_kills WHERE identifier = @identifier', {
                ["identifier"] = _identifier,
                ["deaths"] = playerDeaths,
                ["zombie_kills"] = zombieKills
            }) 

        end

    end
end

if Config.Framework == "ESX" then

    ESX.RegisterServerCallback('tp-advancedzombies:getAllPlayerStatistics', function(source, cb)

        local results = MySQL.Sync.fetchAll('SELECT * FROM tp_user_statistics ORDER BY zombie_kills DESC')

        for k,v in pairs(results) do

            if containsIdentifier(v.identifier) then
                v.zombie_kills = getZombieKills(v.identifier)
                v.deaths = getDeaths(v.identifier)
            end

            if next(results,k) == nil then
                table.sort(results, function (k1, k2) return k1.zombie_kills > k2.zombie_kills end )
            end

        end

        cb(results)
    
    end)

end

if Config.Framework == "QBCore" then

    QBCore.Functions.CreateCallback('tp-advancedzombies:getAllPlayerStatistics', function(source,cb)
        local results = MySQL.Sync.fetchAll('SELECT * FROM tp_user_statistics ORDER BY zombie_kills DESC')

        for k,v in pairs(results) do

            if containsIdentifier(v.identifier) then
                v.zombie_kills = getZombieKills(v.identifier)
                v.deaths = getDeaths(v.identifier)
            end

            if next(results,k) == nil then
                table.sort(results, function (k1, k2) return k1.zombie_kills > k2.zombie_kills end )
            end

        end

        cb(results)
    end)

end

function containsIdentifier(identifier)
    for k,v in pairs(userStatistics) do
        if v.id == identifier then
            return true
        end
    end

    return false
end

function getZombieKills(identifier)
    for k,v in pairs(userStatistics) do
        if v.id == identifier then
            return v.zombie_kills
        end
    end

    return 0
end

function getDeaths(identifier)
    for k,v in pairs(userStatistics) do
        if v.id == identifier then
            return v.deaths
        end
    end

    return 0
end