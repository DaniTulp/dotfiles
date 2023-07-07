hs.loadSpoon('ModalMgr')

local obj = {}
obj.__index = obj

function combo(modifiers, key)
    return function()
        hs.eventtap.keyStroke(modifiers, key)
    end
end

function keys(keys)
    return function()
        hs.eventtap.keyStrokes(keys)
    end
end

function chain(commands)
    return function ()
        for _, command in pairs(commands) do
            command()
        end
    end
end

function alfredSearch(keys)
    return function()
        hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to search "' .. keys ..' "')
    end
end

function alfredWorkflow(workflow, trigger)
    return function()
        hs.osascript.applescript('tell application id "com.runningwithcrayons.Alfred" to run trigger "' .. trigger .. '" in workflow "' .. workflow .. '"')
    end
end

function launch(bundleID)
    return function()
        hs.application.launchOrFocusByBundleID(bundleID)
    end
end

function modal(name, actions, onEnter, onExit)
    spoon.ModalMgr:new(name)
    local modal = spoon.ModalMgr.modal_list[name]
    modal:bind('', 'escape', 'Deactivate ' .. name .. ' modal', function()
        spoon.ModalMgr:deactivate({name})
    end)

    if (onEnter) then
        modal.entered = onEnter
    end
    if (onExit) then
        modal.exited = onExit
    end

    for key, action in pairs(actions) do
        modal:bind('', key, '', function()
            action()
            spoon.ModalMgr:deactivate({name})
        end)
    end

    return function()
        spoon.ModalMgr:deactivateAll()
        spoon.ModalMgr:activate({name}, '#0000FF', false)
    end
end

function getSelectedText(copying)
    original = hs.pasteboard.getContents()
    hs.pasteboard.clearContents()
    hs.eventtap.keyStroke({'cmd'}, 'C')
    text = hs.pasteboard.getContents()
    finderFileSelected = false
    for k,v in pairs(hs.pasteboard.contentTypes()) do
        if v == 'public.file-url' then
            finderFileSelected = true
        end
    end

    if not copying and finderFileSelected then
        text = 'finderFileSelected'
    end

    if not copying then
        hs.pasteboard.setContents(original)
    end

    return text
end

function copy(callback)
    return function()
        text = getSelectedText(true)
        -- hack around notion seemingly populating non-selected text with "-"
        if text == "-" and frontApp() == notion then
            callback()
        end
        if text then
            -- Already in clipboard, do not reset
            return
        end
        callback()
    end
end


return obj
