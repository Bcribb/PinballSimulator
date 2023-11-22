--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BALL_BEHAVIOUR = require(ReplicatedStorage.Source.Constants.BALL_BEHAVIOUR)

local DebugHelper = require(ReplicatedStorage.Source.Helpers.DebugHelper)
local RaycastParamsHelper = require(ReplicatedStorage.Source.Helpers.RaycastParamsHelper)
local VectorHelper = require(ReplicatedStorage.Source.Helpers.VectorHelper)

local StepsHelper = {}

function shouldBounce()
    return true
end

function StepsHelper.calculateSteps(
    _time : number,
    _position : Vector3,
    _velocity : Vector3,
    _radius : number,
    _acceleration : Vector3,
    _attributes
)
    local newTime : number = _time + BALL_BEHAVIOUR.TIME_INCREMENT
    local newPosition : Vector3 = _position + VectorHelper.displacement(_velocity, _acceleration, BALL_BEHAVIOUR.TIME_INCREMENT)
    local newVelocity : Vector3 = _velocity + _acceleration * BALL_BEHAVIOUR.TIME_INCREMENT
    local intendedDirection : Vector3 = newPosition - _position
    local raycastResult : RaycastResult = workspace:Spherecast(_position, _radius, intendedDirection, RaycastParamsHelper.ballRaycastParams)
    local attributes = _attributes

    if raycastResult then
        local distancePortion : number = raycastResult.Distance / intendedDirection.Magnitude
        local timeDelta : number = BALL_BEHAVIOUR.TIME_INCREMENT * distancePortion
        
        newTime = _time + timeDelta
        newPosition = _position + intendedDirection.Unit * raycastResult.Distance

        if shouldBounce() then
            newVelocity = VectorHelper.reflect(
                _velocity + _acceleration * timeDelta,
                raycastResult.Normal
            )
        else
            attributes.rollPlaneNormal = raycastResult.Normal
            attributes.rollPlanePoint = newPosition
        end
    end

    if attributes.rollPlaneNormal and attributes.rollPlanePoint then
        newPosition = VectorHelper.projectPointOntoPlane(newPosition, attributes.rollPlanePoint, attributes.rollPlaneNormal)
        newVelocity = VectorHelper.projectOntoPlane(newVelocity, attributes.rollPlaneNormal)
    end

    DebugHelper.createDirectionIndicator(_position, _velocity.Unit, (newPosition - _position).Magnitude, workspace)

    local step = {
        serverTime = newTime,
        position = newPosition,
        velocity = newVelocity
    }

    return step, attributes
end

return StepsHelper