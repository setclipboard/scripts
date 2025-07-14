local Players=game:GetService("Players")
local TweenService=game:GetService("TweenService")
local TextService=game:GetService("TextService")
local player=Players.LocalPlayer
local playerGui=player:WaitForChild("PlayerGui")
_G.Dialog={Message="Hello, world!",NameColor=Color3.fromRGB(0,0,139),MessageColor=Color3.fromRGB(255,255,255)}
local NAME_SIZE=26
local MSG_SIZE=26
local STAGGER=0.05
local HOLD_TIME=1.0
local TWEEN=TweenInfo.new(0.5,Enum.EasingStyle.Quad,Enum.EasingDirection.Out)

local function icl(c,fs,p,col,par)
    local d=TextService:GetTextSize(c,fs,Enum.Font.SourceSansBold,Vector2.new(1e6,1e6))
    local l=Instance.new("TextLabel")
    l.Size=UDim2.new(0,d.X,0,d.Y)
    l.Position=p+UDim2.new(0,0,0,20)
    l.AnchorPoint=Vector2.new(0,0)
    l.BackgroundTransparency=1
    l.Font=Enum.Font.SourceSansBold
    l.TextSize=fs
    l.TextColor3=col
    l.Text=c
    l.TextTransparency=1
    l.Parent=par
    local s=Instance.new("UIStroke",l)
    s.Thickness=2
    s.Color=Color3.new(0,0,0)
    s.Transparency=1
    return{lbl=l,stroke=s,startPos=l.Position}
end

local function tspmo(e,d)
    delay(d,function()
        TweenService:Create(e.lbl,TWEEN,{Position=e.startPos-UDim2.new(0,0,0,20),TextTransparency=0,Rotation=0}):Play()
        TweenService:Create(e.stroke,TWEEN,{Transparency=0}):Play()
    end)
end

local function ts(e,d)
    delay(d,function()
        TweenService:Create(e.lbl,TWEEN,{TextTransparency=1,Rotation=20}):Play()
        TweenService:Create(e.stroke,TWEEN,{Transparency=1}):Play()
    end)
end

function _G.Dialog.Show()
    local cfg=_G.Dialog
    local gui=playerGui:FindFirstChild("DialogUI") or Instance.new("ScreenGui",playerGui)
    gui.Name="DialogUI"
    gui.ResetOnSpawn=false
    local cam=workspace.CurrentCamera
    local nameText=player.Name
    local msgText=cfg.Message
    local nameW=TextService:GetTextSize(nameText,NAME_SIZE,Enum.Font.SourceSansBold,Vector2.new(1e6,1e6)).X
    local msgW=TextService:GetTextSize(msgText,MSG_SIZE,Enum.Font.SourceSansBold,Vector2.new(1e6,1e6)).X
    local nameStart=(cam.ViewportSize.X-nameW)/2
    local msgStart=(cam.ViewportSize.X-msgW)/2
    local nameEntries={}
    do
        local x=0
        for i=1,#nameText do
            local ch=nameText:sub(i,i)
            local pos=UDim2.new(0,nameStart+x,0.72,0)
            local ent=icl(ch,NAME_SIZE,pos,cfg.NameColor,gui)
            table.insert(nameEntries,ent)
            x=x+TextService:GetTextSize(ch,NAME_SIZE,Enum.Font.SourceSansBold,Vector2.new(1e6,1e6)).X
        end
    end
    local msgEntries={}
    do
        local x=0
        for i=1,#msgText do
            local ch=msgText:sub(i,i)
            local pos=UDim2.new(0,msgStart+x,0.77,0)
            local ent=icl(ch,MSG_SIZE,pos,cfg.MessageColor,gui)
            table.insert(msgEntries,ent)
            x=x+TextService:GetTextSize(ch,MSG_SIZE,Enum.Font.SourceSansBold,Vector2.new(1e6,1e6)).X
        end
    end
    for i,ent in ipairs(nameEntries) do tspmo(ent,i*STAGGER) end
    for i,ent in ipairs(msgEntries)  do tspmo(ent,i*STAGGER) end
    delay(math.max(#nameEntries,#msgEntries)*STAGGER+HOLD_TIME+0.5,function()
        for i,ent in ipairs(nameEntries) do ts(ent,i*STAGGER) end
        for i,ent in ipairs(msgEntries)  do ts(ent,i*STAGGER) end
    end)
end
