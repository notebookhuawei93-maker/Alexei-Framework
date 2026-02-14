# 🚀 Alexei Framework

A modern and beautiful UI library for Roblox with a clean design inspired by Discord.

## ✨ Features

- 🎨 **Modern Design** - Clean and professional look
- 📱 **Draggable Windows** - Move windows anywhere
- 🔘 **Interactive Elements** - Buttons, Toggles, Sliders, Dropdowns
- 🎯 **Tab System** - Organized with active/inactive states
- ℹ️ **Info/Warning/Label** - Different message types
- 🌈 **Smooth Animations** - Fluid transitions and hover effects

## 📦 Installation

```lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/ТВОЙ_ЛОГИН/Alexei-Framework/main/source.lua"))()

📖 Usage
Creating a Window
lua
local window = Library:CreateWindow("My Script")

Adding Tabs
lua
local mainTab = window:AddTab("Main", "rbxassetid://10723407389")
local settingsTab = window:AddTab("Settings", "rbxassetid://10747384394")

🎮 Available Elements
Button
lua
tab:AddButton("Click Me", function()
    print("Button clicked!")
end)

Toggle
lua
tab:AddToggle("Enable Feature", true, function(state)
    print("Toggle:", state)
end)

Slider
lua
tab:AddSlider("Volume", 0, 100, 50, function(value)
    print("Volume:", value)
end)

Dropdown
lua
tab:AddDropdown("Select Game", {"Game 1", "Game 2"}, function(option)
    print("Selected:", option)
end)

Info/Warning/Label
lua
tab:AddInfo("Information message")
tab:AddWarning("Warning message")
tab:AddLabel("Simple label")
📸 Preview
https://via.placeholder.com/400x300/1c1c1c/ffffff?text=Alexei+Framework+Preview

📋 Example
See the example.lua file for a complete usage example.

📜 License
This project is licensed under the MIT License.

🤝 Contributing
Feel free to submit issues and pull requests.

⭐ Support
If you like this library, don't forget to star the repository!

Created with ❤️ by Alexei

text

## 🔧 ЧТО ЗАМЕНИТЬ:
1. `ТВОЙ_ЛОГИН` → на свой GitHub ник
2. Если репозиторий называется не `Alexei-Framework`, замени и это

Готово! Один цельный файл README.md
