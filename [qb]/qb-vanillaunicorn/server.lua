
local QBCore = exports['qb-core']:GetCoreObject()

RegisterServerEvent('paystripclub:pay')
AddEventHandler('paystripclub:pay', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)

	if Player.PlayerData.money.cash >= 250 then
		Player.Functions.RemoveMoney("cash", 250)
		TriggerEvent("qb-bossmenu:server:addAccountMoney", "vanilla", 250)
		TriggerClientEvent('QBCore:Notify', src, "You paid 250$ Entry Fee for VU.")
	else
		TriggerClientEvent('QBCore:Notify', src, 'Not enough money.', 2)
		end
		TriggerClientEvent("strippers:mail", -1, {
            sender = "Vanilla Unicorn",
            subject = "Vanilla Unicorn Receipt",
            message = Player.PlayerData.charinfo.firstname .. " " .. Player.PlayerData.charinfo.lastname .. " has paid 1000$ entry fee for the vanilla unicorn.",
            button = {}
		})
end)

RegisterServerEvent("strippers:spawn")
AddEventHandler("strippers:spawn", function(spawned)
	TriggerClientEvent("strippers:spawn", spawned)
end)

RegisterServerEvent("strippers:updateStrippers")
AddEventHandler("strippers:updateStrippers", function(data)
	TriggerClientEvent("strippers:updateStrippers", -1, data)
	Config.Strippers['locations'] = data
end)

RegisterServerEvent('stripclubstack:pay')
AddEventHandler('stripclubstack:pay', function()
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	
    if Player.PlayerData.money.cash >= 1000 then
		Player.Functions.RemoveMoney("cash", 1000)
		TriggerEvent("qb-bossmenu:server:addAccountMoney", "vanilla", 1000)
    else
        TriggerClientEvent('QBCore:Notify', src, 'Not enough money.', 2)
    end
end)

RegisterServerEvent("strippers:serverDeletePed")
AddEventHandler("strippers:serverDeletePed", function(model, coords)
	TriggerClientEvent("strippers:clientDeletePed", -1, model, coords)
end)