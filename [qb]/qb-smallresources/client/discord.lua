-- To Set This Up visit https://forum.cfx.re/t/how-to-updated-discord-rich-presence-custom-image/157686

CreateThread(function()
    while true do
        -- This is the Application ID (Replace this with you own)
	SetDiscordAppId(807455758248968222)

        -- Here you will have to put the image name for the "large" icon.
	SetDiscordRichPresenceAsset('5thgate22')
        
        -- (11-11-2018) New Natives:

        -- Here you can add hover text for the "large" icon.
        SetDiscordRichPresenceAssetText('Playing 5th Gate 2.0')
       
        -- Here you will have to put the image name for the "small" icon.
        --SetDiscordRichPresenceAssetSmall('5thgate')

        -- Here you can add hover text for the "small" icon.
        --SetDiscordRichPresenceAssetSmallText('Join 5th Gate today!')

        QBCore.Functions.TriggerCallback('smallresources:server:GetCurrentPlayers', function(result)
            SetRichPresence('Players: '..result..'/128'..' | ')
        end)

        -- (26-02-2021) New Native:

        --[[ 
            Here you can add buttons that will display in your Discord Status,
            First paramater is the button index (0 or 1), second is the title and 
            last is the url (this has to start with "fivem://connect/" or "https://") 
        ]]--
        SetDiscordRichPresenceAction(0, "Discord", "https://discord.gg/5thGate")
        SetDiscordRichPresenceAction(1, "Play", "fivem://connect/mmxbgv")

        -- It updates every minute just in case.
	Wait(60000)
    end
end)
