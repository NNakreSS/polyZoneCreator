fx_version "cerulean"

description "Fivem Polyzone Creator"
author "NakreS"
version '1.0.0'

lua54 'yes'

games {"gta5", "rdr3"}

ui_page 'web/build/index.html'
client_scripts {"client/**/*", '@PolyZone/client.lua', '@PolyZone/BoxZone.lua', '@PolyZone/ComboZone.lua'}
shared_script "shared/**.lua"

files {'web/build/index.html', 'web/build/**/*'}
