game.ReplicatedFirst:RemoveDefaultLoadingScreen()
script.Loading.Frame.TextLabel.Text = "Welcome to FPS Minigames!"

local PlayerGui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
PlayerGui:SetTopbarTransparency(0)

local GUI = script.Loading:Clone()
GUI.Parent = PlayerGui

repeat
	wait(5)
until game:IsLoaded()

GUI.Frame:TweenPosition(UDim2.new(0,0,1,0),"InOut","Sine",0.5)

wait(0.5)
--make any guis visible
PlayerGui:WaitForChild("Shop"):WaitForChild("ToggleShop").Visible = true

wait(0.5)
GUI:Destroy()