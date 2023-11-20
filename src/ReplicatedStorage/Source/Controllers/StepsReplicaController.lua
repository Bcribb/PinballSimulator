--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ReplicaController = require(ReplicatedStorage.Source.External.ReplicaService.ReplicaController)

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local WorldServiceController = require(ReplicatedStorage.Source.SharedServiceControllers.WorldServiceController)

ReplicaController.ReplicaOfClassCreated("StepsReplica", function(replica)
    replica:ListenToNewKey({}, function(_newValue, _newKey)
        local model : Model = ReplicatedStorage.Assets.Ball:Clone()
        model.Parent = workspace

        WorldServiceController:parmWorld():spawn(
            COMPONENTS.BALL({serverId = _newKey}),
            COMPONENTS.STEPS({steps = _newValue.steps}),
            COMPONENTS.MODEL({model = model})
        )
    end)
end)

local StepsReplicaController = {}

ReplicaController.RequestData()

return StepsReplicaController