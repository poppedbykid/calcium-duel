-- ═══════════════════════════════════════════
--  Enter your key below
-- ═══════════════════════════════════════════

local KEY = "YOUR_KEY_HERE"  -- ← Change this to your key!

-- ═══════════════════════════════════════════
--  Do not touch anything below this line!
-- ═══════════════════════════════════════════

local API_URL = "http://77.169.255.80:8080"

local function getHWID()
    return game:GetService("RbxAnalyticsService"):GetClientId()
end

local function validateKey(key, hwid)
    local url = API_URL .. "/validate?key=" .. key .. "&hwid=" .. hwid
    local success, response = pcall(function()
        return game:HttpGet(url)
    end)
    if not success then
        return false, "Could not connect to the server"
    end
    local ok, data = pcall(function()
        return game:GetService("HttpService"):JSONDecode(response)
    end)
    if not ok then
        return false, "Invalid server response"
    end
    return data.success, data.message
end

local function createGUI(message, success)
    local player = game.Players.LocalPlayer
    local gui = Instance.new("ScreenGui")
    gui.Name = "LoaderGUI"
    gui.ResetOnSpawn = false
    gui.Parent = player.PlayerGui

    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 400, 0, 100)
    frame.Position = UDim2.new(0.5, -200, 0.05, 0)
    frame.BackgroundColor3 = success and Color3.fromRGB(20, 30, 20) or Color3.fromRGB(30, 20, 20)
    frame.BorderSizePixel = 0
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    local stroke = Instance.new("UIStroke")
    stroke.Color = success and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 60, 60)
    stroke.Thickness = 2
    stroke.Parent = frame

    local title = Instance.new("TextLabel")
    title.Size = UDim2.new(1, 0, 0, 35)
    title.Position = UDim2.new(0, 0, 0, 5)
    title.BackgroundTransparency = 1
    title.Text = success and "✅ Key Validated!" or "❌ Invalid Key"
    title.TextColor3 = success and Color3.fromRGB(0, 255, 100) or Color3.fromRGB(255, 60, 60)
    title.TextScaled = true
    title.Font = Enum.Font.GothamBold
    title.Parent = frame

    local msg = Instance.new("TextLabel")
    msg.Size = UDim2.new(1, -20, 0, 40)
    msg.Position = UDim2.new(0, 10, 0, 45)
    msg.BackgroundTransparency = 1
    msg.Text = message
    msg.TextColor3 = Color3.fromRGB(200, 200, 200)
    msg.TextScaled = true
    msg.Font = Enum.Font.Gotham
    msg.Parent = frame

    task.delay(4, function()
        gui:Destroy()
    end)
end

-- ── MAIN ──────────────────────────────────
if KEY == "YOUR_KEY_HERE" or KEY == "" then
    createGUI("Please enter your key at the top of the script!", false)
    return
end

local HWID = getHWID()
local valid, msg = validateKey(KEY, HWID)
createGUI(msg, valid)

if valid then
    loadstring(game:HttpGet("https://pastebin.com/raw/L9mDuyvp", true))()
else
    warn("[Loader] Validation failed: " .. msg)
end
