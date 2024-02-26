
local TweenService = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Camera = game.Workspace.Camera
local GameOngoing = ReplicatedStorage:FindFirstChild("GameOngoing")

local cutsceneTime = 9.5

local tweenInfo = TweenInfo.new(
	cutsceneTime,
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
	
	wait(cutsceneTime)
	
	Camera.CameraType = Enum.CameraType.Custom
end

GameOngoing:GetPropertyChangedSignal("Value"):Connect(function()
	if GameOngoing.Value == true then
		tween(game.Workspace.Cam1, game.Workspace.Cam2)
	end
end)
