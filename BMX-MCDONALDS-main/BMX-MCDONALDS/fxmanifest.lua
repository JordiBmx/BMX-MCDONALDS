fx_version 'cerulean'
game 'gta5'

version '1.0.0'

ui_page 'html/index.html'

client_scripts {
    'config.lua',
    'client/*.lua',
}

server_scripts {
    'server/main.lua',
}

files {
    'html/*.html',
    'html/css/*.css',
    'html/js/*.js',
}
