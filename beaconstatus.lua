local ReplicatedStorage = game:GetService("ReplicatedStorage")
local BeaconA_Status = ReplicatedStorage:FindFirstChild("BeaconA_Status")
local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")
local TextLabel = script.Parent

TextLabel.Text = "A"
GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true then
		wait(11)
		TextLabel.Visible = true
	else
		TextLabel.Visible = false
	end
end)

BeaconA_Status:GetPropertyChangedSignal("Value"):Connect(function()
	if BeaconA_Status.Value == "Blue" then
		TextLabel.BackgroundColor3 = Color3.fromRGB(0,0,255)
		--print("Beacon A gui updated")
	elseif BeaconA_Status.Value == "Red" then
		TextLabel.BackgroundColor3 = Color3.fromRGB(255,0,0)
		--print("Beacon A gui updated")
	else
		TextLabel.BackgroundColor3 = Color3.fromRGB(255,255,255)
		--print("Beacon A gui updated")
	end
	
end)