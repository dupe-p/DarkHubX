local Players = game:GetService("Players")
local player = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local chatEvent = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents"):WaitForChild("SayMessageRequest")

while true do
    chatEvent:FireServer("fuck", "dick")
    wait(0.1)  -- waits 0.1 seconds between messages
end
