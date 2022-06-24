local QBCore = exports['qb-core']:GetCoreObject()

local VehicleList = {}


QBCore.Functions.CreateCallback('vehiclekeys:CheckHasKey', function(source, cb, plate)
    local Player = QBCore.Functions.GetPlayer(source)
    local retval = false
    --cb(CheckOwner(plate, Player.PlayerData.citizenid))
    local keys = Player.Functions.GetItemsByName('vehiclekey')
    if keys then
        for _,v in pairs(keys) do
            if plate == v.info.plate then
                retval = true
            end
        end
    end
    cb(retval)
end)

--[[
RegisterServerEvent('vehiclekeys:server:SetVehicleOwner')
AddEventHandler('vehiclekeys:server:SetVehicleOwner', function(plate)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if VehicleList ~= nil then
        if DoesPlateExist(plate) then
            for k, val in pairs(VehicleList) do
                if val.plate == plate then
                    table.insert(VehicleList[k].owners, Player.PlayerData.citizenid)
                end
            end
        else
            local vehicleId = #VehicleList+1
            VehicleList[vehicleId] = {
                plate = plate, 
                owners = {},
            }
            VehicleList[vehicleId].owners[1] = Player.PlayerData.citizenid
        end
    else
        local vehicleId = #VehicleList+1
        VehicleList[vehicleId] = {
            plate = plate, 
            owners = {},
        }
        VehicleList[vehicleId].owners[1] = Player.PlayerData.citizenid
    end
end)

RegisterServerEvent('vehiclekeys:server:GiveVehicleKeys')
AddEventHandler('vehiclekeys:server:GiveVehicleKeys', function(plate, target)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if CheckOwner(plate, Player.PlayerData.citizenid) then
        if QBCore.Functions.GetPlayer(target) ~= nil then
            TriggerClientEvent('vehiclekeys:client:SetOwner', target, plate)
            TriggerClientEvent('QBCore:Notify', src, "You gave the keys!")
            TriggerClientEvent('QBCore:Notify', target, "You got the keys!")
        else
            TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "Player not online!")
        end
    else
        TriggerClientEvent('chatMessage', src, "SYSTEM", "error", "You dont have the keys of the vehicle!")
    end
end)--]]

QBCore.Commands.Add("motor", "Toggle engine On/Off of the vehicle", {}, false, function(source, args)
	TriggerClientEvent('vehiclekeys:client:ToggleEngine', source)
end)
--[[
QBCore.Commands.Add("givekeys", "Give keys of the vehicle", {{name = "id", help = "ID"}}, true, function(source, args)
	local src = source
    local target = tonumber(args[1])
    TriggerClientEvent('vehiclekeys:client:GiveKeys', src, target)
end)--]]
--[[
function DoesPlateExist(plate)
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if val.plate == plate then
                return true
            end
        end
    end
    return false
end--]]

RegisterServerEvent('vehiclekeys:server:SetVehicleOwner')
AddEventHandler('vehiclekeys:server:SetVehicleOwner', function(plate, model, owner)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    AddVehicleKey(plate,model, owner)
end)

function AddVehicleKey(plate, model, owner)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)
	local info = {}
	if owner == nil then info.owner = Player.PlayerData.charinfo.firstname .. ' ' .. Player.PlayerData.charinfo.lastname else info.owner = "STOLEN" end
	if QBCore.Shared.VehicleModels[model] ~= nil then
        info.vehname = QBCore.Shared.VehicleModels[model]['brand'] .. ' ' .. QBCore.Shared.VehicleModels[model]['name']
    elseif model ~= nil then
        info.vehname = model
    else
        info.vehname = 'Unknown'
    end
	info.plate = plate
	info.citizenid = Player.PlayerData.citizenid
    info.quality = 100
	Player.Functions.AddItem('vehiclekey', 1, nil, info)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items['vehiclekey'], 'add')
end

function CheckOwner(plate, identifier)
    local retval = false
    if VehicleList ~= nil then
        for k, val in pairs(VehicleList) do
            if val.plate == plate then
                for key, owner in pairs(VehicleList[k].owners) do
                    if owner == identifier then
                        retval = true
                    end
                end
            end
        end
    end
    return retval
end


QBCore.Functions.CreateUseableItem("lockpick", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, false)
end)

QBCore.Functions.CreateUseableItem("advancedlockpick", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("lockpicks:UseLockpick", source, true)
end)

QBCore.Functions.CreateUseableItem("vehiclekey", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    if item.info.quality > 0 then
        TriggerClientEvent("vehiclekeys:client:UseKey", source, item.info.plate)
    else
        TriggerClientEvent('QBCore:Notify', source, "These keys are broken and cannot be used!", "error")
    end
end)

