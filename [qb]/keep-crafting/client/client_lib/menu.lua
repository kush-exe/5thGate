------------------
--   Const
local QBCore = exports['qb-core']:GetCoreObject()

--   Variable
local PlayerJob = nil
local menu = {}
Workbench = nil
------------------
function Open_menu()
     menu:main_categories()
end

------------------
--   functions
------------------

local function updatePlayerJob()
     repeat
          Wait(10)
     until QBCore.Functions.GetPlayerData().job ~= nil
     PlayerJob = QBCore.Functions.GetPlayerData().job
end

local function isJobAllowed(job_list)
     -- check player job
     updatePlayerJob()

     if #job_list.allowed_list == 0 then return true end
     for _, allowed_job in ipairs(job_list.allowed_list) do
          if allowed_job == PlayerJob.name then
               -- check player grade
               if not job_list.allowed_grades[PlayerJob.name] then
                    return true
               end
               if #job_list.allowed_grades[PlayerJob.name] == 0 then
                    return true
               else
                    for _, allowed_grades in ipairs(job_list.allowed_grades[PlayerJob.name]) do
                         if allowed_grades == PlayerJob.grade.level then
                              return true
                         end
                    end
               end
          end
     end
     return false
end

function GetClosest_Workbenches()
     local ped = PlayerPedId()
     local playercoords = GetEntityCoords(ped)
     local benches = Config.workbenches

     for _, v in ipairs(benches) do
          local distance = #(playercoords - v.coords)
          if distance < 2.6 then

               if isJobAllowed(v.job) then
                    v.id = _
                    return true, v
               else
                    QBCore.Functions.Notify(Lang:t('error.not_authorized'), 'error')
                    return false
               end
          end
     end
     return false
end

------------------
--     Menu
------------------
local function search_for_items_in_category(category)
     local tmp = {}
     for key, recipe in pairs(Workbench.recipes) do
          for k, item in pairs(recipe) do
               if not item.categories.sub and item.categories.main and item.categories.main == category then
                    tmp[k] = item
               end
               if not item.categories.main and item.categories.sub and item.categories.sub == category then
                    tmp[k] = item
               end
          end
     end
     return tmp
end

function menu:main_categories()
     -- workbench.recipes.categories
     if Workbench == nil then return end
     local Menu = {}
     Menu[#Menu + 1] = {
          header = Lang:t('menu.main_menu_header'),
          icon = 'fa-solid fa-wrench',
          disabled = true
     }
     for key, category in pairs(Workbench.categories) do
          -- main menu + sub menu ref
          if category.sub_categories then
               Menu[#Menu + 1] = {
                    header = category.label,
                    icon = category.icon or 'fa-solid fa-caret-right',
                    submenu = true,
                    args = {
                         category.sub_categories
                    },
                    action = function(args)
                         menu:sub_categories(args)
                    end
               }
          else
               Menu[#Menu + 1] = {
                    header = category.label,
                    icon = category.icon or 'fa-solid fa-caret-right',
                    submenu = true,
                    args = {
                         category.key, 'main'
                    },
                    action = function(arg)
                         menu:crafting_items_list(arg)
                    end
               }
          end
     end

     Menu[#Menu + 1] = {
          header = Lang:t('menu.player_crafting_information'),
          icon = 'fa-solid fa-circle-info',
          args = { 1 },
          action = function()
               menu:player_crafting_information()
          end
     }

     Menu[#Menu + 1] = {
          header = Lang:t('menu.leave'),
          event = "keep-menu:closeMenu",
          leave = true
     }

     exports['keep-menu']:createMenu(Menu)
end

function menu:player_crafting_information()
     QBCore.Functions.TriggerCallback('keep-crafting:server:get_player_information', function(result)
          local job_sub = Lang:t("menu.job_sub")
          job_sub = string.format(job_sub, result.job.name, result.job.grade.name)
          local Menu = {
               {
                    header = Lang:t("menu.back"),
                    back = true,
                    args = { 1 },
                    action = function()
                         menu:main_categories()
                    end
               },
               {
                    header = Lang:t('menu.your_name'),
                    subheader = result.charinfo.firstname .. ' ' .. result.charinfo.lastname,
                    icon = 'fa-solid fa-list-ol',
                    disabled = true
               },
               {
                    header = Lang:t('menu.your_job'),
                    subheader = job_sub,
                    icon = 'fa-solid fa-list-ol',
                    disabled = true
               },
               {
                    header = Lang:t('menu.crafting_exp'),
                    subheader = tostring(result.metadata.craftingrep),
                    icon = 'fa-solid fa-list-ol',
                    disabled = true
               },
               {
                    header = Lang:t('menu.leave'),
                    event = "keep-menu:closeMenu",
                    leave = true
               }
          }
          exports['keep-menu']:createMenu(Menu)
     end)
