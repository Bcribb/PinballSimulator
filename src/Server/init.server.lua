--!strict

local ServerStorage = game:GetService("ServerStorage")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MatterService = require(ServerStorage.Source.Services.MatterService)

for _, serviceController in ReplicatedStorage.Source.SharedServiceControllers:GetChildren() do
    require(serviceController)
end
for _, service in ServerStorage.Source.Services:GetChildren() do
    require(service)
end