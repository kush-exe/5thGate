Config = {
      MenuHead = 'Dpemotes',
      -- Change the language of the menu here!.
      -- Note fr and de are google translated, if you would like to help out with translation / just fix it for your server check below and change translations yourself
      -- try en, fr, de or sv.
	MenuLanguage = 'en',	
      -- Set this to true to enable some extra prints
	DebugDisplay = false,
      -- Set this to false if you have something else on X, and then just use /e c to cancel emotes.
	EnableXtoCancel = true,
      -- Set this to true if you want to disarm the player when they play an emote.
	DisarmPlayer= false,
      -- Set this if you really wanna disable emotes in cars, as of 1.7.2 they only play the upper body part if in vehicle
    AllowedInCars = true,
      -- You can disable the (F3) menu here / change the keybind.
	MenuKeybindEnabled = true,
	MenuKeybind = 'F3', -- Get the button name here https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
      -- You can disable the Favorite emote KeyBinding here.
	FavKeybindEnabled = false,
	FavKeybind = 'NUMPAD4', -- Get the button name here https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
      -- You can change the header image for the f9 menu here
      -- Use a 512 x 128 image!
      -- NOte this might cause an issue of the image getting stuck on peoples screens
	CustomMenuEnabled = false,
	MenuImage = "https://i.imgyukle.com/2020/03/08/nwO7fe.png",
      -- You can change the menu position here
	MenuPosition = "right", -- (left, right)
      -- You can disable the Ragdoll KeyBinding here.
	RagdollEnabled = false,
	RagdollKeybind = '', -- Get the button number here https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/keyboard/
      -- You can disable the Facial Expressions menu here.
	ExpressionsEnabled = true,
      -- You can disable the Walking Styles menu here.
	WalkingStylesEnabled = true,	
      -- You can disable the Shared Emotes here.
      SharedEmotesEnabled = true,
      CheckForUpdates = false,
      -- Keybinds
      KeyBinding = false,
}


Config.OpenKey = 'F3' -- Change this

Config.Languages = {
      ['en'] = {
            ['emotes'] = 'Emotes',
            ['danceemotes'] = "🌟 Emotes",
            ['propemotes'] = "📦 Prop Emotes",
            ['favoriteemotes'] = "🌟 Favorite",
            ['favoriteinfo'] = "Select an emote here to set it as your favorite.",
            ['rfavorite'] = "Reset favorite",
            ['prop2info'] = "❓ Prop Emotes can be located at the end",
            ['set'] = "Set (",
            ['setboundemote'] = ") to be your bound emote?",
            ['newsetemote'] = "~w~ is now your bound emote, press ~g~CapsLock~w~ to use it.",
            ['cancelemote'] = "Cancel Emote",
            ['cancelemoteinfo'] = "~r~X~w~ Cancels the currently playing emote",
            ['walkingstyles'] = "Walking Styles",
            ['resetdef'] = "Reset to default",
            ['normalreset'] = "Normal (Reset)",
            ['moods'] = "Moods",
            ['infoupdate'] = "Information",
            ['infoupdateav'] = "Information (Update available)",
            ['infoupdateavtext'] = "An update is available, get the latest version from ~y~https://github.com/andristum/dpemotes~w~",
            ['suggestions'] = "Suggestions?",
            ['suggestionsinfo'] = "Shout out to the Los Santos Roleplay Developer`",
            ['notvaliddance'] = "is not a valid dance.",
            ['notvalidemote'] = "is not a valid emote.",
            ['nocancel'] = "No emote to cancel.",
            ['maleonly'] = "This emote is male only, sorry!",
            ['emotemenucmd'] = "Do /emotemenu for a menu.",
            ['shareemotes'] = "👫 Shared Emotes",
            ['shareemotesinfo'] = "Invite a nearby person to emote",
            ['sharedanceemotes'] = "🕺 Shared Dances",
            ['notvalidsharedemote'] = "is not a valid shared emote.",
            ['sentrequestto'] = "Sent request to ~y~",
            ['nobodyclose'] = "Nobody ~r~close~w~ enough.",
            ['doyouwanna'] = "~y~Y~w~ to accept, ~r~L~w~ to refuse (~g~",
            ['refuseemote'] = "Emote refused.",
            ['makenearby'] = "makes the nearby player play",
            ['camera'] = "Press ~y~G~w~ to use camera flash.",
            ['makeitrain'] = "Press ~y~G~w~ to make it rain.",
            ['pee'] = "Hold ~y~G~w~ to pee.",
            ['spraychamp'] = "Hold ~y~G~w~ to spray champagne",
            ['bound'] = "Bound ",
            ['to'] = "to",
            ['currentlyboundemotes'] = " Currently bound emotes:",
            ['notvalidkey'] = "is not a valid key.",
            ['keybinds'] = "🔢 Keybinds",
            ['keybindsinfo'] = "Use"
      },
  }
