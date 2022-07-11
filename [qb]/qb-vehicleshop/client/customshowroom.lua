local ClosestCustomVehicle = 1
local CustomModelLoaded = true
local CustomVehicleList = {}
local tablet = 0
local purchaseable = 0
local salesperson = nil

Citizen.CreateThread(function()
    for k, v in pairs(QB.VehicleShops) do
        Dealer = AddBlipForCoord(-795.91, -220.21, 37.07)

        SetBlipSprite (Dealer, 326)
        SetBlipDisplay(Dealer, 4)
        SetBlipScale  (Dealer, 0.75)
        SetBlipAsShortRange(Dealer, true)
        SetBlipColour(Dealer, 3)

        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName("Diamond Autos")
        EndTextCommandSetBlipName(Dealer)
    end
end)

exports["qb-target"]:AddBoxZone("lux1", vector3(-794.91, -211.25, 37.08), 0.4, 1, {
    name="lux1",
    heading=132,
    --debugPoly=true,
    minZ=36.08,
    maxZ=37.48
    }, {
        options = {
            {
                type = "client",
                event = "lux:client:tablet",
                icon = "fas fa-book-open",
                label = "Catalog",
                job = "cardealer",
                tablet = 3
            },
            {
                type = "client",
                event = "lux:client:sell",
                icon = "fas fa-money-check-alt",
                label = "Sell Vehicle",
                job = "cardealer",
                tablet = 3,
            },
            {
                type = "client",
                event = "lux:client:purchase",
                icon = "fas fa-dollar-sign",
                label = "Purchase Vehicle",
                tablet = 3,
            }
        },
        distance = 3
    }
)
exports["qb-target"]:AddBoxZone("lux2", vector3(-796.21, -209.16, 37.08), 0.4, 1, {
    name="lux2",
    heading=295,
    --debugPoly=true,
    minZ=35.88,
    maxZ=37.48    
    }, {
        options = {
            {
                type = "client",
                event = "lux:client:tablet",
                icon = "fas fa-book-open",
                label = "Catalog",
                job = "cardealer",
                tablet = 2
            },
            {
                type = "client",
                event = "lux:client:sell",
                icon = "fas fa-money-check-alt",
                label = "Sell Vehicle",
                job = "cardealer",
                tablet = 2,
            },
            {
                type = "client",
                event = "lux:client:purchase",
                icon = "fas fa-dollar-sign",
                label = "Purchase Vehicle",
                tablet = 2,
            }
        },
        distance = 3
    }
)
exports["qb-target"]:AddBoxZone("lux3", vector3(-797.58, -206.82, 37.08), 0.4, 1, {
    name="lux3",
    heading=290,
    --debugPoly=true,
    minZ=36.08,
    maxZ=37.48
    }, {
        options = {
            {
                type = "client",
                event = "lux:client:tablet",
                icon = "fas fa-book-open",
                label = "Catalog",
                job = "cardealer",
                tablet = 1
            },
            {
                type = "client",
                event = "lux:client:sell",
                icon = "fas fa-money-check-alt",
                label = "Sell Vehicle",
                job = "cardealer",
                tablet = 1,
            },
            {
                type = "client",
                event = "lux:client:purchase",
                icon = "fas fa-dollar-sign",
                label = "Purchase Vehicle",
                tablet = 1,
            }
        },
        distance = 3
    }
)

RegisterNetEvent('lux:client:tablet')
AddEventHandler('lux:client:tablet', function(data)
    tablet = data.tablet
    --send nh-context menu of categories
    --TriggerEvent("nh-context:sendMenu", CustomVehicleCats)
    exports['qb-menu']:openMenu(CustomVehicleCats)
end)

RegisterNetEvent('lux:client:catalog')
AddEventHandler('lux:client:catalog', function(data)
    --data.category
    --send nh-context menu of vehicles in category
    --TriggerEvent("nh-context:sendMenu", CustomVehicleList[data.category])
    exports['qb-menu']:openMenu(CustomVehicleList[data.brand])
end)

