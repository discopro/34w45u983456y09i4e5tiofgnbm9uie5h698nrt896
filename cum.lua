-- Horrible source

-- DO NOT LOOK

local library = loadstring(game:HttpGet("https://raw.githubusercontent.com/Consistt/Ui/main/UnLeaked"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/Exunys/Aimbot-V2/main/Resources/Scripts/Raw%20Main.lua"))()
getgenv().Aimbot.Settings.Enabled = false
getgenv().Aimbot.FOVSettings.Visible = false

local p = game.Players.LocalPlayer
local c = p.Character
local hrp = c.HumanoidRootPart
local hum = c.Humanoid
local mouse = p:GetMouse()

local trig_weap
local triggerbot = false
local alcheck = false
local tcheck = false
local high_esp = false
local box = false
local CHMSenabled = false
local trace_stat = false

local thick = 0
local outline = 1

local BillboardGui = Instance.new("BillboardGui")
local Frame = Instance.new("Frame")

BillboardGui.Parent = game.Workspace
BillboardGui.Name = "fart"
BillboardGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
BillboardGui.Adornee = game.Workspace
BillboardGui.AlwaysOnTop = true
BillboardGui.LightInfluence = 1.000
BillboardGui.Size = UDim2.new(4, 0, 6, 0)

Frame.Parent = BillboardGui
Frame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Frame.BackgroundTransparency = 0.500
Frame.BorderSizePixel = 0
Frame.Size = UDim2.new(1, 0, 1, 0)
Frame.Visible = false

local COREGUI = game:GetService("CoreGui")
local Players = game.Players

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end


library.version = "1"
library.rank = "User"
local Wm = library:Watermark("AimWare | v" .. library.version ..  " | " .. library:GetUsername() .. " | rank: " .. library.rank)
local FpsWm = Wm:AddWatermark("fps: " .. library.fps)
coroutine.wrap(function()
	while wait(.75) do
		FpsWm:Text("fps: " .. library.fps)
	end
end)()


local Notif = library:InitNotifications()

local LoadingXSX = Notif:Notify("Loading AimWare...", 3, "information") -- notification, alert, error, success, information

library.title = "AimWare"

library:Introduction()
wait(1)
local Init = library:Init()

local Tab1 = Init:NewTab("Combat")
local Tab2 = Init:NewTab("Visuals")
local Tab3 = Init:NewTab("Misc")
local Tab4 = Init:NewTab("Credits")
local Label1 = Tab4:NewLabel("Script made by : bandruf#5735", "ceneter")

local Button1 = Tab3:NewButton("DestroyGui", function()
	library:Remove()
end)

local Section3 = Tab3:NewSection("LocalPlayer")

local Slider1 = Tab3:NewSlider("WalkSpeed", "", true, "/", {min = 16, max = 300, default = 16}, function(value)
	game.Players.LocalPlayer.Character.Humanoid.WalkSpeed = value
end)

local Slider1 = Tab3:NewSlider("JumpPower", "", true, "/", {min = 50, max = 300, default = 50}, function(value)
	game.Players.LocalPlayer.Character.Humanoid.JumpPower = value
end)

local plr = game.Players.LocalPlayer
local mouse = plr:GetMouse()

local Section1 = Tab1:NewSection("Aimbot")
local Section2 = Tab2:NewSection("BoxEsp")

local Toggle2 = Tab2:NewToggle("Box", false, function(bool)
	box = bool

	if bool == false then
		for _,v in pairs(game.Workspace:GetChildren()) do
			if v:FindFirstChild("fart") then
				v:FindFirstChild("fart"):Destroy()
			end
		end
	end
end)

function change()
	for _,v in pairs(game.Workspace:GetDescendants()) do
		if v:IsA("Highlight") then
			if v.Name == "fart" then
				v.FillTransparency = thick
				v.OutlineTransparency = outline
			end
		end
	end
end

local Section3 = Tab2:NewSection("HighlightESP")

local Toggle2 = Tab2:NewToggle("Highlight", false, function(bool)
	high_esp = bool

	if bool == false then
		for _,v in pairs(game.Workspace:GetChildren()) do
			if v:FindFirstChildWhichIsA("Humanoid") then
				if v:FindFirstChildWhichIsA("Highlight") then
					v:FindFirstChildWhichIsA("Highlight"):Destroy()
				end
			end
		end
	end
end)


local Slider1 = Tab2:NewSlider("FillTransparency", "", true, "/", {min = 0, max = 1, default = 1}, function(value)
	thick = value
	change()
end)

local Slider1 = Tab2:NewSlider("OutlineTransparency", "", true, "/", {min = 0, max = 1, default = 1}, function(value)
	outline = value
	change()
end)

local Section3 = Tab2:NewSection("Chams")

function CHMS(plr)
	task.spawn(function()
		for i,v in pairs(COREGUI:GetChildren()) do
			if v.Name == plr.Name..'_CHMS' then
				v:Destroy()
			end
		end
		wait()
		if plr.Character and plr.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(plr.Name..'_CHMS') then
			local ESPholder = Instance.new("Folder")
			ESPholder.Name = plr.Name..'_CHMS'
			ESPholder.Parent = COREGUI
			repeat wait(1) until plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
			for b,n in pairs (plr.Character:GetChildren()) do
				if (n:IsA("BasePart")) then
					local a = Instance.new("BoxHandleAdornment")
					a.Name = plr.Name
					a.Parent = ESPholder
					a.Adornee = n
					a.AlwaysOnTop = true
					a.ZIndex = 10
					a.Size = n.Size
					a.Transparency = 0.3
					a.Color = plr.TeamColor
				end
			end
			local addedFunc
			local teamChange
			local CHMSremoved
			addedFunc = plr.CharacterAdded:Connect(function()
				if CHMSenabled then
					ESPholder:Destroy()
					teamChange:Disconnect()
					repeat wait(1) until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
					CHMS(plr)
					addedFunc:Disconnect()
				else
					teamChange:Disconnect()
					addedFunc:Disconnect()
				end
			end)
			teamChange = plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
				if CHMSenabled then
					ESPholder:Destroy()
					addedFunc:Disconnect()
					repeat wait(1) until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
					CHMS(plr)
					teamChange:Disconnect()
				else
					teamChange:Disconnect()
				end
			end)
			CHMSremoved = ESPholder.AncestryChanged:Connect(function()
				teamChange:Disconnect()
				addedFunc:Disconnect()
				CHMSremoved:Disconnect()
			end)
		end
	end)
end

local Toggle2 = Tab2:NewToggle("Chams", false, function(bool)
	CHMSenabled = bool

	if bool == true then
		for _,v in pairs(game.Players:GetChildren()) do
			CHMS(v)
		end
	end
end)


--"left", "center", "right"

local Toggle1 = Tab1:NewToggle("Aimbot", false, function(value)
	getgenv().Aimbot.Settings.Enabled = value
end)

local Toggle1 = Tab1:NewToggle("FOV Circle", false, function(bool)
	getgenv().Aimbot.FOVSettings.Visible = bool
end)

local Toggle1 = Tab1:NewToggle("FOV Circle Filled", false, function(bool)
	getgenv().Aimbot.FOVSettings.Filled = bool
end)

local Toggle1 = Tab1:NewToggle("TeamCheck", false, function(bool)
	getgenv().Aimbot.Settings.TeamCheck = bool
end)

local Toggle1 = Tab1:NewToggle("AliveCheck", false, function(bool)
	getgenv().Aimbot.Settings.AliveCheck = bool
end)

local Toggle1 = Tab1:NewToggle("WallCheck", false, function(bool)
	getgenv().Aimbot.Settings.WallCheck = bool
end)

local Toggle1 = Tab1:NewToggle("ThirdPerson", false, function(bool)
	getgenv().Aimbot.Settings.ThirdPerson = bool
end)

local Slider1 = Tab1:NewSlider("FOV", "", true, "/", {min = 50, max = 500, default = 190}, function(value)
	getgenv().Aimbot.FOVSettings.Amount = value
end)

local Slider1 = Tab1:NewSlider("FOV Circle Thickness", "", true, "/", {min = 0.1, max = 100, default = 1}, function(value)
	getgenv().Aimbot.FOVSettings.Thickness = value
end)

local Label1 = Tab1:NewLabel("Aimbot powered by AimbotV2", "left")

local FinishedLoading = Notif:Notify("Loaded AimWare", 4, "success")
game.Players.PlayerRemoving:Connect(function(player)
	if CHMSenabled == true then
		for i,v in pairs(COREGUI:GetChildren()) do
			if v.Name == player.Name..'_ESP' or v.Name == player.Name..'_LC' or v.Name == player.Name..'_CHMS' then
				v:Destroy()
			end
		end
	end
end)

Players.PlayerAdded:Connect(function(plr)
	if CHMSenabled then
		repeat wait(1) until plr.Character and getRoot(plr.Character)
		CHMS(plr)
	end
end)

game:GetService("RunService").Heartbeat:Connect(function()
	if triggerbot == true then
		if mouse.Target then
			if mouse.Target.Parent:FindFirstChild("Humanoid") then
				print(mouse.Target.Parent)
				if tcheck == false and alcheck == false then
					trig_weap:Activate()
				end
			end
		end
	end
	if high_esp == true then
		for _,v in pairs(game.Workspace:GetChildren()) do
			if v:FindFirstChildWhichIsA("Humanoid") then
				if not v:FindFirstChildWhichIsA("Highlight") then
					local h = Instance.new("Highlight",v)
					h.Name = "penis"
					h.FillTransparency = thick
					h.OutlineTransparency = outline

					if game.Players:FindFirstChild(v.Name) then
						h.FillColor = game.Players:FindFirstChild(v.Name).TeamColor.Color
					end
				end
			end
		end
	end
	if box == true then
		for _,v in pairs(game.Workspace:GetChildren()) do
			if game.Players:FindFirstChild(v.Name) then
				if v.Name ~= game.Players.LocalPlayer.Name then
					if not v:FindFirstChild("fart") then
						local c = BillboardGui:Clone()
						c.Parent = v
						c.Adornee = v.HumanoidRootPart
						c.Frame.Visible = true
						c.Frame.BackgroundColor3 = game.Players:FindFirstChild(v.Name).TeamColor.Color
					end
				end
			end
		end
	end
end)
