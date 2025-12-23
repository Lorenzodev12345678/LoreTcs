local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local pgui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local targetBall = nil
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025"
local speedEnabled = false
local speedValue = 2.2 -- Ajustado para ser rápido mas seguro

-- [[ ANTIBIÓTICO V4: BLINDAGEM DE MEMÓRIA ]]
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

-- [[ SISTEMA DE PÊNALTI 100% (CAN COLLIDE OFF) ]]
local function Penalty100(btn)
    if targetBall and savedGoalPos then
        btn.Text = "FAZENDO GOL..."
        btn.BackgroundColor3 = Color3.fromRGB(0, 255, 100)
        
        -- DESATIVA COLISÃO (Atravessa o Goleiro)
        targetBall.CanCollide = false
        
        -- Aplica Força Física Fantasma Direcionada
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = (savedGoalPos - targetBall.Position).Unit * 150 -- Velocidade de chute forte
        bv.Parent = targetBall
        
        task.wait(1.5)
        
        bv:Destroy()
        targetBall.CanCollide = true -- Ativa de volta pra não bugar o jogo
        btn.Text = "2. PÊNALTI 100% (rlk)"
        btn.BackgroundColor3 = Color3.fromRGB(200, 0, 0)
    else
        btn.Text = "MARQUE A BOLA ANTES!"
        task.wait(1)
        btn.Text = "2. PÊNALTI 100% (rlk)"
    end
end

-- [[ BOOSTER SKYBOX ]]
local function BoostSkybox(btn)
    btn.Text = "OTIMIZANDO..."
    game:GetService("Lighting").GlobalShadows = false
    for _, v in pairs(game:GetService("Lighting"):GetChildren()) do
        if v:IsA("Sky") or v:IsA("Atmosphere") then v:Destroy() end
    end
    local s = Instance.new("Sky", game:GetService("Lighting"))
    s.SkyboxBk = Color3.fromRGB(0,0,0)
    btn.Text = "CÉU LISO! (FPS UP)"
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
end

if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end
local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

-- [[ HUB PRINCIPAL (DRAGGABLE) ]]
local function OpenLoreTCS()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 340)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -170)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true 
    MainFrame.Draggable = true 
    Instance.new("UICorner", MainFrame)
    Instance.new("UIStroke", MainFrame).Color = Color3.fromRGB(0, 255, 100)

    local function AddBtn(name, pos, col, fn)
        local b = Instance.new("TextButton", MainFrame)
        b.Size = UDim2.new(0.9, 0, 0, 40)
        b.Position = pos
        b.Text = name
        b.BackgroundColor3 = col
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        b.Font = Enum.Font.GothamBold
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(function() fn(b) end)
    end

    AddBtn("1. MARCAR BOLA (CLIQUE)", UDim2.new(0.05, 0, 0.1, 0), Color3.fromRGB(0, 150, 255), function()
        local conn
        conn = mouse.Button1Down:Connect(function()
            local obj = mouse.Target
            if obj and obj:IsA("BasePart") and obj.Size.X < 10 then
                targetBall = obj
                local h = Instance.new("Highlight", targetBall)
                h.FillColor = Color3.fromRGB(0, 255, 0)
                conn:Disconnect()
            end
        end)
    end)

    AddBtn("2. PÊNALTI 100% (rlk)", UDim2.new(0.05, 0, 0.3, 0), Color3.fromRGB(200, 0, 0), Penalty100)
    AddBtn("BOOSTER SKYBOX (FPS)", UDim2.new(0.05, 0, 0.5, 0), Color3.fromRGB(100, 0, 200), BoostSkybox)
    
    AddBtn("SPEED BYPASS: OFF", UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(50, 50, 50), function(b)
        speedEnabled = not speedEnabled
        b.Text = speedEnabled and "SPEED BYPASS: ON" or "SPEED BYPASS: OFF"
        b.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(50, 50, 50)
    end)
end

-- [[ TELAS DE SETUP E KEY ]]
local function StartSetup()
    local SetupF = Instance.new("Frame", ScreenGui)
    SetupF.Size = UDim2.new(0, 250, 0, 100); SetupF.Position = UDim2.new(0.5, -125, 0.4, 0)
    SetupF.BackgroundColor3 = Color3.fromRGB(20, 40, 20); SetupF.Active = true; SetupF.Draggable = true
    Instance.new("UICorner", SetupF)
    local S = Instance.new("TextButton", SetupF)
    S.Size = UDim2.new(0.8, 0, 0, 40); S.Position = UDim2.new(0.1, 0, 0.3, 0); S.Text = "SALVAR GOL"
    S.MouseButton1Click:Connect(function() savedGoalPos = player.Character.HumanoidRootPart.Position; SetupF:Destroy(); OpenLoreTCS() end)
end

local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 200); KeyFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); KeyFrame.Active = true; KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame)
local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 40); KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0); KeyInput.PlaceholderText = "KEY..."
local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40); CheckBtn.Position = UDim2.new(0.1, 0, 0.6, 0); CheckBtn.Text = "LOGAR"
CheckBtn.MouseButton1Click:Connect(function() if KeyInput.Text == correctKey then KeyFrame:Destroy(); StartSetup() end end)
