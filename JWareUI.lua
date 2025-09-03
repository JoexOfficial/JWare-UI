--Services
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

--vars
local ViewPort = workspace.CurrentCamera.ViewportSize
local TweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut)

local Themes = {
	JWare  = { MainColor = Color3.fromRGB(70, 7, 100), OutlineColor = Color3.fromRGB(0, 0, 0), BackgroundColor = Color3.fromRGB(27, 27, 27), BackgroundColor2 = Color3.fromRGB(16, 16, 16) },
	JWare2 = { MainColor = Color3.fromRGB(135, 0, 2), OutlineColor = Color3.fromRGB(0, 0, 0), BackgroundColor = Color3.fromRGB(27, 27, 27), BackgroundColor2 = Color3.fromRGB(16, 16, 16) }
}

local Theme = Themes.JWare2

local Library = {}

function Library:Validate(Defaults, Options)
	for i,v in pairs(Defaults) do
		if Options[i] == nil then
			Options[i] = v
		end
	end
end

function Library:Tween(Object, Goal, Callback)
	local Tween = TweenService:Create(Object, TweenInfo, Goal)
	Tween.Completed:Connect(Callback or function() end)
	Tween:Play()
end

-- Main Window
function CreateWindow(Options)
	local Options = Options or {}
	Library:Validate({
		Title = "JWare UI [v1.0]",
		TextAlignment = "Center"
	}, Options or {})

	local Window = {
		CurrentTab = nil,
		Tabs = {}
	}

	---Main
	do
		Window["1"] = Instance.new("ScreenGui", RunService:IsStudio() and Players.LocalPlayer:WaitForChild("PlayerGui") or CoreGui);
		Window["1"].Name = "JWare UI";
		Window["1"].IgnoreGuiInset = true;

		Window["2"] = Instance.new("Frame", Window["1"]);
		Window["2"].BorderSizePixel = 0;
		Window["2"].BackgroundColor3 = Theme.BackgroundColor;
		Window["2"].AnchorPoint = Vector2.new(0, 0);
		Window["2"].Size = UDim2.new(0, 700, 0, 550);
		Window["2"].Position = UDim2.fromOffset((ViewPort.X/2) - (Window["2"].Size.X.Offset / 2), (ViewPort.Y/2) - (Window["2"].Size.Y.Offset / 2));
		Window["2"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Window["2"].Name = "MainFrame";

		Window["6"] = Instance.new("UIStroke", Window["2"]);
		Window["6"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		Window["6"].Thickness = 2;
		Window["6"].Color = Theme.MainColor;

		Window["3"] = Instance.new("Frame", Window["2"]);
		Window["3"].BorderSizePixel = 0;
		Window["3"].BackgroundColor3 = Theme.BackgroundColor;
		Window["3"].Size = UDim2.new(0, 700, 0, 30);
		Window["3"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Window["3"].Name = "TitleFrame";

		Window["4"] = Instance.new("TextLabel", Window["3"]);
		Window["4"].BorderSizePixel = 0;
		Window["4"].TextSize = 15;
		Window["4"].BackgroundColor3 = Theme.BackgroundColor;
		Window["4"].FontFace = Font.new([[rbxasset://fonts/families/DenkOne.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
		Window["4"].TextColor3 = Color3.fromRGB(255, 255, 255);
		Window["4"].BackgroundTransparency = 1;
		Window["4"].Size = UDim2.new(0, 680, 1, 0);
		Window["4"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Window["4"].Text = Options["Title"];
		Window["4"].TextXAlignment = Options["TextAlignment"]
		Window["4"].Name = "Title";
		Window["4"].Position = UDim2.new(0, 10, 0, 0);

		Window["7"] = Instance.new("Frame", Window["2"]);
		Window["7"].BorderSizePixel = 0;
		Window["7"].BackgroundColor3 = Theme.BackgroundColor2;
		Window["7"].Size = UDim2.new(0, 690, 0, 515);
		Window["7"].Position = UDim2.new(0, 5, 0, 30);
		Window["7"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Window["7"].Name = "ContentFrame";

		Window["8"] = Instance.new("UIStroke", Window["7"]);
		Window["8"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		Window["8"].Color = Theme.OutlineColor
		Window["8"].Thickness = 2;

		Window["9"] = Instance.new("Frame", Window["7"]);
		Window["9"].BorderSizePixel = 0;
		Window["9"].BackgroundColor3 = Theme.BackgroundColor2;
		Window["9"].Size = UDim2.new(1, 0, 0, 40);
		Window["9"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Window["9"].Name = "TabsFrame";

		Window["a"] = Instance.new("UIStroke", Window["9"]);
		Window["a"].ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
		Window["a"].Color = Theme.OutlineColor
		Window["a"].Thickness = 2;

		Window["b"] = Instance.new("Frame", Window["9"]);
		Window["b"].BorderSizePixel = 0;
		Window["b"].BackgroundColor3 = Color3.fromRGB(255, 255, 255);
		Window["b"].Size = UDim2.new(1, 0, 1, 0);
		Window["b"].BorderColor3 = Color3.fromRGB(0, 0, 0);
		Window["b"].Name = "ButtonHolder";
		Window["b"].BackgroundTransparency = 1;

		Window["10"] = Instance.new("UIListLayout", Window["b"]);
		Window["10"].Padding = UDim.new(0, 2);
		Window["10"].SortOrder = Enum.SortOrder.LayoutOrder;
		Window["10"].FillDirection = Enum.FillDirection.Horizontal;

		Window["c"] = Instance.new("UIPadding", Window["b"]);
		Window["c"].PaddingRight = UDim.new(0, 1);
		Window["c"].PaddingLeft = UDim.new(0, 1);

		-- Keybinds Window (always created but hidden)
		local KeybindFrame = Instance.new("Frame", Window["1"])
		KeybindFrame.Name = "KeybindFrame"
		KeybindFrame.Size = UDim2.new(0, 150, 0, 120)
		KeybindFrame.Position = UDim2.new(0, 5, 0, 500)
		KeybindFrame.BackgroundColor3 = Theme.BackgroundColor
		KeybindFrame.BorderSizePixel = 0
		KeybindFrame.Visible = false

		local Stroke = Instance.new("UIStroke", KeybindFrame)
		Stroke.Color = Theme.MainColor
		Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
		Stroke.Thickness = 2

		local Content = Instance.new("Frame", KeybindFrame)
		Content.Name = "ContentFrame"
		Content.Size = UDim2.new(1, -10, 1, -10)
		Content.Position = UDim2.new(0, 5, 0, 5)
		Content.BackgroundColor3 = Theme.BackgroundColor2
		Content.BorderSizePixel = 0

		local Layout = Instance.new("UIListLayout", Content)
		Layout.SortOrder = Enum.SortOrder.LayoutOrder
		Layout.Padding = UDim.new(0, 2)

		local Title = Instance.new("TextLabel", Content)
		Title.Text = "Keybinds"
		Title.Size = UDim2.new(1, 0, 0, 20)
		Title.BackgroundTransparency = 1
		Title.TextColor3 = Color3.fromRGB(200,200,200)
		Title.Font = Enum.Font.Gotham
		Title.TextSize = 14



		-- Draggable TitleFrame (smooth)
		do
			local dragging = false
			local dragStartPos = Vector2.zero
			local frameStartPos = Window["2"].Position
			local targetPos = Window["2"].Position -- initialize to current position
			local speed = 0.2 -- lerp speed

			Window["3"].InputBegan:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					dragging = true
					dragStartPos = input.Position
					frameStartPos = Window["2"].Position
					targetPos = frameStartPos
					input.Changed:Connect(function()
						if input.UserInputState == Enum.UserInputState.End then
							dragging = false
						end
					end)
				end
			end)

			Window["3"].InputChanged:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseMovement then
					local moveConn
					moveConn = UserInputService.InputChanged:Connect(function(moveInput)
						if dragging and moveInput.UserInputType == Enum.UserInputType.MouseMovement then
							local delta = moveInput.Position - dragStartPos
							targetPos = UDim2.new(
								0,
								frameStartPos.X.Offset + delta.X,
								0,
								frameStartPos.Y.Offset + delta.Y
							)
						end
					end)

					UserInputService.InputEnded:Connect(function(endInput)
						if endInput.UserInputType == Enum.UserInputType.MouseButton1 then
							dragging = false
							if moveConn then
								moveConn:Disconnect()
							end
						end
					end)
				end
			end)

			RunService.RenderStepped:Connect(function()
				Window["2"].Position = Window["2"].Position:Lerp(targetPos, speed)
			end)
		end

	end

	-- Tab Creation
	function Window:AddTab(Options)
		Options = Options or {}
		Library:Validate({
			Title = "Preview Tab",
			Icon = "rbxassetid://70562308088944"
		}, Options)

		local Tab = {
			Hover = false,
			Active = false
		}

		-- Tab Button
		do
			Tab["d"] = Instance.new("TextLabel", Window["b"]);
			Tab["d"].BorderSizePixel = 0;
			Tab["d"].TextSize = 14;
			Tab["d"].BackgroundColor3 = Theme.MainColor;
			Tab["d"].BackgroundTransparency = 1
			Tab["d"].FontFace = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
			Tab["d"].TextColor3 = Color3.fromRGB(160, 160, 160);
			Tab["d"].Size = UDim2.new(0, 100, 1, 0);
			Tab["d"].BorderColor3 = Color3.fromRGB(0, 0, 0);
			Tab["d"].Text = Options.Title;
			Tab["d"].Name = "Button"

			Tab["e"] = Instance.new("UIPadding", Tab["d"]);
			Tab["e"].PaddingLeft = UDim.new(0, 26);

			Tab["f"] = Instance.new("ImageLabel", Tab["d"]);
			Tab["f"].BorderSizePixel = 0;
			Tab["f"].BackgroundColor3 = Color3.fromRGB(0, 0, 0);
			Tab["f"].ImageColor3 = Color3.fromRGB(160, 160, 160);
			Tab["f"].Image = Options.Icon;
			Tab["f"].Size = UDim2.new(0, 20, 0, 20);
			Tab["f"].BorderColor3 = Color3.fromRGB(0, 0, 0);
			Tab["f"].BackgroundTransparency = 1;
			Tab["f"].Position = UDim2.new(0, -10, 0.25, 0);
		end

		-- Elements Container (unique per tab)
		do
			Tab.ElementsContainer = Instance.new("Frame", Window["7"]);
			Tab.ElementsContainer.BorderSizePixel = 0;
			Tab.ElementsContainer.BackgroundColor3 = Theme.BackgroundColor;
			Tab.ElementsContainer.Size = UDim2.new(0, 680, 0, 460);
			Tab.ElementsContainer.Position = UDim2.new(0, 5, 0, 50);
			Tab.ElementsContainer.BorderColor3 = Color3.fromRGB(0, 0, 0);
			Tab.ElementsContainer.Name = Options.Title .. "_Container";
			Tab.ElementsContainer.Visible = false;

			local stroke = Instance.new("UIStroke", Tab.ElementsContainer);
			stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
			stroke.Color = Theme.OutlineColor
			stroke.Thickness = 2
		end

		-- Methods
		function Tab:Activate()
			if not Tab.Active then
				if Window.CurrentTab ~= nil then
					Window.CurrentTab:Deactivate()
				end
				Tab.Active = true
				Library:Tween(Tab["d"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
				Library:Tween(Tab["f"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				Library:Tween(Tab["d"], {BackgroundTransparency = 0})
				Tab.ElementsContainer.Visible = true
				Window.CurrentTab = Tab
			end
		end

		function Tab:Deactivate()
			if Tab.Active then
				Tab.Active = false
				Tab.Hover = false
				Library:Tween(Tab["d"], {TextColor3 = Color3.fromRGB(160, 160, 160)})
				Library:Tween(Tab["f"], {ImageColor3 = Color3.fromRGB(160, 160, 160)})
				Library:Tween(Tab["d"], {BackgroundTransparency = 1})
				Tab.ElementsContainer.Visible = false
			end
		end

		-- Hover / Click Logic
		do
			Tab["d"].MouseEnter:Connect(function()
				Tab.Hover = true
				if not Tab.Active then
					Library:Tween(Tab["d"], {TextColor3 = Color3.fromRGB(255, 255, 255)})
					Library:Tween(Tab["f"], {ImageColor3 = Color3.fromRGB(255, 255, 255)})
				end
			end)

			Tab["d"].MouseLeave:Connect(function()
				Tab.Hover = false
				if not Tab.Active then
					Library:Tween(Tab["d"], {TextColor3 = Color3.fromRGB(160, 160, 160)})
					Library:Tween(Tab["f"], {ImageColor3 = Color3.fromRGB(160, 160, 160)})
				end
			end)

			UserInputService.InputBegan:Connect(function(input, gpe)
				if gpe then return end
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					if Tab.Hover then
						Tab:Activate()
					end
				end
			end)

			if Window.CurrentTab == nil then
				Tab:Activate()
			end
		end

		function Tab:AddSection(config)
			local Section = {}

			-- Default to LeftSection if type/position not provided
			config.Type = config.Type or "Left"

			Tab.SectionCount = Tab.SectionCount or {Left=0, Center=0, Right=0} -- track sections per column

			-- Horizontal position
			local posX = 5
			if config.Type == "Center" then
				posX = 231
			elseif config.Type == "Right" then
				posX = 457
			end

			-- Calculate vertical position based on previous sections in the same column
			local posY = 5
			for _, existingSection in ipairs(Tab.ElementsContainer:GetChildren()) do
				if existingSection:IsA("Frame") and existingSection.Position.X.Offset == posX then
					posY = posY + existingSection.Size.Y.Offset + 30 -- 5px spacing
				end
			end


			-- Create Section Frame
			local SectionFrame = Instance.new("Frame")
			SectionFrame.Name = config.Title or (config.Type .. "Section")
			SectionFrame.Parent = Tab.ElementsContainer
			SectionFrame.BackgroundColor3 = Theme.BackgroundColor2
			SectionFrame.BorderSizePixel = 0
			SectionFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
			SectionFrame.Position = UDim2.new(0, posX, 0, posY)
			SectionFrame.Size = UDim2.new(0, 218, 0, 450)


			local Stroke = Instance.new("UIStroke", SectionFrame);
			Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
			Stroke.Color = Theme.OutlineColor
			Stroke.Thickness = 2;

			-- Title Label
			local Title = Instance.new("TextLabel")
			Title.Name = "Title"
			Title.Parent = SectionFrame
			Title.ZIndex = 3
			Title.Text = config.Title or (config.Type .. "Section")
			Title.TextColor3 = Color3.fromRGB(255, 255, 255)
			Title.BackgroundTransparency = 1
			Title.BorderSizePixel = 0
			Title.Size = UDim2.new(1, 0, 0, 15)
			Title.Position = UDim2.new(0, 0, 0, 5)
			Title.FontFace = Font.new([[rbxasset://fonts/families/Ubuntu.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal)
			Title.TextSize = 14

			-- Fade Frame + Gradient
			local Fade = Instance.new("Frame")
			Fade.Name = "Fade"
			Fade.Parent = SectionFrame
			Fade.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			Fade.BorderSizePixel = 0
			Fade.Size = UDim2.new(1, 0, 0, 20)
			Fade.Position = UDim2.new(0, 0, 0, 0)

			local Gradient = Instance.new("UIGradient", Fade)
			Gradient.Rotation = 90
			Gradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0),
				NumberSequenceKeypoint.new(1, 0.5)
			}
			Gradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Theme.MainColor),
				ColorSequenceKeypoint.new(1, Theme.BackgroundColor2)
			}

			-- Elements Holder
			local ElementsHolder = Instance.new("Frame")
			ElementsHolder.Name = "ElementsHolder"
			ElementsHolder.Parent = SectionFrame
			ElementsHolder.BackgroundTransparency = 1
			ElementsHolder.BorderSizePixel = 0
			ElementsHolder.Position = UDim2.new(0, 0, 0, 30)
			ElementsHolder.Size = UDim2.new(0, 218, 0, 420)

			local Layout = Instance.new("UIListLayout")
			Layout.Parent = ElementsHolder
			Layout.SortOrder = Enum.SortOrder.LayoutOrder
			Layout.Padding = UDim.new(0, 4)

			-- Auto resize SectionFrame based on elements
			local function updateSectionHeight()
				SectionFrame.Size = UDim2.new(0, 218, 0, ElementsHolder.UIListLayout.AbsoluteContentSize.Y + 40) -- extra 5 added
			end

			Layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSectionHeight)
			updateSectionHeight()


			local Padding = Instance.new("UIPadding")
			Padding.Parent = ElementsHolder
			Padding.PaddingLeft = UDim.new(0, 5)

			-- Attach properties and methods
			Section.Frame = SectionFrame
			Section.ElementsHolder = ElementsHolder
			Section.Title = Title
			Section.Fade = Fade
			Section.Gradient = Gradient

			--Button
			function Section:AddButton(config)
				config = config or {}
				config.Title = config.Title or "Button"
				config.Callback = config.Callback or function() end

				local Button = Instance.new("TextLabel")
				Button.Name = config.Title
				Button.Parent = self.ElementsHolder
				Button.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				Button.BorderSizePixel = 0
				Button.Size = UDim2.new(0, 208, 0, 20)
				Button.Text = config.Title
				Button.TextSize = 14
				Button.TextColor3 = Color3.fromRGB(200, 200, 200) -- default text color
				Button.Font = Enum.Font.Gotham
				Button.BackgroundTransparency = 0
				Button.ClipsDescendants = true

				local Stroke = Instance.new("UIStroke")
				Stroke.Parent = Button
				Stroke.Color = Theme.OutlineColor
				Stroke.Thickness = 1;
				Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border

				-- Hover effect
				local hoverBG = Theme.MainColor
				local normalBG = Color3.fromRGB(26, 26, 26)
				local normalText = Color3.fromRGB(200, 200, 200)
				local hoverText = Color3.fromRGB(255, 255, 255)

				-- Hover effect (text only)
				local hovering = false -- track hover state

				local function onHover()
					hovering = true
					TweenService:Create(Button, TweenInfo, {
						TextColor3 = hoverText
					}):Play()
				end

				local function onLeave()
					hovering = false
					TweenService:Create(Button, TweenInfo, {
						TextColor3 = normalText
					}):Play()
				end

				Button.MouseEnter:Connect(onHover)
				Button.MouseLeave:Connect(onLeave)

				-- Click effect (background only)
				Button.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						-- briefly change background
						local clickTween = TweenService:Create(Button, TweenInfo, {
							BackgroundColor3 = hoverBG
						})
						clickTween:Play()

						-- return background to normal after half the tween time
						task.delay(TweenInfo.Time / 2, function()
							TweenService:Create(Button, TweenInfo, {
								BackgroundColor3 = normalBG
							}):Play()
						end)

						-- callback
						config.Callback()
					end
				end)


				return Button
			end



			--Toggle
			--Toggle
			function Section:AddToggle(config)
				config = config or {}
				config.Title = config.Title or "Toggle"
				config.Default = config.Default or false
				config.Callback = config.Callback or function(v) end

				local ToggleFrame = Instance.new("Frame")
				ToggleFrame.Name = config.Title
				ToggleFrame.Parent = self.ElementsHolder
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				ToggleFrame.BackgroundTransparency = 1
				ToggleFrame.BorderSizePixel = 0
				ToggleFrame.Size = UDim2.new(0, 208, 0, 20)

				-- Toggle Label
				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ToggleFrame
				TitleLabel.Text = config.Title
				TitleLabel.TextSize = 14
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Size = UDim2.new(0, 185, 1, 0)
				TitleLabel.Position = UDim2.new(0, 23, 0, 0)
				TitleLabel.Font = Enum.Font.Gotham
				TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200) -- normal text

				-- Toggle Check Box
				local ToggleCheck = Instance.new("Frame")
				ToggleCheck.Name = "ToggleCheck"
				ToggleCheck.Parent = ToggleFrame
				ToggleCheck.Size = UDim2.new(0, 15, 0, 15)
				ToggleCheck.Position = UDim2.new(0, 0, 0, 3)
				ToggleCheck.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				ToggleCheck.BorderSizePixel = 0

				local UICorner = Instance.new("UICorner", ToggleCheck)
				UICorner.CornerRadius = UDim.new(0, 2)

				local UIStroke = Instance.new("UIStroke", ToggleCheck)
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				UIStroke.Color = Theme.OutlineColor
				UIStroke.Thickness = 1;

				-- State
				local toggled = config.Default

				local function updateCheck(animated)
					local targetColor = toggled and Theme.MainColor or Color3.fromRGB(26, 26, 26)
					if animated then
						TweenService:Create(ToggleCheck, TweenInfo, {
							BackgroundColor3 = targetColor
						}):Play()
					else
						ToggleCheck.BackgroundColor3 = targetColor
					end
				end
				updateCheck(false)

				-- Click function
				local function toggle()
					toggled = not toggled
					updateCheck(true) -- fade effect
					config.Callback(toggled)
				end

				-- Hover effect (text only)
				TitleLabel.MouseEnter:Connect(function()
					TweenService:Create(TitleLabel, TweenInfo, {
						TextColor3 = Color3.fromRGB(255, 255, 255)
					}):Play()
				end)

				TitleLabel.MouseLeave:Connect(function()
					TweenService:Create(TitleLabel, TweenInfo, {
						TextColor3 = Color3.fromRGB(200, 200, 200)
					}):Play()
				end)

				-- Connections (toggle on click)
				TitleLabel.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						toggle()
					end
				end)

				ToggleCheck.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						toggle()
					end
				end)

				return {
					Frame = ToggleFrame,
					Check = ToggleCheck,
					GetState = function() return toggled end
				}
			end


			--Slider
			function Section:AddSlider(config)
				config = config or {}
				config.Title = config.Title or "Slider"
				config.Min = config.Min or 0
				config.Max = config.Max or 100
				config.Default = config.Default or config.Min
				config.Rounding = config.Rounding or 0
				config.Suffix = config.Suffix or ""
				config.Callback = config.Callback or function(v) end

				-- Main Slider Frame
				local SliderFrame = Instance.new("Frame")
				SliderFrame.Name = config.Title
				SliderFrame.Parent = self.ElementsHolder
				SliderFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				SliderFrame.BackgroundTransparency = 1
				SliderFrame.BorderSizePixel = 0
				SliderFrame.Size = UDim2.new(0, 208, 0, 40)

				-- Title
				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = SliderFrame
				TitleLabel.Text = config.Title
				TitleLabel.TextSize = 14
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Size = UDim2.new(0, 198, 0, 15)
				TitleLabel.Position = UDim2.new(0, 0, 0, 0)
				TitleLabel.Font = Enum.Font.Gotham
				TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

				-- Slider Back
				local SliderBack = Instance.new("Frame")
				SliderBack.Name = "SliderBack"
				SliderBack.Parent = SliderFrame
				SliderBack.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				SliderBack.BorderSizePixel = 0
				SliderBack.Size = UDim2.new(1, 0, 0, 15)
				SliderBack.Position = UDim2.new(0, 0, 0, 20)

				local Stroke = Instance.new("UIStroke", SliderBack)
				Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Stroke.Color = Theme.OutlineColor
				Stroke.Thickness = 1;

				-- Drag Frame
				local Drag = Instance.new("Frame")
				Drag.Name = "Drag"
				Drag.Parent = SliderBack
				Drag.BackgroundColor3 = Theme.MainColor
				Drag.BorderSizePixel = 0
				Drag.Size = UDim2.new(0, 0, 1, 0) -- will set width dynamically
				Drag.Position = UDim2.new(0, 0, 0, 0)

				-- Value Label
				local ValueLabel = Instance.new("TextLabel")
				ValueLabel.Name = "Value"
				ValueLabel.Parent = SliderFrame
				ValueLabel.TextSize = 14
				ValueLabel.BackgroundTransparency = 1
				ValueLabel.Size = UDim2.new(0, 50, 0, 15)
				ValueLabel.Position = UDim2.new(0, 170, 0, 0)
				ValueLabel.Font = Enum.Font.Gotham
				ValueLabel.TextColor3 = Color3.fromRGB(200, 200, 200)
				ValueLabel.Text = tostring(config.Default)..config.Suffix

				-- Functions
				local dragging = false

				local function updateValue(mouseX)
					local relX = math.clamp(mouseX - SliderBack.AbsolutePosition.X, 0, SliderBack.AbsoluteSize.X)
					local percent = relX / SliderBack.AbsoluteSize.X
					local value = config.Min + (config.Max - config.Min) * percent

					-- Rounding for display
					local displayValue = value
					if config.Rounding > 0 then
						displayValue = math.floor(value / config.Rounding + 0.5) * config.Rounding
					end

					-- Tween for smoothness
					Drag:TweenSize(UDim2.new(percent, 0, 1, 0), Enum.EasingDirection.InOut, Enum.EasingStyle.Quad, 0.03, true)

					ValueLabel.Text = tostring(math.floor(displayValue)) .. config.Suffix
					config.Callback(value)
				end

				-- Start dragging when mouse down on handle or bar
				local function beginDrag(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = true
						updateValue(input.Position.X)
					end
				end

				local function endDrag(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
					end
				end

				-- Connections
				Drag.InputBegan:Connect(beginDrag)
				SliderBack.InputBegan:Connect(beginDrag)
				Drag.InputEnded:Connect(endDrag)
				SliderBack.InputEnded:Connect(endDrag)

				UserInputService.InputChanged:Connect(function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						updateValue(input.Position.X)
					end
				end)

				-- Hover effect for Title + Value only
				SliderFrame.MouseEnter:Connect(function()
					TweenService:Create(TitleLabel, TweenInfo, { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
					TweenService:Create(ValueLabel, TweenInfo, { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
				end)

				SliderFrame.MouseLeave:Connect(function()
					TweenService:Create(TitleLabel, TweenInfo, { TextColor3 = Color3.fromRGB(200, 200, 200) }):Play()
					TweenService:Create(ValueLabel, TweenInfo, { TextColor3 = Color3.fromRGB(200, 200, 200) }):Play()
				end)

				-- Set initial value
				local initialPercent = (config.Default - config.Min) / (config.Max - config.Min)
				Drag.Size = UDim2.new(initialPercent, 0, 1, 0)
				ValueLabel.Text = tostring(config.Default)..config.Suffix

				return {
					Frame = SliderFrame,
					Drag = Drag,
					ValueLabel = ValueLabel,
					GetValue = function() return tonumber(ValueLabel.Text:match("%d+")) end
				}



			end

			function Section:AddLabel(config)
				config = config or {}
				config.Title = config.Title or "Label"
				config.TextAlignment = config.TextAlignment or "Left"

				-- Main Label Frame
				local LabelFrame = Instance.new("Frame")
				LabelFrame.Name = "Label"
				LabelFrame.Parent = self.ElementsHolder
				LabelFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				LabelFrame.BackgroundTransparency = 1
				LabelFrame.BorderSizePixel = 0
				LabelFrame.Size = UDim2.new(0, 208, 0, 15)

				-- Title TextLabel
				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = LabelFrame
				TitleLabel.Text = config.Title
				TitleLabel.TextSize = 14
				TitleLabel.TextXAlignment = config.TextAlignment
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Size = UDim2.new(1, 0, 1, 0)
				TitleLabel.Position = UDim2.new(0, 0, 0, 0)
				TitleLabel.Font = Enum.Font.Gotham
				TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

				return {
					Frame = LabelFrame,
					Label = TitleLabel
				}
			end

			function Section:AddColorPicker(config)
				config = config or {}
				config.Title = config.Title or "Color"
				config.Default = config.Default or Color3.fromRGB(255, 255, 255)
				config.Callback = config.Callback or function(v) end

				local ColorPickerFrame = Instance.new("Frame")
				ColorPickerFrame.Name = "ColorPicker"
				ColorPickerFrame.Parent = self.ElementsHolder
				ColorPickerFrame.BackgroundColor3 = Color3.fromRGB(26, 26, 26)
				ColorPickerFrame.BackgroundTransparency = 1
				ColorPickerFrame.BorderSizePixel = 0
				ColorPickerFrame.Size = UDim2.new(0, 208, 0, 15)

				local TitleLabel = Instance.new("TextLabel")
				TitleLabel.Name = "Title"
				TitleLabel.Parent = ColorPickerFrame
				TitleLabel.Text = config.Title..":"
				TitleLabel.TextSize = 14
				TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
				TitleLabel.BackgroundTransparency = 1
				TitleLabel.Size = UDim2.new(1, 0, 1, 0)
				TitleLabel.Font = Enum.Font.Gotham
				TitleLabel.TextColor3 = Color3.fromRGB(200, 200, 200)

				local ColorFrame = Instance.new("Frame")
				ColorFrame.Name = "Color"
				ColorFrame.Parent = ColorPickerFrame
				ColorFrame.BackgroundColor3 = config.Default
				ColorFrame.BorderSizePixel = 0
				ColorFrame.Size = UDim2.new(0, 30, 0, 15)
				ColorFrame.Position = UDim2.new(0, 177, 0, 0)

				local Stroke = Instance.new("UIStroke", ColorFrame)
				Stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				Stroke.Color = Theme.OutlineColor
				Stroke.Thickness = 1;

				local UIFrame = Instance.new("Frame")
				UIFrame.Name = "UI"
				UIFrame.Parent = ColorFrame
				UIFrame.Visible = false
				UIFrame.BackgroundColor3 = Color3.fromRGB(16,16,16)
				UIFrame.BorderSizePixel = 0
				UIFrame.Size = UDim2.new(0, 150, 0, 150)
				UIFrame.Position = UDim2.new(0, 35, 0, 0)
				UIFrame.ZIndex = 50

				local UIStroke = Instance.new("UIStroke", UIFrame)
				UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				UIStroke.Thickness = 2
				UIStroke.Color = config.Default

				local Picker = Instance.new("Frame")
				Picker.Name = "Picker"
				Picker.Parent = UIFrame
				Picker.BorderSizePixel = 0
				Picker.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Picker.Size = UDim2.new(0, 5, 0, 5)
				Picker.ZIndex = 52

				local PickerStroke = Instance.new("UIStroke", Picker)
				PickerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				PickerStroke.Color = Theme.OutlineColor
				PickerStroke.Thickness = 1;

				local GradientFrame = Instance.new("Frame")
				GradientFrame.Name = "PickerGradient"
				GradientFrame.Parent = UIFrame
				GradientFrame.BorderSizePixel = 0
				GradientFrame.BackgroundColor3 = Color3.fromRGB(255,255,255)
				GradientFrame.Position = UDim2.new(0, 5, 0, 5)
				GradientFrame.Size = UDim2.new(0, 140, 0, 95)
				GradientFrame.ZIndex = 51

				local GradientStroke = Instance.new("UIStroke", GradientFrame)
				GradientStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				GradientStroke.Color = Theme.OutlineColor
				GradientStroke.Thickness = 1;

				local Gradient = Instance.new("UIGradient", GradientFrame)
				Gradient.Rotation = 0
				Gradient.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0.000, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.150, Color3.fromRGB(255, 0, 0)),
					ColorSequenceKeypoint.new(0.333, Color3.fromRGB(236, 255, 16)),
					ColorSequenceKeypoint.new(0.500, Color3.fromRGB(0, 255, 9)),
					ColorSequenceKeypoint.new(0.667, Color3.fromRGB(0, 255, 248)),
					ColorSequenceKeypoint.new(0.833, Color3.fromRGB(0, 0, 255)),
					ColorSequenceKeypoint.new(1.000, Color3.fromRGB(239, 0, 255))
				}

				local Darkness = Instance.new("Frame")
				Darkness.Name = "Darkness"
				Darkness.Parent = UIFrame
				Darkness.BorderSizePixel = 0
				Darkness.BackgroundColor3 = Color3.fromRGB(255,255,255)
				Darkness.Position = UDim2.new(0,5,0,105)
				Darkness.Size = UDim2.new(0,140,0,15)
				Darkness.ZIndex = 51

				local DarknessStroke = Instance.new("UIStroke", Darkness)
				DarknessStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				DarknessStroke.Color = Theme.OutlineColor
				DarknessStroke.Thickness = 1;

				local DarknessGradient = Instance.new("UIGradient", Darkness)
				DarknessGradient.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255,255,255)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0,0,0))
				}

				local DarknessPointer = Instance.new("Frame")
				DarknessPointer.Name = "DarknessPointer"
				DarknessPointer.Parent = Darkness
				DarknessPointer.BorderSizePixel = 0
				DarknessPointer.BackgroundColor3 = Color3.fromRGB(255,255,255)
				DarknessPointer.Size = UDim2.new(0, 6, 1, 0)

				local DarknessPointerStroke = Instance.new("UIStroke", DarknessPointer)
				DarknessPointerStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				DarknessPointerStroke.Color = Theme.OutlineColor
				DarknessPointerStroke.Thickness = 1;

				local ApplyButton = Instance.new("Frame")
				ApplyButton.Name = "Button"
				ApplyButton.Parent = UIFrame
				ApplyButton.BorderSizePixel = 0
				ApplyButton.BackgroundColor3 = Color3.fromRGB(26,26,26)
				ApplyButton.Position = UDim2.new(0,5,0,125)
				ApplyButton.Size = UDim2.new(0,140,0,20)
				ApplyButton.ZIndex = 51
				local ButtonStroke = Instance.new("UIStroke", ApplyButton)
				ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border;
				ButtonStroke.Color = Theme.OutlineColor
				ButtonStroke.Thickness = 1;
				local ButtonLabel = Instance.new("TextLabel")
				ButtonLabel.Name = "Title"
				ButtonLabel.Parent = ApplyButton
				ButtonLabel.Text = "Close"
				ButtonLabel.BackgroundTransparency = 1
				ButtonLabel.Size = UDim2.new(1,0,1,0)
				ButtonLabel.Font = Enum.Font.Gotham
				ButtonLabel.TextSize = 14
				ButtonLabel.TextColor3 = Color3.fromRGB(255,255,255)
				ButtonLabel.ZIndex = 52

				-- Gradient keypoints
				local KEYPOINTS = {
					{t = 0.000, c = Color3.fromRGB(255, 255, 255)},
					{t = 0.150, c = Color3.fromRGB(255, 0, 0)},
					{t = 0.333, c = Color3.fromRGB(236, 255, 16)},
					{t = 0.500, c = Color3.fromRGB(0, 255, 9)},
					{t = 0.667, c = Color3.fromRGB(0, 255, 248)},
					{t = 0.833, c = Color3.fromRGB(0, 0, 255)},
					{t = 1.000, c = Color3.fromRGB(239, 0, 255)},
				}

				local function lerp(a,b,t) return a + (b-a)*t end
				local function lerpColor(c1,c2,t)
					return Color3.new(lerp(c1.R,c2.R,t), lerp(c1.G,c2.G,t), lerp(c1.B,c2.B,t))
				end

				local function sampleGradient(t)
					t = math.clamp(t,0,1)
					for i=1,#KEYPOINTS-1 do
						local a,b = KEYPOINTS[i], KEYPOINTS[i+1]
						if t>=a.t and t<=b.t then
							local localT = (t-a.t)/(b.t-a.t)
							return lerpColor(a.c,b.c,localT)
						end
					end
					return KEYPOINTS[#KEYPOINTS].c
				end

				local dragging = false
				local draggingDarkness = false
				local baseColor = config.Default
				local selectedColor = config.Default
				local darknessValue = 1 -- lightest

				local function applyBrightness(c)
					local h,s,v = Color3.toHSV(c)
					return Color3.fromHSV(h,s,darknessValue)
				end

				local function updateColor(px)
					local t = math.clamp(px/GradientFrame.AbsoluteSize.X,0,1)
					baseColor = sampleGradient(t)
					selectedColor = applyBrightness(baseColor)
					ColorFrame.BackgroundColor3 = selectedColor
					UIStroke.Color = selectedColor
				end

				local function dragPicker(input)
					local mouse = input.Position
					local px = math.clamp(mouse.X - GradientFrame.AbsolutePosition.X,0,GradientFrame.AbsoluteSize.X)
					local py = math.clamp(mouse.Y - GradientFrame.AbsolutePosition.Y,0,GradientFrame.AbsoluteSize.Y)
					Picker.Position = UDim2.new(0, px - Picker.AbsoluteSize.X/2, 0, py - Picker.AbsoluteSize.Y/2)
					updateColor(px)
					config.Callback(selectedColor)

				end

				local function updateDarkness(input)
					local mouse = input.Position
					local px = math.clamp(mouse.X - Darkness.AbsolutePosition.X,0,Darkness.AbsoluteSize.X)
					DarknessPointer.Position = UDim2.new(0, px - DarknessPointer.AbsoluteSize.X/2, 0, 0)
					darknessValue = 1 - (px / Darkness.AbsoluteSize.X)
					selectedColor = applyBrightness(baseColor)
					ColorFrame.BackgroundColor3 = selectedColor
					UIStroke.Color = selectedColor
					config.Callback(selectedColor) -- pass Color3 directly
				end

				GradientFrame.InputBegan:Connect(function(input)
					if input.UserInputType==Enum.UserInputType.MouseButton1 then
						dragging=true; dragPicker(input)
					end
				end)
				GradientFrame.InputEnded:Connect(function(input)
					if input.UserInputType==Enum.UserInputType.MouseButton1 then
						dragging=false
					end
				end)

				Darkness.InputBegan:Connect(function(input)
					if input.UserInputType==Enum.UserInputType.MouseButton1 then
						draggingDarkness=true; updateDarkness(input)
					end
				end)
				Darkness.InputEnded:Connect(function(input)
					if input.UserInputType==Enum.UserInputType.MouseButton1 then
						draggingDarkness=false
					end
				end)

				UserInputService.InputChanged:Connect(function(input)
					if input.UserInputType==Enum.UserInputType.MouseMovement then
						if dragging then dragPicker(input)
						elseif draggingDarkness then updateDarkness(input)
						end
					end
				end)

				ColorFrame.InputBegan:Connect(function(input)
					if input.UserInputType==Enum.UserInputType.MouseButton1 then
						UIFrame.Visible = not UIFrame.Visible
					end
				end)

				ApplyButton.InputBegan:Connect(function(input)
					if input.UserInputType==Enum.UserInputType.MouseButton1 then
						UIFrame.Visible=false
					end
				end)

				-- Hover effect for Title only
				ColorPickerFrame.MouseEnter:Connect(function()
					TweenService:Create(TitleLabel, TweenInfo, { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
				end)
				ColorPickerFrame.MouseLeave:Connect(function()
					TweenService:Create(TitleLabel, TweenInfo, { TextColor3 = Color3.fromRGB(200, 200, 200) }):Play()
				end)

				-- Initialize picker to Default by **finding nearest gradient t**
				do
					local bestT = 0
					local minDist = math.huge
					for t=0,1,0.001 do
						local c = sampleGradient(t)
						local dr = c.R - config.Default.R
						local dg = c.G - config.Default.G
						local db = c.B - config.Default.B
						local dist = dr*dr + dg*dg + db*db
						if dist < minDist then
							minDist = dist
							bestT = t
						end
					end
					local px = bestT*GradientFrame.Size.X.Offset
					local py = GradientFrame.Size.Y.Offset*0.5
					Picker.Position = UDim2.new(0, px-Picker.AbsoluteSize.X/2, 0, py-Picker.AbsoluteSize.Y/2)
					baseColor = sampleGradient(bestT)
					darknessValue = 1
					DarknessPointer.Position = UDim2.new(0, (1-darknessValue)*Darkness.Size.X.Offset - DarknessPointer.AbsoluteSize.X/2, 0, 0)
					selectedColor = applyBrightness(baseColor)
					ColorFrame.BackgroundColor3 = selectedColor
					UIStroke.Color = selectedColor
				end

				return {
					Frame = ColorPickerFrame,
					ColorFrame = ColorFrame,
					UIFrame = UIFrame,
					GetColor = function()
						return selectedColor  -- returns Color3
					end,
					SetColor = function(c)
						-- Set color programmatically
						local bestT = 0
						local minDist = math.huge
						for t=0,1,0.001 do
							local col = sampleGradient(t)
							local dr = col.R - c.R
							local dg = col.G - c.G
							local db = col.B - c.B
							local dist = dr*dr + dg*dg + db*db
							if dist < minDist then
								minDist = dist
								bestT = t
							end
						end
						local px = bestT*GradientFrame.Size.X.Offset
						local py = GradientFrame.Size.Y.Offset*0.5
						Picker.Position = UDim2.new(0, px-Picker.AbsoluteSize.X/2, 0, py-Picker.AbsoluteSize.Y/2)
						baseColor = sampleGradient(bestT)
						darknessValue = 1
						DarknessPointer.Position = UDim2.new(0, (1-darknessValue)*Darkness.Size.X.Offset - DarknessPointer.AbsoluteSize.X/2, 0, 0)
						selectedColor = applyBrightness(baseColor)
						ColorFrame.BackgroundColor3 = selectedColor
						UIStroke.Color = selectedColor
						config.Callback(selectedColor)
					end
				}

			end

			function Section:AddKeyPicker(config)
				config = config or {}
				config.Title = config.Title or "Keybind"
				config.Default = config.Default or "None"
				config.Mode = config.Mode or "Toggle" -- Toggle or Hold
				config.Callback = config.Callback or function() end

				local UIS = game:GetService("UserInputService")

				local Holder = Instance.new("Frame", self.ElementsHolder)
				Holder.Size = UDim2.new(0, 208, 0, 20)
				Holder.BackgroundTransparency = 1

				local Title = Instance.new("TextLabel", Holder)
				Title.Size = UDim2.new(1, -40, 1, 0)
				Title.BackgroundTransparency = 1
				Title.TextXAlignment = Enum.TextXAlignment.Left
				Title.Font = Enum.Font.Gotham
				Title.TextSize = 14
				Title.TextColor3 = Color3.fromRGB(200, 200, 200)
				Title.Text = config.Title

				local KeyLabel = Instance.new("TextLabel", Holder)
				KeyLabel.Size = UDim2.new(0, 30, 0, 15)
				KeyLabel.Position = UDim2.new(0, 177, 0, 0)
				KeyLabel.BackgroundTransparency = 1
				KeyLabel.Font = Enum.Font.GothamBold
				KeyLabel.TextSize = 12
				KeyLabel.TextColor3 = Color3.fromRGB(150, 150, 150)
				KeyLabel.Text = config.Default
				KeyLabel.TextXAlignment = Enum.TextXAlignment.Center

				-- Hover effect for Title only
				Title.MouseEnter:Connect(function()
					TweenService:Create(Title, TweenInfo, { TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
				end)
				Title.MouseLeave:Connect(function()
					TweenService:Create(Title, TweenInfo, { TextColor3 = Color3.fromRGB(200, 200, 200) }):Play()
				end)


				local hovered = false
				local listening = false
				local currentKey = config.Default
				local toggleState = false

				KeyLabel.MouseEnter:Connect(function() hovered = true end)
				KeyLabel.MouseLeave:Connect(function() hovered = false end)

				-- Handle listening for rebind
				UIS.InputBegan:Connect(function(input, gameProcessed)
					if gameProcessed then return end

					if hovered and input.UserInputType == Enum.UserInputType.MouseButton1 and not listening then
						listening = true
						KeyLabel.Text = "..."

						task.defer(function()
							local conn
							conn = UIS.InputBegan:Connect(function(in2, gp2)
								if gp2 then return end

								local keyName
								if in2.UserInputType == Enum.UserInputType.Keyboard then
									keyName = in2.KeyCode.Name
								elseif in2.UserInputType == Enum.UserInputType.MouseButton1 then
									keyName = "MB1"
								elseif in2.UserInputType == Enum.UserInputType.MouseButton2 then
									keyName = "MB2"
								elseif in2.UserInputType == Enum.UserInputType.MouseButton3 then
									keyName = "MB3"
								end

								if keyName then
									listening = false
									KeyLabel.Text = keyName

									if keyName ~= currentKey then
										currentKey = keyName
										config.Callback("Changed", { Key = keyName, Mode = config.Mode })
									end

									conn:Disconnect()
								end
							end)
						end)
					end

					-- Key was pressed: handle "Pressed" and "Toggle"
					local function keyMatches()
						if input.UserInputType == Enum.UserInputType.Keyboard then
							return input.KeyCode.Name == currentKey
						elseif input.UserInputType.Name:match("MouseButton") and currentKey:match("MB") then
							local mb = "MB" .. tostring(input.UserInputType.Value - Enum.UserInputType.MouseButton1.Value + 1)
							return mb == currentKey
						end
						return false
					end

					if keyMatches() then
						if config.Mode == "Toggle" then
							toggleState = not toggleState
							config.Callback("Pressed", { Key = currentKey, Mode = config.Mode, State = toggleState })
						elseif config.Mode == "Hold" then
							config.Callback("Pressed", { Key = currentKey, Mode = config.Mode, State = true })
						end
					end
				end)

				-- For hold mode: detect when key is released
				UIS.InputEnded:Connect(function(input, gameProcessed)
					if config.Mode == "Hold" then
						if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode.Name == currentKey then
							config.Callback("Pressed", { Key = currentKey, Mode = config.Mode, State = false })
						elseif input.UserInputType.Name:match("MouseButton") and currentKey:match("MB") then
							local mb = "MB" .. tostring(input.UserInputType.Value - Enum.UserInputType.MouseButton1.Value + 1)
							if mb == currentKey then
								config.Callback("Pressed", { Key = currentKey, Mode = config.Mode, State = false })
							end
						end
					end
				end)

				return {
					GetKey = function() return currentKey end,
					SetKey = function(v)
						if v ~= currentKey then
							currentKey = v
							KeyLabel.Text = v
							config.Callback("Changed", { Key = v, Mode = config.Mode })
						end
					end,
					GetMode = function() return config.Mode end,
					SetMode = function(v) config.Mode = v end,
				}
			end




			return Section
		end

		table.insert(Window.Tabs, Tab)
		return Tab
	end

	return Window
end
