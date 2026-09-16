
local GMOnPlayerChat
local ChatAddText

local prefix = {}

local function OnPlayerChat(self, ply, strText, bTeam, bDead)
    prefix = {Color(255, 100, 100, 255), "hello", " "} -- prepare player prefix
    local result = GMOnPlayerChat(self, ply, strText, bTeam, bDead);
    if (result) then
        return true
    end
end

local function isplayer(value)
    return isentity(value) && value:IsPlayer()
end

local function AddText(...)
    local text = {...}
    local args = {}
    local index = 0

    for i = 1, #text do
        index = i
        if(isplayer(text[i])) then
            table.Add(args, prefix)
            break
        end
        table.insert(args, text[i])
    end

    prefix = {} -- consume player prefix

    for i = index, #text do
        table.insert(args, text[i])
    end

    ChatAddText(unpack(args))
end

hook.Add("OnGamemodeLoaded", "RCT_OnGamemodeLoaded", function()
    GMOnPlayerChat = gmod.GetGamemode().OnPlayerChat
    gmod.GetGamemode().OnPlayerChat = OnPlayerChat

    ChatAddText = chat.AddText
    chat.AddText = AddText
end)
