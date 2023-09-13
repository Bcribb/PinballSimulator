--!strict

local VectorHelper = {}

-- Calculates displacement after _dt for given inputs
function VectorHelper.displacement(_velocity : Vector3, _acceleration : Vector3, _dt : number)
    return (_velocity * _dt) + 0.5 * (_acceleration * (_dt ^ 2)) 
end

-- Reflects _incident about _normal
function VectorHelper.reflect(_incident : Vector3, _normal : Vector3) : Vector3
	if (typeof(_incident) ~= "Vector3") or (typeof(_normal) ~= "Vector3") then
		error("Invalid inputs")
	end
	
	return _incident - (2 * _incident:Dot(_normal) * _normal)
end

-- Returns projection of _u onto _v
function VectorHelper.project(_u : Vector3, _v : Vector3) : Vector3
	if (typeof(_u) ~= "Vector3") or (typeof(_v) ~= "Vector3") then
		error("Invalid inputs")
	end
	
	return (_u:Dot(_v) / (_v.Magnitude ^ 2)) * _v
end

-- Projects _vector onto a plane defined by _normal
function VectorHelper.projectOntoPlane(_vector : Vector3, _normal : Vector3)
	return _vector - (_normal.Unit:Dot(_vector)) * _normal.Unit
end

-- Returns _point projected onto a plane defined _planePoint and _normal
function VectorHelper.projectPointOntoPlane(_point : Vector3, _planePoint : Vector3, _normal : Vector3)
	return _point - (_point - _planePoint):Dot(_normal.Unit) * _normal.Unit
end

-- Returns _vector rotated about _axis by _angle (radians)
function VectorHelper.rotate(_vector : Vector3, _axis : Enum.Axis | Vector3, _angle : number)
	local axis : Vector3 =
		if typeof(_axis) == "Vector3" then
			_axis
		else
			Vector3.FromAxis(_axis)

	return CFrame.fromAxisAngle(axis, _angle):VectorToWorldSpace(_vector)
end

-- Return the angle between _u and _v
function VectorHelper.angleBetween(_u : Vector3, _v : Vector3)
	return math.acos((_u:Dot(_v)) / (_u.Magnitude * _v.Magnitude))
end

function VectorHelper.vectorMax(_vector : Vector3, _maximums : Vector3)
	return Vector3.new(math.max(_vector.X, _maximums.X), math.max(_vector.Y, _maximums.Y), math.max(_vector.Z, _maximums.Z))
end

return VectorHelper