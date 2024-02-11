fx_version "cerulean"

description "Fivem Polyzone Creator"
author "NakreS"
version '1.0.0'

lua54 'yes'

games {"gta5", "rdr3"}

ui_page 'web/build/index.html'
client_script "client/**/*"
shared_script "shared/**.lua"

-- polyzone or lib.zone from ox_lib
-- client_scripts {'@PolyZone/client.lua', '@PolyZone/BoxZone.lua', '@PolyZone/ComboZone.lua'}
shared_script '@ox_lib/init.lua'

files {'web/build/index.html', 'web/build/**/*'}
