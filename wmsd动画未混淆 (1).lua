local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer

local gui = Instance.new("ScreenGui")
gui.Name = "EnhancedLoadingUI"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = player:WaitForChild("PlayerGui")

-- 创建渐变动画背景
local background = Instance.new("Frame")
background.Size = UDim2.new(1, 0, 1, 0)
background.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
background.BackgroundTransparency = 1
background.Parent = gui

-- 背景渐变遮罩
local gradient = Instance.new("UIGradient")
gradient.Rotation = 45
gradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(10, 10, 25)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(20, 20, 40))
})
gradient.Parent = background

-- 创建加载窗口（添加圆角阴影效果）
local loadingFrame = Instance.new("Frame")
loadingFrame.Size = UDim2.new(0, 400, 0, 300)
loadingFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
loadingFrame.BackgroundColor3 = Color3.fromRGB(25, 25, 35)
loadingFrame.BackgroundTransparency = 1
loadingFrame.ClipsDescendants = true
loadingFrame.Parent = background

-- 圆角
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 15)
corner.Parent = loadingFrame

-- 内阴影效果
local innerShadow = Instance.new("Frame")
innerShadow.Size = UDim2.new(1, 0, 1, 0)
innerShadow.BackgroundTransparency = 1
innerShadow.BorderSizePixel = 0
innerShadow.Parent = loadingFrame

local shadowCorner = Instance.new("UICorner")
shadowCorner.CornerRadius = corner.CornerRadius
shadowCorner.Parent = innerShadow

local shadowStroke = Instance.new("UIStroke")
shadowStroke.Color = Color3.fromRGB(255, 255, 255)
shadowStroke.Transparency = 0.9
shadowStroke.Thickness = 2
shadowStroke.Parent = innerShadow

-- 窗口装饰线条
local topAccent = Instance.new("Frame")
topAccent.Size = UDim2.new(1, 0, 0, 3)
topAccent.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
topAccent.BorderSizePixel = 0
topAccent.Parent = loadingFrame

local accentCorner = Instance.new("UICorner")
accentCorner.CornerRadius = UDim.new(0, 2)
accentCorner.Parent = topAccent

-- 加载标题
local title = Instance.new("TextLabel")
title.Text = "亡命速递加载中"
title.Size = UDim2.new(1, 0, 0, 60)
title.Position = UDim2.new(0, 0, 0, 20)
title.TextColor3 = Color3.new(1, 1, 1)
title.Font = Enum.Font.GothamBold
title.TextSize = 28
title.BackgroundTransparency = 1
title.TextTransparency = 1
title.Parent = loadingFrame

-- 副标题
local subtitle = Instance.new("TextLabel")
subtitle.Text = "正在准备您的体验..."
subtitle.Size = UDim2.new(1, 0, 0, 30)
subtitle.Position = UDim2.new(0, 0, 0, 60)
subtitle.TextColor3 = Color3.fromRGB(200, 200, 200)
subtitle.Font = Enum.Font.Gotham
subtitle.TextSize = 16
subtitle.BackgroundTransparency = 1
subtitle.TextTransparency = 1
subtitle.Parent = loadingFrame

-- 加载进度条容器
local progressContainer = Instance.new("Frame")
progressContainer.Size = UDim2.new(0.85, 0, 0, 40)
progressContainer.Position = UDim2.new(0.075, 0, 0.45, 0)
progressContainer.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
progressContainer.BackgroundTransparency = 1
progressContainer.Parent = loadingFrame

local containerCorner = Instance.new("UICorner")
containerCorner.CornerRadius = UDim.new(0, 10)
containerCorner.Parent = progressContainer

local containerStroke = Instance.new("UIStroke")
containerStroke.Color = Color3.fromRGB(60, 60, 70)
containerStroke.Thickness = 2
containerStroke.Transparency = 1
containerStroke.Parent = progressContainer

-- 加载进度条背景
local progressBarBg = Instance.new("Frame")
progressBarBg.Size = UDim2.new(1, -20, 0.6, 0)
progressBarBg.Position = UDim2.new(0, 10, 0.2, 0)
progressBarBg.BackgroundColor3 = Color3.fromRGB(50, 50, 60)
progressBarBg.BorderSizePixel = 0
progressBarBg.Parent = progressContainer

local barBgCorner = Instance.new("UICorner")
barBgCorner.CornerRadius = UDim.new(0, 5)
barBgCorner.Parent = progressBarBg

