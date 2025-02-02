-- Script by Str0iteL
-- License: Non-commercial use only. See LICENSE for details.

local player = game.Players.LocalPlayer
local screenGui = Instance.new("ScreenGui")
local textLabel = Instance.new("TextLabel")

-- Настройка ScreenGui
screenGui.Name = "CustomLabel"
screenGui.IgnoreGuiInset = true  -- Отключаем автоматические отступы
screenGui.Parent = player:WaitForChild("PlayerGui")

-- Настройка TextLabel
textLabel.Name = "TgLabel"
textLabel.Parent = screenGui
textLabel.Size = UDim2.new(1, 0, 0.08, 0)  -- Высота текста: 8% от экрана
textLabel.Position = UDim2.new(0, 0, 0, 0)  -- Текст вплотную к верхней границе
textLabel.BackgroundTransparency = 1  -- Прозрачный фон
textLabel.Text = "Tg: @TheScript404"
textLabel.Font = Enum.Font.SourceSansBold  -- Жирный текст
textLabel.TextColor3 = Color3.fromRGB(255, 255, 255)  -- Белый цвет
textLabel.TextStrokeTransparency = 0  -- Обводка текста
textLabel.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)  -- Черный цвет обводки
textLabel.TextSize = 30  -- Размер текста
textLabel.TextScaled = true  -- Автоматическое масштабирование текста
textLabel.ZIndex = 10  -- Приоритет отображения

-- Оптимизация графики
local lighting = game:GetService("Lighting")
local soundService = game:GetService("SoundService")
local starterGui = game:GetService("StarterGui")
local replicatedStorage = game:GetService("ReplicatedStorage")
local workspace = game:GetService("Workspace")
local collectionService = game:GetService("CollectionService")  -- Используем CollectionService для поиска объектов

-- Локальные переменные для повышения производительности
local lastTime = tick()

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

-- Применение оптимизаций для всех объектов с тегом
local function optimizeTaggedObjects()
    for _, part in pairs(collectionService:GetTagged("Optimizable")) do
        part.Transparency = 1  -- Прячем все части с тегом
        part.CanCollide = false  -- Убираем коллизии
        part.Anchored = true  -- Отключаем физику
    end
end

-- Применение полных оптимизаций
local function optimizeGame(player)
    -- Делаем асинхронное выполнение задач, чтобы не блокировать основной поток
    coroutine.wrap(function()
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
        optimizeTaggedObjects()
    end)()

    -- Ограничение FPS
    setFPSLimit()
end

-- Главный цикл с уменьшенным интервалом
while true do
    local player = game.Players.LocalPlayer
    optimizeGame(player)
    wait(0.05)  -- Уменьшаем интервал для более частой оптимизации
end
