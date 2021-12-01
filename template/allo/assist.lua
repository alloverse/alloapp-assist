local here = arg[1]
local g_here = here
local g_branchname = "main"
local g_platform = None

package.path = package.path .. ';'..here..'/?.lua;'..here..'/deps/alloui/lib/pl/lua/?.lua'
local json = require "json"
local tablex = require"pl.tablex"


local g_platform_file_map = {
    ["linux-x64"] =   { file = "liballonet.so" },
    ["windows-x64"] = { file = "allonet.dll" },
    ["mac-universal"] = { file = "liballonet.dylib" }
}

--- Write the allonet.lock file
-- version: x.y.z.githash
function save(version)
    print("Latest Allonet build version is " .. version)
    writefile(here .. "/allonet.lock", version)
end

--------------------------------------------------------------

local s3_root = "http://alloverse-downloads-prod.s3-eu-north-1.amazonaws.com/allonet" --alloverse-downloads-prod/allonet/"

--- Check lock file and download binaries for that version
-- If lockfile is empty do upgrade
function fetch(version)
    version = version or get_current_version() or get_latest_version()
    if not version then 
        return print("Could not determine version to fetch")
    end

    print("Downloading version " .. version)

    local file = g_platform_file_map[g_platform].file
    download(s3_root .. "/" .. version .. "/" .. g_platform .. "/" .. file, g_here .. "/lib/" .. file)
end

--- Download the latest meta. If versions differ then save version to lock file, fetch the version
function upgrade()
    local latest_version = get_latest_version()
    local current_version = get_current_version()

    if not latest_version then
        return print("Failed to read latest version")
    end

    if not current_version or (current_version ~= latest_version) then
        print("Found a new version")
        save(latest_version)
        fetch()
        return
    end

    print("You are already on the latest version.")
end

function download(url, dest)
    system("curl -fsSL \"" .. url .. "\" > " .. dest)
end

-------------------------------------------------------------------

--- Returns None or "x.y.z.githash"
function get_current_version() 
    local cachefilepath = here .. "/lib/allonet.cache"
    local currentVersion = trim(readfile(cachefilepath))
end

--- Returns the meta json for the latest available build
-- {
--     "version": "${VERSION}",
--     "platform": "${PLATFORM}",
--     "branch": "${BUILD_SOURCEBRANCHNAME}",
--     "buildid": "${BUILD_BUILDID}",
--     "buildnumber": "${BUILD_BUILDNUMBER}",
--     "githash": "${BUILD_SOURCEVERSION}",
--     "changemsg": "${BUILD_SOURCEVERSIONMESSAGE}"
-- }
function get_latest_json()
    local path = "latest_" .. g_branchname .. "_" .. g_platform .. ".json"
    local url = s3_root .. "/" .. path
    local jsons = system("curl -fsSL \"" .. url .. "\"")
    local json = json.decode(jsons)
    return json
end

function get_latest_version()
    local latest = get_latest_json()
    if latest then 
        return latest["version"] .. "." .. latest["githash"] 
    end
end

function system(cmd)
    --print("system("..cmd..")")
    local handle = io.popen(cmd)
    local result = handle:read("*a")
    handle:close()
    return trim(result)
end

function readfile(path)
    local f = io.open(path, "r")
    if f == nil then
        return ""
    end
    local s = f:read("*a")
    f:close()
    return s
end

function writefile(path, content)
    local f = io.open(path, "w")
    f:write(content)
    f:close()
end

function file_exists(path)
    local f=io.open(path,"r")
    if f~=nil then 
        io.close(f)
        return true
    else 
        return false
    end
end

function trim(s)
    return (s:gsub("^%s*(.-)%s*$", "%1"))
end

function all(t, f)
    for k, v in ipairs(t) do
        if f(v) == false then
            return false
        end
    end
    return true
end

function get_current_platform()
    local uname = system("uname -s")
    if uname == "Darwin" then
        return "mac-universal"
    elseif uname == "Linux" then
        return "linux-x64"
    elseif uname == "CYGWIN" or uname == "MINGW" then
        return "windows-x64"
    else
        return None
    end
end

--------------------------------------------------------------
--------------------------------------------------------------

local g_platform = get_current_platform()
if not g_platform then
    print("Could not determine your platform. Please reach out to us via email or our Discord. Details on alloverse.com")
    return
end

if arg[2] == "fetch" then
    g_branchname = arg[3] or g_branchname
    fetch()
elseif arg[2] == "upgrade" then 
    upgrade()
end
