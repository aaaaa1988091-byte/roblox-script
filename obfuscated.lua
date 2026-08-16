-- ==========================================
-- 黑橘科技風 Hub UI (已移除調色盤)
-- ==========================================

local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")
local Players = game:GetService("Players")

local parentContainer = (gethui and gethui()) or (syn and syn.protect_gui and CoreGui) or Players.LocalPlayer:WaitForChild("PlayerGui")

if parentContainer:FindFirstChild("OrangeHubUI") then
    parentContainer.OrangeHubUI:Destroy()
end

local Hub = {}
Hub.__index = Hub

local CORNER_RADIUS = UDim.new(0, 8)

local STYLE = {
    BgColor = Color3.fromRGB(15, 15, 18),
    SidebarColor = Color3.fromRGB(22, 22, 26),
    CardColor = Color3.fromRGB(30, 30, 36),
    CardHover = Color3.fromRGB(40, 40, 50),
    AccentColor = Color3.fromRGB(255, 120, 0),
    AccentDark = Color3.fromRGB(180, 80, 0),
    TextColor = Color3.fromRGB(245, 245, 250),
    SubTextColor = Color3.fromRGB(140, 140, 155),
    ToggleOff = Color3.fromRGB(45, 45, 52)
}

function Hub.new(hubName, iconId)
    local self = setmetatable({}, Hub)
    self.IsMinimized = false
    self.IsVisible = true
    self.IconAsset = "rbxassetid://" .. tostring(iconId or 86234166703463)
    
    local gui = Instance.new("ScreenGui")
    gui.Name = "OrangeHubUI"
    gui.ResetOnSpawn = false
    gui.Parent = parentContainer
    
    local main = Instance.new("Frame")
    main.Name = "MainFrame"
    main.Size = UDim2.new(0, 520, 0, 360)
    main.Position = UDim2.new(0.5, -260, 0.5, -140)
    main.BackgroundColor3 = STYLE.BgColor
    main.BackgroundTransparency = 1
    main.BorderSizePixel = 0
    main.ClipsDescendants = true
    main.Visible = true
    main.Parent = gui
    
    local mainCorner = Instance.new("UICorner", main)
    mainCorner.CornerRadius = CORNER_RADIUS
    
    local mainStroke = Instance.new("UIStroke")
    mainStroke.Color = STYLE.AccentColor
    mainStroke.Thickness = 1.5
    mainStroke.Transparency = 1
    mainStroke.Parent = main

    local bgImage = Instance.new("ImageLabel")
    bgImage.Name = "BgImage"
    bgImage.Size = UDim2.new(1, 0, 1, 0)
    bgImage.Image = self.IconAsset
    bgImage.ScaleType = Enum.ScaleType.Crop
    bgImage.BackgroundTransparency = 1
    bgImage.ImageTransparency = 1
    bgImage.ZIndex = 1
    bgImage.Parent = main

    local introContainer = Instance.new("Frame")
    introContainer.Size = UDim2.new(1, 0, 1, 0)
    introContainer.BackgroundTransparency = 1
    introContainer.ZIndex = 20
    introContainer.Parent = main

    local introIcon = Instance.new("ImageLabel")
    introIcon.Size = UDim2.new(0, 50, 0, 50)
    introIcon.Position = UDim2.new(0.5, -25, 0.38, -25)
    introIcon.BackgroundTransparency = 1
    introIcon.Image = self.IconAsset
    introIcon.ImageTransparency = 1
    introIcon.ZIndex = 21
    introIcon.Parent = introContainer

    local introTitle = Instance.new("TextLabel")
    introTitle.Size = UDim2.new(1, 0, 0, 25)
    introTitle.Position = UDim2.new(0, 0, 0.58, 0)
    introTitle.BackgroundTransparency = 1
    introTitle.Font = Enum.Font.GothamBold
    introTitle.TextSize = 15
    introTitle.TextColor3 = STYLE.TextColor
    introTitle.Text = hubName or "HUB"
    introTitle.TextTransparency = 1
    introTitle.ZIndex = 21
    introTitle.Parent = introContainer

    local introStatus = Instance.new("TextLabel")
    introStatus.Size = UDim2.new(1, 0, 0, 20)
    introStatus.Position = UDim2.new(0, 0, 0.66, 0)
    introStatus.BackgroundTransparency = 1
    introStatus.Font = Enum.Font.GothamMedium
    introStatus.TextSize = 11
    introStatus.TextColor3 = STYLE.SubTextColor
    introStatus.Text = "INITIALIZING..."
    introStatus.TextTransparency = 1
    introStatus.ZIndex = 21
    introStatus.Parent = introContainer

    local loadBarBg = Instance.new("Frame")
    loadBarBg.Size = UDim2.new(0, 180, 0, 3)
    loadBarBg.Position = UDim2.new(0.5, -90, 0.76, 0)
    loadBarBg.BackgroundColor3 = STYLE.SidebarColor
    loadBarBg.BackgroundTransparency = 1
    loadBarBg.BorderSizePixel = 0
    loadBarBg.ZIndex = 21
    loadBarBg.Parent = introContainer
    Instance.new("UICorner", loadBarBg).CornerRadius = UDim.new(1, 0)

    local loadBarFill = Instance.new("Frame")
    loadBarFill.Size = UDim2.new(0, 0, 1, 0)
    loadBarFill.BackgroundColor3 = STYLE.AccentColor
    loadBarFill.BorderSizePixel = 0
    loadBarFill.ZIndex = 22
    loadBarFill.Parent = loadBarBg
    Instance.new("UICorner", loadBarFill).CornerRadius = UDim.new(1, 0)

    local particleContainer = Instance.new("Frame")
    particleContainer.Size = UDim2.new(1, 0, 1, 0)
    particleContainer.BackgroundTransparency = 1
    particleContainer.ClipsDescendants = true
    particleContainer.ZIndex = 2
    particleContainer.Parent = main

    task.spawn(function()
        while main and main.Parent do
            task.wait(math.random(3, 8) / 10)
            if not main.Visible or self.IsMinimized then continue end

            local particle = Instance.new("Frame")
            local size = math.random(3, 6)
            particle.Size = UDim2.new(0, size, 0, size)
            particle.Position = UDim2.new(math.random(5, 95) / 100, 0, 1, 0)
            particle.BackgroundColor3 = STYLE.AccentColor
            particle.BackgroundTransparency = math.random(3, 6) / 10
            particle.BorderSizePixel = 0
            particle.ZIndex = 2
            particle.Parent = particleContainer

            Instance.new("UICorner", particle).CornerRadius = UDim.new(1, 0)

            local floatTime = math.random(25, 45) / 10
            local targetY = UDim2.new(particle.Position.X.Scale, math.random(-20, 20), -0.1, 0)

            TweenService:Create(particle, TweenInfo.new(floatTime, Enum.EasingStyle.Linear), {
                Position = targetY,
                BackgroundTransparency = 1
            }):Play()

            game:GetService("Debris"):AddItem(particle, floatTime)
        end
    end)

    local miniIcon = Instance.new("ImageButton")
    miniIcon.Size = UDim2.new(1, 0, 1, 0)
    miniIcon.BackgroundTransparency = 1
    miniIcon.Image = self.IconAsset
    miniIcon.ScaleType = Enum.ScaleType.Crop
    miniIcon.Visible = false
    miniIcon.ZIndex = 10
    miniIcon.Parent = main
    Instance.new("UICorner", miniIcon).CornerRadius = CORNER_RADIUS

    local topBar = Instance.new("Frame")
    topBar.Size = UDim2.new(1, 0, 0, 40)
    topBar.BackgroundColor3 = STYLE.SidebarColor
    topBar.BackgroundTransparency = 1
    topBar.BorderSizePixel = 0
    topBar.ZIndex = 3
    topBar.Parent = main
    Instance.new("UICorner", topBar).CornerRadius = CORNER_RADIUS
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Text = "  " .. (hubName or "HUB")
    titleLabel.Size = UDim2.new(1, -80, 1, 0)
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 14
    titleLabel.TextColor3 = STYLE.TextColor
    titleLabel.TextTransparency = 1
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.BackgroundTransparency = 1
    titleLabel.ZIndex = 4
    titleLabel.Parent = topBar

    local minBtn = Instance.new("TextButton")
    minBtn.Size = UDim2.new(0, 30, 0, 30)
    minBtn.Position = UDim2.new(1, -35, 0.5, -15)
    minBtn.BackgroundColor3 = STYLE.CardColor
    minBtn.BackgroundTransparency = 1
    minBtn.Text = "-"
    minBtn.Font = Enum.Font.GothamBold
    minBtn.TextSize = 16
    minBtn.TextColor3 = STYLE.TextColor
    minBtn.TextTransparency = 1
    minBtn.ZIndex = 4
    minBtn.Parent = topBar
    Instance.new("UICorner", minBtn).CornerRadius = CORNER_RADIUS

    local sidebar = Instance.new("Frame")
    sidebar.Size = UDim2.new(0, 130, 1, -40)
    sidebar.Position = UDim2.new(0, 0, 0, 40)
    sidebar.BackgroundColor3 = STYLE.SidebarColor
    sidebar.BackgroundTransparency = 1
    sidebar.BorderSizePixel = 0
    sidebar.ZIndex = 3
    sidebar.Parent = main
    Instance.new("UICorner", sidebar).CornerRadius = CORNER_RADIUS
    
    local sideList = Instance.new("UIListLayout")
    sideList.Padding = UDim.new(0, 5)
    sideList.Parent = sidebar
    
    local sidePad = Instance.new("UIPadding")
    sidePad.PaddingTop = UDim.new(0, 8)
    sidePad.PaddingLeft = UDim.new(0, 8)
    sidePad.PaddingRight = UDim.new(0, 8)
    sidePad.Parent = sidebar
    
    local contentArea = Instance.new("Frame")
    contentArea.Size = UDim2.new(1, -130, 1, -40)
    contentArea.Position = UDim2.new(0, 130, 0, 40)
    contentArea.BackgroundTransparency = 1
    contentArea.ZIndex = 3
    contentArea.Parent = main
    Instance.new("UICorner", contentArea).CornerRadius = CORNER_RADIUS
    
    self.Main = main
    self.MainStroke = mainStroke
    self.Sidebar = sidebar
    self.ContentArea = contentArea
    self.TopBar = topBar
    self.Tabs = {}

    task.spawn(function()
        TweenService:Create(main, TweenInfo.new(0.4, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
            Position = UDim2.new(0.5, -260, 0.5, -180),
            BackgroundTransparency = 0
        }):Play()
        TweenService:Create(mainStroke, TweenInfo.new(0.4), {Transparency = 0.3}):Play()
        TweenService:Create(bgImage, TweenInfo.new(0.4), {ImageTransparency = 0.6}):Play()

        TweenService:Create(introIcon, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
        TweenService:Create(introTitle, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(introStatus, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(loadBarBg, TweenInfo.new(0.3), {BackgroundTransparency = 0.4}):Play()

        task.wait(0.2)
        TweenService:Create(loadBarFill, TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            Size = UDim2.new(1, 0, 1, 0)
        }):Play()
        task.wait(0.5)

        TweenService:Create(introIcon, TweenInfo.new(0.25), {ImageTransparency = 1}):Play()
        TweenService:Create(introTitle, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(introStatus, TweenInfo.new(0.25), {TextTransparency = 1}):Play()
        TweenService:Create(loadBarBg, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        TweenService:Create(loadBarFill, TweenInfo.new(0.25), {BackgroundTransparency = 1}):Play()
        task.wait(0.25)

        introContainer:Destroy()

        TweenService:Create(topBar, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
        TweenService:Create(sidebar, TweenInfo.new(0.3), {BackgroundTransparency = 0.2}):Play()
        TweenService:Create(bgImage, TweenInfo.new(0.3), {ImageTransparency = 0.4}):Play()
        TweenService:Create(titleLabel, TweenInfo.new(0.3), {TextTransparency = 0}):Play()
        TweenService:Create(minBtn, TweenInfo.new(0.3), {BackgroundTransparency = 0.2, TextTransparency = 0}):Play()
    end)

    local function toggleMinimize()
        self.IsMinimized = not self.IsMinimized
        if self.IsMinimized then
            topBar.Visible = false
            sidebar.Visible = false
            contentArea.Visible = false
            bgImage.Visible = false
            particleContainer.Visible = false
            miniIcon.Visible = true
            miniIcon.ImageTransparency = 0
            TweenService:Create(main, TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 40, 0, 40)
            }):Play()
        else
            miniIcon.Visible = false
            topBar.BackgroundTransparency = 1
            sidebar.BackgroundTransparency = 1
            bgImage.ImageTransparency = 1
            titleLabel.TextTransparency = 1
            minBtn.BackgroundTransparency = 1
            minBtn.TextTransparency = 1
            topBar.Visible = true
            sidebar.Visible = true
            contentArea.Visible = true
            bgImage.Visible = true
            particleContainer.Visible = true

            TweenService:Create(main, TweenInfo.new(0.35, Enum.EasingStyle.Quart, Enum.EasingDirection.Out), {
                Size = UDim2.new(0, 520, 0, 360)
            }):Play()

            TweenService:Create(topBar, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
            TweenService:Create(sidebar, TweenInfo.new(0.2), {BackgroundTransparency = 0.2}):Play()
            TweenService:Create(bgImage, TweenInfo.new(0.25), {ImageTransparency = 0.4}):Play()
            TweenService:Create(titleLabel, TweenInfo.new(0.2), {TextTransparency = 0}):Play()
            TweenService:Create(minBtn, TweenInfo.new(0.2), {BackgroundTransparency = 0.2, TextTransparency = 0}):Play()
        end
    end

    minBtn.MouseButton1Click:Connect(toggleMinimize)
    miniIcon.MouseButton1Click:Connect(toggleMinimize)

    UserInputService.InputBegan:Connect(function(input, gpe)
        if not gpe and input.KeyCode == Enum.KeyCode.RightControl then
            self.IsVisible = not self.IsVisible
            main.Visible = self.IsVisible
        end
    end)
    
    local dragging, dragStart, startPos
    local function updateDrag(input)
        local delta = input.Position - dragStart
        main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end

    topBar.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)
    
    miniIcon.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            dragStart = input.Position
            startPos = main.Position
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateDrag(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)
    
    return self
end

function Hub:AddTab(tabName)
    local tabObj = {}
    tabObj.Hub = self
    
    local tabBtn = Instance.new("TextButton")
    tabBtn.Size = UDim2.new(1, 0, 0, 32)
    tabBtn.BackgroundColor3 = STYLE.SidebarColor
    tabBtn.BackgroundTransparency = 0.2
    tabBtn.Text = tabName
    tabBtn.Font = Enum.Font.GothamMedium
    tabBtn.TextSize = 12
    tabBtn.TextColor3 = STYLE.SubTextColor
    tabBtn.ZIndex = 4
    tabBtn.Parent = self.Sidebar
    
    Instance.new("UICorner", tabBtn).CornerRadius = CORNER_RADIUS
    
    local page = Instance.new("ScrollingFrame")
    page.Size = UDim2.new(1, 0, 1, 0)
    page.BackgroundTransparency = 1
    page.Visible = false
    page.ScrollBarThickness = 3
    page.ScrollBarImageColor3 = STYLE.AccentColor
    page.ZIndex = 4
    page.Parent = self.ContentArea
    
    local pageList = Instance.new("UIListLayout")
    pageList.Padding = UDim.new(0, 8)
    pageList.Parent = page
    
    local pagePad = Instance.new("UIPadding")
    pagePad.PaddingTop = UDim.new(0, 10)
    pagePad.PaddingLeft = UDim.new(0, 10)
    pagePad.PaddingRight = UDim.new(0, 10)
    pagePad.Parent = page
    
    local function selectTab()
        for _, t in pairs(self.Tabs) do
            t.Page.Visible = false
            t.Button.TextColor3 = STYLE.SubTextColor
            t.Button.BackgroundColor3 = STYLE.SidebarColor
        end
        page.Visible = true
        tabBtn.TextColor3 = STYLE.AccentColor
        tabBtn.BackgroundColor3 = STYLE.CardColor
    end
    
    tabBtn.MouseButton1Click:Connect(selectTab)
    tabObj.Page = page
    tabObj.Button = tabBtn
    
    -- 1. 分區標題 (Section)
    function tabObj:AddSection(text)
        local secFrame = Instance.new("Frame")
        secFrame.Size = UDim2.new(1, 0, 0, 20)
        secFrame.BackgroundTransparency = 1
        secFrame.ZIndex = 5
        secFrame.Parent = page

        local secLabel = Instance.new("TextLabel")
        secLabel.Text = string.upper(text)
        secLabel.Size = UDim2.new(1, 0, 1, 0)
        secLabel.Font = Enum.Font.GothamBold
        secLabel.TextSize = 11
        secLabel.TextColor3 = STYLE.SubTextColor
        secLabel.TextXAlignment = Enum.TextXAlignment.Left
        secLabel.BackgroundTransparency = 1
        secLabel.ZIndex = 6
        secLabel.Parent = secFrame
    end

    -- 2. 普通按鈕 (Button)
    function tabObj:AddButton(text, callback)
        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 0, 36)
        btn.BackgroundColor3 = STYLE.CardColor
        btn.BackgroundTransparency = 0.2
        btn.Text = "  " .. text
        btn.Font = Enum.Font.Gotham
        btn.TextSize = 12
        btn.TextColor3 = STYLE.TextColor
        btn.TextXAlignment = Enum.TextXAlignment.Left
        btn.ZIndex = 5
        btn.Parent = page
        
        Instance.new("UICorner", btn).CornerRadius = CORNER_RADIUS
        
        btn.MouseEnter:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = STYLE.CardHover}):Play()
        end)
        btn.MouseLeave:Connect(function()
            TweenService:Create(btn, TweenInfo.new(0.15), {BackgroundColor3 = STYLE.CardColor}):Play()
        end)
        btn.MouseButton1Click:Connect(function()
            if callback then callback() end
        end)
    end

    -- 3. 開關 (Toggle)
    function tabObj:AddToggle(text, defaultState, callback)
        local state = defaultState or false
        
        local toggleFrame = Instance.new("Frame")
        toggleFrame.Size = UDim2.new(1, 0, 0, 36)
        toggleFrame.BackgroundColor3 = STYLE.CardColor
        toggleFrame.BackgroundTransparency = 0.2
        toggleFrame.ZIndex = 5
        toggleFrame.Parent = page
        Instance.new("UICorner", toggleFrame).CornerRadius = CORNER_RADIUS

        local label = Instance.new("TextLabel")
        label.Text = "  " .. text
        label.Size = UDim2.new(1, -60, 1, 0)
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextColor3 = STYLE.TextColor
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.ZIndex = 6
        label.Parent = toggleFrame

        local switchBg = Instance.new("Frame")
        switchBg.Size = UDim2.new(0, 40, 0, 20)
        switchBg.Position = UDim2.new(1, -50, 0.5, -10)
        switchBg.BackgroundColor3 = state and STYLE.AccentColor or STYLE.ToggleOff
        switchBg.ZIndex = 6
        switchBg.Parent = toggleFrame
        Instance.new("UICorner", switchBg).CornerRadius = UDim.new(1, 0)

        local switchDot = Instance.new("Frame")
        switchDot.Size = UDim2.new(0, 16, 0, 16)
        switchDot.Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)
        switchDot.BackgroundColor3 = STYLE.TextColor
        switchDot.ZIndex = 7
        switchDot.Parent = switchBg
        Instance.new("UICorner", switchDot).CornerRadius = UDim.new(1, 0)

        local btn = Instance.new("TextButton")
        btn.Size = UDim2.new(1, 0, 1, 0)
        btn.BackgroundTransparency = 1
        btn.Text = ""
        btn.ZIndex = 8
        btn.Parent = toggleFrame

        btn.MouseButton1Click:Connect(function()
            state = not state
            TweenService:Create(switchBg, TweenInfo.new(0.2), {BackgroundColor3 = state and STYLE.AccentColor or STYLE.ToggleOff}):Play()
            TweenService:Create(switchDot, TweenInfo.new(0.2), {Position = state and UDim2.new(1, -18, 0.5, -8) or UDim2.new(0, 2, 0.5, -8)}):Play()
            if callback then callback(state) end
        end)
    end

    -- 4. 滑桿 (Slider)
    function tabObj:AddSlider(text, min, max, defaultVal, callback)
        min = min or 0
        max = max or 100
        defaultVal = math.clamp(defaultVal or min, min, max)

        local sliderFrame = Instance.new("Frame")
        sliderFrame.Size = UDim2.new(1, 0, 0, 50)
        sliderFrame.BackgroundColor3 = STYLE.CardColor
        sliderFrame.BackgroundTransparency = 0.2
        sliderFrame.ZIndex = 5
        sliderFrame.Parent = page
        Instance.new("UICorner", sliderFrame).CornerRadius = CORNER_RADIUS

        local label = Instance.new("TextLabel")
        label.Text = "  " .. text
        label.Size = UDim2.new(1, -60, 0, 25)
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextColor3 = STYLE.TextColor
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.ZIndex = 6
        label.Parent = sliderFrame

        local valLabel = Instance.new("TextLabel")
        valLabel.Text = tostring(defaultVal)
        valLabel.Size = UDim2.new(0, 50, 0, 25)
        valLabel.Position = UDim2.new(1, -55, 0, 0)
        valLabel.Font = Enum.Font.GothamBold
        valLabel.TextSize = 12
        valLabel.TextColor3 = STYLE.AccentColor
        valLabel.BackgroundTransparency = 1
        valLabel.ZIndex = 6
        valLabel.Parent = sliderFrame

        local sliderBg = Instance.new("Frame")
        sliderBg.Size = UDim2.new(1, -20, 0, 6)
        sliderBg.Position = UDim2.new(0, 10, 0, 32)
        sliderBg.BackgroundColor3 = STYLE.SidebarColor
        sliderBg.ZIndex = 6
        sliderBg.Parent = sliderFrame
        Instance.new("UICorner", sliderBg).CornerRadius = UDim.new(1, 0)

        local sliderFill = Instance.new("Frame")
        sliderFill.Size = UDim2.new((defaultVal - min) / (max - min), 0, 1, 0)
        sliderFill.BackgroundColor3 = STYLE.AccentColor
        sliderFill.ZIndex = 7
        sliderFill.Parent = sliderBg
        Instance.new("UICorner", sliderFill).CornerRadius = UDim.new(1, 0)

        local isSliding = false
        local function updateSlider(input)
            local posX = math.clamp(input.Position.X - sliderBg.AbsolutePosition.X, 0, sliderBg.AbsoluteSize.X)
            local percent = posX / sliderBg.AbsoluteSize.X
            local val = math.floor(min + (max - min) * percent)
            sliderFill.Size = UDim2.new(percent, 0, 1, 0)
            valLabel.Text = tostring(val)
            if callback then callback(val) end
        end

        sliderBg.InputBegan:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isSliding = true
                updateSlider(input)
            end
        end)

        UserInputService.InputChanged:Connect(function(input)
            if isSliding and input.UserInputType == Enum.UserInputType.MouseMovement then
                updateSlider(input)
            end
        end)

        UserInputService.InputEnded:Connect(function(input)
            if input.UserInputType == Enum.UserInputType.MouseButton1 then
                isSliding = false
            end
        end)
    end

    -- 5. 下拉選單 (Dropdown)
    function tabObj:AddDropdown(text, options, defaultSelected, callback)
        options = options or {}
        local selected = defaultSelected or options[1] or "Select..."
        local isExpanded = false

        local dropdownFrame = Instance.new("Frame")
        dropdownFrame.Size = UDim2.new(1, 0, 0, 36)
        dropdownFrame.BackgroundColor3 = STYLE.CardColor
        dropdownFrame.BackgroundTransparency = 0.2
        dropdownFrame.ClipsDescendants = true
        dropdownFrame.ZIndex = 5
        dropdownFrame.Parent = page
        Instance.new("UICorner", dropdownFrame).CornerRadius = CORNER_RADIUS

        local topBtn = Instance.new("TextButton")
        topBtn.Size = UDim2.new(1, 0, 0, 36)
        topBtn.BackgroundTransparency = 1
        topBtn.Text = "  " .. text .. ": " .. tostring(selected)
        topBtn.Font = Enum.Font.Gotham
        topBtn.TextSize = 12
        topBtn.TextColor3 = STYLE.TextColor
        topBtn.TextXAlignment = Enum.TextXAlignment.Left
        topBtn.ZIndex = 6
        topBtn.Parent = dropdownFrame

        local listContainer = Instance.new("Frame")
        listContainer.Size = UDim2.new(1, -10, 0, #options * 28)
        listContainer.Position = UDim2.new(0, 5, 0, 36)
        listContainer.BackgroundTransparency = 1
        listContainer.ZIndex = 6
        listContainer.Parent = dropdownFrame

        local dList = Instance.new("UIListLayout")
        dList.Padding = UDim.new(0, 2)
        dList.Parent = listContainer

        for _, opt in ipairs(options) do
            local optBtn = Instance.new("TextButton")
            optBtn.Size = UDim2.new(1, 0, 0, 26)
            optBtn.BackgroundColor3 = STYLE.SidebarColor
            optBtn.Text = tostring(opt)
            optBtn.Font = Enum.Font.Gotham
            optBtn.TextSize = 11
            optBtn.TextColor3 = STYLE.SubTextColor
            optBtn.ZIndex = 7
            optBtn.Parent = listContainer
            Instance.new("UICorner", optBtn).CornerRadius = CORNER_RADIUS

            optBtn.MouseButton1Click:Connect(function()
                selected = opt
                topBtn.Text = "  " .. text .. ": " .. tostring(selected)
                isExpanded = false
                TweenService:Create(dropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, 36)}):Play()
                if callback then callback(selected) end
            end)
        end

        topBtn.MouseButton1Click:Connect(function()
            isExpanded = not isExpanded
            local targetHeight = isExpanded and (38 + #options * 28) or 36
            TweenService:Create(dropdownFrame, TweenInfo.new(0.2), {Size = UDim2.new(1, 0, 0, targetHeight)}):Play()
        end)
    end

    -- 6. 輸入框 (Textbox)
    function tabObj:AddTextbox(text, placeholder, callback)
        local boxFrame = Instance.new("Frame")
        boxFrame.Size = UDim2.new(1, 0, 0, 36)
        boxFrame.BackgroundColor3 = STYLE.CardColor
        boxFrame.BackgroundTransparency = 0.2
        boxFrame.ZIndex = 5
        boxFrame.Parent = page
        Instance.new("UICorner", boxFrame).CornerRadius = CORNER_RADIUS

        local label = Instance.new("TextLabel")
        label.Text = "  " .. text
        label.Size = UDim2.new(0.5, 0, 1, 0)
        label.Font = Enum.Font.Gotham
        label.TextSize = 12
        label.TextColor3 = STYLE.TextColor
        label.TextXAlignment = Enum.TextXAlignment.Left
        label.BackgroundTransparency = 1
        label.ZIndex = 6
        label.Parent = boxFrame

        local textBox = Instance.new("TextBox")
        textBox.Size = UDim2.new(0.45, 0, 0, 24)
        textBox.Position = UDim2.new(0.52, 0, 0.5, -12)
        textBox.BackgroundColor3 = STYLE.SidebarColor
        textBox.Font = Enum.Font.Gotham
        textBox.TextSize = 11
        textBox.TextColor3 = STYLE.TextColor
        textBox.PlaceholderText = placeholder or "Input..."
        textBox.PlaceholderColor3 = STYLE.SubTextColor
        textBox.Text = ""
        textBox.ZIndex = 6
        textBox.Parent = boxFrame
        Instance.new("UICorner", textBox).CornerRadius = CORNER_RADIUS

        textBox.FocusLost:Connect(function(enterPressed)
            if enterPressed and callback then
                callback(textBox.Text)
            end
        end)
    end

    table.insert(self.Tabs, tabObj)
    if #self.Tabs == 1 then selectTab() end
    return tabObj
end

--------------------------------------------------
-- 自動建構器 (BuildFromConfig)
--------------------------------------------------
function Hub:BuildFromConfig(configTable)
    for _, tabData in ipairs(configTable) do
        local tabName = tabData.Name or "Tab"
        local newTab = self:AddTab(tabName)
        
        if tabData.Elements then
            for _, elem in ipairs(tabData.Elements) do
                if elem.Type == "Section" then
                    newTab:AddSection(elem.Title or "Section")
                elseif elem.Type == "Button" then
                    newTab:AddButton(elem.Title or "Button", elem.Callback)
                elseif elem.Type == "Toggle" then
                    newTab:AddToggle(elem.Title or "Toggle", elem.Default, elem.Callback)
                elseif elem.Type == "Slider" then
                    newTab:AddSlider(elem.Title or "Slider", elem.Min, elem.Max, elem.Default, elem.Callback)
                elseif elem.Type == "Dropdown" then
                    newTab:AddDropdown(elem.Title or "Dropdown", elem.Options, elem.Default, elem.Callback)
                elseif elem.Type == "Textbox" then
                    newTab:AddTextbox(elem.Title or "Textbox", elem.Placeholder, elem.Callback)
                end
            end
        end
    end
end

return Hub
