local Players = game:GetService("Players")
local Plr = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Gui = script.Parent
local MainFrame = Gui:WaitForChild("MainFrame")
local ExitButton = Gui:WaitForChild("ExitButton")
local Next = MainFrame:WaitForChild("Next")
local Prev = MainFrame:WaitForChild("Previous")
local PlayerName = MainFrame:WaitForChild("PlayerName")

local GameOngoing = ReplicatedStorage:WaitForChild("GameOngoing")
local TriggerSpectateGUI = ReplicatedStorage:WaitForChild("TriggerSpectateGUI")

local Num = 1

local function SetCam(n)
	local P = Players:GetPlayers()[n]
	PlayerName.Text = P.Name
	if P.Character.Humanoid then
		workspace.CurrentCamera.CameraSubject = P.Character.Humanoid
	end
end

Prev.MouseButton1Click:Connect(function()
	if Num > 1 then
		Num = Num - 1
	else
		Num = #Players:GetPlayers() 
	end
	SetCam(Num)
end)

Next.MouseButton1Click:Connect(function()
	if Num < #Players:GetPlayers() then
		Num = Num + 1
	else
		Num = 1
	end
	SetCam(Num)
end)

ExitButton.MouseButton1Click:Connect(function()
	MainFrame.Visible = false
	ExitButton.Visible = false
	if Plr.Character.Humanoid then
		workspace.CurrentCamera.CameraSubject = Plr.Character.Humanoid
	end
end)

TriggerSpectateGUI.OnClientEvent:Connect(function()
	--print("event signal recieved")
	MainFrame.Visible = true
	ExitButton.Visible = true
	Num = 1
	PlayerName.Text = Plr.Name
	if Plr.Character.Humanoid then
		workspace.CurrentCamera.CameraSubject = Plr.Character.Humanoid
	end
end)