-- 加载进度条
local progressBar = Instance.new("Frame")
progressBar.Size = UDim2.new(0, 0, 1, 0)
progressBar.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
progressBar.BorderSizePixel = 0
progressBar.Parent = progressBarBg

-- 进度条渐变
local barGradient = Instance.new("UIGradient")
barGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 170, 255)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 210, 255)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 170, 255))
})
barGradient.Rotation = 0
barGradient.Parent = progressBar

-- 进度条圆角
local barCorner = Instance.new("UICorner")
barCorner.CornerRadius = UDim.new(0, 5)
barCorner.Parent = progressBar

-- 加载百分比文本
local percentText = Instance.new("TextLabel")
percentText.Text = "0%"
percentText.Size = UDim2.new(1, 0, 0, 40)
percentText.Position = UDim2.new(0, 0, 0.65, 0)
percentText.TextColor3 = Color3.new(1, 1, 1)
percentText.Font = Enum.Font.GothamBold
percentText.TextSize = 24
percentText.BackgroundTransparency = 1
percentText.TextTransparency = 1
percentText.Parent = progressContainer

-- 加载提示文本
local hintText = Instance.new("TextLabel")
hintText.Text = "请稍候..."
hintText.Size = UDim2.new(1, 0, 0, 30)
hintText.Position = UDim2.new(0, 0, 0.8, 0)
hintText.TextColor3 = Color3.fromRGB(150, 150, 150)
hintText.Font = Enum.Font.Gotham
hintText.TextSize = 14
hintText.BackgroundTransparency = 1
hintText.TextTransparency = 1
hintText.Parent = loadingFrame

-- 旋转加载图标
local loadingIcon = Instance.new("Frame")
loadingIcon.Size = UDim2.new(0, 50, 0, 50)
loadingIcon.Position = UDim2.new(0.5, -25, 0.85, 0)
loadingIcon.BackgroundTransparency = 1
loadingIcon.Parent = loadingFrame

for i = 1, 8 do
    local dot = Instance.new("Frame")
    dot.Size = UDim2.new(0, 6, 0, 6)
    dot.Position = UDim2.new(0.5, -3, 0, 20)
    dot.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
    dot.BorderSizePixel = 0
    dot.BackgroundTransparency = 1
    
    local dotCorner = Instance.new("UICorner")
    dotCorner.CornerRadius = UDim.new(1, 0)
    dotCorner.Parent = dot
    
    dot.Parent = loadingIcon
end

-- 淡入动画函数
local function fadeIn()
    local tweenInfo = TweenInfo.new(0.8, Enum.EasingStyle.Quint, Enum.EasingDirection.Out)
    
    -- 背景淡入
    TweenService:Create(background, tweenInfo, {BackgroundTransparency = 0.3}):Play()
    
    -- 窗口淡入
    TweenService:Create(loadingFrame, tweenInfo, {BackgroundTransparency = 0}):Play()
    
    -- 文本淡入
    task.wait(0.2)
    TweenService:Create(title, tweenInfo, {TextTransparency = 0}):Play()
    
    task.wait(0.1)
    TweenService:Create(subtitle, tweenInfo, {TextTransparency = 0}):Play()
    TweenService:Create(progressContainer, tweenInfo, {BackgroundTransparency = 0}):Play()
    TweenService:Create(containerStroke, tweenInfo, {Transparency = 0}):Play()
    
    task.wait(0.1)
    TweenService:Create(percentText, tweenInfo, {TextTransparency = 0}):Play()
    TweenService:Create(hintText, tweenInfo, {TextTransparency = 0}):Play()
end

