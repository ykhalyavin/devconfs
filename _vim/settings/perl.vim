autocmd FileType perl set nowrap textwidth=78 keywordprg=perldoc\ -f
autocmd FileType perl set errorformat=%f:%l:%m
autocmd FileType perl set autowrite

autocmd FileType perl set makeprg=perl\ -c\ %\ $*

autocmd BufEnter *.pl,*.pm compiler perl
autocmd BufEnter *.pl,*.pm set softtabstop=4 sw=4

let perl_extended_vars = 1
let perl_include_pod = 1
