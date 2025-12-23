-- Garante que não haja instâncias duplicadas bugando
if game.CoreGui:FindFirstChild("LoreTCS_Auth") then game.CoreGui:FindFirstChild("LoreTCS_Auth"):Destroy() end
if game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoreTCS_Auth") then game.Players.LocalPlayer.PlayerGui:FindFirstChild("LoreTCS_Auth"):Destroy() end

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local pgui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local targetBall = nil
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025"
local keyLink = "https://link-da-sua-key.com"
local speedEnabled = false
local speedValue = 2.2

-- [[ CRIAÇÃO DA INTERFACE (FORÇADA NO PLAYERGUI) ]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.Parent = pgui -- Tenta colocar no PlayerGui
ScreenGui.ResetOnSpawn = false

-- Se o PlayerGui falhar (em alguns executores), tenta o CoreGui
task.spawn(function()
    if not ScreenGui.Parent then
        ScreenGui.Parent = game:GetService("CoreGui")
    end
end)

-- [[ TELA DE LOGIN (O FRAME QUE TEM DE APARECER) ]]
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 250)
KeyFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyFrame.Active = true
KeyFrame.Draggable = true -- Se bugar, tenta desativar isto
Instance.new("UICorner", KeyFrame)
Instance.new("UIStroke", KeyFrame).Color = Color3.fromRGB(0, 255, 100)

local Title = Instance.new("TextLabel", KeyFrame)
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Text = "LORE TCS - LOGIN"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.BackgroundTransparency = 1
Title.Font = Enum.Font.GothamBold

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0.25, 0)
KeyInput.PlaceholderText = "COLE A KEY..."
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40)
CheckBtn.Position = UDim2.new(0.1, 0, 0.5, 0)
CheckBtn.Text = "LOGAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 70)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CheckBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 40)
GetKeyBtn.Position = UDim2.new(0.1, 0, 0.75, 0)
GetKeyBtn.Text = "GET KEY (COPIAR)"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", GetKeyBtn)

-- [[ FUNÇÕES DE CLICK ]]
GetKeyBtn.MouseButton1Click:Connect(function()
    if setclipboard then
        setclipboard(keyLink)
        GetKeyBtn.Text = "COPIADO!"
    else
        GetKeyBtn.Text = "VER CONSOLE F9"
        print(keyLink)
    end
    task.wait(2)
    GetKeyBtn.Text = "GET KEY (COPIAR)"
end)

-- SISTEMA DE SELEÇÃO E OUTROS CONTINUAM ABAIXO...
-- (O resto do teu código entra aqui)

print("LoreTCS: Script Executado, man!")
