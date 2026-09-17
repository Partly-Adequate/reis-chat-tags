require("pacoman")

reis_chat_tags = {}
reis_chat_tags.setting_namespace = pacoman.client_settings:AddChild("chat_tags")
local player_messages_only = reis_chat_tags.setting_namespace:AddSetting("player_messages_only", pacoman.TYPE_BOOLEAN, true, "If set to true, it will only add chat-tags in player written messages.")
local enabled = reis_chat_tags.setting_namespace:AddSetting("enabled", pacoman.TYPE_BOOLEAN, true, "Will only display tags when set to true.")

local ChatAddText
local GMOnPlayerChat
local is_player_message = false

hook.Add("RCT_GetChatTag", "GetChatTag", function(ply)
    return {}
end)

local function isplayer(value)
    return isentity(value) && value:IsPlayer()
end

local function AddText(...)
    if(not enabled:GetActiveValue()) then
        ChatAddText(...)
        is_player_message = false
        return
    end
    if (player_messages_only:GetActiveValue() and not is_player_message) then
        ChatAddText(...)
        return
    end

    local text = {...}
    local args = {}

    for i = 1, #text do
        if(isplayer(text[i])) then
            table.Add(args, hook.Run("RCT_GetChatTag", text[i]))
        end
        table.insert(args, text[i])
    end

    is_player_message = false
    ChatAddText(unpack(args))
end

local function OnPlayerChat(self, ply, strText, bTeam, bDead)
    is_player_message = true

    if GMOnPlayerChat(self, ply, strText, bTeam, bDead) then
        return true
    end
end

hook.Add("InitPostEntity", "RCT_InitPostEntity", function()
    ChatAddText = chat.AddText
    chat.AddText = AddText

    GMOnPlayerChat = gmod.GetGamemode().OnPlayerChat
    gmod.GetGamemode().OnPlayerChat = OnPlayerChat

    if(ulx) then
	    include("reis_chat_tags/client/cl_ulx.lua")
    end
end)
