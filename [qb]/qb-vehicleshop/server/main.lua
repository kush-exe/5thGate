QBCore = exports['qb-core']:GetCoreObject()

local NumberCharset = {}
local Charset = {}

for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

-- code

RegisterNetEvent('qb-vehicleshop:server:buyVehicle')
AddEventHandler('qb-vehicleshop:server:buyVehicle', function(vehicleData, garage)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local vData = QBCore.Shared.Vehicles[vehicleData["model"]]
    local bankBalance = pData.PlayerData.money["bank"]
    local cashBalance = pData.PlayerData.money["cash"]
    local chosenBalance = nil

    if bankBalance > cashBalance then
        chosenBalance = "bank"
    else
        chosenBalance = "cash"
    end
    
    if (pData.PlayerData.money[chosenBalance] - vData["price"]) >= 0 then
        local plate = GeneratePlate()
        MySQL.Async.execute("INSERT INTO `player_vehicles` (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `garage`) VALUES ('"..pData.PlayerData.license.."', '"..cid.."', '"..vData["model"].."', '"..GetHashKey(vData["model"]).."', '{}', '"..plate.."', '"..garage.."')")
        TriggerClientEvent("QBCore:Notify", src, "Your vehicle was delivered to "..QB.GarageLabel[garage], "success", 5000)
        pData.Functions.RemoveMoney(chosenBalance, vData["price"], "vehicle-bought-in-shop")
        TriggerEvent("qb-log:server:sendLog", cid, "vehiclebought", {model=vData["model"], name=vData["name"], from="garage", location=QB.GarageLabel[garage], moneyType="bank", price=vData["price"], plate=plate})
        TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle bought (garage)", "green", "**"..GetPlayerName(src) .. "** Bought a " .. vData["name"] .. " for $" .. vData["price"])
    else
		TriggerClientEvent("QBCore:Notify", src, "You don\'t have enough money, you\'re short $"..(vData["price"] - pData.PlayerData.money[chosenBalance]), "error", 5000)
    end
end)

RegisterNetEvent('qb-vehicleshop:server:buyShowroomVehicle')
AddEventHandler('qb-vehicleshop:server:buyShowroomVehicle', function(vehicle)
    local src = source
    local pData = QBCore.Functions.GetPlayer(src)
    local cid = pData.PlayerData.citizenid
    local bankBalance = pData.PlayerData.money["bank"]
    local cashBalance = pData.PlayerData.money["cash"]
    local vehiclePrice = QBCore.Shared.Vehicles[vehicle]["price"]
    local plate = GeneratePlate()
    local chosenBalance = nil

    if bankBalance > cashBalance then
        chosenBalance = "bank"
    else
        chosenBalance = "cash"
    end

    if (pData.PlayerData.money[chosenBalance] - vehiclePrice) >= 0 then
        MySQL.Async.execute("INSERT INTO `player_vehicles` (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`, `garage`) VALUES ('"..pData.PlayerData.license.."', '"..cid.."', '"..vehicle.."', '"..GetHashKey(vehicle).."', '{}', '"..plate.."', 0, 'motelgarage')")
        TriggerClientEvent("QBCore:Notify", src, "Successful! Your vehicle is waiting for you outside.", "success", 5000)
        TriggerClientEvent('qb-vehicleshop:client:buyShowroomVehicle', src, vehicle, plate)
        pData.Functions.RemoveMoney(chosenBalance, vehiclePrice, "vehicle-bought-in-showroom")
        TriggerEvent("qb-log:server:sendLog", cid, "vehiclebought", {model=vehicle, name=QBCore.Shared.Vehicles[vehicle]["name"], from="showroom", moneyType="bank", price=QBCore.Shared.Vehicles[vehicle]["price"], plate=plate})
        TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle purchased (showroom)", "green", "**"..GetPlayerName(src) .. "** has a " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " purchased for $" .. QBCore.Shared.Vehicles[vehicle]["price"])
    else
        TriggerClientEvent("QBCore:Notify", src, "You don\'t have enough money, you\'re short asdf$"..(vehiclePrice - pData.PlayerData.money[chosenBalance]), "error", 5000)
    end
end)

function format_thousand(v)
    local s = string.format("%d", math.floor(v))
    local pos = string.len(s) % 3
    if pos == 0 then pos = 3 end
    return string.sub(s, 1, pos)
            .. string.gsub(string.sub(s, pos+1), "(...)", ".%1")
end

function GeneratePlate()
    local plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
    MySQL.Async.fetchAll("SELECT * FROM `player_vehicles` WHERE `plate` = '"..plate.."'", function(result)
        while (result[1] ~= nil) do
            plate = tostring(GetRandomNumber(1)) .. GetRandomLetter(2) .. tostring(GetRandomNumber(3)) .. GetRandomLetter(2)
        end
        return plate
    end)
    return plate:upper()
