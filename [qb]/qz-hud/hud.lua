local QBCore = exports['qb-core']:GetCoreObject()
local PlayerData = QBCore.Functions.GetPlayerData()
local stress = 0
local config = Config
local speedMultiplier = config.UseMPH and 2.23694 or 3.6
local seatbeltIsOn = false
local hasPlayerLoaded = true
local speedLevel = 0
local limiter = false

AddEventHandler('QBCore:Client:OnPlayerLoaded', function(player)
    hasPlayerLoaded = true
end)


RegisterNetEvent('hud:client:UpdateNeeds')
AddEventHandler('hud:client:UpdateNeeds', function(newHunger, newThirst)
    hunger = newHunger
    thirst = newThirst
end)

RegisterNetEvent('hud:client:UpdateStress', function(newStress) -- Add this event with adding stress elsewhere
    stress = newStress
end)

function PauseMenuState()
    if hasPlayerLoaded then
        return IsPauseMenuActive()
    end
    return true
end

local function startLimiter()
    Citizen.CreateThread(function()
        local ped = PlayerPedId()
        local veh = GetVehiclePedIsIn(ped)
        local speed = GetEntitySpeed(veh)
        while limiter do
            if GetEntitySpeed(veh) > speed then
                SetVehicleForwardSpeed(veh, speed)
            end
            if not IsPedInAnyVehicle(ped) then
                limiter = false
            end
            Wait(100)
        end
    end)
end

RegisterCommand("togglelimiter", function()
    local ped = PlayerPedId()
    local vehicle = GetVehiclePedIsIn(ped, false)
    local inVehicle = IsPedSittingInAnyVehicle(ped)
            if (inVehicle) then
                if (GetPedInVehicleSeat(vehicle, -1) == ped) then
                    if limiter == false then
                        limiter = true
                        startLimiter()
                        QBCore.Functions.Notify('Speed Limiter: Enabled')
                    else
                        limiter = false
                        QBCore.Functions.Notify('Speed Limiter: Disabled')
                    end
                end
            end
end)

RegisterKeyMapping("togglelimiter", "Toggle Speed Limiter", "keyboard", "Y")

Citizen.CreateThread(function()
    while true do 
        local ped = PlayerPedId()
        local MyPedVeh = GetVehiclePedIsIn(PlayerPedId(),false)
        local isinthewater = IsEntityInWater(ped)
        local isinthewaterswiming = IsPedSwimming(ped)
        local vehicle = GetVehiclePedIsIn(ped)
        local IsPedInAnyVehicle = IsPedInAnyVehicle(ped)
        local fuelLevel  = 0
        local gearLevel  = 0
        local healthCar  = 0
        
        local damage = GetVehicleEngineHealth(vehicle)
        
        if IsPedSittingInAnyVehicle(ped) and not IsPlayerDead(ped) then

            DisplayRadar(true)

        elseif not IsPedSittingInAnyVehicle(ped) then

            DisplayRadar(false)

        end

        if (IsPedInAnyVehicle) then
            fuelLevel = GetVehicleFuelLevel(vehicle)
            gearLevel = GetVehicleCurrentGear(vehicle)
            healthCar = math.ceil(GetVehicleBodyHealth(vehicle) / 10)
            speedLevel = math.ceil(GetEntitySpeed(vehicle) * speedMultiplier)
            --sleepThread = 170
        else
            fuelLevel  = 0
            gearLevel  = 0
            healthCar  = 0
            speedLevel = 0
        end
        
        local retval , lightsOn , highbeamsOn = GetVehicleLightsState(vehicle)

        if lightsOn == 1 and highbeamsOn == 0 then
            vehicleLight = 'normal'
        elseif (lightsOn == 1 and highbeamsOn == 1) or (lightsOn == 0 and highbeamsOn == 1) then
            vehicleLight = 'high'
        else
            vehicleLight = 'off'
        end

        SendNUIMessage({
            pauseMenu = PauseMenuState();
            armour = GetPedArmour(PlayerPedId());
            health = GetEntityHealth(PlayerPedId())-100;
            food = hunger;
            thirst = thirst;
            stress = stress;
            estoyencoche = IsPedSittingInAnyVehicle(ped);
            id = GetPlayerServerId(PlayerId());
            isinthewater = IsEntityInWater(ped);
            isinthewaterswiming = IsPedSwimming(ped);
            oxigenoagua = GetPlayerUnderwaterTimeRemaining(PlayerId())*10;
            oxigeno = 100-GetPlayerSprintStaminaRemaining(PlayerId());

            type = 'carhud:update';
            isInVehicle = IsPedInAnyVehicle;
            speed = speedLevel;
            fuel = fuelLevel;
            gear = gearLevel;
            vidacoche = healthCar;
            luces = lightsOn;
            luceslargas = highbeamsOn;
            locked = GetVehicleDoorLockStatus(vehicle);
            damage = damage;
        })


        RegisterCommand('hidehud',function()    -- Command for hiding the hud
            SendNUIMessage({
                quitarhud = true
            })
        end)

        RegisterCommand('showhud',function()    -- Command for showing the hud
            SendNUIMessage({
                ponerhud = true
            })
        end)

        RegisterCommand('startcinematic',function()  -- Command to make black bars appear on the screen (21:9)
            DisplayHud(false)
            SendNUIMessage({
                ponerbarras = true
            })
        end)

        RegisterCommand('stopcinematic',function()  -- Command to make black bars disappear on the screen (21:9)
            SendNUIMessage({
                quitarbarras = true
            })
        end)

        Citizen.Wait(500)
        
	end
	
end)

