local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Weapons = ReplicatedStorage:WaitForChild("Weapons")
local ShopGui = script.Parent
local Caption = ShopGui:WaitForChild("Caption")
local ShopButton = ShopGui:WaitForChild("ToggleShop")
local ItemModal = ShopGui:WaitForChild("ItemModal")
local Frame = ShopGui:WaitForChild("ScrollingFrame")
local Template = Frame:WaitForChild("Template") 
local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")

GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true then
		ShopButton.Visible = false
		ItemModal.Visible = false
		Caption.Visible = false
		Frame.Visible = false
		wait(11)
		ShopButton.Visible = true
	end
end)

for _, weapon in pairs(Weapons:GetChildren()) do
	local NewTemplate = Template:Clone()
	NewTemplate.Name = weapon.Name
	NewTemplate.WeaponName.Text = weapon.Name
	NewTemplate.Visible = true
	NewTemplate.Parent = Frame
	
	local Object = weapon:Clone()
	Object.Parent = NewTemplate.ViewportFrame
	
	local Camera = Instance.new("Camera")
	if weapon.Name == "Avalanche" then
		Camera.CFrame = CFrame.new(Object.Handle.Position + Vector3.new(0,0,4), Object.Handle.Position)
	else
		Camera.CFrame = CFrame.new(Object.CameraPart.Position + Vector3.new(4,0,0), Object.CameraPart.Position)
	end
	Camera.Parent = NewTemplate.ViewportFrame
	NewTemplate.ViewportFrame.CurrentCamera = Camera
	
	NewTemplate.MouseButton1Click:Connect(function()
		
		NewTemplate.BackgroundColor3 = Color3.fromRGB(55,255,85)
		wait(0.5)
		NewTemplate.BackgroundColor3 = Color3.fromRGB(255,255,255)
		
		--make item modal visible
		Frame.Visible = false
		Caption.Visible = false
		ItemModal.Visible = true
		local ViewportFrame = Instance.new("ViewportFrame")
		ViewportFrame.Parent = ItemModal
		ViewportFrame.AnchorPoint = Vector2.new(0.5,0.5)
		ViewportFrame.Position = UDim2.new(0.5,0,0.55,0)
		ViewportFrame.Size = UDim2.new(0.25,0,0.5,0)
		ViewportFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
		
		ItemModal:WaitForChild("ToggleModal").MouseButton1Click:Connect(function()
			ViewportFrame:Destroy()
			ItemModal.Visible = false
			Frame.Visible = true
			Caption.Visible = true
		end)
		
		--display picture of item with the use of a viewport frame and camera
		ItemModal.WeaponName.Text = weapon.Name
		ItemModal.Damage.Text = weapon.Damage.Value
		ItemModal.Range.Text = weapon.Range.Value
		ItemModal.ReloadTime.Text = weapon.ReloadTime.Value.." sec"
		ItemModal.Price.Text = weapon.Price.Value
		
		local CloneObject = weapon:Clone()
		CloneObject.Parent = ItemModal.ViewportFrame
		
		local CloneCamera = Instance.new("Camera")
		if weapon.Name == "Avalanche" then
			CloneCamera.CFrame = CFrame.new(Object.Handle.Position + Vector3.new(0,0,4), Object.Handle.Position)
		else
			CloneCamera.CFrame = CFrame.new(Object.CameraPart.Position + Vector3.new(4,0,0), Object.CameraPart.Position)
		end
		CloneCamera.Parent = ItemModal.ViewportFrame
		ItemModal.ViewportFrame.CurrentCamera = CloneCamera
		
		ItemModal.Buy.MouseButton1Click:Connect(function()
			local Result = ReplicatedStorage.BuyItem:InvokeServer(weapon.Name)
			
			if(Result == true) then
				ItemModal.Buy.Text = "Successful"
			end
			wait(0.5)
			ItemModal.Buy.Text = "Buy"
		end)
		
	end)
end

ShopButton.MouseButton1Click:Connect(function()
	if ItemModal:FindFirstChild("ViewportFrame") then
		ItemModal.ViewportFrame:Destroy()
	end
	Frame.Visible = not Frame.Visible
	Caption.Visible = not Caption.Visible
	ItemModal.Visible = false
end)
