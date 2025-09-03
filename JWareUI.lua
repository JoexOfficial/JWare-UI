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

local Theme = Themes.JWare

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
function Library:CreateWindow(Options)
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

		-- (rest of your Tab/Section/Button/Toggle/etc code goes here unchanged)
	end

	-- Tab Creation
	function Window:AddTab(Options)
		-- keep all your original tab/section/widget code
	end

	return Window
end

return Library
