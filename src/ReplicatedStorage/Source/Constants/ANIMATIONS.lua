local ReplicatedStorage = game:GetService("ReplicatedStorage")
--!strict

local ANIMATIONS = {
    BAT = {
        CHARGING = ReplicatedStorage.Assets.Animations.Bat_Charging,
        HITTING = ReplicatedStorage.Assets.Animations.Bat_Hitting,
        FOLLOW_THROUGH = ReplicatedStorage.Assets.Animations.Bat_FollowThrough
    }
}

return ANIMATIONS