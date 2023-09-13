--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local MatterController = require(ReplicatedStorage.Source.Controllers.MatterController)

for _, serviceController in ReplicatedStorage.Source.SharedServiceControllers:GetChildren() do
    require(serviceController)
end
for _, controller in ReplicatedStorage.Source.Controllers:GetChildren() do
    require(controller)
end