--!strict

local RunService = game:GetService("RunService")

local DebugHelper = {}

function DebugHelper.createDirectionIndicator(_origin : Vector3, _direction : Vector3, _length : number, _folder : Folder)
    local cone : ConeHandleAdornment = Instance.new("ConeHandleAdornment")

    cone.Adornee = workspace
    cone.Parent = _folder
    cone.Radius = 0.2
    cone.Height = _length
    cone.Color3 = if RunService:IsServer() then Color3.new(0.27450980392156865, 0.050980392156862744, 0.8941176470588236) else Color3.new(1, 0.0784313725490196, 0.0784313725490196)
    cone.CFrame = CFrame.new(_origin, _origin + _direction)

    return cone
end

function DebugHelper.createBallGhost(_position : Vector3, _folder : Folder)
    local part : Part = Instance.new("Part")

    part.Size = Vector3.new(0.5, 0.5, 0.5)
    part.Shape = Enum.PartType.Ball
    part.Color = if RunService:IsServer() then Color3.new(0.27450980392156865, 0.050980392156862744, 0.8941176470588236) else Color3.new(1, 0.0784313725490196, 0.0784313725490196)
    part.CFrame = CFrame.new(_position)
    part.Transparency = 0.5
    part.CanCollide = false
    part.CanQuery = false
    part.Anchored = true
    part.Parent = _folder

    return part
end

return DebugHelper