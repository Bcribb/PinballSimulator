--!strict

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local INTERACTABLES = require(ReplicatedStorage.Source.Constants.INTERACTABLES)
local GLOBAL = require(ReplicatedStorage.Source.Constants.GLOBAL)
local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local WorldServiceController = require(ReplicatedStorage.Source.SharedServiceControllers.WorldServiceController)

local InteractableServiceController = {}

local function makeInvisible(_model : Model)
    for _, descendant in _model:GetDescendants() do
        if descendant.Transparency then
            descendant.Transparency = 1
        end
    end
end

local function initaliseModel(_model : Model)
    local model : Model = if RunService:IsClient() then _model:Clone() else _model
    model.Parent = _model.Parent

    if RunService:IsServer() and not GLOBAL.DEBUG then
        makeInvisible(_model)
    end
    
    return model
end

local function onLinearOscillatorAdded(_model : Model)
    local model : Model = initaliseModel(_model)

    WorldServiceController:parmWorld():spawn(
        COMPONENTS.MODEL({
            model = model
        }),
        COMPONENTS.LINEAR_OSCILLATION({
            axis = INTERACTABLES.LINEAR_OSCILLATOR.AXIS[_model:GetAttribute(INTERACTABLES.LINEAR_OSCILLATOR.AXIS_ATTRIBUTE)],
            maxDisplacement = _model:GetAttribute(INTERACTABLES.LINEAR_OSCILLATOR.MAX_DISPLACEMENT_ATTRIBUTE),
            period = _model:GetAttribute(INTERACTABLES.LINEAR_OSCILLATOR.PERIOD_ATTRIBUTE)
        }),
        COMPONENTS.ORIGIN({
            position = _model.PrimaryPart.CFrame.Position,
            rotation = _model.PrimaryPart.CFrame.Rotation
        })
    )
end

local function onInteractableAdded(_tagged : Model)
    if _tagged:GetAttribute(INTERACTABLES.INTERACTABLE_TYPE_ATTRIBUTE) then
        if _tagged:GetAttribute(INTERACTABLES.INTERACTABLE_TYPE_ATTRIBUTE) == INTERACTABLES.TYPES.BUMPER then
            _tagged:SetAttribute(INTERACTABLES.BUMPER.ORIGINAL_SIZE_ATTRIBUTE, _tagged.Size)
        end
    end
end

for _, tagged in CollectionService:GetTagged(INTERACTABLES.TYPES.LINEAR_OSCILLATOR) do
    onLinearOscillatorAdded(tagged)
end
CollectionService:GetInstanceAddedSignal(INTERACTABLES.TYPES.LINEAR_OSCILLATOR):Connect(onLinearOscillatorAdded)

for _, tagged in CollectionService:GetTagged(INTERACTABLES.INTERACTABLE_TAG) do
    onInteractableAdded(tagged)
end

return InteractableServiceController