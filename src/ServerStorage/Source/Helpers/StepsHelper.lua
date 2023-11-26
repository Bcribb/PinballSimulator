--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BALL_BEHAVIOUR = require(ReplicatedStorage.Source.Constants.BALL_BEHAVIOUR)
local GLOBAL = require(ReplicatedStorage.Source.Constants.GLOBAL)

local DebugHelper = require(ReplicatedStorage.Source.Helpers.DebugHelper)
local RaycastParamsHelper = require(ReplicatedStorage.Source.Helpers.RaycastParamsHelper)
local VectorHelper = require(ReplicatedStorage.Source.Helpers.VectorHelper)

local StepsHelper = {}

function StepsHelper.calculateSteps(
    _step : {
        serverTime : number,
        position : Vector3,
        velocity : Vector3,
        acceleration : Vector3
    },
    _rollComponent
)
    local newTime : number = _step.serverTime + BALL_BEHAVIOUR.TIME_INCREMENT
    local newPosition : Vector3 = _step.position + VectorHelper.displacement(_step.velocity, _step.acceleration, BALL_BEHAVIOUR.TIME_INCREMENT)
    local newVelocity : Vector3 = _step.velocity + _step.acceleration * BALL_BEHAVIOUR.TIME_INCREMENT
    local newAcceleration : Vector3 = _step.acceleration

    -- Apply roll constraints if applicable
    if _rollComponent then
        newPosition = VectorHelper.projectPointOntoPlane(newPosition, _rollComponent.planePoint, _rollComponent.planeNormal)
        newVelocity = VectorHelper.projectOntoPlane(newVelocity, _rollComponent.planeNormal)
    end

    local intendedDirection : Vector3 = newPosition - _step.position
    local raycastResult : RaycastResult = workspace:Spherecast(_step.position, 1, intendedDirection, RaycastParamsHelper.ballRaycastParams)    

    if raycastResult then
        local distancePortion : number = raycastResult.Distance / intendedDirection.Magnitude

        newTime = _step.serverTime + (BALL_BEHAVIOUR.TIME_INCREMENT * distancePortion)
        newPosition = _step.position + (intendedDirection.Unit * raycastResult.Distance)
        newVelocity = _step.velocity + _step.acceleration * BALL_BEHAVIOUR.TIME_INCREMENT * distancePortion
        newAcceleration = _step.acceleration
    end

    if GLOBAL.DEBUG then
        local actualDirection : Vector3 = newPosition - _step.position
        DebugHelper.createDirectionIndicator(_step.position, actualDirection.Unit, actualDirection.Magnitude, workspace)
    end

    local step = {
        serverTime = newTime,
        position = newPosition,
        velocity = newVelocity,
        acceleration = newAcceleration
    }

    return step, raycastResult
end

return StepsHelper