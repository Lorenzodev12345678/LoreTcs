local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local pgui = player:WaitForChild("PlayerGui")
local targetBall = nil
local savedGoalPos = nil
local correctKey = "LORE-RLK-2025"

-- [ SEGURANÇA: BYPASS DE KICK ]
local mt = getrawmetatable(game)
local old = mt.__namecall
setreadonly(mt, false)
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    if method == "Kick" or method == "kick" then return nil end
    return old(self, ...)
end)
setreadonly(mt, true)

if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end
local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"

-- [ FUNÇÃO DE TELEPORTE SEGURO ]
local function TeleportBall()
    if targetBall and savedGoalPos then
        targetBall.AssemblyLinearVelocity = Vector3.new(0,0,0)
        task.wait(0.05)
        targetBall.CFrame = CFrame.new(savedGoalPos + Vector3.new(0, 3, 0))
    end
end

-- [ TELA DE KEY ]
local KeyFrame = Instance.new("Frame", ScreenGui)
KeyFrame.Size = UDim2.new(0, 300, 0, 200)
KeyFrame.Position = UDim2.new(0.5, -150, 0.4, 0)
KeyFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
Instance.new("UICorner", KeyFrame)

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
CheckBtn.Text = "LOGAR"
CheckBtn.BackgroundColor3 = Color3.fromRGB(0, 200, 80)
Instance.new("UICorner", CheckBtn)

-- [ HUB PRINCIPAL ]
local function OpenLoreTCS()
    local MainFrame = Instance.new("Frame", ScreenGui)
    MainFrame.Size = UDim2.new(0, 300, 0, 250)
    MainFrame.Position = UDim2.new(0.5, -150, 0.5, -125)
    MainFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Instance.new("UICorner", MainFrame)

    local function AddBtn(name, pos, col, fn)
        local b = Instance.new("TextButton", MainFrame)
        b.Size = UDim2.new(0.9, 0, 0, 40)
        b.Position = pos
        b.Text = name
        b.BackgroundColor3 = col
        b.TextColor3 = Color3.fromRGB(255, 255, 255)
        Instance.new("UICorner", b)
        b.MouseButton1Click:Connect(fn)
    end

    -- BOTÃO PARA MARCAR A BOLA
    AddBtn("1. CLIQUE NA BOLA", UDim2.new(0.05, 0, 0.2, 0), Color3.fromRGB(0, 150, 255), function()
        local connection
        connection = mouse.Button1Down:Connect(function()
            if mouse.Target then
                targetBall = mouse.Target
                print("Bola Marcada: " .. targetBall.Name)
                
                -- Efeito visual de marcação
                local highlight = Instance.new("Highlight", targetBall)
                highlight.FillColor = Color3.fromRGB(0, 255, 0)
                
                connection:Disconnect() -- Para de selecionar após o primeiro clique
            end
        end)
    end)

    AddBtn("2. TELEPORT PRO GOL", UDim2.new(0.05, 0, 0.45, 0), Color3
