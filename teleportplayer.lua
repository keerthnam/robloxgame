local CurrentMap
local ChosenBeacon
local BeaconLocation

game.ReplicatedStorage:WaitForChild("TeleportPlayer").OnServerEvent:Connect(function(player, SelectedSpawn)
	
	--print("teleport player signal recieved")
	--get beacon position
	CurrentMap = game.ReplicatedStorage:FindFirstChild("CurrentMap").Value
	ChosenBeacon = SelectedSpawn:gsub('%s+', '')
	BeaconLocation = game.Workspace:FindFirstChild(CurrentMap):FindFirstChild(ChosenBeacon):FindFirstChild("BeaconBound").Position
	
	--teleport player root part to beacon position
	player.Character.HumanoidRootPart.CFrame = CFrame.new(BeaconLocation) + Vector3.new(20,5,20)
	--print("event executed")
end)