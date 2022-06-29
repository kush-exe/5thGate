Config = Config or {}

Config.model_loading = {
     timeout = 1500, --ms
     dealy = 50 --ms
}

Config.categories = {
     ["misc"] = {
          key = "misc",
          label = "Misc",
          icon = "fa-solid fa-tags",
          jobs = {}
     },
     ["weapons"] = {
          key = "weapons",
          label = "Weapons",
          icon = "fa-solid fa-gun",
          jobs = {},
          sub_categories = {
               ["melee"] = {
                    label = "Melee"
               },
               ["pistol"] = {
                    label = "Pistol"
               },
               ["smg"] = {
                    label = "SMG"
               },
               ["shotgun"] = {
                    label = "Shotgun"
               },
               ["rifle"] = {
                    label = "Rifles"
               }
          }
     },
     ["medical"] = {
          key = "medical",
          label = "Medical",
          icon = "fa-solid fa-hand-holding-medical",
          jobs = {}
     },
     ["attachments"] = {
          key = "attachments",
          label = "attachments",
          icon = "fa-solid fa-gun",
          jobs = {}
     }
}

Config.permanent_items = {
     "wrench"
}

local misc_recipe = {
     ["repairkit"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Repair kit",
               -- icon = 'fa-solid fa-gun',
               object = {
                    name = "v_ind_cs_toolbox4", -- <-- this model can fail to load
                    rotation = vector3(45.0, 0.0, -45.0)
               },
               image = "repairkit", -- use inventory's images
               level = 200,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 32,
                    ["steel"] = 43,
                    ["plastic"] = 61
               },
               exp_per_craft = 7
          }
     },
     ["radio"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Radio",
               image = "radio", -- use inventory's images
               object = {
                    name = "v_serv_radio",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 25,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 40,
               materials = {
                    ["electronickit"] = 2,
                    ["plastic"] = 52,
                    ["steel"] = 40
               },
               exp_per_craft = 4
          }
     },
     ["lockpick"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Lockpick",
               image = "lockpick", -- use inventory's images
               object = {
                    name = "prop_cs_padlock",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 10,
               materials = {
                    ["metalscrap"] = 22,
                    ["plastic"] = 32
               },
               exp_per_craft = 1
          }
     },
     ["screwdriverset"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Toolkit",
               image = "screwdriverset", -- use inventory's images
               object = {
                    name = "prop_cs_padlock",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 30,
                    ["plastic"] = 42
               },
               exp_per_craft = 2
          }
     },
     ["electronickit"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Electronic Kit",
               image = "electronickit", -- use inventory's images
               object = {
                    name = "prop_cs_tablet_02",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 50,
               materials = {
                    ["metalscrap"] = 30,
                    ["plastic"] = 45,
                    ["aluminum"] = 28
               },
               exp_per_craft = 3
          }
     },
     ["gatecrack"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Gatecrack",
               image = "gatecrack", -- use inventory's images
               object = {
                    name = "hei_prop_hst_usb_drive",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 120,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 10,
                    ["plastic"] = 50,
                    ["aluminum"] = 30,
                    ["iron"] = 17,
                    ["electronickit"] = 1
               },
               exp_per_craft = 5
          }
     },
     ["ziptie"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "ziptie",
               image = "ziptie", -- use inventory's images
               object = {
                    name = "prop_cs_cuffs_01",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 150,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["plastic"] = 40,
                    ["rubber"] = 4
               },
               exp_per_craft = 2
          }
     },
     ["pistol_ammo"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Pistol Ammo",
               image = "pistol_ammo", -- use inventory's images
               object = {
                    name = "prop_ld_ammo_pack_01",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 250,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 75,
               materials = {
                    ["metalscrap"] = 50,
                    ["copper"] = 50
               },
               exp_per_craft = 6
          }
     },
     ["ironoxide"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Iron Oxide",
               image = "ironoxide", -- use inventory's images
               object = {
                    name = "prop_metalfoodjar_002",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 300,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 45,
               materials = {
                    ["iron"] = 60,
                    ["glass"] = 30
               },
               exp_per_craft = 9
          }
     },
     ["aluminumoxide"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Aluminum Oxide",
               image = "aluminumoxide", -- use inventory's images
               object = {
                    name = "prop_metalfoodjar_002",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 300,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 45,
               materials = {
                    ["aluminum"] = 60,
                    ["glass"] = 30
               },
               exp_per_craft = 10
          }
     },
     ["armor"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Armor",
               image = "armor", -- use inventory's images
               level = 350,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["iron"] = 33,
                    ["steel"] = 44,
                    ["plastic"] = 55,
                    ["aluminum"] = 22
               },
               exp_per_craft = 11
          }
     },
     ["drill"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Drill",
               image = "drill", -- use inventory's images
               object = {
                    name = "prop_tool_drill",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 45,
               materials = {
                    ["iron"] = 50,
                    ["steel"] = 50,
                    ["screwdriverset"] = 3,
                    ["advancedlockpick"] = 2
               },
               exp_per_craft = 12
          }
     },
     ["trojan_usb"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Trojan USB",
               image = "trojan_usb", -- use inventory's images
               object = {
                    name = "hei_prop_hst_usb_drive",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 15,
               materials = {
                    ["metalscrap"] = 10,
                    ["plastic"] = 50,
                    ["aluminum"] = 30,
                    ["iron"] = 17,
                    ["electronickit"] = 1
               },
               exp_per_craft = 12
          }
     },
     ["snspistol_part_1"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Springfield XD9 Trigger",
               image = "weapon_snspistol", -- use inventory's images
               object = {
                    name = "w_pi_sns_pistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 350,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 10,
               materials = {
                    ["metalscrap"] = 175,
                    ["steel"] = 175,
                    ["iron"] = 175
               },
               exp_per_craft = 12
          }
     },
     ["snspistol_part_2"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Springfield XD9 Slide",
               image = "weapon_snspistol", -- use inventory's images
               object = {
                    name = "w_pi_sns_pistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 350,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 10,
               materials = {
                    ["metalscrap"] = 75,
                    ["steel"] = 75,
                    ["aluminum"] = 75
               },
               exp_per_craft = 12
          }
     },
     ["snspistol_part_3"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Springfield XD9 Frame",
               image = "weapon_snspistol", -- use inventory's images
               object = {
                    name = "w_pi_sns_pistol_mag1",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 350,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 75,
               materials = {
                    ["metalscrap"] = 120,
                    ["steel"] = 120,
                    ["aluminum"] = 120
               },
               exp_per_craft = 12
          }
     },
     ["combatpistol_part_1"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Glock 19X Trigger",
               image = "weapon_combatpistol", -- use inventory's images
               object = {
                    name = "w_pi_combatpistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 10,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["iron"] = 250
               },
               exp_per_craft = 12
          }
     },
     ["combatpistol_part_2"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Glock 19X Slide",
               image = "weapon_combatpistol", -- use inventory's images
               object = {
                    name = "w_pi_combatpistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 10,
               materials = {
                    ["metalscrap"] = 100,
                    ["steel"] = 100,
                    ["aluminum"] = 100
               },
               exp_per_craft = 12
          }
     },
     ["combatpistol_part_3"] = {
          categories = {
               main = "misc"
          },
          item_settings = {
               label = "Glock 19X Frame",
               image = "weapon_combatpistol", -- use inventory's images
               object = {
                    name = "w_pi_combatpistol_mag1",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 75,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 150,
                    ["aluminum"] = 150
               },
               exp_per_craft = 12
          }
     },
     ['weapon_molotov'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Molotov Cocktail',
               image = 'weapon_molotov', -- use inventory's images
               object = {
                    name = 'w_ex_molotov',
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 250,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["glass"] = 50,
                    ['weapon_petrolcan'] = 1
               },
               exp_per_craft = 2
          }
     },
}