end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function GetRandomLetter(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomLetter(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

RegisterServerEvent('qb-vehicleshop:server:setShowroomCarInUse')
AddEventHandler('qb-vehicleshop:server:setShowroomCarInUse', function(showroomVehicle, bool)
    QB.ShowroomVehicles[showroomVehicle].inUse = bool
    TriggerClientEvent('qb-vehicleshop:client:setShowroomCarInUse', -1, showroomVehicle, bool)
end)

RegisterServerEvent('qb-vehicleshop:server:setShowroomVehicle')
AddEventHandler('qb-vehicleshop:server:setShowroomVehicle', function(vData, k)
    QB.ShowroomVehicles[k].chosenVehicle = vData
    TriggerClientEvent('qb-vehicleshop:client:setShowroomVehicle', -1, vData, k)
end)

RegisterServerEvent('qb-vehicleshop:server:SetCustomShowroomVeh')
AddEventHandler('qb-vehicleshop:server:SetCustomShowroomVeh', function(vData, k)
    QB.ShowroomVehicles[k].vehicle = vData
    TriggerClientEvent('qb-vehicleshop:client:SetCustomShowroomVeh', -1, vData, k)
end)

QBCore.Commands.Add("sell", "Sell vehicle out of custom car dealer", {{name="id", help="Player ID"}}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local TargetId = args[1]

    if Player.PlayerData.job.name == "cardealer" then
        if TargetId ~= nil then
            TriggerClientEvent('qb-vehicleshop:client:SellCustomVehicle', source, TargetId)
        else
            TriggerClientEvent('QBCore:Notify', source, 'That player id is not near you', 'error')
        end
    else
        TriggerClientEvent('QBCore:Notify', source, 'You aren\'t a car dealer', 'error')
    end
end)

QBCore.Commands.Add("testdrive", "Take a test drive", {}, false, function(source, args)
    local Player = QBCore.Functions.GetPlayer(source)
    local TargetId = args[1]

    if Player.PlayerData.job.name == "cardealer" then
        TriggerClientEvent('qb-vehicleshop:client:DoTestrit', source, GeneratePlate())
    else
        TriggerClientEvent('QBCore:Notify', source, 'You aren\'t a car dealer', 'error')
    end
end)

RegisterServerEvent('qb-vehicleshop:server:SellCustomVehicle')
AddEventHandler('qb-vehicleshop:server:SellCustomVehicle', function(TargetId, ShowroomSlot)
    TriggerClientEvent('qb-vehicleshop:client:SetVehicleBuying', TargetId, ShowroomSlot)
end)

RegisterNetEvent('lux:server:allowpurchase')
AddEventHandler('lux:server:allowpurchase', function(TargetId, ShowroomSlot)
    local src = source
    local salesperson = QBCore.Functions.GetPlayer(src)
    local n = salesperson.PlayerData.charinfo.firstname..' '..salesperson.PlayerData.charinfo.lastname
    TriggerClientEvent('lux:client:allowpurchase', TargetId, ShowroomSlot, n)
end)

RegisterServerEvent('qb-vehicleshop:server:ConfirmVehicle')
AddEventHandler('qb-vehicleshop:server:ConfirmVehicle', function(ShowroomVehicle, salesperson)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local vehicle = ShowroomVehicle.vehicle
    local VehPrice = QBCore.Shared.Vehicles[ShowroomVehicle.vehicle].price
    local plate = GeneratePlate()

    if Player.PlayerData.money.cash >= VehPrice then
        Player.Functions.RemoveMoney('cash', VehPrice)
        TriggerClientEvent('qb-vehicleshop:client:ConfirmVehicle', src, ShowroomVehicle, plate)
        MySQL.Async.insert("INSERT INTO `player_vehicles` (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`, `garage`) VALUES ('"..Player.PlayerData.license.."', '"..Player.PlayerData.citizenid.."', '"..ShowroomVehicle.vehicle.."', '"..GetHashKey(ShowroomVehicle.vehicle).."', '{}', '"..plate.."', 0, 'motelgarage')")
    elseif Player.PlayerData.money.bank >= VehPrice then
        Player.Functions.RemoveMoney('bank', VehPrice)
        TriggerClientEvent('qb-vehicleshop:client:ConfirmVehicle', src, ShowroomVehicle, plate)
        MySQL.Async.insert("INSERT INTO `player_vehicles` (`license`, `citizenid`, `vehicle`, `hash`, `mods`, `plate`, `state`, `garage`) VALUES ('"..Player.PlayerData.license.."', '"..Player.PlayerData.citizenid.."', '"..ShowroomVehicle.vehicle.."', '"..GetHashKey(ShowroomVehicle.vehicle).."', '{}', '"..plate.."', 0, 'motelgarage')")
        TriggerEvent("qb-log:server:CreateLog", "vehicleshop", "Vehicle purchased (Lux)", "green", "**"..GetPlayerName(src) .. "** " .. QBCore.Shared.Vehicles[vehicle]["name"] .. " purchased for $" .. QBCore.Shared.Vehicles[vehicle]["price"] .. "SOLD BY " .. salesperson)
        TriggerEvent("qb-bossmenu:server:addAccountMoney", "cardealer", VehPrice * 0.15)
    else
        if Player.PlayerData.money.cash > Player.PlayerData.money.bank then
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough money in your bank... you\'re short ('..(Player.PlayerData.money.cash - VehPrice)..',-)')
        else
            TriggerClientEvent('QBCore:Notify', src, 'You don\'t have enough money in your bank... you\'re short ('..(Player.PlayerData.money.bank - VehPrice)..',-)')
        end
    end
end)

QBCore.Functions.CreateCallback('qb-vehicleshop:server:SellVehicle', function(source, cb, vehicle, plate)
    local VehicleData = QBCore.Shared.VehicleModels[vehicle]
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    MySQL.Async.fetchAll("SELECT * FROM `player_vehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `plate` = '"..plate.."'", function(result)
        if result[1] ~= nil then
            Player.Functions.AddMoney('bank', math.ceil(VehicleData["price"] / 100 * 60))
            MySQL.Async.execute("DELETE FROM `player_vehicles` WHERE `citizenid` = '"..Player.PlayerData.citizenid.."' AND `plate` = '"..plate.."'")
            cb(true)
        else
            cb(false)
        end
    end)
end)