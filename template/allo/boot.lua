local projHome = arg[1]
local url = arg[2]
local srcDir = projHome.."/lua"
local depsDir = projHome.."/allo/deps"
local libDir = projHome.."/allo/lib"

if string.match(package.cpath, "so") then
    package.cpath = package.cpath..";"..libDir.."/linux64/?.so"
elseif string.match(package.cpath, "dylib") then
    package.cpath = package.cpath..";"..libDir.."/osx64/?.dylib"
elseif string.match(package.cpath, "dll") then
    package.cpath = package.cpath..";"..libDir.."/win64/?.dll"
end

package.path = package.path
    ..";"..srcDir.."/%s/?.lua"
    ..";"..depsDir.."/alloui-lua/lua/?.lua"
    ..";"..depsDir.."/alloui-lua/lib/cpml/?.lua"
    ..";"..depsDir.."/alloui-lua/lib/pl/lua/?.lua"

-- Establish globals
require("liballonet")
Client = require("alloui.client")
ui = require("alloui.ui")

-- start app
require("main")