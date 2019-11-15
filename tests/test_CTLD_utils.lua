local lu = require("tests.luaunit")
local ctldUtils = require("CTLD_utils")

TestCtldUtils = {}

function TestCtldUtils:testGetTransportPilotNames()
    local x = ctldUtils.getTransportPilotNames()
    lu.assertEquals(#x, 234)
end

local runner = lu.LuaUnit.new()
os.exit(runner:runSuite())

