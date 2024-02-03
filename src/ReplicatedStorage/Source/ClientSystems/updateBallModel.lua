--strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local StepHelper = require(ReplicatedStorage.Source.Helpers.StepHelper)

local function updateBallModel(_world)
    local serverTime : number = workspace:GetServerTimeNow()

    for id, ball, steps, model in _world:query(COMPONENTS.BALL, COMPONENTS.STEPS, COMPONENTS.MODEL) do
        local currentStep, nextStep = StepHelper.getCurrentAndNextSteps(steps.steps)

        local timeDifference : number = nextStep.serverTime - currentStep.serverTime
        local alpha : number = serverTime - currentStep.serverTime
        local newPosition = currentStep.position:Lerp(nextStep.position, alpha / timeDifference)

        model.model:PivotTo(CFrame.new(newPosition))
    end
end

return updateBallModel