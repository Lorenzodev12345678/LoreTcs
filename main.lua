-- [[ LoreTCS v1 - TPS EDITION ]]
-- Link Key: https://pastebin.com/n7nB6mpX

local player = game.Players.LocalPlayer
local pgui = player:WaitForChild("PlayerGui")
local savedGoalPos = nil

-- CONFIGURAÇÃO DE ACESSO
local correctKey = "LORE-RLK-2025" 
local keyLink = "https://pastebin.com/n7nB6mpX"

-- Limpeza de Versões Anteriores
if pgui:FindFirstChild("LoreTCS_Auth") then pgui:FindFirstChild("LoreTCS_Auth"):Destroy() end

local ScreenGui = Instance.new("ScreenGui", pgui)
ScreenGui.Name = "LoreTCS_Auth"
ScreenGui.ResetOnSpawn = false

-- [[ FUNÇÃO DE TELEPORTE DA BOLA TPS ]]
local function TeleportBall()
    -- Busca focada na bola TPS
    local ball = workspace:FindFirstChild("TPS")
    
    if not ball then
        for _, v in pairs(workspace:GetDescendants()) do
            if v.Name == "TPS" and v:IsA("BasePart") then
                ball = v
                break
            end
        end
    end

    if ball and savedGoalPos then
        -- Teleporta com um pequeno offset pra não bugar no chão
        ball.CFrame = CFrame.new(savedGoalPos + Vector3.new(0, 2, 0))
        -- Zera a força da bola pra ela cair mort

