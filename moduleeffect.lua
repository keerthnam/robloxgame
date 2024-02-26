local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ModuleActivated = ReplicatedStorage:WaitForChild("ModuleActivated")

ModuleActivated.OnServerEvent:Connect(function(player)
	if player.Character:FindFirstChild("Humanoid") then
		for i = 5, 0, -1 do
			if player.Character:FindFirstChild("Humanoid") then
				player.Character.Humanoid.Health = (math.floor(player.Character.Humanoid.Health) * 0.015) + player.Character.Humanoid.Health
			end
			--print("healing")
			wait(1)
		end
	end
end)