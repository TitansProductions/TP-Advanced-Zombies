
ESX, QBCore      = nil, nil

if Config.Framework == "ESX" then
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
elseif Config.Framework == "QBCore" then
    QBCore = exports['qb-core']:GetCoreObject()
end


function getIdentifier()

	if Config.Framework == "ESX" then
        local xPlayer    = ESX.GetPlayerFromId(_source)

		if xPlayer then
			return xPlayer.identifier
		end

	elseif Config.Framework == "QBCore" then
        local xPlayer    = QBCore.Functions.GetPlayer(_source)

		if xPlayer then
			return xPlayer.PlayerData.license
		end
	end

	return nil

end