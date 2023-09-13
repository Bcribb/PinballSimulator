--!strict

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local UiController = {}

for _, module in ReplicatedStorage.Source.Ui:GetChildren() do
    require(module)
end

return UiController