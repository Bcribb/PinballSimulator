--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GLOBAL = require(ReplicatedStorage.Source.Constants.GLOBAL)

local BALL_BEHAVIOUR = {
    LOOK_AHEAD = GLOBAL.LOOK_AHEAD,
    TIME_INCREMENT = 0.2
}

return BALL_BEHAVIOUR