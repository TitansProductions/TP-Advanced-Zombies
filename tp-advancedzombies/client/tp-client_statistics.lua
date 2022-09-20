ESX, QBCore = nil, nil

local loadedPlayerData = false

local hasUserStatisticsRankingUIOpen = false

local userStatistics = {}

Citizen.CreateThread(function()

    if Config.Framework == "ESX" then

        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(100)
        end
    
    elseif Config.Framework == "QBCore" then
        while QBCore == nil do
    
            QBCore = exports['qb-core']:GetCoreObject()
            Citizen.Wait(100)
        end
    end

end)


if Config.UserStatisticsRanking then
    TriggerServerEvent('tp-advancedzombies:onPlayerStatisticsLoad')
end

RegisterNetEvent("tp-advancedzombies:updatePlayerStatisticsOnClient")
AddEventHandler("tp-advancedzombies:updatePlayerStatisticsOnClient", function(data)
    userStatistics = data
end)

RegisterNetEvent("tp-advancedzombies:loadedPlayerData")
AddEventHandler("tp-advancedzombies:loadedPlayerData", function(cb)
    loadedPlayerData = cb
end)

-- Supporting QBCore Hospital in order to update player deaths.
AddEventHandler('hospital:client:RespawnAtHospital', function()
    if Config.UserStatisticsRanking then
        TriggerServerEvent("tp-advancedzombies:updatePlayerStatistics", "deaths", 1)
    end
end)

function updatePlayerStatistics(type, count)
    if Config.UserStatisticsRanking then
        TriggerServerEvent("tp-advancedzombies:updatePlayerStatistics", type, count)
    end
end


-----------------------------------------------------
-- User Statistic & UI Functions.
-----------------------------------------------------

function openUserStatisticsRankingUI()

    while not loadedPlayerData do
        Citizen.Wait(100)
    end

    if loadedPlayerData then

        SendNUIMessage({
            action = 'addPersonalStatistics',
            stats = {identifier = userStatistics.id, name = userStatistics.name, deaths = userStatistics.deaths, zombie_kills = userStatistics.zombie_kills}
        })
    
        if Config.Framework == "ESX" then
    
            ESX.TriggerServerCallback('tp-advancedzombies:getAllPlayerStatistics', function(players)
    
                for k,v in pairs(players) do
    
                    SendNUIMessage({
                        action = 'addPlayerStatistics',
                        player_det = v,
                        clientIdentifier = userStatistics.id,
                    })
    
                end
        
            end)
    
        elseif Config.Framework == "QBCore" then
    
            QBCore.Functions.TriggerCallback('tp-advancedzombies:getAllPlayerStatistics', function(players) 
                for k,v in pairs(players) do
    
                    SendNUIMessage({
                        action = 'addPlayerStatistics',
                        player_det = v,
                        clientIdentifier = userStatistics.id,
                    })
    
                end
            end)
    
        end
    
        toggleUI(true)
    end

end

function toggleUI(display)
	SetNuiFocus(display,display)

	hasUserStatisticsRankingUIOpen = display

    SendNUIMessage({
        action = 'toggle',
		toggle = display
    })

end

function closeAdvancedZombiesUI()
    if hasUserStatisticsRankingUIOpen then
        SendNUIMessage({action = 'closeUI'})
    end
end


function getIdentifier()
    return userStatistics.id
end

function getZombieKills()
    return userStatistics.zombie_kills
end

-----------------------------------------------------
-- User Statistic & UI NUI Callbacks.
-----------------------------------------------------

RegisterNUICallback('closeUI', function()
	toggleUI(false)
end)

-----------------------------------------------------
-- User Statistic & UI Commands & Key Mapping.
-----------------------------------------------------
if Config.UserStatisticsRanking then
    RegisterCommand(Config.UserStatistics.OpenCommand, function()
    
        if not isPlayerDead() then 
            openUserStatisticsRankingUI() 
        end
    
    end, false)
    
    RegisterKeyMapping(Config.UserStatistics.OpenCommand, 'Open User Statistics (Zombies Ranking UI)', 'keyboard', Config.UserStatistics.OpenKey)
end