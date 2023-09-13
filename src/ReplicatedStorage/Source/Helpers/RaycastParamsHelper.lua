--!strict

local Players = game:GetService("Players")

local RaycastParamsHelper = {}

RaycastParamsHelper.ballRaycastParams = RaycastParams.new()

Players.PlayerAdded:Connect(function(_player : Player)
    _player.CharacterAdded:Connect(function(_character : Model)
        RaycastParamsHelper.ballRaycastParams:AddToFilter(_character)
    end)
end)
for _, player in Players:GetPlayers() do
    player.CharacterAdded:Connect(function(_character : Model)
        RaycastParamsHelper.ballRaycastParams:AddToFilter(_character)
    end)

    if player.Character then
        RaycastParamsHelper.ballRaycastParams:AddToFilter(player.Character)
    end
end

return RaycastParamsHelper