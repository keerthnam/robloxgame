local Player = game:GetService("Players").LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Camera = game.Workspace.Camera
local GameOngoing = ReplicatedStorage:FindFirstChild("GameOngoing")
local BarProgress = script.ScreenGui.Background.Frame.Frame.Size.X.Offset

script.ScreenGui.Background.Visible = false

--trigger loading gui
GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true then
		script.battle:Play()
		script.ScreenGui.Background.Visible = true
		if Player.Character:FindFirstChild("Humanoid") then
			Player.Character:FindFirstChild("Humanoid").WalkSpeed = 0
		end
		BarProgress = 0
		while wait() do
			BarProgress = BarProgress + 2
			script.ScreenGui.Background.Frame.Frame.Size = UDim2.new(0,BarProgress,0,40)
			--print(BarProgress)
			if BarProgress >= 500 then
				print("Loading Complete")
				
				while wait() do
					script.ScreenGui.Background.BackgroundTransparency = script.ScreenGui.Background.BackgroundTransparency + 0.08
					if script.ScreenGui.Background.BackgroundTransparency >= 1 then
						break
					end
				end
				break
			end
		end
		Player.Character:FindFirstChild("Humanoid").WalkSpeed = 16
		script:Destroy()
	end
end)

