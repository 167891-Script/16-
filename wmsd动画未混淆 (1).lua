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
    ["On Discord!"] = "是的，Discord",
    ["You Can Request Script"] = "你可以请求脚本",
    ["MOBILE USER"] = "手机",
    ["PC USER"] = "PC端(电脑)",
    ["Just Press The CTRL"] = "点击ctrl打开",
    ["To Close The Menu"] = "点击按钮关闭",
    ["Simply Click the Icon"] = "点击按钮关闭",
    ["Copy"] = "点击复制",
    ["To Close the Menu"] = "点击ctrl关闭",
    [""] = "",
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
