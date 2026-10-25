--[[]]
    SILVER PANEL | Roblox LocalScript
    Установи этот LocalScript в StarterPlayer > StarterPlayerScripts.
    Кнопка открывает и закрывает окно; окно можно перетаскивать мышью или касанием.
]]

local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Удаляем предыдущую копию интерфейса при повторном запуске скрипта.
local previous = playerGui:FindFirstChild("SilverPanelGui")
if previous then
    previous:Destroy()
end

local gui = Instance.new("ScreenGui")
gui.Name = "SilverPanelGui"
gui.ResetOnSpawn = false
gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
gui.Parent = playerGui

local function addCorner(instance, radius)
    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, radius)
    corner.Parent = instance
    return corner
end

local function addStroke(instance, color, thickness, transparency)
    local stroke = Instance.new("UIStroke")
    stroke.Color = color
    stroke.Thickness = thickness
    stroke.Transparency = transparency or 0
    stroke.Parent = instance
    return stroke
end

-- Круглая кнопка в левом верхнем углу.
local toggleButton = Instance.new("TextButton")
toggleButton.Name = "ToggleButton"
toggleButton.Size = UDim2.fromOffset(142, 46)
toggleButton.Position = UDim2.new(0, 24, 0, 24)
toggleButton.BackgroundColor3 = Color3.fromRGB(18, 19, 22)
toggleButton.Text = "SILVER  ✦"
toggleButton.TextColor3 = Color3.fromRGB(245, 247, 250)
toggleButton.TextSize = 15
toggleButton.Font = Enum.Font.GothamBold
toggleButton.AutoButtonColor = false
toggleButton.Parent = gui
addCorner(toggleButton, 14)
local buttonStroke = addStroke(toggleButton, Color3.fromRGB(205, 215, 228), 1.5, 0.12)

local buttonGradient = Instance.new("UIGradient")
buttonGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(78, 83, 92)),
    ColorSequenceKeypoint.new(0.48, Color3.fromRGB(25, 27, 31)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(9, 10, 12)),
})
buttonGradient.Rotation = 35
buttonGradient.Parent = toggleButton

-- Основное окно.
local panel = Instance.new("Frame")
panel.Name = "SilverWindow"
panel.Size = UDim2.fromOffset(360, 250)
panel.Position = UDim2.new(0.5, -180, 0.5, -125)
panel.BackgroundColor3 = Color3.fromRGB(17, 19, 23)
panel.Visible = false
panel.Active = true
panel.Parent = gui
addCorner(panel, 16)
addStroke(panel, Color3.fromRGB(185, 198, 215), 1.5, 0.15)

local panelGradient = Instance.new("UIGradient")
panelGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(49, 53, 61)),
    ColorSequenceKeypoint.new(0.35, Color3.fromRGB(24, 26, 31)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(12, 13, 16)),
})
panelGradient.Rotation = 90
panelGradient.Parent = panel

-- Верхняя полоска служит областью захвата для перетаскивания.
local titleBar = Instance.new("Frame")
titleBar.Name = "TitleBar"
titleBar.Size = UDim2.new(1, 0, 0, 54)
titleBar.BackgroundColor3 = Color3.fromRGB(40, 44, 52)
titleBar.BackgroundTransparency = 0.2
titleBar.Active = true
titleBar.Parent = panel
addCorner(titleBar, 16)

local title = Instance.new("TextLabel")
title.Name = "Title"
title.Size = UDim2.new(1, -72, 1, 0)
title.Position = UDim2.fromOffset(18, 0)
title.BackgroundTransparency = 1
title.Text = "SILVER PANEL"
title.TextColor3 = Color3.fromRGB(240, 243, 248)
title.TextSize = 16
title.Font = Enum.Font.GothamBold
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = titleBar

local closeButton = Instance.new("TextButton")
closeButton.Name = "CloseButton"
closeButton.Size = UDim2.fromOffset(34, 34)
closeButton.Position = UDim2.new(1, -44, 0, 10)
closeButton.BackgroundColor3 = Color3.fromRGB(15, 16, 19)
closeButton.Text = "×"
closeButton.TextColor3 = Color3.fromRGB(226, 231, 238)
closeButton.TextSize = 24
closeButton.Font = Enum.Font.Gotham
closeButton.AutoButtonColor = true
closeButton.Parent = titleBar
addCorner(closeButton, 10)
addStroke(closeButton, Color3.fromRGB(155, 168, 185), 1, 0.35)

local accent = Instance.new("Frame")
accent.Name = "SilverAccent"
accent.Size = UDim2.new(1, -36, 0, 2)
accent.Position = UDim2.new(0, 18, 0, 62)
accent.BackgroundColor3 = Color3.fromRGB(190, 204, 222)
accent.BorderSizePixel = 0
accent.Parent = panel

local accentGradient = Instance.new("UIGradient")
accentGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, Color3.fromRGB(75, 82, 95)),
    ColorSequenceKeypoint.new(0.5, Color3.fromRGB(235, 240, 248)),
    ColorSequenceKeypoint.new(1, Color3.fromRGB(75, 82, 95)),
})
accentGradient.Parent = accent

local message = Instance.new("TextLabel")
message.Name = "Message"
message.Size = UDim2.new(1, -40, 0, 90)
message.Position = UDim2.fromOffset(20, 88)
message.BackgroundTransparency = 1
message.Text = "Привет! Это твоё серебряное окно.\nПеретаскивай его за верхнюю панель."
message.TextColor3 = Color3.fromRGB(210, 216, 226)
message.TextSize = 15
message.Font = Enum.Font.Gotham
message.TextWrapped = true
message.Parent = panel

local hint = Instance.new("TextLabel")
hint.Name = "Hint"
hint.Size = UDim2.new(1, -40, 0, 24)
hint.Position = UDim2.new(0, 20, 1, -38)
hint.BackgroundTransparency = 1
hint.Text = "DRAG TO MOVE  •  CLICK × TO CLOSE"
hint.TextColor3 = Color3.fromRGB(130, 141, 157)
hint.TextSize = 10
hint.Font = Enum.Font.GothamMedium
hint.Parent = panel

-- Открытие и закрытие окна.
toggleButton.Activated:Connect(function()
    panel.Visible = not panel.Visible
end)

closeButton.Activated:Connect(function()
    panel.Visible = false
end)

-- Перетаскивание окна мышью и сенсорным экраном.
local dragging = false
local dragInput
local dragStart
local startPosition

local function updateDrag(input)
    local delta = input.Position - dragStart
    panel.Position = UDim2.new(
        startPosition.X.Scale,
        startPosition.X.Offset + delta.X,
        startPosition.Y.Scale,
        startPosition.Y.Offset + delta.Y
    )
end

titleBar.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPosition = panel.Position
        dragInput = input
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement
        or input.UserInputType == Enum.UserInputType.Touch) then
        updateDrag(input)
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input == dragInput
        or input.UserInputType == Enum.UserInputType.MouseButton1
        or input.UserInputType == Enum.UserInputType.Touch then
        dragging = false
        dragInput = nil
    end
end)

-- Небольшая подсветка кнопки при наведении.
toggleButton.MouseEnter:Connect(function()
    buttonStroke.Transparency = 0
    toggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
end)

toggleButton.MouseLeave:Connect(function()
    buttonStroke.Transparency = 0.12
    toggleButton.TextColor3 = Color3.fromRGB(245, 247, 250)
end)
