return {
    "vim-test/vim-test",
    keys = {
        { "<Leader>tn", ":TestNearest<CR>" },
        { "<Leader>tf", ":TestFile<CR>" },
        { "<Leader>ts", ":TestSuite<CR>" },
        { "<Leader>tl", ":TestLast<CR>" },
        { "<Leader>tv", ":TestVisit<CR>" },
    },
    dependencies = { "voldikss/vim-floaterm" },
    config = function()
        vim.cmd([[
      let test#php#phpunit#executable = 'php artisan test'
      let g:test#strategy = 'floaterm'
    ]])
    end,
}
