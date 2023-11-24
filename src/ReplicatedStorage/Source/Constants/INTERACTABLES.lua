--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GLOBAL = require(ReplicatedStorage.Source.Constants.GLOBAL)

local INTERACTABLES = {
    LOOK_AHEAD = GLOBAL.LOOK_AHEAD,

    TYPES = {
        LINEAR_OSCILLATOR = "LINEAR_OSCILLATOR"
    },

    LINEAR_OSCILLATOR = {
        AXIS_ATTRIBUTE = "AXIS",
        MAX_DISPLACEMENT_ATTRIBUTE = "MAX_DISPLACEMENT",
        PERIOD_ATTRIBUTE = "PERIOD",
        AXIS = {
            Y = Enum.Axis.Y,
            X = Enum.Axis.X,
            Z = Enum.Axis.Z,
        }
    }
}

return INTERACTABLES