-- 模拟加载过程
local function simulateLoading()
    -- 先执行淡入动画
    fadeIn()
    task.wait(1)
    
    local progress = 0
    local startTime = tick()
    local dots = loadingIcon:GetChildren()
    
    -- 旋转动画
    local spinConnection
    spinConnection = RunService.Heartbeat:Connect(function(deltaTime)
        local timePassed = tick() - startTime
        loadingIcon.Rotation = timePassed * 180  -- 每秒旋转180度
    end)
    
    -- 点状动画
    local dotConnection
    dotConnection = RunService.Heartbeat:Connect(function()
        for i, dot in ipairs(dots) do
            if dot:IsA("Frame") then
                local angle = (tick() * 5 + i * 0.5) % (2 * math.pi)
                local radius = 20
                local x = math.cos(angle) * radius
                local y = math.sin(angle) * radius
                dot.Position = UDim2.new(0.5, x - 3, 0.5, y - 3)
                dot.BackgroundTransparency = 0.3 + (math.sin(angle) + 1) * 0.35
            end
        end
    end)
    
    -- 渐变动画
    local gradientConnection
    gradientConnection = RunService.Heartbeat:Connect(function(deltaTime)
        barGradient.Offset = Vector2.new((tick() * 0.5) % 1, 0)
    end)
    
    -- 进度更新
    local progressConnection
    progressConnection = RunService.Heartbeat:Connect(function(deltaTime)
        if progress < 100 then
            -- 动态加载速度（开始时快，结束时慢）
            local speed = 40
            if progress > 80 then
                speed = 15
            elseif progress > 50 then
                speed = 25
            end
            
            progress = math.min(progress + deltaTime * speed, 100)
            
            -- 更新进度条（带缓动效果）
            local tweenInfo = TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
            TweenService:Create(progressBar, tweenInfo, {Size = UDim2.new(progress / 100, 0, 1, 0)}):Play()
            
            percentText.Text = string.format("%d%%", math.floor(progress))
            
            -- 更新提示文本
            if progress < 30 then
                hintText.Text = "正在初始化..."
            elseif progress < 60 then
                hintText.Text = "正在加载资源..."
            elseif progress < 90 then
                hintText.Text = "正在优化性能..."
            else
                hintText.Text = "即将完成..."
            end
            
            -- 完成加载
            if progress >= 100 then
                spinConnection:Disconnect()
                dotConnection:Disconnect()
                gradientConnection:Disconnect()
                progressConnection:Disconnect()
                
                -- 加载完成效果
                task.wait(0.5)
                title.Text = "加载完成！"
                subtitle.Text = "汉化by16"
                hintText.Text = "正在进入..."
                
                -- 成功动画
                progressBar.BackgroundColor3 = Color3.fromRGB(0, 200, 100)
                barGradient.Color = ColorSequence.new({
                    ColorSequenceKeypoint.new(0, Color3.fromRGB(0, 200, 100)),
                    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(100, 230, 150)),
                    ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 200, 100))
                })
                
                -- 淡出动画
                task.wait(1)
                local fadeOutInfo = TweenInfo.new(1, Enum.EasingStyle.Quint, Enum.EasingDirection.In)
                
                TweenService:Create(loadingFrame, fadeOutInfo, {BackgroundTransparency = 1}):Play()
                TweenService:Create(title, fadeOutInfo, {TextTransparency = 1}):Play()
                TweenService:Create(subtitle, fadeOutInfo, {TextTransparency = 1}):Play()
                TweenService:Create(progressContainer, fadeOutInfo, {BackgroundTransparency = 1}):Play()
                TweenService:Create(containerStroke, fadeOutInfo, {Transparency = 1}):Play()
                TweenService:Create(percentText, fadeOutInfo, {TextTransparency = 1}):Play()
                TweenService:Create(hintText, fadeOutInfo, {TextTransparency = 1}):Play()
                TweenService:Create(loadingIcon, fadeOutInfo, {BackgroundTransparency = 1}):Play()
                
                -- 隐藏所有点
                for _, dot in ipairs(dots) do
                    if dot:IsA("Frame") then
                        TweenService:Create(dot, fadeOutInfo, {BackgroundTransparency = 1}):Play()
                    end
                end
                
                task.wait(1.2)
                TweenService:Create(background, fadeOutInfo, {BackgroundTransparency = 1}):Play()
                
                task.wait(1)
                
                -- 执行loadstring
                -- 汉化
-- 自动生成的汉化脚本

