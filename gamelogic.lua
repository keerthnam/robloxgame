local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local GameStatus = ReplicatedStorage:WaitForChild("GameStatus")
local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")
local GameMode = ReplicatedStorage:WaitForChild("GameMode")
local CurrentMap = ReplicatedStorage:WaitForChild("CurrentMap")
local NameTag = ServerStorage:WaitForChild("NameTag")
local Maps = ServerStorage:WaitForChild("Maps")

local GameLength = 120
local IntermissionLength = 5
local TimeToStartRound = 5

local ModeMaps
local GameModeNum
local EndGame 
local LosingTeam 
local WinningTeam
local ChosenMap
local CloneMap
local Count
local BlueTeam
local RedTeam
local BlueSpawnPos
local RedSpawnPos
local LosingTeamOnTimeUp

--reward variables
local WinningTeamDefaultReward = 10000
local LosingTeamDefaultReward = 3000
local RewardPerKill = 1000

--game loop
while true do
	
	--reset some values
	LosingTeam = ""
	WinningTeam = ""
	EndGame = false
	
	--wait for enough players to join the game
	if Players.NumPlayers < 1 then
		GameStatus.Value = "Waiting for enough players"
		repeat
			wait(2)
		until Players.NumPlayers >= 2
	end

	--start the round
	GameStatus.Value = "Intermission"
	wait(IntermissionLength)
	
	for i = TimeToStartRound, 0, -1 do
		GameStatus.Value = "Next round will begin in "..i
		wait(1)
	end
	
	--pick game mode
	GameModeNum = 3 --math.random(1,3)
	if GameModeNum == 1 then
		GameMode.Value = "Domination"
		ModeMaps = Maps:FindFirstChild("DominationMode"):GetChildren()
	elseif GameModeNum == 2 then
		GameMode.Value = "Team Deathmatch"
		ModeMaps = Maps:FindFirstChild("TeamDeathmatchMode"):GetChildren()
	elseif GameModeNum == 3 then
		GameMode.Value = "Beacon Rush"
		ModeMaps = Maps:FindFirstChild("BeaconRushMode"):GetChildren()
	end
	GameStatus.Value = "Next Mission: ".. GameMode.Value
	wait(4)
	
	--pick and import a map 
	ChosenMap = ModeMaps[math.random(1,#ModeMaps)]
	CurrentMap.Value = ChosenMap.Name
	GameStatus.Value = "Map: "..ChosenMap.Name
	CloneMap = ChosenMap:Clone()
	CloneMap.Parent = game.Workspace
	wait(4)
	--print("Currently playing on "..CurrentMap.Value)
	
	--split players into teams (for teammode) 
	Count = true
	BlueTeam = {}
	RedTeam = {}
	
	for i, player in pairs(Players:GetChildren()) do
		if Count == true then
			table.insert(BlueTeam, #BlueTeam + 1, player)
			--print(player.Name.." is in the blue team")
			Count = false
		else
			table.insert(RedTeam, #RedTeam + 1, player)
			--print(player.Name.." is in the red team")
			Count = true
		end
	end
	--print("All players have been put into teams")
	
	GameOngoing.Value = true
	
	--teleport players to the corresponding spawns and give nametags
	BlueSpawnPos = CloneMap.BlueBase.Blue.Position
	RedSpawnPos = CloneMap.RedBase.Red.Position
	
	for i, player in pairs(BlueTeam) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character.HumanoidRootPart.CFrame = CFrame.new(BlueSpawnPos) + Vector3.new(0,5,0)
			player.Team = game.Teams.Blue
			player.Character.Head.NameTag.TextLabel.TextColor3 = Color3.fromRGB(0,128,255)
			player:FindFirstChild("KillCount").Value = 0
			local BlueTag = Instance.new("BoolValue")
			BlueTag.Name = "BlueTag"
			BlueTag.Parent = player
			local NumLives = Instance.new("IntValue")
			NumLives.Name = "NumLives"
			NumLives.Value = 5
			NumLives.Parent = player
			player.Character:FindFirstChild("Humanoid").WalkSpeed = 0
		end
	end
	
	for i, player in pairs(RedTeam) do
		if player.Character and player.Character:FindFirstChild("HumanoidRootPart") and player.Character:FindFirstChild("Humanoid") then
			player.Character.HumanoidRootPart.CFrame = CFrame.new(RedSpawnPos) + Vector3.new(0,5,0)
			player.Team = game.Teams.Red
			player.Character.Head.NameTag.TextLabel.TextColor3 = Color3.fromRGB(255,0,0)
			player:FindFirstChild("KillCount").Value = 0
			local RedTag = Instance.new("BoolValue")
			RedTag.Name = "RedTag"
			RedTag.Parent = player
			local NumLives = Instance.new("IntValue")
			NumLives.Name = "NumLives"
			NumLives.Value = 5
			NumLives.Parent = player
			player.Character:FindFirstChild("Humanoid").WalkSpeed = 0
		end
	end
	--print("All players have been teleported")
	wait(11) --time for loading gui to complete
	
	--give players time to equip weapons and enable them to move
	for i = 3, 0, -1 do
		GameStatus.Value = "Time to equip weapons: "..i
		wait(1)
	end
	
	for i, player in pairs(BlueTeam) do
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character:FindFirstChild("Humanoid").WalkSpeed = 16
		end
	end
	
	for i, player in pairs(RedTeam) do
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			player.Character:FindFirstChild("Humanoid").WalkSpeed = 16
		end
	end
	
	--end game event
	ReplicatedStorage:FindFirstChild("BeaconBarEmpty").Event:Connect(function(losingTeam)
		--print("signal recieved")
		EndGame = true
		LosingTeam = losingTeam
	end)
	
	ReplicatedStorage:FindFirstChild("TeamEliminated").Event:Connect(function(losingTeam)
		print("teameliminated signal recieved by gamelogic script")
		EndGame = true
		LosingTeam = losingTeam
	end)
	--countdown timer
	for i = GameLength, 0, -1 do
		
		if i % 60 == 0 then
			GameStatus.Value = (math.floor(i/60))..":00"
		elseif i % 60 < 10 then
			GameStatus.Value = (math.floor(i/60))..":0"..(i%60)
		else
			GameStatus.Value = (math.floor(i/60))..":"..(i%60)
		end
		
		--update team tables every second
		for x, player in pairs(BlueTeam) do
			if not player.Character then
				table.remove(BlueTeam,x)
				print(player.Name.." left the game")
			end
		end
		
		for y, player in pairs(RedTeam) do
			if not player.Character then
				table.remove(RedTeam,y)
				print(player.Name.." left the game")
			end
		end
		
		if EndGame == true then
			wait(2)
			break
		end
		
		wait(1)
	end
	
	LosingTeamOnTimeUp = ReplicatedStorage:FindFirstChild("TimeUp"):Invoke()
	print("time up fired")
	if LosingTeamOnTimeUp == "Blue" then
		LosingTeam = "Blue"
	elseif LosingTeamOnTimeUp == "Red" then
		LosingTeam = "Red"
	elseif LosingTeamOnTimeUp == "Tie" then
		LosingTeam = nil
	end
	
	wait(1)
	--CREATE A WAY TO DETERMINE WINNING TEAM WITHOUT THE BEACON BAR
	GameStatus.Value = "Game over"
	if LosingTeam == "Blue" then
		WinningTeam = "Red"
		GameStatus.Value = WinningTeam.." Team Won"
	elseif LosingTeam == "Red" then
		WinningTeam = "Blue"
		GameStatus.Value = WinningTeam.." Team Won"
	else --neither beacon bar empty nor team eliminated event has fired
		GameStatus.Value = "Tie"
	end
	
	GameOngoing.Value = false
	
	--remove player's game tags and life count, and kill them
	for i, player in pairs(BlueTeam) do
		if player:FindFirstChild("BlueTag") then
			player:FindFirstChild("BlueTag"):Destroy()
		end 
		player:FindFirstChild("NumLives"):Destroy()
		player.Character:FindFirstChild("Humanoid").Health = 0
	end
	
	for i, player in pairs(RedTeam) do
		if player:FindFirstChild("RedTag") then
			player:FindFirstChild("RedTag"):Destroy()
		end 
		player:FindFirstChild("NumLives"):Destroy()
		player.Character:FindFirstChild("Humanoid").Health = 0
	end
	
	--clear up the map
	CloneMap:Destroy()
	wait(4)
	
	--result testing
	print("Blue Team:")
	for i, player in pairs(BlueTeam) do
		if WinningTeam == "Blue" then
			player.leaderstats.Money.Value = player.leaderstats.Money.Value + WinningTeamDefaultReward + (RewardPerKill * player.KillCount.Value)
		else
			player.leaderstats.Money.Value = player.leaderstats.Money.Value + (RewardPerKill * player.KillCount.Value)
		end
		print(player.Name.." got "..player:FindFirstChild("KillCount").Value.." kills")
	end
	
	print("Red Team:")
	for i, player in pairs(RedTeam) do
		if WinningTeam == "Red" then
			player.Reward.Value = WinningTeamDefaultReward + (RewardPerKill * player.KillCount.Value)
			player.leaderstats.Money.Value = player.leaderstats.Money.Value + player.Reward.Value
		else
			player.Reward.Value = RewardPerKill * player.KillCount.Value
			player.leaderstats.Money.Value = player.leaderstats.Money.Value + player.Reward.Value
		end
		print(player.Name.." got "..player:FindFirstChild("KillCount").Value.." kills")
	end
	
	wait(3)
	ReplicatedStorage.ResultsDisplay:FireAllClients(BlueTeam, RedTeam)
end

