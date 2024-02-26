local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameStatus = ReplicatedStorage:FindFirstChild("GameStatus")

script.Parent.Visible = true

GameStatus:GetPropertyChangedSignal("Value"):Connect(function()
	script.Parent.Text = GameStatus.Value
end)