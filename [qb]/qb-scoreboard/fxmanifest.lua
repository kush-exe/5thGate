fx_version 'adamant'

game 'gta5'

ui_page "html/ui.html"

client_scripts {
    'client.lua',
	'config.lua',
}

server_scripts {
	'config.lua',
	'server.lua',
}

files {
    "html/*"
}
--client_script '@qb-core/init.lua'
--server_script '@qb-core/init.lua'