fx_version 'cerulean'
game 'gta5'

ui_page 'ui/dist/index.html'  

client_scripts {
    'config.lua',
    'client/main.lua',
    'client/cl_testing.lua'
}

files {
    'ui/dist/index.html',     -- Changed from 'web/dist/index.html'
    'ui/dist/assets/*'        -- Changed from 'web/dist/assets/*'
}