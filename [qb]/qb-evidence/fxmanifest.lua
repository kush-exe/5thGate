fx_version 'cerulean'
game 'gta5'

description 'r14-evidence'
version '1.1.0'

shared_scripts {
    'config.lua',
}

ui_page 'html/index.html'

client_scripts {
	'config.lua',
	'client/*.lua',
}

server_scripts {	
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

files {
	'html/index.html',
	'html/main.js',
}

lua54 'yes'