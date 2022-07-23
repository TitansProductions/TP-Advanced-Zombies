ESX, QBCore      = nil, nil

if Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end

RegisterServerEvent("tp-advancedzombies:onZombiesLootReward")
AddEventHandler("tp-advancedzombies:onZombiesLootReward", function(entityName)
    local _source = source
    entityName = string.lower(entityName)

    local entityRewardLevel = Config.ZombiePedModelsData[entityName].loot
    local rewardData = Config.Zombies.Loot.LootRewardPackages[entityRewardLevel]
    
    if entityRewardLevel and rewardData then
        if Config.Framework == "ESX" then
            local xPlayer    = ESX.GetPlayerFromId(_source)
    
            if rewardData.account.cash and rewardData.account.cash > 0 then
                xPlayer.addMoney(rewardData.account.cash)
            end
    
            if rewardData.account.black_money and rewardData.account.black_money > 0 then
                xPlayer.addAccountMoney("black_money", rewardData.account.black_money)
            end
    
            if rewardData.items then
    
                for k, v in pairs (rewardData.items) do
    
                    local randomChance = math.random(0, 100)
    
                    if randomChance <= v.chance then
    
                        if v.randomAmount then
                            local randomAmount = math.random(v.min, v.max)
        
                            if randomAmount > 0 then
                                xPlayer.addInventoryItem(k, randomAmount)
                            end
                        else
                            if v.max > 0 then
                                xPlayer.addInventoryItem(k, v.max)
                            end
                        end
    
                    end
    
                end
            end
    
            if rewardData.weapons then
    
                local randomChance = math.random(0, 100)
    
                if randomChance <= v.chance then
    
                    if v.randomAmount then
                        local randomAmount = math.random(v.min, v.max)
    
                        if randomAmount <= 0 then
                            xPlayer.addWeapon(k, 1)
                        else
                            xPlayer.addWeapon(k, randomAmount)
                        end
    
                    else
                        if v.max <= 0 then
                            xPlayer.addInventoryItem(k, 1)
                        else
                            xPlayer.addInventoryItem(k, v.max)
                        end
                    end
    
                end
    
            end
    
    
        elseif Config.Framework == "QBCore" then
            local xPlayer    = QBCore.Functions.GetPlayer(_source)
            
            if rewardData.account.cash and rewardData.account.cash > 0 then
                xPlayer.Functions.AddMoney('cash', rewardData.account.cash)
            end
    
            if rewardData.account.black_money and rewardData.account.black_money > 0 then
                xPlayer.Functions.AddMoney('black_money', rewardData.account.black_money)
            end
            
            if rewardData.items then
    
                for k, v in pairs (rewardData.items) do
    
                    local randomChance = math.random(0, 100)
    
                    if randomChance <= v.chance then
    
                        if v.randomAmount then
                            local randomAmount = math.random(v.min, v.max)
        
                            if randomAmount > 0 then
                                xPlayer.Functions.AddItem(k, randomAmount)
                            end
                        else
                            if v.max > 0 then
                                xPlayer.Functions.AddItem(k, v.max)
                            end
                        end
    
                    end
    
                end
    
            end
    
            if rewardData.weapons then
    
                local randomChance = math.random(0, 100)
    
                if randomChance <= v.chance then
    
                    if v.randomAmount then
                        local randomAmount = math.random(v.min, v.max)
    
                        if randomAmount <= 0 then
                            xPlayer.Functions.AddItem(k, 1)
                        else
                            xPlayer.Functions.AddItem(k, randomAmount)
                        end
    
                    else
                        if v.max <= 0 then
                            xPlayer.Functions.AddItem(k, 1)
                        else
                            xPlayer.Functions.AddItem(k, v.max)
                        end
                    end
    
                end
    
            end
    
        end
    else
        print("The specified zombie {" .. entityName .. "} does not have any loot data in Config.ZombiePedModelsData or the loot package does not exist.")
    end

end)

function randomValue(min, max)
    return math.random(min, max)
end