RegisterNetEvent('lux:client:changeveh')
AddEventHandler('lux:client:changeveh', function(data)
    if CustomModelLoaded then
        TriggerServerEvent('qb-vehicleshop:server:SetCustomShowroomVeh', data.vehicle, tablet)
    end
end)

RegisterNetEvent('lux:client:sell')
AddEventHandler('lux:client:sell', function(data)
    --prompt keyboard and ask for player id
    local kb = exports["qb-input"]:ShowInput({
        header = "Customer Info:",
        submitText = "Submit",
        inputs = {
            {
                type = 'text',
                isRequired = true,
                name = 'id',
                text = "Identification Number"
            }
        }
    })
    if kb then
        print(kb.id)
        --add buy option for customer
        TriggerServerEvent('lux:server:allowpurchase', tonumber(kb.id), tablet)
    end
end)

RegisterNetEvent('lux:client:purchase')
AddEventHandler('lux:client:purchase', function(data)
    --data.tablet
    if purchaseable == data.tablet then
        if QBCore.Shared.Vehicles[QBCustom.ShowroomPositions[data.tablet].vehicle] ~= nil then
            --send nh context confirmation
            exports['qb-menu']:openMenu({
                {
                    id = 1,
                    header = "Purchase Vehicle",
                    --name of the car
                    txt = QBCore.Shared.Vehicles[QBCustom.ShowroomPositions[data.tablet].vehicle].brand.." "..QBCore.Shared.Vehicles[QBCustom.ShowroomPositions[data.tablet].vehicle].name
                },
                {
                    id = 2,
                    header = "Cancel",
                    txt = "",
                    params = {
                        event = "lux:client:confirm",
                        args = {
                            confirm = false,
                        }
                    }
                },
                {
                    id = 3,
                    header = "Purchase for $"..QBCore.Shared.Vehicles[QBCustom.ShowroomPositions[data.tablet].vehicle].price,
                    txt = "",
                    params = {
                        event = "lux:client:confirm",
                        args = {
                            confirm = true,
                            veh = data.tablet
                        }
                    }
                },
            })
        end
    end
end)

RegisterNetEvent('lux:client:confirm')
AddEventHandler('lux:client:confirm', function(data)
    if data.confirm then
        TriggerServerEvent('qb-vehicleshop:server:ConfirmVehicle', QBCustom.ShowroomPositions[data.veh], salesperson)
    end
end)

RegisterNetEvent('lux:client:allowpurchase')
AddEventHandler('lux:client:allowpurchase', function(slot, salesp)
    purchaseable = slot
    salesperson = salesp
end)

--[[Citizen.CreateThread(function()
    while true do
        local dist = #(GetEntityCoords(GLOBAL_PED, false) - vector3(-768.15, -233.1, 37.07))

        if isLoggedIn then
            if insideLuxury then
                if (PlayerJob ~= nil) and PlayerJob.name == "cardealer" then
                    if IsPedInAnyVehicle(GLOBAL_PED, false) then
                        if dist < 15 then
                            DrawMarker(2, bringcoords.x, bringcoords.y, bringcoords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.4, 0.3, 0.1, 255, 0, 0, 155, false, false, false, false, false, false, false)

                            if dist < 2 then
                                DrawText3Ds(bringcoords.x, bringcoords.y, bringcoords.z, '~g~E~w~ - Return the vehicle')
                                if IsControlJustPressed(0, Keys["E"]) then
                                    local veh = GetVehiclePedIsIn(GLOBAL_PED)
                                    QBCore.Functions.DeleteVehicle(veh)
                                end
                            end
                        end
                    end
                else
                    Citizen.Wait(2000)
                end
            else
                Citizen.Wait(2000)
            end
        end
        Citizen.Wait(2000)
    end
end)]]

local CustomVehicleCats = {}

