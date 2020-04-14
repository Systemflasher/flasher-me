-----<Written by flasher>-----Discord:flasher#0271 >

ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)


function GetCharacterName(source)
	local result = MySQL.Sync.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier', {
		['@identifier'] = GetPlayerIdentifiers(source)[1]
	})

	if result[1] and result[1].firstname and result[1].lastname then
		
			return ('%s %s'):format(result[1].firstname, result[1].lastname)
		end
	
end


local logEnabled, isMasked = true, false


RegisterServerEvent('3dme:toggleMasked')
AddEventHandler('3dme:toggleMasked', function(state)
	isMasked = state
end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	local playerName = GetCharacterName(source)
	
	if isMasked then
		TriggerClientEvent("flasher:metext", -1, source, "Maskerad man", text)
	else
		TriggerClientEvent("flasher:metext", -1, source, playerName, text)
	end
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
	if logEnabled then
		setLog(text, source)
	end
end)





