--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)
local BALL_BEHAVIOUR = require(ReplicatedStorage.Source.Constants.BALL_BEHAVIOUR)

local StepsHelper = require(ServerStorage.Source.Helpers.StepsHelper)
local CollisionsHelper = require(ServerStorage.Source.Helpers.CollisionsHelper)
local StepsReplicaController = require(ServerStorage.Source.Services.StepsReplicaService)

local function calculateBallSteps(_world)
    for id, ballComponent, timeComponent, positionComponent, velocityComponent, sizeComponent, gravityComponent in _world:query(
        COMPONENTS.BALL,
        COMPONENTS.TIME,
        COMPONENTS.POSITION,
        COMPONENTS.VELOCITY,
        COMPONENTS.SIZE,
        COMPONENTS.GRAVITY
    ) do
        -- Construct the step
        local step = {
            serverTime = timeComponent.time,
            position = positionComponent.position,
            velocity = velocityComponent.velocity,
            acceleration = gravityComponent.gravity
        }

        -- Think ahead
        while step.serverTime <= workspace:GetServerTimeNow() + BALL_BEHAVIOUR.LOOK_AHEAD do
            local raycastResult : RaycastResult
            local rollComponent = _world:get(id, COMPONENTS.ROLL)

            -- Calculate the basics of the step, i.e - move the ball and update velocity etc
            step, raycastResult = StepsHelper.calculateSteps(step, rollComponent)

            -- If we've hit anything, then handle that collision
            step = CollisionsHelper.handleCollisions(step, raycastResult, id)

            _world:insert(
                id,
                timeComponent:patch({
                    time = step.serverTime
                }),
                positionComponent:patch({
                    position = step.position
                }),
                velocityComponent:patch({
                    velocity = step.velocity
                })
            )

            --[[
            if attributes.rollPlaneNormal then
                _world:insert(id, COMPONENTS.ROLL({
                    planeNormal = attributes.rollPlaneNormal,
                    planePoint = attributes.rollPlanePoint
                }))
            end
            ]]

            StepsReplicaController:insertBallStep(id, step)
        end
    end
end

return calculateBallSteps