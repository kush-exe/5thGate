local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('police:livery')
AddEventHandler('police:livery', function(livery)

    if IsPedInAnyVehicle(PlayerPedId()) then
        local vehicle = GetVehiclePedIsIn(PlayerPedId())

        if GetVehicleLiveryCount(vehicle) == -1 then
            TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message server">SYSTEM: {0}</div>',
                args = { 'Vehicle dont have any liveries' }
            })
            return
        end

        if livery and GetVehicleLiveryCount(vehicle) >= livery then
            SetVehicleLivery(vehicle, livery, true)
            return
        else
            TriggerEvent('chat:addMessage', {
                template = '<div class="chat-message server">Available Liveries: {0}</div>',
                args = { GetVehicleLiveryCount(vehicle) }
            })
            return
        end
    
    else
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message server">SYSTEM: {0}</div>',
            args = { 'You have to be in vehicle' }
        })
        return
    end
end)

local PoliceGarages = {
    { ['x'] = 424.1455, ['y'] = -1023.361, ['z'] = 28.92278, ['h'] = 300.83587 },
    { ['x'] = -459.241, ['y'] = 6002.0151, ['z'] = 31.342147, ['h'] = 200.63348 },
    { ['x'] = -439.5925, ['y'] = 6029.1791, ['z'] = 31.340551, ['h'] = 274.22802 },
    { ['x'] = 1855.5954, ['y'] = 3674.6323, ['z'] = 33.661075, ['h'] = 30.010299 },
    { ['x'] = 293.09509, ['y'] = -581.854, ['z'] = 43.193058, ['h'] = 152.69309 },
    { ['x'] = 293.09509, ['y'] = -581.854, ['z'] = 43.193058, ['h'] = 152.69309 },
    { ['x'] = 1855.0419, ['y'] = 2587.0893, ['z'] = 45.106185, ['h'] = 110.52773 },
    { ['x'] = -342.9639, ['y'] = -136.1628, ['z'] = 39.009616, ['h'] = 270.94482 },
    { ['x'] = -211.3267, ['y'] = -1326.596, ['z'] = 30.89038, ['h'] = 261.77297 },
    { ['x'] = 731.14245, ['y'] = -1088.785, ['z'] = 22.163265, ['h'] = 300.03933 },
	{ ['x'] = -1629.60, ['y'] = -1141.96, ['z'] = 0.86, ['h'] = 146.34 },
	{ ['x'] = -2814.367, ['y'] = 2380.24, ['z'] = 0.31, ['h'] = 65.84 },
	{ ['x'] = -641.04, ['y'] = 6357.82, ['z'] = -0.23, ['h'] = 61.35 },
	{ ['x'] = 1543.67, ['y'] = 3900.56, ['z'] = 30.43, ['h'] = 143.82 }
}

function IsNearPoliceGarage()
    local plyCoords = GetEntityCoords(PlayerPedId())

    for k,v in pairs(PoliceGarages) do
        local distance = GetDistanceBetweenCoords(plyCoords.x, plyCoords.y,plyCoords.z, v.x, v.y, v.z)
        if distance < 100 then
            return true
        end
    end

    return false
end

RegisterNetEvent('police:fix')
AddEventHandler('police:fix', function()
    if not IsNearPoliceGarage() then
        return
    end

    if IsPedInAnyVehicle(PlayerPedId()) then
		local veh = GetVehiclePedIsIn(PlayerPedId())
        --FreezeEntityPosition(veh, true)
		--Progressbar(15000,"Fixing Vehicle")
        SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message system">SYSTEM: {0}</div>',
            args = { 'Fixed!' }
        })
		--FreezeEntityPosition(veh, false)
    else
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message server">SYSTEM: {0}</div>',
            args = { 'You have to be in vehicle' }
        })
        return
    end
end)

RegisterNetEvent('police:windowtint')
AddEventHandler('police:windowtint', function(num)

    if IsPedInAnyVehicle(PlayerPedId()) then
        local props = QBCore.Functions.GetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()))
        props["modEngine"] = 3
        props['windowTint'] = num
        QBCore.Functions.SetVehicleProperties(GetVehiclePedIsIn(PlayerPedId()), props)
        SetVehicleFixed(GetVehiclePedIsIn(PlayerPedId()))
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message system">SYSTEM: {0}</div>',
            args = { 'Installed!' }
        })
    else
        TriggerEvent('chat:addMessage', {
            template = '<div class="chat-message server">SYSTEM: {0}</div>',
            args = { 'You have to be in vehicle' }
        })
        return
    end
end)