Config = {}

Config.DrawTextUI = false

Config.DrawSprite = {
    -- Unlocked
    [0] = {'mpsafecracking', 'lock_open', 0, 0, 0.018, 0.018, 0, 105, 187, 60, 100},

    -- Locked
    [1] = {'mpsafecracking', 'lock_closed', 0, 0, 0.018, 0.018, 0, 227, 36, 43, 100},
}

-- Allow the following ACL principal to use 'command.doorlock'
Config.CommandPrincipal = 'group.admin'

-- Allow players with 'command.doorlock' permission to open any doors
Config.PlayerAceAuthorised = false
