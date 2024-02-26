local Projectiles = game.ServerStorage:WaitForChild("Projectiles")
local GameOngoing

game.ReplicatedStorage.LaunchProjectile.OnServerEvent:Connect(function(player, TargetPos, Muzzle, ProjectileType, Damage, Range)
	
	GameOngoing = game.ReplicatedStorage:WaitForChild("GameOngoing")
	if GameOngoing.Value == true then
		local Character = player.Character	
		local newProjectile = Projectiles:FindFirstChild(ProjectileType):Clone()
		newProjectile.CFrame = Muzzle.CFrame 
		
		local BodyPosition = Instance.new("BodyPosition")
		BodyPosition.Position = TargetPos
		BodyPosition.Parent = newProjectile
		
		newProjectile.Parent = game.Workspace
		
		local TouchConn
		local debounce = false
		
		TouchConn = newProjectile.Touched:Connect(function(hit)
			if hit.Parent:FindFirstChild("Humanoid") then --NOTE: script sometimes breaks here when humanoid object is destroyed
				if hit.Parent.Name ~= player.Name then
					if (player:FindFirstChild("BlueTag") and hit.Parent.Parent:FindFirstChild("RedTag")) or (player:FindFirstChild("RedTag") and hit.Parent.Parent:FindFirstChild("BlueTag")) or not (hit.Parent.Parent:FindFirstChild("BlueTag") or hit.Parent.Parent:FindFirstChild("RedTag")) then
						if ProjectileType == "Grenade" then
							if debounce == false then
								debounce = true
								local Explosion = Instance.new("Explosion")
								Explosion.BlastPressure = 30
								Explosion.BlastRadius = 3
								Explosion.ExplosionType = "NoCraters"
								Explosion.Position = newProjectile.Position
								Explosion.Parent = newProjectile
								debounce = false
								wait(2) -- wait to allow explosion
							end
						else
							hit.Parent:FindFirstChild("Humanoid"):TakeDamage(Damage) -- set damage according to weapon config
						end
					end
					
					if TouchConn ~= nil then
						TouchConn:Disconnect()
					end
					newProjectile:Destroy()
				end
			end
		end)
		
		if Range == "Short" then
			wait(0.3)
		elseif Range == "Medium" then
			wait(1)
		elseif Range == "Long" then
			wait(2)
		end
		
		if TouchConn ~= nil then
			TouchConn:Disconnect()
		end
		newProjectile:Destroy()
	end
end)
