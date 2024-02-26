
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")
local TeamCount = ReplicatedStorage:WaitForChild("TeamCount")

local BluePersons = script.ScreenGui.Blue:GetChildren()
local RedPersons = script.ScreenGui.Red:GetChildren()

if GameOngoing.Value == true then
	script.ScreenGui.Blue.Visible = true
	script.ScreenGui.Red.Visible = true
end

GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true then
		wait(11)
		script.ScreenGui.Blue.Visible = true
		script.ScreenGui.Red.Visible = true
	else
		wait(3)
		script.ScreenGui.Blue.Visible = false
		script.ScreenGui.Red.Visible = false
	end
end)

TeamCount.OnClientEvent:Connect(function(BlueTeam, RedTeam)
	--print("recieved")
	if BlueTeam == 1 then
		BluePersons[1].Visible = true
		BluePersons[2].Visible = false
		BluePersons[3].Visible = false
		BluePersons[4].Visible = false
		BluePersons[5].Visible = false
	elseif BlueTeam == 2 then
		BluePersons[1].Visible = true
		BluePersons[2].Visible = true
		BluePersons[3].Visible = false
		BluePersons[4].Visible = false
		BluePersons[5].Visible = false
	elseif BlueTeam == 3 then
		BluePersons[1].Visible = true
		BluePersons[2].Visible = true
		BluePersons[3].Visible = true
		BluePersons[4].Visible = false
		BluePersons[5].Visible = false
	elseif BlueTeam == 4 then
		BluePersons[1].Visible = true
		BluePersons[2].Visible = true
		BluePersons[3].Visible = true
		BluePersons[4].Visible = true
		BluePersons[5].Visible = false
	elseif BlueTeam == 5 then
		BluePersons[1].Visible = true
		BluePersons[2].Visible = true
		BluePersons[3].Visible = true
		BluePersons[4].Visible = true
		BluePersons[5].Visible = true
	elseif BlueTeam == 0 then
		BluePersons[1].Visible = false
		BluePersons[2].Visible = false
		BluePersons[3].Visible = false
		BluePersons[4].Visible = false
		BluePersons[5].Visible = false
	end
	
	if RedTeam == 1 then
		RedPersons[1].Visible = true
		RedPersons[2].Visible = false
		RedPersons[3].Visible = false
		RedPersons[4].Visible = false
		RedPersons[5].Visible = false
	elseif RedTeam == 2 then
		RedPersons[1].Visible = true
		RedPersons[2].Visible = true
		RedPersons[3].Visible = false
		RedPersons[4].Visible = false
		RedPersons[5].Visible = false
	elseif RedTeam == 3 then
		RedPersons[1].Visible = true
		RedPersons[2].Visible = true
		RedPersons[3].Visible = true
		RedPersons[4].Visible = false
		RedPersons[5].Visible = false
	elseif RedTeam == 4 then
		RedPersons[1].Visible = true
		RedPersons[2].Visible = true
		RedPersons[3].Visible = true
		RedPersons[4].Visible = true
		RedPersons[5].Visible = false
	elseif RedTeam == 5 then
		RedPersons[1].Visible = true
		RedPersons[2].Visible = true
		RedPersons[3].Visible = true
		RedPersons[4].Visible = true
		RedPersons[5].Visible = true
	elseif RedTeam == 0 then
		RedPersons[1].Visible = false
		RedPersons[2].Visible = false
		RedPersons[3].Visible = false
		RedPersons[4].Visible = false
		RedPersons[5].Visible = false
	end
end)
