local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService = game:GetService("UserInputService")

local GameOngoing = ReplicatedStorage:FindFirstChild("GameOngoing")

local Bar = script.ScreenGui.Background
local Frame = Bar.Frame
local DisplayNum = Bar.TextLabel
local Health
local Humanoid = Player.Character:WaitForChild("Humanoid")
local CoolDown = false

if GameOngoing.Value == true then
	Bar.Visible = true
end

GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true then
		wait(11)
		Bar.Visible = true
	else
		wait(3)
		Bar.Visible = false
	end
end)

UserInputService.InputBegan:Connect(function(Input, IsTyping)
	if not IsTyping then
		if Input.KeyCode == Enum.KeyCode.H and CoolDown == false then
			CoolDown = true
			ReplicatedStorage:FindFirstChild("ModuleActivated"):FireServer()
			print("module activated")
			wait(15)
			CoolDown = false
		end
	end
end)

while wait(0.2) do
	Health = Humanoid.Health
	DisplayNum.Text = math.floor(Health).."/500"
	Frame.Size = UDim2.new(Health/500,0,1,0) --divide by max health for the correct ratio
end
