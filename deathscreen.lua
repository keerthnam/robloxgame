local Player = game.Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local Camera = game.Workspace.Camera

local Character = Player.Character or Player.CharacterAdded:Wait()
repeat wait() until Character:FindFirstChild("Humanoid")
local Humanoid = Character:FindFirstChild("Humanoid")
local CurrentMap 
local BeaconCams

local Frame = script:WaitForChild("ScreenGui"):WaitForChild("Frame")
local LifeCountMessage = Frame:WaitForChild("LifeCountMessage")

local RespawnSelectionFrame = script:WaitForChild("ScreenGui"):WaitForChild("RespawnSelectionFrame")
local Prompt = RespawnSelectionFrame:WaitForChild("Prompt")
local SwitchToPrevious = RespawnSelectionFrame:WaitForChild("SwitchToPrevious")
local SwitchToNext = RespawnSelectionFrame:WaitForChild("SwitchToNext")
local Countdown = RespawnSelectionFrame:WaitForChild("Countdown")
local SelectedSpawn = RespawnSelectionFrame:WaitForChild("SelectedSpawn")
local ConfirmChoice = RespawnSelectionFrame:WaitForChild("ConfirmChoice")
local NumLives
local PlayerTeam

local tweenInfo = TweenInfo.new(
	0.3,
	Enum.EasingStyle.Sine,
	Enum.EasingDirection.Out,
	0,
	false,
	0
)

function tween(part1,part2)
	Camera.CameraType = Enum.CameraType.Scriptable
	Camera.CFrame = part1.CFrame
	
	local tween = TweenService:Create(Camera, tweenInfo, {CFrame = part2.CFrame})
	tween:Play()
	
	wait(0.3)
	
	
end

