--!strict

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)
local INTERACTABLES = require(ReplicatedStorage.Source.Constants.INTERACTABLES)

local StepHelper = require(ReplicatedStorage.Source.Helpers.StepHelper)

local function handleCollisions(_world)
    for _, _, steps in _world:query(COMPONENTS.BALL, COMPONENTS.STEPS) do
        local currentStep, _ = StepHelper.getCurrentAndNextSteps(steps.steps)

        if currentStep.collides then
            if CollectionService:HasTag(currentStep.collides, INTERACTABLES.INTERACTABLE_TAG) then
                local originalSize : Vector3 = currentStep.collides:GetAttribute(INTERACTABLES.BUMPER.ORIGINAL_SIZE_ATTRIBUTE)
                local goal = {
                    Size = originalSize
                }
                currentStep.collides.Size = originalSize + Vector3.new(0, 2, 2)

                local tweenInfo : TweenInfo = TweenInfo.new(1)
                local tween : Tween = TweenService:Create(currentStep.collides, tweenInfo, goal)
                
                tween:Play()
            end

            currentStep.collides = nil
        end
    end
end

return handleCollisions