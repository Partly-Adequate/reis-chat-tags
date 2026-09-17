require("pacoman")

reis_chat_tags = {}
reis_chat_tags.setting_namespace = pacoman.client_settings:AddChild("chat_tags")

local GMOnPlayerChat
local ChatAddText
local prefix = {}

hook.Add("RCT_GetChatTag", "GetChatTag", function(ply)
    return {}
end)

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
            table.Add(args, hook.Run("RCT_GetChatTag", text[i]))
        end
        table.insert(args, text[i])
    end

    ChatAddText(unpack(args))
end

hook.Add("InitPostEntity", "RCT_InitPostEntity", function()
    ChatAddText = chat.AddText
    chat.AddText = AddText

    if(ulx) then
	    include("reis_chat_tags/client/cl_ulx.lua")
    end
end)
