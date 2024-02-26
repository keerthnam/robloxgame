local ServerStorage = game:GetService("ServerStorage")

local NameTag = ServerStorage:WaitForChild("NameTag")

game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		character:FindFirstChild("Humanoid").NameDisplayDistance = 0
		character:FindFirstChild("Humanoid").MaxHealth = 500
		character:FindFirstChild("Humanoid").Health = 500
		print("player configured")
		
		local CloneTag = NameTag:Clone()
		CloneTag.TextLabel.Text = player.Name
		CloneTag.Parent = character.Head
		print("name tag given configure")
		
		if player:FindFirstChild("BlueTag") or player:FindFirstChild("RedTag") then	
			if player:FindFirstChild("BlueTag") then
				CloneTag.TextLabel.TextColor3 = Color3.fromRGB(0,128,255) --color of blue team
			else
				CloneTag.TextLabel.TextColor3 = Color3.fromRGB(255,0,0) --color of red team
			end
		else
			CloneTag.TextLabel.TextColor3 = Color3.new(1,1,1) --color of lobby team
		end
	end)
end)