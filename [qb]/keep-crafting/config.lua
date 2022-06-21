Config = Config or {}

Config.model_loading = {
     timeout = 1500, --ms
     dealy = 50, --ms
}

Config.categories = {
     ['misc'] = {
          key = 'misc',
          label = 'Misc',
          icon = 'fa-solid fa-tags',
          jobs = {},
     },
     ['weapons'] = {
          key = 'weapons',
          label = 'Weapons',
          icon = 'fa-solid fa-gun',
          jobs = {},
          sub_categories = {
               ['pistol'] = {
                    label = 'Pistol',
               },
               ['smg'] = {
                    label = 'SMG',
               },
          }
     },
     ['medical'] = {
          key = 'medical',
          label = 'Medical',
          icon = 'fa-solid fa-hand-holding-medical',
          jobs = {}
     }
}

Config.permanent_items = {
     'wrench'
}

local misc_recipe = {
     ['repairkit'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Repair kit',
               -- icon = 'fa-solid fa-gun',
               object = {
                    name = 'v_ind_cs_toolbox4', -- <-- this model can fail to load
                    rotation = vector3(45.0, 0.0, -45.0)
               },
               image = 'repairkit', -- use inventory's images
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
                    ["plastic"] = 61,
               },
               exp_per_craft = 7
          }
     },
     ['radio'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Radio',
               image = 'radio', -- use inventory's images
               object = {
                    name = 'v_serv_radio',
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
                    ["steel"] = 40,
               },
               exp_per_craft = 4
          }
     },
     ['lockpick'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Lockpick',
               image = 'lockpick', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
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
                    ["plastic"] = 32,
               },
               exp_per_craft = 1
          }
     },
     ['screwdriverset'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Toolkit',
               image = 'screwdriverset', -- use inventory's images
               object = {
                    name = 'prop_cs_padlock',
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
                    ["plastic"] = 42,
               },
               exp_per_craft = 2
          }
     },
     ['electronickit'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Electronic Kit',
               image = 'electronickit', -- use inventory's images
               object = {
                    name = 'prop_cs_tablet_02',
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
                    ["aluminum"] = 28,
               },
               exp_per_craft = 3
          }
     },
     ['gatecrack'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Gatecrack',
               image = 'gatecrack', -- use inventory's images
               object = {
                    name = 'hei_prop_hst_usb_drive',
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
                    ["electronickit"] = 1,
               },
               exp_per_craft = 5
          }
     },
     ['ziptie'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'ziptie',
               image = 'ziptie', -- use inventory's images
               object = {
                    name = 'prop_cs_cuffs_01',
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
                    ["rubber"] = 4,
               },
               exp_per_craft = 2
          }
     },
     ['pistol_ammo'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Pistol Ammo',
               image = 'pistol_ammo', -- use inventory's images
               object = {
                    name = 'prop_ld_ammo_pack_01',
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
                    ["copper"] = 50,
               },
               exp_per_craft = 6
          }
     },
     ['ironoxide'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Iron Oxide',
               image = 'ironoxide', -- use inventory's images
               object = {
                    name = 'prop_metalfoodjar_002',
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
                    ["glass"] = 30,
               },
               exp_per_craft = 9
          }
     },
     ['aluminumoxide'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Aluminum Oxide',
               image = 'aluminumoxide', -- use inventory's images
               object = {
                    name = 'prop_metalfoodjar_002',
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
                    ["glass"] = 30,
               },
               exp_per_craft = 10
          }
     },
     ['armor'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Armor',
               image = 'armor', -- use inventory's images
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
                    ["aluminum"] = 22,
               },
               exp_per_craft = 11
          }
     },
     ['drill'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Drill',
               image = 'drill', -- use inventory's images
               object = {
                    name = 'prop_tool_drill',
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
                    ["advancedlockpick"] = 2,
               },
               exp_per_craft = 12
          }
     },
     ['trojan_usb'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Trojan USB',
               image = 'trojan_usb', -- use inventory's images
               object = {
                    name = 'hei_prop_hst_usb_drive',
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
                    ["electronickit"] = 1,
               },
               exp_per_craft = 12
          }
     },
     ['snspistol_part_1'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'SNS Pistol Loop',
               image = 'weapon_snspistol', -- use inventory's images
               object = {
                    name = 'w_pi_sns_pistol',
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
                    ["iron"] = 175,
               },
               exp_per_craft = 12
          }
     },
     ['snspistol_part_2'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'SNS Pistol Trigger',
               image = 'weapon_snspistol', -- use inventory's images
               object = {
                    name = 'w_pi_sns_pistol',
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
                    ["aluminum"] = 75,
               },
               exp_per_craft = 12
          }
     },
     ['snspistol_part_3'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'SNS Pistol Clip',
               image = 'weapon_snspistol', -- use inventory's images
               object = {
                    name = 'w_pi_sns_pistol_mag1',
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
                    ["aluminum"] = 120,
               },
               exp_per_craft = 12
          }
     },
     ['combatpistol_part_1'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Glock Loop',
               image = 'weapon_combatpistol', -- use inventory's images
               object = {
                    name = 'w_pi_combatpistol',
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
                    ["iron"] = 250,
               },
               exp_per_craft = 12
          }
     },
     ['combatpistol_part_2'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Glock Trigger',
               image = 'weapon_combatpistol', -- use inventory's images
               object = {
                    name = 'w_pi_combatpistol',
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
                    ["aluminum"] = 100,
               },
               exp_per_craft = 12
          }
     },
     ['combatpistol_part_3'] = {
          categories = {
               main = 'misc',
          },
          item_settings = {
               label = 'Glock Clip',
               image = 'weapon_combatpistol', -- use inventory's images
               object = {
                    name = 'w_pi_combatpistol_mag1',
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
                    ["aluminum"] = 150,
               },
               exp_per_craft = 12
          }
     },
}

