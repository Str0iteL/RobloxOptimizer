-- Script by Str0iteL
-- Repository: https://github.com/Str0iteL/RobloxOptimizer/tree/main
-- License: Non-commercial use only. See LICENSE for details.


-- Оптимизация графики
local lighting = game:GetService("Lighting")
local soundService = game:GetService("SoundService")
local starterGui = game:GetService("StarterGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")

-- Отключение FPS
local function setFPSLimit()
    local currentTime = tick()
    local deltaTime = currentTime - lastTime
    if deltaTime < (1 / 15) then
        return
    end
    lastTime = currentTime
end

-- Удаление текстур или их замена на пустые
local function removeTextures()
    for _, texture in pairs(workspace:GetDescendants()) do
        if texture:IsA("Texture") then
            texture.Texture = "rbxassetid://0"  -- Заменяем текстуру на пустую
        end
    end
end

-- Отключение качества графики
local function optimizeLighting()
    lighting:ClearAllChildren()  -- Удаляем все ненужные объекты в Lighting
    lighting.GlobalShadows = false  -- Отключаем глобальные тени
    lighting.OutdoorAmbient = Color3.fromRGB(255, 255, 255) -- Минимальный уровень внешнего освещения
    lighting.Ambient = Color3.fromRGB(255, 255, 255)  -- Настройки минимального освещения
    lighting.Skybox = nil  -- Убираем небо
    lighting.Quality = Enum.QualityLevel.Level01  -- Минимальное качество графики
    lighting.FogEnd = 1  -- Устанавливаем минимальную дальность видимости для тумана
end

-- Отключение частиц
local function disableParticles()
    for _, particle in pairs(workspace:GetDescendants()) do
        if particle:IsA("ParticleEmitter") then
            particle.Enabled = false
        end
    end
end

-- Отключение звуков
local function disableSounds()
    soundService:SetVolume(0)
end

-- Отключение ненужных сервисов
local function disableServices()
    starterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, false)  -- Отключаем GUI
    replicatedStorage:ClearAllChildren()  -- Удаляем все объекты из ReplicatedStorage
end

-- Скрытие и удаление объектов
local function hideParts()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") or part:IsA("MeshPart") then
            part.Transparency = 1  -- Прячем все части
            part.CanCollide = false  -- Убираем коллизии
        end
    end
end

-- Отключение анимаций
local function stopAnimations()
    for _, animation in pairs(workspace:GetDescendants()) do
        if animation:IsA("Animation") then
            animation:Stop()  -- Останавливаем анимации
        end
    end
end

-- Отключаем камеры
local function removeCameras()
    for _, camera in pairs(workspace:GetDescendants()) do
        if camera:IsA("Camera") then
            camera:Destroy()  -- Удаляем камеры
        end
    end
end

-- Отключение физики для объектов, не взаимодействующих с игроком
local function disablePhysics()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") or part:IsA("MeshPart") then
            part.Anchored = true  -- Отключаем физику
        end
    end
end

-- Оптимизация освещения для дальних объектов
local function optimizeLightingForDistance(player)
    local playerPosition = player.Character.HumanoidRootPart.Position
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("Part") or part:IsA("MeshPart") then
            local distance = (part.Position - playerPosition).Magnitude
            if distance > 1000 then  -- Удаляем или минимизируем освещение для объектов, находящихся далеко
                part.Material = Enum.Material.SmoothPlastic  -- Устанавливаем минимальное качество материала
                part.Color = Color3.fromRGB(255, 255, 255)  -- Минимальная освещенность
            end
        end
    end
end

-- Основная оптимизация
local function optimizeGame(player)
    removeTextures()
    optimizeLighting()
    disableParticles()
    disableSounds()
    disableServices()
    hideParts()
    stopAnimations()
    removeCameras()
    disablePhysics()
    optimizeLightingForDistance(player)
end

-- Главный цикл
while true do
    local player = game.Players.LocalPlayer
    optimizeGame(player)
    wait(0.1)  -- Интервал между итерациями для снижения нагрузки
end
