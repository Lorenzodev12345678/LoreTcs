-- [[ LoreTCS v1 - OFFICIAL FULL RELEASE ]]
-- [[ Link Key: https://pastebin.com/n7nB6mpX ]]

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local savedGoalPos = nil

-- CONFIGURAÇÃO DA CHAVE
local correctKey = "LORE-RLK-2025" 
local keyLink = "https://pastebin.com/n7nB6mpX"

-- Limpeza
if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

-- [[ FUNÇÃO DE TELEPORTAR A BOLA ]]
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

-- [[ TELA DE KEY (BLOQUEIO) ]]
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 320, 0, 220)
KeyFrame.Position = UDim2.new(0.5, -160, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(5, 5, 5)
Instance.new("UICorner", KeyFrame)
local KStroke = Instance.new("UIStroke", KeyFrame)
KStroke.Color = Color3.fromRGB(0, 255, 100)
KStroke.Thickness = 2

local KTitle = Instance.new("TextLabel", KeyFrame)
KTitle.Size = UDim2.new(1, 0, 0, 60)
KTitle.Text = "LORETCS | AUTENTICAÇÃO"
KTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
KTitle.Font = Enum.Font.GothamBold
KTitle.TextSize = 18
KTitle.BackgroundTransparency = 1

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.85, 0, 0, 45)
KeyInput.Position = UDim2.new(0.075, 0, 0.35, 0)
KeyInput.PlaceholderText = "INSIRA A CHAVE..."
KeyInput.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.85, 0, 0, 45)
CheckBtn.Position = UDim2.new(0.075, 0, 0.62, 0)
CheckBtn.Text = "VERIFICAR AGORA"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CheckBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", CheckBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.85, 0, 0, 30)
GetKeyBtn.Position = UDim2.new(0.075, 0, 0.85, 0)
GetKeyBtn.Text = "PEGAR KEY (PASTEBIN)"
GetKeyBtn.BackgroundTransparency = 1
GetKeyBtn.TextColor3 = Color3.fromRGB(0, 180, 255)
GetKeyBtn.TextSize = 14

GetKeyBtn.MouseButton1Click:Connect(function()
    setclipboard(keyLink)
    GetKeyBtn.Text = "LINK COPIADO!"
    task.wait(2)
    GetKeyBtn.Text = "PEGAR KEY (PASTEBIN)"
end)

-- [[ FUNÇÃO PARA ABRIR O HUB PRINCIPAL ]]
local function OpenLoreTCS()
    -- Painel Principal
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 320, 0, 280)
    MainFrame.Position =
