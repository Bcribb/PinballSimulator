--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local StepsReplicaSerivce = require(ServerStorage.Source.Services.StepsReplicaService)

local function handleBallRequests(_world)
    for id, ballRequest in _world:query(COMPONENTS.BALL_REQUEST) do
        local velocity : Vector3 = ballRequest.direction * 30

        local ballId : number = _world:spawn(
            COMPONENTS.OWNER({player = ballRequest.player}),
            COMPONENTS.TIME({time = workspace:GetServerTimeNow()}),
            COMPONENTS.BALL({}),
            COMPONENTS.SIZE({size = Vector3.new(2, 2, 2), radius = 1}),
            COMPONENTS.POSITION({position = ballRequest.position}),
            COMPONENTS.VELOCITY({velocity = velocity}),
            COMPONENTS.GRAVITY({gravity = Vector3.new(0, -50, 0)})
        )

        local step = {
            serverTime = workspace:GetServerTimeNow(),
            position = ballRequest.position,
            velocity = velocity
        }

        StepsReplicaSerivce:createBallSteps(ballId, step)

        _world:despawn(id)
    end
end

return handleBallRequests