
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")
local BeaconBarDepleting = ReplicatedStorage:WaitForChild("BeaconBarDepleting")

local BeaconA_Status = ReplicatedStorage:WaitForChild("BeaconA_Status")
local BeaconB_Status = ReplicatedStorage:WaitForChild("BeaconB_Status")
local BeaconC_Status = ReplicatedStorage:WaitForChild("BeaconC_Status")
local BeaconD_Status = ReplicatedStorage:WaitForChild("BeaconD_Status")
local BeaconE_Status = ReplicatedStorage:WaitForChild("BeaconE_Status")

local BlueBarProgress = ReplicatedStorage:WaitForChild("BlueBarProgress").Value
ReplicatedStorage.BlueBarProgress.Value = 500 --size offset of beacon bar frame
local RedBarProgress = ReplicatedStorage:WaitForChild("RedBarProgress").Value
ReplicatedStorage.RedBarProgress.Value = 500

local BeaconStatus = {}
local NumBlueBeacons = 0
local NumRedBeacons = 0

local BreakLoop = false

ReplicatedStorage:FindFirstChild("TimeUp").OnInvoke = function()
	print("timeup signal recieved")
	BreakLoop = true
end

ReplicatedStorage:FindFirstChild("TeamEliminated").Event:Connect(function(losingTeam)
	print("teameliminated signal recieved by beaconbar script")
	BreakLoop = true
end)
--once the game is ongoing, constantly update number of beacons each team has and deplete beacon 
--bar size accordingly, send that input to localscript to update the beacon bar 
GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true or BreakLoop == true then
		if ReplicatedStorage:WaitForChild("GameMode").Value == "Domination" or ReplicatedStorage:WaitForChild("GameMode").Value == "Beacon Rush" then
			while wait(0.3) do 
				if BreakLoop == true then
					break
				end
				BeaconStatus = {
				BeaconA_Status.Value,
				BeaconB_Status.Value,
				BeaconC_Status.Value,
				BeaconD_Status.Value,
				BeaconE_Status.Value,
				}
				NumBlueBeacons = 0
				NumRedBeacons = 0
				for i, status in pairs(BeaconStatus) do
					--print(i.." is "..status)
					if status == "Blue" then
						NumBlueBeacons = NumBlueBeacons + 1
					elseif status == "Red" then
						NumRedBeacons = NumRedBeacons + 1
					end
				end
				--print("Blue team now has "..NumBlueBeacons.." beacons")
				--print("Red team now has "..NumRedBeacons.." beacons")
				
				if NumBlueBeacons > NumRedBeacons then
					print("Red team's beacon bar is depleting")
					ReplicatedStorage.RedBarProgress.Value = ReplicatedStorage.RedBarProgress.Value - 1
					BeaconBarDepleting:FireAllClients("Red",ReplicatedStorage.RedBarProgress.Value)
					
					if ReplicatedStorage.RedBarProgress.Value <= 0 then
						print("Game Over! Red team lost")
						ReplicatedStorage:FindFirstChild("BeaconBarEmpty"):Fire("Red")
						break
					end
				elseif NumRedBeacons > NumBlueBeacons then
					--print("Blue team's beacon bar is depleting")
					ReplicatedStorage.BlueBarProgress.Value = ReplicatedStorage.BlueBarProgress.Value - 1
					BeaconBarDepleting:FireAllClients("Blue",ReplicatedStorage.BlueBarProgress.Value)
					
					if ReplicatedStorage.BlueBarProgress.Value <= 0 then
						print("Game Over! Blue team lost")
						ReplicatedStorage:FindFirstChild("BeaconBarEmpty"):Fire("Blue")
						break
					end
				end
			end
		end
		
		BreakLoop = false
		--reset bar progress values
		ReplicatedStorage.BlueBarProgress.Value = 500
		ReplicatedStorage.RedBarProgress.Value = 500
	end
end)