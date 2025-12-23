local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local pgui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local targetBall = nil
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025"
local keyLink = "https://link-da-sua-key.com" -- MAN, TROQUE PELO SEU LINK REAL AQUI
local speedEnabled = false
local speedValue = 2.2

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

-- [[ SELEÇÃO POR CLIQUE COM QUADRADO AZUL ]]
mouse.Button1Down:Connect(function()
    local target = mouse.Target
    if target and target:IsA("BasePart") then
        if (target.Name:lower():find("ball") or target.Name:lower():find("foot") or target.Size.X < 10) and not target:FindFirstAncestorOfClass("Model"):FindFirstChild("Humanoid") then
            targetBall = target
            -- Limpa seleções antigas na bola
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
            print("Bola marcada: Quadrado Azul ativo, rlk!")
        end
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

-- [[ PÊNALTI 100% (CAN COLLIDE OFF) ]]
local function Penalty100(btn)
    if targetBall and savedGoalPos then
        btn.Text = "FAZENDO GOL..."
        targetBall.CanCollide = false
        local bv = Instance.new("BodyVelocity")
        bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
        bv.Velocity = (savedGoalPos - targetBall.Position).Unit * 165
        bv.Parent = targetBall
        task.wait(1.2)
        bv:Destroy()
        targetBall.CanCollide = true
        btn.Text = "2. PÊNALTI 100% (rlk)"
    else
        btn.Text = "CLIQUE NA BOLA PRIMEIRO!"
        task.wait(1)
        btn.Text = "2. PÊNALTI 100% (rlk)"
    end
end

-- [[ BOOSTER SKYBOX (FIX ID EXPECTED) ]]
local function BoostSkybox(btn)
    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("PostProcessEffect") or v:IsA("Atmosphere") or v:IsA("Sky") then v:Destroy() end
    end
    lighting.OutdoorAmbient = Color3.fromRGB(120, 120, 120)
    btn.Text = "CÉU OTIMIZADO! (FPS UP)"
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
end

if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end
local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

-- [[ HUB PRINCIPAL (APÓS LOGIN) ]]
local function OpenLoreTCS()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 300)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -150)
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

    AddBtn("2. PÊNALTI 100% (rlk)", UDim2.new(0.05, 0, 0.15, 0), Color3.fromRGB(200, 0, 0), Penalty100)
    AddBtn("BOOSTER SKYBOX (FPS)", UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(100, 0, 200), BoostSkybox)
    AddBtn("SPEED BYPASS: OFF", UDim2.new(0.05, 0, 0.75, 0), Color3.fromRGB(50, 50, 50), function(b)
        speedEnabled = not speedEnabled
        b.Text = speedEnabled and "SPEED BYPASS: ON" or "SPEED BYPASS: OFF"
        b.BackgroundColor3 = speedEnabled and Color3.fromRGB(0, 100, 200) or Color3.fromRGB(50, 50, 50)
    end)
end

-- [[ TELA DE LOGIN COM GET KEY ]]
local function StartSetup()
    local SetupF = Instance.new("Frame", ScreenGui)
    SetupF.Size = UDim2.new(0, 250, 0, 100); SetupF.Position = UDim2.new(0.5, -125, 0.4, 0)
    SetupF.BackgroundColor3 = Color3.fromRGB(20, 40, 20); SetupF.Active = true; SetupF.Draggable = true
    Instance.new("UICorner", SetupF)
    local S = Instance.new("TextButton", SetupF)
    S.Size = UDim2.new(0.8, 0, 0, 40); S.Position = UDim2.new(0.1, 0, 0.3, 0); S.Text = "SALVAR GOL"
    S.MouseButton1Click:Connect(function() savedGoalPos = player.Character.HumanoidRootPart.Position; SetupF:Destroy(); OpenLoreTCS() end)
    Instance.new("UICorner", S)
end

local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 250); KeyFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10); KeyFrame.Active = true; KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 40); KeyInput.Position = UDim2.new(0.1, 0, 0.2, 0); KeyInput.PlaceholderText = "COLE A KEY AQUI..."
KeyInput.BackgroundColor3 = Color3.fromRGB(25, 25, 25); KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40); CheckBtn.Position = UDim2.new(0.1, 0, 0.45, 0); CheckBtn.Text = "LOGAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 180, 70); CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255); Instance.new("UICorner", CheckBtn)

local GetKeyBtn = Instance.new("TextButton",
