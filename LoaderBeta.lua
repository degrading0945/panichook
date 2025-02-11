local API = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
--
script_id = "eefc5bc05320cf95d0e87add99b06320"
API.script_id = script_id
--
do -- Handling
    local LocalPlayer = cloneref(game:GetService("Players")).LocalPlayer
    --
    if not script_key then
        return LocalPlayer:Kick("missing script key")
    end
    --
    if type(messagebox) ~= "function" then
        return LocalPlayer:Kick("missing function messagebox")
    end
    --
    local Status = API.check_key(script_key)
    if Status == "invalid" then
        return LocalPlayer:Kick("invalid script key")
    end
    --
    if Status.code == "KEY_VALID" then
        if game.GameId == 3747388906 then
            if game.PlaceId == 10228136016 then
                if not isfile("key.dat") then
                    writefile("key.dat", script_key)
                    writefile("script_id.dat", script_id)
                end
                --
                if not isfile("script_id.dat") then
                    writefile("script_id.dat", script_id)
                end
                --
                queue_on_teleport([[
					if not isfile("key.dat") then return end
					if not isfile("script_id.dat") then return end
					--
					local API = loadstring(game:HttpGet("https://sdkapi-public.luarmor.net/library.lua"))()
					API.script_id = readfile("script_id.dat")
					script_key = readfile("key.dat")
					--
					API.load_script()
                    API.purge_cache()
				]])
                --
                return messagebox("Preloaded script, please join a server now", `panichook`, 64)
            else
                return messagebox("Please run the loader script in the fallen lobby", `panichook`, 48)
            end
        else
            API.load_script()
            API.purge_cache()
        end
    elseif Status.code == "KEY_HWID_LOCKED" then
        return messagebox("Key linked to a different HWID. Please contact support to get a reset", `panichook`, 16)
    elseif Status.code == "KEY_INCORRECT" then
        return messagebox("Key is incorrect or does not exist", `panichook`, 16)
    elseif Status.code == "KEY_EXPIRED" then
        return messagebox("Key has expired. Please purchase a new key to continue using panichook", `panichook`, 16)
    elseif Status.code == "KEY_BANNED" then
        return messagebox("Key has been banned", `panichook`, 16)
    elseif Status.code == "KEY_INVALID" then
        return messagebox("Key does not meet format requirements", `panichook`, 16)
    elseif Status.code == "SCRIPT_ID_INCORRECT" then
        return messagebox("Script ID is incorrect. Please contact support", `panichook`, 16)
    elseif Status.code == "SCRIPT_ID_INVALID" then
        return messagebox("Script ID is invalid. Please contact support", `panichook`, 16)
    elseif Status.code == "INVALID_EXECUTOR" then
        return messagebox(
            "Your executor is currently not supported. Contact (discord.gg/luarmor) for more information",
            `panichook`,
            16
        )
    elseif Status.code == "SECURITY_ERROR" then
        return messagebox("Request could not be verified by Cloudflare. Please try again later", `panichook`, 16)
    elseif Status.code == "TIME_ERROR" then
        return messagebox(
            "Client time is incorrect. Please sync your clock\n(Settings -> Date & Time -> Synchronize your clock -> Sync Now)",
            `panichook`,
            16
        )
    else
        return messagebox("An unknown error occurred. Please contact support", `panichook`, 16)
    end
end
