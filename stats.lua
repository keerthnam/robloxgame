local DataStore = game:GetService("DataStoreService"):GetDataStore("MyDataStore")


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local LivesReduced = ReplicatedStorage:WaitForChild("LivesReduced")
local NameTag = ServerStorage:WaitForChild("NameTag")

game.Players.PlayerAdded:Connect(function(player)
	
	local leaderstats = Instance.new("Folder")
	leaderstats.Name = "leaderstats"
	leaderstats.Parent = player
	
	local Kills = Instance.new("IntValue")
	Kills.Name = "Kills"
	Kills.Parent = leaderstats
	
	local Money = Instance.new("IntValue")
	Money.Name = "Money"
	Money.Parent = leaderstats
	
	local KillCount = Instance.new("IntValue")
	KillCount.Name = "KillCount"
	KillCount.Parent = player
	
	local Reward = Instance.new("IntValue")
	Reward.Name = "Reward"
	Reward.Parent = player
	
	local data
	local MoneyStored
	
	local success, errorMessage = pcall(function()
		data = DataStore:GetAsync(player.UserId.."weapons")
		MoneyStored = DataStore:GetAsync(player.UserId.."money")
	end)
	
	if MoneyStored ~= nil then
		Money.Value = MoneyStored
	else
		Money.Value = 500000 -- choose an appropriate starting cash value
	end
	
	if data ~= nil then
		for _, weaponName in pairs(data) do
			local weapon = game.ReplicatedStorage.Weapons:FindFirstChild(weaponName)
			if weapon then
				local newWeapon = weapon:Clone()
				newWeapon.Parent = player.Backpack
				
				local newWeapon = weapon:Clone()
				newWeapon.Parent = player.StarterGear
			end
		end
	end
	
	player.Team = game.Teams.Lobby
	
	print("player added event complete")
	
	player.CharacterAdded:Connect(function(character)
		
		character.Humanoid.Died:Connect(function()
			
			if player:FindFirstChild("BlueTag") or player:FindFirstChild("RedTag") then
				
				player:FindFirstChild("NumLives").Value = player:FindFirstChild("NumLives").Value - 1
				--print("number of lives reduced")
				--if number of lives reaches zero, player is out of the round
				if player:FindFirstChild("NumLives").Value == 0 then
					if player:FindFirstChild("BlueTag") then
						player:FindFirstChild("BlueTag"):Destroy()
					elseif player:FindFirstChild("RedTag") then
						player:FindFirstChild("RedTag"):Destroy()
					end
					player.Team = game.Teams.Lobby
				end
				
			--otherwise spawn players at the lobby 
			else
				player.Team = game.Teams.Lobby
				print(player.Name.." was respawned at the lobby")
			end
		end)
	end)
end)

game.Players.PlayerRemoving:Connect(function(plr)
	
	local WeaponsTable = {}
	
	for _, weapon in pairs(plr.Backpack:GetChildren()) do
		if game.ReplicatedStorage.Weapons:FindFirstChild(weapon.Name) then
			table.insert(WeaponsTable, weapon.Name)
			
		end
	end
	
	local success, errorMessage = pcall(function()
		DataStore:SetAsync{plr.UserId.."weapons", WeaponsTable}
		DataStore:SetAsync{plr.UserId.."money", plr.leaderstats.Money.Value}
	end)
	
end)

game:BindToClose(function()
	for _, plr in pairs(game.Players:GetPlayers()) do
		local WeaponsTable = {}
	
		for _, weapon in pairs(plr.Backpack:GetChildren()) do
			if game.ReplicatedStorage.Weapons:FindFirstChild(weapon.Name) then
				table.insert(WeaponsTable, weapon.Name)
				
			end
		end
		
		local success, errorMessage = pcall(function()
			DataStore:SetAsync{plr.UserId.."weapons", WeaponsTable}
			DataStore:SetAsync{plr.UserId.."money", plr.leaderstats.Money.Value}
		end)
	end
end)