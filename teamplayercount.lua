
local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")
local TeamCount = ReplicatedStorage:WaitForChild("TeamCount")
local TeamEliminated = ReplicatedStorage:WaitForChild("TeamEliminated")

local NumBlueTeam = 0
local NumRedTeam = 0
local BreakLoop = false

ReplicatedStorage:FindFirstChild("TimeUp").OnInvoke = function()
	print("timeup signal recieved")
	BreakLoop = true
	
	if NumBlueTeam < NumRedTeam then
		return "Blue"
	elseif NumBlueTeam > NumRedTeam then
		return "Red"
	else
		return "Tie"
	end
end

ReplicatedStorage:FindFirstChild("BeaconBarEmpty").Event:Connect(function()
	print("beaconbarempty signal recieved")
	BreakLoop = true
end)

GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true or BreakLoop == true then
		if BreakLoop == false then
			wait(11)
		end
		while wait() do
			if BreakLoop == true then
				break
			end
			NumBlueTeam = 0
			NumRedTeam = 0
			for i, player in pairs(Players:GetChildren()) do
				if player:FindFirstChild("BlueTag") or player:FindFirstChild("RedTag") then
					if player:FindFirstChild("BlueTag") then
						NumBlueTeam = NumBlueTeam + 1
					else
						NumRedTeam = NumRedTeam + 1
					end
				end
			end
			TeamCount:FireAllClients(NumBlueTeam, NumRedTeam)
			--print("fired")
			if NumBlueTeam == 0 then
				TeamEliminated:Fire("Blue")
				print("teameliminated fired")
				break
			elseif NumRedTeam == 0 then
				TeamEliminated:Fire("Red")
				print("teameliminated fired")
				break
			end
		end
	end
	BreakLoop = false
end)

	
	
