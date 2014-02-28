let python_highlight_all = 1
au FileType python set omnifunc=pythoncomplete#Complete
let g:SuperTabDefaultCompletionType = "context"
"autocmd BufRead *.py set smartindent cinwords=if,elif,else,for,while,try,except,finally,def,class

" Don`t check code every save
let g:pymode_lint_write = 0
" Auto open cwindow if errors be finded
let g:pymode_lint_cwindow = 1
" Disable python folding
let g:pymode_folding = 0
let g:pymode_syntax_all = 1
let g:pymode_syntax_slow_sync = 0
