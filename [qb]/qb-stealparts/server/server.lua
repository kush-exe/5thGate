local QBCore = exports['qb-core']:GetCoreObject()

--events
RegisterNetEvent('qb-stealparts:server:giverim', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('stolenwheel', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['stolenrim'], "add")
end)

RegisterNetEvent('qb-stealparts:server:takerim', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('stolenwheel', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['stolenrim'], "add")
end)

RegisterNetEvent('qb-stealparts:server:givepart', function(part)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.AddItem('stolenwheel', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['stolenrim'], "add")
end)

RegisterNetEvent('qb-stealparts:server:takepart', function(part)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    Player.Functions.RemoveItem('stolenwheel', 1)
    TriggerClientEvent("inventory:client:ItemBox", src, QBCore.Shared.Items['stolenrim'], "add")
end)

--items
QBCore.Functions.CreateUseableItem("stolenwheel", function(source)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if not Player.Functions.GetItemByName("stolenwheel") then return end
    TriggerClientEvent("qb-stealparts:client:AddRim", src)
end)



