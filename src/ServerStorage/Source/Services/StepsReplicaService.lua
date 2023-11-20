--!strict

local ServerStorage = game:GetService("ServerStorage")
local ReplicaService = require(ServerStorage.External.ReplicaService.ReplicaService)

local stepsReplica = ReplicaService.NewReplica({
    ClassToken = ReplicaService.NewClassToken("StepsReplica"),
    Data = {

    },
    Replication = "All",
})

local StepsReplicaService = {
    replica = stepsReplica
}

function StepsReplicaService:createBallSteps(_id : number, _step)
    local ball = {
        steps = {
            [1] = _step
        }
    }
    self.replica:SetValue({_id}, ball)
end

function StepsReplicaService:insertBallStep(_id : number, _step)
    self.replica:ArrayInsert({_id, "steps"}, _step)
end

return StepsReplicaService