--build our lists of categories and vehicles in each cat
Citizen.CreateThread(function()
    Citizen.Wait(3000)
    local i = 0
    --create categories
    for k, v in pairs(QBCore.Shared.Vehicles) do
        if v["shop"] == "luxury" then
            local exists = false
            for _, cat in pairs(CustomVehicleCats) do
                if cat["header"] == v["brand"] then
                    exists = true
                end
            end
            if exists == false then
                i = i + 1
                table.insert(CustomVehicleCats, {
                    id = i,
                    header = v["brand"],
                    txt = "",
                    params = {
                        event = "lux:client:catalog",
                        args = {
                            brand = v["brand"]
                        }
                    }
                })
            end
        end
    end

    --create car list per category
    
    for _, v in pairs(CustomVehicleCats) do
        local x = 1
        CustomVehicleList[v["header"]] = {}
        table.insert(CustomVehicleList[v["header"]], {
            id = x,
            header = "< Go Back",
            txt = "",
            params = {
                event = "lux:client:tablet",
                args = {
                    tablet = tablet
                }
            }
        })
        for a, b in pairs(QBCore.Shared.Vehicles) do
            if b["brand"] == v["header"] then
                x = x+1
                table.insert(CustomVehicleList[v["header"]], {
                    id = x,
                    header = b["brand"]..' '..b["name"],
                    txt = tostring(b["price"]),
                    params = {
                        event = "lux:client:changeveh",
                        args = {
                            vehicle = a
                        }
                    }
                    
                })
            end
        end
    end
end)

Citizen.CreateThread(function()
    Citizen.Wait(1000)
    for i = 1, #QBCustom.ShowroomPositions, 1 do
        local oldVehicle = GetClosestVehicle(QBCustom.ShowroomPositions[i].coords.x, QBCustom.ShowroomPositions[i].coords.y, QBCustom.ShowroomPositions[i].coords.z, 3.0, 0, 70)
        if oldVehicle ~= 0 then
            QBCore.Functions.DeleteVehicle(oldVehicle)
        end

		local model = GetHashKey(QBCustom.ShowroomPositions[i].vehicle)
		RequestModel(model)
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local veh = CreateVehicle(model, QBCustom.ShowroomPositions[i].coords.x, QBCustom.ShowroomPositions[i].coords.y, QBCustom.ShowroomPositions[i].coords.z, false, false)
		SetModelAsNoLongerNeeded(model)
		SetVehicleOnGroundProperly(veh)
		SetEntityInvincible(veh,true)
        SetEntityHeading(veh, QBCustom.ShowroomPositions[i].coords.h)
        SetVehicleDoorsLocked(veh, 3)

		FreezeEntityPosition(veh,true)
		SetVehicleNumberPlateText(veh, i .. "CARSALE")
		SetVehicleOnGroundProperly(veh)
    end
end)


