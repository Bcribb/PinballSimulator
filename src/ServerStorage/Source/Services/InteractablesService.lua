--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local INTERACTABLES = require(ReplicatedStorage.Source.Constants.INTERACTABLES)

local VectorHelper = require(ReplicatedStorage.Source.Helpers.VectorHelper)

local InteractablesService = {}

function InteractablesService:handleInteractable(_step, _raycastResult : RaycastResult, _id : number)
    local interactable : Instance = _raycastResult.Instance
    local interactableType : string = interactable:GetAttribute(INTERACTABLES.INTERACTABLE_TYPE_ATTRIBUTE)
    local step = table.clone(_step)

    if interactableType == INTERACTABLES.TYPES.BUMPER then
        local speedIncrease : number = interactable:GetAttribute(INTERACTABLES.BUMPER.SPEED_INCREASE_ATTRIBUTE)

        step.velocity = VectorHelper.reflect(
            step.velocity,
            _raycastResult.Normal
        )
        step.velocity += step.velocity.Unit * speedIncrease
    end

    return step
end

return InteractablesService