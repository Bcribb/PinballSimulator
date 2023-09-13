--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Matter = require(ReplicatedStorage.Packages.matter)

local WorldServiceController = require(ReplicatedStorage.Source.SharedServiceControllers.WorldServiceController)

local world = Matter.World.new()
local loop = Matter.Loop.new(world)

local MatterService = {}

local systems = {}
for _, child in ipairs(ReplicatedStorage.Source.ClientSystems:GetChildren()) do
    if child:IsA("ModuleScript") then
        table.insert(systems, require(child))
    end
end
for _, child in ipairs(ReplicatedStorage.Source.SharedSystems:GetChildren()) do
    if child:IsA("ModuleScript") then
        table.insert(systems, require(child))
    end
end

loop:scheduleSystems(systems)

loop:begin({
    default = RunService.Heartbeat
})

WorldServiceController:parmWorld(world)

return MatterService