local medial = {
     ["bandage"] = {
          categories = {
               main = "medical"
          },
          item_settings = {
               label = "Bandage",
               image = "bandage", -- use inventory's images
               level = 125,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 3,
               materials = {
                    ["plastic"] = 10
               },
               exp_per_craft = 1
          }
     }
}

local weapons_recipe = {
     ["pistol_ammo"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Pistol Ammo",
               image = "pistol_ammo", -- use inventory's images
               object = {
                    name = "prop_ld_ammo_pack_01",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 250,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 50,
                    ["copper"] = 50
               },
               exp_per_craft = 6
          }
     },
     ["smg_ammo"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "SMG Ammo",
               image = "smg_ammo", -- use inventory's images
               object = {
                    name = "prop_ld_ammo_pack_01",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 250,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 60,
                    ["copper"] = 80
               },
               exp_per_craft = 4
          }
     },
     ["weapon_pistol"] = {
          categories = {
               sub = "pistol"
          },
          item_settings = {
               label = "Walther P99",
               image = "weapon_pistol", -- use inventory's images
               object = {
                    name = "w_pi_pistol50",
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 250,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 180,
               materials = {
                    ["metalscrap"] = 600,
                    ["steel"] = 600,
                    ["iron"] = 250,
                    ["aluminum"] = 250
               },
               exp_per_craft = 12
          }
     },
     --mac 10
     ["microsmg_part_1"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Mac-10 Trigger",
               image = "weapon_microsmg", -- use inventory's images
               object = {
                    name = "w_sb_microsmg",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1200,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["iron"] = 250,
                    ["ironoxide"] = 5
               },
               exp_per_craft = 12
          }
     },
     ["microsmg_part_2"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Mac-10 Barrel",
               image = "weapon_microsmg", -- use inventory's images
               object = {
                    name = "w_sb_microsmg",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1200,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 125,
                    ["steel"] = 170,
                    ["aluminum"] = 160
               },
               exp_per_craft = 12
          }
     },
     ["microsmg_part_3"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Mac-10 Frame",
               image = "weapon_microsmg", -- use inventory's images
               object = {
                    name = "w_sb_microsmg_mag1",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1200,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 150,
                    ["rubber"] = 150,
                    ["aluminumoxide"] = 5
               },
               exp_per_craft = 12
          }
     },
     --draco
     ["compactrifle_part_1"] = {
          categories = {
               
               sub = "rifle"
          },
          item_settings = {
               label = "Draco Trigger",
               image = "weapon_compactrifle", -- use inventory's images
               object = {
                    name = "w_ar_assaultrifle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2200,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 300,
                    ["steel"] = 250,
                    ["iron"] = 150,
                    ["ironoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["compactrifle_part_2"] = {
          categories = {
               
               sub = "rifle"
          },
          item_settings = {
               label = "Draco Barrel",
               image = "weapon_compactrifle", -- use inventory's images
               object = {
                    name = "w_ar_assaultrifle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2400,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 125,
                    ["steel"] = 170,
                    ["aluminum"] = 160
               },
               exp_per_craft = 12
          }
     },
     ["compactrifle_part_3"] = {
          categories = {
               
               sub = "rifle"
          },
          item_settings = {
               label = "Draco Frame",
               image = "weapon_compactrifle", -- use inventory's images
               object = {
                    name = "w_ar_assaultrifle_mag1",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2600,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["rubber"] = 180,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --AP Pistol
     ["appistol_part_1"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Glock-18 Trigger",
               image = "weapon_appistol", -- use inventory's images
               object = {
                    name = "w_pi_appistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 200,
                    ["steel"] = 200,
                    ["iron"] = 200,
                    ["ironoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["appistol_part_2"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Glock-18 Slide",
               image = "weapon_appistol", -- use inventory's images
               object = {
                    name = "w_pi_appistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 100,
                    ["steel"] = 120,
                    ["aluminum"] = 120
               },
               exp_per_craft = 12
          }
     },
     ["appistol_part_3"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Glock-18 Frame",
               image = "weapon_appistol", -- use inventory's images
               object = {
                    name = "w_pi_appistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 120,
                    ["steel"] = 200,
                    ["rubber"] = 120,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --Brass Knuckles
     ["weapon_knuckle"] = {
          categories = {
               
               sub = "melee"
          },
          item_settings = {
               label = "Brass Knuckles",
               image = "weapon_knuckle", -- use inventory's images
               object = {
                    name = "w_me_knuckle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 200,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 60,
                    ["steel"] = 60,
                    ["iron"] = 60,
                    ["aluminum"] = 60,
                    ["copper"] = 60
               },
               exp_per_craft = 5
          }
     },
     --Deagle
     ["deagle_part_1"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Deagle Trigger",
               image = "weapon_deagle", -- use inventory's images
               object = {
                    name = "w_pi_deagle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1800,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 200,
                    ["steel"] = 200,
                    ["iron"] = 200,
                    ["ironoxide"] = 10,
                    ["aluminumoxide"] = 10,
                    ["copper"] = 200
               },
               exp_per_craft = 12
          }
     },
     ["deagle_part_2"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Deagle Slide",
               image = "weapon_deagle", -- use inventory's images
               object = {
                    name = "w_pi_deagle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 150,
                    ["aluminum"] = 150
               },
               exp_per_craft = 12
          }
     },
     ["deagle_part_3"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Deagle Frame",
               image = "weapon_deagle", -- use inventory's images
               object = {
                    name = "w_pi_deagle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 160,
                    ["steel"] = 220,
                    ["rubber"] = 150,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --Vintage pistol
     ["vintagepistol_part_1"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Colt 1911 Trigger",
               image = "weapon_vintagepistol", -- use inventory's images
               object = {
                    name = "w_pi_vintagepistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1000,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 200,
                    ["steel"] = 200,
                    ["copper"] = 200,
                    ["ironoxide"] = 10,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["vintagepistol_part_2"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Colt 1911 Slide",
               image = "weapon_vintagepistol", -- use inventory's images
               object = {
                    name = "w_pi_vintagepistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1000,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 120,
                    ["steel"] = 120,
                    ["aluminum"] = 120
               },
               exp_per_craft = 12
          }
     },
     ["vintagepistol_part_3"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Colt 1911 Frame",
               image = "weapon_vintagepistol", -- use inventory's images
               object = {
                    name = "w_pi_vintagepistol",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1000,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 120,
                    ["steel"] = 200,
                    ["rubber"] = 120,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --Revolver
     ["revolver_part_1"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Revolver Trigger",
               image = "weapon_revolver", -- use inventory's images
               object = {
                    name = "w_pi_revolver",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2000,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 300,
                    ["steel"] = 300,
                    ["iron"] = 300,
                    ["ironoxide"] = 15,
                    ["aluminumoxide"] = 15
               },
               exp_per_craft = 12
          }
     },
     ["revolver_part_2"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Revolver Barrel",
               image = "weapon_navyrevolver", -- use inventory's images
               object = {
                    name = "w_pi_revolver",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2000,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 200,
                    ["steel"] = 200,
                    ["aluminum"] = 200
               },
               exp_per_craft = 12
          }
     },
     ["revolver_part_3"] = {
          categories = {
               
               sub = "pistol"
          },
          item_settings = {
               label = "Revolver Frame",
               image = "weapon_revolver", -- use inventory's images
               object = {
                    name = "w_pi_revolver",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2000,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 200,
                    ["steel"] = 220,
                    ["rubber"] = 200,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --MP5
     ["smg_part_1"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "MP5 Trigger",
               image = "weapon_mp5", -- use inventory's images
               object = {
                    name = "w_sb_mp5",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2100,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["iron"] = 250,
                    ["ironoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["smg_part_2"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "MP5 Barrel",
               image = "weapon_mp5", -- use inventory's images
               object = {
                    name = "w_sb_mp5",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2100,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 125,
                    ["steel"] = 170,
                    ["aluminum"] = 160
               },
               exp_per_craft = 12
          }
     },
     ["smg_part_3"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "MP5 Frame",
               image = "weapon_mp5", -- use inventory's images
               object = {
                    name = "w_sb_mp5",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2100,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 150,
                    ["rubber"] = 150,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --Assault SMG
     ["assaultsmg_part_1"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "P90 Trigger",
               image = "weapon_assaultsmg", -- use inventory's images
               object = {
                    name = "w_sb_assaultsmg",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1200,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 275,
                    ["steel"] = 275,
                    ["iron"] = 275,
                    ["ironoxide"] = 10,
                    ["aluminum"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["assaultsmg_part_2"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "P90 Barrel",
               image = "weapon_assaultsmg", -- use inventory's images
               object = {
                    name = "w_sb_assaultsmg",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2100,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 170,
                    ["aluminum"] = 160
               },
               exp_per_craft = 12
          }
     },
     ["assaultsmg_part_3"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "P90 Frame",
               image = "weapon_assaultsmg", -- use inventory's images
               object = {
                    name = "w_sb_assaultsmg",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2100,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 150,
                    ["rubber"] = 150,
                    ["aluminumoxide"] = 5
               },
               exp_per_craft = 12
          }
     },
     --Combat PDW
     ["combatpdw_part_1"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Combat PDW Trigger",
               image = "weapon_combatpdw", -- use inventory's images
               object = {
                    name = "w_sb_combatpdw",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1600,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 225,
                    ["steel"] = 225,
                    ["iron"] = 225,
                    ["ironoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["combatpdw_part_2"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Combat PDW Barrel",
               image = "weapon_combatpdw", -- use inventory's images
               object = {
                    name = "w_sb_combatpdw",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1600,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 125,
                    ["steel"] = 170,
                    ["aluminum"] = 160
               },
               exp_per_craft = 12
          }
     },
     ["combatpdw_part_3"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Combat PDW Frame",
               image = "weapon_combatpdw", -- use inventory's images
               object = {
                    name = "w_sb_combatpdw",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1600,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 150,
                    ["rubber"] = 150,
                    ["aluminumoxide"] = 5
               },
               exp_per_craft = 12
          }
     },
     --Tec 9
     ["tec9_part_1"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Tec 9 Trigger",
               image = "weapon_tec9", -- use inventory's images
               object = {
                    name = "w_sb_tec9",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 700,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 300,
                    ["steel"] = 300,
                    ["iron"] = 300,
                    ["ironoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["tec9_part_2"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "tec9 Barrel",
               image = "weapon_tec9", -- use inventory's images
               object = {
                    name = "w_sb_tec9",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 700,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 100,
                    ["steel"] = 120,
                    ["aluminum"] = 120
               },
               exp_per_craft = 12
          }
     },
     ["tec9_part_3"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Tec9 Frame",
               image = "weapon_tec9", -- use inventory's images
               object = {
                    name = "w_sb_tec9",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 700,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 120,
                    ["steel"] = 200,
                    ["rubber"] = 120,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --Mini SMG
     ["minismg_part_1"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Skorpion Trigger",
               image = "weapon_minismg", -- use inventory's images
               object = {
                    name = "w_sb_minismg",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 800,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["iron"] = 250,
                    ["ironoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["minismg_part_2"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Skorpion Barrel",
               image = "weapon_minismg", -- use inventory's images
               object = {
                    name = "w_sb_minismg",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 800,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 100,
                    ["steel"] = 120,
                    ["aluminum"] = 120
               },
               exp_per_craft = 12
          }
     },
     ["minismg_part_3"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Skorpion Frame",
               image = "weapon_minismg", -- use inventory's images
               object = {
                    name = "w_sb_minismg_mag1",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 800,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 200,
                    ["rubber"] = 150,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     --sawn off shotgun
     ["sawnoffshotgun_part_1"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Sawn off Shotgun Trigger",
               image = "weapon_sawnoffshotgun", -- use inventory's images
               object = {
                    name = "w_sg_sawnoffshotgun",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1900,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["iron"] = 250,
                    ["ironoxide"] = 10,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["sawnoffshotgun__part_2"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Sawnoffshotgun Barrel",
               image = "weapon_sawnoffshotgun", -- use inventory's images
               object = {
                    name = "w_sg_sawnoffshotgun",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1900,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 150,
                    ["aluminum"] = 150
               },
               exp_per_craft = 12
          }
     },
     ["sawnoffshotgun_part_3"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Sawn off Shotgun Frame",
               image = "weapon_sawnoffshotgun", -- use inventory's images
               object = {
                    name = "w_sg_sawnoffshotgun_mag1",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1900,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 120,
                    ["steel"] = 200,
                    ["rubber"] = 120,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["sawnoffshotgun_part_4"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Sawn off Shotgun Bolt",
               image = "weapon_sawnoffshotgun", -- use inventory's images
               object = {
                    name = "w_sg_sawnoffshotgun",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 1900,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 300,
                    ["steel"] = 300
               },
               exp_per_craft = 12
          }
     },
     --Double barrel Shotgun
     ["doublebarrelshotgun_part_1"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Double Barrel Shotgun Trigger",
               image = "weapon_dbshotgun", -- use inventory's images
               object = {
                    name = "w_sg_doublebarrel",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["iron"] = 250,
                    ["ironoxide"] = 10,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 8
          }
     },
     ["doublebarrelshotgun__part_2"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Double Barrel Shotgun Barrel",
               image = "weapon_dbshotgun", -- use inventory's images
               object = {
                    name = "w_sg_doublebarrel",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["aluminum"] = 250
               },
               exp_per_craft = 8
          }
     },
     ["doublebarrelshotgun_part_3"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Double Barrel Shotgun Frame",
               image = "weapon_dbshotgun", -- use inventory's images
               object = {
                    name = "w_sg_doublebarrel_mag1",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 150,
                    ["steel"] = 200,
                    ["rubber"] = 150,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 8
          }
     },
     ["doublebarrelshotgun_part_4"] = {
          categories = {
               
               sub = "shotgun"
          },
          item_settings = {
               label = "Double Barrel Shotgun Bolt",
               image = "weapon_dbshotgun", -- use inventory's images
               object = {
                    name = "w_sg_doublebarrel",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 300,
                    ["steel"] = 300,
                    ["aluminum"] = 300
               },
               exp_per_craft = 8
          }
     },
     ["assaultrifle_part_1"] = {
          categories = {
               
               sub = "rifle"
          },
          item_settings = {
               label = "AK Trigger",
               image = "weapon_assaultrifle", -- use inventory's images
               object = {
                    name = "w_ar_assaultrifle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 350,
                    ["steel"] = 350,
                    ["iron"] = 350,
                    ["ironoxide"] = 10,
                    ["aluminumoxide"] = 10,
                    ["aluminum"] = 350
               },
               exp_per_craft = 12
          }
     },
     ["assaultrifle_part_2"] = {
          categories = {
               
               sub = "rifle"
          },
          item_settings = {
               label = "AK Barrel",
               image = "weapon_assaultrifle", -- use inventory's images
               object = {
                    name = "w_ar_assaultrifle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 200,
                    ["steel"] = 200,
                    ["aluminum"] = 200
               },
               exp_per_craft = 12
          }
     },
     ["assaultrifle_part_3"] = {
          categories = {
               
               sub = "rifle"
          },
          item_settings = {
               label = "AK Frame",
               image = "weapon_assaultrifle", -- use inventory's images
               object = {
                    name = "w_ar_assaultrifle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 180,
                    ["steel"] = 200,
                    ["rubber"] = 200,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     },
     ["assaultrifle_part_4"] = {
          categories = {
               
               sub = "rifle"
          },
          item_settings = {
               label = "AK Bolt",
               image = "weapon_assaultrifle", -- use inventory's images
               object = {
                    name = "w_ar_assaultrifle",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 2500,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 300,
                    ["steel"] = 300,
                    ["aluminum"] = 300
               },
               exp_per_craft = 12
          }
     },
     --Tommy Gun
     ["tommygun_part_1"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Tommy Gun Trigger",
               image = "weapon_gusenberg", -- use inventory's images
               object = {
                    name = "w_sb_tommygun",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 900,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 250,
                    ["steel"] = 250,
                    ["iron"] = 250,
                    ["ironoxide"] = 10
               },
               exp_per_craft = 10
          }
     },
     ["tommygun_part_2"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Tommy Gun Barrel",
               image = "weapon_gusenberg", -- use inventory's images
               object = {
                    name = "w_sb_tommygun",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 900,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 100,
                    ["steel"] = 120,
                    ["aluminum"] = 120
               },
               exp_per_craft = 10
          }
     },
     ["tommygun_part_3"] = {
          categories = {
               
               sub = "smg"
          },
          item_settings = {
               label = "Tommy Gun Frame",
               image = "weapon_gusenberg", -- use inventory's images
               object = {
                    name = "w_sb_tommygun",
                    rotation = vector3(0.0, 0.0, 0.0)
               },
               level = 900,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 60,
               materials = {
                    ["metalscrap"] = 120,
                    ["steel"] = 200,
                    ["rubber"] = 120,
                    ["aluminumoxide"] = 10
               },
               exp_per_craft = 12
          }
     }
}

local attachments_recipe = {
     ["pistol_suppressor"] = {
          categories = {
               sub = "pistol"
          },
          item_settings = {
               label = "Walther suppressor",
               image = "pistol_suppressor", -- use inventory's images
               object = {
                    name = "w_at_ar_supp_02",
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["metalscrap"] = 350,
                    ["steel"] = 300,
                    ["rubber"] = 300
               },
               exp_per_craft = 5
          }
     },
     ["combatpistol_suppressor"] = {
          categories = {
               sub = "pistol"
          },
          item_settings = {
               label = "Glock suppressor",
               image = "pistol_suppressor", -- use inventory's images
               object = {
                    name = "w_at_ar_supp_02",
                    rotation = vector3(45.0, 0.0, 0.0)
               },
               level = 0,
               job = {
                    allowed_list = {},
                    allowed_grades = {}
               }
          },
          crafting = {
               success_rate = 100,
               amount = 1, -- crafted amount
               duration = 120,
               materials = {
                    ["metalscrap"] = 350,
                    ["steel"] = 300,
                    ["rubber"] = 300
               },
               exp_per_craft = 5
          }
     }
}

Config.workbench_default_model = "gr_prop_gr_bench_04a"

Config.workbenches = {
     -- items
     {
          table_model = "gr_prop_gr_bench_04b",
          coords = vector3(1346.55, 4391.04, 43.36),
          item_show_case_offset = vector3(0.0, 0.0, 1.3),
          rotation = vector3(0.0, 0.0, 350),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = {Config.categories.misc, Config.categories.medical},
          recipes = {misc_recipe, medial},
          radius = 3.0
     },
     {
          table_model = "gr_prop_gr_bench_04b",
          coords = vector3(-59.5, 6388.77, 30.49),
          rotation = vector3(0.0, 0.0, 225.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = {Config.categories.misc, Config.categories.medical},
          recipes = {misc_recipe, medial},
          radius = 3.0
     },
     -- gun
     {
          table_model = "gr_prop_gr_bench_02b",
          coords = vector3(68, 3684.62, 38.83),
          item_show_case_offset = vector3(0.0, 0.0, 1.2),
          rotation = vector3(0.0, 0.0, 235.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = {Config.categories.weapons},
          recipes = {weapons_recipe},
          radius = 3.0
     },
     {
          table_model = "gr_prop_gr_bench_02b",
          coords = vector3(2939.04, 4623.81, 47.72),
          item_show_case_offset = vector3(0.0, 0.0, 1.2),
          rotation = vector3(0.0, 0.0, 47.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = {Config.categories.weapons},
          recipes = {weapons_recipe},
          radius = 3.0
     }
}

--gr_prop_gr_jailer_keys_01a

-- gr_prop_gr_missle_long
-- gr_prop_gr_missle_short
-- gr_int02_generator_01
-- gr_prop_gr_hammer_01

-- w_sr_heavysnipermk2_mag2
-- w_sb_smgmk2_mag2
-- w_sb_smgmk2_mag1
-- w_pi_pistolmk2_mag1
-- w_mg_combatmgmk2_mag1
-- w_ar_carbineriflemk2_mag1
-- w_ar_assaultriflemk2_mag1
-- w_ex_vehiclemissile_3
-- w_ex_vehiclemissile_1
-- w_ex_vehiclemissile_2
-- w_ex_vehiclemortar

-- w_sg_pumpshotgunmk2_mag1
-- w_sg_pumpshotgunh4_mag1
-- gr_prop_gr_adv_case

-- w_at_pi_flsh_2
-- w_at_afgrip_2
-- w_at_muzzle_1
-- w_at_muzzle_3
-- w_at_muzzle_2
-- w_at_muzzle_5
-- w_at_muzzle_6
-- w_at_muzzle_7
-- w_at_muzzle_8
-- w_at_muzzle_9

-- w_at_pi_comp_1
-- w_at_pi_rail_1
-- w_at_scope_macro_2_mk2
-- w_at_scope_small_mk2
-- w_at_scope_medium_2
-- w_at_scope_nv
-- w_at_sights_1
-- w_at_sights_smg
-- w_at_sr_supp3

-- gr_prop_gr_drill_01a

-- gr_prop_gr_driver_01a
-- gr_prop_gr_pliers_01
-- gr_prop_gr_pliers_02
-- gr_prop_gr_rasp_01
-- gr_prop_gr_rasp_02
-- gr_prop_gr_rasp_03
-- gr_prop_gr_sdriver_01
-- gr_prop_gr_sdriver_02
-- gr_prop_gr_sdriver_03

-- gr_prop_gr_vice_01a
