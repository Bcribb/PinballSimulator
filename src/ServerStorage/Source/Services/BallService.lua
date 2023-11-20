--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")
local ServerComm = require(ReplicatedStorage.Packages.Comm).ServerComm

local WorldServiceController = require(ReplicatedStorage.Source.SharedServiceControllers.WorldServiceController)

local COMPONENTS = require(ReplicatedStorage.Source.Constants.COMPONENTS)

local serverComm = ServerComm.new(ReplicatedStorage, "BallService")

local BallService = {}

local function onShot(_player : Player, _serverTime : number, _origin : Vector3, _shotDirection : Vector3)
    WorldServiceController:parmWorld():spawn(COMPONENTS.BALL_REQUEST({
        player = _player,
        serverTime = _serverTime,
        position = _origin,
        direction = _shotDirection.Unit
    }))
end

serverComm:BindFunction("shoot", onShot)

return BallService