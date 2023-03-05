--[[

	All Credit to Exunys
	https://github.com/Exunys
	Edited by Rtxyy for Part ESP

]]

--// Cache


local PartESP = {}


local select, next, tostring, pcall, getgenv, mathfloor, mathabs, stringgsub, stringmatch, wait = select, next, tostring, pcall, getgenv, math.floor, math.abs, string.gsub, string.match, task.wait
local Vector2new, Vector3new, Vector3zero, CFramenew, Drawingnew, WorldToViewportPoint,Color3fromRGB = Vector2.new, Vector3.new, Vector3.zero, CFrame.new, Drawing.new , Color3.fromRGB


--// Services

local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Camera = workspace.CurrentCamera

--// Environment

local CrosshairParts, WrappedPlayers = {
	LeftLine = Drawingnew("Line"),
	RightLine = Drawingnew("Line"),
	TopLine = Drawingnew("Line"),
	BottomLine = Drawingnew("Line"),
	CenterDot = Drawingnew("Circle")
}, {}

--// Core Functions

WorldToViewportPoint = function(...)
	return Camera.WorldToViewportPoint(Camera, ...)
end



--// Main


function PartESP.AddESP(ObjectName,Object,ObjectPath,TextSize,TextColor)
	local PartTable = {
		Name = Object.Name,
		OldPath = Object:GetFullName()
		ESP = Drawingnew("Text"),
		Connections = {}
	}


	PartTable.Connections.ESP = RunService.RenderStepped:Connect(function()
		if LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
			local Vector, OnScreen = WorldToViewportPoint(Object.Position)	
			if OnScreen then
				PartTable.ESP.Visible = true

				if PartTable.ESP.Visible then
					PartTable.ESP.Center = true
					PartTable.ESP.Size = TextSize or 14
					PartTable.ESP.Outline = true
					PartTable.ESP.OutlineColor = Color3.fromRGB(0, 0, 0)
					PartTable.ESP.Color = TextColor or Color3.fromRGB(255,255,255)
					PartTable.ESP.Transparency = 0.5
					PartTable.ESP.Font = Drawing.Fonts.UI

					PartTable.ESP.Position = Vector2new(Vector.X, Vector.Y - 25)

					local Parts, Content = {
						Distance = "["..tostring(mathfloor(((Object.Position or Vector3zero) - (LocalPlayer.Character.HumanoidRootPart.Position or Vector3zero)).Magnitude)).."]",
						Name = ObjectName
					}, ""


						Content = Parts.Name..Content

						Content = Content.." "..Parts.Distance
				

					PartTable.ESP.Text = Content
				end
			else
				PartTable.ESP.Visible = false
			end
		else
			PartTable.ESP.Visible = false
		end

		if Object:GetFullName() ~= PartTable.OldPath then
			print("Part Gone")
			PartTable.Connections.ESP:Disconnect()
			PartTable.ESP:Remove()
		
		end
	end)

end
return PartESP

