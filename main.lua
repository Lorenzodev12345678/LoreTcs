local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025" 
local keyLink = "https://pastebin.com/n7nB6mpX"

if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

local function TeleportBall()
    local ball = workspace:FindFirstChild("TPS")
    if not ball then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "TPS" and v:IsA("BasePart") then
                ball = v
                break
            end
        end
    end
    if ball and savedGoalPos then
        ball.CFrame = CFrame.new(savedGoalPos + Vector3.new(0, 2, 0))
        ball.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        ball.AssemblyAngularVelocity = Vector3.new(0, 0, 0)
    end
end

local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame)

local KStroke = Instance.new("UIStroke", KeyFrame)
KStroke.Color = Color3.fromRGB(0, 255, 100)
KStroke.Thickness = 2

local KTitle = Instance.new("TextLabel", KeyFrame)
KTitle.Size = UDim2.new(1, 0, 0, 50)
KTitle.Text = "LORETCS | TPS"
KTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KTitle.Font = Enum.Font.GothamBold
KTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "KEY..."
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40)
CheckBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
CheckBtn.Text = "VERIFICAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CheckBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 20)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.85, 0)
GetKeyBtn.Text = "PEGAR KEY"
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
GetKeyBtn.TextSize = 12

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(keyLink)
    GetKeyBtn.Text = "COPIADO!"
    task.wait(2)
    GetKeyBtn.Text = "PEGAR KEY"
end)

local function OpenLoreTCS()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Visible = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 100)

    local IconBtn = Instance.new("ImageButton", ScreenGui)
    IconBtn.Size = UDim2.new(0, 50, 0, 50)
    IconBtn.Position = UDim2.new(0.05, 0, 0.4, 0)
    IconBtn.Image = "rbxassetid://110311797595334"
    IconBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    IconBtn.Draggable = true
    Instance.new("UICorner", IconBtn).CornerRadius = UDim.new(1, 0)

    IconBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    local function Add(name, pos, col, fn)
        local b = Instance.new("TextButton", MainFrame)
        b.Size = UDim2.new(0.9, 0, 0, 40)
        b.Position = pos
        b.Text = name
        b.BackgroundColor3 = col
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(fn)
    end

    Add("GOAL TELEPORT", UDim2.new(0.05, 0, 0.25, 0), Color3.fromRGB(200, 0, 0), TeleportBall)
    Add("SPEED 100", UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(0, 100, 200), function() player.Character.Humanoid.WalkSpeed = 100 end)
    Add("JUMP 120", UDim2.new(0.05, 0, 0.65, 0), Color3.fromRGB(0, 150, 0), function() player.Character.Humanoid.JumpPower = 120 end)
end

local function StartSetup()
    KeyFrame:Destroy()
    local SetupFrame = Instance.new("Frame", ScreenGui)
    SetupFrame.Size = UDim2.new(0, 250, 0, 120)
    SetupFrame.Position = UDim2.new(0.5, -125, 0.4, 0)
    SetupFrame.BackgroundColor3 = Color3.fromRGB(20, 40, 20)
    Instance.new("UICorner", SetupFrame)

    local S = Instance.new("TextButton", SetupFrame)
    S.Size = UDim2.new(0.8, 0, 0, 40)
    S.Position = UDim2.new(0.1, 0, 0.5, 0)
    S.Text = "SALVAR GOL"
    S.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Instance.new("UICorner", S)

    S.MouseButton1Click:Connect(function()
        savedGoalPos = player.Character.HumanoidRootPart.Position
        SetupFrame:Destroy()
        OpenLoreTCS()
    end)
end

CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == correctKey then
        StartSetup()
    else
        KeyInput.PlaceholderText = "ERRO!"
        KeyInput.Text = ""
    end
end)
