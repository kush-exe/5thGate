local Bones = {Options = {}, Vehicle = {'chassis', 'windscreen', 'seat_pside_r', 'seat_dside_r', 'bodyshell', 'suspension_lm', 'suspension_lr', 'platelight', 'attach_female', 'attach_male', 'bonnet', 'boot', 'chassis_dummy', 'chassis_Control', 'door_dside_f', 'door_dside_r', 'door_pside_f', 'door_pside_r', 'Gun_GripR', 'windscreen_f', 'platelight', 'VFX_Emitter', 'window_lf', 'window_lr', 'window_rf', 'window_rr', 'engine', 'gun_ammo', 'ROPE_ATTATCH', 'wheel_lf', 'wheel_lr', 'wheel_rf', 'wheel_rr', 'exhaust', 'overheat', 'seat_dside_f', 'seat_pside_f', 'Gun_Nuzzle', 'seat_r'}}
local QBCore = exports['qb-core']:GetCoreObject()

if Config.EnableDefaultOptions then
    local BackEngineVehicles = {
        [`ninef`] = true,
        [`adder`] = true,
        [`vagner`] = true,
        [`t20`] = true,
        [`infernus`] = true,
        [`zentorno`] = true,
        [`reaper`] = true,
        [`comet2`] = true,
        [`comet3`] = true,
        [`jester`] = true,
        [`jester2`] = true,
        [`cheetah`] = true,
        [`cheetah2`] = true,
        [`prototipo`] = true,
        [`turismor`] = true,
        [`pfister811`] = true,
        [`ardent`] = true,
        [`nero`] = true,
        [`nero2`] = true,
        [`tempesta`] = true,
        [`vacca`] = true,
        [`bullet`] = true,
        [`osiris`] = true,
        [`entityxf`] = true,
        [`turismo2`] = true,
        [`fmj`] = true,
        [`re7b`] = true,
        [`tyrus`] = true,
        [`italigtb`] = true,
        [`penetrator`] = true,
        [`monroe`] = true,
        [`ninef2`] = true,
        [`stingergt`] = true,
        [`surfer`] = true,
        [`surfer2`] = true,
        [`gp1`] = true,
        [`autarch`] = true,
        [`tyrant`] = true
    }

    local function ToggleDoor(vehicle, door)
        if GetVehicleDoorLockStatus(vehicle) ~= 2 then
            if GetVehicleDoorAngleRatio(vehicle, door) > 0.0 then
                SetVehicleDoorShut(vehicle, door, false)
            else
                SetVehicleDoorOpen(vehicle, door, false)
            end
        end
    end

    local function smash(vehicle)
        if IsVehicleWindowIntact(vehicle,0) then
            SetVehicleDoorsLocked(vehicle,7)
            TaskEnterVehicle(PlayerPedId(), vehicle, -1, -1, 1.0, 0)
        else
            QBCore.Functions.Notify('The cars window is already broken')
        end
    end

    local function flip()
        local playerPed	= PlayerPedId()
        local coords = GetEntityCoords(playerPed)
        local vehicle = nil
        if IsPedSittingInAnyVehicle(playerPed) then
            TriggerEvent("QBCore:Notify", "Cannot flip while inside vehicle", "error")
            ClearPedTasks(playerPed)
            return
        end
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.5) then
            vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.5, 0, 71)
            if DoesEntityExist(vehicle) then
                QBCore.Functions.Progressbar("accepted_key", "Flipping Vehicle", 12000, false, true, {
                    disableMovement = true,
                    disableCarMovement = true,
                    disableMouse = false,
                    disableCombat = true,
                }, {
                    task = "CODE_HUMAN_MEDIC_TEND_TO_DEAD"
                }, {}, {}, function() -- Done
                    ClearPedTasks(playerPed)
                    FreezeEntityPosition(playerPed, false)
                    vehiclecoords = GetEntityCoords(vehicle)
                    SetEntityCoords(vehicle, vehiclecoords.x+0.5, vehiclecoords.y+0.5, vehiclecoords.z+1)
                    Wait(200)
                    SetEntityRotation(vehicle, GetEntityRotation(PlayerPedId(), 2), 2)
                    Wait(500)
                    SetVehicleOnGroundProperly(vehicle)
                    TriggerEvent("QBCore:Notify", "Success! Vehicle Flipped", "success")
                end, function() -- Cancel
    
                    TriggerEvent("QBCore:Notify", "Vehicle flip failed!", "error")
                    FreezeEntityPosition(playerPed, false)
                    ClearPedTasks(playerPed)								
                end)
            else
                TriggerEvent("QBCore:Notify", "There is no vehicle nearby", "error")
            end
        else
            TriggerEvent("QBCore:Notify", "There is no vehicle nearby", "error")
        end
    end

    Bones.Options['seat_dside_f'] = {
        ["Toggle Front Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Front Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_f') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 0)
            end,
            distance = 1.2
        },
        ["Steal Driver Door"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Steal Door",
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealbodypart', 'door')
            end,
            distance = 0.9
        },
        ["Flip Vehicle"] = {
            icon = "fas fa-car",
            label = "Flip Vehicle",
            canInteract = function(entity)
                return true
            end,
            action = function()
                flip()
            end,
            distance = 1.2
        },
        ["Smash Glass"] = {
            icon = "fas fa-car",
            label = "Smash Glass",
            action = function(entity)
                smash(entity)
            end,
            distance = 1.2
        }
    }

    Bones.Options['seat_pside_f'] = {
        ["Toggle Front Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Front Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_f') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 1)
            end,
            distance = 1.2
        },
        ["Steal Pass Door"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Steal Door",
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealbodypart', 'door')
            end,
            distance = 0.9
        },
        ["Flip Vehicle"] = {
            icon = "fas fa-car",
            label = "Flip Vehicle",
            canInteract = function(entity)
                return true
            end,
            action = function()
                flip()
            end,
            distance = 1.2
        }
    }

    Bones.Options['seat_dside_r'] = {
        ["Toggle Rear Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Rear Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_dside_r') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 2)
            end,
            distance = 1.2
        },
        ["Steal Left Door"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Steal Door",
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealbodypart', 'door')
            end,
            distance = 0.9
        },
        ["Flip Vehicle"] = {
            icon = "fas fa-car",
            label = "Flip Vehicle",
            canInteract = function(entity)
                return true
            end,
            action = function()
                flip()
            end,
            distance = 1.2
        }
    }

    Bones.Options['seat_pside_r'] = {
        ["Toggle Rear Door"] = {
            icon = "fas fa-door-open",
            label = "Toggle Rear Door",
            canInteract = function(entity)
                return GetEntityBoneIndexByName(entity, 'door_pside_r') ~= -1
            end,
            action = function(entity)
                ToggleDoor(entity, 3)
            end,
            distance = 1.2
        },
        ["Steal Right Door"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Steal Door",
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealbodypart', 'door')
            end,
            distance = 0.9
        },
        ["Flip Vehicle"] = {
            icon = "fas fa-car",
            label = "Flip Vehicle",
            canInteract = function(entity)
                return true
            end,
            action = function()
                flip()
            end,
            distance = 1.2
        }
    }

    Bones.Options['bonnet'] = {
        ["Toggle Hood"] = {
            icon = "fa-duotone fa-engine",
            label = "Toggle Hood",
            action = function(entity)
                ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 5 or 4)
            end,
            distance = 0.9
        },
        ["Steal Hood"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Steal Hood",
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealbodypart', 'bonnet')
            end,
            distance = 0.9
        },
        ["Flip Vehicle"] = {
            icon = "fas fa-car",
            label = "Flip Vehicle",
            canInteract = function(entity)
                return true
            end,
            action = function()
                flip()
            end,
            distance = 1.2
        }
    }

    Bones.Options['boot'] = {
        ["Toggle Trunk"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Toggle Trunk",
            action = function(entity)
                ToggleDoor(entity, BackEngineVehicles[GetEntityModel(entity)] and 4 or 5)
            end,
            distance = 0.9
        },
        ["Steal Trunk"] = {
            icon = "fas fa-truck-ramp-box",
            label = "Steal Trunk",
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealbodypart', 'boot')
            end,
            distance = 0.9
        },
        ["Flip Vehicle"] = {
            icon = "fas fa-car",
            label = "Flip Vehicle",
            canInteract = function(entity)
                return true
            end,
            action = function()
                flip()
            end,
            distance = 1.2
        }
    }
--[[
    Bones.Options['wheel_lf'] = {
        ["Steal Rim"] = {
            icon = "fas fa-mask",
            label = "Steal Rim",
            canInteract = function(entity)
                return true
            end,
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealrim', entity)
            end,
            distance = 1.2
        }
    }

    Bones.Options['wheel_lr'] = {
        ["Steal Rim"] = {
            icon = "fas fa-mask",
            label = "Steal Rim",
            canInteract = function(entity)
                return true
            end,
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealrim', entity)
            end,
            distance = 1.2
        }
    }

    Bones.Options['wheel_rf'] = {
        ["Steal Rim"] = {
            icon = "fas fa-mask",
            label = "Steal Rim",
            canInteract = function(entity)
                return true
            end,
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealrim', entity)
            end,
            distance = 1.2
        }
    }

    Bones.Options['wheel_rr'] = {
        ["Steal Rim"] = {
            icon = "fas fa-mask",
            label = "Steal Rim",
            canInteract = function(entity)
                return true
            end,
            action = function(entity)
                TriggerEvent('qb-stealparts:client:stealrim', entity)
            end,
            distance = 1.2
        }
    }--]]
end

return Bones