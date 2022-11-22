fx_version 'cerulean'
game 'gta5'
lua54 'yes'
use_experimental_fxv2_oal 'yes'

author "DokaDoka"
description "DokaDoka's Coord Grabber"
version "0.3.0"

shared_scripts {
	'@ox_lib/init.lua',
}

server_scripts {
	'server.lua',
}

client_scripts {
	'client.lua',
}
