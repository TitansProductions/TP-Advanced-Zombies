fx_version 'adamant'
game 'gta5'

author 'Nosmakos'
description 'Titans Productions Advanced Zombies System (Supporting ESX & QBCore)'
version '1.7.0'

ui_page 'html/index.html'

shared_scripts {
    'config.lua',
    'locales.lua'
}

server_scripts {
    "@mysql-async/lib/MySQL.lua",
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

files {
    'html/index.html',

    'html/css/*.css',

    'html/js/locales/*.js',
    'html/js/*.js',

    'html/img/*.jpg',
    'html/img/*.png',

    'html/sounds/*.ogg',
    'html/sounds/*.mp3'
}
