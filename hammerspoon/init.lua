gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({
        title = 'Karabiner Config',
        informativeText = output
    }):send()
end):start()

hs.loadSpoon('ReloadConfiguration')

spoon.ReloadConfiguration:start()


hs.audiodevice.watcher.setCallback(function(event)
    print(event)
    if (event == "dIn ") then -- That trailing space is not a mistake
        local microphone = hs.audiodevice.findDeviceByName("Scarlett Solo USB")
        if (microphone and microphone:name() ~= hs.audiodevice.defaultInputDevice():name()) then
            microphone:setDefaultInputDevice()
            hs.notify.new({ title = 'Input Connected', informativeText = microphone:name() }):send()
        end
    end
end)
hs.audiodevice.watcher.start()



hs.notify.new({
    title = 'Hammerspoon',
    informativeText = 'Config loaded'
}):send()

hs.loadSpoon('Hyper')
hs.loadSpoon('Helpers')
hs.loadSpoon('Apps')
hs.loadSpoon('Windows')

hyper:app(slack):action('open', {
    default = combo({ 'cmd' }, 'k')
}):action('navigate', {
    back = combo({ 'cmd' }, '['),
    forward = combo({ 'cmd' }, ']')
}):action('toggle', {
    sidebar = combo({ 'cmd' }, '.')
})

hyper:app(arc):action('open', {
    default = combo({ 'cmd' }, 't')
}):action('navigate', {
    back = combo({ 'cmd' }, '['),
    forward = combo({ 'cmd' }, ']'),
    up = combo({ 'cmd', 'shift' }, '['),
    down = combo({ 'cmd', 'shift' }, ']')
}):action('copy', {
    default = copy(keys('yy'))
}):action('toggle', {
    sidebar = combo({ 'cmd', 'alt' }, 's')
}):action('insert', {
    c = combo({ 'cmd', 'shift' }, 'p'),                                  -- credentials
    g = chain({ combo({ 'cmd', 'shift' }, '9'), combo({ 'cmd' }, 'v') }) -- generate & paste password
}):action('execute', {
    debug = combo({ 'cmd', 'option' }, 'i')
})

hyper:app(vscode):action('copy', {
    default = copy(combo({ 'cmd', 'option', 'control' }, 'y'))
}):action('execute', {
    default = combo({ 'cmd', 'shift' }, 'p'),
    a = combo({ 'cmd', 'ctrl' }, 'a'), -- run all tests
    f = combo({ 'cmd', 'ctrl' }, 'f'), -- test current file
    r = combo({ 'cmd', 'ctrl' }, 'p'), -- rerun last test
    t = combo({ 'cmd', 'ctrl' }, 't'), -- test current method
}):action('toggle', {
    default = combo({ 'cmd' }, '/'),
    sidebar = combo({ 'cmd' }, 'b')
})

hyper:app(cursor):action('copy', {
    default = copy(combo({ 'cmd', 'option', 'control' }, 'y'))
}):action('execute', {
    default = combo({ 'cmd', 'shift' }, 'p'),
    a = combo({ 'cmd', 'ctrl' }, 'a'), -- run all tests
    f = combo({ 'cmd', 'ctrl' }, 'f'), -- test current file
    r = combo({ 'cmd', 'ctrl' }, 'p'), -- rerun last test
    t = combo({ 'cmd', 'ctrl' }, 't'), -- test current method
}):action('toggle', {
    default = combo({ 'cmd' }, '/'),
    sidebar = combo({ 'cmd' }, 'b')
})

hyper:app(obsidian):action('open', {
    default = combo({ 'cmd' }, 'o')
}):action('execute', {
    default = combo({ 'cmd' }, 'p')
})

hyper:app(notion):action('open', {
    default = combo({ 'cmd' }, 'k')
}):action('copy', {
    default = copy(combo({ 'cmd' }, 'l'))
}):action('toggle', {
    sidebar = combo({ 'cmd' }, '\\')
})

hyper:app(finder):action('navigate', {
    back = combo({ 'cmd' }, '['),
    forward = combo({ 'cmd' }, ']')
})

hyper:app(linear):action('open', {
    default = combo({ 'cmd' }, 'k')
}):action('toggle', {
    sidebar = keys("[")
})

hyper:app('fallback'):action('open', {
    default = combo({ 'cmd' }, 'p')
}):action('copy', {
    default = combo({ 'cmd' }, 'c')
}):action('paste', {
    default = combo({ 'cmd' }, 'v')
}):action('insert', {
    default = combo({ 'cmd', 'shift', 'option', 'control' }, 'i') -- Alfred clipboard
}):action('open', {
    alfred = combo({ 'cmd', 'shift', 'option', 'control' }, ';')
}):action('general', {
    save = combo({ 'cmd' }, 's'),
    close = combo({ 'cmd' }, 'w'),
    new = combo({ 'cmd' }, 't'),
    refresh = combo({ 'cmd' }, 'r')
}):action('execute', {
    default = alfredWorkflow('com.folded-paper.menu-bar-search', 'menubarsearch')
}):action('toggle', {
    sidebar = combo({ 'cmd' }, '/')
}):action('navigate', {
    back = combo({ 'cmd' }, '['),
    forward = combo({ 'cmd' }, ']')
}):action('universal-action', {
    alfred = combo({'cmd', 'option', 'control'}, '/')
})
