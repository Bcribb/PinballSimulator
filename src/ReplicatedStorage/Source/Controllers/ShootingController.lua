--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ContextActionService = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")
local ClientComm = require(ReplicatedStorage.Packages.Comm).ClientComm

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local WorldServiceController = require(ReplicatedStorage.Source.SharedServiceControllers.WorldServiceController)
local CharacterHelper = require(ReplicatedStorage.Source.Helpers.CharacterHelper)

local clientComm = ClientComm.new(ReplicatedStorage, true, "BallService")
local comm = clientComm:BuildObject()

local ShootingController = {}

local function handleButtonDown(_actionName : string, _inputState : Enum.UserInputState, _inputObject : InputObject)
    if _inputState == Enum.UserInputState.Begin then
        local serverTime : number = workspace:GetServerTimeNow()
        local mouseHitPosition : Vector3 = CharacterHelper.getMouse().Hit.Position
        local characterPosition : Vector3 = CharacterHelper.getCharacter().PrimaryPart.Position
        local shotDirection : Vector3 = (mouseHitPosition - characterPosition).Unit

        comm:shoot(serverTime, characterPosition, shotDirection)
    end
end

ContextActionService:BindAction("Shoot", handleButtonDown, false, Enum.UserInputType.MouseButton1)

return ShootingController