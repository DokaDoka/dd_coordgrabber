local function Raycast()
    local ped = PlayerPedId()
    local offset = GetOffsetFromEntityInWorldCoords(GetCurrentPedWeaponEntityIndex(ped), 0, 0, -0.01)
    local direction = GetGameplayCamRot()
    direction = vector2(direction.x * math.pi / 180.0, direction.z * math.pi / 180.0)
    local num = math.abs(math.cos(direction.x))
    direction = vector3((-math.sin(direction.y) * num), (math.cos(direction.y) * num), math.sin(direction.x))
    local destination = vector3(offset.x + direction.x * 30, offset.y + direction.y * 30, offset.z + direction.z * 30)
    local rayHandle, result, hit, endCoords, surfaceNormal, entityHit = StartShapeTestLosProbe(offset.x, offset.y, offset.z, destination.x, destination.y, destination.z, -1, ped, 0)
    repeat
        result, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)
        Wait(0)
    until result ~= 1
    return hit, entityHit
end

local function capture(raycast)
    local data = {}
    local entity
    if raycast then
        while true do
            Wait(0)
            if IsPlayerFreeAiming(PlayerId()) then
                local result, object = Raycast()
                if GetEntityType(object) ~= 0 then
                    if result and object ~= entity then
                        SetEntityDrawOutline(entity, false)
                        SetEntityDrawOutline(object, true)
                        entity = object
                    end
                end
            end
            if entity and IsControlPressed(0, 24) then
                SetEntityDrawOutline(entity, false)

                local coords = GetEntityCoords(entity)

                data.x = coords.x
                data.y = coords.y
                data.z = coords.z

                data.hash = GetEntityModel(entity)
                data.heading = GetEntityHeading(entity)

                return data
            end
        end
    else
        local plyPed = PlayerPedId()
        local coords = GetEntityCoords(plyPed)

        data.x = coords.x
        data.y = coords.y
        data.z = coords.z
        data.w = GetEntityHeading(plyPed)

        return data
    end
end

RegisterCommand('capture', function(source, args, rawCommand)
	if args[1] == 'shoot' then
        local data = capture(true)
        TriggerServerEvent('dd_tools:save', vec(data.x, data.y, data.z, data.heading))
    elseif args[1] == 'coords' then
        TriggerServerEvent('dd_tools:save', GetEntityCoords(cache.ped))
    end
end)
