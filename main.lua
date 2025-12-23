-- [[ LoreTCS v1 - REVISADO E PRONTO ]]
-- Link Key: https://pastebin.com/n7nB6mpX

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local savedGoalPos = nil

-- CONFIGURAÇÃO
local correctKey = "LORE-RLK-2025" 
local keyLink = "https://pastebin.com/n7nB6mpX"

-- Limpeza de segurança
if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

-- [[ FUNÇÃO TELEPORTE ]]
local function TeleportBall()
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Football")
    if not ball then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Ball" and v:IsA("BasePart") then ball = v break end
        end
    end
    if ball and savedGoalPos then
        ball.CFrame = CFrame.new(savedGoalPos)
    end
end

-- [[ TELA DE KEY (APARECE PRIMEIRO) ]]
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 320, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -160, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame)

local KStroke = Instance.new("UIStroke", KeyFrame)
KStroke.Color = Color3.fromRGB(0, 255, 100)
KStroke.Thickness = 2

local KTitle = Instance.new("TextLabel", KeyFrame)
KTitle.Size = UDim2.new(1, 0, 0, 60)
KTitle.Text = "LORETCS | KEY SYSTEM"
KTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KTitle.Font = Enum.Font.GothamBold
KTitle.TextSize = 18
KTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.85, 0, 0, 45)
KeyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
KeyInput.PlaceholderText = "COLE A CHAVE..."
KeyInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.85, 0, 0, 45)
CheckBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
CheckBtn.Text = "VERIFICAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CheckBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 30)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.85, 0)
GetKeyBtn.Text = "PEGAR KEY (CLIQUE AQUI)"
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
GetKeyBtn.TextSize = 14

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(keyLink)
    GetKeyBtn.Text = "LINK COPIADO!"
    wait(2)
    GetKeyBtn.Text = "PEGAR KEY (CLIQUE AQUI)"
end)

-- [[ FUNÇÃO DO HUB PRINCIPAL ]]
local function CreateMainHub()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 320, 0, 280)
    MainFrame.Position = UDim2.new(0.5, -160, 0.5, -140)
    MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
    MainFrame.Visible = true
    MainFrame.Draggable = true
    Instance.new("UICorner", MainFrame)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 100)

    local IconBtn = Instance.new("ImageButton", ScreenGui)
    IconBtn.Size = UDim2.new(0, 55, 0, 55)
    IconBtn.Position = UDim2.new(0.02, 0, 0.45, 0)
    IconBtn.Image = "rbxassetid://110311797595334"
    IconBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
    IconBtn.Draggable = true
    Instance.new("UICorner", IconBtn).CornerRadius = UDim.new(1, 0)
    local IS = Instance.new("UIStroke", IconBtn)
    IS.Color = Color3.fromRGB(0,0,0)
    IS.Thickness = 3

    IconBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

    local function AddBtn(text, pos, color, func)
        local b = Instance.new("TextButton", MainFrame)
        b.Size = UDim2.new(0.9, 0, 0, 45)
        b.Position = pos
        b.Text = text
        b.BackgroundColor3 = color
        b.TextColor3 = Color3.fromRGB(255,255,255)
        b.Font = Enum.Font.GothamBold
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(func)
    end

    AddBtn("TELEPORT BOLA (GOL)", UDim2.new(0.05, 0, 0.25, 0), Color3.fromRGB(200,0,0), TeleportBall)
    AddBtn("SPEED (100)", UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(0,100,200), function() player.Character.Humanoid.WalkSpeed = 100 end)
    AddBtn("PULO (120)", UDim2.new(0.05, 0, 0.65, 0), Color3.fromRGB(0,150,0), function() player.Character.Humanoid.JumpPower = 120 end)
end

-- [[ LÓGICA DO SETUP GOL ]]
local function StartSetup()
    KeyFrame:Destroy()
    local SetupF = Instance.new("Frame", ScreenGui)
    SetupF.Size = UDim2.new(0, 260, 0, 140)
    SetupF.Position = UDim2.new(0.5, -130, 0.4, 0)
    SetupF.BackgroundColor3 = Color3.fromRGB(10, 30, 10)
    Instance.new("UICorner", SetupF)

    local T = Instance.new("TextLabel", SetupF)
    T.Size = UDim2.new(1,0,0,60) T.Text = "VÁ AO GOL E SALVE"
    T.TextColor3 = Color3.fromRGB(255,255,255) T.BackgroundTransparency = 1
    T.Font = Enum.Font.GothamBold

    local S = Instance.new("TextButton", SetupF)
    S.Size = UDim2.new(0.8,0,0,40) S.Position = UDim2.new(0.1,0,0.6,0)
    S.Text = "SALVAR POSIÇÃO" S.BackgroundColor3 = Color3.fromRGB(255,255,255)
    Instance.new("UICorner", S)

    S.MouseButton1Click:Connect(function()
        savedGoalPos = player.Character.HumanoidRootPart.Position
        SetupF:Destroy()
        CreateMainHub() -- FINALMENTE ABRE O HUB
    end)
end

-- [[ VERIFICAR KEY ]]
CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == correctKey then
        StartSetup()
    else
        KeyInput.Text = ""
        KeyInput.PlaceholderText = "KEY INCORRETA!"
        KStroke.Color = Color3.fromRGB(255,0,0)
        wait(1)
        KStroke.Color = Color3.fromRGB(0,255,100)
    end
end)
