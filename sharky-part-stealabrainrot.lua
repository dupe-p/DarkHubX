-- Variables
local player = game.Players.LocalPlayer
local runService = game:GetService("RunService")
local userInputService = game:GetService("UserInputService")

-- Create ScreenGui
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SharkyPartGui" 
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Create Button
local button = Instance.new("TextButton")
button.Name = "SharkyPartButton"
button.Size = UDim2.new(0, 150, 0, 50)
button.Position = UDim2.new(0, 10, 0.8, 0)  -- Left side of screen
button.BackgroundColor3 = Color3.new(1, 0, 0) -- Red initially (inactive)
button.Text = "Sharky Part"
button.TextColor3 = Color3.new(1, 1, 1)
button.Font = Enum.Font.SourceSansBold
button.TextScaled = true
button.Parent = screenGui

-- Variables for platform and toggle state
local active = false
local platform = nil
local platformHeight = 0
local platformLoopThread

-- Function to create platform
local function createPlatform()
    if platform then
        platform:Destroy()
    end
    platformHeight = 0
    platform = Instance.new("Part")
    platform.Size = Vector3.new(10, 1, 10)
    platform.Anchored = true
    platform.CanCollide = true
    platform.Material = Enum.Material.Neon
    platform.Color = Color3.fromRGB(0, 170, 255)
    platform.Transparency = 1 -- Start invisible
    platform.Parent = workspace
end

-- Function to update platform position and visibility
local function updatePlatform()
    if not platform then return end
    local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        local basePosition = hrp.Position - Vector3.new(0, 5 - platformHeight, 0)
        platform.Position = basePosition
        platform.Transparency = 0
        wait(0.05) -- Visible for 0.05 seconds
        platform.Transparency = 1
        platformHeight = platformHeight + 0.1
    end
end

-- Continuous loop for platform spawn and disappear with movement
local function platformLoop()
    while active do
        updatePlatform()
        wait(0.1)
    end
end

-- Toggle function
local function togglePlatform()
    active = not active
    if active then
        button.BackgroundColor3 = Color3.new(0, 1, 0) -- Green
        createPlatform()
        platformHeight = 0
        platformLoopThread = coroutine.create(platformLoop)
        coroutine.resume(platformLoopThread)
    else
        button.BackgroundColor3 = Color3.new(1, 0, 0) -- Red
        if platform then
            platform:Destroy()
            platform = nil
        end
    end
end

button.MouseButton1Click:Connect(togglePlatform)

-- Make the button draggable
local dragging = false
local dragInput, dragStart, startPos

button.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = button.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

button.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

userInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        button.Position = UDim2.new(
            startPos.X.Scale,
            startPos.X.Offset + delta.X,
            startPos.Y.Scale,
            startPos.Y.Offset + delta.Y
        )
    end
end)