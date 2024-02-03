--!strict

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ANIMATIONS = require(ReplicatedStorage.Source.Constants.ANIMATIONS)

local CharacterHelper = require(ReplicatedStorage.Source.Helpers.CharacterHelper)

local AnimationController = {}

function AnimationController:load()
    local humanoid : Humanoid = CharacterHelper.getHumanoid(Players.LocalPlayer, true)

    AnimationController.tracks = {
        charging = humanoid:LoadAnimation(ANIMATIONS.BAT.CHARGING),
        hitting = humanoid:LoadAnimation(ANIMATIONS.BAT.HITTING),
        followThrough = humanoid:LoadAnimation(ANIMATIONS.BAT.FOLLOW_THROUGH)
    }
end

function AnimationController:play()
    AnimationController.tracks.charging:Play()

    AnimationController.tracks.charging.Stopped:Connect(function()
        AnimationController:stop()
    end)
end

function AnimationController:stop()
    AnimationController.tracks.charging:Stop()
end

AnimationController:load()

return AnimationController