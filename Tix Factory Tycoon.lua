--i got banned 👍

local library = loadstring(game:HttpGet(('https://raw.githubusercontent.com/Maxgat5/UiLib/main/lua')))()

local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local TeleportService=game:GetService("TeleportService")

local Factories=game:GetService("Workspace")["Fros Studio's Tycoon Kit"].Factories
local localPlayer=Players.LocalPlayer

function GetPlayerReborn(plr)
    if plr then
        return plr.Character.PlayerOverhead.RebornName.Text:gsub("Reborn ",""):sub(1,1)
    else
        return localPlayer.Character.PlayerOverhead.RebornName.Text:gsub("Reborn ",""):sub(1,1)
    end
end

function ChangeChams(enable)
    for _,plr in pairs(Players:GetChildren()) do
        if plr~=localPlayer then
            for _,v in pairs(plr.Character:GetChildren()) do
                if enable then
                    if char:IsA("BasePart") then
                        if not char:FindFirstChild("CHAMS") then
                            local chams=Instance.new("BoxHandleAdornment", char)
                            chams.Name='CHAMS'
                            chams.Parent=char
                            chams.Adornee=char
                            chams.Size=char.Size
                            chams.ZIndex=10
                            chams.AlwaysOnTop=true
                        end
                    end
                else
                    if char:IsA("BasePart") then
                        if char:FindFirstChild("CHAMS") then
                            char.CHAMS:Destroy()
                        end
                    end
                end
            end
        end
    end
end

local Ores={
    "Gold";
    "Gold Block";
    "Forgotten Tix";
}

local Teleports={
    "Garage";
    "Train Station";
    "Warehouse";
    "Forgotten Tix Mine";
    "Vault Door";
    "Chainsaw Factory";
    "Bunker Entrance";
    "Dr. Tix Cave";
}

for _,factory in pairs(Factories:GetChildren()) do
    if factory:FindFirstChild('Owner') and factory:FindFirstChild('Owner2') then
        if factory.Owner2.Value==localPlayer.Name then
            myFactory=factory
        end
    end
end

if not myFactory then
	return print("Please Load The Tycoon First!")
end

local main=library:CreateWindow("Tix Factory Tycoon")
local AutoStuff=main:CreateFolder("Auto Stuff")
local Others=main:CreateFolder("Others")
local Credits=main:CreateFolder("Credits")


------------------------------Auto Stuff Tab
AutoStuff:Toggle("Auto Buy Button", function(bool)
    AutoBuyButtons=bool
end)

AutoStuff:Toggle("Auto Click Tree", function(bool)
    AutoClickTree=bool
end)

AutoStuff:Dropdown("Ores", Ores, true, function(v)
    SelectedOre=v
end)

AutoStuff:Toggle("Collect Ores", function(bool)
    CollectOres=bool
end)

AutoStuff:Toggle("Collect Event Tix", function(bool)
    CollectEventTix=bool
end)


------------------------------Others Tab
Others:Toggle("Chams", function(bool)
    Chams=bool
end)

Others:Button("Rejoin", function()
    TeleportService:Teleport(game.PlaceId, localPlayer)
end)

Others:Box("WalkSpeed","number",function(value)
	localPlayer.Character.Humanoid.WalkSpeed = value
end)

Others:Box("JumpPower","number",function(value)
	localPlayer.Character.Humanoid.JumpPower = value
end)

Others:Dropdown("Teleports", Teleports, true, function(v)
    SelectedTeleport=v
end)

Others:Button("Teleport", function()
    local Garage=CFrame.new(-207.904648, 857.618958, 134.552597)
    local TrainStation=CFrame.new(30.9379864, 857.500122, -812.164795)
    local Warehouse=CFrame.new(150.280426, 857.75116, -2314.2395)
    local ForgottenTixMine=CFrame.new(11.3515043, 837.744263, 959.950867)
    local VaultDoor=CFrame.new(722.939941, 687.584656, 1715.37207)
    local ChainsawFactory=CFrame.new(-296.19043, 857.500122, 410.952637)
    local BunkerEntrance=CFrame.new(520.440796, 878.221252, -1399.03711)
    local DrTixCave=CFrame.new(-603.246582, 860.200012, -284.211884)

   

    if SelectedTeleport then
        local st=SelectedTeleport
        if st=='Garage' then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=Garage}):Play()
        elseif st=='Train Station' then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=TrainStation}):Play()
        elseif st=="Warehouse" then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=Warehouse}):Play()
        elseif st=="Forgotten Tix Mine" then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=ForgottenTixMine}):Play()
        elseif st=="Vault Door" then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=VaultDoor}):Play()
        elseif st=="Chainsaw Factory" then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=ChainsawFactory}):Play()
        elseif st=="Bunker Entrance" then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=BunkerEntrance}):Play()
        elseif st=="Dr. Tix Cave" then
            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(1, Enum.EasingStyle.Quart), {CFrame=DrTixCave}):Play()
        end
    end
end)


