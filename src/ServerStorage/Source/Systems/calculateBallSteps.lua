--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)
local BALL_BEHAVIOUR = require(ReplicatedStorage.Source.Constants.BALL_BEHAVIOUR)

local StepsHelper = require(ServerStorage.Source.Helpers.StepsHelper)
local StepsReplicaController = require(ServerStorage.Source.Services.StepsReplicaService)

local function calculateBallSteps(_world)
    for id, ballComponent, timeComponent, positonComponent, velocityComponent, sizeComponent in _world:query(
        COMPONENTS.BALL,
        COMPONENTS.TIME,
        COMPONENTS.POSITION,
        COMPONENTS.VELOCITY,
        COMPONENTS.SIZE
    ) do
        local currentTime : number = timeComponent.time
        local position : Vector3 = positonComponent.position
        local velocity : Vector3 = velocityComponent.velocity

        local attributes = {}
        local rollComponent = _world:get(id, COMPONENTS.ROLL)

        if rollComponent then
            attributes.rollPlaneNormal = rollComponent.planeNormal
            attributes.rollPlanePoint = rollComponent.planePoint
        end

        while currentTime <= workspace:GetServerTimeNow() + BALL_BEHAVIOUR.LOOK_AHEAD do
            local step, attributes = StepsHelper.calculateSteps(currentTime, position, velocity, sizeComponent.radius, attributes)
            currentTime = step.serverTime
            position = step.position
            velocity = step.velocity

            _world:insert(
                id,
                timeComponent:patch({
                    time = currentTime
                }),
                positonComponent:patch({
                    position = position
                }),
                velocityComponent:patch({
                    velocity = velocity
                })
            )

            if attributes.rollPlaneNormal then
                rollComponent = rollComponent or COMPONENTS.ROLL({})
                rollComponent:patch({
                    planeNormal = attributes.rollPlaneNormal,
                    planePoint = attributes.rollPlanePoint
                })

                _world:insert(id, rollComponent)
            end

            StepsReplicaController:insertBallStep(id, step)
        end
    end
end

return calculateBallSteps