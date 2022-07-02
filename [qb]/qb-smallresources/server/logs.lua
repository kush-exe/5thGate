local QBCore = exports['qb-core']:GetCoreObject()

local Webhooks = {
    ['default'] = 'https://discord.com/api/webhooks/992520206905782312/TwFsoMCvre1VBmgw6poV3_ISzFIDGknqv50qEoAt9FmELK67aKKxMfM48S9vB_5TVhI8',
    ['testwebhook'] = '',
    ['playermoney'] = 'https://discord.com/api/webhooks/992520271359639592/8uAV5Mlxb9Xu6ift7Jhz5qi6nTGUgsbHqrW9NMKXy3lhHdAcYnHfV0AILeeLTvPVjea7',
    ['playerinventory'] = 'https://discord.com/api/webhooks/992520402314207233/VQTal3nGxqCl4cNVGJ5CJU3ikLHqbMX9DZkNQxJm_if_RWhuDC7RW9wVxLHjnUK20-VH',
    ['robbing'] = 'https://discord.com/api/webhooks/992520482081484992/JHRl5pqWl58--j_g46_8LbrpvyqGisKXEROlZdE1nfpeCAyTTZgt6wj3r1gGZnaw1mAT',
    ['cuffing'] = 'https://discord.com/api/webhooks/992520551790813255/4DI-l-anHVQodGLkUn3XTRZT5V4Cb6MNU-AMYo_u9r_CUxWX_AUu9QpiTUghLmiLx6As',
    ['drop'] = 'https://discord.com/api/webhooks/992520600927096962/Og2jjA-2IbT40cRkYdt5QlyS3HlgmTP6nhyFNYDk-jjvaRbXAo1raH8Bvl23M9CAJC91',
    ['trunk'] = 'https://discord.com/api/webhooks/992520666073010187/ZXAebs-dP5ybXHKW0Vhna8FmUCKjXrc8_9zkyoOu1mmYIG1h-VcoXM5Mpvsqfax6BvNz',
    ['stash'] = 'https://discord.com/api/webhooks/992520729847402526/V11q9itglGZ2u_XL9vlPEtXLFPglDp-k68PNue8L-Stp2cJuzvgZH4zG-BuKN2BI0J0x',
    ['glovebox'] = 'https://discord.com/api/webhooks/992520797321179277/u5eVKpI6sJwScFt9xFfWIW7bEl1l-epKc3kNOr0WYvQiN_W3Qok6z0aUS8rrZQPWv4oC',
    ['banking'] = 'https://discord.com/api/webhooks/992520859111657602/g7GRik6xWI4wSKI0K4q93bUu6k91JtMl8rJLN26URs-LRjOWjHEXBCOWZgmaPwp-V_QC',
    ['vehicleshop'] = 'https://discord.com/api/webhooks/992520926103080980/FekUr3V4Wpk0n0Rxdgjk4DTyJihZ_tzpDl4ijXYES65iu7WT1k0R-CnOW2BISrA_9twA',
    ['vehicleupgrades'] = 'https://discord.com/api/webhooks/992521004532367413/0KimdOd1WVOZLx5wamLzOQU8euK0wx70QMA_VViNGiWB5UbSUGUzxZ8jHMys_CZqL1eG',
    ['shops'] = 'https://discord.com/api/webhooks/992521083993456670/QbwjQDef_iRQqclK69_uR9tvpFan-vLYWjQP67Id6Ux9N36RGArkugJlftNbcp2g66vX',
    ['dealers'] = 'https://discord.com/api/webhooks/992521137928028241/syORWiSBuaCB23hT2HS1pwH82r5SAtQQATgjS13zt6N6I_wn7iX3vwxLqT9EQC_K5V9Z',
    ['storerobbery'] = 'https://discord.com/api/webhooks/992521183683686510/GOQH953ASC6eliQ7TPysPBrXanN7x0-AerZBHDGqeRNSyTc2_RM0kZVdy-Z34z1JCChH',
    ['bankrobbery'] = 'https://discord.com/api/webhooks/992521239224655953/ZP4AaWq3qGH9ElgiRUtAVIBWJrZpF0ydTWxXTu01FST46lsPgZaB2-Uv6nX4Mw2CClSg',
    ['powerplants'] = 'https://discord.com/api/webhooks/992521291787669538/VWXXukNArF4go1uju7q6feKm9l5VbViQxI58cVcHe1NMEdMwNXGIlhvmYftIV-A5Zdtv',
    ['death'] = 'https://discord.com/api/webhooks/992521339527233706/AKcjDQK9Av-CHQqCyPkMbQeGDS7IAmVFksNj_H3d1cokDFTnfDjk8lQST1w3a-KgjS7O',
    ['joinleave'] = 'https://discord.com/api/webhooks/992521406711607356/YAW8gueIpEKbJxB-8MZNFy7sSC18u2AddlTUnnCDUnb4v9R1TTdtTHg5Xp5LvbNlkkpw',
    ['ooc'] = 'https://discord.com/api/webhooks/992521464572039178/JY0SkG-MtPn6godQ-pPC2qj-5O8HwcWsgrnGreyMPVeFOqP3vQ6qSxsXQ2MYDguny6rr',
    ['report'] = 'https://discord.com/api/webhooks/992521575079346256/3K_4HuJjYj0dv2XzAxM3R5ppmPp5cbGFKwJc52ChMCTRmEFl8Q9GocBbZFj6gRSdl50d',
    ['me'] = 'https://discord.com/api/webhooks/992521668855595149/-USARuBSzhNUoCdq8E6HA7eVf00s8950CWcK9ccMvrFEMSC057W5pQbyrGFUaSVTF4cN',
    ['pmelding'] = 'https://discord.com/api/webhooks/992521720630091876/3TIfpHRL33k7uR1MZKlviRucr64dFwBvT3EOxu9NTlOf-y8BnvWWnrrZjKXGemSazxzl',
    ['112'] = 'https://discord.com/api/webhooks/992521769695055872/9Sz7rAoffjdXCzLThbuj_-s-gkLOxT9dygQZW76Dz_uyO1ZE979YC9lbgaa_kO97K1Pf',
    ['bans'] = 'https://discord.com/api/webhooks/992521813194190908/7coftAkivJIHj8BOFr5GzKikw8WjTgo4tDbg_W0EuvTM9QuAVuJ_zMS6apHVur2I-h7P',
    ['anticheat'] = 'https://discord.com/api/webhooks/992521965636173926/NPUwfeqKYYM23hfEXl8cPsIEc_7KNgqyN6Qe_nSSOwnKvBiyPzVo1ATWAy6adV82F0R6',
    ['weather'] = 'https://discord.com/api/webhooks/992522010875920504/aMNf-wtRGOjJh3cpv6wrl0DSkBcHs79s5zcl5QULD0M0KqtBOEXeJQUw-Y9D7yos3Q3k',
    ['moneysafes'] = 'https://discord.com/api/webhooks/992522082984398928/PeI84f7UHxT02j1PpbtCIcWTXam8uJB58VABcsKXIaLaecjZ5ESrpyGGLl9NGrpLqZ9t',
    ['bennys'] = 'https://discord.com/api/webhooks/992522147203391512/smCU40xYaImDNfgSZ8dXqH6kaQVJl-1yWdgL6oiISxhTbXZrBWImtnivpjwiYeTE5rIo',
    ['bossmenu'] = 'https://discord.com/api/webhooks/992522199636389989/FdWzOFy1IBX-mxDyXxAu0etoHzINm5be_1YDNkR-rs7rOW4-U7gJ508hqZnawNfblHo6',
    ['robbery'] = 'https://discord.com/api/webhooks/992522328531554405/iZoqXm_DyIc-qwezjAq0d518qGATOAzYrdnnlv4QsXS0X3PIV3VZkB_eSVL4bIlWNDeT',
    ['casino'] = '',
    ['traphouse'] = 'https://discord.com/api/webhooks/992522433682755685/LfuuM8CkDmiBDzYwF_iABjfQwO28u09eJ9yJrSCMSLazeLBCmhlAWIL7wlOp7C15gPNU',
    ['911'] = 'https://discord.com/api/webhooks/992522514062376970/zWzLOrGsthDwdb8-wstCFBM_MIpkvDqhHe7ugaiJSVBxgp5d2ny9nHcTU19oq6yaT7ii',
    ['palert'] = '',
    ['house'] = 'https://discord.com/api/webhooks/992522605825380372/MEU8kVoXh80w3Sqidm64DuJNGPxzXBgy60c9sO9w-mfqJTYrsgFCU3xun_mGMJMeGTpI',
}

