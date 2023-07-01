local obj = {}
obj.__index = obj

hs.grid.setGrid('10x4')
hs.grid.setMargins({x=0, y=0})
hs.window.animationDuration = 0.0

windowPositions = {
  full = '0,0 10x4',
  left = '0,0 5x4',
  right = '5,0 5x4',
  top = '0,0 10x2',
  bottom = '0,2 10x2',
  center = '2,0 6x4',
  topLeft = '0,0 5x2',
  topRight = '5,0 5x2',
  bottomLeft = '0,2 5x2',
  bottomRight = '5,2 5x2',
}

hs.urlevent.bind('moveWindow', function(listener, params)
    local win = hs.window.focusedWindow()
    local axApp = hs.axuielement.applicationElement(win:application())
    local wasEnhanced = axApp.AXEnhancedUserInterface
    if wasEnhanced then
        axApp.AXEnhancedUserInterface = false
    end

    hs.grid.set(win, windowPositions[params.key])

    if wasEnhanced then
        axApp.AXEnhancedUserInterface = true
    end
end)

return obj;
