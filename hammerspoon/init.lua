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

hyper:app(brave):action('open', {
    default = alfredSearch('bm')
}):action('navigate', {
    back = combo({'cmd'}, '['),
    forward = combo({'cmd'}, ']')
}):action('copy', {
    default = copy(keys('yy'))
})

hyper:app(vscode):action('copy', {
    default = copy(combo({'cmd', 'option', 'control'}, 'y'))
}):action('execute', {
    default = combo({'cmd', 'shift'}, 'p')
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
    alfred = combo({'cmd'}, 'space')
}):action('general', {
    save = combo({'cmd'}, 's');
    close = combo({'cmd'}, 'w');
    new = combo({'cmd'}, 't');
    refresh = combo({'cmd'}, 'r');
}):action('execute', {
    default = alfredWorkflow('com.tedwise.menubarsearch', 'menubarsearch')
})
