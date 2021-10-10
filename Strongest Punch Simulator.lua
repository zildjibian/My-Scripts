--//VARIABLES//--
local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Maxgat5/UiLib/main/lua')))()

local WORLD=0
local POWER=0
local LocalPlayer=game:GetService("Players").LocalPlayer
--


--PlayerStats
spawn(function()
    while wait() do
        WORLD=LocalPlayer.leaderstats.WORLD.Value
        POWER=LocalPlayer.leaderstats.POWER.Value
    end
end)
--


--//MAIN GUI//--
local MAIN=library:CreateWindow("STRONGEST PUNCH SIMULATOR")
local AutoFarm=MAIN:CreateFolder("Auto Farm")
local Other=MAIN:CreateFolder("Other")

AutoFarm:Toggle("Auto Collect Orbs", function(bool)
    Auto_Collect_Orb=bool
end)

Other:Toggle("Orb ESP", function(bool)
    Orb_ESP=bool
end)
--


--//SCRIPTS//--


--Auto Collect Orbs
spawn(function()
    while wait() do
        if Auto_Collect_Orb then
            for _,orb in pairs(workspace.Map.Stages.Boosts[LocalPlayer.leaderstats.WORLD.Value]:GetDescendants()) do
                if orb:FindFirstChild("TouchInterest") then
                    if Auto_Collect_Orb then
                        firetouchinterest(LocalPlayer.Character:WaitForChild("HumanoidRootPart"), orb)
                        wait(math.random(100,2000)/1000)--0.1 Seconds to 2 Seconds
                    end
                end
            end
        end
    end
end)

--Orb ESP
spawn(function()
    while wait() do
            for _,orb in pairs(workspace.Map.Stages.Boosts:GetDescendants()) do
                if orb:FindFirstChild('TouchInterest') then
                    if Orb_ESP then
                        if not orb:FindFirstChild("ESP") then
                            local esp=Instance.new("SphereHandleAdornment", orb)
                            esp.Name="ESP"
                            esp.AlwaysOnTop=true
                            esp.ZIndex=10
                            esp.Adornee=orb
                            esp.Transparency=.4
                            esp.Radius=orb.Size.X/2
                        end
                    else
                        if orb:FindFirstChild("ESP") then
                            orb.ESP:Destroy()
                        end
                    end
                end
            end
            wait(2)
    end
end)
--
