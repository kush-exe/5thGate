fx_version 'cerulean'
game 'gta5'

description 'jpr-newphone'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    '@qb-apartments/config.lua',
    '@qb-garages/config.lua',
}

client_scripts {
    'client/main.lua',
    'client/legacy.lua',
    'client/animation.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua',
    'server/legacy.lua',
}

files {
    'html/*.html',
    'html/js/*.js',
    'html/img/*.png',
    'html/css/*.css',
    'html/fonts/*.ttf',
    'html/fonts/*.otf',
    'html/fonts/*.woff',
    'html/img/backgrounds/*.png',
    'html/img/backgrounds/fundosiphone/*.jpg',
    'html/img/backgrounds/*.jpg',
    'html/img/backgrounds/*.png',
    'html/img/apps/*.png',
    'html/img/apps2/*.png',
    'html/img/youtube/*.png',
    'html/img/marcas/*.png',
}

escrow_ignore {
	'config.lua',
}

lua54 'yes'
dependency '/assetpacks'