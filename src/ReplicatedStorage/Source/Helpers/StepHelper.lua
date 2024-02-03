--!strict

local StepHelper = {}

function StepHelper.getCurrentAndNextSteps(_steps)
    local serverTime : number = workspace:GetServerTimeNow()
    local currentStep, nextStep

    if #_steps > 1 then
        nextStep = _steps[#_steps]

        for i = #_steps - 1, 1, -1 do
            local checkStep = _steps[i]

            if checkStep.serverTime > serverTime then
                nextStep = checkStep
            else
                currentStep = checkStep
                break
            end
        end
    else
        currentStep = _steps[1]
        nextStep = _steps[1]
    end

    return currentStep, nextStep
end

return StepHelper