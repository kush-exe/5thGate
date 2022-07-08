
QBCore = exports['qb-core']:GetCoreObject()
isLoggedIn = false

PlayerJob = {}

--- CODE

local inVehicleShop = false

insidePDM = false
insideLuxury = false


vehicleCategorys = {
    ["coupes"] = {
        label = "Coupes",
        vehicles = {}
    },
    ["sedans"] = {
        label = "Sedans",
        vehicles = {}
    },
    ["muscle"] = {
        label = "Muscle",
        vehicles = {}
    },
    ["suvs"] = {
        label = "SUVs",
        vehicles = {}
    },
    ["compacts"] = {
        label = "Compacts",
        vehicles = {}
    },
    ["vans"] = {
        label = "Vans",
        vehicles = {}
    },
    ["super"] = {
        label = "Super",
        vehicles = {}
    },
    ["sports"] = {
        label = "Sports",
        vehicles = {}
    },
    ["sportsclassics"] = {
        label = "Sports Classics",
        vehicles = {}
    },
    ["motorcycles"] = {
        label = "Motorcycles",
        vehicles = {}
    },
    ["offroad"] = {
        label = "Offroad",
        vehicles = {}
    },
}

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    QBCore.Functions.GetPlayerData(function(PlayerData)
        PlayerJob = PlayerData.job
    end)
    isLoggedIn = true
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for k, v in pairs(QBCore.Shared.Vehicles) do
        if v["shop"] == "pdm" then
            for cat,_ in pairs(vehicleCategorys) do
                if QBCore.Shared.Vehicles[k]["category"] == cat then
                    table.insert(vehicleCategorys[cat].vehicles, QBCore.Shared.Vehicles[k])
                end
            end
        end
    end
end)

function openVehicleShop(bool)
    SetNuiFocus(bool, bool)
    SendNUIMessage({
        action = "ui",
        ui = bool
    })
end

function setupVehicles(vehs)
    SendNUIMessage({
        action = "setupVehicles",
        vehicles = vehs
    })
end

RegisterNUICallback('GetCategoryVehicles', function(data)
    setupVehicles(shopVehicles[data.selectedCategory])
end)

RegisterNUICallback('exit', function()
    openVehicleShop(false)
end)

RegisterNUICallback('buyVehicle', function(data)
    local vehicleData = data.vehicleData
    local garage = data.garage

    TriggerServerEvent('qb-vehicleshop:server:buyVehicle', vehicleData, garage)
    openVehicleShop(false)
end)

RegisterNetEvent('qb-vehicleshop:client:spawnBoughtVehicle')
AddEventHandler('qb-vehicleshop:client:spawnBoughtVehicle', function(vehicle)
    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetEntityHeading(veh, QB.SpawnPoint.h)
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
    end, QB.SpawnPoint, true)
end)

-- Citizen.CreateThread(function()
--     Citizen.Wait(100)
--     while true do
--         local ped = PlayerPedId()
--         local pos = GetEntityCoords(ped)

--         if isLoggedIn then
--             for k, v in pairs(QB.VehicleShops) do
--                 local dist = GetDistanceBetweenCoords(pos, QB.VehicleShops[k].x, QB.VehicleShops[k].y, QB.VehicleShops[k].z)
--                 if dist <= 15 then
--                     DrawMarker(2, QB.VehicleShops[k].x, QB.VehicleShops[k].y, QB.VehicleShops[k].z + 0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.2, 0.15, 200, 0, 0, 222, false, false, false, true, false, false, false)
--                     if dist <= 1.5 then
--                         QBCore.Functions.DrawText3D(QB.VehicleShops[k].x, QB.VehicleShops[k].y, QB.VehicleShops[k].z + 1.3, '~g~E~w~ - Premium Deluxe Motorsports')
--                         if IsControlJustPressed(0, 51) then
--                             openVehicleShop(true)
--                         end
--                     end
--                 end
--             end
--         end

--         Citizen.Wait(0)
--     end
-- end)

Citizen.CreateThread(function()
    for k, v in pairs(QB.VehicleShops) do
        Dealer = AddBlipForCoord(QB.VehicleShops[k].x, QB.VehicleShops[k].y, QB.VehicleShops[k].z)

        SetBlipSprite (Dealer, 326)
        SetBlipDisplay(Dealer, 4)
        SetBlipScale  (Dealer, 0.75)
        SetBlipAsShortRange(Dealer, true)
        SetBlipColour(Dealer, 3)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Premium Deluxe Motorsports")
        EndTextCommandSetBlipName(Dealer)
    end
end)

Citizen.CreateThread(function()
    QuickSell = AddBlipForCoord(QB.QuickSell.x, QB.QuickSell.y, QB.QuickSell.z)

    SetBlipSprite (QuickSell, 108)
    SetBlipDisplay(QuickSell, 4)
    SetBlipScale  (QuickSell, 0.55)
    SetBlipAsShortRange(QuickSell, true)
    SetBlipColour(QuickSell, 3)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentSubstringPlayerName("PDM Quick Sell")
    EndTextCommandSetBlipName(QuickSell)
end)

local PDMZone = PolyZone:Create({
    vector2(-79.192260742188, -1125.691040039),
    vector2(-26.407430648804, -1126.6867675782),
    vector2(-11.02359676361, -1086.9711914062),
    vector2(-58.1205368042, -1070.287475586)
  }, {
    name="pdm",
    minZ = 25.0,
    maxZ = 28.5,
    debugGrid = false,
    gridDivisions = 25
})

local LuxuryZone = PolyZone:Create({
    vector2(-823.6079711914, -199.30744934082),
    vector2(-790.2357788086, -179.87368774414),
    vector2(-754.68518066406, -242.51640319824),
    vector2(-791.16577148438, -256.7541809082)
    }, {
    name="luxury",
    minZ = 36.0,
    maxZ = 38.0,
    debugGrid = false,
    gridDivisions = 25
})

local HeadBone = 0x796e;
--[[
Citizen.CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local coord = GetPedBoneCoords(plyPed, HeadBone)
        local inPolyPDM = PDMZone:isPointInside(coord)
        local inPolyLuxury = LuxuryZone:isPointInside(coord)
        -- if true, then player just entered zone
        if inPolyPDM and not insidePDM then
            insidePDM = true
        elseif not inPolyPDM and insidePDM then
            insidePDM = false
        elseif inPolyLuxury and not insideLuxury then
            insideLuxury = true
        elseif not inPolyLuxury and insideLuxury then
            insideLuxury = false
        end
        Citizen.Wait(1500)
    end
end)--]]