resource_manifest_version '44febabe-d386-4d18-afbe-5e627f4af937'

shared_script "@mg-scripts1/cl_errorlog.lua"


client_script 'sc_c.lua'
server_script 'sc_s.lua'

files {
	"sc_index.html",
	"sc_js.js"
}

ui_page {
	'sc_index.html',
}

client_script '@qb-core/init.lua'
server_script '@qb-core/init.lua'