local Colors = { -- https://www.spycolor.com/
    ['default'] = 14423100,
    ['blue'] = 255,
    ['red'] = 16711680,
    ['green'] = 65280,
    ['white'] = 16777215,
    ['black'] = 0,
    ['orange'] = 16744192,
    ['yellow'] = 16776960,
    ['pink'] = 16761035,
    ["lightgreen"] = 65309,
}

RegisterNetEvent('qb-log:server:CreateLog', function(name, title, color, message, tagEveryone)
    local tag = tagEveryone or false
    local webHook = Webhooks[name] or Webhooks['default']
    local embedData = {
        {
            ['title'] = title,
            ['color'] = Colors[color] or Colors['default'],
            ['footer'] = {
                ['text'] = os.date('%c'),
            },
            ['description'] = message,
            ['author'] = {
                ['name'] = 'QBCore Logs',
                ['icon_url'] = 'https://media.discordapp.net/attachments/870094209783308299/870104331142189126/Logo_-_Display_Picture_-_Stylized_-_Red.png?width=670&height=670',
            },
        }
    }
    PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', embeds = embedData}), { ['Content-Type'] = 'application/json' })
    Citizen.Wait(100)
    if tag then
        PerformHttpRequest(webHook, function() end, 'POST', json.encode({ username = 'QB Logs', content = '@everyone'}), { ['Content-Type'] = 'application/json' })
    end
end)

QBCore.Commands.Add('testwebhook', 'Test Your Discord Webhook For Logs (God Only)', {}, false, function()
    TriggerEvent('qb-log:server:CreateLog', 'testwebhook', 'Test Webhook', 'default', 'Webhook setup successfully')
end, 'god')
