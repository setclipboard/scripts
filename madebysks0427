_G.ScriptToggles = {
    Music = {
        Enabled = true,
        Set = function(state)
            _G.ScriptToggles.Music.Enabled = (state == true)
            print("Music is now " .. (_G.ScriptToggles.Music.Enabled and "ENABLED" or "DISABLED"))
        end,
        Toggle = function()
            _G.ScriptToggles.Music.Set(not _G.ScriptToggles.Music.Enabled)
        end
    }
}

local Scripts = {
    Main = "https://raw.githubusercontent.com/setclipboard/scripts/refs/heads/8282282929281918181818292929292929292292222/Main.lua",
    Ult = "https://raw.githubusercontent.com/setclipboard/scripts/refs/heads/8282282929281918181818292929292929292292222/ult.lua",
    Music = "https://raw.githubusercontent.com/setclipboard/scripts/refs/heads/8282282929281918181818292929292929292292222/Handler.lua"
}

local function loadScript(url)
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)

    if not success or not content then
        warn("Error fetching script from:", url)
        warn(content) 
        return false
    end

    local func, err = loadstring(content)
    if not func then
        warn("Error loading script from:", url)
        warn(err)
        return false
    end
    
    local execSuccess, execErr = pcall(func)
    if not execSuccess then
        warn("Error executing script from:", url)
        warn(execErr)
        return false
    end
    
    return true
end

local function loadToggleableMusic(url)
    local success, content = pcall(function()
        return game:HttpGet(url)
    end)

    if not success or not content then
        warn("Error fetching music script from:", url)
        warn(content)
        return false
    end

    local originalConnection = "RunService.Stepped:Connect(function()"
    local modifiedConnection = "RunService.Stepped:Connect(function() if not _G.ScriptToggles.Music.Enabled then return end"

    local modifiedContent = content:gsub(originalConnection, modifiedConnection, 1)

    local func, err = loadstring(modifiedContent)
    if not func then
        warn("Error loading modified music script from:", url)
        warn(err)
        return false
    end

    local execSuccess, execErr = pcall(func)
    if not execSuccess then
        warn("Error executing modified music script from:", url)
        warn(execErr)
        return false
    end
    
    return true
end

loadScript(Scripts.Main)
loadScript(Scripts.Ult)

if loadToggleableMusic(Scripts.Music) then
    print("Music loaded. Toggle with 'ScriptToggles.Music:Toggle()'")
else
    warn("The music script could not be loaded.")
end
