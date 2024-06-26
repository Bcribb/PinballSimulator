--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Matter = require(ReplicatedStorage.Packages.matter)

local COMPONENTS = {
    -- EVENTS
    BALL_REQUEST = Matter.component("BALL_REQUEST"),

    -- DATA
    BALL = Matter.component("BALL"),
    STEPS = Matter.component("STEPS"),
    OWNER = Matter.component("OWNER"),
    TIME = Matter.component("TIME"),

    -- ATTRIBUTES
    SIZE = Matter.component("SIZE"),
    POSITION = Matter.component("POSITION"),
    VELOCITY = Matter.component("VELOCITY"),
    GRAVITY = Matter.component("GRAVITY"),
    ORIGIN = Matter.component("ORIGIN"),

    -- MODIFIERS
    ROLL = Matter.component("PLANE_NORMAL"),

    -- BEHAVIOUR
    LINEAR_OSCILLATION = Matter.component("LINEAR_OSCILLATION"),

    -- INSTANCES
    MODEL = Matter.component("MODEL")
}

local REPLICATED_COMPONENTS = {}

COMPONENTS.REPLICATED_COMPONENTS = REPLICATED_COMPONENTS

return COMPONENTS