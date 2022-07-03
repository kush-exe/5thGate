local QBCore = exports['qb-core']:GetCoreObject()
local owners = {}
local VehicleList = {}

QBCore.Functions.CreateCallback('carremote:checkOwnedVehicle', function(source, cb, plate)
    local Player = QBCore.Functions.GetPlayer(source)
    --cb(CheckOwner(plate, Player.PlayerData.citizenid))
	cb(true)
end)


RegisterNetEvent('carremote:playSoundFromVehicle')
AddEventHandler('carremote:playSoundFromVehicle', function(maxDistance, soundFile, maxVolume, vehicleNetId)
	TriggerClientEvent('carremote:playSoundFromVehicle', source, source, maxDistance, soundFile, maxVolume, vehicleNetId)
end)

RegisterNetEvent('carremote:playSound')
AddEventHandler('carremote:playSound', function(maxDistance, soundFile, soundVolume)
    TriggerClientEvent('carremote:playSound', source, source, maxDistance, soundFile, soundVolume)
end)