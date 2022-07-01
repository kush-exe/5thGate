local QBCore = exports['qb-core']:GetCoreObject()

local timeout = false

local function doTimeout()
    Citizen.CreateThread(function()
        if timeout then
            Wait(90000)
            timeout = false
        end
    end)
end

local function sendNoti(job, message)
    if not timeout then
        TriggerServerEvent('qb-smallresources:server:sendJobNoti', job, message)
        doTimeout()
    else
        QBCore.Functions.Notify('Please wait!')
    end
end

RegisterNetEvent('qb-smallresources:client:sendJobNotiMech', function()
    sendNoti('mechanic', 'A client is requesting a mechanic at the shop.')
end)

RegisterNetEvent('qb-smallresources:client:sendReply', function(data)
    TriggerServerEvent('qb-smallresources:server:sendReply', data.job, data.cid)
end)

RegisterNetEvent('qb-smallresources:client:receiveJobNoti', function(job, message, cid)
    if QBCore.Functions.GetPlayerData().job.name == job then
        local data = {
            ['cid'] = cid,
            ['job'] = job
        }
        print('here2')
        TriggerServerEvent('jpr-newphone:server:sendNewMail', {
            sender = string.upper(job),
            subject = "Waiting",
            message = message,
            button = {
                enabled = true,
                buttonEvent = "qb-smallresources:client:sendReply",
                buttonData = data
            }
        })
    end
end)

RegisterNetEvent('qb-smallresources:client:receiveReply', function(job)
    TriggerServerEvent('jpr-newphone:server:sendNewMail', {
        sender = string.upper(job),
        subject = "Reply from "..string.upper(job),
        message = "Please have a seat, someone will be with you shortly",
    })
end)