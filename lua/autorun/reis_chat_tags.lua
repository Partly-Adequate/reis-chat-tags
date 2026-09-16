if SERVER then
	AddCSLuaFile()
    AddCSLuaFile("reis_chat_tags/client/cl_init.lua")
else
	include("reis_chat_tags/client/cl_init.lua")
end