local Translations = {["Vgxmod Hub"] = "Vgxmod 🇨🇳 ",
    ["Discord"] = "discord",
    ["Credits"] = "脚本作者的dc",
    ["Made By: Pkgx1"] = "汉化by16(不是脚本作者)",
    ["Main"] = "主要",
    ["Info"] = "公告",
    ["Settings"] = "UI设置",
    ["TELEPORT"] = "传送",
    ["TP Elevator"] = "传送至电梯",
    ["AUTOMATION"] = "自动",
    ["Auto Farm"] = "自动农场",
    ["Auto Open"] = "自动互动",
    ["Auto Rescue (NPC)"] = "自动救援NPC",
    ["Auto Loot (Item)"] = "自动收集食材需要出电梯门才可运行",
    ["Auto Loot (Gear)"] = "自动收集装备需要出电梯门",
    ["Auto Open (Crate + More)"] = "自动打开所有物品",
    ["ESP"] = "视觉",
    ["Crate ESP"] = "透视箱子",
    ["Cabinet ESP"] = "柜子透视",
    ["Loot ESP"] = "透视食材",
    ["Oil Bucket ESP"] = "透视油桶",
    ["Monster ESP"] = "透视怪物",
    ["NPC ESP"] = "透视NPC",
    ["Player ESP"] = "球员透视",
    ["PLAYER"] = "玩家",
    ["Walk Speed"] = "速度",
    ["Value"] = "速度滑块",
    ["Anti Trap (Monster)"] = "反陷阱/怪物",
    ["Infinity Stamina"] = "无限体力",
    ["Always (SafeZone)"] = "始终安全区域",
    ["discord"] = "控制",
    ["On Discord!"] = "对,discord",
    ["You Can Request Script"] = "你可以请求脚本",
    ["MOBILE USER"] = "手机",
    ["PC USER"] = "PC端(电脑)",
    ["Just Press The CTRL"] = "点击ctrl打开",
    ["To Close The Menu"] = "点击按钮关闭",
    ["Simply Click the Icon"] = "点击按钮关闭",
    ["Copy"] = "点击复制",
    ["To Close the Menu"] = "点击ctrl关闭",
    ["Discord Link"] = "discord链接",
    [""] = "",
    }

local function translateText(text)
    if not text or type(text) ~= "string" then return text end
    
    if Translations[text] then
        return Translations[text]
    end
    
    for en, cn in pairs(Translations) do
        if text:find(en) then
            return text:gsub(en, cn)
        end
    end
    
    return text
end

local function setupTranslationEngine()
    local success, err = pcall(function()
        local oldIndex = getrawmetatable(game).__newindex
        setreadonly(getrawmetatable(game), false)
        
        getrawmetatable(game).__newindex = newcclosure(function(t, k, v)
            if (t:IsA("TextLabel") or t:IsA("TextButton") or t:IsA("TextBox")) and k == "Text" then
                v = translateText(tostring(v))
            end
            return oldIndex(t, k, v)
        end)
        
        setreadonly(getrawmetatable(game), true)
    end)
    
    if not success then
        warn("元表劫持失败:", err)
       
        local translated = {}
        local function scanAndTranslate()
            for _, gui in ipairs(game:GetService("CoreGui"):GetDescendants()) do
                if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                    pcall(function()
                        local text = gui.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                gui.Text = translatedText
                                translated[gui] = true
                            end
                        end
                    end)
                end
            end
            
            local player = game:GetService("Players").LocalPlayer
            if player and player:FindFirstChild("PlayerGui") then
                for _, gui in ipairs(player.PlayerGui:GetDescendants()) do
                    if (gui:IsA("TextLabel") or gui:IsA("TextButton") or gui:IsA("TextBox")) and not translated[gui] then
                        pcall(function()
                            local text = gui.Text
                            if text and text ~= "" then
                                local translatedText = translateText(text)
                                if translatedText ~= text then
                                    gui.Text = translatedText
                                    translated[gui] = true
                                end
                            end
                        end)
                    end
                end
            end
        end
        
        local function setupDescendantListener(parent)
            parent.DescendantAdded:Connect(function(descendant)
                if descendant:IsA("TextLabel") or descendant:IsA("TextButton") or descendant:IsA("TextBox") then
                    task.wait(0.1)
                    pcall(function()
                        local text = descendant.Text
                        if text and text ~= "" then
                            local translatedText = translateText(text)
                            if translatedText ~= text then
                                descendant.Text = translatedText
                            end
                        end
                    end)
                end
            end)
        end
        
        pcall(setupDescendantListener, game:GetService("CoreGui"))
        local player = game:GetService("Players").LocalPlayer
        if player and player:FindFirstChild("PlayerGui") then
            pcall(setupDescendantListener, player.PlayerGui)
        end
        
        while true do
            scanAndTranslate()
            task.wait(3)
        end
    end
end

task.wait(2)

setupTranslationEngine()

local success, err = pcall(function()
loadstring(game:HttpGet("https://raw.githubusercontent.com/VGXMODPLAYER68/Vgxmod-Hub/refs/heads/main/Deadly%20delivery.lua"))()
end)

if not success then
    warn("加载失败:", err)
end
                
                gui:Destroy()
                print("增强版加载界面演示完成")
            end
        end
    end)
end

-- 延迟启动以显示动画效果
task.wait(0.5)
simulateLoading()
