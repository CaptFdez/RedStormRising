require("mist_4_3_74")

local log = mist.Logger:new("HandleMarkEvents", "info")

local M = {}

local function crate(text, pos)
    local weight = tonumber(text)
    log:info("Spawning red crate with weight $1 at $2", weight, pos)
    ctld.spawnCrateAtPoint("red", weight, pos)
end

local function destroy(text)
    local unit = Unit.getByName(text)
    if unit ~= nil then
        log:info("Destroying unit $1", text)
        unit:destroy()
    else
        log:warn("Unable to find unit with name $1", text)
    end
end
--- Handles mark removals
function M.markRemoved(event)
    if event.id == world.event.S_EVENT_MARK_REMOVED and event.text ~= nil then
        if event.text:find("-crate") then
            crate(string.sub(event.text, 8), event.pos)
        elseif event.text:find("-destroy") then
            destroy(string.sub(event.text, 10))
        end
    end
end

function M.registerHandlers(devMode)
    if devMode then
        mist.addEventHandler(M.markRemoved)
    end
end

return M
