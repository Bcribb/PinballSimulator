--!strict

local WorldServiceController = {}

function WorldServiceController:parmWorld(_world)
    if _world then
        WorldServiceController.world = _world
    end

    return WorldServiceController.world
end

return WorldServiceController