if game.ReplicatedStorage.GameMode.Value == "Beacon Rush" and (Player:FindFirstChild("BlueTag") or Player:FindFirstChild("RedTag")) then
	
	if Player:FindFirstChild("BlueTag") then
		PlayerTeam = "Blue"
	elseif Player:FindFirstChild("RedTag") then
		PlayerTeam = "Red"
	end
	
	NumLives = Player.NumLives.Value	
	if NumLives > 0 then
		CurrentMap = game.ReplicatedStorage:FindFirstChild("CurrentMap").Value
		BeaconCams = game.Workspace[CurrentMap]:FindFirstChild("BeaconCams")
		Camera.CameraType = Enum.CameraType.Scriptable
		Camera.CFrame = game.Workspace.HomeBaseCam.CFrame
		RespawnSelectionFrame.Visible = true
		SelectedSpawn.Text = "Home Base"
		print("camera changed")
		
		SwitchToNext.MouseButton1Click:Connect(function()
			if SelectedSpawn.Text == "Home Base" then
				tween(game.Workspace.HomeBaseCam, BeaconCams.BeaconACam)
				SelectedSpawn.Text = "Beacon A"
			elseif SelectedSpawn.Text == "Beacon A" then
				tween(BeaconCams.BeaconACam, BeaconCams.BeaconBCam)
				SelectedSpawn.Text = "Beacon B"
			elseif SelectedSpawn.Text == "Beacon B" then
				tween(BeaconCams.BeaconBCam, BeaconCams.BeaconCCam)
				SelectedSpawn.Text = "Beacon C"
			elseif SelectedSpawn.Text == "Beacon C" then
				tween(BeaconCams.BeaconCCam, BeaconCams.BeaconDCam)
				SelectedSpawn.Text = "Beacon D"
			elseif SelectedSpawn.Text == "Beacon D" then
				tween(BeaconCams.BeaconDCam, BeaconCams.BeaconECam)
				SelectedSpawn.Text = "Beacon E"
			elseif SelectedSpawn.Text == "Beacon E" then
				tween(BeaconCams.BeaconECam, game.Workspace.HomeBaseCam)			
				SelectedSpawn.Text = "Home Base"
			end
		end)
		
		SwitchToPrevious.MouseButton1Click:Connect(function()
			if SelectedSpawn.Text == "Home Base" then
				tween(game.Workspace.HomeBaseCam, BeaconCams.BeaconECam)
				SelectedSpawn.Text = "Beacon E"
			elseif SelectedSpawn.Text == "Beacon A" then
				tween(BeaconCams.BeaconACam, game.Workspace.HomeBaseCam)
				SelectedSpawn.Text = "Home Base"
			elseif SelectedSpawn.Text == "Beacon B" then
				tween(BeaconCams.BeaconBCam, BeaconCams.BeaconACam)
				SelectedSpawn.Text = "Beacon A"
			elseif SelectedSpawn.Text == "Beacon C" then
				tween(BeaconCams.BeaconCCam, BeaconCams.BeaconBCam)
				SelectedSpawn.Text = "Beacon B"
			elseif SelectedSpawn.Text == "Beacon D" then
				tween(BeaconCams.BeaconDCam, BeaconCams.BeaconCCam)
				SelectedSpawn.Text = "Beacon C"
			elseif SelectedSpawn.Text == "Beacon E" then
				tween(BeaconCams.BeaconECam, BeaconCams.BeaconDCam)
				SelectedSpawn.Text = "Beacon D"
			end
		end)
		
		ConfirmChoice.MouseButton1Click:Connect(function()
			if SelectedSpawn.Text ~= "Home Base" then
				if SelectedSpawn.Text == "Beacon A" and (game.ReplicatedStorage:FindFirstChild("BeaconA_Status").Value == PlayerTeam) then
					game.ReplicatedStorage:FindFirstChild("TeleportPlayer"):FireServer(SelectedSpawn.Text)
					RespawnSelectionFrame.Visible = false
					Camera.CameraType = Enum.CameraType.Custom
				elseif SelectedSpawn.Text == "Beacon B" and (game.ReplicatedStorage:FindFirstChild("BeaconB_Status").Value == PlayerTeam) then
					game.ReplicatedStorage:FindFirstChild("TeleportPlayer"):FireServer(SelectedSpawn.Text)
					RespawnSelectionFrame.Visible = false
					Camera.CameraType = Enum.CameraType.Custom
				elseif SelectedSpawn.Text == "Beacon C" and (game.ReplicatedStorage:FindFirstChild("BeaconC_Status").Value == PlayerTeam) then
					game.ReplicatedStorage:FindFirstChild("TeleportPlayer"):FireServer(SelectedSpawn.Text)
					RespawnSelectionFrame.Visible = false
					Camera.CameraType = Enum.CameraType.Custom
				elseif SelectedSpawn.Text == "Beacon D" and (game.ReplicatedStorage:FindFirstChild("BeaconD_Status").Value == PlayerTeam) then
					game.ReplicatedStorage:FindFirstChild("TeleportPlayer"):FireServer(SelectedSpawn.Text)
					RespawnSelectionFrame.Visible = false
					Camera.CameraType = Enum.CameraType.Custom
				elseif SelectedSpawn.Text == "Beacon E" and (game.ReplicatedStorage:FindFirstChild("BeaconE_Status").Value == PlayerTeam) then
					game.ReplicatedStorage:FindFirstChild("TeleportPlayer"):FireServer(SelectedSpawn.Text)
					RespawnSelectionFrame.Visible = false
					Camera.CameraType = Enum.CameraType.Custom
				else
					Prompt.Text = "Must select a beacon that is your team's color!"
					wait(0.7)
					Prompt.Text = "Select a beacon to teleport to!"
				end
			else
				RespawnSelectionFrame.Visible = false
				Camera.CameraType = Enum.CameraType.Custom
			end
		end)
		
		for i = 15, 0, -1 do
			Countdown.Text = "Time to select: "..i
			wait(1)
		end
		RespawnSelectionFrame.Visible = false
		Camera.CameraType = Enum.CameraType.Custom
	end
end


Humanoid.Died:Connect(function()
	if game.ReplicatedStorage.GameOngoing.Value ~= false then
		Frame.Visible = true
		NumLives = Player.NumLives.Value - 1
		if NumLives == 1 then
			LifeCountMessage.Text = "You have ".. NumLives .. " life left" 
		else
			LifeCountMessage.Text = "You have ".. NumLives .. " lives left" 
		end
		
		while Frame.BackgroundTransparency > 0 do
			Frame.BackgroundTransparency = Frame.BackgroundTransparency - 0.05
			wait(0.3)
		end
		wait(0.3)
		Frame.Visible = false
		Frame.BackgroundTransparency = 0.7
	end
end)
