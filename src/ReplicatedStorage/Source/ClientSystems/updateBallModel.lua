--strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local function updateBallModel(_world)
    local serverTime : number = workspace:GetServerTimeNow()

    for id, ball, steps, model in _world:query(COMPONENTS.BALL, COMPONENTS.STEPS, COMPONENTS.MODEL) do
        local currentStep, nextStep

        if #steps.steps > 1 then
            nextStep = steps.steps[#steps.steps]

            for i = #steps.steps - 1, 1, -1 do
                local checkStep = steps.steps[i]

                if checkStep.serverTime > serverTime then
                    nextStep = checkStep
                else
                    currentStep = checkStep
                    break
                end
            end
        else
            currentStep = steps.steps[1]
            nextStep = steps.steps[1]
        end

        local timeDifference : number = nextStep.serverTime - currentStep.serverTime
        local alpha : number = serverTime - currentStep.serverTime
        local newPosition = currentStep.position:Lerp(nextStep.position, alpha / timeDifference)

        model.model:PivotTo(CFrame.new(newPosition))
    end
end

return updateBallModel