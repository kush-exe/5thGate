local QBCore = exports['qb-core']:GetCoreObject()

QBCore.Commands.Add('pfix', 'Fix Vehicle (Emergency Only)', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)

    if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance') then
        TriggerClientEvent('police:fix', src)
    else
        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message server">SYSTEM: {0}</div>',
            args = { 'This command is for emergency services!' }
        })
    end
    
end)

QBCore.Commands.Add('livery', 'Set vehicle livery ', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local livery = tonumber(args[1])

    if Player and (Player.PlayerData.job.name == 'police' or Player.PlayerData.job.name == 'ambulance' or Player.PlayerData.job.name == 'mechanic' or Player.PlayerData.job.name == 'mechanic2' or Player.PlayerData.job.name == 'mechanic3') then
        if Player then
            TriggerClientEvent('police:livery', src, livery)
        else
            TriggerClientEvent('chat:addMessage', src, {
                template = '<div class="chat-message server">SYSTEM: {0}</div>',
                args = { 'Not Authorized!' }
            })
        end
    else
        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message server">Usage /livery [Number]</div>',
        })
    end
end)

QBCore.Commands.Add('ptint', 'Set Tint (Emergency Only)', {}, false, function(source, args)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player and (Player.PlayerData.job.name == 'police') then
        TriggerClientEvent('police:windowtint', src, tonumber(args[1]))
    else
        TriggerClientEvent('chat:addMessage', src, {
            template = '<div class="chat-message server">SYSTEM: {0}</div>',
            args = { 'This command is for emergency services!' }
        })
    end
    
end)