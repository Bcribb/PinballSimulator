--!strict

local CollectionService = game:GetService("CollectionService")

local function onTaggedAdded(_instance)
    local animationController : AnimationController = _instance.AnimationController
    local animator : Animator = animationController.Animator
    local animation : Animation = Instance.new("Animation")
    animation.AnimationId = "rbxassetid://15441969790"

    local animationTrack : AnimationTrack = animator:LoadAnimation(animation)
    animationTrack.Looped = true
    animationTrack:Play()
end

for _, tagged in CollectionService:GetTagged("TEST") do
   onTaggedAdded(tagged) 
end
CollectionService:GetInstanceAddedSignal("TEST"):Connect(onTaggedAdded)

return {}