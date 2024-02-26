local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BuyItem = ReplicatedStorage:WaitForChild("BuyItem")

BuyItem.OnServerInvoke = function(player, WeaponName)
	
	local Weapon = ReplicatedStorage:FindFirstChild("Weapons"):FindFirstChild(WeaponName)
	if Weapon and not player.StarterGear:FindFirstChild(WeaponName) then
		if Weapon:FindFirstChild("Price") then
			if Weapon.Price.Value <= player.leaderstats.Money.Value then
				player.leaderstats.Money.Value = player.leaderstats.Money.Value - Weapon.Price.Value
				
				local NewWeapon = Weapon:Clone()
				NewWeapon.Parent = player.Backpack
				
				local NewWeapon = Weapon:Clone()
 				NewWeapon.Parent = player.StarterGear
				
				return true
			else
				return false
			end
		else
			return false
		end
	else
		return false
	end
end