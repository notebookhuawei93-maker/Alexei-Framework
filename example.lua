-- Пример использования библиотеки Alexei Framework
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ТВОЙ_ЛОГИН/Alexei-Framework/main/source.lua"))()

-- Создаем главное окно
local window = Library:CreateWindow("Alexei Framework v1.0")

-- Добавляем вкладку "Main" с иконкой дома
local mainTab = window:AddTab("Main", "rbxassetid://10723407389")

-- КНОПКА
mainTab:AddButton("Click Me!", function()
    print("✅ Button clicked!")
    game:GetService("StarterGui"):SetCore("SendNotification", {
        Title = "Alexei Framework",
        Text = "Button clicked!",
        Duration = 2
    })
end)

-- ТОГГЛ (переключатель)
mainTab:AddToggle("Enable Feature", true, function(state)
    print("🔄 Toggle:", state)
end)

-- СЛАЙДЕР
mainTab:AddSlider("Volume", 0, 100, 50, function(value)
    print("🔊 Volume:", value)
end)

-- ДРОПДАУН (выпадающий список)
mainTab:AddDropdown("Select Game", {"Pet Simulator", "Blox Fruits", "MM2"}, function(option)
    print("🎮 Selected:", option)
end)

-- ИНФО (синий)
mainTab:AddInfo("Script loaded successfully!")

-- ВАРНИНГ (желтый)
mainTab:AddWarning("Use at your own risk!")

-- ЛЕЙБЕЛ (обычный текст)
mainTab:AddLabel("Version 1.0.0")

-- Вторая вкладка "Settings" с иконкой шестеренки
local settingsTab = window:AddTab("Settings", "rbxassetid://10747384394")

settingsTab:AddToggle("Dark Mode", false, function(state)
    print("🌙 Dark mode:", state)
end)

settingsTab:AddToggle("Auto Execute", true, function(state)
    print("⚡ Auto execute:", state)
end)

settingsTab:AddSlider("Speed", 16, 200, 100, function(value)
    print("🏃 Speed:", value)
end)

print("🎉 Example loaded successfully!")
