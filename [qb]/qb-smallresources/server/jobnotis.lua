local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('qb-smallresources:server:sendJobNoti', function(job, message)
    local Player = QBCore.Functions.GetPlayer(source)
    local cid = Player.PlayerData.citizenid
    TriggerClientEvent('qb-smallresources:client:receiveJobNoti', -1, job, message, cid)
end)

RegisterNetEvent('qb-smallresources:server:sendReply', function(job, cid)
    local Player = QBCore.Functions.GetPlayerByCitizenId(cid)
    if Player ~= nil then
        TriggerClientEvent('qb-smallresources:client:receiveReply', Player.PlayerData.source, job)
    end
end)