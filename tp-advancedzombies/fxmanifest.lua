fx_version 'adamant'
game 'gta5'

author 'Nosmakos'
description 'Titans Productions Advanced Zombies System (Supporting ESX, QBCore & Standalone)'
version '1.6.1'

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
    'html/js/script.js',
    'html/sounds/*.ogg',
    'html/sounds/*.mp3'
}
