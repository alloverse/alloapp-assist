local projHome = arg[1]
local url = arg[2]
local srcDir = projHome.."/lua"
local depsDir = projHome.."/allo/deps"
local libDir = projHome.."/allo/lib"

function os.system(cmd, notrim)
    local f = assert(io.popen(cmd, 'r'))
    local s = assert(f:read('*l'))
    f:close()
    if notrim then return s end
    s = string.gsub(s, '^%s+', '')
    s = string.gsub(s, '%s+$', '')
    return s
end

function os.uname()
    return os.system("uname -s")
end

local dylibext = ""
if os.uname():find("^Darwin") ~= nil then
    dylibext = "dylib"
elseif string.match(package.cpath, "so") then
    dylibext = "so"
elseif string.match(package.cpath, "dll") then
    dylibext = "dll"
end

package.path = package.path
    ..";"..srcDir.."/?.lua"
    ..";"..depsDir.."/alloui/lua/?.lua"
    ..";"..depsDir.."/alloui/lib/cpml/?.lua"
    ..";"..depsDir.."/alloui/lib/pl/lua/?.lua"
    

-- Load allonet
local ffi = require 'ffi'
allonet = ffi.load(libDir .. "/liballonet."..dylibext, false)

-- Then, load allonet_av if available
local liballonet_av_location = libDir .. "/liballonet_av."..dylibext
local libav_available, av = pcall(ffi.load, liballonet_av_location, true)
if libav_available then
    print("liballonet_av loaded with libavcodec support")
    ffi.cdef [[
    void allo_libav_initialize(void);
    ]]
    ffi.C.allo_libav_initialize()
else
    print("NOTE: liballonet_av not available, h264 cannot be used (because: "..av..")")
    av = nil
end

Client = require("alloui.client")
ui = require("alloui.ui")
class = require('pl.class')
tablex = require('pl.tablex')
pretty = require('pl.pretty')
vec3 = require("modules.vec3")
mat4 = require("modules.mat4")

ui.App.initialLocation = nil
ui.VideoSurface.libavAvailable = libav_available
if arg[3] then
    local ms = {string.match(arg[3], "([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+), ([-+\\.%d]+)")}
    local x, y, z = string.match(arg[3], "([-+\\.%d]+),([-+\\.%d]+),([-+\\.%d]+)")
    if #ms == 16 then
        local mn = tablex.map(function(s) return tonumber(s) end, ms)
        local m = mat4(mn)
        ui.App.initialLocation = m
    elseif z then
        ui.App.initialLocation = mat4.translate(mat4(), mat4(), vec3(tonumber(x), tonumber(y), tonumber(z)))
    end
end

-- start app
require("main")
