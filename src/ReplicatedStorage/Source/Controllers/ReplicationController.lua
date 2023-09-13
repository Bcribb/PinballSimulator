--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ClientComm = require(ReplicatedStorage.Packages.Comm).ClientComm

local WorldServiceController = require(ReplicatedStorage.Source.SharedServiceControllers.WorldServiceController)

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local clientComm = ClientComm.new(ReplicatedStorage, false, "ReplicationSystem")
local comm = clientComm:BuildObject()
local replicationSignal = clientComm:GetSignal("ReplicationSignal")

-- A lookup table from server entity IDs to client entity IDs. They're different!
local entityIdMap = {}

replicationSignal:Connect(function(_entities)
    -- entities is the data sent from the server. Either the `payload` or `changes` from earlier!

    -- Loop over the entities the server is replicating
    for serverEntityId, componentMap in _entities do
        -- Check if we've created this entity on the client before
        local clientEntityId = entityIdMap[serverEntityId]

        -- If we've created this entity before, and there are no components inside its list, that means
        -- the entity was despawned on the server. We despawn it here too.
        if clientEntityId and next(componentMap) == nil then
            WorldServiceController:parmWorld():despawn(clientEntityId)

            -- Remove it from our lookup table
            entityIdMap[serverEntityId] = nil
            continue
        end

        local componentsToInsert = {}
        local componentsToRemove = {}

        -- Loop over all the components in the entity
        for name, container in componentMap do
            -- If container.data exists, the component was either changed or added.
            if container.data then
                table.insert(componentsToInsert, COMPONENTS.NAMES[name](container.data))
            else -- if it doesn't exist, it was removed!
                table.insert(componentsToRemove, COMPONENTS.NAMES[name])
            end
        end

        -- We haven't created this entity on the client before. create it.
        if clientEntityId == nil then
            clientEntityId = WorldServiceController:parmWorld():spawn(unpack(componentsToInsert))

            -- add the client-side entity id to our lookup table
            entityIdMap[serverEntityId] = clientEntityId
        else -- we've seen this entity before.

            -- Just insert or remove any necessary components.

            if #componentsToInsert > 0 then
                WorldServiceController:parmWorld():insert(clientEntityId, unpack(componentsToInsert))
            end

            if #componentsToRemove > 0 then
                WorldServiceController:parmWorld():remove(clientEntityId, unpack(componentsToRemove))
            end

        end
    end
end)

return {}