---------------------------------ENGINE ON/OFF---------------------------------

---------------------------------ENGINE ON/OFF---------------------------------


---------------------------------STRESS---------------------------------

RegisterNetEvent('hud:client:UpdateStress', function(newStress)
    stress = newStress
end)

CreateThread(function()
    RegisterCommand("clearchat", function()
        TriggerEvent("chat:clear")
    end, false)
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            if IsPedInAnyVehicle(ped, false) then
                local speed = GetEntitySpeed(GetVehiclePedIsIn(ped, false)) * speedMultiplier
                local stressSpeed = seatbeltOn and config.MinimumSpeed or config.MinimumSpeedUnbuckled
                if speed >= stressSpeed then
                    TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                end
            end
        end
        Wait(10000)
    end
end)

local function IsWhitelistedWeaponStress(weapon)
    if weapon then
        for _, v in pairs(config.WhitelistedWeaponStress) do
            if weapon == v then
                return true
            end
        end
    end
    return false
end

CreateThread(function()
    while true do
        if LocalPlayer.state.isLoggedIn then
            local ped = PlayerPedId()
            local weapon = GetSelectedPedWeapon(ped)
            if weapon ~= `WEAPON_UNARMED` then
                if IsPedShooting(ped) and not IsWhitelistedWeaponStress(weapon) then
                    if math.random() < config.StressChance then
                        TriggerServerEvent('hud:server:GainStress', math.random(1, 3))
                    end
                end
            else
                Wait(1000)
            end
        end
        Wait(8)
    end
end)

local function GetBlurIntensity(stresslevel)
    for _, v in pairs(config.Intensity['blur']) do
        if stresslevel >= v.min and stresslevel <= v.max then
            return v.intensity
        end
    end
    return 1500
end

local function GetEffectInterval(stresslevel)
    for _, v in pairs(config.EffectInterval) do
        if stresslevel >= v.min and stresslevel <= v.max then
            return v.timeout
        end
    end
    return 60000
end

CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local effectInterval = GetEffectInterval(stress)
        if stress >= 100 then
            local BlurIntensity = GetBlurIntensity(stress)
            local FallRepeat = math.random(2, 4)
            local RagdollTimeout = FallRepeat * 1750
            TriggerScreenblurFadeIn(1000.0)
            Wait(BlurIntensity)
            TriggerScreenblurFadeOut(1000.0)

            if not IsPedRagdoll(ped) and IsPedOnFoot(ped) and not IsPedSwimming(ped) then
                SetPedToRagdollWithFall(ped, RagdollTimeout, RagdollTimeout, 1, GetEntityForwardVector(ped), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
            end

            Wait(1000)
            for _ = 1, FallRepeat, 1 do
                Wait(750)
                DoScreenFadeOut(200)
                Wait(1000)
                DoScreenFadeIn(200)
                TriggerScreenblurFadeIn(1000.0)
                Wait(BlurIntensity)
                TriggerScreenblurFadeOut(1000.0)
            end
        elseif stress >= config.MinimumStress then
            local BlurIntensity = GetBlurIntensity(stress)
            TriggerScreenblurFadeIn(1000.0)
            Wait(BlurIntensity)
            TriggerScreenblurFadeOut(1000.0)
        end
        Wait(effectInterval)
    end
end)

---------------------------------STRESS---------------------------------

---------------------------------SPEEDOMETER--------------------------------


local seatbeltIsOn = false



function SetSeatBeltActive(e)
    if (e) then
        SendNUIMessage({
            type = 'cinturon:toggle',
            toggle = e.active,
            checkIsVeh = e.checkIsVeh,
        })
    end
end

AddEventHandler("seatbelt:client:ToggleSeatbelt", function(seatbelt)
    seatbeltIsOn = seatbelt
    SetSeatBeltActive({
        active = seatbeltIsOn,
        checkIsVeh = true,
    })
end)

---------------------------------SPEEDOMETER---------------------------------

----------------Speed for Driveby ------------------------------------------
exports('GetSpeed', function()
    return speedLevel
end)

Citizen.CreateThread(function()
	while true do
		Wait(1000)

		local playerPed = PlayerPedId()
		car = GetVehiclePedIsIn(playerPed, false)
		if car then
			if GetPedInVehicleSeat(car, -1) == playerPed then
				SetPlayerCanDoDriveBy(PlayerId(), false)
			elseif GetVehicleClass(car) == 15 and exports['qb-policejob']:IsCopCL() then --helis for pd
				SetPlayerCanDoDriveBy(PlayerId(), true)
			else
                --local speed = exports['qz-hud']:GetSpeed()
                if speedLevel < 30 then
                    SetPlayerCanDoDriveBy(PlayerId(), true)
                else
                    SetPlayerCanDoDriveBy(PlayerId(), false)
                end
			end
		end
	end
end)