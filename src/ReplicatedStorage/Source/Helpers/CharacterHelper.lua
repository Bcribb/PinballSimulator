--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local CharacterHelper = {
    animationTracks = {}
}

local function onCharacterAdded(_character : Model)
end

function CharacterHelper.getCharacter(_player : Player, _wait : boolean)
    local player : Player = if _player then _player else Players.LocalPlayer

    local character : Model = player.Character or if _wait then player.CharacterAdded:Wait() else nil

    return character
end

function CharacterHelper.getHrp(_player : Player, _wait : boolean)
    local player : Player = if _player then _player else Players.LocalPlayer

    local character : Model = CharacterHelper.getCharacter(player, _wait)
    local hrp : Part

    if character then
        hrp = character:FindFirstChild("HumanoidRootPart") or if _wait then character:WaitForChildChild("HumanoidRootPart") else nil
    end

    return hrp
end

function CharacterHelper.getHumanoid(_player : Player, _wait : boolean)
    local player : Player = if _player then _player else Players.LocalPlayer

    local character : Model = CharacterHelper.getCharacter(player, _wait)
    local humanoid : Humanoid

    if character then
        humanoid = character:FindFirstChild("Humanoid") or if _wait then character:WaitForChild("Humanoid") else nil
    end

    return humanoid
end

function CharacterHelper.getAnimator(_player : Player, _wait : boolean)
    local player : Player = if _player then _player else Players.LocalPlayer

    local humanoid : Humanoid = CharacterHelper.getHumanoid(player, _wait)
    local animator : Animator

    if humanoid then
        animator = humanoid:FindFirstChild("Animator") or if _wait then humanoid:WaitForChild("Animator") else nil
    end

    return animator
end

function CharacterHelper.getMouse(_player : Player)
    local player : Player = if _player then _player else Players.LocalPlayer

    return player:GetMouse()
end

if Players.LocalPlayer and Players.LocalPlayer.Character then
    onCharacterAdded(Players.LocalPlayer and Players.LocalPlayer.Character)
end

return CharacterHelper