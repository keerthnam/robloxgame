local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameOngoing = ReplicatedStorage:FindFirstChild("GameOngoing")

local Gui = script.ScreenGui
local GameOverScreen = Gui:WaitForChild("GameOverScreen") 
local Message = GameOverScreen:WaitForChild("TextLabel") 

local GameResultsScreen = Gui:WaitForChild("GameResultsScreen") 
local BlueTeamResults = GameResultsScreen:WaitForChild("BlueTeamResults")
local RedTeamResults = GameResultsScreen:WaitForChild("RedTeamResults")
local Countdown = GameResultsScreen:WaitForChild("Countdown")
local Template = GameResultsScreen:WaitForChild("Template")

-- display game over screen
GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == false then
		GameOverScreen.Visible = true
		for i = 3, 0, -1 do
			wait(0.5)
			Message.Visible = false
			wait(0.5)
			Message.Visible = true
		end
		GameOverScreen.Visible = false
	end
end)

--display game results screen
ReplicatedStorage.ResultsDisplay.OnClientEvent:Connect(function(BlueTeam, RedTeam)
	
	GameResultsScreen.Visible = true
	
	for _, player in pairs(BlueTeam) do
		local NewTemplate = Template:Clone()
		NewTemplate.PlayerName.Text = player.Name
		NewTemplate.KillCount.Text = " "..player:FindFirstChild("KillCount").Value
		NewTemplate.Reward.Text = " "..player:FindFirstChild("Reward").Value
		NewTemplate.Visible = true
		NewTemplate.Parent = BlueTeamResults
	end	
			
	for _, player in pairs(RedTeam) do
		local NewTemplate = Template:Clone()
		NewTemplate.PlayerName.Text = player.Name
		NewTemplate.KillCount.Text = " "..player:FindFirstChild("KillCount").Value
		NewTemplate.Reward.Text = " "..player:FindFirstChild("Reward").Value
		NewTemplate.Visible = true
		NewTemplate.Parent = RedTeamResults
	end	
	
	--countdown
	for i = 10, 0, -1 do
		Countdown.Text = "Back to lobby in "..i
		wait(1)
	end
	GameResultsScreen.Visible = false
	--print("event ended")
end)