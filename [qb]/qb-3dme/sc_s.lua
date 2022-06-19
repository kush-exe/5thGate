local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('me', 'Me message.', {}, false, function(source, args)
	if source == 0 or source == "Console" then return end

	args = table.concat(args, ' ')
	TriggerClientEvent('u7x!A%D*', -1, source, args, "me")
	TriggerEvent('qb-logs:server:createLog', GetCurrentResourceName(), GetCurrentResourceName(), '**ME** ' .. args, source)
end)

QBCore.Commands.Add('do', 'Do message.', {}, false, function(source, args)
	if source == 0 then return end

	args = table.concat(args, ' ')
	TriggerClientEvent('u7x!A%D*', -1, source, args, "do")
	TriggerEvent('qb-logs:server:createLog', GetCurrentResourceName(), GetCurrentResourceName(), '**DO** ' .. args, source)
end)

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('u7x!A%D*', -1, source, text, "do")
end)