end

function menu:sub_categories(args)
     -- args[1] is data used by current menu
     -- args[2] is previous menu cached data (make possible to go back in menus)
     local Menu = {}
     Menu[#Menu + 1] = {
          header = Lang:t("menu.back"),
          back = true,
          args = { 1 },
          action = function()
               menu:main_categories()
          end
     }

     for key, sub in pairs(args[1]) do
          Menu[#Menu + 1] = {
               header = sub.label,
               icon = 'fa-solid fa-gun',
               submenu = true,
               args = {
                    key, args
               },
               action = function(arg)
                    menu:crafting_items_list(arg)
               end
          }
     end

     Menu[#Menu + 1] = {
          header = Lang:t('menu.leave'),
          event = "keep-menu:closeMenu",
          leave = true
     }

     exports["keep-menu"]:createMenu(Menu)
end

function menu:crafting_items_list(args)
     local items = search_for_items_in_category(args[1])
     local Menu = {}
     if type(args[2]) == "table" then
          Menu[#Menu + 1] = {
               header = Lang:t("menu.back"),
               back = true,
               args = { 1 },
               action = function()
                    menu:sub_categories(args[2])
               end
          }
     elseif args[2] == 'main' then
          Menu[#Menu + 1] = {
               header = Lang:t("menu.back"),
               back = true,
               args = { 1 },
               action = function()
                    menu:main_categories()
               end
          }
     end

     for item_name, item in pairs(items) do
          item.item_name = item_name -- inject item name into item's data
          Menu[#Menu + 1] = {
               header = item.item_settings.label or item_name,
               icon = item.item_settings.icon or 'fa-solid fa-caret-right',
               submenu = true,
               image = item.item_settings.image or nil,
               args = {
                    item, args
               },
               action = function(item)
                    menu:crafting_menu(item)
               end
          }
     end

     Menu[#Menu + 1] = {
          header = Lang:t('menu.leave'),
          event = "keep-menu:closeMenu",
          leave = true
     }

     exports["keep-menu"]:createMenu(Menu)
end

function menu:crafting_menu(args)
     local item = args[1]
     local entity, box, cam

     if item.item_settings.object and next(item.item_settings.object) then
          entity, box, cam = SpawnAndCameraWrapper(item.item_settings.object, Workbench.coords, Workbench.rotation,
               Workbench.item_show_case_offset)
     end

     local Menu = {
          {
               header = Lang:t("menu.back"),
               back = true,
               args = { 1 },
               action = function()
                    menu:crafting_items_list(args[2])
               end
          },
          {
               header = Lang:t('menu.item_name'),
               subheader = item.item_settings.label,
               icon = 'fa-solid fa-list-ol',
               disabled = true
          },
          {
               header = Lang:t('menu.craft'),
               subheader = 'craft current item',
               icon = 'fa-solid fa-pen-ruler',
               args = {
                    'sell', item, Workbench.id
               },
               action = function(args)
                    TriggerServerEvent('keep-crafting:server:craft_item', {
                         type = args[1],
                         item = args[2],
                         id = args[3]
                    })
               end
          },
          {
               header = Lang:t('menu.check_mat_list'),
               subheader = 'check inventory for required materials',
               icon = 'fa-solid fa-clipboard-check',
               args = { 'sell', item, Workbench.id },
               action = function(args)
                    TriggerServerEvent('keep-crafting:check_materials_list', {
                         type = args[1],
                         item = args[2],
                         id = args[3]
                    })
               end
          },
          {
               header = Lang:t('menu.leave'),
               event = "keep-menu:closeMenu",
               leave = true
          }
     }

     -- {
     --      header = "Repair",
     --      subheader = 'if you already have one and is repairable',
     --      icon = 'fa-solid fa-screwdriver-wrench',
     --      args = {
     --           'repair', item, Workbench.id
     --      },
     --      action = function(args)
     --           TriggerServerEvent('keep-crafting:server:craft_item', {
     --                type = args[1],
     --                item = args[2],
     --                Workbench_id = args[3]
     --           })
     --      end
     -- },
     exports["keep-menu"]:createMenu(Menu)

     if item.item_settings.object and next(item.item_settings.object) then
          if entity and box and cam then
               SpawnAndCameraRemover(entity, box, cam)
          end
     end
end

------------------
--    Events
------------------

RegisterKeyMapping('+crafting_menu', 'crafting_menu', 'keyboard', 'e')
RegisterCommand('+crafting_menu', function()
     local state, workbench = GetClosest_Workbenches()
     if not IsPauseMenuActive() and state then
          Workbench = workbench
          menu:main_categories()
          return
     end
end, false)
