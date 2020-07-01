local client = Client(
    arg[1], 
    "myprojectname"
)
local app = App(client)

local controlBoard = ui.Surface(ui.Bounds(0, 0.7, 0,   1, 0.5, 0.1))
local button = ui.Button(ui.Bounds(0.0, 0.05, 0.0,   0.2, 0.2, 0.1))
local grabHandle = ui.GrabHandle(ui.Bounds( -0.5, 0.5, 0.3,   0.2, 0.2, 0.2))
controlBoard:addSubview(button)
controlBoard:addSubview(grabHandle)

button.onActivated = function()
    print("Hello!")
end

app.mainView = jukebox
app:connect()
app:run()