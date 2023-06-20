gokuWatcher = hs.pathwatcher.new(os.getenv('HOME') .. '/.config/karabiner.edn/', function()
    output = hs.execute('/usr/local/bin/goku')
    hs.notify.new({
        title = 'Karabiner Config',
        informativeText = output
    }):send()
end):start()

hs.loadSpoon('ReloadConfiguration')
spoon.ReloadConfiguration:start()
hs.notify.new({
    title = 'Hammerspoon',
    informativeText = 'Config loaded'
}):send()

hs.loadSpoon('Hyper')
hs.loadSpoon('Helpers')
hs.loadSpoon('Apps')

hyper:app(slack):action('open', {
    default = combo({'cmd'}, 'k')
}):action('navigate', {
    back = combo({'cmd'}, '['),
    forward = combo({'cmd'}, ']')
})

hyper:app(arc):action('open', {
    default = combo({'cmd'}, 't')
}):action('navigate', {
    back = combo({'cmd'}, '['),
    forward = combo({'cmd'}, ']'),
    up = combo({'cmd', 'shift'}, '['),
    down = combo({'cmd', 'shift'}, ']')
}):action('copy', {
    default = copy(keys('yy'))
}):action('toggle', {
    sidebar = combo({'cmd'}, 's')
}):action('insert', {
    c = combo({'cmd', 'shift'}, 'p'), -- credentials
})

hyper:app(vscode):action('copy', {
    default = copy(combo({'cmd', 'option', 'control'}, 'y'))
}):action('execute', {
    default = combo({'cmd', 'shift'}, 'p')
}):action('toggle', {
    default = combo({'cmd'}, '/'),
    sidebar = combo({'cmd'}, 'b')
})

hyper:app(obsidian):action('open', {
    default = combo({'cmd'}, 'o')
}):action('execute', {
    default = combo({'cmd'}, 'p')
})

hyper:app(finder):action('navigate', {
    back = combo({'cmd'}, '['),
    forward = combo({'cmd'}, ']')
})

hyper:app('fallback'):action('open', {
    default = combo({'cmd'}, 'p')
}):action('copy', {
    default = combo({'cmd'}, 'c')
}):action('paste', {
    default = combo({'cmd'}, 'v')
}):action('insert', {
    default = combo({'cmd', 'shift', 'option', 'control'}, 'i') -- Alfred clipboard
}):action('open', {
    alfred = combo({'cmd', 'shift', 'option', 'control'}, ';')
}):action('general', {
    save = combo({'cmd'}, 's'),
    close = combo({'cmd'}, 'w'),
    new = combo({'cmd'}, 't'),
    refresh = combo({'cmd'}, 'r')
}):action('execute', {
    default = alfredWorkflow('com.tedwise.menubarsearch', 'menubarsearch')
}):action('toggle', {
    sidebar = combo({'cmd'}, '/')
})
