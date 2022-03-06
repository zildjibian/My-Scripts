if shared.loaded==nil then
    shared.loaded=true
    shared.controlToRunLoaded=false
    
    shared.controlToRun=false
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
        scale=UDim2.new(15,0,15,0);
        size=UDim2.new(0,50,0,50);
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

function ToggleESPAllChomik()
    local abc='chomiki'
    
    if game.PlaceId==8414695951 then
        abc='badges'
    end
    
    for _,v in pairs(workspace[abc]:GetChildren()) do
        if v:IsA('BasePart') then
            if v:FindFirstChild('ChaChaCha') then
                v.ChaChaCha:Destroy()
                if v:FindFirstChild('ABCDEFU') then
                    v.ABCDEFU:Destroy()
                end
            elseif not v:FindFirstChild('ChaChaCha') and shared.config.esp.enableESP then
                if shared.config.esp.enableChams then
                    local bha=Instance.new('BoxHandleAdornment', v)
                    bha.Size=v.Size+Vector3.new(0,0, shared.config.esp.extraChamsTHICCness)
                    bha.Color3=shared.config.esp.chamsColor
                    bha.AlwaysOnTop=true
                    bha.Transparency=shared.config.esp.chamsTransparency
                    bha.Adornee=v
                    bha.ZIndex=1
                    bha.AdornCullingMode=Enum.AdornCullingMode.Never
                    bha.Name='ABCDEFU'
                end
                
                local bb=Instance.new('BillboardGui', v)
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
                    a.Text=v.Name
                else
                    a.Text=bb.Parent.ChomikName.Value
                end
                a.Size=UDim2.new(1,0,1,0)
                a.BackgroundTransparency=1
                a.TextScaled=true
                a.TextColor3=Color3.new(1,1,1)
                a.TextStrokeTransparency=0
            end
        end
    end
end

function CollectALLChomiks()
	for _,v in pairs(workspace.chomiki:GetChildren()) do
		if v:IsA('BasePart') and v.Name~='youareachomik' then
			firetouchinterest(shared.lplr.Character.HumanoidRootPart, v)
			game:GetService('RunService').RenderStepped:Wait()
		end
	end
	firetouchinterest(shared.lplr.Character.HumanoidRootPart, workspace.chomiki.youareachomik)
end
