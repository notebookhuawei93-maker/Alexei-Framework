--[[
	Alexei Framework - Roblox UI Library
	GitHub: https://github.com/alexei/framework
	Полностью сохранен оригинальный дизайн с иконками
]]

--services
local players = game:GetService("Players")
local tweenService = game:GetService("TweenService")
local runService = game:GetService("RunService")
local coregui = game:GetService("CoreGui")
local userInputService = game:GetService("UserInputService")

local Library = {}
Library.Tree = {}
Library.Tabs = {}
Library.CurrentTab = nil
Library.Flags = {}

-- Tween animation
function Library:TweenObject(object, properties, duration, easingStyle, easingDirection)
	duration = duration or 0.2
	easingStyle = easingStyle or Enum.EasingStyle.Quad
	easingDirection = easingDirection or Enum.EasingDirection.Out
	
	local tweenInfo = TweenInfo.new(duration, easingStyle, easingDirection)
	local tween = tweenService:Create(object, tweenInfo, properties)
	tween:Play()
	return tween
end

-- Draggable
function Library:MakeDraggable(frame, dragArea)
	dragArea = dragArea or frame
	local dragging = false
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale, 
			startPos.X.Offset + delta.X,
			startPos.Y.Scale, 
			startPos.Y.Offset + delta.Y
		)
	end

	dragArea.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = frame.Position
		end
	end)

	dragArea.InputEnded:Connect(function()
		dragging = false
	end)

	userInputService.InputChanged:Connect(function(input)
		if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)
end

