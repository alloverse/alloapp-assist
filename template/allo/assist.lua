local here = arg[1]
package.path = package.path .. ';'..here..'/?.lua'
local json = require "json"


if arg[2] == "create-lock" then
    local buildsf = io.open(here.."/builds.json", "r")
    local buildss = buildsf:read("*a")
    buildsf:close()
    local buildsj = json.decode(buildss)
    local latestId = tostring(buildsj["value"][1]["id"])
    print("Latest Allonet build ID is " .. latestId)
    local lockf = io.open(here.."/allonet.lock", "w")
    lockf:write(latestId)
    lockf:close()
end