local medial = {
     ['bandage'] = {
          categories = {
               main = 'medical',
          },
          item_settings = {
               label = 'Bandage',
               image = 'bandage', -- use inventory's images
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
                    ["plastic"] = 10,
               },
               exp_per_craft = 1
          }
     },
}

local weapons_recipe = {
     ['pistol_ammo'] = {
          categories = {
               sub = 'pistol',
          },
          item_settings = {
               label = 'Pistol Ammo',
               image = 'pistol_ammo', -- use inventory's images
               object = {
                    name = 'prop_ld_ammo_pack_01',
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
                    ["copper"] = 50,
               },
               exp_per_craft = 6
          }
     },
     ['weapon_pistol'] = {
          categories = {
               sub = 'pistol',
          },
          item_settings = {
               label = 'Walther P99',
               image = 'weapon_pistol', -- use inventory's images
               object = {
                    name = 'w_pi_pistol50',
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
                    ["aluminum"] = 250,
               },
               exp_per_craft = 12
          }
     },
     ['pistol_suppressor'] = {
          categories = {
               sub = 'smg',
          },
          item_settings = {
               label = 'Pistol suppressor',
               image = 'pistol_suppressor', -- use inventory's images
               object = {
                    name = 'w_at_ar_supp_02',
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
                    ["rubber"] = 300,
               },
               exp_per_craft = 5
          }
     },
}

Config.workbench_default_model = 'gr_prop_gr_bench_04a'

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
          categories = { Config.categories.misc, Config.categories.medical },
          recipes = { misc_recipe, medial },
          radius = 3.0
     },
     {
          table_model = 'gr_prop_gr_bench_04b',
          coords = vector3(-59.5, 6388.77, 30.49),
          rotation = vector3(0.0, 0.0, 225.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = { Config.categories.misc, Config.categories.medical },
          recipes = { misc_recipe, medial },
          radius = 3.0
     },
     -- gun
     {
          table_model = 'gr_prop_gr_bench_02b',
          coords = vector3(68, 3684.62, 38.83),
          item_show_case_offset = vector3(0.0, 0.0, 1.2),
          rotation = vector3(0.0, 0.0, 235.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = { Config.categories.weapons },
          recipes = { weapons_recipe },
          radius = 3.0
     }, {
          table_model = 'gr_prop_gr_bench_02b',
          coords = vector3(2939.04, 4623.81, 47.72),
          item_show_case_offset = vector3(0.0, 0.0, 1.2),
          rotation = vector3(0.0, 0.0, 47.0),
          job = {
               allowed_list = {},
               allowed_grades = {}
          },
          categories = { Config.categories.weapons },
          recipes = { weapons_recipe },
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