function Library:CreateWindow(title)
	title = title or "Alexei Framework"
	
	-- ScreenGui
	Library.Tree["1"] = Instance.new("ScreenGui")
	Library.Tree["1"].ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	Library.Tree["1"].Name = "AlexeiLibrary"
	Library.Tree["1"].IgnoreGuiInset = true
	Library.Tree["1"].Parent = runService:IsStudio() and players.LocalPlayer:WaitForChild("PlayerGui") or coregui
	
	-- Main Frame
	Library.Tree["2"] = Instance.new("Frame", Library.Tree["1"])
	Library.Tree["2"].BorderSizePixel = 0
	Library.Tree["2"].BackgroundColor3 = Color3.fromRGB(28, 28, 28)
	Library.Tree["2"].Size = UDim2.new(0, 400, 0, 300)
	Library.Tree["2"].Position = UDim2.new(0.5, -200, 0.5, -150)
	Library.Tree["2"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["2"].Name = "Main"
	Library.Tree["2"].Active = true
	
	-- UICorner
	Library.Tree["3"] = Instance.new("UICorner", Library.Tree["2"])
	Library.Tree["3"].CornerRadius = UDim.new(0, 6)
	
	-- TopBar
	Library.Tree["4"] = Instance.new("Frame", Library.Tree["2"])
	Library.Tree["4"].BorderSizePixel = 0
	Library.Tree["4"].BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	Library.Tree["4"].Size = UDim2.new(1, 0, 0, 30)
	Library.Tree["4"].BorderColor3 = Color3.fromRGB(48, 48, 48)
	Library.Tree["4"].Name = "TopBar"
	
	-- Make TopBar draggable
	Library:MakeDraggable(Library.Tree["2"], Library.Tree["4"])
	
	-- TopBar UICorner
	Library.Tree["5"] = Instance.new("UICorner", Library.Tree["4"])
	Library.Tree["5"].CornerRadius = UDim.new(0, 6)
	
	-- Extension
	Library.Tree["6"] = Instance.new("Frame", Library.Tree["4"])
	Library.Tree["6"].BorderSizePixel = 0
	Library.Tree["6"].BackgroundColor3 = Color3.fromRGB(48, 48, 48)
	Library.Tree["6"].AnchorPoint = Vector2.new(0, 1)
	Library.Tree["6"].Size = UDim2.new(1, 0, 1, 0)
	Library.Tree["6"].Position = UDim2.new(0, 0, 1, 0)
	Library.Tree["6"].BorderColor3 = Color3.fromRGB(48, 48, 48)
	Library.Tree["6"].Name = "Extension"
	
	-- Extension UICorner
	Library.Tree["7"] = Instance.new("UICorner", Library.Tree["6"])
	Library.Tree["7"].CornerRadius = UDim.new(0, 6)
	
	-- Title
	Library.Tree["8"] = Instance.new("TextLabel", Library.Tree["4"])
	Library.Tree["8"].BorderSizePixel = 0
	Library.Tree["8"].TextSize = 22
	Library.Tree["8"].TextXAlignment = Enum.TextXAlignment.Left
	Library.Tree["8"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Library.Tree["8"].FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
	Library.Tree["8"].TextColor3 = Color3.fromRGB(255, 255, 255)
	Library.Tree["8"].BackgroundTransparency = 1
	Library.Tree["8"].Size = UDim2.new(0.5, 0, 1, 0)
	Library.Tree["8"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["8"].Text = title
	Library.Tree["8"].Name = "Title"
	
	-- Title Padding
	Library.Tree["9"] = Instance.new("UIPadding", Library.Tree["8"])
	Library.Tree["9"].PaddingTop = UDim.new(0, 1)
	Library.Tree["9"].PaddingLeft = UDim.new(0, 8)
	
	-- Exit Button
	Library.Tree["a"] = Instance.new("ImageButton", Library.Tree["4"])
	Library.Tree["a"].BorderSizePixel = 0
	Library.Tree["a"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Library.Tree["a"].AnchorPoint = Vector2.new(1, 0)
	Library.Tree["a"].Image = "rbxassetid://10747384394"
	Library.Tree["a"].Size = UDim2.new(0, 22, 0, 22)
	Library.Tree["a"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["a"].BackgroundTransparency = 1
	Library.Tree["a"].Name = "ExitButton"
	Library.Tree["a"].Position = UDim2.new(1, -4, 0, 4)
	
	-- Close function
	Library.Tree["a"].MouseButton1Click:Connect(function()
		Library.Tree["1"]:Destroy()
	end)
	
	-- Line
	Library.Tree["b"] = Instance.new("Frame", Library.Tree["4"])
	Library.Tree["b"].BorderSizePixel = 0
	Library.Tree["b"].BackgroundColor3 = Color3.fromRGB(96, 96, 96)
	Library.Tree["b"].AnchorPoint = Vector2.new(0, 1)
	Library.Tree["b"].Size = UDim2.new(1, 0, 0, 1)
	Library.Tree["b"].Position = UDim2.new(0, 0, 1, 0)
	Library.Tree["b"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["b"].Name = "Line"
	
	-- Navigation
	Library.Tree["c"] = Instance.new("Frame", Library.Tree["2"])
	Library.Tree["c"].ZIndex = 2
	Library.Tree["c"].BorderSizePixel = 0
	Library.Tree["c"].BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	Library.Tree["c"].Size = UDim2.new(0, 120, 1, -31)
	Library.Tree["c"].Position = UDim2.new(0, 0, 0, 30)
	Library.Tree["c"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["c"].Name = "Navigation"
	
	-- Navigation UICorner
	Library.Tree["d"] = Instance.new("UICorner", Library.Tree["c"])
	Library.Tree["d"].CornerRadius = UDim.new(0, 6)
	
	-- Hide (top corner fix)
	Library.Tree["e"] = Instance.new("Frame", Library.Tree["c"])
	Library.Tree["e"].BorderSizePixel = 0
	Library.Tree["e"].BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	Library.Tree["e"].Size = UDim2.new(1, 0, 0, 20)
	Library.Tree["e"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["e"].Name = "Hide"
	
	-- Hide2 (right corner fix)
	Library.Tree["f"] = Instance.new("Frame", Library.Tree["c"])
	Library.Tree["f"].BorderSizePixel = 0
	Library.Tree["f"].BackgroundColor3 = Color3.fromRGB(41, 41, 41)
	Library.Tree["f"].AnchorPoint = Vector2.new(1, 0)
	Library.Tree["f"].Size = UDim2.new(0, 20, 1, 0)
	Library.Tree["f"].Position = UDim2.new(1, 0, 0, 0)
	Library.Tree["f"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["f"].Name = "Hide2"
	
	-- ButtonHolder
	Library.Tree["10"] = Instance.new("Frame", Library.Tree["c"])
	Library.Tree["10"].BorderSizePixel = 0
	Library.Tree["10"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Library.Tree["10"].Size = UDim2.new(1, 0, 1, 0)
	Library.Tree["10"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["10"].Name = "ButtonHolder"
	Library.Tree["10"].BackgroundTransparency = 1
	
	-- ButtonHolder Padding
	Library.Tree["11"] = Instance.new("UIPadding", Library.Tree["10"])
	Library.Tree["11"].PaddingTop = UDim.new(0, 8)
	Library.Tree["11"].PaddingBottom = UDim.new(0, 8)
	
	-- ButtonHolder Layout
	Library.Tree["12"] = Instance.new("UIListLayout", Library.Tree["10"])
	Library.Tree["12"].Padding = UDim.new(0, 1)
	Library.Tree["12"].SortOrder = Enum.SortOrder.LayoutOrder
	
	-- Navigation Line
	local NavLine = Instance.new("Frame", Library.Tree["c"])
	NavLine.BorderSizePixel = 0
	NavLine.BackgroundColor3 = Color3.fromRGB(96, 96, 96)
	NavLine.Size = UDim2.new(0, 1, 1, 0)
	NavLine.Position = UDim2.new(1, 0, 0, 0)
	NavLine.BorderColor3 = Color3.fromRGB(0, 0, 0)
	NavLine.Name = "Line"
	
	-- ContentContainer
	Library.Tree["1a"] = Instance.new("Frame", Library.Tree["2"])
	Library.Tree["1a"].BorderSizePixel = 0
	Library.Tree["1a"].BackgroundColor3 = Color3.fromRGB(46, 46, 46)
	Library.Tree["1a"].AnchorPoint = Vector2.new(1, 0)
	Library.Tree["1a"].ClipsDescendants = true
	Library.Tree["1a"].Size = UDim2.new(1, -133, 1, -42)
	Library.Tree["1a"].Position = UDim2.new(1, -6, 0, 36)
	Library.Tree["1a"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["1a"].Name = "ContentContainer"
	
	-- ContentContainer UICorner
	Library.Tree["1b"] = Instance.new("UICorner", Library.Tree["1a"])
	Library.Tree["1b"].CornerRadius = UDim.new(0, 6)
	
	-- Fade
	Library.Tree["67"] = Instance.new("Frame", Library.Tree["1a"])
	Library.Tree["67"].ZIndex = 10
	Library.Tree["67"].BorderSizePixel = 0
	Library.Tree["67"].BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Library.Tree["67"].Size = UDim2.new(1, 0, 0, 30)
	Library.Tree["67"].Position = UDim2.new(0, 0, 0, 0)
	Library.Tree["67"].BorderColor3 = Color3.fromRGB(0, 0, 0)
	Library.Tree["67"].Name = "Fade"
	Library.Tree["67"].BackgroundTransparency = 1
	
	-- Fade Gradient
	Library.Tree["68"] = Instance.new("UIGradient", Library.Tree["67"])
	Library.Tree["68"].Rotation = 90
	Library.Tree["68"].Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0.000, 1),
		NumberSequenceKeypoint.new(0.385, 0.61875),
		NumberSequenceKeypoint.new(1.000, 0.04375)
	}
	Library.Tree["68"].Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0.000, Color3.fromRGB(46, 46, 46)),
		ColorSequenceKeypoint.new(1.000, Color3.fromRGB(46, 46, 46))
	}
	
	-- Window Object
	local WindowObj = {}
	
	-- Add Tab function - СОХРАНЯЕМ ТВОЙ ДИЗАЙН С Active И inactive
	function WindowObj:AddTab(name, iconAsset)
		iconAsset = iconAsset or "rbxassetid://10723407389"
		
		-- Active Tab Button (твой дизайн)
		local ActiveTab = Instance.new("TextLabel")
		ActiveTab.BorderSizePixel = 0
		ActiveTab.TextSize = 12
		ActiveTab.TextXAlignment = Enum.TextXAlignment.Left
		ActiveTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ActiveTab.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		ActiveTab.TextColor3 = Color3.fromRGB(255, 255, 255)
		ActiveTab.BackgroundTransparency = 0.9
		ActiveTab.Size = UDim2.new(1, 0, 0, 24)
		ActiveTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ActiveTab.Text = name
		ActiveTab.Name = "Active"
		ActiveTab.Parent = Library.Tree["10"]
		ActiveTab.Visible = false
		
		-- Active Padding
		local ActivePadding = Instance.new("UIPadding", ActiveTab)
		ActivePadding.PaddingLeft = UDim.new(0, 28)
		
		-- Active Icon (твоя позиция -24)
		local ActiveIcon = Instance.new("ImageLabel", ActiveTab)
		ActiveIcon.BorderSizePixel = 0
		ActiveIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		ActiveIcon.AnchorPoint = Vector2.new(0, 0.5)
		ActiveIcon.Image = iconAsset
		ActiveIcon.Size = UDim2.new(0, 20, 0, 20)
		ActiveIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		ActiveIcon.BackgroundTransparency = 1
		ActiveIcon.Name = "icon"
		ActiveIcon.Position = UDim2.new(0, -24, 0.5, 0)
		
		-- Inactive Tab Button (твой дизайн)
		local InactiveTab = Instance.new("TextLabel")
		InactiveTab.BorderSizePixel = 0
		InactiveTab.TextSize = 12
		InactiveTab.TextXAlignment = Enum.TextXAlignment.Left
		InactiveTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InactiveTab.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
		InactiveTab.TextColor3 = Color3.fromRGB(137, 137, 137)
		InactiveTab.BackgroundTransparency = 1
		InactiveTab.Size = UDim2.new(1, 0, 0, 24)
		InactiveTab.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InactiveTab.Text = name
		InactiveTab.Name = "inactive"
		InactiveTab.Parent = Library.Tree["10"]
		InactiveTab.Visible = true
		
		-- Inactive Padding
		local InactivePadding = Instance.new("UIPadding", InactiveTab)
		InactivePadding.PaddingLeft = UDim.new(0, 28)
		
		-- Inactive Icon (твоя позиция -24)
		local InactiveIcon = Instance.new("ImageLabel", InactiveTab)
		InactiveIcon.BorderSizePixel = 0
		InactiveIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		InactiveIcon.AnchorPoint = Vector2.new(0, 0.5)
		InactiveIcon.Image = iconAsset
		InactiveIcon.Size = UDim2.new(0, 20, 0, 20)
		InactiveIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
		InactiveIcon.BackgroundTransparency = 1
		InactiveIcon.Name = "icon"
		InactiveIcon.Position = UDim2.new(0, -24, 0.5, 0)
		
		-- Page
		local TabPage = Instance.new("ScrollingFrame")
		TabPage.Name = name .. "Page"
		TabPage.ScrollBarImageTransparency = 1
		TabPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabPage.Selectable = false
		TabPage.ClipsDescendants = false
		TabPage.Size = UDim2.new(1, 0, 1, 0)
		TabPage.BorderColor3 = Color3.fromRGB(0, 0, 0)
		TabPage.BackgroundTransparency = 1
		TabPage.Visible = false
		TabPage.Parent = Library.Tree["1a"]
		
		-- Page Padding
		local PagePadding = Instance.new("UIPadding", TabPage)
		PagePadding.PaddingTop = UDim.new(0, 1)
		PagePadding.PaddingRight = UDim.new(0, 1)
		PagePadding.PaddingLeft = UDim.new(0, 1)
		PagePadding.PaddingBottom = UDim.new(0, 1)
		
		-- Page Layout
		local PageLayout = Instance.new("UIListLayout", TabPage)
		PageLayout.Padding = UDim.new(0, 4)
		PageLayout.SortOrder = Enum.SortOrder.LayoutOrder
		
		-- Update CanvasSize
		PageLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			TabPage.CanvasSize = UDim2.new(0, 0, 0, PageLayout.AbsoluteContentSize.Y + 2)
		end)
		
		-- Click handler
		InactiveTab.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				-- Hide all pages
				for _, child in pairs(Library.Tree["1a"]:GetChildren()) do
					if child:IsA("ScrollingFrame") then
						child.Visible = false
					end
				end
				TabPage.Visible = true
				
				-- Update all tabs
				for _, child in pairs(Library.Tree["10"]:GetChildren()) do
					if child:IsA("TextLabel") then
						if child.Name == "Active" then
							child.Visible = false
						elseif child.Name == "inactive" then
							child.Visible = true
						end
					end
				end
				
				-- Show active, hide inactive for this tab
				ActiveTab.Visible = true
				InactiveTab.Visible = false
			end
		end)
		
		ActiveTab.InputBegan:Connect(function(input)
			if input.UserInputType == Enum.UserInputType.MouseButton1 then
				-- Hide all pages
				for _, child in pairs(Library.Tree["1a"]:GetChildren()) do
					if child:IsA("ScrollingFrame") then
						child.Visible = false
					end
				end
				TabPage.Visible = true
				
				-- Update all tabs
				for _, child in pairs(Library.Tree["10"]:GetChildren()) do
					if child:IsA("TextLabel") then
						if child.Name == "Active" then
							child.Visible = false
						elseif child.Name == "inactive" then
							child.Visible = true
						end
					end
				end
				
				-- Show active, hide inactive for this tab
				ActiveTab.Visible = true
				InactiveTab.Visible = false
			end
		end)
		
		-- Show first tab by default
		local anyVisible = false
		for _, child in pairs(Library.Tree["1a"]:GetChildren()) do
			if child:IsA("ScrollingFrame") and child.Visible then
				anyVisible = true
				break
			end
		end
		
		if not anyVisible then
			TabPage.Visible = true
			ActiveTab.Visible = true
			InactiveTab.Visible = false
		end
		
		-- Tab Object with elements
		local TabObj = {}
		
		-- BUTTON (твой дизайн)
		function TabObj:AddButton(text, callback)
			callback = callback or function() end
			
			local ButtonFrame = Instance.new("Frame")
			ButtonFrame.BorderSizePixel = 0
			ButtonFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			ButtonFrame.Size = UDim2.new(1, 0, 0, 32)
			ButtonFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonFrame.Name = "Button"
			ButtonFrame.Parent = TabPage
			
			local ButtonCorner = Instance.new("UICorner", ButtonFrame)
			ButtonCorner.CornerRadius = UDim.new(0, 4)
			
			local ButtonStroke = Instance.new("UIStroke", ButtonFrame)
			ButtonStroke.Color = Color3.fromRGB(41, 41, 41)
			ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			local ButtonText = Instance.new("TextLabel", ButtonFrame)
			ButtonText.BorderSizePixel = 0
			ButtonText.TextSize = 14
			ButtonText.TextXAlignment = Enum.TextXAlignment.Left
			ButtonText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ButtonText.BackgroundTransparency = 1
			ButtonText.Size = UDim2.new(1, -20, 1, 0)
			ButtonText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonText.Text = text
			
			local ButtonPadding = Instance.new("UIPadding", ButtonFrame)
			ButtonPadding.PaddingTop = UDim.new(0, 6)
			ButtonPadding.PaddingRight = UDim.new(0, 6)
			ButtonPadding.PaddingLeft = UDim.new(0, 6)
			ButtonPadding.PaddingBottom = UDim.new(0, 6)
			
			local ButtonIcon = Instance.new("ImageLabel", ButtonFrame)
			ButtonIcon.BorderSizePixel = 0
			ButtonIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ButtonIcon.AnchorPoint = Vector2.new(1, 0)
			ButtonIcon.Image = "rbxassetid://10734898355"
			ButtonIcon.Size = UDim2.new(0, 20, 0, 20)
			ButtonIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ButtonIcon.BackgroundTransparency = 1
			ButtonIcon.Name = "icon"
			ButtonIcon.Position = UDim2.new(1, 0, 0, 0)
			
			ButtonFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					callback()
				end
			end)
			
			return ButtonFrame
		end
		
		-- INFO (синий - твой дизайн)
		function TabObj:AddInfo(text)
			local InfoFrame = Instance.new("Frame")
			InfoFrame.BorderSizePixel = 0
			InfoFrame.BackgroundColor3 = Color3.fromRGB(0, 88, 131)
			InfoFrame.Size = UDim2.new(1, 0, 0, 32)
			InfoFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InfoFrame.Name = "info"
			InfoFrame.Parent = TabPage
			
			local InfoCorner = Instance.new("UICorner", InfoFrame)
			InfoCorner.CornerRadius = UDim.new(0, 4)
			
			local InfoStroke = Instance.new("UIStroke", InfoFrame)
			InfoStroke.Color = Color3.fromRGB(0, 0, 131)
			InfoStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			local InfoText = Instance.new("TextLabel", InfoFrame)
			InfoText.BorderSizePixel = 0
			InfoText.TextSize = 14
			InfoText.TextXAlignment = Enum.TextXAlignment.Left
			InfoText.BackgroundColor3 = Color3.fromRGB(61, 64, 71)
			InfoText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			InfoText.TextColor3 = Color3.fromRGB(255, 255, 255)
			InfoText.BackgroundTransparency = 1
			InfoText.Size = UDim2.new(1, 0, 1, 0)
			InfoText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InfoText.Text = text
			
			local InfoIcon = Instance.new("ImageLabel", InfoText)
			InfoIcon.BorderSizePixel = 0
			InfoIcon.BackgroundColor3 = Color3.fromRGB(0, 171, 255)
			InfoIcon.ImageColor3 = Color3.fromRGB(0, 171, 255)
			InfoIcon.AnchorPoint = Vector2.new(0, 0.5)
			InfoIcon.Image = "rbxassetid://10723415903"
			InfoIcon.Size = UDim2.new(0, 20, 0, 20)
			InfoIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			InfoIcon.BackgroundTransparency = 1
			InfoIcon.Name = "icon"
			InfoIcon.Position = UDim2.new(0, 6, 0.5, 0)  -- Исправлено с -26 на 6
			
			local InfoTextPadding = Instance.new("UIPadding", InfoText)
			InfoTextPadding.PaddingLeft = UDim.new(0, 32)  -- Увеличено с 22 до 32
			
			local InfoPadding = Instance.new("UIPadding", InfoFrame)
			InfoPadding.PaddingTop = UDim.new(0, 6)
			InfoPadding.PaddingRight = UDim.new(0, 6)
			InfoPadding.PaddingLeft = UDim.new(0, 6)
			InfoPadding.PaddingBottom = UDim.new(0, 6)
			
			return InfoFrame
		end
		
		-- WARNING (желтый - твой дизайн)
		function TabObj:AddWarning(text)
			local WarnFrame = Instance.new("Frame")
			WarnFrame.BorderSizePixel = 0
			WarnFrame.BackgroundColor3 = Color3.fromRGB(81, 81, 0)
			WarnFrame.Size = UDim2.new(1, 0, 0, 32)
			WarnFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WarnFrame.Name = "Warning"
			WarnFrame.Parent = TabPage
			
			local WarnCorner = Instance.new("UICorner", WarnFrame)
			WarnCorner.CornerRadius = UDim.new(0, 4)
			
			local WarnStroke = Instance.new("UIStroke", WarnFrame)
			WarnStroke.Color = Color3.fromRGB(128, 128, 0)
			WarnStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			local WarnText = Instance.new("TextLabel", WarnFrame)
			WarnText.BorderSizePixel = 0
			WarnText.TextSize = 14
			WarnText.TextXAlignment = Enum.TextXAlignment.Left
			WarnText.BackgroundColor3 = Color3.fromRGB(61, 64, 71)
			WarnText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			WarnText.TextColor3 = Color3.fromRGB(255, 255, 255)
			WarnText.BackgroundTransparency = 1
			WarnText.Size = UDim2.new(1, 0, 1, 0)
			WarnText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WarnText.Text = text
			
			local WarnIcon = Instance.new("ImageLabel", WarnText)
			WarnIcon.BorderSizePixel = 0
			WarnIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			WarnIcon.ImageColor3 = Color3.fromRGB(140, 140, 0)
			WarnIcon.AnchorPoint = Vector2.new(0, 0.5)
			WarnIcon.Image = "rbxassetid://10709753149"
			WarnIcon.Size = UDim2.new(0, 20, 0, 20)
			WarnIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			WarnIcon.BackgroundTransparency = 1
			WarnIcon.Name = "icon"
			WarnIcon.Position = UDim2.new(0, 6, 0.5, 0)  -- Исправлено с -26 на 6
			
			local WarnTextPadding = Instance.new("UIPadding", WarnText)
			WarnTextPadding.PaddingLeft = UDim.new(0, 32)  -- Увеличено с 22 до 32
			
			local WarnPadding = Instance.new("UIPadding", WarnFrame)
			WarnPadding.PaddingTop = UDim.new(0, 6)
			WarnPadding.PaddingRight = UDim.new(0, 6)
			WarnPadding.PaddingLeft = UDim.new(0, 6)
			WarnPadding.PaddingBottom = UDim.new(0, 6)
			
			return WarnFrame
		end
		
		-- LABEL (твой дизайн)
		function TabObj:AddLabel(text)
			local LabelFrame = Instance.new("Frame")
			LabelFrame.BorderSizePixel = 0
			LabelFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			LabelFrame.Size = UDim2.new(1, 0, 0, 32)
			LabelFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LabelFrame.Name = "Label"
			LabelFrame.Parent = TabPage
			
			local LabelCorner = Instance.new("UICorner", LabelFrame)
			LabelCorner.CornerRadius = UDim.new(0, 4)
			
			local LabelText = Instance.new("TextLabel", LabelFrame)
			LabelText.BorderSizePixel = 0
			LabelText.TextSize = 14
			LabelText.TextXAlignment = Enum.TextXAlignment.Left
			LabelText.BackgroundColor3 = Color3.fromRGB(61, 64, 71)
			LabelText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			LabelText.TextColor3 = Color3.fromRGB(255, 255, 255)
			LabelText.BackgroundTransparency = 1
			LabelText.Size = UDim2.new(1, 0, 1, 0)
			LabelText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LabelText.Text = text
			
			local LabelIcon = Instance.new("ImageLabel", LabelText)
			LabelIcon.BorderSizePixel = 0
			LabelIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			LabelIcon.ImageColor3 = Color3.fromRGB(89, 89, 89)
			LabelIcon.AnchorPoint = Vector2.new(0, 0.5)
			LabelIcon.Image = "rbxassetid://10723406885"
			LabelIcon.Size = UDim2.new(0, 20, 0, 20)
			LabelIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			LabelIcon.BackgroundTransparency = 1
			LabelIcon.Name = "icon"
			LabelIcon.Position = UDim2.new(0, 6, 0.5, 0)  -- Исправлено с -26 на 6
			
			local LabelTextPadding = Instance.new("UIPadding", LabelText)
			LabelTextPadding.PaddingLeft = UDim.new(0, 32)  -- Увеличено с 22 до 32
			
			local LabelPadding = Instance.new("UIPadding", LabelFrame)
			LabelPadding.PaddingTop = UDim.new(0, 6)
			LabelPadding.PaddingRight = UDim.new(0, 6)
			LabelPadding.PaddingLeft = UDim.new(0, 6)
			LabelPadding.PaddingBottom = UDim.new(0, 6)
			
			local LabelStroke = Instance.new("UIStroke", LabelFrame)
			LabelStroke.Color = Color3.fromRGB(41, 41, 41)
			LabelStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			return LabelFrame
		end
		
		-- SLIDER (рабочий, с твоим дизайном)
		function TabObj:AddSlider(text, min, max, default, callback)
			min = min or 0
			max = max or 100
			default = default or 50
			callback = callback or function() end
			
			local value = math.clamp(default, min, max)
			local dragging = false
			
			local SliderFrame = Instance.new("Frame")
			SliderFrame.BorderSizePixel = 0
			SliderFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			SliderFrame.Size = UDim2.new(1, 0, 0, 38)
			SliderFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderFrame.Name = "Slider"
			SliderFrame.Parent = TabPage
			
			local SliderCorner = Instance.new("UICorner", SliderFrame)
			SliderCorner.CornerRadius = UDim.new(0, 4)
			
			local SliderStroke = Instance.new("UIStroke", SliderFrame)
			SliderStroke.Color = Color3.fromRGB(41, 41, 41)
			SliderStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			local SliderText = Instance.new("TextLabel", SliderFrame)
			SliderText.BorderSizePixel = 0
			SliderText.TextSize = 14
			SliderText.TextXAlignment = Enum.TextXAlignment.Left
			SliderText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			SliderText.TextColor3 = Color3.fromRGB(255, 255, 255)
			SliderText.BackgroundTransparency = 1
			SliderText.Size = UDim2.new(1, -24, 1, -10)
			SliderText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderText.Text = text
			
			local SliderPadding = Instance.new("UIPadding", SliderFrame)
			SliderPadding.PaddingTop = UDim.new(0, 6)
			SliderPadding.PaddingRight = UDim.new(0, 6)
			SliderPadding.PaddingLeft = UDim.new(0, 6)
			SliderPadding.PaddingBottom = UDim.new(0, 6)
			
			local ValueLabel = Instance.new("TextLabel", SliderFrame)
			ValueLabel.BorderSizePixel = 0
			ValueLabel.TextSize = 14
			ValueLabel.TextXAlignment = Enum.TextXAlignment.Right
			ValueLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ValueLabel.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
			ValueLabel.BackgroundTransparency = 1
			ValueLabel.AnchorPoint = Vector2.new(1, 0)
			ValueLabel.Size = UDim2.new(0, 24, 1, -10)
			ValueLabel.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ValueLabel.Text = tostring(math.floor(value))
			ValueLabel.Name = "Value"
			ValueLabel.Position = UDim2.new(1, 0, 0, 0)
			
			local SliderBack = Instance.new("Frame", SliderFrame)
			SliderBack.BorderSizePixel = 0
			SliderBack.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
			SliderBack.AnchorPoint = Vector2.new(0, 1)
			SliderBack.Size = UDim2.new(1, 0, 0, 4)
			SliderBack.Position = UDim2.new(0, 0, 1, 0)
			SliderBack.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SliderBack.Name = "SliderBack"
			
			local SliderBackStroke = Instance.new("UIStroke", SliderBack)
			SliderBackStroke.Color = Color3.fromRGB(41, 41, 41)
			SliderBackStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			local SliderBackCorner = Instance.new("UICorner", SliderBack)
			SliderBackCorner.CornerRadius = UDim.new(0, 4)
			
			local Draggable = Instance.new("Frame", SliderBack)
			Draggable.BorderSizePixel = 0
			Draggable.BackgroundColor3 = Color3.fromRGB(76, 76, 76)
			Draggable.Size = UDim2.new((value - min) / (max - min), 0, 1, 0)
			Draggable.BorderColor3 = Color3.fromRGB(0, 0, 0)
			Draggable.Name = "Draggable"
			
			local DraggableCorner = Instance.new("UICorner", Draggable)
			DraggableCorner.CornerRadius = UDim.new(0, 4)
			
			-- Slider Logic
			local function updateSlider(input)
				local mousePos = userInputService:GetMouseLocation()
				local sliderPos = SliderBack.AbsolutePosition.X
				local sliderSize = SliderBack.AbsoluteSize.X
				local percent = math.clamp((mousePos - sliderPos) / sliderSize, 0, 1)
				
				value = min + (max - min) * percent
				Draggable.Size = UDim2.new(percent, 0, 1, 0)
				ValueLabel.Text = tostring(math.floor(value))
				callback(value)
			end
			
			SliderBack.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					updateSlider(input)
				end
			end)
			
			SliderBack.InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
					updateSlider(input)
				end
			end)
			
			userInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = false
				end
			end)
			
			return SliderFrame
		end
		
		-- TOGGLE (рабочий, с твоим дизайном)
		function TabObj:AddToggle(text, default, callback)
			default = default or false
			callback = callback or function() end
			
			local toggled = default
			
			local ToggleFrame = Instance.new("Frame")
			ToggleFrame.BorderSizePixel = 0
			ToggleFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			ToggleFrame.Size = UDim2.new(1, 0, 0, 32)
			ToggleFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleFrame.Name = "Toggle"
			ToggleFrame.Parent = TabPage
			
			local ToggleCorner = Instance.new("UICorner", ToggleFrame)
			ToggleCorner.CornerRadius = UDim.new(0, 4)
			
			local ToggleStroke = Instance.new("UIStroke", ToggleFrame)
			ToggleStroke.Color = toggled and Color3.fromRGB(0, 117, 0) or Color3.fromRGB(41, 41, 41)
			ToggleStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			local ToggleText = Instance.new("TextLabel", ToggleFrame)
			ToggleText.BorderSizePixel = 0
			ToggleText.TextSize = 14
			ToggleText.TextXAlignment = Enum.TextXAlignment.Left
			ToggleText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			ToggleText.TextColor3 = Color3.fromRGB(255, 255, 255)
			ToggleText.BackgroundTransparency = 1
			ToggleText.Size = UDim2.new(1, -26, 1, 0)
			ToggleText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			ToggleText.Text = text
			
			local TogglePadding = Instance.new("UIPadding", ToggleFrame)
			TogglePadding.PaddingTop = UDim.new(0, 6)
			TogglePadding.PaddingRight = UDim.new(0, 6)
			TogglePadding.PaddingLeft = UDim.new(0, 6)
			TogglePadding.PaddingBottom = UDim.new(0, 6)
			
			local CheckHolder = Instance.new("Frame", ToggleFrame)
			CheckHolder.BorderSizePixel = 0
			CheckHolder.BackgroundColor3 = toggled and Color3.fromRGB(0, 117, 0) or Color3.fromRGB(76, 76, 76)
			CheckHolder.AnchorPoint = Vector2.new(1, 0.5)
			CheckHolder.Size = UDim2.new(0, 20, 0, 20)
			CheckHolder.Position = UDim2.new(1, -3, 0.5, 0)
			CheckHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CheckHolder.Name = "CheckMarkHolder"
			
			local HolderCorner = Instance.new("UICorner", CheckHolder)
			HolderCorner.CornerRadius = UDim.new(0, 2)
			
			local CheckMark = Instance.new("ImageLabel", CheckHolder)
			CheckMark.BorderSizePixel = 0
			CheckMark.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			CheckMark.AnchorPoint = Vector2.new(0.5, 0.5)
			CheckMark.Image = "rbxassetid://10709790644"
			CheckMark.Size = UDim2.new(1, -2, 1, -2)
			CheckMark.BorderColor3 = Color3.fromRGB(0, 0, 0)
			CheckMark.BackgroundTransparency = 1
			CheckMark.Name = "CheckMark"
			CheckMark.Position = UDim2.new(0.5, 0, 0.5, 0)
			CheckMark.ImageTransparency = toggled and 0 or 1
			
			ToggleFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					toggled = not toggled
					
					CheckHolder.BackgroundColor3 = toggled and Color3.fromRGB(0, 117, 0) or Color3.fromRGB(76, 76, 76)
					CheckMark.ImageTransparency = toggled and 0 or 1
					ToggleStroke.Color = toggled and Color3.fromRGB(0, 117, 0) or Color3.fromRGB(41, 41, 41)
					
					callback(toggled)
				end
			end)
			
			return ToggleFrame
		end
		
		-- DROPDOWN (рабочий, с твоим дизайном)
		function TabObj:AddDropdown(text, options, callback)
			options = options or {"Option 1", "Option 2", "Option 3"}
			callback = callback or function() end
			
			local selected = options[1] or "Option"
			local open = false
			
			local DropFrame = Instance.new("Frame")
			DropFrame.BorderSizePixel = 0
			DropFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
			DropFrame.ClipsDescendants = true
			DropFrame.Size = UDim2.new(1, 0, 0, 30)
			DropFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropFrame.Name = "DropDown"
			DropFrame.Parent = TabPage
			
			local DropCorner = Instance.new("UICorner", DropFrame)
			DropCorner.CornerRadius = UDim.new(0, 4)
			
			local DropStroke = Instance.new("UIStroke", DropFrame)
			DropStroke.Color = Color3.fromRGB(41, 41, 41)
			DropStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			
			local DropText = Instance.new("TextLabel", DropFrame)
			DropText.BorderSizePixel = 0
			DropText.TextSize = 14
			DropText.TextXAlignment = Enum.TextXAlignment.Left
			DropText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropText.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			DropText.TextColor3 = Color3.fromRGB(255, 255, 255)
			DropText.BackgroundTransparency = 1
			DropText.Size = UDim2.new(1, -20, 0, 20)
			DropText.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropText.Text = text .. ": " .. selected
			
			local DropPadding = Instance.new("UIPadding", DropFrame)
			DropPadding.PaddingTop = UDim.new(0, 6)
			DropPadding.PaddingRight = UDim.new(0, 6)
			DropPadding.PaddingLeft = UDim.new(0, 6)
			DropPadding.PaddingBottom = UDim.new(0, 6)
			
			local DropIcon = Instance.new("ImageLabel", DropFrame)
			DropIcon.BorderSizePixel = 0
			DropIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			DropIcon.AnchorPoint = Vector2.new(1, 0)
			DropIcon.Image = "rbxassetid://10734944326"
			DropIcon.Size = UDim2.new(0, 20, 0, 20)
			DropIcon.BorderColor3 = Color3.fromRGB(0, 0, 0)
			DropIcon.BackgroundTransparency = 1
			DropIcon.Name = "icon"
			DropIcon.Position = UDim2.new(1, 0, 0, 0)
			
			local OptionsHolder = Instance.new("Frame", DropFrame)
			OptionsHolder.Visible = false
			OptionsHolder.BorderSizePixel = 0
			OptionsHolder.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			OptionsHolder.Size = UDim2.new(1, 0, 0, 0)
			OptionsHolder.Position = UDim2.new(0, 0, 0, 25)
			OptionsHolder.BorderColor3 = Color3.fromRGB(0, 0, 0)
			OptionsHolder.Name = "OptionsHolder"
			OptionsHolder.BackgroundTransparency = 1
			OptionsHolder.ClipsDescendants = true
			
			local OptionsLayout = Instance.new("UIListLayout", OptionsHolder)
			OptionsLayout.Padding = UDim.new(0, 4)
			OptionsLayout.SortOrder = Enum.SortOrder.LayoutOrder
			
			-- Create options
			for _, opt in ipairs(options) do
				-- Inactive Option (твой дизайн)
				local InactiveOpt = Instance.new("TextLabel")
				InactiveOpt.BorderSizePixel = 0
				InactiveOpt.TextSize = 12
				InactiveOpt.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
				InactiveOpt.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				InactiveOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
				InactiveOpt.Size = UDim2.new(1, 0, 0, 18)
				InactiveOpt.BorderColor3 = Color3.fromRGB(0, 0, 0)
				InactiveOpt.Text = opt
				InactiveOpt.Name = "inactive Option"
				InactiveOpt.Parent = OptionsHolder
				InactiveOpt.Visible = true
				
				local InactiveStroke = Instance.new("UIStroke", InactiveOpt)
				InactiveStroke.Color = Color3.fromRGB(41, 41, 41)
				InactiveStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				
				local InactiveCorner = Instance.new("UICorner", InactiveOpt)
				InactiveCorner.CornerRadius = UDim.new(0, 2)
				
				-- Hover Option (твой дизайн) - невидимый, используется для анимации
				local HoverOpt = Instance.new("TextLabel")
				HoverOpt.BorderSizePixel = 0
				HoverOpt.TextSize = 12
				HoverOpt.BackgroundColor3 = Color3.fromRGB(46, 46, 46)
				HoverOpt.FontFace = Font.new("rbxasset://fonts/families/Ubuntu.json", Enum.FontWeight.Regular, Enum.FontStyle.Normal)
				HoverOpt.TextColor3 = Color3.fromRGB(255, 255, 255)
				HoverOpt.Size = UDim2.new(1, 0, 0, 18)
				HoverOpt.BorderColor3 = Color3.fromRGB(0, 0, 0)
				HoverOpt.Text = opt
				HoverOpt.Name = "Hover Option"
				HoverOpt.Parent = OptionsHolder
				HoverOpt.Visible = false
				
				local HoverStroke = Instance.new("UIStroke", HoverOpt)
				HoverStroke.Color = Color3.fromRGB(81, 81, 81)
				HoverStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				
				local HoverCorner = Instance.new("UICorner", HoverOpt)
				HoverCorner.CornerRadius = UDim.new(0, 2)
				
				-- Click handler
				InactiveOpt.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						selected = opt
						DropText.Text = text .. ": " .. selected
						open = false
						OptionsHolder.Visible = false
						DropFrame.Size = UDim2.new(1, 0, 0, 30)
						callback(selected)
					end
				end)
				
				InactiveOpt.MouseEnter:Connect(function()
					InactiveOpt.Visible = false
					HoverOpt.Visible = true
				end)
				
				InactiveOpt.MouseLeave:Connect(function()
					InactiveOpt.Visible = true
					HoverOpt.Visible = false
				end)
				
				HoverOpt.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						selected = opt
						DropText.Text = text .. ": " .. selected
						open = false
						OptionsHolder.Visible = false
						DropFrame.Size = UDim2.new(1, 0, 0, 30)
						callback(selected)
					end
				end)
				
				HoverOpt.MouseEnter:Connect(function()
					InactiveOpt.Visible = false
					HoverOpt.Visible = true
				end)
				
				HoverOpt.MouseLeave:Connect(function()
					InactiveOpt.Visible = true
					HoverOpt.Visible = false
				end)
			end
			
			-- Toggle dropdown
			DropFrame.InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					open = not open
					OptionsHolder.Visible = open
					
					if open then
						local height = #options * 22
						DropFrame.Size = UDim2.new(1, 0, 0, 30 + height)
					else
						DropFrame.Size = UDim2.new(1, 0, 0, 30)
					end
				end
			end)
			
			return DropFrame
		end
		
		return TabObj
	end
	
	return WindowObj
end

return Library
