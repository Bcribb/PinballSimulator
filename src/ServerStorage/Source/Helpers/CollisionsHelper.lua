--!strict

local CollectionService = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local GLOBAL = require(ReplicatedStorage.Source.Constants.GLOBAL)
local INTERACTABLES = require(ReplicatedStorage.Source.Constants.INTERACTABLES)
local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local DebugHelper = require(ReplicatedStorage.Source.Helpers.DebugHelper)
local VectorHelper = require(ReplicatedStorage.Source.Helpers.VectorHelper)
local InteractablesService = require(ServerStorage.Source.Services.InteractablesService)
local WorldServiceController = require(ReplicatedStorage.Source.SharedServiceControllers.WorldServiceController)

local CollisionsHelper = {}

local function shouldRoll()
    return false
end

function CollisionsHelper.handleCollisions(
    _step : {
        serverTime : number,
        position : Vector3,
        velocity : Vector3,
        acceleration : Vector3
    },
    _raycastResult : RaycastResult,
    _id : number
) 
    local step = {
        serverTime = _step.serverTime,
        position = _step.position,
        velocity = _step.velocity,
        acceleration = _step.acceleration
    }

    if _raycastResult then
        if GLOBAL.DEBUG then
            DebugHelper.createBallGhost(_raycastResult.Position, workspace)
        end

        local isInteractable : boolean = CollectionService:HasTag(_raycastResult.Instance, INTERACTABLES.INTERACTABLE_TAG)

        if isInteractable then
            step = InteractablesService:handleInteractable(step, _raycastResult, _id)
        else
            if shouldRoll() then
                WorldServiceController:parmWorld():insert(_id, COMPONENTS.ROLL({
                    planeNormal = _raycastResult.Normal,
                    planePoint = step.position
                }))
            else
                step.velocity = VectorHelper.reflect(step.velocity, _raycastResult.Normal)
            end
        end

        step.collides = _raycastResult.Instance
    end

    return step
end

return CollisionsHelper