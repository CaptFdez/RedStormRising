local M = {}

local function iterUnits(mission, callback)
    for _, coalition in pairs(mission.coalition) do
        for _, country in ipairs(coalition.country) do
            if country.helicopter ~= nil then
                -- Skip if no helicopters
                for _, helicopterGroups in pairs(country.helicopter) do
                    for _, helicopterGroup in ipairs(helicopterGroups) do
                        for _, helicopterUnit in ipairs(helicopterGroup.units) do
                            callback(helicopterUnit)
                        end
                    end
                end
            end
            if country.plane ~= nil then
                -- Skip if no planes
                for _, airplaneGroups in pairs(country.plane) do
                    for _, airplaneGroup in ipairs(airplaneGroups) do
                        for _, airplaneUnit in ipairs(airplaneGroup.units) do
                            callback(airplaneUnit)
                        end
                    end
                end
            end
        end
    end
end

function M.getTransportPilotNames(mission, unitTypes)
    local names = {}
    iterUnits(mission, function(unitData)
        for _, unitType in ipairs(unitTypes) do
            if unitData.type == unitType then
                table.insert(names, unitData.name)
                break
            end
        end
    end)
    return names
end

return M