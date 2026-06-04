--[[
    ________           __             _____ __            ___           
   / ____/ /___ ______/ /_  __  __   / ___// /___  ______/ (_)___  _____
  / /_  / / __ `/ ___/ __ \/ / / /   \__ \/ __/ / / / __  / / __ \/ ___/
 / __/ / / /_/ (__  ) / / / /_/ /   ___/ / /_/ /_/ / /_/ / / /_/ (__  )  
/_/   /_/\__,_/____/_/ /_/\__, /   /____/\__/\__,_/\__,_/_/\____/____/  
                         /____/                                         
]]

local BASE_URL = "https://github.com/flashyshadowstrike/Flashy-Hub/tree/main/Scripts"

local GAME_MAP = {
    -- [PlaceId] = "ScriptFileName.lua"

    -- Sell Lemons
    [79268393072444] = "SellLemons.lua",

    -- Industrialist
    [9192423027] = "Industrialist.lua",
}

local Fluent = loadstring(game:HttpGet(
    "https://github.com/StyearX/Fluent-Modded/releases/download/Fluent/FluentPro"
))()

local placeId  = game.PlaceId
local okInfo, info = pcall(function()
    return game:GetService("MarketplaceService"):GetProductInfo(placeId)
end)
local gameName = (okInfo and info and info.Name) or "Unknown Game"

local target = GAME_MAP[placeId]

if not target then
    local Window = Fluent:CreateWindow({
        Title    = "Flashy Studios Loader",
        SubTitle = "by Flashy Studios",
        Size     = UDim2.fromOffset(400, 200),
        Acrylic  = false,
        Theme    = "Dark",
    })

    task.spawn(function()
        task.wait(0.3)
        Window:Dialog({
            Title   = "Game Not Supported",
            Content = ("This game (%s) is not supported yet.\nCheck back later or request support in our Discord!"):format(gameName),
            Buttons = {
                {
                    Title    = "OK",
                    Callback = function()
                        Window:Destroy()
                    end,
                },
            },
        })
    end)

    warn(("[Loader] Unsupported game: %s (PlaceId %d)"):format(gameName, placeId))
    return
end

print(("[Loader] Detected: %s (PlaceId %d) → loading %s"):format(gameName, placeId, target))

local url = BASE_URL .. target
local ok, result = pcall(function()
    return loadstring(game:HttpGet(url, true))()
end)

if not ok then
    Fluent:Notify({
        Title    = "Loader Error",
        Content  = ("Failed to load script for %s.\nCheck console for details."):format(gameName),
        Duration = 8,
    })
    warn(("[Loader] Failed to load %s\nError: %s"):format(url, tostring(result)))
end
