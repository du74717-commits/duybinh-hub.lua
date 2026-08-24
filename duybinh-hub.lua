-- DUYBINH HUB | LOCAL KEY GATE
-- Key: duybinhhub
-- Expires: NEVER
-- Old saved keys: automatically removed
-- Get Key: Key là: duybinhhub

local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")

local CONFIG = {
    KEY = "duybinhhub",
    SAVE_FILE = "DuybinhHub_Key.json",
    SCRIPT_URL = "https://vss.pandauth.com/kv/c96fbaae7252d36e",
    GET_KEY_MESSAGE = "Key là: duybinhhub",
}

local Player = Players.LocalPlayer

-- Kiểm tra API file
local function hasFileAPI()
    return type(isfile) == "function"
        and type(readfile) == "function"
        and type(writefile) == "function"
        and type(delfile) == "function"
end

-- Xóa key cũ
local function deleteOldKey()
    if not hasFileAPI() then
        return
    end

    pcall(function()
        if isfile(CONFIG.SAVE_FILE) then
            delfile(CONFIG.SAVE_FILE)
        end
    end)
end

-- Kiểm tra key đã lưu
-- Chỉ chấp nhận duybinhhub
local function getSavedKey()
    if not hasFileAPI() then
        return false
    end

    local ok, result = pcall(function()
        if not isfile(CONFIG.SAVE_FILE) then
            return false
        end

        local data = HttpService:JSONDecode(
            readfile(CONFIG.SAVE_FILE)
        )

        if type(data) ~= "table" then
            deleteOldKey()
            return false
        end

        -- Nếu là key cũ thì xóa ngay
        if data.key ~= CONFIG.KEY then
            deleteOldKey()
            return false
        end

        return true
    end)

    if not ok then
        deleteOldKey()
        return false
    end

    return result == true
end

-- Lưu key mới vô hạn
local function saveNewKey()
    if not hasFileAPI() then
        return
    end

    -- Xóa toàn bộ key cũ trước
    deleteOldKey()

    -- Lưu key mới duybinhhub
    local payload = {
        key = CONFIG.KEY,
        activatedAt = os.time(),
        expires = "never",
    }

    pcall(function()
        writefile(
            CONFIG.SAVE_FILE,
            HttpService:JSONEncode(payload)
        )
    end)
end

-- Chạy script chính
local function runProtectedScript()
    local ok, err = pcall(function()
        loadstring(
            game:HttpGet(CONFIG.SCRIPT_URL)
        )()
    end)

    if not ok then
        warn("[Duybinh Hub] Script error:", err)
    end
end

-- Chỉ chạy tự động nếu key đã lưu chính xác là duybinhhub
if getSavedKey() then
    runProtectedScript()
    return
end

-- =========================
-- GUI
-- =========================

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DuybinhHubKeySystem"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.Parent = Player:WaitForChild("PlayerGui")

local Main = Instance.new("Frame")
Main.Size = UDim2.fromOffset(520, 260)
Main.Position = UDim2.new(0.5, -260, 0.5, -130)
Main.BackgroundColor3 = Color3.fromRGB(24, 24, 30)
Main.BorderSizePixel = 0
Main.Parent = ScreenGui

Instance.new("UICorner", Main).CornerRadius = UDim.new(0, 14)

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -30, 0, 60)
Title.Position = UDim2.fromOffset(15, 12)
Title.BackgroundTransparency = 1
Title.Text = "DUYBINH HUB | KEY SYSTEM"
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.Parent = Main

local Info = Instance.new("TextLabel")
Info.Size = UDim2.new(1, -30, 0, 30)
Info.Position = UDim2.fromOffset(15, 65)
Info.BackgroundTransparency = 1
Info.Text = "Nhập key để mở hub • Hạn key: Vô hạn"
Info.Font = Enum.Font.Gotham
Info.TextSize = 14
Info.TextColor3 = Color3.fromRGB(185, 185, 195)
Info.TextXAlignment = Enum.TextXAlignment.Left
Info.Parent = Main

local KeyBox = Instance.new("TextBox")
KeyBox.Size = UDim2.new(1, -30, 0, 52)
KeyBox.Position = UDim2.fromOffset(15, 110)
KeyBox.BackgroundColor3 = Color3.fromRGB(37, 37, 45)
KeyBox.BorderSizePixel = 0
KeyBox.PlaceholderText = "Nhập key..."
KeyBox.Text = ""
KeyBox.Font = Enum.Font.Gotham
KeyBox.TextSize = 16
KeyBox.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyBox.PlaceholderColor3 = Color3.fromRGB(140, 140, 150)
KeyBox.ClearTextOnFocus = false
KeyBox.Parent = Main

Instance.new("UICorner", KeyBox).CornerRadius = UDim.new(0, 10)

-- LEFT: CHECK KEY
local CheckButton = Instance.new("TextButton")
CheckButton.Size = UDim2.fromOffset(235, 55)
CheckButton.Position = UDim2.fromOffset(15, 185)
CheckButton.BackgroundColor3 = Color3.fromRGB(55, 75, 100)
CheckButton.BorderSizePixel = 0
CheckButton.Text = "CHECK KEY"
CheckButton.Font = Enum.Font.GothamBold
CheckButton.TextSize = 15
CheckButton.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckButton.Parent = Main

Instance.new("UICorner", CheckButton).CornerRadius = UDim.new(0, 10)

-- RIGHT: GET KEY
local GetKeyButton = Instance.new("TextButton")
GetKeyButton.Size = UDim2.fromOffset(235, 55)
GetKeyButton.Position = UDim2.fromOffset(270, 185)
GetKeyButton.BackgroundColor3 = Color3.fromRGB(75, 55, 100)
GetKeyButton.BorderSizePixel = 0
GetKeyButton.Text = "GET KEY"
GetKeyButton.Font = Enum.Font.GothamBold
GetKeyButton.TextSize = 15
GetKeyButton.TextColor3 = Color3.fromRGB(255, 255, 255)
GetKeyButton.Parent = Main

Instance.new("UICorner", GetKeyButton).CornerRadius = UDim.new(0, 10)

local Status = Instance.new("TextLabel")
Status.Size = UDim2.new(1, -30, 0, 28)
Status.Position = UDim2.new(0, 15, 1, 8)
Status.BackgroundTransparency = 1
Status.Text = ""
Status.Font = Enum.Font.GothamBold
Status.TextSize = 14
Status.TextXAlignment = Enum.TextXAlignment.Center
Status.Parent = Main

-- CHECK KEY
CheckButton.MouseButton1Click:Connect(function()
    local enteredKey = KeyBox.Text

    if enteredKey == CONFIG.KEY then
        Status.Text = "✓ KEY ĐÚNG - ĐANG MỞ DUYBINH HUB"
        Status.TextColor3 = Color3.fromRGB(90, 255, 130)

        -- Xóa toàn bộ key cũ rồi mới lưu duybinhhub
        saveNewKey()

        task.wait(0.5)

        ScreenGui:Destroy()
        runProtectedScript()
    else
        Status.Text = "✗ KEY KHÔNG ĐÚNG"
        Status.TextColor3 = Color3.fromRGB(255, 90, 90)
    end
end)

-- GET KEY
GetKeyButton.MouseButton1Click:Connect(function()
    Status.Text = "Key là: duybinhhub"
    Status.TextColor3 = Color3.fromRGB(255, 220, 100)
end)