--[[
function SetClosestCustomVehicle()
    local pos = GetEntityCoords(GLOBAL_PED, true)
    local current = nil
    local dist = nil

    for id, veh in pairs(QBCustom.ShowroomPositions) do
        if current ~= nil then
            if(#(pos - vector3(QBCustom.ShowroomPositions[id].coords.x, QBCustom.ShowroomPositions[id].coords.y, QBCustom.ShowroomPositions[id].coords.z)) < dist)then
                current = id
                dist = #(pos - vector3(QBCustom.ShowroomPositions[id].coords.x, QBCustom.ShowroomPositions[id].coords.y, QBCustom.ShowroomPositions[id].coords.z))
            end
        else
            dist = #(pos - vector3(QBCustom.ShowroomPositions[id].coords.x, QBCustom.ShowroomPositions[id].coords.y, QBCustom.ShowroomPositions[id].coords.z))
            current = id
        end
    end
    if current ~= ClosestCustomVehicle then
        ClosestCustomVehicle = current
    end
end

--[[
Citizen.CreateThread(function()
    while true do
        --local pos = GetEntityCoords(GLOBAL_PED, true)
        --local ShopDistance = #(pos - vector3(QBCustom.ShowroomPositions[1].coords.x, QBCustom.ShowroomPositions[1].coords.y, QBCustom.ShowroomPositions[1].coords.z))

        if isLoggedIn then
            if insideLuxury then
                SetClosestCustomVehicle()
            end
        end
        Citizen.Wait(3000)
    end
end)--]]


--[[
Citizen.CreateThread(function()
    while true do
        --local ped = PlayerPedId()
        local pos = GetEntityCoords(GLOBAL_PED, false)
        local dist = GetDistanceBetweenCoords(pos, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.x, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.y, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.z, false)

        if isLoggedIn then
            if dist < 2 then
                if PlayerJob ~= nil then
                    if PlayerJob.name == "cardealer" then
                        DrawText3Ds(QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.x, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.y, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.z + 1.9, '~g~G~w~ - Change vehicle')
                        DrawText3Ds(QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.x, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.y, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.z + 1.75, '~b~/sell [id]~w~ - Sell vehicle ~b~/testdrive~w~ - Try vehicle')
                        
                        if not CustomVehicleShop.opened then
                            if IsControlJustPressed(0, Keys["G"]) then
                                if CustomVehicleShop.opened then
                                    CloseCustomCreator()
                                else
                                    OpenCustomCreator()
                                end
                            end
                        end

                        if CustomVehicleShop.opened then
                            --local ped = PlayerPedId()
                            local menu = CustomVehicleShop.menu[CustomVehicleShop.currentmenu]
                            local y = CustomVehicleShop.menu.y + 0.12
                            buttoncount = tablelength(menu.buttons)
                            local selected = false

                            for i,button in pairs(menu.buttons) do
                                if i >= CustomVehicleShop.menu.from and i <= CustomVehicleShop.menu.to then
                                    if i == CustomVehicleShop.selectedbutton then
                                        selected = true
                                    else
                                        selected = false
                                    end
                                    drawMenuButton(button,CustomVehicleShop.menu.x,y,selected)
                                    if button.price ~= nil then
                                        drawMenuRight("$"..button.price,CustomVehicleShop.menu.x,y,selected)
                                    end
                                    y = y + 0.04
                                    if isCustomValidMenu(CustomVehicleShop.currentmenu) then
                                        if selected then
                                            if IsControlJustPressed(1, 18) then
                                                if CustomModelLoaded then
                                                    TriggerServerEvent('qb-vehicleshop:server:SetCustomShowroomVeh', button.model, ClosestCustomVehicle)
                                                end
                                            end
                                        end
                                    end
                                    if selected and (IsControlJustPressed(1,38) or IsControlJustPressed(1, 18)) then
                                        CustomButtonSelected(button)
                                    end
                                end
                            end
                        end

                        if CustomVehicleShop.opened then
                            if IsControlJustPressed(1,202) then
                                BackCustom()
                            end
                            if IsControlJustReleased(1,202) then
                                backlock = false
                            end
                            if IsControlJustPressed(1,188) then
                                if CustomModelLoaded then
                                    if CustomVehicleShop.selectedbutton > 1 then
                                        CustomVehicleShop.selectedbutton = CustomVehicleShop.selectedbutton -1
                                        if buttoncount > 10 and CustomVehicleShop.selectedbutton < CustomVehicleShop.menu.from then
                                            CustomVehicleShop.menu.from = CustomVehicleShop.menu.from -1
                                            CustomVehicleShop.menu.to = CustomVehicleShop.menu.to - 1
                                        end
                                    end
                                end
                            end
                            if IsControlJustPressed(1,187)then
                                if CustomModelLoaded then
                                    if CustomVehicleShop.selectedbutton < buttoncount then
                                        CustomVehicleShop.selectedbutton = CustomVehicleShop.selectedbutton +1
                                        if buttoncount > 10 and CustomVehicleShop.selectedbutton > CustomVehicleShop.menu.to then
                                            CustomVehicleShop.menu.to = CustomVehicleShop.menu.to + 1
                                            CustomVehicleShop.menu.from = CustomVehicleShop.menu.from + 1
                                        end
                                    end
                                end
                            end
                        end

                        if GetVehiclePedIsTryingToEnter(GLOBAL_PED) ~= nil and GetVehiclePedIsTryingToEnter(GLOBAL_PED) ~= 0 then
                            ClearPedTasksImmediately(GLOBAL_PED)
                        end

                        DisableControlAction(0, Keys["7"], true)
                        DisableControlAction(0, Keys["8"], true)
                    else
                        if ClosestCustomVehicle ~= nil then
                            if QBCustom.ShowroomPositions[ClosestCustomVehicle] ~= nil then
                                if QBCustom.ShowroomPositions[ClosestCustomVehicle].buying then
                                    if QBCore.Shared.Vehicles[QBCustom.ShowroomPositions[ClosestCustomVehicle].vehicle] ~= nil then
                                        DrawText3Ds(QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.x, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.y, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.z + 1.6, '~g~7~w~ - Buy / ~r~8~w~ - Cancel - ~g~($'..QBCore.Shared.Vehicles[QBCustom.ShowroomPositions[ClosestCustomVehicle].vehicle].price..',-)')
                                        
                                        if IsDisabledControlJustPressed(0, Keys["7"]) then
                                            TriggerServerEvent('qb-vehicleshop:server:ConfirmVehicle', QBCustom.ShowroomPositions[ClosestCustomVehicle])
                                            QBCustom.ShowroomPositions[ClosestCustomVehicle].buying = false
                                        end

                                        if IsDisabledControlJustPressed(0, Keys["8"]) then
                                            QBCore.Functions.Notify('You did NOT buy the car!')
                                            QBCustom.ShowroomPositions[ClosestCustomVehicle].buying = false
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            elseif dist > 1.8 then
                if CustomVehicleShop.opened then
                    CloseCustomCreator()
                end
            end
        end

        Citizen.Wait(3)
    end
end)--]]

RegisterNetEvent('qb-vehicleshop:client:SetCustomShowroomVeh')
AddEventHandler('qb-vehicleshop:client:SetCustomShowroomVeh', function(showroomVehicle, k)
    CancelEvent()
    if purchaseable == k then
        purchaseable = 0
        salesperson = nil
    end
    if QBCustom.ShowroomPositions[k].vehicle ~= showroomVehicle then
        QBCore.Functions.DeleteVehicle(GetClosestVehicle(QBCustom.ShowroomPositions[k].coords.x, QBCustom.ShowroomPositions[k].coords.y, QBCustom.ShowroomPositions[k].coords.z, 3.0, 0, 70))
        CustomModelLoaded =  false
        Wait(250)
        local model = GetHashKey(showroomVehicle)
        RequestModel(model)
        while not HasModelLoaded(model) do
            Citizen.Wait(250)
        end
        local veh = CreateVehicle(model, QBCustom.ShowroomPositions[k].coords.x, QBCustom.ShowroomPositions[k].coords.y, QBCustom.ShowroomPositions[k].coords.z, false, false)
        SetModelAsNoLongerNeeded(model)
        SetVehicleOnGroundProperly(veh)
        SetEntityInvincible(veh,true)
        SetEntityHeading(veh, QBCustom.ShowroomPositions[k].coords.h)
        SetVehicleDoorsLocked(veh, 3)

        FreezeEntityPosition(veh, true)
        SetVehicleNumberPlateText(veh, k .. "CARSALE")
        CustomModelLoaded =  true
        QBCustom.ShowroomPositions[k].vehicle = showroomVehicle
    end
end)

RegisterNetEvent('qb-vehicleshop:client:ConfirmVehicle')
AddEventHandler('qb-vehicleshop:client:ConfirmVehicle', function(Showroom, plate)
    QBCore.Functions.SpawnVehicle(Showroom.vehicle, function(veh)
        TaskWarpPedIntoVehicle(GLOBAL_PED, veh, -1)
        exports['ps-fuel']:SetFuel(veh, 100)
        SetVehicleNumberPlateText(veh, plate)
        SetEntityAsMissionEntity(veh, true, true)
        SetEntityHeading(veh, QBCustom.VehicleBuyLocation.h)
        TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
        TriggerServerEvent("qb-customs:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))

        if Showroom.vehicle == "urus" then
            SetVehicleExtra(veh, 1, false)
            SetVehicleExtra(veh, 2, true)
        end

    end, QBCustom.VehicleBuyLocation, false)
end)

RegisterNetEvent('qb-vehicleshop:client:DoTestrit')
AddEventHandler('qb-vehicleshop:client:DoTestrit', function(plate)
    if ClosestCustomVehicle ~= 0 then
        QBCore.Functions.SpawnVehicle(QBCustom.ShowroomPositions[ClosestCustomVehicle].vehicle, function(veh)
            TaskWarpPedIntoVehicle(GLOBAL_PED, veh, -1)
            exports['ps-fuel']:SetFuel(veh, 100)
            SetVehicleNumberPlateText(veh, plate)
            SetEntityAsMissionEntity(veh, true, true)
            SetEntityHeading(veh, QBCustom.VehicleBuyLocation.h)
            TriggerEvent("vehiclekeys:client:SetOwner", GetVehicleNumberPlateText(veh))
            TriggerServerEvent("qb-customs:server:SaveVehicleProps", QBCore.Functions.GetVehicleProperties(veh))
            testritveh = veh

            if QBCustom.ShowroomPositions[ClosestCustomVehicle].vehicle == "urus" then
                SetVehicleExtra(veh, 1, false)
                SetVehicleExtra(veh, 2, true)
            end
        end, QBCustom.VehicleBuyLocation, false)
    end
end)

RegisterNetEvent('qb-vehicleshop:client:SellCustomVehicle')
AddEventHandler('qb-vehicleshop:client:SellCustomVehicle', function(TargetId)
    --local ped = PlayerPedId()
    local pos = GetEntityCoords(GLOBAL_PED)
    local player, distance = GetClosestPlayer()

    if player ~= -1 and distance < 2.5 then
        local VehicleDist = #(pos - vector3(QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.x, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.y, QBCustom.ShowroomPositions[ClosestCustomVehicle].coords.z))

        if VehicleDist < 2.5 then
            TriggerServerEvent('qb-vehicleshop:server:SellCustomVehicle', TargetId, ClosestCustomVehicle)
        else
            QBCore.Functions.Notify("You are not near the vehicle!", "error")
        end
    else
        QBCore.Functions.Notify("No one around!", "error")
    end
end)

function GetClosestPlayer()
    local closestPlayers = QBCore.Functions.GetPlayersFromCoords()
    local closestDistance = -1
    local closestPlayer = -1
    local coords = GetEntityCoords(GLOBAL_PED)

    for i=1, #closestPlayers, 1 do
        if closestPlayers[i] ~= PlayerId() then
            local pos = GetEntityCoords(GetPlayerPed(closestPlayers[i]))
            local distance = GetDistanceBetweenCoords(pos.x, pos.y, pos.z, coords.x, coords.y, coords.z, true)

            if closestDistance == -1 or closestDistance > distance then
                closestPlayer = closestPlayers[i]
                closestDistance = distance
            end
        end
	end

	return closestPlayer, closestDistance
end

RegisterNetEvent('qb-vehicleshop:client:SetVehicleBuying')
AddEventHandler('qb-vehicleshop:client:SetVehicleBuying', function(slot)
    QBCustom.ShowroomPositions[slot].buying = true
    SetTimeout((60 * 1000) * 5, function()
        QBCustom.ShowroomPositions[slot].buying = false
    end)
end)
--[[
function isCustomValidMenu(menu)
    local retval = false
    for k, v in pairs(CustomVehicleShop.menu["vehicles"].buttons) do
        if menu == v.menu then
            retval = true
        end
    end
    return retval
end

function drawMenuButton(button,x,y,selected)
	local menu = CustomVehicleShop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	if selected then
		SetTextColour(0, 0, 0, 255)
	else
		SetTextColour(255, 255, 255, 255)
	end
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(button.name)
	if selected then
		DrawRect(x,y,menu.width,menu.height,255,255,255,255)
	else
		DrawRect(x,y,menu.width,menu.height,0, 0, 0,220)
	end
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function drawMenuInfo(text)
	local menu = CustomVehicleShop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)
	SetTextColour(255, 255, 255, 255)
	SetTextCentre(0)
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawRect(0.675, 0.95,0.65,0.050,0,0,0,250)
	DrawText(0.255, 0.254)
end

function drawMenuRight(txt,x,y,selected)
	local menu = CustomVehicleShop.menu
	SetTextFont(menu.font)
	SetTextProportional(0)
	SetTextScale(0.2, 0.2)
	--SetTextRightJustify(1)
	if selected then
		SetTextColour(0,0,0, 255)
	else
		SetTextColour(255, 255, 255, 255)
		
	end
	SetTextCentre(1)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawText(x + menu.width/2 + 0.025, y - menu.height/3 + 0.0002)

	if selected then
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,255, 255, 255,250)
	else
		DrawRect(x + menu.width/2 + 0.025, y,menu.width / 3,menu.height,0, 0, 0,250) 
	end
end

function drawMenuTitle(txt,x,y)
	local menu = CustomVehicleShop.menu
	SetTextFont(2)
	SetTextProportional(0)
	SetTextScale(0.25, 0.25)

	SetTextColour(255, 255, 255, 255)
	SetTextEntry("STRING")
	AddTextComponentString(txt)
	DrawRect(x,y,menu.width,menu.height,0,0,0,250)
	DrawText(x - menu.width/2 + 0.005, y - menu.height/2 + 0.0028)
end

function tablelength(T)
  local count = 0
  for _ in pairs(T) do count = count + 1 end
  return count
end

function CustomButtonSelected(button)
	--local ped = PlayerPedId()
	local this = CustomVehicleShop.currentmenu
    local btn = button.name
    
	if this == "main" then
		if btn == "Vehicles" then
			OpenCustomMenu('coupes')
		end
	end
end

function OpenCustomMenu(menu)
    CustomVehicleShop.lastmenu = CustomVehicleShop.currentmenu
    fakecar = {model = '', car = nil}
	if menu == "vehicles" then
		CustomVehicleShop.lastmenu = "main"
	end
	CustomVehicleShop.menu.from = 1
	CustomVehicleShop.menu.to = 10
	CustomVehicleShop.selectedbutton = 0
	CustomVehicleShop.currentmenu = menu
end

function BackCustom()
	if backlock then
		return
	end
	backlock = true
	if CustomVehicleShop.currentmenu == "main" then
		CloseCustomCreator()
	elseif isCustomValidMenu(CustomVehicleShop.currentmenu) then
		OpenCustomMenu(CustomVehicleShop.lastmenu)
	else
		OpenCustomMenu(CustomVehicleShop.lastmenu)
	end
end

function CloseCustomCreator(name, veh, price, financed)
	Citizen.CreateThread(function()
		--local ped = PlayerPedId()
		CustomVehicleShop.opened = false
		CustomVehicleShop.menu.from = 1
        CustomVehicleShop.menu.to = 10
	end)
end

function OpenCustomCreator()
	CustomVehicleShop.currentmenu = "main"
	CustomVehicleShop.opened = true
    CustomVehicleShop.selectedbutton = 0
end--]]