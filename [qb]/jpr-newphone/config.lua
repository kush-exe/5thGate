Config = Config or {}
Config.BillingCommissions = { -- This is a percentage (0.10) == 10%
    mechanic = 0.10
}
Config.Linux = true -- True if linux
Config.VoiceScript = "pma"  -- pma, mumble, salty, tokovoip
Config.WebHook = "https://discord.com/api/webhooks/958453427258683412/AimBKpK6c2KsbJSHi43Nwuz_mM0Pwxcupw2yeLiokYCSq-ZYGe1t9k0vKCDMHnAgCw4S"  -- photos
Config.TweetDuration = 48 -- How many hours to load tweets 
Config.OLXDuration = 72 -- How many hours to load olx 
Config.RepeatTimeout = 4000 --- Depends of ringtone
Config.CallRepeats = 10 --- Depends of ringtone
Config.OpenPhone = 244 ---- to open phone
Config.PhoneApplications = {
    ["phone"] = { 
        app = "phone", --- app name
        color = "transparent", ---- leave this transparent
        icon = "phone.png", --- app icon
        tooltipText = "Phone", --- app name
        tooltipPos = "top", --- leave top
        job = false, --- if job locked
        blockedjobs = {}, --- what jobs?
        slot = 1, --- default slot
        Alerts = 0,
    },
    ["whatsapp"] = {
        app = "whatsapp",
        color = "transparent",
        icon = "whatsapp.png",
        tooltipText = "Whatsapp",
        tooltipPos = "top",
        style = "font-size: 2.8vh";
        job = false,
        blockedjobs = {},
        slot = 2,
        Alerts = 0,
    },
    ["settings"] = {
        app = "settings",
        color = "transparent",
        icon = "settings.png",
        tooltipText = "Settings",
        tooltipPos = "top",
        style = "padding-right: .08vh; font-size: 2.3vh";
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
    },
    
    ["lawyers"] = {
        app = "lawyers",
        color = "transparent",
        icon = "contacts.png",
        tooltipText = "Services",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
    },
    ["gallery"] = {
        app = "gallery",
        color = "transparent",
        icon = "photos.png",
        tooltipText = "Gallery",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
    },
    ["camera"] = {
        app = "camera",
        color = "transparent",
        icon = "camera.png",
        tooltipText = "Camera",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
    },
    
    ["store"] = {
        app = "store",
        color = "transparent",
        icon = "appstore.png",
        tooltipText = "AppStore",
        tooltipPos = "bottom",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
    }, 
}
Config.MaxSlots = 20

Config.StoreApps = {
    ["twitter"] = {
        app = "twitter", --- app name
        color = "transparent", --- leave always transparent
        icon = "twitter.png", --- app icon
        tooltipText = "Twitter", --- app name
        tooltipPos = "top", --- leave top
        job = false, --- job locked
        blockedjobs = {}, --- what jobs?
        slot = 2, ---- store apps dont need to change slots because they change automatically
        Alerts = 0, 
        creator = "Twitter, Inc.", --- app creator "appstore"
        title = "Twitter", --- app name "appstore"
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>' --- app rating "appstore"
    },
    ["garage"] = {
        app = "garage",
        color = "transparent",
        icon = "garagem.png",
        tooltipText = "Garage",
        job = false,
        blockedjobs = {},
        slot = 3,
        Alerts = 0,
        creator = "Via Verde, Inc.",
        title = "Garage",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>'
    },
    ["mail"] = {
        app = "mail",
        color = "transparent",
        icon = "mail.png",
        tooltipText = "W-Mail",
        job = false,
        blockedjobs = {},
        slot = 4,
        Alerts = 0,
        creator = "Microsoft Corporation",
        title = "Mail",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>'
    },
    ["advert"] = {
        app = "advert",
        color = "transparent",
        icon = "olx.png",
        tooltipText = "OLX",
        job = false,
        blockedjobs = {},
        slot = 5,
        Alerts = 0,
        creator = "OLX Portugal SA",
        title = "OLX",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>'
    },
    ["bank"] = {
        app = "bank",
        color = "transparent",
        icon = "wallet.png", 
        tooltipText = "WBank",
        job = false,
        blockedjobs = {},
        slot = 6,
        Alerts = 0,
        creator = "Fleeca Bank",
        title = "Fleeca",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>'
    },
    ["crypto"] = {
        app = "crypto",
        color = "transparent",
        icon = "stocks.png",
        tooltipText = "Crypto",
        job = false,
        blockedjobs = {},
        slot = 7,
        Alerts = 0,
        creator = "Satoshi Nakamoto",
        title = "Crypto",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>'
    },
    ["racing"] = {
        app = "racing",
        color = "transparent",
        icon = "corrida.png",
        tooltipText = "Racing",
        job = false,
        blockedjobs = {},
        slot = 8,
        Alerts = 0,
        creator = "Lambra, LDA",
        title = "Racing",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>'
    },
    ["houses"] = {
        app = "houses",
        color = "transparent",
        icon = "home.png",
        tooltipText = "Houses",
        job = false,
        blockedjobs = {},
        slot = 9,
        Alerts = 0,
        creator = "Nino imóveis, LDA",
        title = "Houses",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>'
    },
    ["meos"] = {
        app = "meos",
        color = "transparent",
        icon = "meos.png",
        tooltipText = "MDT",
        job = "police",
        blockedjobs = {},
        slot = 10,
        Alerts = 0,
        creator = "LSPD",
        title = "MDT",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>'
    },
    ["youtube"] = {
        app = "youtube",
        color = "transparent",
        icon = "youtube.png",
        tooltipText = "Youtube",
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
        creator = "Google LLC",
        title = "Youtube",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>'
    }, 

    ["jogos"] = {
        app = "jogos",
        color = "transparent",
        icon = "playjogos.png",
        tooltipText = "Games",
        blockedjobs = {},
        slot = 11,
        Alerts = 0,
        creator = "Google LLC",
        title = "Games",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star-half-stroke"></i>'
    },

    ["calculator"] = {
        app = "calculator",
        color = "transparent",
        icon = "calculator.png",
        tooltipText = "Calculator",
        blockedjobs = {},
        slot = 12,
        Alerts = 0,
        creator = "IOS",
        title = "Calculator",
        avaliacao = '<i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i><i class="fa-solid fa-star"></i>'
    },

}