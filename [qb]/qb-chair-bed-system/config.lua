

Config = {}

Config.Healing = 0 -- // If this is 0, then its disabled.. Default: 3.. That means, if a person lies in a bed, then he will get 1 health every 3 seconds.

Config.objects = {
	ButtonToSitOnChair = 58, -- // Default: G -- // https://docs.fivem.net/game-references/controls/
	ButtonToLayOnBed = 38, -- // Default: E -- // https://docs.fivem.net/game-references/controls/
	ButtonToStandUp = 23, -- // Default: F -- // https://docs.fivem.net/game-references/controls/
	SitAnimation = {anim='PROP_HUMAN_SEAT_CHAIR_MP_PLAYER'},
	BedBackAnimation = {dict='anim@gangops@morgue@table@', anim='ko_front'},
	BedStomachAnimation = {anim='WORLD_HUMAN_SUNBATHE'},
	BedSitAnimation = {anim='WORLD_HUMAN_PICNIC'},
	locations = {
		{object="prop_skid_chair_02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.0, direction=180.0, bed=false},
		--yy
		{object="v_serv_ct_chair02", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.0, direction=168.0, bed=false},
		{object="prop_off_chair_04", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_03", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="prop_off_chair_05", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_club_officechair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_ilev_leath_chr", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="v_corp_offchair", verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.4, direction=168.0, bed=false},
		{object="Prop_Off_Chair_01", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object="prop_cs_office_chair", verticalOffsetX=0.0, verticalOffsetY=-0.1, verticalOffsetZ=-0.5, direction=180.0, bed=false},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.15, direction=180.0, bed=false, hash=538002882}, --use this to add new ones
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.45, direction=180.0, bed=false, hash=-1692811878},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.55, direction=180.0, bed=false, hash=1816935351},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.55, direction=180.0, bed=false, hash=1889748069},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.45, direction=180.0, bed=false, hash=-1198343923},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.15, direction=180.0, bed=false, hash=1580642483},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.15, direction=180.0, bed=false, hash=-1626066319},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.15, direction=180.0, bed=false, hash=-1278649385},
		--{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.70, direction=0.0, bed=false, hash=1850701663}, -- bar stool
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.55, direction=180.0, bed=false, hash=1404176808},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=-0.77, direction=0.0, bed=false, hash=-1120527678},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.15, direction=180.0, bed=false, hash=-109356459},
		{object=nil, verticalOffsetX=0.0, verticalOffsetY=0.0, verticalOffsetZ=0.15, direction=180.0, bed=false, hash=-853526657},
	},
}

Config.Text = {
	SitOnChair = 'Press ~g~G~w~ to sit.',
	SitOnBed = 'Press ~r~E~w~ to sit on the bed.',
	LieOnBed = 'Press ~r~E~w~ to lay on your.',
	SwitchBetween = 'Switch between with ~r~Arrow left~w~ and ~r~Arrow right~w~.',
	Standup = 'Press ~r~F~w~ to stand up.',
}