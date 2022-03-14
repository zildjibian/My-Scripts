--[[
Current Games Supported:
- Find the Chomiks
- Find the Cones
- Find the Stickmen
- find the reggies

TODO:
- Find the little guys (7370903084)
- find the ducks (7932407199)
- Find the Markers (7896264844)
]]

if shared.loaded==nil then
    shared.loaded=true
    shared.controlToRunLoaded=false
    
    shared.controlToRun=false
end

local abc
    
if game.PlaceId==8414695951 then
    abc=workspace.badges
elseif game.PlaceId==8376378000 then
    abc=workspace.Stickmen
elseif game.PlaceId==7967866040 then
    abc=workspace['Badges (Reggies)']
else
    abc=workspace.chomiki
end

shared.lplr=game:GetService('Players').LocalPlayer

local UIS=game:GetService('UserInputService')
local TS=game:GetService('TweenService')

shared.config={
    lightMeUp={
        brightness=1;
        range=69;
    };
    
    esp={
        enableESP=true;
        enableChams=true;
        extraChamsTHICCness=.45;
        chamsColor=Color3.fromRGB(255,0,125);
        chamsTransparency=0.7;
        useScale=true; --(scale/size) on BillboardGui
        scale=UDim2.new(7,0,7,0);
        size=UDim2.new(0,50,0,50);
        font=nil; --default: SourceSans
        maxTextRange=nil; --nil for infinity
    };
	
	controlToRun={
		useFOV=true;
		
		runSpeed=24;
		runFOV=80;
		walkSpeed=16;
		walkFOV=70;
	};
}

function LightMeUp()
    if not shared.lplr.Character.HumanoidRootPart:FindFirstChild('Lighter') then
        local a=Instance.new('PointLight', shared.lplr.Character.HumanoidRootPart)
        a.Name='Lighter'
        a.Range=shared.config.lightMeUp.range
        a.Brightness=shared.config.lightMeUp.brightness
    else
       shared.lplr.Character.HumanoidRootPart.Lighter:Destroy() 
    end
end

function ToggleControlToRun()
	shared.controlToRun=not shared.controlToRun
	
    if not shared.controlToRunLoaded then
        shared.controlToRunLoaded=true
		
        local TweenInfo=TweenInfo.new(
            .4,
            Enum.EasingStyle.Quart
        )
            
        UIS.InputBegan:Connect(function(key, gpe)
            if shared.controlToRun then
                if not gpe and key.KeyCode==Enum.KeyCode.LeftControl then
                    TS:Create(workspace.CurrentCamera, TweenInfo, {FieldOfView=shared.config.controlToRun.runFOV}):Play()
                    shared.lplr.Character.Humanoid.WalkSpeed=shared.config.controlToRun.runSpeed
                end
            end
        end)
            
        UIS.InputEnded:Connect(function(key, gpe)
            if shared.controlToRun then
                if not gpe and key.KeyCode==Enum.KeyCode.LeftControl then
                    TS:Create(workspace.CurrentCamera, TweenInfo, {FieldOfView=shared.config.controlToRun.walkFOV}):Play()
                    shared.lplr.Character.Humanoid.WalkSpeed=shared.config.controlToRun.walkSpeed
                end
            end
        end)
    end
end

function ToggleESPAll()
    local function addESP(ins)
        if shared.config.esp.enableChams then
            local bha=Instance.new('BoxHandleAdornment', ins)
            bha.Size=ins.Size+Vector3.new(0,0, shared.config.esp.extraChamsTHICCness)
            bha.Color3=shared.config.esp.chamsColor
            bha.AlwaysOnTop=true
            bha.Transparency=shared.config.esp.chamsTransparency
            bha.Adornee=ins
            bha.ZIndex=1
            bha.AdornCullingMode=Enum.AdornCullingMode.Never
            bha.Name='ABCDEFU'
        end
                
        local bb=Instance.new('BillboardGui', ins)
        
        if shared.config.esp.useScale then
            bb.Size=shared.config.esp.scale
        else
            bb.Size=shared.config.esp.size
        end
        
        bb.AlwaysOnTop=true
        bb.MaxDistance=shared.config.esp.maxTextRange or math.huge
        bb.Name='ChaChaCha'
        local a=Instance.new('TextLabel',bb)
        
        if game.PlaceId==8414695951 then
            a.Text=ins.Name
        elseif game.PlaceId==8376378000 then
            a.Text=ins.Name
        elseif game.PlaceId==7967866040 then
            a.Text=ins.Name
        else
            if bb.Parent:FindFirstChild('ChomikName') then
                a.Text=bb.Parent.ChomikName.Value
            else
                a.Text=ins.Parent.Name
            end
        end
        
        a.Size=UDim2.new(1,0,1,0)
        a.BackgroundTransparency=1
        a.Font=Enum.Font.SourceSans
        a.TextScaled=true
        a.TextColor3=Color3.new(1,1,1)
        a.TextStrokeTransparency=0
    end
    
    if typeof(abc)=='table' then
        for _,v in pairs(abc) do
            if v:IsA('BasePart') then
                if v:FindFirstChild('ChaChaCha') then
                    v.ChaChaCha:Destroy()
                    if v:FindFirstChild('ABCDEFU') then
                        v.ABCDEFU:Destroy()
                    end
                elseif not v:FindFirstChild('ChaChaCha') and shared.config.esp.enableESP then
                    addESP(v)
                end
            end
        end
    elseif typeof(abc)=='Instance' then
        if abc:IsA('Folder') then
            for _,v in pairs(abc:GetChildren()) do
                if v:IsA('BasePart') then
                    if v:FindFirstChild('ChaChaCha') then
                        v.ChaChaCha:Destroy()
                        if v:FindFirstChild('ABCDEFU') then
                            v.ABCDEFU:Destroy()
                        end
                    elseif not v:FindFirstChild('ChaChaCha') and shared.config.esp.enableESP then
                        addESP(v)
                    end
                end
            end
        elseif abc:IsA('BasePart') then
            if abc:FindFirstChild('ChaChaCha') then
                abc.ChaChaCha:Destroy()
                if abc:FindFirstChild('ABCDEFU') then
                    abc.ABCDEFU:Destroy()
                end
            elseif not abc:FindFirstChild('ChaChaCha') and shared.config.esp.enableESP then
                addESP(abc)
            end
        end
    end
end

function CollectALL() --ONLY WORKS IN Find the Chomiks!
	for _,v in pairs(workspace[abc]:GetChildren()) do
		if v:IsA('BasePart') and v.Name~='youareachomik' then
			firetouchinterest(shared.lplr.Character.HumanoidRootPart, v)
			game:GetService('RunService').RenderStepped:Wait()
		end
	end
	firetouchinterest(shared.lplr.Character.HumanoidRootPart, workspace.chomiki.youareachomik)
end
