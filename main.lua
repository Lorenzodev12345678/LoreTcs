 local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local pgui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local targetBall = nil
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025"

-- [[ ANTIBIÓTICO: ANULADOR DE KICK SUPREMO ]]
local oldKick
oldKick = hookmetamethod(game, "__namecall", function(self, ...)
    local method = getnamecallmethod()
    if not checkcaller() and (method == "Kick" or method == "kick") then
        print("Tentativa de Kick anulada com sucesso, rlk!")
        return nil
    end
    return oldKick(self, ...)
end)

-- [[ BYPASS DE VELOCIDADE NO HUMANOIDE ]]
local oldIndex
oldIndex = hookmetamethod(game, "__index", function(t, k)
    if not checkcaller() and t:IsA("Humanoid") and (k == "WalkSpeed" or k == "JumpPower") then
        return 16 
    end
    return oldIndex(t, k)
end)

-- [[ FUNÇÃO DE MOVIMENTO SUAVE (ANTI-VELOCITY) ]]
local function SmoothMoveBall()
    if targetBall and savedGoalPos then
        targetBall.AssemblyLinearVelocity = Vector3.new(0, 0, 0)
        local info = TweenInfo.new(0.8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        local goal = {CFrame = CFrame.new(savedGoalPos + Vector3.new(0, 2, 0))}
        local tween = TweenService:Create(targetBall, info, goal)
        tween:Play()
        print("Bola deslizando pro gol, rblx!")
    end
end

if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end
local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

-- [[ HUB PRINCIPAL (DRAGGABLE) ]]
local function OpenLoreTCS()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    MainFrame.Active = true 
    MainFrame.Draggable = true -- Opção para arrastar ativa
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
        b.MouseButton1Click:Connect(fn)
    end

    -- SISTEMA DE SELEÇÃO INTELIGENTE (IGNORA O CAMPO)
    AddBtn("1. CLICAR NA BOLA", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(0, 150, 255), function()
        local conn
        conn = mouse.Button1Down:Connect(function()
            local obj = mouse.Target
            if obj and obj:IsA("BasePart") then
                -- Filtro: Ignora se o objeto for gigante como o campo
                if obj.Size.X < 10 and obj.Size.Y < 10 then
                    targetBall = obj
                    if targetBall:FindFirstChild("SelectionHighlight") then targetBall.SelectionHighlight:Destroy() end
                    local h = Instance.new("Highlight", targetBall)
                    h.Name = "SelectionHighlight"
                    h.FillColor = Color3.fromRGB(0, 255, 0)
                    conn:Disconnect()
                    print("Bola marcada: " .. obj.Name)
                else
                    print("Clica na bola, man! Isso ai e o campo.")
                end
            end
        end)
    end)

    AddBtn("2. GOL SUAVE (ANTI-BAN)", UDim2.new(0.05, 0, 0.45, 0), Color3.fromRGB(200, 0, 0), SmoothMoveBall)
    AddBtn("SPEED 50 (SAFE)", UDim2.new(0.05, 0, 0.7, 0), Color3.fromRGB(0, 100, 200), function() player.Character.Humanoid.WalkSpeed = 50 end)
end

-- [[ TELA DE SETUP (DRAGGABLE) ]]
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

-- [[ TELA DE KEY (DRAGGABLE) ]]
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
KeyInput.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
KeyInput.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", KeyInput)

local CheckBtn = Instance.new("TextButton", KeyFrame)
CheckBtn.Size = UDim2.new(0.8, 0, 0, 40)
CheckBtn.Position = UDim2.new(0.1, 0, 0.6, 0)
CheckBtn.Text = "LOGAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
CheckBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", CheckBtn)

CheckBtn.MouseButton1Click:Connect(function()
    if KeyInput.Text == correctKey then
        KeyFrame:Destroy()
        StartSetup()
    end
end)
