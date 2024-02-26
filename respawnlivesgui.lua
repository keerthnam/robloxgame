local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")
local LivesReduced = ReplicatedStorage:WaitForChild("LivesReduced")

local NumLives
local Lives = script.ScreenGui.Lives:GetChildren()

if GameOngoing.Value == true then
	script.ScreenGui.Lives.Visible = true
	while wait() do
		NumLives = Players.LocalPlayer:FindFirstChild("NumLives")
		if NumLives then
			for i = 5, NumLives.Value + 1, -1 do
			Lives[i]:Destroy()
			end
		end
	end
end

GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true then
		wait(11)
		script.ScreenGui.Lives.Visible = true
		NumLives = Players.LocalPlayer:FindFirstChild("NumLives")
		NumLives:GetPropertyChangedSignal("Value"):Connect(function()
			print("Num lives value changed")
			Lives[#Lives]:Destroy()
		end)
	else
		wait(3)
		script.ScreenGui.Lives.Visible = false
	end
end)


