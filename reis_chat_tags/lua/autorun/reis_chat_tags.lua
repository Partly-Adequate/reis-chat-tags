if SERVER then
    AddCSLuaFile("reis_chat_tags/client/cl_init.lua")
    AddCSLuaFile("reis_chat_tags/client/cl_ulx.lua")
else
    include("reis_chat_tags/client/cl_init.lua")
end
