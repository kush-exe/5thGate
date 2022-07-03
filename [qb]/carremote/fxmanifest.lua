fx_version 'adamant'

game 'gta5'

description 'Car Remote'

version '1.0.0'

client_scripts {
    "config.lua",
    "client/main.lua"
}

server_scripts {
    "config.lua",
    "server/main.lua"
}


ui_page 'html/ui.html'

files {
    'html/ui.html',
    'html/css/ui.css',
    'html/scripts/ui.js',
    'html/scripts/sounds.js',
    'html/images/keyfob_viper.png',
    'html/sounds/lock-inside.ogg',
	'html/sounds/lock-outside.ogg',
    'html/sounds/unlock-inside.ogg',
    'html/sounds/unlock-outside.ogg', 
    'html/sounds/unlock-police.ogg',
    'html/sounds/beep.ogg',
    'html/sounds/chime.ogg'
}