------------------------------Credits
Credits:Button("Library Maker ("..game:service("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Maxgat5/Decode/main/JSON")).username..")",function()
	setclipboard(game:service("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Maxgat5/Decode/main/JSON")).username)
end)

Credits:Button("Library Discord Server",function()
	setclipboard(game:service("HttpService"):JSONDecode(game:HttpGet("https://raw.githubusercontent.com/Maxgat5/Decode/main/JSON")).discord)
end)


------------------------------Script
spawn(function()
    while wait() do
        for _,plr in pairs(Players:GetChildren()) do
            if plr~=localPlayer then
                for _,char in pairs(plr.Character:GetChildren()) do
                    if enable then
                        if char:IsA("BasePart") then
                            if not char:FindFirstChild("CHAMS") then
                                local chams=Instance.new("BoxHandleAdornment", char)
                                chams.Name='CHAMS'
                                chams.Parent=char
                                chams.Adornee=char
                                chams.Size=chas.Size
                                chams.ZIndex=10
                                chams.AlwaysOnTop=true
                            end
                        end
                    else
                        if char:IsA("BasePart") then
                            if char:FindFirstChild("CHAMS") then
                                char.CHAMS:Destroy()
                            end
                        end
                    end
                end
            end
        end
    end
end)


spawn(function()
    while wait() do
        local Events=workspace.Game.Events

        for _,v in pairs(Events.Default:GetChildren()) do
            if v.Name~="AAN" then
                for _,tix in pairs(v:GetDescendants()) do
                    if tix:FindFirstChild("TouchInterest") then
                        if CollectEventTix then
                            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(0), {CFrame=tix.CFrame}):Play()
                            wait()
                        end
                    end
                end
            end
        end

        for _,v in pairs(Events.Madness:GetChildren()) do
            if v.Name~="AAN" then
                for _,tix in pairs(v:GetDescendants()) do
                    if tix:FindFirstChild("TouchInterest") then
                        if CollectEventTix then
                            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(0), {CFrame=tix.CFrame}):Play()
                            wait()
                        end
                    end
                end
            end
        end

        for _,v in pairs(Events.Special:GetChildren()) do
            if v.Name~="AAN" then
                for _,tix in pairs(v:GetDescendants()) do
                    if tix:FindFirstChild("TouchInterest") then
                        if CollectEventTix then
                            TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(0), {CFrame=tix.CFrame}):Play()
                            wait()
                        end
                    end
                end
            end
        end
    end
end)

spawn(function()
    while wait() do
        if AutoClickTree then
            if myFactory.PurchasedObjects:FindFirstChild('Click01') then
                fireclickdetector(myFactory.PurchasedObjects.Click01.Button.ClickDetector)
            end
        end
    end
end)

spawn(function()
    while wait() do
        if SelectedOre then
            local so=SelectedOre
                if so=='Gold' then
                    for _,og in pairs(workspace.Game.Ores:GetChildren()) do
                        if og.Name=='Gold_Piece' or og.Name=='Gold_Piece_2' or og.Name=='Gold_Piece_3' then
                            for _,ore in pairs(og:GetChildren()) do
                                if CollectOres then
                                    TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(.125, Enum.EasingStyle.Quart), {CFrame=ore.CFrame}):Play()
                                    wait(.3)
                                end
                        end
                    end
                end
            elseif so=='Gold Block' then
                for _,og in pairs(workspace.Game.Ores:GetChildren()) do
                    if og.Name=='GoldBlocks' then
                        for _,ore in pairs(og:GetChildren()) do
                            if CollectOres then
                                    TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(.125, Enum.EasingStyle.Quart), {CFrame=ore.CFrame}):Play()
                                    wait(.3)
                                end
                        end
                    end
                end
            elseif so=='Forgotten Tix' then
                for _,og in pairs(workspace.Game.Ores:GetChildren()) do
                    if og.Name=='Forgot_Piece' then
                        for _,ore in pairs(og:GetChildren()) do
                            if CollectOres then
                                    TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(.125, Enum.EasingStyle.Quart), {CFrame=ore.CFrame}):Play()
                                    wait(.4)
                                end
                        end
                    end
                end
            end
        end
    end
end)

spawn(function()
    while wait() do
        local Buttons=myFactory.Buttons
         for _,button in pairs(Buttons:GetChildren()) do
            for _,realButton in pairs(button:GetChildren()) do
                if AutoBuyButtons then
                    if realButton:IsA("BasePart") then
                        if realButton.Transparency<=.99 then
                            if realButton.Parent:FindFirstChild("Reborn") then
                                if tonumber(GetPlayerReborn())>=realButton.Parent.Reborn.Value then
                                    TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(.25), {CFrame=realButton.CFrame}):Play()
                                    wait(.25)
                                end
                            else
                                TweenService:Create(localPlayer.Character.HumanoidRootPart, TweenInfo.new(.25), {CFrame=realButton.CFrame}):Play()
                                wait(.25)
                            end
                        end
                    end
                end
            end
        end
    end
end)
