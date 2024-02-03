--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local GLOBAL = require(ReplicatedStorage.Source.Constants.GLOBAL)

local INTERACTABLES = {
    INTERACTABLE_TAG = "INTERACTABLE",
    INTERACTABLE_TYPE_ATTRIBUTE = "INTERACTABLE_TYPE",
    LOOK_AHEAD = GLOBAL.LOOK_AHEAD,

    TYPES = {
        LINEAR_OSCILLATOR = "LINEAR_OSCILLATOR",
        BUMPER = "BUMPER"
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
    },

    BUMPER = {
        SPEED_INCREASE_ATTRIBUTE = "SPEED_INCREASE",
        ORIGINAL_SIZE_ATTRIBUTE = "ORIGINAL_SIZE"
    },

    INTERACTABLE_EFFECTS = {
        INCREASE_SPEED = "INCREASE_SPEED"
    }
}

return INTERACTABLES