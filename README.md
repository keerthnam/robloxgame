# robloxgame
Name: FPS Minigames

//--Description-//
This is a multiplayer first person shooter (FPS) minigame. Players are split into teams to battle their opponents with cool weapons, in different game modes (domination, beacon rush, and team deathmatch). The code is entirely in the programming language Lua, which is specific to Roblox Studio- the platform I used to build the game. Within the folders here, I have all the code for the game, however, to recreate the game on Roblox Studio, you will need prior knowledge of creating/manipulating objects such as GUIs and Parts where needed. I've listed below all the objects (with the specific name I used for each) within the particular services. 

//--Required Objects in Workspace--//
- Each beacon and team base has a "Cam" part in facing it, positioned in air
- a lobby/platform with SpawnPart named "Lobby"


//--Required Objects in ReplicatedStorage--//
- all weapon objects (in a folder named "Weapons")

[Values]
- StringValues for each beacon ("BeaconA_Status", "BeaconB_Status"...)
- StringValue "CurrentMap"
- StringValue "GameMode"
- StringValue "GameStatus"
- 2 IntValues named "RedBarProgress" & "BlueBarProgress"
- BoolValue "GameOngoing"
 
[Functions]
- RemoteFunction "BuyItem"
- BindableFunction "TimeUp"

[Events]
- RemoteEvent "BeaconBarDepleting"
- RemoteEvent "LaunchProjectile"
- RemoteEvent "LivesReduced"
- RemoteEvent "ModuleActivated"
- RemoteEvent "ResultsDisplay"
- RemoteEvent "TeamCount"
- RemoteEvent "TeleportPlayer"
- RemoteEvent "TeamCount"

- BindableEvent "BeaconBarEmpty"
- BindableEvent "TeamEliminated"

//--Required Objects in ServerScriptService--//
- All server scripts

//--Required Objects in ServerStorage--//
- BillboardGui "NameTag"
- Folder "Maps" containing all game maps
- Folder "Projectiles" containing all gun projectiles


//--Required Objects in StarterGui--//
- All local scripts
- Folder "BeaconStatus" containing beacon status ScreenGui with the local script of the same name
- ScreenGui "Ammo"
- ScreenGui "GameStatus" containing local script of the same name
- ScreenGui "GunName"
- ScreenGui "Shop" containing local script of the same name
- ScreenGui "SpectateGui" containing local script of the same name

//Required Objects in StarterPlayer -> StarterCharacterScripts--//
- Blank script named "Health" 

//Required Objects in Teams--//
- Team "Blue", "Red", & "Lobby"

//--Other specific required objects--//
- Each beacons has a "BeaconBound" part at encircling its base
- Each team base has a "Spawn" part in front of it
