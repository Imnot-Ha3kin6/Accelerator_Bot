local config = _G.AccelerateLoader  
    
--[[for _,v in pairs(keys) do
    if(v == config.WhitelistKey) then
        whitelisted = true
    end
end]]--

if(config.WhitelistKey == "pineapple24") then whitelisted = true end

if(whitelisted == false) then
    messagebox("ERROR wrong key m8", "Accelerator", 0)
    error("wrong key m8")
    return
end

if(_G.AcceleratorLoaded == true) then
    messagebox("Make sure you only execute Accelerator once.", "Accelerator", 0)
    error("Make sure you only execute Accelerator once.")
    return
else
    print("Accelerator loading...")
    _G.AcceleratorLoaded = true 
end

if game.PlaceId ~= 2788229376 then
    messagebox("You are not in the correct game, please ensure you are in 'Da Hood'.", "Accelerator", 0)
    error("You are not in the correct game, please ensure you are in 'Da Hood'.")
    return
end

setfpscap(5)
game:GetService("RunService"):Set3dRenderingEnabled(false)

print("Loading Commands...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/Imnot-Ha3kin6/Accelerator_Bot/main/Commands.lua"))()
print("Commands Loaded!")

local VirtualUser = game:GetService("VirtualUser")
game:GetService("Players").LocalPlayer.Idled:connect(function()
    VirtualUser:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    wait(1)
    VirtualUser:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

repeat wait() until game:IsLoaded() and game.Players.LocalPlayer.Character ~= nil

print("Loading Command Handler...")

function Command(player, msg)
     cmd = string.split(msg," ")
     print("Controller chatted: " .. cmd[1])
     if(string.sub(string.lower(cmd[1]),1,1) == config.Prefix) then
          cmd1 = string.lower(cmd[1]):gsub(config.Prefix, "")
         if(_G.Acceleratorcmds[cmd1] ~= nil) then
             print("Running Command " .. cmd1 .. "...")
             _G.Acceleratorcmds[cmd1]({cmd[2], cmd[3], cmd[4], cmd[5], cmd[6], cmd[7], cmd[8], cmd[9], cmd[10], cmd[11]}, player)
         end
     end
end

game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.OnMessageDoneFiltering.OnClientEvent:Connect(function(Data)
    local Player = game:GetService("Players")[Data.FromSpeaker]
    local Message = Data.Message
    local Channel = Data.OriginalChannel
        
     for _,v in pairs(config.Controllers) do
       if(tostring(Player.UserId) == tostring(v)) then
              Command(Player, Message)
        end
    end
end)

print("Command Handler ready.")

print("Loading Libraries...")
loadstring(game:HttpGet("https://raw.githubusercontent.com/PickleIsDaBest/Min/main/Skript"))()
print("Libraries loaded.")
print("Acclerator loaded!")

game.StarterGui:SetCore("SendNotification", {
        Title = "Accelerator";
        Text = "Accelerator has loaded!";
        Duration = 10;
    })
