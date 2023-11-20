--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local BALL_BEHAVIOUR = require(ReplicatedStorage.Source.Constants.BALL_BEHAVIOUR)

local DebugHelper = require(ReplicatedStorage.Source.Helpers.DebugHelper)

local StepsHelper = {}

function StepsHelper.calculateSteps(_time : number, _position : Vector3, _velocity : Vector3)
    local newTime : number = _time + BALL_BEHAVIOUR.TIME_INCREMENT
    local newPostion : Vector3 = _position + _velocity * BALL_BEHAVIOUR.TIME_INCREMENT
    local newVelocity : Vector3 = _velocity

    DebugHelper.createDirectionIndicator(_position, _velocity.Unit, _velocity.Magnitude * BALL_BEHAVIOUR.TIME_INCREMENT, workspace)

    local step = {
        serverTime = newTime,
        position = newPostion,
        velocity = newVelocity
    }

    return step
end

return StepsHelper