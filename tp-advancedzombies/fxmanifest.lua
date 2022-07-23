fx_version 'adamant'
game 'gta5'

author 'Nosmakos'
description 'Titans Productions Advanced Zombies System (Supporting ESX & QBCore)'
version '1.0.0'

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