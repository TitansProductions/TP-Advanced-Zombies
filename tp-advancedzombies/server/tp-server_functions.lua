
-- ESX & QBCore Support.
ESX, QBCore      = nil, nil

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