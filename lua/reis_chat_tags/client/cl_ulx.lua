local ulx_namespace = reis_chat_tags.setting_namespace:AddChild("ulx")

local function AddULXTag(group, text, color)
    local group_namespace = ulx_namespace:AddChild(group)
    group_namespace:AddSetting("color", pacoman.TYPE_COLOR, color, "The color of the ".. group .." tag.")
    group_namespace:AddSetting("text", pacoman.TYPE_STRING, text, "The text of the ".. group .." tag.")
end

for k, v in SortedPairs(CAMI.GetUsergroups()) do
    AddULXTag(k, "", Color(255,255,255))
end

hook.Add("RCT_GetChatTag", "GetChatTag", function(ply)
    local group_namespace = ulx_namespace:GetChild(ply:GetUserGroup())
    if not group_namespace then return end

    local color_setting = group_namespace:GetSetting("color")
    if not color_setting then return end

    local text_setting = group_namespace:GetSetting("text")
    if not text_setting then return end

    local color = color_setting:GetActiveValue()
    local text = text_setting:GetActiveValue()

    if(text != "") then
        return {color, text, " "}
    end
end)
