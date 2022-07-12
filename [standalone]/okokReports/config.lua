Config = {}

-------------------------- COMMANDS & FUNCTIONALITY

Config.FeedbackClientCommand = 'report' -- The command that the players use to report something

Config.FeedbackAdminCommand = 'reports' -- The command that the admins use to check the pendent feedbacks list

Config.FeedbackCooldown = 10 -- Time in minutes

-------------------------- ADMIN PERMISSIONS

Config.ESX = false -- Set this to true if you use ESX 

-- If you use ESX you don't need to add any identifier to Config.AdminList because it checks if you have permission by your player group (superadmin, admin, mod)

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.AdminList = {
	'discord:972684911326658622', -- Example, change this
	'discord:931764546606071808', -- Example, change this
	'discord:560572592151592961',
	'discord:705300308640923659',
	'discord:440387476645740555', -- luis
	'discord:254857188210638848', --benji
	'discord:502683646109417484',


}

-------------------------- DISCORD LOGS

-- To set your Discord Webhook URL go to server.lua, line 13

Config.BotName = '5th Gate' -- Write the desired bot name

Config.ServerName = '5th Gate' -- Write your server's name

Config.IconURL = '' -- Insert your desired image link

Config.DateFormat = '%d/%m/%Y [%X]' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.NewFeedbackWebhookColor = '65352'

Config.AssistFeedbackWebhookColor = '16127'

Config.ConcludeFeedbackWebhookColor = '16711680'

-- ok? okok