webhook = "https://discord.com/api/webhooks/994389840009371799/d5G9ruBt9yFgdA23fL_SxU6tKsdWYahYy73jLU0fpdWyjcpsYVResLk0SLXMPMph4lKq"
RegisterNetEvent('vehicledebug:senddata', function(vehicle, val)
    local information = {
		{
			["color"] = '16127',
			["description"] = val,
			["footer"] = {
				["text"] = vehicle,
			}
		}
	}
	PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({username = "Vehicle Debug", embeds = information}), {['Content-Type'] = 'application/json'})
end)