local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameOngoing = ReplicatedStorage:FindFirstChild("GameOngoing")
local GameMode = ReplicatedStorage:WaitForChild("GameMode")
local BeaconBarDepleting = ReplicatedStorage:FindFirstChild("BeaconBarDepleting")
local BlueBarProgress = ReplicatedStorage:FindFirstChild("BlueBarProgress").Value
local RedBarProgress = ReplicatedStorage:FindFirstChild("RedBarProgress").Value

--make gui visible if player respawns in middle of the round
if GameOngoing.Value == true then
	script.ScreenGui.BlueBar.Visible = true
	script.ScreenGui.RedBar.Visible = true
	script.ScreenGui.BlueBar.Frame.Size = UDim2.new(0,BlueBarProgress,0,20)
	script.ScreenGui.RedBar.Frame.Size = UDim2.new(0,RedBarProgress,0,20)
end

--make beacon bars visible when round starts
GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true and (ReplicatedStorage:FindFirstChild("GameMode").Value == "Domination" or ReplicatedStorage:FindFirstChild("GameMode").Value == "Beacon Rush") then
		wait(11)
		script.ScreenGui.BlueBar.Visible = true
		script.ScreenGui.RedBar.Visible = true
	else
		wait(3)
		script.ScreenGui.BlueBar.Visible = false
		script.ScreenGui.RedBar.Visible = false
	end
end)

--update beacon bar using input from server script
BeaconBarDepleting.OnClientEvent:Connect(function(Team,BarProgress)
	--print("event fired")
	if Team == "Blue" then
		script.ScreenGui.BlueBar.Frame.Size = UDim2.new(0,BarProgress,0,20)
	else
		script.ScreenGui.RedBar.Frame.Size = UDim2.new(0,BarProgress,0,20)
	end
	
end)
