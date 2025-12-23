-- [[ LoreTCS v1 - THE FOOTBALL DOMINATOR ]]
-- [[ Projeto Focado: TCS Futebol Clássico ]]

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local savedGoalPos = nil

-- Limpeza de Versões
if pgui:FindFirstChild("LoreTCS") then pgui:FindFirstChild("LoreTCS"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS"
ScreenGui.ResetOnSpawn = false

-- [[ INTERFACE DE SETUP INICIAL ]]
local SetupFrame = Instance.new("Frame", ScreenGui)
SetupFrame.Size = UDim2.new(0, 260, 0, 130)
SetupFrame.Position = UDim2.new(0.5, -130, 0.4, 0)
SetupFrame.BackgroundColor3 = Color3.fromRGB(10, 30, 10) -- Verde escuro gramado
Instance.new("UICorner", SetupFrame)
local SetupStroke = Instance.new("UIStroke", SetupFrame)
SetupStroke.Color = Color3.fromRGB(255, 255, 255)
SetupStroke.Thickness = 2

local SetupText = Instance.new("TextLabel", SetupFrame)
SetupText.Size = UDim2.new(1, -20, 0, 60)
SetupText.Position = UDim2.new(0, 10, 0, 5)
SetupText.Text = "LORETCS: VÁ AO GOL DO ADVERSÁRIO E SALVE"
SetupText.TextColor3 = Color3.fromRGB(255, 255, 255)
SetupText.Font = Enum.Font.GothamBold
SetupText.TextSize = 14
SetupText.TextWrapped = true
SetupText.BackgroundTransparency = 1

local SetBtn = Instance.new("TextButton", SetupFrame)
SetBtn.Size = UDim2.new(0, 200, 0, 40)
SetBtn.Position = UDim2.new(0.5, -100, 0.6, 0)
SetBtn.Text = "CONFIGURAR ALVO"
SetBtn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SetBtn.TextColor3 = Color3.fromRGB(0, 0, 0)
SetBtn.Font = Enum.Font.GothamBold
Instance.new("UICorner", SetBtn)

-- [[ PAINEL DE CONTROLE LORETCS ]]
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 320, 0, 250)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -125)
MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
MainFrame.Visible = false
MainFrame.Draggable = true
Instance.new("UICorner", MainFrame)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(0, 255, 100) -- Neon Football
MainStroke.Thickness = 2

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.new(1, 0, 0, 50)
Title.Text = "LORETCS | v1.0"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.BackgroundTransparency = 1

-- Botão de Ativação (Sua Foto)
local IconBtn = Instance.new("ImageButton", ScreenGui)
IconBtn.Size = UDim2.new(0, 55, 0, 55)
IconBtn.Position = UDim2.new(0.02, 0, 0.45, 0)
IconBtn.Image = "rbxassetid://110311797595334"
IconBtn.Visible = false
IconBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
Instance.new("UICorner", IconBtn).CornerRadius = UDim.new(1, 0)
local IconStroke = Instance.new("UIStroke", IconBtn)
IconStroke.Color = Color3.fromRGB(0, 0, 0) -- Stroke Preto rlk

-- Lógica do Setup
SetBtn.MouseButton1Click:Connect(function()
    savedGoalPos = player.Character.HumanoidRootPart.Position
    SetupFrame.Visible = false
    IconBtn.Visible = true
    MainFrame.Visible = true
    print("Alvo do LoreTCS configurado!")
end)

IconBtn.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- [[ FUNÇÕES DE FUTEBOL ]]
local function AddAction(name, color, callback)
    local btn = Instance.new("TextButton", MainFrame)
    btn.Size = UDim2.new(0.9, 0, 0, 45)
    btn.Position = UDim2.new(0.05, 0, 0, (#MainFrame:GetChildren() * 50) + 10)
    btn.Text = name
    btn.BackgroundColor3 = color
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.GothamBold
    Instance.new("UICorner", btn)
    btn.MouseButton1Click:Connect(callback)
end

AddAction("TELEPORTAR BOLA (GOL)", Color3.fromRGB(200, 0, 0), function()
    local ball = workspace:FindFirstChild("Ball") or workspace:FindFirstChild("Football")
    if not ball then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "Ball" and v:IsA("BasePart") then ball = v break end
        end
    end
    if ball and savedGoalPos then
        ball.CFrame = CFrame.new(savedGoalPos)
    end
end)

AddAction("CORRIDA SUPREMA (100)", Color3.fromRGB(0, 100, 255), function()
    player.Character.Humanoid.WalkSpeed = 100
end)

AddAction("PULO DE CABEÇA (PRO)", Color3.fromRGB(0, 150, 0), function()
    player.Character.Humanoid.JumpPower = 120
end)

print("LoreTCS Inicializado com Sucesso!")
