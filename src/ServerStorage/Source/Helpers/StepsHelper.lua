--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BALL_BEHAVIOUR = require(ReplicatedStorage.Source.Constants.BALL_BEHAVIOUR)

local DebugHelper = require(ReplicatedStorage.Source.Helpers.DebugHelper)
local RaycastParamsHelper = require(ReplicatedStorage.Source.Helpers.RaycastParamsHelper)
local VectorHelper = require(ReplicatedStorage.Source.Helpers.VectorHelper)

local StepsHelper = {}

function StepsHelper.calculateSteps(_time : number, _position : Vector3, _velocity : Vector3, _radius : number)
    local newTime : number = _time + BALL_BEHAVIOUR.TIME_INCREMENT
    local newPostion : Vector3 = _position + _velocity * BALL_BEHAVIOUR.TIME_INCREMENT
    local newVelocity : Vector3 = _velocity
    local intendedDirection : Vector3 = newPostion - _position
    local raycastResult : RaycastResult = workspace:Spherecast(_position, _radius, intendedDirection, RaycastParamsHelper.ballRaycastParams)

    if raycastResult then
        local distancePortion : number = raycastResult.Distance / intendedDirection.Magnitude
        local timeDelta : number = BALL_BEHAVIOUR.TIME_INCREMENT * distancePortion
        
        newTime = _time + timeDelta
        newPostion = _position + _velocity * BALL_BEHAVIOUR.TIME_INCREMENT * distancePortion
        newVelocity = VectorHelper.reflect(_velocity, raycastResult.Normal)
    end

    DebugHelper.createDirectionIndicator(_position, _velocity.Unit, _velocity.Magnitude * BALL_BEHAVIOUR.TIME_INCREMENT, workspace)

    local step = {
        serverTime = newTime,
        position = newPostion,
        velocity = newVelocity
    }

    return step
end

return StepsHelper