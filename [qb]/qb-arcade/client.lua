local QBCore = exports['qb-core']:GetCoreObject()
local gotTicket = false
local minutes = 0
local seconds = 0

local arcadeMachines = {
    -1991361770, -- qubed
    -2133758469, -- badlands revenge
    1876055757, --space monkey
    -1502319666, --invade and persuade
    815879628, --wizards ruin
    -1501557515, --penetrator
    1301167921, --monkeys paradise
    -538006270, --defender of faith
}

exports["qb-target"]:AddTargetModel(arcadeMachines, {
    options = {
        {
            event = "arcade:client:openArcadeGames",
            icon = "fas fa-gamepad",
            label = "Play Arcade Game"
        },
    },
    distance = 2
})

--=====================================  EVENTS
RegisterNetEvent("arcade:client:openTicketMenu")
AddEventHandler("arcade:client:openTicketMenu", function()
    if gotTicket == false then
        playerBuyTicketMenu()
    else
        returnTicketMenu()
    end
end)

RegisterNetEvent("arcade:client:openArcadeGames")
AddEventHandler("arcade:client:openArcadeGames", function()
    openComputerMenu()
end)


RegisterNUICallback('exit', function()
    SendNUIMessage({
        type = "off",
        game = "",
    })
    SetNuiFocus(false, false)
end)


RegisterNetEvent('rcore_arcade:client:playArcade')
AddEventHandler('rcore_arcade:client:playArcade', function(args)
    local args = tonumber(args)
    if args == 1 then 
        SendNUIMessage({
            type = "on",
            game = 'http://xogos.robinko.eu/PACMAN/',
            gpu = Config.GPUList[2],
            cpu =  Config.CPUList[1],
            SetNuiFocus(true, true)
        })
        elseif args == 2  then
            SendNUIMessage({
                type = "on",
                game = 'http://xogos.robinko.eu/TETRIS/',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 3 then
            SendNUIMessage({
                type = "on",
                game = 'http://xogos.robinko.eu/PONG/',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 4 then
            SendNUIMessage({
                type = "on",
                game = 'http://lama.robinko.eu/fullscreen.html',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 5 then
            SendNUIMessage({
                type = "on",
                game = 'http://uno.robinko.eu/fullscreen.html',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 6 then
            SendNUIMessage({
                type = "on",
                game = 'http://ants.robinko.eu/fullscreen.html',
                gpu = Config.GPUList[2], 
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 7 then
            SendNUIMessage({
                type = "on",
                game = 'http://xogos.robinko.eu/FlappyParrot/',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 8 then
            SendNUIMessage({
                type = "on",
                game = 'http://zoopaloola.robinko.eu/Embed/fullscreen.html',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 9 then  
            SendNUIMessage({
                type = "on",
                game = 'https://gulper.io',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 11 then  
            SendNUIMessage({
                type = "on",
                game = 'https://sigmally.com/',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        elseif args == 12 then  
            SendNUIMessage({
                type = "on",
                game = 'https://www.pramuwaskito.org/game/mario/',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
        else  
            SendNUIMessage({
                type = "on",
                game = 'https://www.google.com/logos/fnbx/solitaire/standalone.html',
                gpu = Config.GPUList[2],
                cpu =  Config.CPUList[1],
                SetNuiFocus(true, true)
            })
    end
end) 


--===================================== Context Menu

function openComputerMenu()
    exports["qb-menu"]:openMenu({
        {
            
            header = "Arcade Game Selection",
            txt = "",
            isMenuHeader = true,
        },
        {
            
            header = "Play Pacman",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '1'
            }
        },
        {
           
            header = "Play Tetris",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '2'
            }
        },
        {
            
            header = "Play PingPong",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '3'
            }
        },
        {
           
            header = "Play Slide a Lama",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '4'
            }
        },
        {
           
            header = "Play Uno",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '5'
            }
        },
        {
           
            header = "Play Ants",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '6'
            }
        },
        {
            
            header = "Play FlappyParrot",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '7'
            }
        },
        {
            
            header = "Play Zoopaloola",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '8'
            }
        },
        {
            
            header = "Play Gulper.io (NEW)",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '9'
            }
        },
        {
           
            header = "Play Solitaire (NEW)",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '10'
            }
        },
        {
           
            header = "Play Agar.io (NEW)",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '11'
            }
        },
        {
           
            header = "Play Super Mario (NEW)",
			txt = "",
			params = {
                event = "rcore_arcade:client:playArcade",
                args = '12'
            }
        },
        {
            
            header = "Cancel",
			txt = "",
			params = {
                event = ""
            }
        },
    })
end
