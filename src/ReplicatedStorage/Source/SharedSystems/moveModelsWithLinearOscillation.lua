--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)
local INTERACTABLES = require(ReplicatedStorage.Source.Constants.INTERACTABLES)

local function moveModelsWithLinearOscillation(_world)
    local serverTime : number = workspace:GetServerTimeNow()

    if RunService:IsServer() then
        serverTime += INTERACTABLES.LOOK_AHEAD
    end

    for _, model, linearOscillation, origin in _world:query(COMPONENTS.MODEL, COMPONENTS.LINEAR_OSCILLATION, COMPONENTS.ORIGIN) do
        local timePortion : number = serverTime % linearOscillation.period
        local displacementMagnitude : number = (linearOscillation.maxDisplacement / 2) * (-math.cos((2 * math.pi * timePortion) / linearOscillation.period) - 1)
        local displacementDirection : Vector3 = Vector3.fromAxis(linearOscillation.axis)
        local newPosition : Vector3 = origin.position + (displacementDirection * displacementMagnitude)

        model.model:PivotTo(CFrame.new(newPosition):ToWorldSpace(origin.rotation))
    end
end

return moveModelsWithLinearOscillation