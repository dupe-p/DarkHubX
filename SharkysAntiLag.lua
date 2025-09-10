-- Anti-lag script for Delta Executor
-- Made By Sharky

local Workspace = game:GetService("Workspace")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- Remove or disable particle emitters, trails, and decals
for _, obj in ipairs(Workspace:GetDescendants()) do
    if obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Enabled = false
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj.Transparency = 1
    end
end

-- Remove all sounds
for _, sound in ipairs(Workspace:GetDescendants()) do
    if sound:IsA("Sound") then
        sound.Volume = 0
        sound:Stop()
    end
end

-- Optional: Clear terrain (commented out for compatibility)
-- if Workspace:FindFirstChildOfClass("Terrain") then
--     Workspace.Terrain:Clear()
-- end

-- Create a ScreenGui for the popup text
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "AntiLagPopupGui"
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create the TextLabel
local textLabel = Instance.new("TextLabel")
textLabel.Size = UDim2.new(0.5, 0, 0, 50)
textLabel.Position = UDim2.new(0.25, 0, 0.5, -25)
textLabel.BackgroundColor3 = Color3.new(0, 0, 0)
textLabel.BackgroundTransparency = 0.5
textLabel.Text = "Successfully Used AntiLag Script Made By Sharky"
textLabel.TextColor3 = Color3.new(0, 1, 0)
textLabel.Font = Enum.Font.SourceSansBold
textLabel.TextScaled = true
textLabel.Parent = screenGui

-- Remove the TextLabel after 3 seconds
task.delay(3, function()
    screenGui:Destroy()
end)