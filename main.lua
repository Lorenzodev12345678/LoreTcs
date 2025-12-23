local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local pgui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local targetBall = nil
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025"

-- [[ ANTIBIÓTICO V2: BYPASS DE KICK REFORÇADO ]]
local function BlindagemTotal()
    local mt = getrawmetatable(game)
    local oldNamecall = mt.__namecall
    setreadonly(mt, false)
    
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        -- Bloqueia tentativas de Kick via Namecall (Scripts Locais)
        if not checkcaller() and (method == "Kick" or method == "kick") then
            warn("LoreTCS: Tentativa de Kick interceptada!")
            return nil
        end
        return oldNamecall(self, ...)
    end)
    
    -- Bloqueia a função Kick diretamente no objeto Player (Bypass de Hook)
    local oldKick
    oldKick = hookfunction(player.Kick, newcclosure(function(self, ...)
        return nil
    end))
    
    setreadonly(mt, true)
end
BlindagemTotal()

-- [[ BOOSTER DE SKYBOX & ILUMINAÇÃO (FPS UP) ]]
-- Mantém as texturas, mas remove o peso do céu e sombras
local function BoostSkybox(btn)
    btn.Text = "LIMPANDO CÉU..."
    btn.BackgroundColor3 = Color3.fromRGB(150, 0, 255)
    task.wait(0.2) -- Delay para evitar crash no processamento

    local lighting = game:GetService("Lighting")
    lighting.GlobalShadows = false -- Desativa sombras pesadas
    lighting.Brightness = 2
    lighting.FogEnd = 9e9 -- Remove neblina
    
    -- Limpa elementos pesados da iluminação sem tocar nos blocos
    for _, v in pairs(lighting:GetChildren()) do
        if v:IsA("Sky") or v:IsA("BloomEffect") or v:IsA("BlurEffect") or v:IsA("SunRaysEffect") or v:IsA("Atmosphere") then
            v:Destroy()
        end
    end
    
    -- Adiciona um fundo sólido leve
    local simpleSky = Instance.new("Sky", lighting)
    simpleSky.SkyboxBk = Color3.fromRGB(20, 20, 20)
    simpleSky.SkyboxDn = Color3.fromRGB(20, 20, 20)
    simpleSky.SkyboxFt = Color3.fromRGB(20, 20, 20)
    simpleSky.SkyboxLf = Color3.fromRGB(20, 20, 20)
    simpleSky.SkyboxRt = Color3.fromRGB(20, 20, 20)
    simpleSky.SkyboxUp = Color3.fromRGB(20, 20, 20)
    simpleSky.SunAngularSize = 0
    
    btn.Text = "CÉU OTIMIZADO! (rlk)"
    btn.BackgroundColor3 = Color3.fromRGB(0, 150, 0)
    print("Otimização de Skybox aplicada, man!")
end

-- [[ FUNÇÃO MOVIMENTO SUAVE (ANTI-VELOCITY) ]]
local function SmoothMoveBall()
    if targetBall and savedGoalPos then
        targetBall.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        -- Tempo de 1.2s para ser ainda mais seguro contra Anti-Velocity
        local info = TweenInfo.new(1.2, Enum.EasingStyle.Linear) 
        local goal = {CFrame = CFrame.new(savedGoalPos + Vector3.new(0, 2, 0))}
        local tween = TweenService:Create(targetBall, info, goal)
        tween:Play()
    end
end

-- [[ INTERFACE PRINCIPAL ]]
if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end
local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

local function OpenLoreTCS()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 320)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -160)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true 
    MainFrame.Draggable = true -- Opção de arrastar ativa
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
            -- Filtro para pegar apenas a bola (objetos pequenos)
            if obj and obj:IsA("BasePart") and obj.Size.X < 10 then
                targetBall = obj
                if targetBall:FindFirstChild("SelectionHighlight") then targetBall.SelectionHighlight:Destroy() end
                local h = Instance.new("Highlight", targetBall)
                h.Name = "SelectionHighlight"
                h.FillColor = Color3.fromRGB(0, 255, 0)
                conn:Disconnect()
            end
        end)
    end)

    AddBtn("2. GOL SUAVE (ANTI-BAN)", UDim2.new(0.05, 0, 0.3, 0), Color3.fromRGB(200, 0, 0), function() SmoothMoveBall() end)
    AddBtn("BOOSTER SKYBOX (FPS)", UDim2.new(0.05, 0, 0.5, 0), Color3.fromRGB(100, 0, 200), BoostSkybox)
    AddBtn("SPEED 50 (SAFE)", UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(0, 100, 200), function() player.Character.Humanoid.WalkSpeed = 50 end)
end

-- [[ TELA DE SETUP E KEY ]]
local function StartSetup()
    local SetupF = Instance.new("Frame", ScreenGui)
    SetupF.Size = UDim2.new(0, 250, 0, 100)
    SetupF.Position = UDim2.new(0.5, -125, 0.4, 0)
    SetupF.BackgroundColor3 = Color3.fromRGB(20, 40, 20)
    SetupF.Active = true
    SetupF.Draggable = true
    Instance.new("UICorner", SetupF)
    local S = Instance.new("TextButton", SetupF)
    S.Size = UDim2.new(0.8, 0, 0, 40)
    S.Position = UDim2.new(0.1, 0, 0.3, 0)
    S.Text = "SALVAR GOL"
    Instance.new("UICorner", S)
    S.MouseButton1Click:Connect(function()
        savedGoalPos = player.Character.HumanoidRootPart.Position
        SetupF:Destroy()
        OpenLoreTCS()
    end)
end

local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
KeyFrame.Active = true
KeyFrame.Draggable = true
Instance.new("UICorner", KeyFrame)

local KeyInput = Instance.new("TextBox", KeyFrame)
KeyInput.Size = UDim2.new(0.8, 0, 0, 40)
KeyInput.Position = UDim2.new(0.1, 0, 0.35, 0)
KeyInput.PlaceholderText = "INSIRA A KEY..."
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40)
CheckBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
CheckBtn.Text = "LOGAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
Instance.new("UICorner", CheckBtn)

CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == correctKey then KeyFrame:Destroy() StartSetup() end
end)
