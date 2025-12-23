-- [[ LoreTCS - VERSÃO TPS GOD MODE ]]
-- loadstring(game:HttpGet("https://raw.githubusercontent.com/Lorenzodev12345678/LoreTcs/refs/heads/main/main.lua"))()

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local pgui = player:WaitForChild("PlayerGui")
local RunService = game:GetService("RunService")
local targetBall = nil
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025"
local keyLink = "https://link-da-sua-key.com"
local speedEnabled = false
local speedValue = 2.3

-- [[ ANTIBIÓTICO V4: BLINDAGEM ]]
local function BlindagemTotal()
    local mt = getrawmetatable(game)
    local oldIndex = mt.__index
    setreadonly(mt, false)
    mt.__index = newcclosure(function(t, k)
        if not checkcaller() and t:IsA("Humanoid") then
            if k == "WalkSpeed" then return 16 end
            if k == "JumpPower" then return 50 end
        end
        return oldIndex(t, k)
    end)
    hookfunction(player.Kick, newcclosure(function() return nil end))
    setreadonly(mt, true)
end
BlindagemTotal()

-- [[ FUNÇÃO PARA BUSCAR A BOLA EM QUALQUER LUGAR ]]
local function FindTPSBall()
    -- Procura no Workspace e em todas as pastas
    for _, obj in pairs(game:GetDescendants()) do
        if obj:IsA("BasePart") and (obj.Name == "TPS" or obj.Name == "Ball") then
            return obj
        end
    end
    return nil
end

-- [[ SELEÇÃO TPS COM QUADRADO AZUL ]]
mouse.Button1Down:Connect(function()
    local target = mouse.Target
    -- Se clicar em algo ou se a gente forçar a busca
    if target then
        if target.Name:upper():find("TPS") or target.Name:lower():find("ball") then
            targetBall = target
        else
            -- Se não clicar direto, tenta achar pelo nome globalmente
            targetBall = FindTPSBall()
        end
    end

    if targetBall then
        -- Limpa seleções antigas
        for _, v in pairs(targetBall:GetChildren()) do
            if v:IsA("SelectionBox") then v:Destroy() end
        end
        -- Cria o Quadrado Azul
        local box = Instance.new("SelectionBox")
        box.Name = "LoreSelection"
        box.Adornee = targetBall
        box.Color3 = Color3.fromRGB(0, 170, 255)
        box.LineThickness = 0.05
        box.Parent = targetBall
        print("TPS Encontrada e Marcada, rlk!")
    end
end)

-- [[ SPEED BYPASS (CFRAME) ]]
RunService.Stepped:Connect(function()
    if speedEnabled and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
        local hrp = player.Character.HumanoidRootPart
        local hum = player.Character.Humanoid
        if hum.MoveDirection.Magnitude > 0 then
            hrp.CFrame = hrp.CFrame + (hum.MoveDirection * (speedValue / 10))
        end
    end
end)

-- [[ INTERFACE ]]
if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end
local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

-- HUB PRINCIPAL
local function OpenLoreTCS()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true; MainFrame.Draggable = true 
    Instance.new("UICorner", MainFrame)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 100)

    local function AddBtn(name, pos, col, fn)
        local b = Instance.new("TextButton", MainFrame)
        b.Size = UDim2.new(0.9, 0, 0, 45); b.Position = pos; b.Text = name
        b.BackgroundColor3 = col; b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold; Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() fn(b) end)
    end

    -- TELEPORTE DA BOLA (PÊNALTI 100%)
    AddBtn("TELEPORT BALL TO GOAL", UDim2.new(0.05, 0, 0.15, 0), Color3.fromRGB(200, 0, 0), function(btn)
        -- Tenta re-identificar a bola se ela sumiu
        if not targetBall then targetBall = FindTPSBall() end
        
        if targetBall and savedGoalPos then
            btn.Text = "TELEPORTANDO..."
            -- Desativa colisão para não bater em nada no caminho
            targetBall.CanCollide = false
            -- Teleporte instantâneo via CFrame
            targetBall.CFrame = CFrame.new(savedGoalPos)
            task.wait(0.1)
            targetBall.CanCollide = true
            btn.Text = "GOL FEITO! (rlk)"
            task.wait(1)
            btn.Text = "TELEPORT BALL TO GOAL"
        else
            btn.Text = "BOLA NÃO ENCONTRADA!"
            task.wait(1)
            btn.Text = "TELEPORT BALL TO GOAL"
        end
    end)

    AddBtn("BOOSTER FPS (TPS LISO)", UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(100, 0, 200), function(btn)
        game:GetService("Lighting").GlobalShadows = false
        for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
            if v:IsA("PostProcessEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
        end
        btn.Text = "TPS LISO!"
        btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    end)

    AddBtn("SPEED BYPASS: OFF", UDim2.new(0.05, 0, 0.75, 0), Color3.fromRGB(50, 50, 50), function(b)
        speedEnabled = not speedEnabled
        b.Text = speedEnabled and "SPEED BYPASS: ON" or "SPEED BYPASS: OFF"
        b.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(50, 50, 50)
    end)
end

-- SETUP POSIÇÃO DO GOL
local function StartSetup()
    local SetupF = Instance.new("Frame", ScreenGui)
    SetupF.Size = UDim2.new(0, 250, 0, 100); SetupF.Position = UDim2.new(0.5, -125, 0.4, 0)
    SetupF.BackgroundColor3 = Color3.fromRGB(20, 40, 20); SetupF.Active = true; SetupF.Draggable = true
    Instance.new("UICorner", SetupF)
    local S = Instance.new("TextButton", SetupF)
    S.Size = UDim2.new(0.8, 0, 0, 40); S.Position = UDim2.new(0.1, 0, 0.3, 0); S.Text = "SALVAR POSIÇÃO GOL"
    S.MouseButton1Click:Connect(function() 
        savedGoalPos = player.Character.HumanoidRootPart.Position 
        SetupF:Destroy() 
        OpenLoreTCS() 
    end)
    Instance.new("UICorner", S)
end

-- LOGIN
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 250); KeyFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); KeyFrame.Active = true; KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 40); KeyInput.Position = UDim2.new(0.1, 0, 0.2, 0); KeyInput.PlaceholderText = "COLE A KEY..."
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25); KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40); CheckBtn.Position = UDim2.new(0.1, 0, 0.45, 0); CheckBtn.Text = "LOGAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 70); CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", CheckBtn)

local GetKeyBtn = Instance.new("TextButton", KeyFrame)
GetKeyBtn.Size = UDim2.new(0.8, 0, 0, 40); GetKeyBtn.Position = UDim2.new(0.1, 0, 0.7, 0); GetKeyBtn.Text = "GET KEY"
GetKeyBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100); GetKeyBtn.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", GetKeyBtn)

GetKeyBtn.MouseButton1Click:Connect(function() if setclipboard then setclipboard(keyLink) GetKeyBtn.Text = "COPIADO!" task.wait(2) GetKeyBtn.Text = "GET KEY" end end)

CheckBtn.MouseButton1Click:Connect(function() 
    if KeyInput.Text == correctKey then KeyFrame:Destroy(); StartSetup() end 
end)
